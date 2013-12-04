From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 0/2] ASoC: sam9x5_wm8731: fix left right channel swap issue
Date: Wed,  4 Dec 2013 10:37:02 +0800
Message-ID: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@kernel.org
Cc: nicolas.ferre@atmel.com, richard.genoud@gmail.com, zql@glomationinc.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch series fix sam9x5 wm8731 playback left right channel swap issue
However, sam9x5 and wm8731 only can work in DSP A mode while can not work
in I2S mode.

Bo Shen (2):
  ASoC: atmel_ssc_dai: add dai trigger ops
  ASoC: sam9x5_wm8731: change to work in DSP A mode

 sound/soc/atmel/atmel_ssc_dai.c |   30 +++++++++++++++++++++++++++++-
 sound/soc/atmel/sam9x5_wm8731.c |    2 +-
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.7.9.5

