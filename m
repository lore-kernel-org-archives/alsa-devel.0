From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Atom: read timestamp moved to period_elapsed
Date: Tue, 9 Jul 2019 14:45:19 +0300
Message-ID: <20190709114519.GW9224@smile.fi.intel.com>
References: <20190709040147.111927-1-levinale@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190709040147.111927-1-levinale@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Levin <levinale@chromium.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, benzh@chromium.org, cujomalainey@chromium.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 08, 2019 at 09:01:47PM -0700, Alex Levin wrote:
> sst_platform_pcm_pointer is called from both snd_pcm_period_elapsed and
> from snd_pcm_ioctl. Calling read timestamp results in recalculating
> pcm_delay and buffer_ptr (sst_calc_tstamp) which consumes buffers in a
> faster rate than intended.
> In a tested BSW system with chtrt5650, for a rate of 48000, the
> measured rate was sometimes 10 times more than that.
> After moving the timestamp read to period elapsed, buffer consumption is
> as expected.

>From code prospective it looks good. You may take mine
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Though I'm not an expert in the area, Pierre and / or Liam should give
their blessing.

> 
> Signed-off-by: Alex Levin <levinale@chromium.org>
> ---
>  sound/soc/intel/atom/sst-mfld-platform-pcm.c | 23 +++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 0e8b1c5eec88..196af0b30b41 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -265,16 +265,28 @@ static void sst_period_elapsed(void *arg)
>  {
>  	struct snd_pcm_substream *substream = arg;
>  	struct sst_runtime_stream *stream;
> -	int status;
> +	struct snd_soc_pcm_runtime *rtd;
> +	int status, ret_val;
>  
>  	if (!substream || !substream->runtime)
>  		return;
>  	stream = substream->runtime->private_data;
>  	if (!stream)
>  		return;
> +
> +	rtd = substream->private_data;
> +	if (!rtd)
> +		return;
> +
>  	status = sst_get_stream_status(stream);
>  	if (status != SST_PLATFORM_RUNNING)
>  		return;
> +
> +	ret_val = stream->ops->stream_read_tstamp(sst->dev, &stream->stream_info);
> +	if (ret_val) {
> +		dev_err(rtd->dev, "stream_read_tstamp err code = %d\n", ret_val);
> +		return;
> +	}
>  	snd_pcm_period_elapsed(substream);
>  }
>  
> @@ -658,20 +670,15 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
>  			(struct snd_pcm_substream *substream)
>  {
>  	struct sst_runtime_stream *stream;
> -	int ret_val, status;
> +	int status;
>  	struct pcm_stream_info *str_info;
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  
>  	stream = substream->runtime->private_data;
>  	status = sst_get_stream_status(stream);
>  	if (status == SST_PLATFORM_INIT)
>  		return 0;
> +
>  	str_info = &stream->stream_info;
> -	ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
> -	if (ret_val) {
> -		dev_err(rtd->dev, "sst: error code = %d\n", ret_val);
> -		return ret_val;
> -	}
>  	substream->runtime->delay = str_info->pcm_delay;
>  	return str_info->buffer_ptr;
>  }
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
With Best Regards,
Andy Shevchenko
