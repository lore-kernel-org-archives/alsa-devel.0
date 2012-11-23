From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 0/3] ASoC: atmel-pcm: add dma support
Date: Fri, 23 Nov 2012 14:14:14 +0800
Message-ID: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch series is intend to add dma support for atmel pcm which is
based on snd soc dmaengine pcm framework

Bo Shen (3):
  ASoC: snd_dmaengine_pcm: add inline empty function
  ASoC: atmel-pcm: prepare for adding dma support
  ASoC: atmel-pcm: add dma support

 include/sound/dmaengine_pcm.h   |   53 +++++++++
 sound/soc/atmel/atmel-pcm.c     |  247 ++++++++++++++++++++++++++++++++++-----
 sound/soc/atmel/atmel-pcm.h     |    4 +-
 sound/soc/atmel/atmel_ssc_dai.c |   30 ++---
 4 files changed, 292 insertions(+), 42 deletions(-)

-- 
1.7.9.5

