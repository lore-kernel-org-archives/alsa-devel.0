From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC sst: Add mid platform driver
Date: Sun, 2 Jan 2011 13:41:34 +0000
Message-ID: <20110102134134.GD4935@opensource.wolfsonmicro.com>
References: <1293707573-8340-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D10A1245F3
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2011 14:41:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293707573-8340-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, alan@linux.intel.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 30, 2010 at 04:42:53PM +0530, Vinod Koul wrote:

> +	case SNDRV_PCM_TRIGGER_START:
> +		pr_debug("sst: Trigger Start\n");
> +		ret_val = stream->sstdrv_ops->control_set(
> +						SST_SND_START, &str_id);
> +		if (ret_val)
> +			return ret_val;
> +		stream->stream_status = RUNNING;
> +		stream->stream_info.mad_substream = substream;
> +		break;

You've no locking in the rest of the driver protecting the variables
you're updating here.

> +
> +	stream = substream->runtime->private_data;
> +	if (stream->stream_status == INIT)
> +		return 0;
> +	str_info = &stream->stream_info;
> +	ret_val = stream->sstdrv_ops->control_set(
> +				SST_SND_BUFFER_POINTER, &str_info);
> +	if (ret_val) {
> +		pr_err("sst: error code = 0x%x\n", ret_val);
> +		return ret_val;
> +	}
> +
> +	return stream->stream_info.buffer_ptr;

I suspect you need to return bytes_to_frames() of this...

> +	pr_debug("intelmid_platform_probe called\n");
> +	ret = snd_soc_register_platform(&pdev->dev, &intelmid_soc_platform_drv);
> +	if (ret) {
> +		pr_err("registering soc platform failed\n");
> +		return ret;
> +	}
> +	return snd_soc_register_dais(&pdev->dev,
> +				mfld_dai, ARRAY_SIZE(mfld_dai));

You're not unwinding the platform register if the DAI registration
fail.s

> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("mid-platform");

Same issue as with the CODEC driver here.

> +int snd_intelmad_alloc_stream(struct snd_pcm_substream *substream);
> +int snd_intelmad_init_stream(struct snd_pcm_substream *substream);

Why are these exposed here?

> +enum mid_drv_status {
> +	INIT = 1,
> +	STARTED,
> +	RUNNING,
> +	PAUSED,
> +	DROPPED,
> +};

Namespacing.
