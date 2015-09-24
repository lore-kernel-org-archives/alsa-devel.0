From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 0/4] ASoC: Add support for DA7219 audio codec
Date: Thu, 24 Sep 2015 18:19:45 +0100
Message-ID: <cover.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jason Coughlan <jason.coughlan@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds support for the DA7219 audio codec with built-in
advanced accessory detection functionality. Patch set includes codec driver,
associated DT bindings documentation and MAINTAINERS file updates to cover new
bindings.

This patch set is baselined against the v4.3-rc2 kernel version.

Changes in v2:
 - Add SOC_DOUBLE_R_EXT support to ASoC core.
 - Use of upper-case naming for controls, where missing.
 - Use of Playback/Capture Digital naming for certain ADC/DAC controls.
 - CP mchange and vol_thresh DT bindings removed, now Kcontrols
 - Kcontrols and DAPM now locked as part of hptest work, and specific controls
   affected have had locking introduced.
 - Timeout for btn_det work when checking micbias status.
 - Added comments to describe reasoning for work use with hptest, btn_det.
 - Added comments to tonegen_freq_put/get to clarify endian conversion, and
   code now uses regmap_raw_read/write calls instead of bulk.
 - DT parsing code now prints dev_warn() for invalid settings.
 - SOC_VALUE_ENUM_SINGLE now used for hpf_mode handling, instead of customer
   get/put handlers.
 - DTMF key control now a SOC_ENUM to correctly describe supported keys,
   including non-numeric.
 - MIXIN_L_MIX_EN bit set as part of DAPM now (SUPPLY), rather than in probe.
 - Fix dai_sysclk() function to correctly check for no change, using clk_id as
   well as freq.
 - Error checking added for clk_set_rate() call.
 - Improved error checking for devm_clk_get() call.
 - Removed explicit use of device_may_wakeup() and enable/disable_irq_wake().
   Now taken care of by I2C core so DT bindings updated accordingly to
   document this.
 - hptest work now uses cache to keep state, instead of reading registers
   individually. Cache is bypassed, then when test executed and complete,
   regcache_sync_region() used to restore settings to pre-test values.
 - Regulator consumer framework usage added, in particular to determine VDDIO
   level in use so device can be configured accordingly. DT documents updated
   to reflect this.

Adam Thomson (4):
  ASoC: Add SOC_DOUBLE_R_EXT
  ASoC: codecs: Add da7219 codec driver
  ASoC: da7219: Add bindings documentation for DA7219 audio codec
  MAINTAINERS: da7219: Add entry to cover DA7219 bindings document

 Documentation/devicetree/bindings/sound/da7219.txt |  106 ++
 MAINTAINERS                                        |    1 +
 include/sound/da7219-aad.h                         |   99 +
 include/sound/da7219.h                             |   55 +
 include/sound/soc.h                                |    7 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/da7219-aad.c                      |  823 +++++++++
 sound/soc/codecs/da7219-aad.h                      |  212 +++
 sound/soc/codecs/da7219.c                          | 1938 ++++++++++++++++++++
 sound/soc/codecs/da7219.h                          |  820 +++++++++
 11 files changed, 4067 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7219.txt
 create mode 100644 include/sound/da7219-aad.h
 create mode 100644 include/sound/da7219.h
 create mode 100644 sound/soc/codecs/da7219-aad.c
 create mode 100644 sound/soc/codecs/da7219-aad.h
 create mode 100644 sound/soc/codecs/da7219.c
 create mode 100644 sound/soc/codecs/da7219.h

--
1.9.3
