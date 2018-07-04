From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v3] ALSA: core: Allow drivers to set R/W
	wait time.
Date: Wed, 04 Jul 2018 20:04:04 +0100
Message-ID: <af1da2956779bb67391b4caaf7a6f02caad1c8fe.camel@linux.intel.com>
References: <20180703112225.14604-1-liam.r.girdwood@linux.intel.com>
 <s5hin5wxr5n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AA622670D7
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 21:03:59 +0200 (CEST)
In-Reply-To: <s5hin5wxr5n.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-07-03 at 17:41 +0200, Takashi Iwai wrote:
> On Tue, 03 Jul 2018 13:22:25 +0200,
> Liam Girdwood wrote:
> > 
> > Currently ALSA core blocks userspace for about 10 seconds for PCM R/W IO.
> > This needs to be configurable for modern hardware like DSPs where no
> > pointer update in milliseconds can indicate terminal DSP errors.
> > 
> > Add a substream variable to set the wait time in ms. This allows userspace
> > and drivers to recover more quickly from terminal DSP errors.
> > 
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > ---
> > 
> > Changes since V1 :-
> >   o Remove API method and alow drivers to set directly.
> >   o Validate time is driver supplied times.
> > 
> > V2 :-
> >   o Max wait calc now in ms.
> >   o checkpatch. 
> > 
> >  include/sound/pcm.h  |  1 +
> >  sound/core/pcm_lib.c | 12 +++++++++---
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> > index e054c583d3b3..fcdf358a25f0 100644
> > --- a/include/sound/pcm.h
> > +++ b/include/sound/pcm.h
> > @@ -462,6 +462,7 @@ struct snd_pcm_substream {
> >          /* -- timer section -- */
> >  	struct snd_timer *timer;		/* timer */
> >  	unsigned timer_running: 1;	/* time is running */
> > +	long wait_time;	/* time in ms for R/W to wait for avail */
> >  	/* -- next substream -- */
> >  	struct snd_pcm_substream *next;
> >  	/* -- linked substreams -- */
> > diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> > index 44b5ae833082..82a41e4d7170 100644
> > --- a/sound/core/pcm_lib.c
> > +++ b/sound/core/pcm_lib.c
> > @@ -1832,12 +1832,18 @@ static int wait_for_avail(struct snd_pcm_substream
> > *substream,
> >  	if (runtime->no_period_wakeup)
> >  		wait_time = MAX_SCHEDULE_TIMEOUT;
> >  	else {
> > -		wait_time = 10;
> > +		/* use wait time from substream if available */
> > +		if (substream->wait_time)
> > +			wait_time = substream->wait_time;
> > +		else
> > +			wait_time = 10 * 1000; /* 10 secs */
> > +
> >  		if (runtime->rate) {
> > -			long t = runtime->period_size * 2 / runtime->rate;
> > +			long t = runtime->period_size * 2 /
> > +				 (runtime->rate / 1000);
> >  			wait_time = max(t, wait_time);
> >  		}
> > -		wait_time = msecs_to_jiffies(wait_time * 1000);
> > +		wait_time = msecs_to_jiffies(wait_time);
> 
> I can take the patch as is, but would you like to keep runtime->rate
> max check also in the case with substream->wait_time set?
> 

Good point, I was trying to keep the same constraints but it does seem like a
good idea if the driver is setting wait_time then it should be set correctly for
any hw_params. This also gives options to set wait time lower that two periods
too if desired.

> Also, substream->wait_time isn't cleared at each open, right?
> The driver can do it if wants, and the driver can set statically at
> creation time if wants, too.

SOF currently does this at creation time, but I can update this to be more
flexible in hw_params.

I'll send a V4.

Thanks

Liam

> 
> 
> thanks,
> 
> Takashi
