From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Wed, 24 Nov 2010 13:16:49 +0000
Message-ID: <20101124131649.GF24970@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B976103950
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 14:16:51 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 2ab46c9390e74368a38ddb5aa525124518df8b69:

  Merge branch 'for-2.6.38' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into topic/asoc (2010-11-23 12:45:05 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Bigger than usual set due to Jarkko's removal of header inclusions
(which touched a lot of files) and Jassi's Samsung driver reworking.

Axel Lin (10):
      ASoC: stac9766 - set reg_cache_default to stac9766_reg
      ASoC: Fix a memory leak in alc5623_i2c_probe error path
      ASoC: Do not update the cache if write to hardware failed
      ASoC: max98088 - fix a memory leak
      ASoC: wm8904 - fix memory leaks
      ASoC: wm8994 - fix memory leaks
      ASoC: wm8961 - clear WM8961_DACSLOPE bit for normal mode
      ASoC: wm8961 - clear WM8961_MCLKDIV bit for freq <= 16500000
      ASoC: Return proper error for omap3pandora_soc_init
      ASoC: nuc900-ac97: fix a memory leak

Janusz Krzysztofik (1):
      ASoC: OMAP: fix OMAP1 compilation problem

Jarkko Nikula (4):
      ASoC: Fix compile breakage in jz4740.c and smartq_wm8987.c
      ASoC: Do not include soc-dapm.h
      ASoC: Do not include soc-dai.h
      ASoC: Remove cyclic dependency between soc.h and soc-dapm.h/soc-dai.h

Jassi Brar (18):
      ASoC: Samsung: Remove redundant AQUILA driver
      ASoC: Samsung: Rename DMA device
      ARM: Samsung: Define common audio-dma device
      ASoC: Samsung: Rename ASoC DMA driver
      ASoC: Samsung: Rename AC97 platform device
      ASoC: Samsung: Rename AC97 driver
      ASoC: Samsung: Rename PCM driver
      ASoC: Samsung: Generalize DMA driver namespace
      ASoC: Samsung: Rename s3c64xx I2S device
      ASoC: Samsung: Add common I2S driver
      ASoC: SMARTQ: Move to use new I2S driver
      ASoC: GONI: Move to use new I2S driver
      ASoC: SMDK64XX: Move to use new I2S driver
      ASoC: S3C64XX: Remove obsoleted I2S drivers
      ASoC: SMDK64XX: Rename for other platforms
      ASoC: SMDK_WM8580: Enable for SMDKC100
      ASoC: Samsung: Generalize Kconfig symbols
      ASoC: Samsung: Rename from s3c24xx to samsung

Jesper Juhl (1):
      ASoC: MPC5200: Eliminate duplicate include of of_device.h

Liam Girdwood (1):
      Merge commit 'v2.6.37-rc1' into for-2.6.37

Mark Brown (8):
      ASoC: Fix multi-component mismerge in WM8523
      ASoC: Restore WM8994 volatile and readable register operations
      Merge branch 'for-2.6.37' into for-2.6.38
      Merge branch 'for-2.6.37' into for-2.6.38
      Merge branch 'fix/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.37
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.38
      ASoC: Add initial WM8737 driver
      Merge branch 'for-2.6.37' into for-2.6.38

Takashi Iwai (1):
      Merge branch 'for-2.6.37' of git://git.kernel.org/.../lrg/asoc-2.6 into fix/asoc

Vasiliy Kulikov (2):
      ASoC: s3c24xx: test wrong variable
      ASoC: atmel: test wrong variable

 arch/arm/mach-s3c2410/mach-h1940.c                 |    2 +-
 arch/arm/mach-s3c2440/mach-rx1950.c                |    2 +-
 arch/arm/mach-s3c64xx/dev-audio.c                  |   15 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
 arch/arm/mach-s5pc100/dev-audio.c                  |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +
 arch/arm/mach-s5pv210/dev-audio.c                  |    2 +-
 arch/arm/plat-s3c24xx/devs.c                       |   19 +-
 arch/arm/plat-samsung/Makefile                     |    1 +
 arch/arm/plat-samsung/dev-asocdma.c                |   24 +
 arch/arm/plat-samsung/include/plat/devs.h          |    2 +-
 include/sound/soc-dai.h                            |    2 -
 include/sound/soc-dapm.h                           |    1 -
 sound/soc/Kconfig                                  |    2 +-
 sound/soc/Makefile                                 |    2 +-
 sound/soc/atmel/playpaq_wm8510.c                   |    1 -
 sound/soc/atmel/sam9g20_wm8731.c                   |    5 +-
 sound/soc/atmel/snd-soc-afeb9260.c                 |    1 -
 sound/soc/au1x/db1200.c                            |    1 -
 sound/soc/blackfin/bf5xx-ad1836.c                  |    1 -
 sound/soc/blackfin/bf5xx-ad193x.c                  |    1 -
 sound/soc/blackfin/bf5xx-ad73311.c                 |    1 -
 sound/soc/blackfin/bf5xx-ssm2602.c                 |    1 -
 sound/soc/codecs/88pm860x-codec.c                  |    1 -
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ad1836.c                          |    1 -
 sound/soc/codecs/ad193x.c                          |    1 -
 sound/soc/codecs/ad1980.c                          |    1 -
 sound/soc/codecs/ak4535.c                          |    1 -
 sound/soc/codecs/ak4671.c                          |    1 -
 sound/soc/codecs/alc5623.c                         |   12 +-
 sound/soc/codecs/cq93vc.c                          |    2 -
 sound/soc/codecs/cs42l51.c                         |    1 -
 sound/soc/codecs/jz4740.c                          |    1 -
 sound/soc/codecs/max98088.c                        |    4 +-
 sound/soc/codecs/ssm2602.c                         |    1 -
 sound/soc/codecs/stac9766.c                        |    2 +-
 sound/soc/codecs/tlv320aic23.c                     |    1 -
 sound/soc/codecs/tlv320aic26.c                     |    1 -
 sound/soc/codecs/tlv320aic3x.c                     |    1 -
 sound/soc/codecs/tlv320dac33.c                     |    1 -
 sound/soc/codecs/tpa6130a2.c                       |    5 +-
 sound/soc/codecs/twl4030.c                         |    1 -
 sound/soc/codecs/twl6040.c                         |    1 -
 sound/soc/codecs/uda134x.c                         |    1 -
 sound/soc/codecs/uda1380.c                         |    1 -
 sound/soc/codecs/wl1273.c                          |    3 +-
 sound/soc/codecs/wm2000.c                          |    1 -
 sound/soc/codecs/wm8350.c                          |    1 -
 sound/soc/codecs/wm8400.c                          |    1 -
 sound/soc/codecs/wm8510.c                          |    1 -
 sound/soc/codecs/wm8523.c                          |    2 -
 sound/soc/codecs/wm8580.c                          |    1 -
 sound/soc/codecs/wm8711.c                          |    1 -
 sound/soc/codecs/wm8728.c                          |    1 -
 sound/soc/codecs/wm8731.c                          |    1 -
 sound/soc/codecs/wm8737.c                          |  713 +++++++++++
 sound/soc/codecs/wm8737.h                          |  322 +++++
 sound/soc/codecs/wm8741.c                          |    1 -
 sound/soc/codecs/wm8750.c                          |    1 -
 sound/soc/codecs/wm8753.c                          |    1 -
 sound/soc/codecs/wm8770.c                          |    1 -
 sound/soc/codecs/wm8776.c                          |    1 -
 sound/soc/codecs/wm8804.c                          |    1 -
 sound/soc/codecs/wm8900.c                          |    1 -
 sound/soc/codecs/wm8903.c                          |    1 -
 sound/soc/codecs/wm8904.c                          |    3 +-
 sound/soc/codecs/wm8940.c                          |    1 -
 sound/soc/codecs/wm8955.c                          |    1 -
 sound/soc/codecs/wm8960.c                          |    1 -
 sound/soc/codecs/wm8961.c                          |    5 +-
 sound/soc/codecs/wm8962.c                          |    1 -
 sound/soc/codecs/wm8971.c                          |    1 -
 sound/soc/codecs/wm8974.c                          |    1 -
 sound/soc/codecs/wm8978.c                          |    1 -
 sound/soc/codecs/wm8985.c                          |    1 -
 sound/soc/codecs/wm8988.c                          |    1 -
 sound/soc/codecs/wm8990.c                          |    1 -
 sound/soc/codecs/wm8993.c                          |    1 -
 sound/soc/codecs/wm8994.c                          |    5 +-
 sound/soc/codecs/wm9081.c                          |    1 -
 sound/soc/codecs/wm9090.c                          |    1 -
 sound/soc/codecs/wm9705.c                          |    1 -
 sound/soc/codecs/wm9712.c                          |    1 -
 sound/soc/codecs/wm9713.c                          |    1 -
 sound/soc/codecs/wm_hubs.c                         |    1 -
 sound/soc/davinci/davinci-evm.c                    |    1 -
 sound/soc/davinci/davinci-sffsdr.c                 |    1 -
 sound/soc/ep93xx/snappercl15.c                     |    1 -
 sound/soc/fsl/mpc5200_dma.c                        |    1 -
 sound/soc/imx/eukrea-tlv320.c                      |    1 -
 sound/soc/imx/phycore-ac97.c                       |    1 -
 sound/soc/imx/wm1133-ev1.c                         |    1 -
 sound/soc/jz4740/jz4740-i2s.c                      |    1 -
 sound/soc/jz4740/qi_lb60.c                         |    1 -
 sound/soc/kirkwood/kirkwood-t5325.c                |    1 -
 sound/soc/nuc900/nuc900-ac97.c                     |    2 +-
 sound/soc/nuc900/nuc900-audio.c                    |    1 -
 sound/soc/omap/am3517evm.c                         |    1 -
 sound/soc/omap/igep0020.c                          |    1 -
 sound/soc/omap/n810.c                              |    1 -
 sound/soc/omap/omap-mcbsp.c                        |    8 +
 sound/soc/omap/omap2evm.c                          |    1 -
 sound/soc/omap/omap3beagle.c                       |    1 -
 sound/soc/omap/omap3evm.c                          |    1 -
 sound/soc/omap/omap3pandora.c                      |    2 +-
 sound/soc/omap/osk5912.c                           |    1 -
 sound/soc/omap/overo.c                             |    1 -
 sound/soc/omap/rx51.c                              |    1 -
 sound/soc/omap/sdp3430.c                           |    1 -
 sound/soc/omap/sdp4430.c                           |    1 -
 sound/soc/omap/zoom2.c                             |    1 -
 sound/soc/pxa/corgi.c                              |    1 -
 sound/soc/pxa/e740_wm9705.c                        |    1 -
 sound/soc/pxa/e750_wm9705.c                        |    1 -
 sound/soc/pxa/e800_wm9712.c                        |    1 -
 sound/soc/pxa/em-x270.c                            |    1 -
 sound/soc/pxa/magician.c                           |    1 -
 sound/soc/pxa/mioa701_wm9713.c                     |    1 -
 sound/soc/pxa/palm27x.c                            |    1 -
 sound/soc/pxa/poodle.c                             |    1 -
 sound/soc/pxa/raumfeld.c                           |    1 -
 sound/soc/pxa/saarb.c                              |    1 -
 sound/soc/pxa/spitz.c                              |    1 -
 sound/soc/pxa/tavorevb3.c                          |    1 -
 sound/soc/pxa/tosa.c                               |    1 -
 sound/soc/pxa/z2.c                                 |    1 -
 sound/soc/pxa/zylonite.c                           |    1 -
 sound/soc/s3c24xx/Kconfig                          |  171 ---
 sound/soc/s3c24xx/Makefile                         |   55 -
 sound/soc/s3c24xx/aquila_wm8994.c                  |  296 -----
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c                 |  230 ----
 sound/soc/s3c24xx/s3c64xx-i2s.c                    |  242 ----
 sound/soc/s3c24xx/s3c64xx-i2s.h                    |   41 -
 sound/soc/s6000/s6105-ipcam.c                      |    1 -
 sound/soc/samsung/Kconfig                          |  155 +++
 sound/soc/samsung/Makefile                         |   51 +
 sound/soc/{s3c24xx/s3c-ac97.c => samsung/ac97.c}   |   22 +-
 sound/soc/{s3c24xx/s3c-ac97.h => samsung/ac97.h}   |    8 +-
 sound/soc/{s3c24xx/s3c-dma.c => samsung/dma.c}     |  134 +-
 sound/soc/{s3c24xx/s3c-dma.h => samsung/dma.h}     |    2 +-
 sound/soc/{s3c24xx => samsung}/goni_wm8994.c       |   36 +-
 sound/soc/samsung/i2s.c                            | 1256 ++++++++++++++++++++
 sound/soc/samsung/i2s.h                            |   29 +
 sound/soc/{s3c24xx => samsung}/jive_wm8750.c       |    7 +-
 sound/soc/{s3c24xx => samsung}/lm4857.h            |    0
 sound/soc/{s3c24xx => samsung}/ln2440sbc_alc650.c  |    9 +-
 .../{s3c24xx => samsung}/neo1973_gta02_wm8753.c    |    7 +-
 sound/soc/{s3c24xx => samsung}/neo1973_wm8753.c    |    7 +-
 sound/soc/{s3c24xx/s3c-pcm.c => samsung/pcm.c}     |    6 +-
 sound/soc/{s3c24xx/s3c-pcm.h => samsung/pcm.h}     |    2 +-
 sound/soc/{s3c24xx => samsung}/regs-i2s-v2.h       |    0
 sound/soc/{s3c24xx => samsung}/rx1950_uda1380.c    |    5 +-
 sound/soc/{s3c24xx => samsung}/s3c-i2s-v2.c        |    4 +-
 sound/soc/{s3c24xx => samsung}/s3c-i2s-v2.h        |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c2412-i2s.c       |    4 +-
 sound/soc/{s3c24xx => samsung}/s3c2412-i2s.h       |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c24xx-i2s.c       |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c24xx-i2s.h       |    0
 sound/soc/{s3c24xx => samsung}/s3c24xx_simtec.c    |    5 +-
 sound/soc/{s3c24xx => samsung}/s3c24xx_simtec.h    |    2 +-
 .../{s3c24xx => samsung}/s3c24xx_simtec_hermes.c   |    7 +-
 .../s3c24xx_simtec_tlv320aic23.c                   |    7 +-
 sound/soc/{s3c24xx => samsung}/s3c24xx_uda134x.c   |    5 +-
 sound/soc/{s3c24xx => samsung}/smartq_wm8987.c     |   33 +-
 sound/soc/{s3c24xx => samsung}/smdk2443_wm9710.c   |    9 +-
 sound/soc/{s3c24xx => samsung}/smdk_spdif.c        |    8 +-
 .../smdk64xx_wm8580.c => samsung/smdk_wm8580.c}    |  151 ++--
 sound/soc/{s3c24xx => samsung}/smdk_wm9713.c       |    8 +-
 sound/soc/{s3c24xx => samsung}/spdif.c             |    4 +-
 sound/soc/{s3c24xx => samsung}/spdif.h             |    2 +-
 sound/soc/sh/migor.c                               |    1 -
 sound/soc/sh/sh7760-ac97.c                         |    1 -
 sound/soc/sh/siu.h                                 |    2 +-
 sound/soc/sh/siu_dai.c                             |    2 +-
 sound/soc/sh/siu_pcm.c                             |    2 +-
 sound/soc/soc-core.c                               |    1 -
 sound/soc/soc-dapm.c                               |    1 -
 sound/soc/soc-jack.c                               |    1 -
 180 files changed, 2859 insertions(+), 1456 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-asocdma.c
 create mode 100644 sound/soc/codecs/wm8737.c
 create mode 100644 sound/soc/codecs/wm8737.h
 delete mode 100644 sound/soc/s3c24xx/Kconfig
 delete mode 100644 sound/soc/s3c24xx/Makefile
 delete mode 100644 sound/soc/s3c24xx/aquila_wm8994.c
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s-v4.c
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s.c
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s.h
 create mode 100644 sound/soc/samsung/Kconfig
 create mode 100644 sound/soc/samsung/Makefile
 rename sound/soc/{s3c24xx/s3c-ac97.c => samsung/ac97.c} (96%)
 rename sound/soc/{s3c24xx/s3c-ac97.h => samsung/ac97.h} (73%)
 rename sound/soc/{s3c24xx/s3c-dma.c => samsung/dma.c} (74%)
 rename sound/soc/{s3c24xx/s3c-dma.h => samsung/dma.h} (97%)
 rename sound/soc/{s3c24xx => samsung}/goni_wm8994.c (92%)
 create mode 100644 sound/soc/samsung/i2s.c
 create mode 100644 sound/soc/samsung/i2s.h
 rename sound/soc/{s3c24xx => samsung}/jive_wm8750.c (97%)
 rename sound/soc/{s3c24xx => samsung}/lm4857.h (100%)
 rename sound/soc/{s3c24xx => samsung}/ln2440sbc_alc650.c (92%)
 rename sound/soc/{s3c24xx => samsung}/neo1973_gta02_wm8753.c (99%)
 rename sound/soc/{s3c24xx => samsung}/neo1973_wm8753.c (99%)
 rename sound/soc/{s3c24xx/s3c-pcm.c => samsung/pcm.c} (99%)
 rename sound/soc/{s3c24xx/s3c-pcm.h => samsung/pcm.h} (99%)
 rename sound/soc/{s3c24xx => samsung}/regs-i2s-v2.h (100%)
 rename sound/soc/{s3c24xx => samsung}/rx1950_uda1380.c (98%)
 rename sound/soc/{s3c24xx => samsung}/s3c-i2s-v2.c (99%)
 rename sound/soc/{s3c24xx => samsung}/s3c-i2s-v2.h (98%)
 rename sound/soc/{s3c24xx => samsung}/s3c2412-i2s.c (98%)
 rename sound/soc/{s3c24xx => samsung}/s3c2412-i2s.h (95%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx-i2s.c (99%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx-i2s.h (100%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_simtec.c (99%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_simtec.h (94%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_simtec_hermes.c (96%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_simtec_tlv320aic23.c (96%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_uda134x.c (99%)
 rename sound/soc/{s3c24xx => samsung}/smartq_wm8987.c (92%)
 rename sound/soc/{s3c24xx => samsung}/smdk2443_wm9710.c (92%)
 rename sound/soc/{s3c24xx => samsung}/smdk_spdif.c (97%)
 rename sound/soc/{s3c24xx/smdk64xx_wm8580.c => samsung/smdk_wm8580.c} (63%)
 rename sound/soc/{s3c24xx => samsung}/smdk_wm9713.c (95%)
 rename sound/soc/{s3c24xx => samsung}/spdif.c (99%)
 rename sound/soc/{s3c24xx => samsung}/spdif.h (94%)
