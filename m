From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/2] ASoC: add driver for Atmel I2S controller
Date: Tue, 29 Sep 2015 16:09:18 +0200
Message-ID: <cover.1443535188.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This series of patches adds support to the new Atmel I2S controller embedded
on sama5d2 SoCs.


ChangeLog

v2:
- initialize dev->dev before calling dev->caps->mck_init().

Cyrille Pitchen (2):
  ASoC: atmel-i2s: add DT bindings for I2S controller
  ASoC: atmel-i2s: add driver for the new Atmel I2S controller

 .../devicetree/bindings/sound/atmel-i2s.txt        |  43 ++
 sound/soc/atmel/Kconfig                            |  10 +
 sound/soc/atmel/Makefile                           |   2 +
 sound/soc/atmel/atmel-i2s.c                        | 760 +++++++++++++++++++++
 4 files changed, 815 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt
 create mode 100644 sound/soc/atmel/atmel-i2s.c

-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
