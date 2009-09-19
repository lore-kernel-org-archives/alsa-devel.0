From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Sat, 19 Sep 2009 09:11:57 +0100
Message-ID: <20090919081156.GC4676@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 023622450C
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Sep 2009 10:12:04 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit cdc65fbe18aef15e92d2ebb410a189fbf956fb06:
  Manuel Lauss (1):
        ASoC: au1x: PSC-AC97 bugfixes

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

The only really big thing here is the addition of the AK4671 driver,
other than that it's minor tweaks.

Barry Song (4):
      ASoC: Provide API for reordering channels
      ASoC: use set_channel_map api to reorder channels for AD1938 and AD1836
      ASoC: fix typos in Blackfin headers
      ASoC: Blackfin I2S: add lost platform_device parameter to resume function

Chaithrika U S (1):
      ASoC: DaVinci: Fixes to McASP configuration

Cliff Cai (2):
      ASoC: Blackfin AC97: add a few missing multichannel define handling
      ASoC: Blackfin I2S: fix resuming when device hasn't been used

Huang Weiyi (1):
      ASoC: remove unused #include <linux/version.h>

Jassi (3):
      ASoC: S3C lrsync function made to work with IRQs disabled.
      ASoC: S3C I2S LRCLK polarity option.
      ASoC: Return correct codec clock in s3c64xx-i2s

Joonyoung Shim (2):
      ASoC: Factor out I2C 8 bit address 8 bit data I/O
      ASoC: AK4671: add ak4671 codec driver

Julia Lawall (1):
      ASoC: Clean up error handling in MPC5200 DMA setup

Mark Brown (5):
      ASoC: Add source argument to PLL configuration
      ASoC: Allow per-route connectedness checks for supplies
      ASoC: Fix display of stream name in DAPM debugfs
      ASoC: Add S3C64xx IIS CDCLK source selection
      Merge branch 'for-2.6.32' into for-2.6.33

Miguel Aguilar (1):
      ASoC: Davinci: Add audio codec support for DM365 EVM

Mike Frysinger (1):
      ASoC: bf5xx-sport: the irq save/restore funcs take an unsigned long

 arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h |    2 +
 include/sound/soc-dai.h                           |   13 +-
 include/sound/soc-dapm.h                          |    7 +
 sound/soc/atmel/playpaq_wm8510.c                  |    2 +-
 sound/soc/blackfin/bf5xx-ac97.c                   |    8 +
 sound/soc/blackfin/bf5xx-ac97.h                   |    2 +-
 sound/soc/blackfin/bf5xx-ad1836.c                 |    7 +
 sound/soc/blackfin/bf5xx-ad1938.c                 |    9 +-
 sound/soc/blackfin/bf5xx-i2s.c                    |   22 +-
 sound/soc/blackfin/bf5xx-i2s.h                    |    2 +-
 sound/soc/blackfin/bf5xx-sport.c                  |    2 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c                |    9 +-
 sound/soc/blackfin/bf5xx-tdm.c                    |   45 +-
 sound/soc/blackfin/bf5xx-tdm.h                    |   11 +
 sound/soc/codecs/Kconfig                          |    4 +
 sound/soc/codecs/Makefile                         |    2 +
 sound/soc/codecs/ad1836.c                         |    1 -
 sound/soc/codecs/ad1938.c                         |    1 -
 sound/soc/codecs/ak4671.c                         |  825 +++++++++++++++++++++
 sound/soc/codecs/ak4671.h                         |  156 ++++
 sound/soc/codecs/wm8350.c                         |    2 +-
 sound/soc/codecs/wm8400.c                         |    3 +-
 sound/soc/codecs/wm8510.c                         |    4 +-
 sound/soc/codecs/wm8580.c                         |    4 +-
 sound/soc/codecs/wm8753.c                         |    4 +-
 sound/soc/codecs/wm8900.c                         |    4 +-
 sound/soc/codecs/wm8940.c                         |    4 +-
 sound/soc/codecs/wm8960.c                         |    4 +-
 sound/soc/codecs/wm8974.c                         |    5 +-
 sound/soc/codecs/wm8990.c                         |    4 +-
 sound/soc/codecs/wm8993.c                         |    2 +-
 sound/soc/codecs/wm9713.c                         |    4 +-
 sound/soc/davinci/Kconfig                         |    4 +-
 sound/soc/davinci/davinci-evm.c                   |    7 +-
 sound/soc/davinci/davinci-mcasp.c                 |   24 +-
 sound/soc/fsl/mpc5200_dma.c                       |   33 +-
 sound/soc/imx/mx27vis_wm8974.c                    |    2 +-
 sound/soc/pxa/magician.c                          |    2 +-
 sound/soc/pxa/pxa-ssp.c                           |    4 +-
 sound/soc/pxa/zylonite.c                          |    5 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c          |    2 +-
 sound/soc/s3c24xx/neo1973_wm8753.c                |    2 +-
 sound/soc/s3c24xx/s3c-i2s-v2.c                    |   46 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                   |   19 +-
 sound/soc/s3c24xx/s3c64xx-i2s.h                   |    1 +
 sound/soc/soc-cache.c                             |   30 +
 sound/soc/soc-core.c                              |   32 +-
 sound/soc/soc-dapm.c                              |   26 +-
 48 files changed, 1312 insertions(+), 101 deletions(-)
 create mode 100644 sound/soc/codecs/ak4671.c
 create mode 100644 sound/soc/codecs/ak4671.h
