From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 0/3] DMA fixes for ux500 ASoC driver
Date: Wed, 12 Jun 2013 09:57:56 +0200
Message-ID: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

The DMA driver used on ux500 has been recently reworked to make it
device-tree capable, but the rework required to drop some "features",
such as opportunistic channel allocation and hardcoded addresses, that
the ASoC driver was relying upon.

This series fixes the audio driver to make it work with the current
dma40 implementation, and works fine even when booting with device-tree.

Would you consider merging these for asoc/topic/ux500?

Thanks,
Fabio


Fabio Baltieri (3):
  ASoC: ux500: Move DMA parameters into ux500_msp
  ASoC: ux500: Set DMA address during device init
  ASoC: ux500: Add DMA slave config prepare routine

 sound/soc/ux500/ux500_msp_dai.c | 11 ++++-------
 sound/soc/ux500/ux500_msp_dai.h |  2 --
 sound/soc/ux500/ux500_msp_i2s.c | 13 +++++++++----
 sound/soc/ux500/ux500_msp_i2s.h | 15 ++++++++-------
 sound/soc/ux500/ux500_pcm.c     | 30 ++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 20 deletions(-)

-- 
1.8.2
