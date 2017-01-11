From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] ASoC: rt5651: use msleep for large delays
Date: Wed, 11 Jan 2017 15:06:45 +0000
Message-ID: <20170111150645.GB16045@osadl.at>
References: <1484135376-482-1-git-send-email-hofrat@osadl.org>
 <20170111145926.22jkebrb7ojemyhq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170111145926.22jkebrb7ojemyhq@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 11, 2017 at 02:59:26PM +0000, Mark Brown wrote:
> On Wed, Jan 11, 2017 at 12:49:36PM +0100, Nicholas Mc Guire wrote:
> 
> >  		if (!rt5651->hp_mute)
> > -			usleep_range(80000, 85000);
> > +			msleep(85);
> 
> If you're doing conversions like this I'd expect us to be picking the
> lower number rather than the higher number - people are saying "wait for
> at least X and at most Y" and msleep() is "wait for at least X" so we
> should be picking X.

useleep_range() sets the timer to max and only if there happens to be a
timer between min and max uses that - so the mean of runs is generally
a bit above max. E.g.

usleep_range(*,200) 5000 samples - idle system
 100,200         190,200
 Min.   :188481  Min.   :197793
 1st Qu.:207062  1st Qu.:207051
 Median :207139  Median :207133
 Mean   :207254  Mean   :207244
 3rd Qu.:207341  3rd Qu.:207610
 Max.   :225340  Max.   :214885

So to keep the behavior as close to the current code as possible
it seemed better to select the upper value.

Am I missing something ?

thx!
hofrat
