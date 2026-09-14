#!/usr/bin/env bash
#
# Copyright (c) 2026 Ant Group Corporation.
#
# SPDX-License-Identifier: Apache-2.0
#
# Idempotent Cloud Agent install for the AKernel Python SDK development
# environment. It installs the SDK (editable) together with its dev tooling
# (ruff, mypy, build) so that `make sdk-check` and the `ak` CLI work.
#
# Full cluster deployment (make build/deploy/e2e) additionally requires Docker,
# cloud credentials, and a reachable AKernel server, which are out of scope for
# this per-agent development install.

set -euo pipefail

# The repository dependency downloads use the public PyPI index; keep proxy
# variables out of the way to match the repository Make helpers.
unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY no_proxy NO_PROXY

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

python3 -m pip install --upgrade pip

# Install the SDK exactly as pinned by sdk/python/pyproject.toml, including the
# dev extra (ruff, mypy, build, and the openyuanrong-sdk pin used by tests).
python3 -m pip install -e './sdk/python[dev]'
