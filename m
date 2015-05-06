From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v2 0/4] ASoC: Add gtm601 simple codec
Date: Wed,  6 May 2015 22:38:46 +0200
Message-ID: <1430944730-10480-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Following patch series add support for gtm601 PCM audio.
gtm601 is UMTS modem which provide I2S interface for rx/tx data.
Codec is connected to cpu in master mode (rate is fixed 8kHz).

changes from v1:
- fix license mismatch
- sort Kconfig and Makefiles additions
- remove misleading comment

Marek Belisko (4):
  ASoC: Add gtm601 codec driver
  Documentation: devicetree: sound: Add documentation for gtm601 codec
  Documentation: vendor-prefixes: Add option prefix
  ARM: dts: omap3-gta04: Add GSM audio support

 Documentation/devicetree/bindings/sound/gtm601.txt | 14 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 | 26 ++++++
 sound/soc/codecs/Kconfig                           |  4 +
 sound/soc/codecs/Makefile                          |  2 +
 sound/soc/codecs/gtm601.c                          | 98 ++++++++++++++++++++++
 6 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
 create mode 100644 sound/soc/codecs/gtm601.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
