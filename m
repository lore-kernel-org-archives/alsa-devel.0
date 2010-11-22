From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Mon, 22 Nov 2010 11:14:32 +0000
Message-ID: <20101122111431.GB16504@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53EB8103892
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 12:14:33 +0100 (CET)
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
To: Takashi Iwai <tiawi@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit e53beacd23d9cb47590da6a7a7f6d417b941a994:

  Linux 2.6.37-rc2 (2010-11-15 18:31:02 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

This pull request is against -rc2 rather than topic/asoc as the merge of
the Samsung DMA support from Jassi (which was applied by Kukjin and will
be merged into both Samsung and ASoC trees to allow parallel development
of things based on it) pulled it in.  As a result all the changes you've
already got in topic/asoc are already listed along with the new stuff.

Arnaud Patard (3):
      ASoC: add support for alc562[123] codecs
      ASoC: kirkwood: Add audio support to hp t5325 thin clients
      ASoC: Add support for OpenRD Ultimate

Axel Lin (9):
      ASoC: Fix snd_soc_register_dais error handling
      ASoC: Return proper error if snd_soc_register_dais fails in psc_i2s_of_probe
      ASoC: Fix compile error if CONFIG_DEBUG_FS is not configured
      ASoC: Fix incorrect kfree in ad1836_probe error path
      ASoC: Fix incorrect kfree in ad193x_probe error path
      ASoC: Fix incorrect kfree in aic3x_probe error path
      ASoC: Fix incorrect kfree in wm8731_probe error path
      ASoC: Fix incorrect kfree in wm8962_probe error path
      ASoC: uda134x - set reg_cache_default to uda134x_reg

Chris Paulson-Ellis (1):
      ASoC: davinci: fixes for multi-component

Dimitris Papastamos (8):
      ASoC: soc-cache: Remove unnecessary debugging info
      ASoC: WM8776: Removed unneeded struct member
      ASoC: WM8770: Initial driver
      ASoC: soc-cache: Use BUG_ON() for unsupported hw_read() calls
      ASoC: Remove unneeded use of address-of operator
      ASoC: soc-cache: Add support for flat register caching
      ASoC: soc-cache: Add support for LZO register caching
      ASoC: soc-cache: Add support for rbtree based register caching

Jarkko Nikula (7):
      ASoC: Fix SND_SOC_ALL_CODECS typo for alc5623
      ASoC: Add sound card directory under debugfs/asoc/
      ASoC: Move codec debugfs directories under parent card directory
      ASoC: Move pop time from DAPM context to sound card
      ASoC: Update DAPM debug and error prints
      ASoC: Convert pop_dbg to use dev_info
      ASoC: Add optional name_prefix for codec kcontrol, widget and route names

Jassi Brar (9):
      ARM: S5PV310: Add platform devices for PL330 DMACs
      ARM: SAMSUNG: Rename s3c64xx I2S platform device
      ARM: SAMSUNG: Prepare audio header for new I2S driver
      ARM: S3C64XX: Upgrade platform device for I2S
      ARM: S5P64X0: Upgrade platform device for I2S
      ARM: S5P6442: Upgrade platform device for I2S
      ARM: S5PC100: Upgrade platform device for I2S
      ARM: S5PV210: Upgrade platform device for I2S
      ARM: S5PV310: Add audio platform devices

Jesse Marroquin (1):
      ASoC: Add support for MAX98089 CODEC

Joe Perches (1):
      ASoC: Remove unnecessary semicolons

Liam Girdwood (1):
      ASoC: Decouple DAPM from CODECs

Marek Belisko (1):
      ASoC: s3c24xx: Fix compilation problem for mini2440

Mark Brown (31):
      ASoC: Store DC offset correction for wm_hubs devices in class W mode
      Merge branch 'for-2.6.37' into for-2.6.38
      Merge branch 'for-2.6.37' into HEAD
      Merge remote branch 'takashi/fix/asoc' into for-2.6.37
      ASoC: Check return value of strict_strtoul() in WM8962
      ASoC: Convert soc-jack code to use request_any_context_irq()
      ASoC: Push snd_soc_write() and snd_soc_read() into the source file
      ASoC: Remove register write trace from WM8994
      ASoC: Use pm_wakeup_event() in WM8962 jack detection
      Merge branch 'for-2.6.37' into HEAD
      ASoC: Lock the CODEC in PXA external jack controls
      Merge branch 'for-2.6.37' into for-2.6.38
      Merge branch 'for-2.6.37' into HEAD
      ASoC: Remove broken WM8350 direction constants
      ASoC: Ensure sane WM835x AIF configuration by default
      Merge branch 'for-2.6.37' into for-2.6.38
      ASoC: Factor out boiler plate for DAPM event generation
      ASoC: Add trace events for ASoC register read/write
      ASoC: Add DAPM trace events
      Merge branch 'for-2.6.37' into for-2.6.38
      ASoC: Reset WM8962 with default ID value
      ASoC: Prevent system suspend while debouncing wakeup capable GPIO jacks
      ASoC: Fix dapm_seq_compare() for multi-component
      Merge branch 'for-2.6.37' into for-2.6.38
      ASoC: Use DAPM context rather than CODEC when constructing sequences
      ASoC: Fix register cache setup WM8994 for multi-component
      Merge branch 'for-2.6.37' into for-2.6.38
      ASoC: Provide ADC left/right channel source selection on WM8994
      ASoC: Move WM8994 read/write access data into separate file
      Merge branch 'for-2.6.37' into for-2.6.38
      Merge branch 'next-samsung-asoc' of git://git.kernel.org/.../kgene/linux-samsung into for-2.6.38

Ryan Mallon (1):
      Fix Atmel soc audio boards Kconfig dependency

Sascha Hauer (6):
      ASoC i.MX eukrea tlv320: Fix for multicomponent
      ASoC i.MX phycore ac97: remove unnecessary includes
      ASoC i.MX: register dma audio device
      ASoC i.MX: switch to new DMA api
      phycore-ac97: add ac97 to cardname
      ASoC: i.MX: we can do mono

Vasily Khoruzhick (1):
      ASoC: RX1950: Fix hw_params function

 arch/arm/mach-davinci/dm355.c                  |    6 +-
 arch/arm/mach-davinci/dm365.c                  |    6 +-
 arch/arm/mach-davinci/dm644x.c                 |    4 +-
 arch/arm/mach-kirkwood/openrd-setup.c          |    2 +-
 arch/arm/mach-s3c64xx/clock.c                  |    2 +-
 arch/arm/mach-s3c64xx/dev-audio.c              |   60 +-
 arch/arm/mach-s5p6442/dev-audio.c              |   44 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c          |    2 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c          |    2 +-
 arch/arm/mach-s5p64x0/dev-audio.c              |   55 +-
 arch/arm/mach-s5pc100/dev-audio.c              |   54 +-
 arch/arm/mach-s5pv210/clock.c                  |   10 +-
 arch/arm/mach-s5pv210/dev-audio.c              |   56 +-
 arch/arm/mach-s5pv310/Kconfig                  |    1 +
 arch/arm/mach-s5pv310/Makefile                 |    3 +-
 arch/arm/mach-s5pv310/dev-audio.c              |  364 ++++++
 arch/arm/mach-s5pv310/dma.c                    |  168 +++
 arch/arm/mach-s5pv310/include/mach/dma.h       |   26 +
 arch/arm/mach-s5pv310/include/mach/irqs.h      |    3 +
 arch/arm/mach-s5pv310/include/mach/map.h       |   21 +
 arch/arm/plat-samsung/include/plat/audio.h     |   24 +
 arch/arm/plat-samsung/include/plat/devs.h      |    9 +
 include/linux/mfd/wm8350/audio.h               |    3 -
 include/sound/alc5623.h                        |   15 +
 include/sound/soc-dapm.h                       |   49 +-
 include/sound/soc.h                            |   72 +-
 include/trace/events/asoc.h                    |  176 +++
 sound/soc/Kconfig                              |    2 +
 sound/soc/atmel/Kconfig                        |    5 +-
 sound/soc/atmel/playpaq_wm8510.c               |   11 +-
 sound/soc/atmel/sam9g20_wm8731.c               |   17 +-
 sound/soc/atmel/snd-soc-afeb9260.c             |   13 +-
 sound/soc/codecs/88pm860x-codec.c              |    9 +-
 sound/soc/codecs/Kconfig                       |    9 +
 sound/soc/codecs/Makefile                      |    6 +-
 sound/soc/codecs/ad1836.c                      |    6 +-
 sound/soc/codecs/ad193x.c                      |    6 +-
 sound/soc/codecs/ak4535.c                      |    9 +-
 sound/soc/codecs/ak4642.c                      |    2 +-
 sound/soc/codecs/ak4671.c                      |    9 +-
 sound/soc/codecs/alc5623.c                     | 1119 ++++++++++++++++
 sound/soc/codecs/alc5623.h                     |  161 +++
 sound/soc/codecs/cq93vc.c                      |    2 +-
 sound/soc/codecs/cs42l51.c                     |    5 +-
 sound/soc/codecs/cx20442.c                     |   15 +-
 sound/soc/codecs/da7210.c                      |    2 +-
 sound/soc/codecs/jz4740.c                      |   10 +-
 sound/soc/codecs/max98088.c                    |   23 +-
 sound/soc/codecs/ssm2602.c                     |    9 +-
 sound/soc/codecs/stac9766.c                    |    3 +-
 sound/soc/codecs/tlv320aic23.c                 |    9 +-
 sound/soc/codecs/tlv320aic3x.c                 |   23 +-
 sound/soc/codecs/tlv320dac33.c                 |   15 +-
 sound/soc/codecs/tpa6130a2.c                   |    5 +-
 sound/soc/codecs/twl4030.c                     |   13 +-
 sound/soc/codecs/twl6040.c                     |   12 +-
 sound/soc/codecs/uda134x.c                     |    3 +-
 sound/soc/codecs/uda1380.c                     |   13 +-
 sound/soc/codecs/wm2000.c                      |    5 +-
 sound/soc/codecs/wm8350.c                      |   37 +-
 sound/soc/codecs/wm8400.c                      |   11 +-
 sound/soc/codecs/wm8510.c                      |   11 +-
 sound/soc/codecs/wm8523.c                      |   11 +-
 sound/soc/codecs/wm8580.c                      |   13 +-
 sound/soc/codecs/wm8711.c                      |    9 +-
 sound/soc/codecs/wm8728.c                      |   11 +-
 sound/soc/codecs/wm8731.c                      |   14 +-
 sound/soc/codecs/wm8741.c                      |    9 +-
 sound/soc/codecs/wm8750.c                      |   11 +-
 sound/soc/codecs/wm8753.c                      |   29 +-
 sound/soc/codecs/wm8770.c                      |  750 +++++++++++
 sound/soc/codecs/wm8770.h                      |   51 +
 sound/soc/codecs/wm8776.c                      |   10 +-
 sound/soc/codecs/wm8804.c                      |    6 +-
 sound/soc/codecs/wm8900.c                      |   11 +-
 sound/soc/codecs/wm8903.c                      |   11 +-
 sound/soc/codecs/wm8904.c                      |   35 +-
 sound/soc/codecs/wm8940.c                      |    6 +-
 sound/soc/codecs/wm8955.c                      |   11 +-
 sound/soc/codecs/wm8960.c                      |   25 +-
 sound/soc/codecs/wm8961.c                      |   11 +-
 sound/soc/codecs/wm8962.c                      |   40 +-
 sound/soc/codecs/wm8971.c                      |   29 +-
 sound/soc/codecs/wm8974.c                      |   11 +-
 sound/soc/codecs/wm8978.c                      |   11 +-
 sound/soc/codecs/wm8985.c                      |   11 +-
 sound/soc/codecs/wm8988.c                      |    9 +-
 sound/soc/codecs/wm8990.c                      |   11 +-
 sound/soc/codecs/wm8993.c                      |   13 +-
 sound/soc/codecs/wm8994-tables.c               | 1575 +++++++++++++++++++++++
 sound/soc/codecs/wm8994.c                      | 1629 +-----------------------
 sound/soc/codecs/wm8994.h                      |    9 +
 sound/soc/codecs/wm9081.c                      |    9 +-
 sound/soc/codecs/wm9090.c                      |   17 +-
 sound/soc/codecs/wm9705.c                      |    6 +-
 sound/soc/codecs/wm9712.c                      |    9 +-
 sound/soc/codecs/wm9713.c                      |    8 +-
 sound/soc/codecs/wm_hubs.c                     |   87 +-
 sound/soc/codecs/wm_hubs.h                     |    3 +
 sound/soc/davinci/davinci-evm.c                |   61 +-
 sound/soc/davinci/davinci-i2s.c                |   15 +-
 sound/soc/davinci/davinci-mcasp.c              |   13 +-
 sound/soc/davinci/davinci-sffsdr.c             |    2 +-
 sound/soc/davinci/davinci-vcif.c               |   13 +-
 sound/soc/ep93xx/snappercl15.c                 |    5 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                |    2 +-
 sound/soc/imx/eukrea-tlv320.c                  |    8 +-
 sound/soc/imx/imx-pcm-dma-mx2.c                |  221 ++--
 sound/soc/imx/imx-ssi.c                        |   48 +-
 sound/soc/imx/imx-ssi.h                        |    4 +
 sound/soc/imx/phycore-ac97.c                   |    5 +-
 sound/soc/imx/wm1133-ev1.c                     |    7 +-
 sound/soc/jz4740/qi_lb60.c                     |   13 +-
 sound/soc/kirkwood/Kconfig                     |   11 +-
 sound/soc/kirkwood/Makefile                    |    2 +
 sound/soc/kirkwood/kirkwood-openrd.c           |    2 +-
 sound/soc/kirkwood/kirkwood-t5325.c            |  142 ++
 sound/soc/omap/am3517evm.c                     |   13 +-
 sound/soc/omap/ams-delta.c                     |   82 +-
 sound/soc/omap/n810.c                          |   42 +-
 sound/soc/omap/omap3pandora.c                  |   44 +-
 sound/soc/omap/osk5912.c                       |   13 +-
 sound/soc/omap/rx51.c                          |   25 +-
 sound/soc/omap/sdp3430.c                       |   43 +-
 sound/soc/omap/sdp4430.c                       |   19 +-
 sound/soc/omap/zoom2.c                         |   35 +-
 sound/soc/pxa/corgi.c                          |   56 +-
 sound/soc/pxa/e740_wm9705.c                    |   29 +-
 sound/soc/pxa/e750_wm9705.c                    |   29 +-
 sound/soc/pxa/e800_wm9712.c                    |    7 +-
 sound/soc/pxa/magician.c                       |   39 +-
 sound/soc/pxa/mioa701_wm9713.c                 |   17 +-
 sound/soc/pxa/palm27x.c                        |   33 +-
 sound/soc/pxa/poodle.c                         |   30 +-
 sound/soc/pxa/saarb.c                          |   17 +-
 sound/soc/pxa/spitz.c                          |   74 +-
 sound/soc/pxa/tavorevb3.c                      |   17 +-
 sound/soc/pxa/tosa.c                           |   42 +-
 sound/soc/pxa/z2.c                             |   15 +-
 sound/soc/pxa/zylonite.c                       |   11 +-
 sound/soc/s3c24xx/Kconfig                      |    1 +
 sound/soc/s3c24xx/aquila_wm8994.c              |   25 +-
 sound/soc/s3c24xx/goni_wm8994.c                |   21 +-
 sound/soc/s3c24xx/jive_wm8750.c                |   19 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |   41 +-
 sound/soc/s3c24xx/neo1973_wm8753.c             |  123 +-
 sound/soc/s3c24xx/rx1950_uda1380.c             |   31 +-
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |   15 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |   15 +-
 sound/soc/s3c24xx/smartq_wm8987.c              |   21 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |   16 +-
 sound/soc/s6000/s6105-ipcam.c                  |   40 +-
 sound/soc/sh/migor.c                           |    5 +-
 sound/soc/sh/sh7760-ac97.c                     |    2 +-
 sound/soc/soc-cache.c                          | 1002 ++++++++++++++-
 sound/soc/soc-core.c                           |  181 ++-
 sound/soc/soc-dapm.c                           |  579 +++++----
 sound/soc/soc-jack.c                           |   23 +-
 158 files changed, 7677 insertions(+), 3157 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/dev-audio.c
 create mode 100644 arch/arm/mach-s5pv310/dma.c
 create mode 100644 arch/arm/mach-s5pv310/include/mach/dma.h
 create mode 100644 include/sound/alc5623.h
 create mode 100644 include/trace/events/asoc.h
 create mode 100644 sound/soc/codecs/alc5623.c
 create mode 100644 sound/soc/codecs/alc5623.h
 create mode 100644 sound/soc/codecs/wm8770.c
 create mode 100644 sound/soc/codecs/wm8770.h
 create mode 100644 sound/soc/codecs/wm8994-tables.c
 create mode 100644 sound/soc/kirkwood/kirkwood-t5325.c
