From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Fix for the constraint
	handling
Date: Mon, 20 Apr 2009 10:23:30 +0300
Message-ID: <200904201023.30652.peter.ujfalusi@nokia.com>
References: <1239972908-4158-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239972908-4158-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090417142642.GD10992@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D3EFC24480
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 09:23:41 +0200 (CEST)
In-Reply-To: <20090417142642.GD10992@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 17 April 2009 17:26:42 ext Mark Brown wrote:
> On Fri, Apr 17, 2009 at 03:55:08PM +0300, Peter Ujfalusi wrote:
> > +	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> > +				SNDRV_PCM_HW_PARAM_RATE,
> > +				twl4030->rate,
> > +				twl4030->rate);
>
> You did note this yourself but there's support for this in the core;
> it'd be good to switch over to that (and push handling for the other
> constraints into core).

Yes it would be better to move these constraints handling to the core over =

time. As I explained it in the introduction mail, I think that the way the =

core handles the constraint for the rate is not without issues (you also no=
ted =

that).
I have been thinking of implementing this in core in a similar manner as I =

have implemented in the twl4030 codec, but I'm not sure that the assumption=
 of =

having a maximum of two streams (one for playback and one for capture) hold=
s =

for all codec/machine pairs. If it does, I can improve the core's constrain=
t =

handling with the approach taken in the twl4030 codec. With my limited test=
s =

it passed all cases that I could come up...

>
> > +	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> > +				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> > +				twl4030->sample_bits,
> > +				twl4030->sample_bits);
> > +
> > +	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> > +				SNDRV_PCM_HW_PARAM_CHANNELS,
> > +				twl4030->channels,
> > +				twl4030->channels);
>
> Are you sure that these need to match exactly and don't set maxima?

These settings are for the audio interface (HiFi interface), which means th=
ey =

are changing the interface format for both playback and capture. On top of =

that in 2 channel mode the interface has to be in I2S mode, in 4 channel mo=
de =

it has to be in DSP_A mode. So I think they have to be exact match in order=
 to =

not to break the existing stream.

>
> Your overall approach in the patch looks good so I'll apply it - it's
> an improvement on the current situation.

-- =

P=E9ter
