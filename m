From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: Allow drivers to set R/W wait
	time.
Date: Thu, 15 Mar 2018 13:35:37 +0000
Message-ID: <1521120937.7762.258.camel@linux.intel.com>
References: <20180314204440.14027-1-liam.r.girdwood@linux.intel.com>
 <s5hsh928gak.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 68903267252
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 14:35:41 +0100 (CET)
In-Reply-To: <s5hsh928gak.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-03-14 at 23:04 +0100, Takashi Iwai wrote:
> On Wed, 14 Mar 2018 21:44:40 +0100,
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
> 
> The idea looks good, though, a bit of nitpicking:
> 
> > ---
> >  include/sound/pcm.h  |  6 ++++++
> >  sound/core/pcm_lib.c | 15 ++++++++++-----
> >  2 files changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> > index e054c583d3b3..e4694684c524 100644
> > --- a/include/sound/pcm.h
> > +++ b/include/sound/pcm.h
> > @@ -462,6 +462,7 @@ struct snd_pcm_substream {
> >          /* -- timer section -- */
> >  	struct snd_timer *timer;		/* timer */
> >  	unsigned timer_running: 1;	/* time is running */
> > +	unsigned wait_time;	/* time in ms for R/W to wait for avail
> > */
> 
> I'd name wait_timeout, which is slightly clearer.
> 
> 
> >  	/* -- next substream -- */
> >  	struct snd_pcm_substream *next;
> >  	/* -- linked substreams -- */
> > @@ -579,6 +580,11 @@ int snd_pcm_start(struct snd_pcm_substream *substream);
> >  int snd_pcm_stop(struct snd_pcm_substream *substream, snd_pcm_state_t
> > status);
> >  int snd_pcm_drain_done(struct snd_pcm_substream *substream);
> >  int snd_pcm_stop_xrun(struct snd_pcm_substream *substream);
> > +static inline void snd_pcm_wait_time(struct snd_pcm_substream *substream,
> > +	unsigned wait_time)
> > +{
> > +	substream->wait_time = wait_time;
> > +}
> 
> IMO, it's a simple one parameter, and no need wrapping with an inline
> function.

This was for drivers to set the parameter according to HW capabilities.

> 
> 
> 
> >  #ifdef CONFIG_PM
> >  int snd_pcm_suspend(struct snd_pcm_substream *substream);
> >  int snd_pcm_suspend_all(struct snd_pcm *pcm);
> > diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> > index a83152e7d387..2ee76c70f55f 100644
> > --- a/sound/core/pcm_lib.c
> > +++ b/sound/core/pcm_lib.c
> > @@ -1839,12 +1839,17 @@ static int wait_for_avail(struct snd_pcm_substream
> > *substream,
> >  	if (runtime->no_period_wakeup)
> >  		wait_time = MAX_SCHEDULE_TIMEOUT;
> >  	else {
> > -		wait_time = 10;
> > -		if (runtime->rate) {
> > -			long t = runtime->period_size * 2 / runtime->rate;
> > -			wait_time = max(t, wait_time);
> > +		/* use wait time from substream if available */
> > +		if (substream->wait_time) {
> > +			wait_time = msecs_to_jiffies(substream->wait_time);
> > +		} else {
> > +			wait_time = 10;
> > +			if (runtime->rate) {
> > +				long t = runtime->period_size * 2 /
> > runtime->rate;
> > +				wait_time = max(t, wait_time);
> > +			}
> > +			wait_time = msecs_to_jiffies(wait_time * 1000);
> >  		}
> > -		wait_time = msecs_to_jiffies(wait_time * 1000);
> 
> This can go bad when wait_time is shorter than the period time.
> Some validation is needed?
> 

Yes, and we should also validate no irq mode somehow too, probably using buffer
time.

> Also, how is user-space supposed to set the new parameter?
> 

It's not atm, as it was being set by the driver. Would probably mean an ABI
change to PCM ops or a new ioctl ? The latter wont break the ABI and the default
value would remain if the ioctl was not called.

Liam


> 
> thanks,
> 
> Takashi
