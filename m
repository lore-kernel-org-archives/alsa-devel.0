From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v4 2/4] ARM: DaVinci: ASoC: Introduce
 platform driver model for dm644x, dm355
Date: Fri, 05 Jun 2009 11:34:12 -0700
Message-ID: <4A296524.9050505@boundarydevices.com>
References: <1244197703-30980-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id EE2E32434D
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 20:34:20 +0200 (CEST)
In-Reply-To: <1244197703-30980-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Chaithrika U S wrote:
> Introduce the platform driver model to get platform data for dm355 and dm644x.
> Register platform driver and acquire the resources in the probe function Since
> the platform specific code had been moved from machine driver to dm<soc>.c
> 
> Signed-off-by: Naresh Medisetty <naresh@ti.com>
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> ---
> This patch applies against ALSA mainline - that's the topic/asoc
> branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
>  sound/soc/davinci/davinci-i2s.c |  117 ++++++++++++++++++++++-----------------
>  1 files changed, 67 insertions(+), 50 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
> index b1ea52f..500d2f5 100644
> --- a/sound/soc/davinci/davinci-i2s.c
> +++ b/sound/soc/davinci/davinci-i2s.c
> @@ -436,16 +436,40 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>  	return ret;
>  }
>  
> -static int davinci_i2s_probe(struct platform_device *pdev,
> -			     struct snd_soc_dai *dai)
> +#define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
> +
> +static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
> +	.startup 	= davinci_i2s_startup,
> +	.trigger	= davinci_i2s_trigger,
> +	.hw_params	= davinci_i2s_hw_params,
> +	.set_fmt	= davinci_i2s_set_dai_fmt,
> +
> +};
> +
> +struct snd_soc_dai davinci_i2s_dai = {
> +	.name = "davinci-i2s",
> +	.id = 0,
> +	.playback = {
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = DAVINCI_I2S_RATES,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> +	.capture = {
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = DAVINCI_I2S_RATES,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> +	.ops = &davinci_i2s_dai_ops,
> +
> +};
> +EXPORT_SYMBOL_GPL(davinci_i2s_dai);
> +
> +static int davinci_i2s_probe(struct platform_device *pdev)
>  {
> -	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> -	struct snd_soc_card *card = socdev->card;
> -	struct snd_soc_dai *cpu_dai = card->dai_link->cpu_dai;
> +	struct snd_platform_data *pdata = pdev->dev.platform_data;
>  	struct davinci_mcbsp_dev *dev;
> -	struct resource *mem, *ioarea;
> -	struct evm_snd_platform_data *pdata;
> -	int ret;
> +	struct resource *mem, *ioarea, *res;
> +	int ret = 0;

I would leave this as int ret;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!mem) {
> @@ -466,9 +490,7 @@ static int davinci_i2s_probe(struct platform_device *pdev,
>  		goto err_release_region;
>  	}
>  
> -	cpu_dai->private_data = dev;
> -
> -	dev->clk = clk_get(&pdev->dev, NULL);
> +	dev->clk = clk_get(&pdev->dev, pdata->clk_name);
>  	if (IS_ERR(dev->clk)) {
>  		ret = -ENODEV;
>  		goto err_free_mem;
> @@ -476,18 +498,35 @@ static int davinci_i2s_probe(struct platform_device *pdev,
>  	clk_enable(dev->clk);
>  
>  	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
> -	pdata = pdev->dev.platform_data;
>  
>  	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK] = &davinci_i2s_pcm_out;
> -	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->channel = pdata->tx_dma_ch;
>  	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->dma_addr =
>  	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DXR_REG);
>  
>  	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE] = &davinci_i2s_pcm_in;
> -	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->channel = pdata->rx_dma_ch;
>  	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->dma_addr =
>  	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DRR_REG);
>  
> +	/* first TX, then RX */
> +	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no DMA resource\n");

And set ret = -EIO; or something similar here.

> +		goto err_free_mem;
> +	}
> +	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->channel = res->start;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no DMA resource\n");

And here

> +		goto err_free_mem;
> +	}
> +	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->channel = res->start;
> +
> +	davinci_i2s_dai.private_data = dev;
> +	ret = snd_soc_register_dai(&davinci_i2s_dai);
> +	if (ret != 0)
> +		goto err_free_mem;
> +
>  	return 0;
>  
>  err_free_mem:
> @@ -498,62 +537,40 @@ err_release_region:
>  	return ret;
>  }
>  
> -static void davinci_i2s_remove(struct platform_device *pdev,
> -			       struct snd_soc_dai *dai)
> +static int davinci_i2s_remove(struct platform_device *pdev)
>  {
> -	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> -	struct snd_soc_card *card = socdev->card;
> -	struct snd_soc_dai *cpu_dai = card->dai_link->cpu_dai;
> -	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
> +	struct davinci_mcbsp_dev *dev = davinci_i2s_dai.private_data;
>  	struct resource *mem;
>  
> +	snd_soc_unregister_dai(&davinci_i2s_dai);
>  	clk_disable(dev->clk);
>  	clk_put(dev->clk);
>  	dev->clk = NULL;
> -
>  	kfree(dev);
> -
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, (mem->end - mem->start) + 1);
> -}
>  
> -#define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
> -
> -static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
> -	.startup	= davinci_i2s_startup,
> -	.trigger	= davinci_i2s_trigger,
> -	.hw_params	= davinci_i2s_hw_params,
> -	.set_fmt	= davinci_i2s_set_dai_fmt,
> -};
> +	return 0;
> +}
>  
> -struct snd_soc_dai davinci_i2s_dai = {
> -	.name = "davinci-i2s",
> -	.id = 0,
> -	.probe = davinci_i2s_probe,
> -	.remove = davinci_i2s_remove,
> -	.playback = {
> -		.channels_min = 2,
> -		.channels_max = 2,
> -		.rates = DAVINCI_I2S_RATES,
> -		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> -	.capture = {
> -		.channels_min = 2,
> -		.channels_max = 2,
> -		.rates = DAVINCI_I2S_RATES,
> -		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> -	.ops = &davinci_i2s_dai_ops,
> +static struct platform_driver davinci_mcbsp_driver = {
> +	.probe		= davinci_i2s_probe,
> +	.remove		= davinci_i2s_remove,
> +	.driver		= {
> +		.name	= "davinci-asp",
> +		.owner	= THIS_MODULE,
> +	},
>  };
> -EXPORT_SYMBOL_GPL(davinci_i2s_dai);
>  
>  static int __init davinci_i2s_init(void)
>  {
> -	return snd_soc_register_dai(&davinci_i2s_dai);
> +	return platform_driver_register(&davinci_mcbsp_driver);
>  }
>  module_init(davinci_i2s_init);
>  
>  static void __exit davinci_i2s_exit(void)
>  {
> -	snd_soc_unregister_dai(&davinci_i2s_dai);
> +	platform_driver_unregister(&davinci_mcbsp_driver);
>  }
>  module_exit(davinci_i2s_exit);
>  
