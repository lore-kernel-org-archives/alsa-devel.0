From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Mon, 10 Oct 2011 12:41:55 +0100
Message-ID: <20111010114155.GC3607@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 492DF244F1
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 13:41:58 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 734787550a60b768b675c26f93d134f6dc370bb5:

  ASoC: wm8995: Slightly optimize configure_clock (2011-10-04 13:09:55 +0100)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.2

Axel Lin (24):
      ASoC: wm8994: Fix setting rate_reg for wm8994-aif2
      ASoC: Avoid writing to WM8971_RESET in wm8971_resume
      ASoC: wm8750: Use snd_soc_update_bits for read-modify-write
      ASoC: wm8988: Use snd_soc_update_bits for read-modify-write
      ASoC: wm8711: Use snd_soc_update_bits for read-modify-write
      ASoC: Remove unneeded hw_write initialisation in ak4671
      ASoC: Remove unneeded hw_write initialisation in wm8523
      ASoC: Remove unused function declaration in imx-ssi.h
      ASoC: imx: Remove unused variable 'dai'
      ASoC: Remove unused variable 'wm9090' in wm9090_probe
      ASoC: wm8990: Convert to snd_soc_cache_sync for sync reg_cache with the hardware
      ASoC: wm8990: Remove incorrect comments
      ASoC: Return early with -EINVAL if invalid dai format is detected
      ASoC: wm8510: Convert to snd_soc_cache_sync
      ASoC: wm8711: Convert to snd_soc_cache_sync
      ASoC: wm8731: Convert to snd_soc_cache_sync
      ASoC: wm8750: Convert to snd_soc_cache_sync
      ASoC: wm8776: Convert to snd_soc_cache_sync
      ASoC: wm8940: Convert to snd_soc_cache_sync
      ASoC: wm8960: Convert to snd_soc_cache_sync
      ASoC: wm8971: Convert to snd_soc_cache_sync
      ASoC: wm8974: Convert to snd_soc_cache_sync
      ASoC: wm8988: Convert to snd_soc_cache_sync
      ASoC: ak4535: convert to soc-cache

Mark Brown (32):
      Merge branch 'for-3.1' into for-3.2
      ASoC: Remove direct register cache accesses from WM8962 driver
      regulator: Fix return code from regulator_disable_deferred()
      ASoC: Factor write of widget power out into a separate function
      ASoC: Move bias level decision into main dapm_power_widgets()
      ASoC: Ensure all DAPM widgets have a power check callback
      ASoC: Factor out widget power check operation
      ASoC: Mark headphone, mic, speaker and line widgets as always connected
      ASoC: Do DAPM power checks only for widgets changed since last run
      ASoC: Reduce the number of neigbours we mark dirty when updating power
      ASoC: Add verbose debugging showing why widgets get marked dirty
      ASoC: Only run power_check() on a widget once per run
      ASoC: Don't mark the outputs of supplies as dirty on state changes
      ASoC: Stop checking for supplied widgets after we find the first
      ASoC: Use dapm_mark_dirty() for new DAPM widgets for consistency
      ASoC: Remove references to linux@wolfsonmicro.com
      ASoC: Ensure DAPM widgets are set up before we sync jacks
      Merge branch 'for-3.1' into for-3.2
      regulator: Add WM1811 support
      ASoC: Suppress early calls to snd_soc_dapm_sync()
      ASoC: Remove redundant snd_soc_dapm_sync() calls from machine drivers
      ASoC: Ensure all DAPM widgets are instantiated with the card
      ASoC: Assign power_check when we allocate DAPM widgets
      ASoC: Cache connected input and output recursions
      ASoC: Squash error codes from regmap down to -1 on read
      ASoC: Fix DAPM sync for TLV320AIC3x custom DAPM widget
      ASoC: Convert Simtec machines to table based DAPM init
      ASoC: Convert H1940 to table based init
      ASoC: Convert RX1950 to table based init
      ASoC: Convert SmartQ to table based init
      ASoC: Convert SMDK WM8580 to table based DAPM init
      ASoC: Convert Jive to table based init

Michael Opdenacker (1):
      ASoC: fix checkpatch.pl error in omap-mcbsp

Peter Ujfalusi (15):
      ASoC: core: Introduce SOC_DOUBLE_VALUE macro
      ASoC: core: Introduce SOC_DOUBLE_R_VALUE macro
      ASoC: twl6040: Simplify custom put_volsw callback
      ASoC: Consolidate use of controls with custom get/put function
      ASoC: twl6040: Simplify custom get_volsw callback
      ASoC: twl6040: Prepare for core put_volsw/volsw_2r merger
      ASoC: core: Change SOC_SINGLE/DOUBLE_VALUE representation
      ASoC: core: Combine snd_soc_info_volsw/info_volsw_2r functions
      ASoC: core: Combine snd_soc_get_volsw/get_volsw_2r functions
      ASoC: core: Combine snd_soc_put_volsw/put_volsw_2r functions
      ASoC: twl6040: Simply call snd_soc_put_volsw form the custom code
      ASoC: core: Remove snd_soc_put_volsw_2r definition
      ASoC: twl6040: Warn user in twl6040_put_volsw for error case
      ASoC: Replace remaining use of *_volsw_2r with *_volsw
      ASoC: fix codec breakage caused by the volsw/volsw_2r merger

Wolfram Sang (1):
      ASoC: tlv320aic32x4 fix initialization of micpga routing

 drivers/regulator/core.c                       |    9 +-
 drivers/regulator/wm8994-regulator.c           |   13 +
 include/sound/soc-dapm.h                       |    8 +
 include/sound/soc.h                            |   85 ++++---
 sound/soc/atmel/playpaq_wm8510.c               |    1 -
 sound/soc/atmel/sam9g20_wm8731.c               |    2 -
 sound/soc/atmel/snd-soc-afeb9260.c             |    2 -
 sound/soc/codecs/ak4535.c                      |  100 ++------
 sound/soc/codecs/ak4671.c                      |    2 -
 sound/soc/codecs/cs4270.c                      |    8 +-
 sound/soc/codecs/cs42l51.c                     |    9 +-
 sound/soc/codecs/lm4857.c                      |    2 +-
 sound/soc/codecs/tlv320aic23.c                 |   14 +-
 sound/soc/codecs/tlv320aic32x4.c               |    4 +-
 sound/soc/codecs/tlv320aic3x.c                 |    4 +
 sound/soc/codecs/twl4030.c                     |   48 +---
 sound/soc/codecs/twl6040.c                     |   76 ++----
 sound/soc/codecs/wm8350.c                      |   43 ++--
 sound/soc/codecs/wm8510.c                      |   13 +-
 sound/soc/codecs/wm8523.c                      |    1 -
 sound/soc/codecs/wm8580.c                      |   38 +--
 sound/soc/codecs/wm8711.c                      |   19 +-
 sound/soc/codecs/wm8731.c                      |   15 +-
 sound/soc/codecs/wm8750.c                      |   42 +---
 sound/soc/codecs/wm8776.c                      |   16 +-
 sound/soc/codecs/wm8940.c                      |   46 ++--
 sound/soc/codecs/wm8960.c                      |   15 +-
 sound/soc/codecs/wm8962.c                      |   21 +-
 sound/soc/codecs/wm8971.c                      |   15 +-
 sound/soc/codecs/wm8974.c                      |   15 +-
 sound/soc/codecs/wm8988.c                      |   18 +--
 sound/soc/codecs/wm8990.c                      |   36 ++--
 sound/soc/codecs/wm8991.c                      |    2 +-
 sound/soc/codecs/wm8994.c                      |    2 +-
 sound/soc/codecs/wm9090.c                      |    1 -
 sound/soc/codecs/wm_hubs.c                     |   20 +-
 sound/soc/davinci/davinci-evm.c                |    2 -
 sound/soc/imx/imx-pcm-fiq.c                    |    1 -
 sound/soc/imx/imx-ssi.c                        |    1 -
 sound/soc/imx/imx-ssi.h                        |    6 -
 sound/soc/kirkwood/kirkwood-t5325.c            |    2 -
 sound/soc/mid-x86/mfld_machine.c               |    2 -
 sound/soc/omap/omap-mcbsp.c                    |    3 +-
 sound/soc/pxa/corgi.c                          |    1 -
 sound/soc/pxa/e740_wm9705.c                    |    2 -
 sound/soc/pxa/e750_wm9705.c                    |    2 -
 sound/soc/pxa/e800_wm9712.c                    |    1 -
 sound/soc/pxa/magician.c                       |    1 -
 sound/soc/pxa/mioa701_wm9713.c                 |    1 -
 sound/soc/pxa/palm27x.c                        |    4 -
 sound/soc/pxa/saarb.c                          |    4 -
 sound/soc/pxa/tavorevb3.c                      |    4 -
 sound/soc/pxa/tosa.c                           |    1 -
 sound/soc/pxa/z2.c                             |    4 -
 sound/soc/pxa/zylonite.c                       |    1 -
 sound/soc/samsung/goni_wm8994.c                |    2 -
 sound/soc/samsung/h1940_uda1380.c              |   19 +-
 sound/soc/samsung/jive_wm8750.c                |   17 +-
 sound/soc/samsung/neo1973_wm8753.c             |    4 -
 sound/soc/samsung/rx1950_uda1380.c             |   33 +--
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |   11 +-
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |   11 +-
 sound/soc/samsung/smartq_wm8987.c              |   25 +--
 sound/soc/samsung/smdk_wm8580.c                |   45 +---
 sound/soc/samsung/smdk_wm8994.c                |    2 -
 sound/soc/sh/sh7760-ac97.c                     |    7 -
 sound/soc/soc-core.c                           |  166 +++---------
 sound/soc/soc-dapm.c                           |  346 +++++++++++++++++-------
 sound/soc/soc-io.c                             |    2 +-
 sound/soc/soc-jack.c                           |    2 +
 sound/soc/tegra/tegra_wm8903.c                 |    2 -
 sound/soc/tegra/trimslice.c                    |    2 -
 72 files changed, 601 insertions(+), 903 deletions(-)
