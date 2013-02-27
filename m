From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] davinci-mcasp: Add support for
 multichannel playback
Date: Wed, 27 Feb 2013 17:24:06 +0100
Message-ID: <512E3326.6060900@gmail.com>
References: <1361980429-32000-1-git-send-email-michal.bachraty@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E0C6265378
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 17:24:14 +0100 (CET)
Received: by mail-wg0-f44.google.com with SMTP id dr12so602234wgb.11
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 08:24:14 -0800 (PST)
In-Reply-To: <1361980429-32000-1-git-send-email-michal.bachraty@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Michal,

[You should add a "vX" (v2 in this case) to your patch subject, so they
can be told apart in the review.]

On 27.02.2013 16:53, Michal Bachraty wrote:
> Davinci McASP has support for I2S multichannel playback.
> For I2S playback/receive, each serializer is capable to play 2 channels
> (L/R) audio data.Serializer function (Playback-receive-none) is configured
> in DT, depending on hardware specification. It is possible to play less
> channels than configured in DT. For that purpose,only specific number of
> active serializers are enabled. McASP FIFO need to have DMA transfer Bcnt
> set to number of enabled serializers, otherwise no data are transfered to
> McASP and Alsa generates "DMA/IRQ playback write error (DMA or IRQ trouble?)"
> error.
> 
> Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c |   56 ++++++++++++++++++++++++++++++++-----
>  sound/soc/davinci/davinci-pcm.c   |   16 ++++++-----
>  sound/soc/davinci/davinci-pcm.h   |    1 +
>  3 files changed, 59 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index d2ca682..9f33d90 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -235,6 +235,10 @@
>  #define DISMOD		(val)(val<<2)
>  #define TXSTATE		BIT(4)
>  #define RXSTATE		BIT(5)
> +#define SRMOD_MASK	3
> +#define SRMOD_INACTIVE	0
> +#define SRMOD_TX	1
> +#define SRMOD_RX	2
>  
>  /*
>   * DAVINCI_MCASP_LBCTL_REG - Loop Back Control Register Bits
> @@ -657,12 +661,15 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
>  	return 0;
>  }
>  
> -static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
> +static int davinci_hw_common_param(struct davinci_audio_dev *dev, int stream,
> +				    int channels)
>  {
>  	int i;
>  	u8 tx_ser = 0;
>  	u8 rx_ser = 0;
> -
> +	u8 ser;
> +	u8 slots = dev->tdm_slots;
> +	u8 max_active_serializers = (channels + slots - 1) / slots;

Is there any chance we divide by zero here? If so, we should catch it
before.

>  	/* Default configuration */
>  	mcasp_set_bits(dev->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
>  
> @@ -680,16 +687,42 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
>  	}
>  
>  	for (i = 0; i < dev->num_serializer; i++) {
> +		if (dev->serial_dir[i] == TX_MODE)
> +			tx_ser++;
> +		if (dev->serial_dir[i] == RX_MODE)
> +			rx_ser++;
> +	}
> +
> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		ser = tx_ser;
> +	else
> +		ser = rx_ser;
> +
> +	if (ser < max_active_serializers) {
> +		dev_warn(dev->dev, "stream has more channels (%d) than are "
> +			"enabled in mcasp (%d)\n", channels, ser * slots);

This is really a nitpick here, but there's general consensus about
breaking the rule of 80 columns if necessary for strings. The problem is
that people tend to grep for them, which fails if they span across
multiple lines.

> +		return -EINVAL;
> +	}
> +
> +	tx_ser = 0;
> +	rx_ser = 0;
> +
> +	for (i = 0; i < dev->num_serializer; i++) {
>  		mcasp_set_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
>  					dev->serial_dir[i]);
> -		if (dev->serial_dir[i] == TX_MODE) {
> +		if (dev->serial_dir[i] == TX_MODE &&
> +					tx_ser < max_active_serializers) {
>  			mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
>  					AXR(i));
>  			tx_ser++;
> -		} else if (dev->serial_dir[i] == RX_MODE) {
> +		} else if (dev->serial_dir[i] == RX_MODE &&
> +					rx_ser < max_active_serializers) {
>  			mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
>  					AXR(i));
>  			rx_ser++;
> +		} else {
> +			mcasp_mod_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
> +					SRMOD_INACTIVE, SRMOD_MASK);
>  		}
>  	}
>  
> @@ -729,6 +762,8 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
>  				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
> @@ -812,8 +847,14 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
>  					&dev->dma_params[substream->stream];
>  	int word_length;
>  	u8 fifo_level;
> +	u8 slots = dev->tdm_slots;
> +	int channels;
> +	struct snd_interval *pcm_channels = hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_CHANNELS);
> +	channels = pcm_channels->min;
>  
> -	davinci_hw_common_param(dev, substream->stream);
> +	if (davinci_hw_common_param(dev, substream->stream, channels))
> +		return -EINVAL;

Generally, you should catch the return value from the failed function
and return this one instead, not blindly -EINVAL. It doesn't really
matter in this case, but maybe davinci_hw_common_param() will return
something else in the future, you never know.

Other than that, the patch looks good to me. Will test it on real
hardware within the next days and let you know.



Thanks,
Daniel


>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>  		fifo_level = dev->txnumevt;
>  	else
> @@ -862,6 +903,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
>  		dma_params->acnt = dma_params->data_type;
>  
>  	dma_params->fifo_level = fifo_level;
> +	dma_params->active_serializers = (channels + slots - 1) / slots;
>  	davinci_config_channel_size(dev, word_length);
>  
>  	return 0;
> @@ -936,13 +978,13 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
>  		.name		= "davinci-mcasp.0",
>  		.playback	= {
>  			.channels_min	= 2,
> -			.channels_max 	= 2,
> +			.channels_max	= 8,
>  			.rates 		= DAVINCI_MCASP_RATES,
>  			.formats	= DAVINCI_MCASP_PCM_FMTS,
>  		},
>  		.capture 	= {
>  			.channels_min 	= 2,
> -			.channels_max 	= 2,
> +			.channels_max	= 8,
>  			.rates 		= DAVINCI_MCASP_RATES,
>  			.formats	= DAVINCI_MCASP_PCM_FMTS,
>  		},
> diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
> index bb57552..3af8b50 100644
> --- a/sound/soc/davinci/davinci-pcm.c
> +++ b/sound/soc/davinci/davinci-pcm.c
> @@ -182,6 +182,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  	unsigned short acnt;
>  	unsigned int count;
>  	unsigned int fifo_level;
> +	unsigned char serializers = prtd->params->active_serializers;
>  
>  	period_size = snd_pcm_lib_period_bytes(substream);
>  	dma_offset = prtd->period * period_size;
> @@ -195,14 +196,14 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  	data_type = prtd->params->data_type;
>  	count = period_size / data_type;
>  	if (fifo_level)
> -		count /= fifo_level;
> +		count /= fifo_level * serializers;
>  
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  		src = dma_pos;
>  		dst = prtd->params->dma_addr;
>  		src_bidx = data_type;
> -		dst_bidx = 0;
> -		src_cidx = data_type * fifo_level;
> +		dst_bidx = 4;
> +		src_cidx = data_type * fifo_level * serializers;
>  		dst_cidx = 0;
>  	} else {
>  		src = prtd->params->dma_addr;
> @@ -210,7 +211,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  		src_bidx = 0;
>  		dst_bidx = data_type;
>  		src_cidx = 0;
> -		dst_cidx = data_type * fifo_level;
> +		dst_cidx = data_type * fifo_level * serializers;
>  	}
>  
>  	acnt = prtd->params->acnt;
> @@ -224,9 +225,10 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  		edma_set_transfer_params(prtd->asp_link[0], acnt, count, 1, 0,
>  							ASYNC);
>  	else
> -		edma_set_transfer_params(prtd->asp_link[0], acnt, fifo_level,
> -							count, fifo_level,
> -							ABSYNC);
> +		edma_set_transfer_params(prtd->asp_link[0], acnt,
> +						fifo_level * serializers,
> +						count, fifo_level * serializers,
> +						ABSYNC);
>  }
>  
>  static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
> diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
> index fbb710c..0d84d32 100644
> --- a/sound/soc/davinci/davinci-pcm.h
> +++ b/sound/soc/davinci/davinci-pcm.h
> @@ -27,6 +27,7 @@ struct davinci_pcm_dma_params {
>  	unsigned char data_type;	/* xfer data type */
>  	unsigned char convert_mono_stereo;
>  	unsigned int fifo_level;
> +	unsigned char active_serializers; /* num. of active audio serializers */
>  };
>  
>  int davinci_soc_platform_register(struct device *dev);
> 
