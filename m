From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 0/2] ASoC: bcm2835: add support for hifiberry-dac
Date: Fri, 13 May 2016 09:14:11 +0000
Message-ID: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add support for the hifiberry-dac hat that can get attached
to a raspberry pi.

This hat also the ti-pcm5102a DAC, so
support for this DAC has been added to codecs.

This is a backport of the drivers in the rpi-downstream
kernel.

Changelog:
* Drivers written by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
* ref-count patch by Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>
* rebased, checkpath fixed and dt-binding documentation added 
  by Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Florian Meier (2):
  ASoC: pcm5102a: Add support for PCM5102A codec
  ASoC: Add support for HifiBerry DAC

 .../bindings/sound/hifiberry,hifiberry-dac.txt     |  12 ++
 .../devicetree/bindings/sound/pcm5102a.txt         |  13 +++
 sound/soc/bcm/Kconfig                              |   7 ++
 sound/soc/bcm/Makefile                             |   3 +-
 sound/soc/bcm/hifiberry_dac.c                      | 126 +++++++++++++++++++++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/pcm5102a.c                        |  69 +++++++++++
 8 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/hifiberry,hifiberry-dac.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm5102a.txt
 create mode 100644 sound/soc/bcm/hifiberry_dac.c
 create mode 100644 sound/soc/codecs/pcm5102a.c

--
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
