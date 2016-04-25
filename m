From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] ASoC: codecs: add support for TAS5720 digital amplifier
Date: Mon, 25 Apr 2016 15:17:34 -0500
Message-ID: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Updated driver for TI's TAS5720L/M digital audio amplifiers incorporating
previous feedback (thanks Mark Brown). Biggest change is that the driver is
no longer using interrupts for codec fault reporting, but instead uses a
polling-based approach to check for (and clear) codec fault conditions every
200ms. This is much more graceful and actually lower overhead than trying to
keep the actual TAS5720 fault interrupts (that come in every 300us!) under
control which is what v2 of the driver was doing. Because of the removal of
interrupts the DT doc had to be updated as well, so I did not carry forward
Rob Herring's earlier Acked-by because of said change.

--

Andreas Dannenberg
Texas Instruments Inc


Changes since v2:
- Switched fault handling from using interrupts to polling mode
- Remove interrupt related description from DT bindings doc
- Remove unlikely() to simplify an expression
- Remove unnesseary tas5720_set_dai_sysclk() function stub

Changes since v1:
- Simplified DT interrupt documentation (Thanks Rob Herring)
- Fixed potential race condition during codec probe where deferred work
  that's used by the threaded IRQ handler was setup after the IRQ was
  initialized (would lead to an issue when the TAS5720 was already throwing
  interrupts at the time of probe)

Andreas Dannenberg (2):
  ASoC: codecs: add TA5720 digital amplifier DT bindings
  ASoC: codecs: add support for TAS5720 digital amplifier

 .../devicetree/bindings/sound/tas5720.txt          |  26 +
 sound/soc/codecs/Kconfig                           |  10 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas5720.c                         | 638 +++++++++++++++++++++
 sound/soc/codecs/tas5720.h                         |  90 +++
 5 files changed, 766 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5720.txt
 create mode 100644 sound/soc/codecs/tas5720.c
 create mode 100644 sound/soc/codecs/tas5720.h

-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
