From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: pcm: Use a common helper for PCM
 state check and hwsync
Date: Sun, 21 May 2017 13:54:28 +0900
Message-ID: <bea13c6a-a4c0-7ad0-c8a3-091fde9940c2@sakamocchi.jp>
References: <20170519183100.11758-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0F928265142
 for <alsa-devel@alsa-project.org>; Sun, 21 May 2017 06:54:35 +0200 (CEST)
In-Reply-To: <20170519183100.11758-1-tiwai@suse.de>
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

On May 20 2017 03:30, Takashi Iwai wrote:
> The mostly same codes for checking the current PCM state and calling
> hwsync are found in a few places.  This patch simplifies them by
> creating a common helper function.
> 
> It also fixes a couple of cases where we missed the proper state check
> (e.g. PAUSED state wasn't handled in rewind and snd_pcm_hwsync()),
> too.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_native.c | 153 +++++++++++-------------------------------------
>   1 file changed, 35 insertions(+), 118 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index f3a3580eb44c..93bd2c662c1d 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -2431,6 +2431,30 @@ static int snd_pcm_release(struct inode *inode, struct file *file)
>   	return 0;
>   }
>   
> +/* check and update PCM state; return 0 or a negative error
> + * call this inside PCM lock
> + */
> +static int do_pcm_hwsync(struct snd_pcm_substream *substream)
> +{
> +	switch (substream->runtime->status->state) {
> +	case SNDRV_PCM_STATE_DRAINING:
> +		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +			return -EBADFD;
> +		/* Fall through */
> +	case SNDRV_PCM_STATE_RUNNING:
> +		return snd_pcm_update_hw_ptr(substream);
> +	case SNDRV_PCM_STATE_PREPARED:
> +	case SNDRV_PCM_STATE_PAUSED:
> +		return 0;
> +	case SNDRV_PCM_STATE_SUSPENDED:
> +		return -ESTRPIPE;
> +	case SNDRV_PCM_STATE_XRUN:
> +		return -EPIPE;
> +	default:
> +		return -EBADFD;
> +	}
> +}
> +
>   static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *substream,
>   						 snd_pcm_uframes_t frames)
>   {
> @@ -2443,25 +2467,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
>   		return 0;
>   
>   	snd_pcm_stream_lock_irq(substream);
> -	switch (runtime->status->state) {
> -	case SNDRV_PCM_STATE_PREPARED:
> -		break;
> -	case SNDRV_PCM_STATE_DRAINING:
> -	case SNDRV_PCM_STATE_RUNNING:
> -		if (snd_pcm_update_hw_ptr(substream) >= 0)
> -			break;
> -		/* Fall through */
> -	case SNDRV_PCM_STATE_XRUN:
> -		ret = -EPIPE;
> -		goto __end;
> -	case SNDRV_PCM_STATE_SUSPENDED:
> -		ret = -ESTRPIPE;
> -		goto __end;
> -	default:
> -		ret = -EBADFD;
> +	ret = do_pcm_hwsync(substream);
> +	if (ret < 0)
>   		goto __end;
> -	}
> -
>   	hw_avail = snd_pcm_playback_hw_avail(runtime);
>   	if (hw_avail <= 0) {
>   		ret = 0;
> @@ -2491,25 +2499,9 @@ static snd_pcm_sframes_t snd_pcm_capture_rewind(struct snd_pcm_substream *substr
>   		return 0;
>   
>   	snd_pcm_stream_lock_irq(substream);
> -	switch (runtime->status->state) {
> -	case SNDRV_PCM_STATE_PREPARED:
> -	case SNDRV_PCM_STATE_DRAINING:
> -		break;
> -	case SNDRV_PCM_STATE_RUNNING:
> -		if (snd_pcm_update_hw_ptr(substream) >= 0)
> -			break;
> -		/* Fall through */
> -	case SNDRV_PCM_STATE_XRUN:
> -		ret = -EPIPE;
> +	ret = do_pcm_hwsync(substream);
> +	if (ret < 0)
>   		goto __end;
> -	case SNDRV_PCM_STATE_SUSPENDED:
> -		ret = -ESTRPIPE;
> -		goto __end;
> -	default:
> -		ret = -EBADFD;
> -		goto __end;
> -	}
> -
>   	hw_avail = snd_pcm_capture_hw_avail(runtime);
>   	if (hw_avail <= 0) {
>   		ret = 0;
> @@ -2539,26 +2531,9 @@ static snd_pcm_sframes_t snd_pcm_playback_forward(struct snd_pcm_substream *subs
>   		return 0;
>   
>   	snd_pcm_stream_lock_irq(substream);
> -	switch (runtime->status->state) {
> -	case SNDRV_PCM_STATE_PREPARED:
> -	case SNDRV_PCM_STATE_PAUSED:
> -		break;
> -	case SNDRV_PCM_STATE_DRAINING:
> -	case SNDRV_PCM_STATE_RUNNING:
> -		if (snd_pcm_update_hw_ptr(substream) >= 0)
> -			break;
> -		/* Fall through */
> -	case SNDRV_PCM_STATE_XRUN:
> -		ret = -EPIPE;
> -		goto __end;
> -	case SNDRV_PCM_STATE_SUSPENDED:
> -		ret = -ESTRPIPE;
> +	ret = do_pcm_hwsync(substream);
> +	if (ret < 0)
>   		goto __end;
> -	default:
> -		ret = -EBADFD;
> -		goto __end;
> -	}
> -
>   	avail = snd_pcm_playback_avail(runtime);
>   	if (avail <= 0) {
>   		ret = 0;
> @@ -2588,26 +2563,9 @@ static snd_pcm_sframes_t snd_pcm_capture_forward(struct snd_pcm_substream *subst
>   		return 0;
>   
>   	snd_pcm_stream_lock_irq(substream);
> -	switch (runtime->status->state) {
> -	case SNDRV_PCM_STATE_PREPARED:
> -	case SNDRV_PCM_STATE_DRAINING:
> -	case SNDRV_PCM_STATE_PAUSED:
> -		break;
> -	case SNDRV_PCM_STATE_RUNNING:
> -		if (snd_pcm_update_hw_ptr(substream) >= 0)
> -			break;
> -		/* Fall through */
> -	case SNDRV_PCM_STATE_XRUN:
> -		ret = -EPIPE;
> -		goto __end;
> -	case SNDRV_PCM_STATE_SUSPENDED:
> -		ret = -ESTRPIPE;
> +	ret = do_pcm_hwsync(substream);
> +	if (ret < 0)
>   		goto __end;
> -	default:
> -		ret = -EBADFD;
> -		goto __end;
> -	}
> -
>   	avail = snd_pcm_capture_avail(runtime);
>   	if (avail <= 0) {
>   		ret = 0;
> @@ -2627,33 +2585,10 @@ static snd_pcm_sframes_t snd_pcm_capture_forward(struct snd_pcm_substream *subst
>   
>   static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
>   {
> -	struct snd_pcm_runtime *runtime = substream->runtime;
>   	int err;
>   
>   	snd_pcm_stream_lock_irq(substream);
> -	switch (runtime->status->state) {
> -	case SNDRV_PCM_STATE_DRAINING:
> -		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> -			goto __badfd;
> -		/* Fall through */
> -	case SNDRV_PCM_STATE_RUNNING:
> -		if ((err = snd_pcm_update_hw_ptr(substream)) < 0)
> -			break;
> -		/* Fall through */
> -	case SNDRV_PCM_STATE_PREPARED:
> -		err = 0;
> -		break;
> -	case SNDRV_PCM_STATE_SUSPENDED:
> -		err = -ESTRPIPE;
> -		break;
> -	case SNDRV_PCM_STATE_XRUN:
> -		err = -EPIPE;
> -		break;
> -	default:
> -	      __badfd:
> -		err = -EBADFD;
> -		break;
> -	}
> +	err = do_pcm_hwsync(substream);
>   	snd_pcm_stream_unlock_irq(substream);
>   	return err;
>   }
> @@ -2666,31 +2601,13 @@ static int snd_pcm_delay(struct snd_pcm_substream *substream,
>   	snd_pcm_sframes_t n = 0;
>   
>   	snd_pcm_stream_lock_irq(substream);
> -	switch (runtime->status->state) {
> -	case SNDRV_PCM_STATE_DRAINING:
> -		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> -			goto __badfd;
> -		/* Fall through */
> -	case SNDRV_PCM_STATE_RUNNING:
> -		if ((err = snd_pcm_update_hw_ptr(substream)) < 0)
> -			break;
> -		/* Fall through */
> -	case SNDRV_PCM_STATE_PREPARED:
> -	case SNDRV_PCM_STATE_SUSPENDED:
> -		err = 0;
> +	err = do_pcm_hwsync(substream);
> +	if (!err) {
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>   			n = snd_pcm_playback_hw_avail(runtime);
>   		else
>   			n = snd_pcm_capture_avail(runtime);
>   		n += runtime->delay;
> -		break;
> -	case SNDRV_PCM_STATE_XRUN:
> -		err = -EPIPE;
> -		break;
> -	default:
> -	      __badfd:
> -		err = -EBADFD;
> -		break;
>   	}
>   	snd_pcm_stream_unlock_irq(substream);
>   	if (!err)

In this patch, the added function, do_pcm_hwsync(), judges from current
status of runtime of PCM substream. The cases are illustrated in a below
table.

any operation:
state      capture   playback
----------+---------+---------
PREPARED   0         0
RUNNING    hw_ptr()  hw_ptr()
XRUN       EPIPE     EPIPE
DRAINING   EBADFD    hw_ptr()
PAUSED     0         0
SUSPENDED  ESTRPIPE  ESTRPIPE
others     EBADFD    EBADFD

Here, 'any' means relevant operations; delay, hwsync, forward and
rewind. Columns with 0 represents they're cases to continue requested
operation. At RUNNING state, snd_pcm_update_hw_ptr() is executed at
first, then continue processing as requested according to its return
value. When getting EPIPE, operation is canceled.

As Iwai-san described, this brings changes to current
implementation. The current cases are illustrated in below tables.
Columns with asterisks get the change.

delay operation:
state      capture   playback
----------+---------+---------+
PREPARED   0         0
RUNNING    hw_ptr()  hw_ptr()
XRUN       EPIPE     EPIPE
DRAINING   EBADFD    hw_ptr()
PAUSED     *EBADFD   *EBADFD
SUSPENDED  *0        *0
others     EBADFD    EBADFD

hwsync operation:
state      capture   playback
----------+---------+---------
PREPARED   0         0
RUNNING    hw_ptr()  hw_ptr()
XRUN       EPIPE     EPIPE
DRAINING   EBADFD    hw_ptr()
PAUSED     *EBADFD   *EBADFD
SUSPENDED  ESTRPIPE  ESTRPIPE
others     EBADFD    EBADFD

forward operation:
state      capture   playback
----------+---------+---------
PREPARED   0         0
RUNNING    hw_ptr()  hw_ptr()
XRUN       EPIPE     EPIPE
DRAINING   *0        hw_ptr()
PAUSED     0         0
SUSPENDED  ESTRPIPE  ESTRPIPE
others     EBADFD    EBADFD

rewind operation:
state      capture   playback
----------+---------+---------
PREPARED   0         0
RUNNING    hw_ptr()  hw_ptr()
XRUN       EPIPE     EPIPE
DRAINING   *0        hw_ptr()
PAUSED     *EBADFD   *EBADFD
SUSPENDED  ESTRPIPE  ESTRPIPE
others     EBADFD    EBADFD

Here, columns with 'others' are for a set of DISCONNECTED, OPEN and
SETUP.

When the PCM substream is under PAUSED state, transmission should be
stopped and PCM buffer is kept as is. In the buffer, hwptr doesn't move
but applptr can be safely moved by applications' requests for
forwarding/rewinding. The change is enough reasonable.

As well, under SUSPENDED state, transmission is stopped. But in this
status, PCM buffer is released. Calculation of PCM frames on the buffer
makes no sense and ESTRPIPE should be returned. Documentation in
alsa-lib also described it[1].

The DRAINING state of PCM substream is valid only in a case that the
substream is for playbacking. Returning EBADFD is reasonable before
synchronizing hwptr for capture PCM substream.

Overall, this change is good to me, against its influences to user
land, from a semantics of states and operations for PCM substream.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


[1] Error codes
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html#pcm_errors


Regards

Takashi Sakamoto
