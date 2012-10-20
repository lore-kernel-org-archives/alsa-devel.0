From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: Re: [PATCH] ALSA: aloop - do not reschedule timer if
 deleted
Date: Sat, 20 Oct 2012 18:12:29 +0530
Message-ID: <50829C35.4060703@linux.intel.com>
References: <1350480946-11732-1-git-send-email-omair.m.abdullah@linux.intel.com>
 <s5htxttqjk0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 10D32264F23
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 14:41:30 +0200 (CEST)
In-Reply-To: <s5htxttqjk0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


>>
>> If the timer is deleted while the timer handler is running, it may get
>> rescheduled and an unnecessary period elapsed will be sent.
>>
>> Add a flag to reschedule the timer only if it has not been stopped.
>
> In which situation is it rescheduled exactly?
When the loopback_timer_stop() runs on one CPU while 
loopback_timer_function() runs on the other CPU. This causes the 
loopback_timer_function() to reschedule the timer beacuse del_timer() 
will not wait for the timer function to finish.

>
> Actually there is a small race in the check of running bit and the
> timer lock.  Do you mean this?
>
> If so, wouldn't it be cleaner to get rid of timer_lock and protect the
> whole start/stop with cable->lock, too, like below?
>
Yes, I think this fixes the problem quite well.

>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
> index 0fe6d64..1904046 100644
> --- a/sound/drivers/aloop.c
> +++ b/sound/drivers/aloop.c
> @@ -120,7 +120,6 @@ struct loopback_pcm {
>   	unsigned int last_drift;
>   	unsigned long last_jiffies;
>   	struct timer_list timer;
> -	spinlock_t timer_lock;
>   };
>
>   static struct platform_device *devices[SNDRV_CARDS];
> @@ -166,12 +165,12 @@ static inline unsigned int get_rate_shift(struct loopback_pcm *dpcm)
>   	return get_setup(dpcm)->rate_shift;
>   }
>
> +/* call in cable->lock */
>   static void loopback_timer_start(struct loopback_pcm *dpcm)
>   {
>   	unsigned long tick;
>   	unsigned int rate_shift = get_rate_shift(dpcm);
>
> -	spin_lock(&dpcm->timer_lock);
>   	if (rate_shift != dpcm->pcm_rate_shift) {
>   		dpcm->pcm_rate_shift = rate_shift;
>   		dpcm->period_size_frac = frac_pos(dpcm, dpcm->pcm_period_size);
> @@ -184,15 +183,13 @@ static void loopback_timer_start(struct loopback_pcm *dpcm)
>   	tick = (tick + dpcm->pcm_bps - 1) / dpcm->pcm_bps;
>   	dpcm->timer.expires = jiffies + tick;
>   	add_timer(&dpcm->timer);
> -	spin_unlock(&dpcm->timer_lock);
>   }
>
> +/* call in cable->lock */
>   static inline void loopback_timer_stop(struct loopback_pcm *dpcm)
>   {
> -	spin_lock(&dpcm->timer_lock);
>   	del_timer(&dpcm->timer);
>   	dpcm->timer.expires = 0;
> -	spin_unlock(&dpcm->timer_lock);
>   }
>
>   #define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
> @@ -274,8 +271,8 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
>   		spin_lock(&cable->lock);	
>   		cable->running |= stream;
>   		cable->pause &= ~stream;
> -		spin_unlock(&cable->lock);
>   		loopback_timer_start(dpcm);
> +		spin_unlock(&cable->lock);
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>   			loopback_active_notify(dpcm);
>   		break;
> @@ -283,23 +280,23 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
>   		spin_lock(&cable->lock);	
>   		cable->running &= ~stream;
>   		cable->pause &= ~stream;
> -		spin_unlock(&cable->lock);
>   		loopback_timer_stop(dpcm);
> +		spin_unlock(&cable->lock);
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>   			loopback_active_notify(dpcm);
>   		break;
>   	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>   		spin_lock(&cable->lock);	
>   		cable->pause |= stream;
> -		spin_unlock(&cable->lock);
>   		loopback_timer_stop(dpcm);
> +		spin_unlock(&cable->lock);
>   		break;
>   	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>   		spin_lock(&cable->lock);
>   		dpcm->last_jiffies = jiffies;
>   		cable->pause &= ~stream;
> -		spin_unlock(&cable->lock);
>   		loopback_timer_start(dpcm);
> +		spin_unlock(&cable->lock);
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -477,6 +474,7 @@ static inline void bytepos_finish(struct loopback_pcm *dpcm,
>   	dpcm->buf_pos %= dpcm->pcm_buffer_size;
>   }
>
> +/* call in cable->lock */
>   static unsigned int loopback_pos_update(struct loopback_cable *cable)
>   {
>   	struct loopback_pcm *dpcm_play =
> @@ -485,9 +483,7 @@ static unsigned int loopback_pos_update(struct loopback_cable *cable)
>   			cable->streams[SNDRV_PCM_STREAM_CAPTURE];
>   	unsigned long delta_play = 0, delta_capt = 0;
>   	unsigned int running, count1, count2;
> -	unsigned long flags;
>
> -	spin_lock_irqsave(&cable->lock, flags);
>   	running = cable->running ^ cable->pause;
>   	if (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) {
>   		delta_play = jiffies - dpcm_play->last_jiffies;
> @@ -529,32 +525,39 @@ static unsigned int loopback_pos_update(struct loopback_cable *cable)
>   	bytepos_finish(dpcm_play, count1);
>   	bytepos_finish(dpcm_capt, count1);
>    unlock:
> -	spin_unlock_irqrestore(&cable->lock, flags);
>   	return running;
>   }
>
>   static void loopback_timer_function(unsigned long data)
>   {
>   	struct loopback_pcm *dpcm = (struct loopback_pcm *)data;
> -	unsigned int running;
> +	unsigned long flags;
>
> -	running = loopback_pos_update(dpcm->cable);
> -	if (running & (1 << dpcm->substream->stream)) {
> +	spin_lock_irqsave(&dpcm->cable->lock, flags);
> +	if (loopback_pos_update(dpcm->cable) & (1 << dpcm->substream->stream)) {
>   		loopback_timer_start(dpcm);
>   		if (dpcm->period_update_pending) {
>   			dpcm->period_update_pending = 0;
> +			spin_unlock_irqrestore(&dpcm->cable->lock, flags);
> +			/* need to unlock before calling below */
>   			snd_pcm_period_elapsed(dpcm->substream);
> +			return;
>   		}
>   	}
> +	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
>   }
>
>   static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
>   {
>   	struct snd_pcm_runtime *runtime = substream->runtime;
>   	struct loopback_pcm *dpcm = runtime->private_data;
> +	snd_pcm_uframes_t pos;
>
> +	spin_lock(&dpcm->cable->lock);
>   	loopback_pos_update(dpcm->cable);
> -	return bytes_to_frames(runtime, dpcm->buf_pos);
> +	pos = dpcm->buf_pos;
> +	spin_unlock(&dpcm->cable->lock);
> +	return bytes_to_frames(runtime, pos);
>   }
>
>   static struct snd_pcm_hardware loopback_pcm_hardware =
> @@ -672,7 +675,6 @@ static int loopback_open(struct snd_pcm_substream *substream)
>   	dpcm->substream = substream;
>   	setup_timer(&dpcm->timer, loopback_timer_function,
>   		    (unsigned long)dpcm);
> -	spin_lock_init(&dpcm->timer_lock);
>
>   	cable = loopback->cables[substream->number][dev];
>   	if (!cable) {
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
