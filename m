From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] ASoC: rt5651: use msleep for large delays
Date: Wed, 11 Jan 2017 18:59:52 +0000
Message-ID: <20170111185952.GA17786@osadl.at>
References: <1484135376-482-1-git-send-email-hofrat@osadl.org>
 <20170111145926.22jkebrb7ojemyhq@sirena.org.uk>
 <20170111150645.GB16045@osadl.at>
 <20170111180658.2yivagcwo4kgsp4e@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170111180658.2yivagcwo4kgsp4e@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 11, 2017 at 06:06:58PM +0000, Mark Brown wrote:
> On Wed, Jan 11, 2017 at 03:06:45PM +0000, Nicholas Mc Guire wrote:
> > On Wed, Jan 11, 2017 at 02:59:26PM +0000, Mark Brown wrote:
> 
> > > If you're doing conversions like this I'd expect us to be picking the
> > > lower number rather than the higher number - people are saying "wait for
> > > at least X and at most Y" and msleep() is "wait for at least X" so we
> > > should be picking X.
> 
> > useleep_range() sets the timer to max and only if there happens to be a
> > timer between min and max uses that - so the mean of runs is generally
> > a bit above max. E.g.
> 
> Yes, but as fairly recently discussed somewhere on the lists (and IIRC
> actually fixed) approximately no users expect or want that behaviour -
> it's a really confusing interface given that sleep functions almost
> always have a "delay up until X" interface and interfaces that can wake
> things up earlier than the expected delay generally flag that condition.
> The applications for the "delay for X but it's OK to wake me up this
> much earlier" are really quite limited.  If you look at the conversions
> that were done to usleep_range() you'll notice that most of them follow
> this pattern and had their delays extended in the process.

True its an odd behavior - the point just was to change the actual behavior
as little from current state as one might expect. Anywa - will fix it up 
then and resend - in this particular case it really makes little 
difference - assuming that both the minimum and maximum value were 
suitable to ensure that the writes had compled or it was actually a failure.

thx!
hofrat
