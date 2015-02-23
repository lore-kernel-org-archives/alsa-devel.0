From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH 2/2] ASoC: pcm512x: Allow independently overclocking PLL, DAC and DSP
Date: Mon, 23 Feb 2015 21:03:32 +0100
Message-ID: <1424721813-6137-1-git-send-email-peda@lysator.liu.se>
References: <20150223143132.GD6236@finisterre.sirena.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150223143132.GD6236@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Peter Rosin <peda@axentia.se>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

On 2015-02-23 15:31, Mark Brown wrote:
> On Sun, Feb 22, 2015 at 12:24:12AM +0000, Peter Rosin wrote:
> 
>> ...but I'm not sure everybody agrees that overclocking games should
>> be allowed by any and all users?
> 
> I don't see why not, ASoC controls are already way beyond end user a lot
> of the time.

*snip*

Ok, so going to ALSA-control route, changes since v1:

- Uses ALSA-controls instead of sysfs knobs.
- Returns -EBUSY if trying to change the values while active.

Cheers,
Peter

Peter Rosin (1):
  ASoC: pcm512x: Allow independently overclocking PLL, DAC and DSP

 sound/soc/codecs/pcm512x.c |  161 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 11 deletions(-)

-- 
1.7.10.4
