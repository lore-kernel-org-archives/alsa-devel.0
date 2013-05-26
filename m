From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH: TinyCompress] fix error reporting in
	tinycompress
Date: Sun, 26 May 2013 19:43:11 +0530
Message-ID: <20130526141311.GX30200@intel.com>
References: <1369295119-29676-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 46D3E261281
 for <alsa-devel@alsa-project.org>; Sun, 26 May 2013 16:50:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1369295119-29676-1-git-send-email-vinod.koul@intel.com>
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
Cc: Lakshmi N Vinnakota <lakshmi.n.vinnakota@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 23, 2013 at 01:15:19PM +0530, Vinod Koul wrote:
> From: Lakshmi N Vinnakota <lakshmi.n.vinnakota@intel.com>
> 
> The compress API are expected to return a negative value on an error
> with errno indicating the type of error. But in some cases, this is
> not happening.
> 
> The fix is the oops function always returns -1 and the actual
> error number is determined by the global variable errno.
> 
> Signed-off-by: Lakshmi N Vinnakota <lakshmi.n.vinnakota@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Applied, Thanks

--
~Vinod
> ---
>  compress.c |   61 ++++++++++++++++++++++++++++++-----------------------------
>  1 files changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/compress.c b/compress.c
> index 8753758..7f56c78 100644
> --- a/compress.c
> +++ b/compress.c
> @@ -102,10 +102,11 @@ static int oops(struct compress *compress, int e, const char *fmt, ...)
>  	va_end(ap);
>  	sz = strlen(compress->error);
>  
> -	if (errno)
> -		snprintf(compress->error + sz, COMPR_ERR_MAX - sz,
> -			": %s", strerror(e));
> -	return e;
> +	snprintf(compress->error + sz, COMPR_ERR_MAX - sz,
> +		": %s", strerror(e));
> +	errno = e;
> +
> +	return -1;
>  }
>  
>  const char *compress_get_error(struct compress *compress)
> @@ -151,27 +152,27 @@ static bool _is_codec_supported(struct compress *compress, struct compr_config *
>  		}
>  	}
>  	if (codec == false) {
> -		oops(compress, -ENXIO, "this codec is not supported");
> +		oops(compress, ENXIO, "this codec is not supported");
>  		return false;
>  	}
>  
>  	if (config->fragment_size < caps->min_fragment_size) {
> -		oops(compress, -EINVAL, "requested fragment size %d is below min supported %d",
> +		oops(compress, EINVAL, "requested fragment size %d is below min supported %d",
>  			config->fragment_size, caps->min_fragment_size);
>  		return false;
>  	}
>  	if (config->fragment_size > caps->max_fragment_size) {
> -		oops(compress, -EINVAL, "requested fragment size %d is above max supported %d",
> +		oops(compress, EINVAL, "requested fragment size %d is above max supported %d",
>  			config->fragment_size, caps->max_fragment_size);
>  		return false;
>  	}
>  	if (config->fragments < caps->min_fragments) {
> -		oops(compress, -EINVAL, "requested fragments %d are below min supported %d",
> +		oops(compress, EINVAL, "requested fragments %d are below min supported %d",
>  			config->fragments, caps->min_fragments);
>  		return false;
>  	}
>  	if (config->fragments > caps->max_fragments) {
> -		oops(compress, -EINVAL, "requested fragments %d are above max supported %d",
> +		oops(compress, EINVAL, "requested fragments %d are above max supported %d",
>  			config->fragments, caps->max_fragments);
>  		return false;
>  	}
> @@ -219,7 +220,7 @@ struct compress *compress_open(unsigned int card, unsigned int device,
>  	char fn[256];
>  
>  	if (!config) {
> -		oops(&bad_compress, -EINVAL, "passed bad config");
> +		oops(&bad_compress, EINVAL, "passed bad config");
>  		return &bad_compress;
>  	}
>  
> @@ -242,7 +243,7 @@ struct compress *compress_open(unsigned int card, unsigned int device,
>  
>  	compress->flags = flags;
>  	if (!((flags & COMPRESS_OUT) || (flags & COMPRESS_IN))) {
> -		oops(&bad_compress, -EINVAL, "can't deduce device direction from given flags");
> +		oops(&bad_compress, EINVAL, "can't deduce device direction from given flags");
>  		goto config_fail;
>  	}
>  
> @@ -315,12 +316,12 @@ int compress_get_hpointer(struct compress *compress,
>  	__u64 time;
>  
>  	if (!is_compress_ready(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  
>  	if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &kavail))
>  		return oops(compress, errno, "cannot get avail");
>  	if (0 == kavail.tstamp.sampling_rate)
> -		return oops(compress, -ENODATA, "sample rate unknown");
> +		return oops(compress, ENODATA, "sample rate unknown");
>  	*avail = (unsigned int)kavail.avail;
>  	time = kavail.tstamp.pcm_io_frames / kavail.tstamp.sampling_rate;
>  	tstamp->tv_sec = time;
> @@ -335,7 +336,7 @@ int compress_get_tstamp(struct compress *compress,
>  	struct snd_compr_tstamp ktstamp;
>  
>  	if (!is_compress_ready(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  
>  	if (ioctl(compress->fd, SNDRV_COMPRESS_TSTAMP, &ktstamp))
>  		return oops(compress, errno, "cannot get tstamp");
> @@ -355,9 +356,9 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
>  	const unsigned int frag_size = compress->config->fragment_size;
>  
>  	if (!(compress->flags & COMPRESS_IN))
> -		return oops(compress, -EINVAL, "Invalid flag set");
> +		return oops(compress, EINVAL, "Invalid flag set");
>  	if (!is_compress_ready(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  	fds.fd = compress->fd;
>  	fds.events = POLLOUT;
>  
> @@ -383,7 +384,7 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
>  				continue;
>  			}
>  			if (fds.revents & POLLERR) {
> -				return oops(compress, -EIO, "poll returned error!");
> +				return oops(compress, EIO, "poll returned error!");
>  			}
>  		}
>  		/* write avail bytes */
> @@ -415,9 +416,9 @@ int compress_read(struct compress *compress, void *buf, unsigned int size)
>  	const unsigned int frag_size = compress->config->fragment_size;
>  
>  	if (!(compress->flags & COMPRESS_OUT))
> -		return oops(compress, -EINVAL, "Invalid flag set");
> +		return oops(compress, EINVAL, "Invalid flag set");
>  	if (!is_compress_ready(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  	fds.fd = compress->fd;
>  	fds.events = POLLIN;
>  
> @@ -440,7 +441,7 @@ int compress_read(struct compress *compress, void *buf, unsigned int size)
>  				continue;
>  			}
>  			if (fds.revents & POLLERR) {
> -				return oops(compress, -EIO, "poll returned error!");
> +				return oops(compress, EIO, "poll returned error!");
>  			}
>  		}
>  		/* read avail bytes */
> @@ -466,7 +467,7 @@ int compress_read(struct compress *compress, void *buf, unsigned int size)
>  int compress_start(struct compress *compress)
>  {
>  	if (!is_compress_ready(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  	if (ioctl(compress->fd, SNDRV_COMPRESS_START))
>  		return oops(compress, errno, "cannot start the stream");
>  	compress->running = 1;
> @@ -477,7 +478,7 @@ int compress_start(struct compress *compress)
>  int compress_stop(struct compress *compress)
>  {
>  	if (!is_compress_running(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  	if (ioctl(compress->fd, SNDRV_COMPRESS_STOP))
>  		return oops(compress, errno, "cannot stop the stream");
>  	return 0;
> @@ -486,7 +487,7 @@ int compress_stop(struct compress *compress)
>  int compress_pause(struct compress *compress)
>  {
>  	if (!is_compress_running(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  	if (ioctl(compress->fd, SNDRV_COMPRESS_PAUSE))
>  		return oops(compress, errno, "cannot pause the stream");
>  	return 0;
> @@ -502,7 +503,7 @@ int compress_resume(struct compress *compress)
>  int compress_drain(struct compress *compress)
>  {
>  	if (!is_compress_running(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  	if (ioctl(compress->fd, SNDRV_COMPRESS_DRAIN))
>  		return oops(compress, errno, "cannot drain the stream");
>  	return 0;
> @@ -511,10 +512,10 @@ int compress_drain(struct compress *compress)
>  int compress_partial_drain(struct compress *compress)
>  {
>  	if (!is_compress_running(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  
>  	if (!compress->next_track)
> -		return oops(compress, -EPERM, "next track not signalled");
> +		return oops(compress, EPERM, "next track not signalled");
>  	if (ioctl(compress->fd, SNDRV_COMPRESS_PARTIAL_DRAIN))
>  		return oops(compress, errno, "cannot drain the stream\n");
>  	compress->next_track = 0;
> @@ -524,10 +525,10 @@ int compress_partial_drain(struct compress *compress)
>  int compress_next_track(struct compress *compress)
>  {
>  	if (!is_compress_running(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  
>  	if (!compress->gapless_metadata)
> -		return oops(compress, -EPERM, "metadata not set");
> +		return oops(compress, EPERM, "metadata not set");
>  	if (ioctl(compress->fd, SNDRV_COMPRESS_NEXT_TRACK))
>  		return oops(compress, errno, "cannot set next track\n");
>  	compress->next_track = 1;
> @@ -542,14 +543,14 @@ int compress_set_gapless_metadata(struct compress *compress,
>  	int version;
>  
>  	if (!is_compress_ready(compress))
> -		return oops(compress, -ENODEV, "device not ready");
> +		return oops(compress, ENODEV, "device not ready");
>  
>  	version = get_compress_version(compress);
>  	if (version <= 0)
>  		return -1;
>  
>  	if (version < SNDRV_PROTOCOL_VERSION(0, 1, 1))
> -		return oops(compress, -ENXIO, "gapless apis not supported in kernel");
> +		return oops(compress, ENXIO, "gapless apis not supported in kernel");
>  
>  	metadata.key = SNDRV_COMPRESS_ENCODER_PADDING;
>  	metadata.value[0] = mdata->encoder_padding;
> -- 
> 1.7.0.4
> 
