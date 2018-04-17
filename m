From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/3] ALSA: pcm: Unify delay calculation in
 snd_pcm_status() and snd_pcm_delay()
Date: Tue, 17 Apr 2018 19:05:01 +0900
Message-ID: <f5732c1a-9b6b-93ef-9c10-efe1bf28e537@sakamocchi.jp>
References: <20180416121417.27452-1-tiwai@suse.de>
 <20180416121417.27452-4-tiwai@suse.de>
 <c188c58d-3737-22d3-d994-25f2e79e7856@sakamocchi.jp>
 <s5hin8qs92o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 5090A2673E1
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 12:05:04 +0200 (CEST)
In-Reply-To: <s5hin8qs92o.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 17 2018 14:20, Takashi Iwai wrote:
> Subject: [PATCH v2 3/3] ALSA: pcm: Unify delay calculation in snd_pcm_status() and snd_pcm_delay()
> 
> Yet another slight code cleanup: there are two places where
> calculating the PCM delay, and they can be unified in a single
> helper.  It reduces the multiple open codes.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_native.c | 37 ++++++++++++++++---------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index eddb0cd6d1eb..7585444352df 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -857,6 +857,18 @@ static int snd_pcm_sw_params_user(struct snd_pcm_substream *substream,
>   	return err;
>   }
>   
> +static inline snd_pcm_uframes_t
> +snd_pcm_calc_delay(struct snd_pcm_substream *substream)
> +{
> +	snd_pcm_uframes_t delay;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		delay = snd_pcm_playback_hw_avail(substream->runtime);
> +	else
> +		delay = snd_pcm_capture_avail(substream->runtime);
> +	return delay + substream->runtime->delay;
> +}
> +
>   int snd_pcm_status(struct snd_pcm_substream *substream,
>   		   struct snd_pcm_status *status)
>   {
> @@ -909,19 +921,8 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
>   	status->appl_ptr = runtime->control->appl_ptr;
>   	status->hw_ptr = runtime->status->hw_ptr;
>   	status->avail = snd_pcm_avail(substream);
> -	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
> -		    runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
> -			status->delay = runtime->buffer_size - status->avail;
> -			status->delay += runtime->delay;
> -		} else
> -			status->delay = 0;
> -	} else {
> -		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
> -			status->delay = status->avail + runtime->delay;
> -		else
> -			status->delay = 0;
> -	}
> +	status->delay = snd_pcm_running(substream) ?
> +		snd_pcm_calc_delay(substream) : 0;
>   	status->avail_max = runtime->avail_max;
>   	status->overrange = runtime->overrange;
>   	runtime->avail_max = 0;
> @@ -2655,19 +2656,13 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
>   		
>   static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
>   {
> -	struct snd_pcm_runtime *runtime = substream->runtime;
>   	int err;
>   	snd_pcm_sframes_t n = 0;
>   
>   	snd_pcm_stream_lock_irq(substream);
>   	err = do_pcm_hwsync(substream);
> -	if (!err) {
> -		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -			n = snd_pcm_playback_hw_avail(runtime);
> -		else
> -			n = snd_pcm_capture_avail(runtime);
> -		n += runtime->delay;
> -	}
> +	if (!err)
> +		n = snd_pcm_calc_delay(substream);
>   	snd_pcm_stream_unlock_irq(substream);
>   	return err < 0 ? err : n;
>   }

Oh, 'snd_pcm_running()' is exactly suitable for this case ;)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
