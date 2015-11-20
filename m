From: Raphael Poggi <poggi.raph@gmail.com>
Subject: [PATCH 0/4] New feature and clean up for pcm1792a driver
Date: Fri, 20 Nov 2015 11:09:13 +0100
Message-ID: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Raphael Poggi <poggi.raph@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Raphael Poggi <poggi.raph@gmail.com>

Hi,

This patch series support for the channel selection (stereo/left/right) based on device tree bindings.
It also adds some registers defines and cleans up weird test on function exit.

Raphael Poggi (4):
  sound: codecs: pcm1792a: clean function exit
  sound: codecs: pcm1792a: add define for register
  dt-bindings: sound: add binding for pcm1792a
  sound: codecs: pcm1792a: introduce channel side

 .../devicetree/bindings/sound/pcm1792a.txt         |   5 +
 sound/soc/codecs/pcm1792a.c                        | 107 +++++++++++++++------
 2 files changed, 83 insertions(+), 29 deletions(-)

-- 
2.1.0
