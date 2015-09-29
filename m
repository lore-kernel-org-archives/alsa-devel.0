From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 0/4] ASoC: Add support for DA7219 audio codec
Date: Tue, 29 Sep 2015 16:43:51 +0100
Message-ID: <cover.1443538420.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Jason Coughlan <jason.coughlan-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch set adds support for the DA7219 audio codec with built-in
advanced accessory detection functionality. Patch set includes codec driver,
associated DT bindings documentation and MAINTAINERS file updates to cover new
bindings.

This patch set is baselined against the v4.3-rc3 kernel version.

Changes in v3:
 - Actually set clk_src in dai_sysclk() function of codec, so future calls can
   correctly identify if work is to be done or not.

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
 sound/soc/codecs/da7219.c                          | 1940 ++++++++++++++++++++
 sound/soc/codecs/da7219.h                          |  820 +++++++++
 11 files changed, 4069 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7219.txt
 create mode 100644 include/sound/da7219-aad.h
 create mode 100644 include/sound/da7219.h
 create mode 100644 sound/soc/codecs/da7219-aad.c
 create mode 100644 sound/soc/codecs/da7219-aad.h
 create mode 100644 sound/soc/codecs/da7219.c
 create mode 100644 sound/soc/codecs/da7219.h

--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
