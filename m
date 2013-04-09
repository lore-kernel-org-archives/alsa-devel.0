From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ASoC: soc-compress: Split copy into
 seperate read and write callbacks
Date: Tue, 9 Apr 2013 16:45:51 +0530
Message-ID: <20130409111551.GG31193@intel.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1364991209-24653-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id A854F265DF1
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 13:44:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1364991209-24653-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 03, 2013 at 01:13:29PM +0100, Charles Keepax wrote:
> The compress API for non-memory mapped DSPs shares a copy callback for
> both read and write, however the file operation of write passes a const
> buffer. Thus we can't maintain const correctness for the copy callback
> and support both read and write.
This should be part of 2nd patch, you break bisect by not doing so...

> 
> This patch seperates the read and write callbacks in the ASoC compressed
> API.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-compress.c |   34 +++++++++++++++++++++++++++-------
>  1 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index f9b2197..0148d82 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -306,8 +306,8 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
>  	return 0;
>  }
>  
> -static int soc_compr_copy(struct snd_compr_stream *cstream,
> -			  const char __user *buf, size_t count)
> +static int soc_compr_write(struct snd_compr_stream *cstream,
> +			   const char __user *buf, size_t count)
>  {
>  	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
>  	struct snd_soc_platform *platform = rtd->platform;
> @@ -315,8 +315,24 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
>  
>  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
>  
> -	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
> -		ret = platform->driver->compr_ops->copy(cstream, buf, count);
> +	if (platform->driver->compr_ops && platform->driver->compr_ops->write)
> +		ret = platform->driver->compr_ops->write(cstream, buf, count);
> +
> +	mutex_unlock(&rtd->pcm_mutex);
> +	return ret;
> +}
> +
> +static int soc_compr_read(struct snd_compr_stream *cstream,
> +			  char __user *buf, size_t count)
> +{
> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> +	struct snd_soc_platform *platform = rtd->platform;
> +	int ret = 0;
> +
> +	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
> +
> +	if (platform->driver->compr_ops && platform->driver->compr_ops->read)
> +		ret = platform->driver->compr_ops->read(cstream, buf, count);
>  
>  	mutex_unlock(&rtd->pcm_mutex);
>  	return ret;
> @@ -392,9 +408,13 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  	}
>  	memcpy(compr->ops, &soc_compr_ops, sizeof(soc_compr_ops));
>  
> -	/* Add copy callback for not memory mapped DSPs */
> -	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
> -		compr->ops->copy = soc_compr_copy;
> +	/* Add write/read callback for not memory mapped DSPs */
> +	if (platform->driver->compr_ops) {
> +		if (platform->driver->compr_ops->write)
> +			compr->ops->write = soc_compr_write;
> +		if (platform->driver->compr_ops->read)
> +			compr->ops->read = soc_compr_read;
> +	}
>  
>  	mutex_init(&compr->lock);
>  	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
> -- 
> 1.7.2.5
> 
