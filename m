From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 0/7] ASoC: pcm512x: Clock master modes
Date: Wed, 14 Jan 2015 12:52:43 +0100
Message-ID: <1421236370-19826-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

Hi!

This series implements BCLK master modes for the pcm512x driver. It has
only been tested with the pcm5142 chip, but they are from the same family
and should be compatible. I have mainly used the spec for the newer
pcm5242 chip (also from the same family) as it fills in a lot of blanks
in the pcm512x/pcm514x specs.

The code has also seen most of its testing in a 3.10 environment, so
there might be some forward-porting warts. But it is able to play sound
in 3.18 as well, and most of the changes have little to do with anything
but the clocking in the chip itself.

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
