From: Songjun Wu <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] ASoC: atmel-pdmic: add driver for Atmel PDMIC
Date: Mon, 14 Dec 2015 16:15:38 +0800
Message-ID: <1450080940-4123-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Songjun Wu <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The Pulse Density Modulation Inteface Controller driver
includes two parts.
1) Driver code to implement the PDMIC function.
2) Device tree binding documentation, it describes how to add
   the PDMIC in device tree.


Songjun Wu (2):
  ASoC: atmel-pdmic: add the Pulse Density Modulation Interface
    Controller
  ASoC: atmel-pdmic: DT binding for PDMIC driver

 .../devicetree/bindings/sound/atmel-pdmic.txt      |   55 ++
 sound/soc/atmel/Kconfig                            |    9 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel-pdmic.c                      |  745 ++++++++++++++++++++
 sound/soc/atmel/atmel-pdmic.h                      |   80 +++
 5 files changed, 891 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt
 create mode 100644 sound/soc/atmel/atmel-pdmic.c
 create mode 100644 sound/soc/atmel/atmel-pdmic.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
