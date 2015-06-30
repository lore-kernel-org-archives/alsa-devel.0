From: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5] Add configuration options for tlv320aic32x4
Date: Tue, 30 Jun 2015 13:25:08 +0300
Message-ID: <cover.1435569929.git.kimmo.saarela@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

 * Patch 1: Make tlv320aic32x4 module selectable on it's own on config system
   * Make codec visible in config tool, instead of magic selection via certain
     board option
 * Patch 2: Don't stop driver initialization if mlck is not defined
   * Only warn if mclk isn't in dtb file, such cases exist when other end of
     I2S bus provides the clock for the system and coded is not in control
 * Patch 3: Fix bus signal polarity configuration
   * Fix driver to use correct format polarity bits in config word, instead of
     magically setting polarity in format configuration
 * Patch 4: Add more devicetree options to driver
   * Add input-use and cmode array options to configure codec input pins
     properly. Current driver lets unused input pins to float.
   * Add swapdacs option, works similarly to old platform data option. When
     enabled, swaps output channels
   * Add powercfg config mask to pass codec power options, like: micbias off,
     configurable ldoin voltage, disable weak pull between AVDD and DVDD,
     configurable LDO voltages
 * Patch 5: Update codec documentation to meet changes above


Kimmo Saarela (5):
  sound/soc/codecs: Make tlv320aic32x4 codec selectable on it's own
  ASoC: tlv320aic32x4: Make mclk optional
  ASoC: tlv320aic32x4: Move bit polarity config to specific switch
    statement
  ASoC: tlv320aic32x4: Change codec input config options
  ASoC: tlv320aic32x4: Update devicetree documentation

 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  27 ++-
 include/sound/tlv320aic32x4.h                      |   8 +
 sound/soc/codecs/Kconfig                           |   3 +-
 sound/soc/codecs/tlv320aic32x4.c                   | 244 ++++++++++++++++++---
 sound/soc/codecs/tlv320aic32x4.h                   |  10 +
 5 files changed, 258 insertions(+), 34 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
