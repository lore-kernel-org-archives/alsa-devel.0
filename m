From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 0/3] Add ES8328 audio codec
Date: Wed, 18 Jun 2014 11:47:18 +0800
Message-ID: <1403063242-20840-1-git-send-email-xobs@kosagi.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patchset adds support for the Everest Semi ES8328 audio codec.  It also
adds support for using the es8328 on IMX boards.

We write a machine driver rather than using simple-card because the machine
driver needs to support regulators for the codec itself and speaker amps,
have headphone support, and must supply an unusual frequency to the codec chip.

Changes since v3:
    - Add OF bindings for everest,es8328
    - Add back in patch to add everest as a vendor prefix
    - Give clocks more generic names
    - Document required clocks in DT bindings document

Changes since v2:
    - Change deemph to a bool, and update based on sample rate
    - Replace value enums with regular enums
    - Break SPI and I2C drivers into their own modules
    - Rename everest,es8328 to es8328 as the module wasn't getting detected.
      Because of this, the patch to vendor-prefixes.txt has been dropped.

Changes since v1:
    - Rename HP/Speaker to OUT1/OUT2
    - Use DAPM widgets for startup/shutdown
    - Add regulator support to machine driver

Sean Cross (3):
  devicetree: bindings: Add Everest Semicodunctor
  ASoC: add es8328 codec driver
  ASoC: fsl: add imx-es8328 machine driver

 Documentation/devicetree/bindings/sound/es8328.txt |  18 +
 .../devicetree/bindings/sound/imx-audio-es8328.txt |  68 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 sound/soc/codecs/Kconfig                           |  13 +
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/es8328-i2c.c                      |  62 ++
 sound/soc/codecs/es8328-spi.c                      |  51 ++
 sound/soc/codecs/es8328.c                          | 625 +++++++++++++++++++++
 sound/soc/codecs/es8328.h                          | 313 +++++++++++
 sound/soc/fsl/Kconfig                              |  14 +
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/imx-es8328.c                         | 359 ++++++++++++
 12 files changed, 1532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/es8328.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
 create mode 100644 sound/soc/codecs/es8328-i2c.c
 create mode 100644 sound/soc/codecs/es8328-spi.c
 create mode 100644 sound/soc/codecs/es8328.c
 create mode 100644 sound/soc/codecs/es8328.h
 create mode 100644 sound/soc/fsl/imx-es8328.c

-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
