From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ALSA: pcm: Allow aborting mutex lock
 at OSS read/write loops
Date: Mon, 8 Jan 2018 16:35:49 +0100
Message-ID: <8315dd4e-7332-c0ae-72e9-2ca43868ca7b@metafoo.de>
References: <20180108142541.18098-1-tiwai@suse.de>
 <20180108142541.18098-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A9D22673AF
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 16:35:52 +0100 (CET)
In-Reply-To: <20180108142541.18098-3-tiwai@suse.de>
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
Cc: Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

On 01/08/2018 03:25 PM, Takashi Iwai wrote:
> @@ -1438,8 +1441,11 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_substream *substream, char __use
>  
>  	if ((tmp = snd_pcm_oss_make_ready(substream)) < 0)
>  		return tmp;
> -	mutex_lock(&runtime->oss.params_lock);
>  	while (bytes > 0) {
> +		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
> +			tmp = -EINTR;

For consistency ERESTARTSYS I guess? In the end this is the same as
signal_pending().

> +			break;
> +		}
>  		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
>  			if (runtime->oss.buffer_used == 0) {
>  				tmp = snd_pcm_oss_read2(substream, runtime->oss.buffer, runtime->oss.period_bytes, 1);
> @@ -1470,16 +1476,16 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_substream *substream, char __use
>  			bytes -= tmp;
>  			xfer += tmp;
>  		}
> + err:
> +		mutex_unlock(&runtime->oss.params_lock);
> +		if (tmp < 0)
> +			break;
>  		if (signal_pending(current)) {
>  			tmp = -ERESTARTSYS;
> -			goto err;
> +			break;
>  		}
> +		tmp = 0;
>  	}
> -	mutex_unlock(&runtime->oss.params_lock);
> -	return xfer;
> -
> - err:
> -	mutex_unlock(&runtime->oss.params_lock);
>  	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
>  }
>  
> 
