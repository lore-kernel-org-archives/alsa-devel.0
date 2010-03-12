From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 2/5] ASoC: DaVinci: Voice Codec Interface
Date: Fri, 12 Mar 2010 08:00:57 +0000
Message-ID: <1268380857.3755.3.camel@odin>
References: <1268321562-18951-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id E26AC24339
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 09:01:08 +0100 (CET)
Received: by bwz20 with SMTP id 20so1920388bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 00:01:08 -0800 (PST)
In-Reply-To: <1268321562-18951-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, nsekhar@ti.com, broonie@opensource.wolfsonmicro.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-11 at 09:32 -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
> This patch adds the support for the interface needed by the DaVinci
> Voice Codec CQ93VC.
> 
> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> ---

snip

> +
> +static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
> +				  struct snd_pcm_hw_params *params,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct davinci_vcif_dev *davinci_vcif_dev = dai->private_data;
> +	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
> +	struct davinci_pcm_dma_params *dma_params =
> +			&davinci_vcif_dev->dma_params[substream->stream];
> +	u32 w;
> +
> +	/* Restart the codec before setup */
> +	davinci_vcif_stop(substream);
> +	davinci_vcif_start(substream);
> +
> +	/* General line settings */
> +	writel(DAVINCI_VC_CTRL_MASK, davinci_vc->base + DAVINCI_VC_CTRL);
> +
> +	writel(DAVINCI_VC_INT_MASK, davinci_vc->base + DAVINCI_VC_INTCLR);
> +
> +	writel(DAVINCI_VC_INT_MASK, davinci_vc->base + DAVINCI_VC_INTEN);
> +
> +	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
> +
> +	/* Determine xfer data type */
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_U8:
> +		dma_params->data_type = 0;
> +
> +		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
> +			    DAVINCI_VC_CTRL_RD_UNSIGNED |
> +			    DAVINCI_VC_CTRL_WD_BITS_8 |
> +			    DAVINCI_VC_CTRL_WD_UNSIGNED, 1);
> +		break;
> +	case SNDRV_PCM_FORMAT_S8:
> +		dma_params->data_type = 1;
> +
> +		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
> +			    DAVINCI_VC_CTRL_WD_BITS_8, 1);
> +
> +		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_UNSIGNED |
> +			    DAVINCI_VC_CTRL_WD_UNSIGNED, 0);
> +		break;
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		dma_params->data_type = 2;
> +
> +		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
> +			    DAVINCI_VC_CTRL_RD_UNSIGNED |
> +			    DAVINCI_VC_CTRL_WD_BITS_8 |
> +			    DAVINCI_VC_CTRL_WD_UNSIGNED, 0);
> +		break;
> +	default:
> +		printk(KERN_WARNING "davinci-vcif: unsupported PCM format");
> +		return -EINVAL;
> +	}
> +
> +	dma_params->acnt  = dma_params->data_type;
> +
> +	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
> +
> +	return 0;
> +}
> +
> +static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int cmd,
> +				struct snd_soc_dai *dai)
> +{
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		davinci_vcif_start(substream);
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		davinci_vcif_stop(substream);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +#define DAVINCI_VCIF_RATES	SNDRV_PCM_RATE_8000_48000
> +
> +static struct snd_soc_dai_ops davinci_vcif_dai_ops = {
> +	.trigger	= davinci_vcif_trigger,
> +	.hw_params	= davinci_vcif_hw_params,
> +};
> +
> +struct snd_soc_dai davinci_vcif_dai = {
> +	.name = "davinci-vcif",
> +	.playback = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		.rates = DAVINCI_VCIF_RATES,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> +	.capture = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		.rates = DAVINCI_VCIF_RATES,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE,},

Your hw_params() supports more formats than just this one.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
