From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Tue, 18 Aug 2009 09:57:30 +0100
Message-ID: <20090818085730.GA26875@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA5EE24598
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 10:57:31 +0200 (CEST)
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

The following changes since commit d2a382143b35a486b8089861790d6b3ec4e46932:
  Mark Brown (1):
        ASoC: Update AD1938 for new TDM slot API

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Barry Song (3):
      ASoC: add output/input widgets in ad1938 to make dac/adc dynamic PM work
      new ad1836 codec driver based on asoc
      ASoC: delete -spi suffix in ad1938 and free private data while registers fail

Chaithrika U S (3):
      ASoC: DaVinci: McASP driver enhacements
      ASoC: DaVinci: Add a DAI format to McASP driver
      ASoC: DaVinci: Add audio support fot DA850/OMAP-L138 EVM

Janusz Krzysztofik (2):
      ASoC: OMAP: Make use of DMA channel self linking on OMAP1510
      ASoC: OMAP: Enhance OMAP1510 DMA progress software counter

Marek Vasut (1):
      ALSA: Allow passing platform_data for pxa2xx-ac97

Mark Brown (20):
      ASoC: Add WM8974 CODEC driver
      ASoC: WM8974 checkpatch cleanups
      ASoC: Update WM8974 to use standard I2C device probe methods
      ASoC: Remove unreferenced wm8974_add_controls()
      ASoC: Refresh WM8974 bias configuration
      ASoC: Declare 2 channels for WM8974
      ASoC: Refresh WM8974 PLL configuration
      ASoC: Add WM8974 TLV information
      ASoC: Use symmetric rates for WM8974
      ASoC: WM8974 cosmetic cleanups
      ASoC: WM8974 DAPM cleanups
      ASoC: Minor cleanups to AD1938 driver
      ASoC: Factor out shared code from WM8993
      Merge branch 'for-2.6.32' into mxc
      ASoC: Remove unneeded i.MX dependency on SND
      ASoC: Staticise unexported variables
      ASoC: Hook i.MX into build
      Merge branch 'wm8974-upstream' into for-2.6.32
      ASoC: Factor out cache I/O from WM8974
      ASoC: Fix handling of bias levels for non-DAPM codecs

Peter Ujfalusi (2):
      ASoC: TWL4030: Introduce PGAs for outputs
      ASoC: TWL4030: Fix for capture mixer strings

Shine Liu (1):
      ASoC: UDA134X: Fix mistaken mute/unmute code

javier Martin (5):
      ASoC: Correct a bug with "ADC Inversion Switch" in wm8974 codec.
      ASoC: add DMA platform driver for MX1x and MX2x
      ASoC: add DAI platform ssi driver for MXC
      ASoC: add machine driver for i.mx27_visstrim_m10 board
      ASoC: Fix review issues in i.MX2x PCM driver

 arch/arm/mach-pxa/include/mach/audio.h |    3 +
 include/sound/ac97_codec.h             |    3 +
 sound/arm/pxa2xx-ac97.c                |   10 +
 sound/soc/Kconfig                      |    1 +
 sound/soc/Makefile                     |    1 +
 sound/soc/codecs/Kconfig               |   12 +
 sound/soc/codecs/Makefile              |    6 +
 sound/soc/codecs/ad1836.c              |  446 ++++++++++++++++
 sound/soc/codecs/ad1836.h              |   64 +++
 sound/soc/codecs/ad1938.c              |   16 +-
 sound/soc/codecs/twl4030.c             |  155 ++++---
 sound/soc/codecs/uda134x.c             |    2 +-
 sound/soc/codecs/wm8974.c              |  808 +++++++++++++++++++++++++++++
 sound/soc/codecs/wm8974.h              |   99 ++++
 sound/soc/codecs/wm8993.c              |  716 +-------------------------
 sound/soc/codecs/wm_hubs.c             |  758 ++++++++++++++++++++++++++++
 sound/soc/codecs/wm_hubs.h             |   24 +
 sound/soc/davinci/Kconfig              |   13 +-
 sound/soc/davinci/Makefile             |    1 +
 sound/soc/davinci/davinci-evm.c        |   29 +-
 sound/soc/davinci/davinci-i2s.c        |    1 +
 sound/soc/davinci/davinci-mcasp.c      |  113 ++++-
 sound/soc/davinci/davinci-mcasp.h      |    5 +
 sound/soc/davinci/davinci-pcm.c        |    4 +-
 sound/soc/davinci/davinci-pcm.h        |    1 +
 sound/soc/imx/Kconfig                  |   21 +
 sound/soc/imx/Makefile                 |   10 +
 sound/soc/imx/mx1_mx2-pcm.c            |  488 ++++++++++++++++++
 sound/soc/imx/mx1_mx2-pcm.h            |   26 +
 sound/soc/imx/mx27vis_wm8974.c         |  317 ++++++++++++
 sound/soc/imx/mxc-ssi.c                |  868 ++++++++++++++++++++++++++++++++
 sound/soc/imx/mxc-ssi.h                |  238 +++++++++
 sound/soc/omap/omap-pcm.c              |   37 +-
 sound/soc/pxa/pxa2xx-ac97.c            |   12 +-
 sound/soc/soc-dapm.c                   |   16 +
 35 files changed, 4532 insertions(+), 792 deletions(-)
 create mode 100644 sound/soc/codecs/ad1836.c
 create mode 100644 sound/soc/codecs/ad1836.h
 create mode 100644 sound/soc/codecs/wm8974.c
 create mode 100644 sound/soc/codecs/wm8974.h
 create mode 100644 sound/soc/codecs/wm_hubs.c
 create mode 100644 sound/soc/codecs/wm_hubs.h
 create mode 100644 sound/soc/imx/Kconfig
 create mode 100644 sound/soc/imx/Makefile
 create mode 100644 sound/soc/imx/mx1_mx2-pcm.c
 create mode 100644 sound/soc/imx/mx1_mx2-pcm.h
 create mode 100644 sound/soc/imx/mx27vis_wm8974.c
 create mode 100644 sound/soc/imx/mxc-ssi.c
 create mode 100644 sound/soc/imx/mxc-ssi.h
