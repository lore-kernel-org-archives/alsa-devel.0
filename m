From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH 0/2] Add devicetree for Axentia Nattis
Date: Fri,  1 Dec 2017 23:44:23 +0100
Message-ID: <20171201224425.5477-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi!

I'd like to add a devicetree for our Nattis to the kernel. The
Nattis is a device for showing departures for public transportation
(optionally including a text-to-speech module for the visually
impaired).

I'm a bit unsure if the tfa9879 sound codec binding is needed,
but I suppose it belongs in trivial-devices?

Cheers,
Peter

Peter Rosin (2):
  dt-bindings: trivial: add tfa9879 device
  ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power

 Documentation/devicetree/bindings/arm/axentia.txt  |   9 +
 .../devicetree/bindings/trivial-devices.txt        |   1 +
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/at91-natte.dtsi                  | 245 +++++++++++++++++++
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        | 258 +++++++++++++++++++++
 6 files changed, 516 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-natte.dtsi
 create mode 100644 arch/arm/boot/dts/at91-nattis-2-natte-2.dts

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
