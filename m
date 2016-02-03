From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH RFC 01/15] ASoC: qcom: use
 snd_dma_alloc/free*	apis
Date: Tue, 2 Feb 2016 16:35:08 -0800
Message-ID: <20160203003507.GB14436@kwestfie-linux.qualcomm.com>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347680-10307-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454347680-10307-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 09:27:59AM -0800, Srinivas Kandagatla wrote:
> diff --git a/sound/soc/qcom/lpass-platform.c
> b/sound/soc/qcom/lpass-platform.c
> index 4aeb8e1..a6dce1b 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -439,39 +439,6 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq,
> void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static int lpass_platform_alloc_buffer(struct snd_pcm_substream
> *substream,
> -		struct snd_soc_pcm_runtime *rt)
> -{
> -	struct snd_dma_buffer *buf = &substream->dma_buffer;
> -	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
> -
> -	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> -	buf->dev.dev = rt->platform->dev;
> -	buf->private_data = NULL;
> -	buf->area = dma_alloc_coherent(rt->platform->dev, size,
> &buf->addr,
> -			GFP_KERNEL);
> -	if (!buf->area) {
> -		dev_err(rt->platform->dev, "%s: Could not allocate DMA
> buffer\n",
> -				__func__);
> -		return -ENOMEM;
> -	}

...

> @@ -499,7 +467,8 @@ static int lpass_platform_pcm_new(struct
> snd_soc_pcm_runtime *soc_runtime)
>  
>  	snd_soc_pcm_set_drvdata(soc_runtime, data);
>  
> -	ret = lpass_platform_alloc_buffer(substream, soc_runtime);
> +	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev,
> +				size, &substream->dma_buffer);
>  	if (ret)
>  		return ret;
>  

Is there a particular reason for using the soundcard device (pcm-card->dev)
rather than the platform device (rt->platform->dev) for memory
allocation?  Especially considering you posted a fix for this several
weeks ago (ASoC: qcom: use correct device pointer in dma allocation).

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
