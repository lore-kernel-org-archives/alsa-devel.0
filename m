From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/7] ALSA: compress_core: Add support for
 capture streams
Date: Fri, 19 Apr 2013 18:55:52 +0530
Message-ID: <20130419132552.GA6081@intel.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
 <61f3f3c2-726d-4fde-af44-608a154ea183@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 05FC526109B
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 15:56:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61f3f3c2-726d-4fde-af44-608a154ea183@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: girdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2013 at 11:02:08AM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  sound/core/compress_offload.c |   43 +++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 52ca4cc..52a2765 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -296,7 +296,41 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
>  static ssize_t snd_compr_read(struct file *f, char __user *buf,
>  		size_t count, loff_t *offset)
>  {
> -	return -ENXIO;
> +	struct snd_compr_file *data = f->private_data;
> +	struct snd_compr_stream *stream;
> +	size_t avail;
> +	int retval;
> +
> +	if (snd_BUG_ON(!data))
> +		return -EFAULT;
> +
> +	stream = &data->stream;
> +	mutex_lock(&stream->device->lock);
> +
> +	/* read is allowed when stream is running */
> +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
> +		retval = -EBADFD;
> +		goto out;
minor one but shouldnt we allow read even when we have stoped or paused the
stream. Stop is important as you might want to get all buffers after you have
stopped.
> +	}
> +
> +	avail = snd_compr_get_avail(stream);
> +	pr_debug("avail returned %ld\n", (unsigned long)avail);
> +	/* calculate how much we can read from buffer */
> +	if (avail > count)
> +		avail = count;
> +
> +	if (stream->ops->copy) {
> +		retval = stream->ops->copy(stream, buf, avail);
> +	} else {
> +		retval = -ENXIO;
> +		goto out;
> +	}
> +	if (retval > 0)
> +		stream->runtime->total_bytes_transferred += retval;
> +
> +out:
> +	mutex_unlock(&stream->device->lock);
> +	return retval;
>  }
>  
>  static int snd_compr_mmap(struct file *f, struct vm_area_struct *vma)
> @@ -481,9 +515,14 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
>  		retval = stream->ops->set_params(stream, params);
>  		if (retval)
>  			goto out;
> -		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +
>  		stream->metadata_set = false;
>  		stream->next_track = false;
> +
> +		if (stream->direction == SND_COMPRESS_PLAYBACK)
> +			stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +		else
> +			stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
>  	} else {
>  		return -EPERM;
>  	}
> -- 
> 1.7.2.5
> 
