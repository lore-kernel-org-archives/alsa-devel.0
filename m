From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Tue, 22 Nov 2011 12:59:03 +0000
Message-ID: <20111122125903.GB20833@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 529E32434C
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 13:59:06 +0100 (CET)
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

The following changes since commit e94de1e864d2d205e4e503b0f083c07f288b45fe:

  ASoC: Avoid a redundant read in cs42l51_pdn_event (2011-11-08 11:02:31 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

A couple of new drivers here, plus some conversions of drivers to use
regmap directly (saving some object size and letting us talk to the
chips before the card is probed) and removal of the LZO cache type.

Andrey Danin (1):
      ASoC: alc5632: rename volume/switch contols for master and speaker volumes.

Axel Lin (8):
      ASoC: wm9081: Fix reading wrong register for setting VMID 2*240k
      ASoC: wm9081: Don't write WM9081_BIAS_ENA bit to WM9081_VMID_CONTROL register
      ASoC: wm9081: Use snd_soc_update_bits for read-modify-write
      ASoC: Remove unused control_data and mutex fields from struct alc5632_priv
      ASoC: cs4271: Fix wrong mask parameter in some snd_soc_update_bits calls
      ASoC: cs42l73: Return proper error code if device id mismatch
      ASoC: cs42l73: Show correct revision id
      ASoC: Remove redundant regcache_sync call in cs42l73_resume

Brian Austin (1):
      ASoC: Add support for CS42L73 codec

Clemens Ladisch (7):
      ASoC: adau1373: fix DB_RANGE size
      ASoC: rt5631: fix DB_RANGE size
      ASoC: sgtl5000: fix DB_RANGE size
      ASoC: wm8962: fix DB_RANGE size
      ASoC: wm8993: fix DB_RANGE size
      ASoC: wm9090: fix DB_RANGE size
      ASoC: wm_hubs: fix DB_RANGE size

Jassi Brar (1):
      MAINTAINERS: Drop inactive Samsung ASoC maintainer

Johannes Stezenbach (3):
      ASoC: sta32x: preserve coefficient RAM
      ASoC: sta32x: add platform data definition
      ASoC: sta32x: add workaround for ESD reset issue

Kuninori Morimoto (5):
      ASoC: ak4642: add ak4642_set_bias_level()
      ASoC: ak4642: add DAPM support for HeadPhone Output
      ASoC: ak4642: add headphone mute switch control
      ASoC: ak4642: add Line out support
      ASoC: ak4642: add ak4648 support

Leon Romanovsky (9):
      ASoC: Add new Realtek ALC5632 CODEC driver
      ASoC: Remove unused defines in alc5632 codec
      ASoC: Remove unnecessary backslash from alc5632 codec
      ASoC: alc5632: Fix compile without CONFIG_PM
      ASoC: Convert ALC5632 codec to use regmap API
      ASoC: alc5632: Remove unrelevant registers and name the relevant
      ASoC: alc5632: Added support of two undocumented registers
      ASoC: alc5632: Update of i2c_probe function to use regmap API only
      ASoC: alc5632: Remove volatile registers from regmap defaults

Mark Brown (34):
      regmap: Track if the register cache is dirty and suppress unneeded syncs
      Merge branch 'topic/cache' of git://opensource.wolfsonmicro.com/regmap into for-3.3
      ASoC: Convert WM8996 to direct regmap API usage
      ASoC: Move most WM8996 resource acquisition to I2C probe
      ASoC: Convert WM8996 gpiolib to regmap
      ASoC: Convert WM8962 to direct regmap usage
      ASoC: Convert wm5100 to direct regmap API usage
      ASoC: Convert WM9081 to direct regmap API usage
      Merge branch 'for-3.2' into for-3.3
      ASoC: Disable debounce on some WM8962 interrupts
      ASoC: Convert wm8971 MICBIAS to a supply widget
      ASoC: Need to convert wm5100 cache sync to direct regmap usage too
      ASoC: Mark WM5100 MISC CONTROL as readable
      ASoC: Move most WM5100 resource allocation to I2C probe
      ASoC: Add Lowland machine driver
      ASoC: Convert WM5100 gpiolib support to direct regmap API usage
      ASoC: Fix duplicate const warnings in da7210.c
      ASoC: Remove extra space in runtime struct definition
      Merge branch 'for-3.2' into for-3.3
      ASoC: Remove LZO cache type
      ASoC: Move WM5100 platform data based setup into I2C probe
      ASoC: Convert WM8995 to direct regmap usage
      Merge branch 'for-3.2' into for-3.3
      ASoC: Say how long short WM8958 DSP2 firmwares are
      Merge branch 'for-3.2' into for-3.3
      devicetree: Document Wolfson prefix
      Merge branch 'DB_RANGE-size-fixes' of git://git.alsa-project.org/alsa-kprivate into for-3.2
      Merge branch 'for-3.2' into for-3.3
      ASoC: Ensure WM8731 register cache is synced when resuming from disabled
      ASoC: Use table based init for wm8731_snd_controls
      Merge branch 'for-3.2' into for-3.3
      ASoC: Convert WM8753 to table based DAPM and control init
      ASoC: Remove WM5100 DSP memory windows from register default data
      ASoC: Remove conditional I2C usage from tlv320aic3x driver

Timo Juhani Lindfors (1):
      ASoC: wm8753: Skip noop reconfiguration of DAI mode

Timur Tabi (1):
      ASoC: fsl_ssi: properly initialize the sysfs attribute object

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    1 -
 drivers/base/regmap/internal.h                     |    1 +
 drivers/base/regmap/regcache.c                     |   19 +
 drivers/base/regmap/regmap.c                       |    4 +-
 include/linux/regmap.h                             |    1 +
 include/sound/soc.h                                |    3 +-
 include/sound/sta32x.h                             |   35 +
 sound/soc/Kconfig                                  |   15 -
 sound/soc/codecs/Kconfig                           |    7 +
 sound/soc/codecs/Makefile                          |    4 +
 sound/soc/codecs/adau1373.c                        |    2 +-
 sound/soc/codecs/ak4642.c                          |  133 ++-
 sound/soc/codecs/alc5632.c                         | 1159 ++++++++++++++
 sound/soc/codecs/alc5632.h                         |  251 +++
 sound/soc/codecs/cs4271.c                          |    8 +-
 sound/soc/codecs/cs42l73.c                         | 1454 ++++++++++++++++++
 sound/soc/codecs/cs42l73.h                         |  227 +++
 sound/soc/codecs/da7210.c                          |    4 +-
 sound/soc/codecs/rt5631.c                          |    2 +-
 sound/soc/codecs/sgtl5000.c                        |    2 +-
 sound/soc/codecs/sta32x.c                          |  143 ++-
 sound/soc/codecs/sta32x.h                          |    1 +
 sound/soc/codecs/tlv320aic3x.c                     |    6 -
 sound/soc/codecs/wm5100-tables.c                   | 1489 ++++++++----------
 sound/soc/codecs/wm5100.c                          |  400 +++---
 sound/soc/codecs/wm5100.h                          |    7 +-
 sound/soc/codecs/wm8731.c                          |    6 +-
 sound/soc/codecs/wm8753.c                          |   27 +-
 sound/soc/codecs/wm8958-dsp2.c                     |    3 +-
 sound/soc/codecs/wm8962.c                          | 1603 ++++++++++----------
 sound/soc/codecs/wm8971.c                          |    2 +-
 sound/soc/codecs/wm8993.c                          |    2 +-
 sound/soc/codecs/wm8995.c                          |  717 ++++++++--
 sound/soc/codecs/wm8996.c                          |  912 ++++++-----
 sound/soc/codecs/wm9081.c                          |  363 +++--
 sound/soc/codecs/wm9090.c                          |    6 +-
 sound/soc/codecs/wm_hubs.c                         |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |    1 +
 sound/soc/samsung/Kconfig                          |    7 +
 sound/soc/samsung/Makefile                         |    2 +
 sound/soc/samsung/lowland.c                        |  246 +++
 sound/soc/soc-cache.c                              |  384 -----
 43 files changed, 6708 insertions(+), 2954 deletions(-)
 create mode 100644 include/sound/sta32x.h
 create mode 100644 sound/soc/codecs/alc5632.c
 create mode 100644 sound/soc/codecs/alc5632.h
 create mode 100644 sound/soc/codecs/cs42l73.c
 create mode 100644 sound/soc/codecs/cs42l73.h
 create mode 100644 sound/soc/samsung/lowland.c
