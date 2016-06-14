From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v2 2/2] sound: lpass-platform: Move dma channel
 allocation to pcmops
Date: Tue, 14 Jun 2016 05:49:08 -0700
Message-ID: <20160614124908.GA16521@kwestfie-linux.qualcomm.com>
References: <1465893003-12477-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465893003-12477-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465893003-12477-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Patrick Lai <plai@codeaurora.org>, kwestfie@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2016 at 09:30:03AM +0100, Srinivas Kandagatla wrote:
> Move dma channel allocations to pcmops open and close functions. Reason
> to do this is that, lpass_platform_pcm_free() accesses snd_soc_pcm_runtime
> via substream->private data, However By this time runtimes are already
> freed as part of soc_cleanup_card_resources() sequence.
> 
> This patch moves the channel allocations/deallocations to pcmops open()
> and close() respectively, where the code has valid snd_soc_pcm_runtime.

> ---
>  sound/soc/qcom/lpass-platform.c | 155 +++++++++++++++++++---------------------
>  1 file changed, 74 insertions(+), 81 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index db000c6..3bd2cd6 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -61,7 +61,36 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)

> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			pcm_data->rdma_ch = ch;
> +			reg =  LPAIF_RDMACTL_REG(v, ch);

Spacing.

> +		} else {
> +			pcm_data->wrdma_ch = ch;
> +			reg =  LPAIF_WRDMACTL_REG(v, ch);

Spacing.

> +static int lpass_platform_pcmops_close(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
> +	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
> +	struct lpass_data *drvdata =
> +		snd_soc_platform_get_drvdata(soc_runtime->platform);
> +	struct lpass_variant *v = drvdata->variant;
> +	int ch;
> +
> +	if (v->free_dma_channel) {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			ch = pcm_data->rdma_ch;
> +		else
> +			ch = pcm_data->wrdma_ch;
> +
> +		if (ch >= 0)
> +			v->free_dma_channel(drvdata, ch);
> +	}

Since this is being moved from free() to close(), drvdata->substream[ch]
should be set to NULL.  Otherwise, the array could fill up as the PCM is
opened/closed.

> @@ -471,14 +529,12 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
>  	struct snd_pcm *pcm = soc_runtime->pcm;
>  	struct snd_pcm_substream *psubstream, *csubstream;
>  	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
> -	struct lpass_data *drvdata =
> -		snd_soc_platform_get_drvdata(soc_runtime->platform);
> -	struct lpass_variant *v = drvdata->variant;
> -	int ret = -EINVAL;
> +	struct device *dev = soc_runtime->platform->dev;
>  	struct lpass_pcm_data *data;
>  	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
> +	int ret = -EINVAL;
>  
> -	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);

Is the reason for changing the dev pointer similar to why it was changed
for snd_dma_alloc_pages() below?

> +		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
> +					  &psubstream->dma_buffer);
>  		if (ret) {
> -			dev_err(soc_runtime->dev,
> -				"%s() error writing to rdmactl reg: %d\n",
> -				__func__, ret);
> -			goto capture_alloc_err;
> +			dev_err(dev, "can't alloc playback dma buffer\n");

Print the return value.

> +		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
> +					  &csubstream->dma_buffer);
>  		if (ret) {
> -			dev_err(soc_runtime->dev,
> -				"%s() error writing to wrdmactl reg: %d\n",
> -				__func__, ret);
> -			goto capture_reg_err;
> +			dev_err(dev, "can't alloc capture dma buffer\n");

Ditto.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
