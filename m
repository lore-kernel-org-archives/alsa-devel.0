From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH sound-unstable] usb-audio: sync ep init fix
 for audioformat mistmatch
Date: Mon, 03 Dec 2012 10:34:29 +0100
Message-ID: <50BC7225.4050204@gmail.com>
References: <s5hk3t4alc0.wl%tiwai@suse.de>
 <1354402226-2392-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C1E926031E
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 10:34:37 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so847132bkc.38
 for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2012 01:34:37 -0800 (PST)
In-Reply-To: <1354402226-2392-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: alsa-devel@alsa-project.org, Chris Cavey <chris-alsa@rauros.net>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Grant Diffey <gdiffey@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, George Willian Condomitti <georgecondomitti@gmail.com>, Jeffrey Barish <jeff_barish@earthlink.net>
List-Id: alsa-devel@alsa-project.org

On 01.12.2012 23:50, Eldad Zack wrote:
> Commit 947d299686aa9cc8aecf749d54e8475c6e498956 , "ALSA: snd-usb:
> properly initialize the sync endpoint", while correcting the
> initialization of the sync endpoint when opening just the data
> endpoint, prevents devices that has a sync endpoint with a channel
> number different than the data endpoint channel from functioning.
> Due to a different channel and period bytes count. attempting to
> initialize the sync endpoint will fail at the usb host driver:
> (example, when using xhci:)
> 
>  cannot submit urb 0, error -90: internal error
> 
> With this patch, if a sync endpoint has multiple audioformats, a
> matching audioformat is perferred. An audioformat must be found
> with at least one channel and support the requested sample rate
> and PCM format, otherwise the stream will not be opened.
> 
> If the number of channels differ between the selected audioformat
> and the requested format, adjust the period bytes count accordingly.
> It is safe to perform the calculation on the basis of the channel
> count, since the PCM audio format and the rate must be supported by
> the selected audioformat.

Thanks for fixing this up, and sorry for the late response on this.

> 
> Cc: Jeffrey Barish <jeff_barish@earthlink.net>
> Cc: Daniel Mack <zonque@gmail.com>
> Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
> ---
>  sound/usb/pcm.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 99 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 5d3cf85..e539a5a 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -451,6 +451,103 @@ add_sync_ep:
>  }
>  
>  /*
> + * Return the score of matching two audioformats.
> + * Veto the audioformat if:
> + * - It has no channels for some reason.
> + * - Requested PCM format is not supported.
> + * - Requested sample rate is not supported.
> + */
> +static int match_endpoint_audioformats(struct audioformat *fp,
> +	struct audioformat *match, int rate,
> +	snd_pcm_format_t pcm_format)
> +{
> +	int i;
> +	int score = 0;
> +
> +	if (fp->channels < 1) {
> +		snd_printdd("%s: (fmt @%p) no channels\n", __func__, fp);
> +		return 0;
> +	}
> +
> +	if (!(fp->formats && pcm_format)) {

That should be a binary &, no?

Otherwise, together with the fix Takashi suggested, looks good to me as
well.


Thanks,
Daniel


> +		snd_printdd("%s: (fmt @%p) no match for format %d\n", __func__,
> +			fp, pcm_format);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < 4; i++) {
> +		if (fp->rate_table[i] == rate) {
> +			score++;
> +			break;
> +		}
> +	}
> +	if (!score) {
> +		snd_printdd("%s: (fmt @%p) no match for rate %d\n", __func__,
> +			fp, rate);
> +		return 0;
> +	}
> +
> +	if (fp->channels == match->channels)
> +		score++;
> +
> +	snd_printdd("%s: (fmt @%p) score %d\n", __func__, fp, score);
> +
> +	return score;
> +}
> +
> +/*
> + * Configure the sync ep using the rate and pcm format of the data ep.
> + */
> +static int configure_sync_endpoint(struct snd_usb_substream *subs)
> +{
> +	int ret;
> +	struct audioformat *fp;
> +	struct audioformat *sync_fp = NULL;
> +	int cur_score = 0;
> +	int sync_period_bytes = subs->period_bytes;
> +	struct snd_usb_substream *sync_subs =
> +		&subs->stream->substream[subs->direction ^ 1];
> +
> +	/* Try to find the best matching audioformat. */
> +	list_for_each_entry(fp, &sync_subs->fmt_list, list) {
> +		int score = match_endpoint_audioformats(fp, subs->cur_audiofmt,
> +			subs->cur_rate, subs->pcm_format);
> +
> +		if (score > cur_score) {
> +			sync_fp = fp;
> +			cur_score = score;
> +		}
> +	}
> +
> +	if (unlikely(sync_fp == NULL)) {
> +		snd_printk(KERN_ERR "%s: no valid audioformat for sync ep %x found\n",
> +			__func__, sync_subs->ep_num);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Recalculated the period bytes if channel number differ between
> +	 * data and sync ep audioformat.
> +	 */
> +	if (sync_fp->channels != subs->channels) {
> +		sync_period_bytes = (subs->period_bytes / subs->channels) *
> +			sync_fp->channels;
> +		snd_printdd("%s: adjusted sync ep period bytes (%d -> %d)\n",
> +			__func__, subs->period_bytes, sync_period_bytes);
> +	}
> +
> +	ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
> +					  subs->pcm_format,
> +					  sync_fp->channels,
> +					  sync_period_bytes,
> +					  subs->cur_rate,
> +					  sync_fp,
> +					  NULL);
> +
> +	return ret;
> +}
> +
> +/*
>   * configure endpoint params
>   *
>   * called  during initial setup and upon resume
> @@ -472,13 +569,8 @@ static int configure_endpoint(struct snd_usb_substream *subs)
>  		return ret;
>  
>  	if (subs->sync_endpoint)
> -		ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
> -						  subs->pcm_format,
> -						  subs->channels,
> -						  subs->period_bytes,
> -						  subs->cur_rate,
> -						  subs->cur_audiofmt,
> -						  NULL);
> +		ret = configure_sync_endpoint(subs);
> +
>  	return ret;
>  }
>  
> 
