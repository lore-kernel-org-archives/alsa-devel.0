From: Peter Rosin <peda@axentia.se>
Subject: RE: [PATCH v2 3/7] ASoC: pcm512x: Change register default to match
 actual content after reset
Date: Wed, 28 Jan 2015 20:42:06 +0000
Message-ID: <4e50aac9e8ad4b5f8e8155ef8ca2d450@EMAIL.axentia.se>
References: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
 <1422454572-7847-4-git-send-email-peda@lysator.liu.se>
 <20150128191217.GF21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150128191217.GF21293@sirena.org.uk>
Content-Language: sv-SE
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Peter Rosin <peda@lysator.liu.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Lars-Peter Clausen <lars@metafoo.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

First of all, thanks for taking the rest of the series!

Mark Brown wrote:
> On Wed, Jan 28, 2015 at 03:16:08PM +0100, Peter Rosin wrote:
> 
> > @@ -78,7 +78,7 @@ static const struct reg_default
> pcm512x_reg_defaults[] = {
> >  	{ PCM512x_DIGITAL_VOLUME_2,  0x30 },
> >  	{ PCM512x_DIGITAL_VOLUME_3,  0x30 },
> >  	{ PCM512x_DIGITAL_MUTE_1,    0x22 },
> > -	{ PCM512x_DIGITAL_MUTE_2,    0x00 },
> > +	{ PCM512x_DIGITAL_MUTE_2,    0x02 },
> 
> The datasheet claims these have undefined values as reserved bits - what
> would be a more robust change here would be to remove the register
> default entirely so that we take the value the hardware has, giving
> robustness against any hardware revisions.  Of course the device has rather a
> lot of such reserved bits which is unfortunate.

Given the incompleteness of the datasheets this might be safest; a lot
of the reserved areas appear to have undocumented functions. But it
works as is of course, so it is not high priority... I don't know what happens
when this particular bit is cleared, but it doesn't change anything for the
pcm5142 that I am able to detect. So, no real problem with dropping 3/7.

Cheers,
Peter
