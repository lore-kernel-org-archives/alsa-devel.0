From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/3] ALSA: pcm: Unify delay calculation in
 snd_pcm_status() and snd_pcm_delay()
Date: Tue, 17 Apr 2018 12:01:13 +0900
Message-ID: <c188c58d-3737-22d3-d994-25f2e79e7856@sakamocchi.jp>
References: <20180416121417.27452-1-tiwai@suse.de>
 <20180416121417.27452-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 7BA4D2673FE
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 05:01:18 +0200 (CEST)
In-Reply-To: <20180416121417.27452-4-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 16 2018 21:14, Takashi Iwai wrote:
> Yet another slight code cleanup: there are two places where
> calculating the PCM delay, and they can be unified in a single
> helper.  It reduces the multiple open codes.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_native.c | 36 +++++++++++++++---------------------
>   1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index eddb0cd6d1eb..81bbe0b3284b 100644
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
> @@ -909,19 +921,7 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
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
> +	status->delay = snd_pcm_calc_delay(substream);
>   	status->avail_max = runtime->avail_max;
>   	status->overrange = runtime->overrange;
>   	runtime->avail_max = 0;
> @@ -2655,19 +2655,13 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
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

When any PCM substream is under running state, this patchset is good.
Below is short descriptions of calculation in each case.

snd_pcm_status() for playback on running
  * delay = runtime->buffer_size - status->avail 
(=snd_pcm_playback_hw_avail())
  * delay += runtime->delay

snd_pcm_status() for capture on running
  * delay = status->avail (= snd_pcm_avail() = snd_pcm_capture_avail())
  * delay += runtime->delay

snd_pcm_delay() for playback
  * delay = snd_pcm_playback_hw_avail()
  * delay += rutime_delay

snd_pcm_delay() for capture
  * delay = snd_pcm_capture_avail(runtime)
  * delay += runtime->delay


However, under non-running states, I have some suspicion, because
originally 'snd_pcm_status()' take 0 in the states while your code
manage to calculate it.

(sound/core/pcm_native.c)
911    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
912        status->avail = snd_pcm_playback_avail(runtime);
913        if (runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
914            runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
                ...
917        } else
918            status->delay = 0;
919        } else {
920            status->avail = snd_pcm_capture_avail(runtime);
921            if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
                    ...
923            else
924                status->delay = 0;
925        }

I think this patch is based on an assumption that hw_ptr is zeroed
after stopping PCM substream. On the other hand, I cannot find codes
which reset hw_ptr to zero during lifetime of PCM runtime. Any
calculation of delay with hw_ptr could return non-zero value in
non-running states. This patch can change behaviour of PCM core in a 
view of userspace applications, in my understanding.


Regards

Takashi Sakamoto
