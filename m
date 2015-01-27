From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: [PATCH 0/7 RESEND] ASoC: pcm512x: Clock master modes
Date: Tue, 27 Jan 2015 20:50:41 +0100
Message-ID: <1422388248-25722-1-git-send-email-peda@lysator.liu.se>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

Hi!

[ Note that the dt change is in patch 5/7, for those only interested
  in that particular bit. ]

This series implements BCLK master modes for the pcm512x driver. It has
only been tested with the pcm5142 chip, but they are from the same family
and should be compatible. I have mainly used the spec for the newer
pcm5242 chip (also from the same family) as it fills in a lot of blanks
in the pcm512x/pcm514x specs.

The code has also seen most of its testing in a 3.10 environment, so
there might be some forward-porting warts. But it is able to play sound
in 3.18 as well, and most of the changes have little to do with anything
but the clocking in the chip itself.

This is technically not a clean resend, since I'm now sending the whole
series to all parties, hopefully using the correct email addesses this
time. I have also augmented the commit message of patch 1/7 according
to the review comments by Lars-Peter Clausen.

Cheers,
Peter

Peter Rosin (7):
  ALSA: pcm: Add snd_interval_ranges() and
    snd_pcm_hw_constraint_ranges()
  ASoC: pcm512x: Fix spelling of register field names.
  ASoC: pcm512x: Change register default to match actual content after
    reset
  ASoC: pcm512x: Support mastering BCLK/LRCLK without using the PLL
  ASoC: pcm512x: Support mastering BCLK/LRCLK using the PLL
  ASoC: pcm512x: Avoid the PLL for the DAC clock, if possible
  ASoC: pcm512x: Support SND_SOC_DAIFMT_CBM_CFS

 .../devicetree/bindings/sound/pcm512x.txt          |   25 +-
 include/sound/pcm.h                                |   12 +
 sound/core/pcm_lib.c                               |   85 ++
 sound/soc/codecs/pcm512x.c                         |  955 +++++++++++++++++++-
 sound/soc/codecs/pcm512x.h                         |  109 ++-
 5 files changed, 1161 insertions(+), 25 deletions(-)

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
