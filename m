From: Florian Vaussard <florian.vaussard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/2] ASoC: ads117x: Add device tree support for TI ADS117x
Date: Fri,  5 Feb 2016 16:32:12 +0100
Message-ID: <1454686334-9668-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hello,

This series adds device tree support for Texas Instruments ADS117x
ADC chip. The first patch adds the binding documentation, while the second
patch adds the compatible string into the driver. No further properties are
necessary.

Best regards,
Florian

---
Since v1:
- Updated topic for the documentation patch
- Removed wildcard in compatible string
---

Florian Vaussard (2):
  ASoC: ads117x: Add bindings documentation for TI ADS117x ADC
  ASoC: ads117x: Add device tree compatible string

 Documentation/devicetree/bindings/sound/ti,ads117x.txt | 11 +++++++++++
 sound/soc/codecs/ads117x.c                             | 12 ++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ads117x.txt

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
