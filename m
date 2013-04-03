From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/8] More dmaengine PCM cleanups
Date: Wed,  3 Apr 2013 10:59:59 +0200
Message-ID: <1364979607-15286-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-091.synserver.de (smtp-out-217.synserver.de
 [212.40.185.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FDC426531D
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 10:00:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi,

The first few patches in this series are a few unrelated cleanups to different
dmaengine PCM drivers and one fix for a small compile error I introduced in the
last dmaengine PCM cleanup series.

The last four patches introduce a common DAI DMA data struct, which will be used
by tegra, omap and fsl/imx. Having a common DAI DMA data struct allows us to
factor out some redundant code from these drivers into a common helper function
in the dmaengine PCM library.

This should hopefully be the last set of cleanups before the generic dmaengine
PCM driver.

- Lars

Lars-Peter Clausen (8):
  ASoC: ep93xx_pcm: Fix compile error
  ASoC: tegra: Don't claim to support PCM pause and resume
  ASoC: ux500_pcm: Use the same snd_pcm_hardware for playback and
    capture
  ASoC: dmaengine_pcm: Setup device_fc in
    snd_hwparams_to_dma_slave_config
  ASoC: dmaengine-pcm: Add a common DAI DMA data struct
  ASoC: tegra: Use common DAI DMA data struct
  ASoC: fsl: Use common DAI DMA data struct
  ASoC: omap: Use common DAI DMA data

 include/sound/dmaengine_pcm.h     | 24 ++++++++++++++++++
 sound/soc/atmel/atmel-pcm-dma.c   |  2 --
 sound/soc/cirrus/ep93xx-i2s.c     |  4 +--
 sound/soc/fsl/fsl_ssi.c           | 23 ++++++++++++------
 sound/soc/fsl/imx-pcm-dma.c       | 25 ++++++-------------
 sound/soc/fsl/imx-pcm-fiq.c       |  4 +--
 sound/soc/fsl/imx-pcm.h           | 16 ++++--------
 sound/soc/fsl/imx-ssi.c           | 21 +++++++++-------
 sound/soc/fsl/imx-ssi.h           |  7 ++++--
 sound/soc/omap/am3517evm.c        |  1 -
 sound/soc/omap/ams-delta.c        |  1 -
 sound/soc/omap/mcbsp.c            | 14 ++++++-----
 sound/soc/omap/mcbsp.h            |  7 +++---
 sound/soc/omap/n810.c             |  1 -
 sound/soc/omap/omap-abe-twl6040.c |  1 -
 sound/soc/omap/omap-dmic.c        | 22 ++++++++---------
 sound/soc/omap/omap-hdmi.c        | 24 ++++++++----------
 sound/soc/omap/omap-mcbsp.c       |  6 ++---
 sound/soc/omap/omap-mcpdm.c       | 31 +++++++++++-------------
 sound/soc/omap/omap-pcm.c         | 42 ++++----------------------------
 sound/soc/omap/omap-pcm.h         | 39 ------------------------------
 sound/soc/omap/omap-twl4030.c     |  1 -
 sound/soc/omap/omap3pandora.c     |  1 -
 sound/soc/omap/osk5912.c          |  1 -
 sound/soc/omap/rx51.c             |  1 -
 sound/soc/soc-dmaengine-pcm.c     | 39 ++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra20_ac97.c    | 13 +++++-----
 sound/soc/tegra/tegra20_ac97.h    |  4 +--
 sound/soc/tegra/tegra20_i2s.c     | 13 +++++-----
 sound/soc/tegra/tegra20_i2s.h     |  4 +--
 sound/soc/tegra/tegra20_spdif.c   |  7 +++---
 sound/soc/tegra/tegra20_spdif.h   |  4 +--
 sound/soc/tegra/tegra30_ahub.c    |  8 +++---
 sound/soc/tegra/tegra30_ahub.h    |  8 +++---
 sound/soc/tegra/tegra30_i2s.c     | 13 +++++-----
 sound/soc/tegra/tegra30_i2s.h     |  4 +--
 sound/soc/tegra/tegra_pcm.c       | 40 +++---------------------------
 sound/soc/tegra/tegra_pcm.h       |  7 ------
 sound/soc/ux500/ux500_pcm.c       | 51 ++++++++++++---------------------------
 sound/soc/ux500/ux500_pcm.h       | 14 -----------
 40 files changed, 226 insertions(+), 322 deletions(-)
 delete mode 100644 sound/soc/omap/omap-pcm.h

-- 
1.8.0
