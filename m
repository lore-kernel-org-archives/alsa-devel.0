From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 0/2] ASoC: pcm512x: Fixups for the Clock master modes series
Date: Thu, 29 Jan 2015 12:21:54 +0100
Message-ID: <1422530516-21779-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

These fixups can either be squashed in with 5/7 from the Clock master mode
series, or they can be added on top of the current topic/pcm512x. Sorry for
the trouble.

I can squash them, and resend the Clock master modes series if that helps.
Let me know how you'd like it.

Cheers,
Peter

Peter Rosin (2):
  ASoC: pcm512x: Fixup warning splat
  ASoC: pcm512x: Use the correct range constraints for S24_LE

 sound/soc/codecs/pcm512x.c |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

-- 
1.7.10.4
