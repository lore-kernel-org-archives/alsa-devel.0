From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: usb: improve delay reporting
Date: Wed, 4 Apr 2018 14:24:52 -0500
Message-ID: <26158b71-cc76-b2b7-e30f-c0040a5cb7e0@linux.intel.com>
References: <20180404135744.3921-1-georg@chini.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0627626718D
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 21:24:56 +0200 (CEST)
In-Reply-To: <20180404135744.3921-1-georg@chini.tk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Georg Chini <georg@chini.tk>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 04/04/2018 08:57 AM, Georg Chini wrote:

> Currently, the kernel uses only the number of USB frames to interpolate the delay
> between sending or receiving URB's. This limits the granuarity of the delay reports
> to one millisecond because the frame counter is updated in a millisecond interval.
>
> This patch additionally uses time stamps to achieve higher precision of the reported
> delay. If the time difference computed using time stamps does not deviate more than
> one millisecond from the difference computed using frames, it is assumed that the
> system time difference delivers the more precise delay estimate.
>
> This will significantly increase the precision of the reported delay in the majority
> of cases where sound card clock and system clock are almost in sync while falling back
> to the old method for the rare cases where the two times differ too much.
I am all for better delay estimates but I have mixed feelings about this 
- and some hardware-related parts are broken.

The frame counter is already an approximation of the actual delay which 
doesn't really account for the type of USB interface (Isoc, Async) used 
on the device side. You'd be adding a lot of precision without really 
solving the fact that you don't know what the actual playback rate is. 
You'd really need a time smoother that models playback rate v. system 
time if you want to be fully accurate below the ms level for all types 
of USB audio devices.

In addition I've only seen drivers report the delay based on hardware 
counters. If we start doing interpolations based on system time, then 
why not do it for other devices as well with a fix at the core level

And last, I think you have an issue for the pause case and you cannot 
remove the code that limits the frame counter to 8 bits, this will not 
work across multiple versions of [e|x]HCI controllers, see below.

>
> As a downside, the possible worst case error increases from 2ms to 3ms.
> ---
>   sound/usb/card.h |  1 +
>   sound/usb/pcm.c  | 47 +++++++++++++++++++++++++++++++----------------
>   2 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index ed87cc83eb47..8835d9628cac 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -149,6 +149,7 @@ struct snd_usb_substream {
>   
>   	int last_frame_number;          /* stored frame number */
>   	int last_delay;                 /* stored delay */
> +	struct timespec last_update_time;    /* time when last_delay was updated */
>   
>   	struct {
>   		int marker;
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 3cbfae6604f9..6d40cb0b8777 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -46,9 +46,8 @@ snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
>   	int current_frame_number;
>   	int frame_diff;
>   	int est_delay;
> -
> -	if (!subs->last_delay)
> -		return 0; /* short path */

NAK. This was added on purpose by 48779a0b8ffc ('ALSA: usb-audio: fix 
delay account during pause')
And since you kept the code that sets last_delay there is no reason to 
take this out.
> +	int time_diff;
> +	struct timespec now;
>   
>   	current_frame_number = usb_get_current_frame_number(subs->dev);
>   	/*
> @@ -58,9 +57,21 @@ snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
>   	 */
>   	frame_diff = (current_frame_number - subs->last_frame_number) & 0xff;
>   
> -	/* Approximation based on number of samples per USB frame (ms),
> -	   some truncation for 44.1 but the estimate is good enough */
> -	est_delay =  frame_diff * rate / 1000;
> +	/* Estimate time since last update of last_delay */
> +	snd_pcm_gettime(subs->pcm_substream->runtime, &now);
> +	time_diff = (now.tv_sec - subs->last_update_time.tv_sec) * 1000000000;
> +	time_diff += (int)now.tv_nsec - subs->last_update_time.tv_nsec;
> +	time_diff /= 1000;
> +
> +	if (abs(time_diff - frame_diff * 1000) < 1000) {
that's a 1ms error, this is quite high IMO to assess a divergence 
between system and frame deltas

> +		/* System time and sound card time do not differ
> +		 * too much. Use system time to calculate delay */
> +		est_delay =  time_diff * rate / 1000000;
> +	} else {
> +		/* Approximation based on number of samples per USB frame (ms),
> +		   some truncation for 44.1 but the estimate is good enough */
> +		est_delay =  frame_diff * rate / 1000;
> +	}
>   	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
>   		est_delay = subs->last_delay - est_delay;
>   	else
> @@ -853,6 +864,8 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
>   	subs->hwptr_done = 0;
>   	subs->transfer_done = 0;
>   	subs->last_delay = 0;
> +	subs->last_update_time.tv_sec = 0;
> +	subs->last_update_time.tv_nsec = 0;
>   	subs->last_frame_number = 0;
>   	runtime->delay = 0;
>   
> @@ -1334,7 +1347,9 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
>   
>   		/* realign last_frame_number */
>   		subs->last_frame_number = current_frame_number;
> -		subs->last_frame_number &= 0xFF; /* keep 8 LSBs */

You can't remove this, this models the fact that only 8 bits are valid 
in the frame counter.

> +
> +		/* Take time stamp for delay accounting */
> +		snd_pcm_gettime(runtime, &subs->last_update_time);
>   
>   		spin_unlock_irqrestore(&subs->lock, flags);
>   		/* copy a data chunk */
> @@ -1550,7 +1565,9 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
>   
>   	/* realign last_frame_number */
>   	subs->last_frame_number = usb_get_current_frame_number(subs->dev);
> -	subs->last_frame_number &= 0xFF; /* keep 8 LSBs */
same here, can't do this

> +
> +	/* Take time stamp for delay accounting */
> +	snd_pcm_gettime(runtime, &subs->last_update_time);
>   
>   	if (subs->trigger_tstamp_pending_update) {
>   		/* this is the first actual URB submitted,
> @@ -1597,6 +1614,12 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
>   		subs->last_delay -= processed;
>   	runtime->delay = subs->last_delay;
>   
> +	/* realign last_frame_number */
> +	subs->last_frame_number = usb_get_current_frame_number(subs->dev);

need to filter on 8 bits..
> +
> +	/* Take time stamp for delay accounting */
> +	snd_pcm_gettime(runtime, &subs->last_update_time);
> +
>   	/*
>   	 * Report when delay estimate is off by more than 2ms.
>   	 * The error should be lower than 2ms since the estimate relies
> @@ -1607,14 +1630,6 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
>   			"delay: estimated %d, actual %d\n",
>   			est_delay, subs->last_delay);
>   
> -	if (!subs->running) {
> -		/* update last_frame_number for delay counting here since
> -		 * prepare_playback_urb won't be called during pause
> -		 */
> -		subs->last_frame_number =
> -			usb_get_current_frame_number(subs->dev) & 0xff;
> -	}
> -
and why is this removed.
>    out:
>   	spin_unlock_irqrestore(&subs->lock, flags);
>   }
