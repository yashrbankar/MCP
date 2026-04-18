#!/bin/bash
set -euo pipefail

echo "🔄 Updating apt cache & installing Node.js (needed for fast UI)..."
sudo apt-get update
sudo apt-get remove -y nodejs nodejs-doc libnode72 || true
sudo apt-get autoremove -y

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs curl

if ! command -v uv &> /dev/null; then
  echo "📦 Installing uv package manager..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

echo "🐍 Syncing Python environment with uv..."
uv sync

echo "🎉 All set! Run 'uv run mcp-server/server.py' or 'npx -y @modelcontextprotocol/inspector uv run mcp-server/server.py' to get started."
