From: Lori Hikichi <lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/9] ASoC: cygnus: Various improvements and fixes
Date: Mon, 14 Aug 2017 15:06:48 -0700
Message-ID: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lori Hikichi <lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch series contains an number of improvements and refinements
to the driver. There is also a fix for a problem when transferring
four or more channels in TDM mode.

Lori Hikichi (9):
  ASoC: cygnus: Add support for 384kHz frame rates
  ASoC: cygnus: Update bindings for audio clock changes
  ASoC: cygnus: Allow each port to select its clock source
  ASoC: cygnus: Only enable MCLK pins when in use
  ASoC: cygnus: Remove support for 8 bit audio and for mono
  ASoc: cygnus: Fix problems with multichannel transfers
  ASoC: cygnus: Remove set_fmt from SPDIF dai ops
  ASoC: cygnus: Add EXPORT_SYMBOL for helper function
  ASoC: cygnus: Tidy up of structure access

 .../bindings/sound/brcm,cygnus-audio.txt           |   70 +-
 sound/soc/bcm/cygnus-pcm.c                         |   50 +-
 sound/soc/bcm/cygnus-ssp.c                         | 1336 ++++++++++----------
 sound/soc/bcm/cygnus-ssp.h                         |   51 +-
 4 files changed, 739 insertions(+), 768 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
