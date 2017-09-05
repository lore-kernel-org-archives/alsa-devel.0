From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 23/25 v2] ALSA/dummy: Replace tasklet with softirq hrtimer
Date: Wed, 6 Sep 2017 01:05:43 +0900
Message-ID: <4cf46286-daf8-d52c-dacc-fa16052dcdb2@sakamocchi.jp>
References: <s5hh8wnvjei.wl-tiwai@suse.de>
 <20170901102537.8066-1-o-takashi@sakamocchi.jp>
 <s5hbmmutytt.wl-tiwai@suse.de>
 <19775981-a3f2-5f65-e934-bfe25db62a43@sakamocchi.jp>
 <20170905155351.2xmwyxrirndfwtgo@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170905155351.2xmwyxrirndfwtgo@breakpoint.cc>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: alsa-devel@alsa-project.org, keescook@chromium.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, john.stultz@linaro.org, tglx@linutronix.de, anna-maria@linutronix.de, hch@lst.de
List-Id: alsa-devel@alsa-project.org

On Sep 6 2017 00:53, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The tasklet is used to defer the execution of snd_pcm_period_elapsed() to
> the softirq context. Using the CLOCK_MONOTONIC_SOFT base invokes the timer
> callback in softirq context as well which renders the tasklet useless.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: alsa-devel@alsa-project.org
> [o-takashi: avoid stall due to a call of hrtimer_cancel() on a callback
>              of hrtimer]
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On 2017-09-02 10:19:45 [+0900], Takashi Sakamoto wrote:
>> Yep. I request the authors to include this
> Thank you for providing a fix.
> 
> v1…v2: merged Takashi Sakamoto fixup of the original patch into v2.
> 
> So this patch now is okay?

I have a small nitpick.

>   sound/drivers/dummy.c | 23 +++++++++--------------
>   1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
> index dd5ed037adf2..3d01fe17ed36 100644
> --- a/sound/drivers/dummy.c
> +++ b/sound/drivers/dummy.c
> @@ -376,17 +376,9 @@ struct dummy_hrtimer_pcm {
>   	ktime_t period_time;
>   	atomic_t running;
>   	struct hrtimer timer;
> -	struct tasklet_struct tasklet;
>   	struct snd_pcm_substream *substream;
>   };
>   
> -static void dummy_hrtimer_pcm_elapsed(unsigned long priv)
> -{
> -	struct dummy_hrtimer_pcm *dpcm = (struct dummy_hrtimer_pcm *)priv;
> -	if (atomic_read(&dpcm->running))
> -		snd_pcm_period_elapsed(dpcm->substream);
> -}
> -
>   static enum hrtimer_restart dummy_hrtimer_callback(struct hrtimer *timer)
>   {
>   	struct dummy_hrtimer_pcm *dpcm;
> @@ -394,7 +386,12 @@ static enum hrtimer_restart dummy_hrtimer_callback(struct hrtimer *timer)
>   	dpcm = container_of(timer, struct dummy_hrtimer_pcm, timer);
>   	if (!atomic_read(&dpcm->running))
>   		return HRTIMER_NORESTART;
> -	tasklet_schedule(&dpcm->tasklet);
> +
> +	/* In a case of XRUN, this calls .trigger to stop PCM substream. */

As Iwai-san mentioned, in this function, .trigger can be called in two 
cases; XRUN occurs and draining is done. Thus, let you change the 
comment as 'In cases of XRUN and draining, this calls .trigger to stop 
PCM substream.'. I'm sorry to trouble you.

snd_pcm_period_elapsed()
->snd_pcm_update_hw_ptr0()
   ->snd_pcm_update_state()
     ->snd_pcm_drain_done()
       ...
       ->.trigger(TRIGGER_STOP)
     ->xrun()
       ->snd_pcm_stop()
         ...
         ->.trigger(TRIGGER_STOP)

> +	snd_pcm_period_elapsed(dpcm->substream);
> +	if (!atomic_read(&dpcm->running))
> +		return HRTIMER_NORESTART;
> +
>   	hrtimer_forward_now(timer, dpcm->period_time);
>   	return HRTIMER_RESTART;
>   }
> @@ -414,14 +411,14 @@ static int dummy_hrtimer_stop(struct snd_pcm_substream *substream)
>   	struct dummy_hrtimer_pcm *dpcm = substream->runtime->private_data;
>   
>   	atomic_set(&dpcm->running, 0);
> -	hrtimer_cancel(&dpcm->timer);
> +	if (!hrtimer_callback_running(&dpcm->timer))
> +		hrtimer_cancel(&dpcm->timer);
>   	return 0;
>   }
>   
>   static inline void dummy_hrtimer_sync(struct dummy_hrtimer_pcm *dpcm)
>   {
>   	hrtimer_cancel(&dpcm->timer);
> -	tasklet_kill(&dpcm->tasklet);
>   }
>   
>   static snd_pcm_uframes_t
> @@ -466,12 +463,10 @@ static int dummy_hrtimer_create(struct snd_pcm_substream *substream)
>   	if (!dpcm)
>   		return -ENOMEM;
>   	substream->runtime->private_data = dpcm;
> -	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC_SOFT, HRTIMER_MODE_REL);
>   	dpcm->timer.function = dummy_hrtimer_callback;
>   	dpcm->substream = substream;
>   	atomic_set(&dpcm->running, 0);
> -	tasklet_init(&dpcm->tasklet, dummy_hrtimer_pcm_elapsed,
> -		     (unsigned long)dpcm);
>   	return 0;
>   }


Regards

Takashi Sakamoto
