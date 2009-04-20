From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Fix for the
	constraint	handling
Date: Mon, 20 Apr 2009 11:40:41 +0100
Message-ID: <20090420104041.GA8776@sirena.org.uk>
References: <1239972908-4158-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239972908-4158-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090417142642.GD10992@sirena.org.uk>
	<200904201023.30652.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EB1B243AA
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 12:40:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904201023.30652.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 20, 2009 at 10:23:30AM +0300, Peter Ujfalusi wrote:

> I have been thinking of implementing this in core in a similar manner as I 
> have implemented in the twl4030 codec, but I'm not sure that the assumption of 
> having a maximum of two streams (one for playback and one for capture) holds 
> for all codec/machine pairs. If it does, I can improve the core's constraint 
> handling with the approach taken in the twl4030 codec. With my limited tests 
> it passed all cases that I could come up...

The single streams are assumed in the ASoC core so there's not much
concern there.  Without working on the ALSA core itself there's not much
you can do to fully plug all the holes, though.

> > > +				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> > > +				SNDRV_PCM_HW_PARAM_CHANNELS,

> > Are you sure that these need to match exactly and don't set maxima?

> These settings are for the audio interface (HiFi interface), which means they 
> are changing the interface format for both playback and capture. On top of 
> that in 2 channel mode the interface has to be in I2S mode, in 4 channel mode 
> it has to be in DSP_A mode. So I think they have to be exact match in order to 
> not to break the existing stream.

Oh, nice.  With some care it should be possible to allow at least a
maximum bit rate setting (since lower bit rates are going to be wire
compatible if enough clocks are generated).
