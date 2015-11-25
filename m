From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 0/2] ASoC: Add support for DA7217 and DA7218 audio codecs
Date: Wed, 25 Nov 2015 14:24:26 +0000
Message-ID: <cover.1448461029.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch set adds DT and ASoC codec driver support for DA7217 and DA7218.

Changes are based against v4.4-rc2 kernel version.

Changes in v4:
 - DT binding updates for unit suffixes (hz, us) at Rob Herring's request.

Changes in v3:
 - At request of Rob Herring, added units suffix to applicable binding names.
 - Add changes for codec Kconfig and Makefile which were somehow missed from
   previous patches.

Changes in v2:
 - Removed Internal LDO voltage selection from DT
 - BiQuad filter coefficients removed from DT, no programmed using mixer
   controls.
 - ALC calibration no longer bypasses regmap cache and instead saves & restores
   registers around procedure, to avoid issues with concurrent regmap access.
 - Removed all unnecessary default settings for mixers in probe.
 - Reporting of mic level detection event to user-space, through input
   VOICECOMMAND key event, removed as not intended for this purpose. Alternative
   solution required as follow up. Event masked off until solution in place.
 - Additional error checking & loggin around mclk usage, in sysclk and
   bias_level functions.

Adam Thomson (2):
  ASoC: da7218: Add bindings documentation for DA7218 audio codec
  ASoC: codecs: Add da7218 codec driver

 Documentation/devicetree/bindings/sound/da7218.txt |  104 +
 include/sound/da7218.h                             |  109 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/da7218.c                          | 3305 ++++++++++++++++++++
 sound/soc/codecs/da7218.h                          | 1414 +++++++++
 6 files changed, 4938 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7218.txt
 create mode 100644 include/sound/da7218.h
 create mode 100644 sound/soc/codecs/da7218.c
 create mode 100644 sound/soc/codecs/da7218.h

--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
