From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: add support for
	unsigned PCM formats
Date: Sun, 28 Aug 2011 18:39:24 +0100
Message-ID: <4E5A7D4C.1030803@ti.com>
References: <1314374564-10291-1-git-send-email-bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8120824388
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Aug 2011 19:39:32 +0200 (CEST)
In-Reply-To: <1314374564-10291-1-git-send-email-bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Nori,
	Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

On 26/08/11 17:02, Ben Gardiner wrote:
> Although the McASP supports sign-extending samples in RX or TX [1]; the
> davinci-mcasp driver does not touch the {R,X}PBIT or {R,X}PAD field of the
> {R,X}FMT registers meaning that the McASP will serialize the bytes it is given
> regardless of their signedness. So supporting unsigned formats is as simple
> as adding them to the metadata of the davinci-mcasp driver.
> 
> Update the FMTBITs reported in the snd_soc_dai_driver and also update the case
> statements in davinci-mcasp's hw_params() function so that the McASP can be
> connected to CODECs that use unsigned values.
> 
> [1] http://www.ti.com/lit/ug/sprufm1/sprufm1.pdf
> 
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>

Acked-by: Liam Girdwood <lrg@ti.com>
> 
> ---
> 
> Tested with a logic analyzer on da850evm where an unsigned 16bit codec was
> registered with the mcasp and a 16bit signed file was played to it. ALSA's
> plug pcm mapped to unsigned and the samples serialized as unsigned 16bit --
> as expected.
> ---
>  sound/soc/davinci/davinci-mcasp.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 8566238..7173df2 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -732,16 +732,19 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
>  		davinci_hw_param(dev, substream->stream);
>  
>  	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_U8:
>  	case SNDRV_PCM_FORMAT_S8:
>  		dma_params->data_type = 1;
>  		word_length = DAVINCI_AUDIO_WORD_8;
>  		break;
>  
> +	case SNDRV_PCM_FORMAT_U16_LE:
>  	case SNDRV_PCM_FORMAT_S16_LE:
>  		dma_params->data_type = 2;
>  		word_length = DAVINCI_AUDIO_WORD_16;
>  		break;
>  
> +	case SNDRV_PCM_FORMAT_U32_LE:
>  	case SNDRV_PCM_FORMAT_S32_LE:
>  		dma_params->data_type = 4;
>  		word_length = DAVINCI_AUDIO_WORD_32;
> @@ -818,6 +821,13 @@ static struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
>  
>  };
>  
> +#define DAVINCI_MCASP_PCM_FMTS (SNDRV_PCM_FMTBIT_S8 | \
> +				SNDRV_PCM_FMTBIT_U8 | \
> +				SNDRV_PCM_FMTBIT_S16_LE | \
> +				SNDRV_PCM_FMTBIT_U16_LE | \
> +				SNDRV_PCM_FMTBIT_S32_LE | \
> +				SNDRV_PCM_FMTBIT_U32_LE)
> +
>  static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
>  	{
>  		.name		= "davinci-mcasp.0",
> @@ -825,17 +835,13 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
>  			.channels_min	= 2,
>  			.channels_max 	= 2,
>  			.rates 		= DAVINCI_MCASP_RATES,
> -			.formats 	= SNDRV_PCM_FMTBIT_S8 |
> -						SNDRV_PCM_FMTBIT_S16_LE |
> -						SNDRV_PCM_FMTBIT_S32_LE,
> +			.formats	= DAVINCI_MCASP_PCM_FMTS,
>  		},
>  		.capture 	= {
>  			.channels_min 	= 2,
>  			.channels_max 	= 2,
>  			.rates 		= DAVINCI_MCASP_RATES,
> -			.formats	= SNDRV_PCM_FMTBIT_S8 |
> -						SNDRV_PCM_FMTBIT_S16_LE |
> -						SNDRV_PCM_FMTBIT_S32_LE,
> +			.formats	= DAVINCI_MCASP_PCM_FMTS,
>  		},
>  		.ops 		= &davinci_mcasp_dai_ops,
>  
> @@ -846,7 +852,7 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
>  			.channels_min	= 1,
>  			.channels_max	= 384,
>  			.rates		= DAVINCI_MCASP_RATES,
> -			.formats	= SNDRV_PCM_FMTBIT_S16_LE,
> +			.formats	= DAVINCI_MCASP_PCM_FMTS,
>  		},
>  		.ops 		= &davinci_mcasp_dai_ops,
>  	},
