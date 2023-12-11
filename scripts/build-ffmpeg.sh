#!/bin/bash

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $(dirname "${BASH_SOURCE[0]}")/..
cd "./$1"
shift
ROOT="`pwd`"

TAG=n6.1

git clone https://git.ffmpeg.org/ffmpeg.git --depth 1 -b $TAG && cd ffmpeg || exit 1
./configure --disable-all --enable-libdrm --enable-avcodec --enable-decoder=h264 --enable-decoder=hevc --enable-hwaccel=h264_vaapi --enable-hwaccel=hevc_vaapi --enable-hwaccel=h264_vulkan --enable-hwaccel=hevc_vulkan --prefix="$ROOT/ffmpeg-prefix" "$@" || exit 1
make -j4 || exit 1
make install || exit 1
