From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 0/2] ASoC: atmel-pcm: use generic dmaengine framework
Date: Tue,  2 Jul 2013 17:04:07 +0800
Message-ID: <1372755849-19546-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, richard.genoud@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

this patch series is based on next-20130701

Bo Shen (2):
  ASoC: atmel_ssc_dai: move set dma data to startup callback
  ASoC: atmel-pcm: use generic dmaengine framework

 sound/soc/atmel/atmel-pcm-dma.c |  118 ++++++---------------------------------
 sound/soc/atmel/atmel_ssc_dai.c |   33 ++++++-----
 2 files changed, 32 insertions(+), 119 deletions(-)

-- 
1.7.9.5

