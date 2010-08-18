From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 02/14] ASoC: multi-component - Atmel
	Platform
Date: Wed, 18 Aug 2010 11:28:51 +0200
Message-ID: <4C6BA7D3.9020704@atmel.com>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
	<1281516393-6060-3-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E8262447C
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 11:29:08 +0200 (CEST)
In-Reply-To: <1281516393-6060-3-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Le 11/08/2010 10:46, Liam Girdwood :
> Update the Atmel platform and machines to new multi-component model.
> 
> This patch changes the machine drivers for multi-component as follows :-
> 
>  o Removed socdev
>  o Each DAI link entry now contains platform and codec fields.
>  o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.
> 
> This patch also changes the DAI and platform DAM drivers as follows :-
> 
>  o Each platform DAI and platform DMA driver is a kernel device and can
>    have platform data.
>  o DAI and Platform DMA drivers have private data accessors.
> 
> Other notable changes required for multi-component support:-
> 
>  o Moved ssc_request() from mach drivers.
>  o WM8510 codec data must now passed in via platform data.
> 
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  sound/soc/atmel/atmel-pcm.c        |   59 +++++++++++++---------
>  sound/soc/atmel/atmel-pcm.h        |    3 -
>  sound/soc/atmel/atmel_ssc_dai.c    |   97 ++++++++++++++++++++++++++---------
>  sound/soc/atmel/atmel_ssc_dai.h    |    1 -
>  sound/soc/atmel/playpaq_wm8510.c   |   65 +++++-------------------
>  sound/soc/atmel/sam9g20_wm8731.c   |   51 ++++---------------
>  sound/soc/atmel/snd-soc-afeb9260.c |   35 +++----------
>  7 files changed, 139 insertions(+), 172 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
> index dc5249f..d0e7532 100644
> --- a/sound/soc/atmel/atmel-pcm.c
> +++ b/sound/soc/atmel/atmel-pcm.c
> @@ -179,7 +179,7 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
>  	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
>  	runtime->dma_bytes = params_buffer_bytes(params);
>  
> -	prtd->params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
> +	prtd->params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
>  	prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
>  
>  	prtd->dma_buffer = runtime->dma_addr;
> @@ -374,14 +374,14 @@ static int atmel_pcm_new(struct snd_card *card,
>  	if (!card->dev->coherent_dma_mask)
>  		card->dev->coherent_dma_mask = 0xffffffff;
>  
> -	if (dai->playback.channels_min) {
> +	if (dai->driver->playback.channels_min) {
>  		ret = atmel_pcm_preallocate_dma_buffer(pcm,
>  			SNDRV_PCM_STREAM_PLAYBACK);
>  		if (ret)
>  			goto out;
>  	}
>  
> -	if (dai->capture.channels_min) {
> +	if (dai->driver->capture.channels_min) {
>  		pr_debug("at32-pcm:"
>  				"Allocating PCM capture DMA buffer\n");
>  		ret = atmel_pcm_preallocate_dma_buffer(pcm,
> @@ -414,12 +414,9 @@ static void atmel_pcm_free_dma_buffers(struct snd_pcm *pcm)
>  }
>  
>  #ifdef CONFIG_PM
> -static int atmel_pcm_suspend(struct snd_soc_dai_link *dai_link)
> +static int atmel_pcm_suspend(struct snd_soc_dai *dai)
>  {
> -	struct snd_pcm *pcm = dai_link->pcm;
> -	struct snd_pcm_str *stream = &pcm->streams[0];
> -	struct snd_pcm_substream *substream = stream->substream;
> -	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_pcm_runtime *runtime = dai->runtime;
>  	struct atmel_runtime_data *prtd;
>  	struct atmel_pcm_dma_params *params;
>  
> @@ -441,12 +438,9 @@ static int atmel_pcm_suspend(struct snd_soc_dai_link *dai_link)
>  	return 0;
>  }
>  
> -static int atmel_pcm_resume(struct snd_soc_dai_link *dai_link)
> +static int atmel_pcm_resume(struct snd_soc_dai *dai)
>  {
> -	struct snd_pcm *pcm = dai_link->pcm;
> -	struct snd_pcm_str *stream = &pcm->streams[0];
> -	struct snd_pcm_substream *substream = stream->substream;
> -	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_pcm_runtime *runtime = dai->runtime;
>  	struct atmel_runtime_data *prtd;
>  	struct atmel_pcm_dma_params *params;
>  
> @@ -470,27 +464,46 @@ static int atmel_pcm_resume(struct snd_soc_dai_link *dai_link)
>  #define atmel_pcm_resume	NULL
>  #endif
>  
> -struct snd_soc_platform atmel_soc_platform = {
> -	.name		= "atmel-audio",
> -	.pcm_ops 	= &atmel_pcm_ops,
> +static struct snd_soc_platform_driver atmel_soc_platform = {
> +	.ops		= &atmel_pcm_ops,
>  	.pcm_new	= atmel_pcm_new,
>  	.pcm_free	= atmel_pcm_free_dma_buffers,
>  	.suspend	= atmel_pcm_suspend,
>  	.resume		= atmel_pcm_resume,
>  };
> -EXPORT_SYMBOL_GPL(atmel_soc_platform);
>  
> -static int __init atmel_pcm_modinit(void)
> +static int __devinit atmel_soc_platform_probe(struct platform_device *pdev)
> +{
> +	return snd_soc_register_platform(&pdev->dev, &atmel_soc_platform);
> +}
> +
> +static int __devexit atmel_soc_platform_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_platform(&pdev->dev);
> +	return 0;
> +}
> +
> +static struct platform_driver atmel_pcm_driver = {
> +	.driver = {
> +			.name = "atmel-pcm-audio",
> +			.owner = THIS_MODULE,
> +	},
> +
> +	.probe = atmel_soc_platform_probe,
> +	.remove = __devexit_p(atmel_soc_platform_remove),
> +};
> +
> +static int __init snd_atmel_pcm_init(void)
>  {
> -	return snd_soc_register_platform(&atmel_soc_platform);
> +	return platform_driver_register(&atmel_pcm_driver);
>  }
> -module_init(atmel_pcm_modinit);
> +module_init(snd_atmel_pcm_init);
>  
> -static void __exit atmel_pcm_modexit(void)
> +static void __exit snd_atmel_pcm_exit(void)
>  {
> -	snd_soc_unregister_platform(&atmel_soc_platform);
> +	platform_driver_unregister(&atmel_pcm_driver);
>  }
> -module_exit(atmel_pcm_modexit);
> +module_exit(snd_atmel_pcm_exit);
>  
>  MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
>  MODULE_DESCRIPTION("Atmel PCM module");
> diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
> index ec9b282..2597329 100644
> --- a/sound/soc/atmel/atmel-pcm.h
> +++ b/sound/soc/atmel/atmel-pcm.h
> @@ -74,9 +74,6 @@ struct atmel_pcm_dma_params {
>  	void (*dma_intr_handler)(u32, struct snd_pcm_substream *);
>  };
>  
> -extern struct snd_soc_platform atmel_soc_platform;
> -
> -
>  /*
>   * SSC register access (since ssc_writel() / ssc_readl() require literal name)
>   */
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index c85844d..eabf66a 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -205,8 +205,7 @@ static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
>  static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>  			     struct snd_soc_dai *dai)
>  {
> -	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
> -	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
> +	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
>  	int dir_mask;
>  
>  	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
> @@ -235,8 +234,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>  static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
>  			       struct snd_soc_dai *dai)
>  {
> -	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
> -	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
> +	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
>  	struct atmel_pcm_dma_params *dma_params;
>  	int dir, dir_mask;
>  
> @@ -338,7 +336,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *dai)
>  {
>  	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
> -	int id = rtd->dai->cpu_dai->id;
> +	int id = dai->id;
>  	struct atmel_ssc_info *ssc_p = &ssc_info[id];
>  	struct atmel_pcm_dma_params *dma_params;
>  	int dir, channels, bits;
> @@ -368,7 +366,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  	 * function.  It should not be used for other purposes
>  	 * as it is common to all substreams.
>  	 */
> -	snd_soc_dai_set_dma_data(rtd->dai->cpu_dai, substream, dma_params);
> +	snd_soc_dai_set_dma_data(rtd->cpu_dai, substream, dma_params);
>  
>  	channels = params_channels(params);
>  
> @@ -605,8 +603,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
>  			     struct snd_soc_dai *dai)
>  {
> -	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
> -	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
> +	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
>  	struct atmel_pcm_dma_params *dma_params;
>  	int dir;
>  
> @@ -690,6 +687,32 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
>  #  define atmel_ssc_resume	NULL
>  #endif /* CONFIG_PM */
>  
> +static int atmel_ssc_probe(struct snd_soc_dai *dai)
> +{
> +	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
> +	int ret = 0;
> +
> +	snd_soc_dai_set_drvdata(dai, ssc_p);
> +
> +	/*
> +	 * Request SSC device
> +	 */
> +	ssc_p->ssc = ssc_request(dai->id);
> +	if (IS_ERR(ssc_p->ssc)) {
> +		printk(KERN_ERR "ASoC: Failed to request SSC %d\n", dai->id);
> +		ret = PTR_ERR(ssc_p->ssc);
> +	}
> +
> +	return ret;
> +}
> +
> +static int atmel_ssc_remove(struct snd_soc_dai *dai)
> +{
> +	struct atmel_ssc_info *ssc_p = snd_soc_dai_get_drvdata(dai);
> +
> +	ssc_free(ssc_p->ssc);
> +	return 0;
> +}
>  
>  #define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
>  
> @@ -705,9 +728,11 @@ static struct snd_soc_dai_ops atmel_ssc_dai_ops = {
>  	.set_clkdiv	= atmel_ssc_set_dai_clkdiv,
>  };
>  
> -struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
> -	{	.name = "atmel-ssc0",
> -		.id = 0,
> +static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
> +	{
> +		.name = "atmel-ssc-dai.0",
> +		.probe = atmel_ssc_probe,
> +		.remove = atmel_ssc_remove,
>  		.suspend = atmel_ssc_suspend,
>  		.resume = atmel_ssc_resume,
>  		.playback = {
> @@ -721,11 +746,12 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
>  			.rates = ATMEL_SSC_RATES,
>  			.formats = ATMEL_SSC_FORMATS,},
>  		.ops = &atmel_ssc_dai_ops,
> -		.private_data = &ssc_info[0],
>  	},
>  #if NUM_SSC_DEVICES == 3
> -	{	.name = "atmel-ssc1",
> -		.id = 1,
> +	{
> +		.name = "atmel-ssc-dai.1",
> +		.probe = atmel_ssc_probe,
> +		.remove = atmel_ssc_remove,
>  		.suspend = atmel_ssc_suspend,
>  		.resume = atmel_ssc_resume,
>  		.playback = {
> @@ -739,10 +765,11 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
>  			.rates = ATMEL_SSC_RATES,
>  			.formats = ATMEL_SSC_FORMATS,},
>  		.ops = &atmel_ssc_dai_ops,
> -		.private_data = &ssc_info[1],
>  	},
> -	{	.name = "atmel-ssc2",
> -		.id = 2,
> +	{
> +		.name = "atmel-ssc-dai.2",
> +		.probe = atmel_ssc_probe,
> +		.remove = atmel_ssc_remove,
>  		.suspend = atmel_ssc_suspend,
>  		.resume = atmel_ssc_resume,
>  		.playback = {
> @@ -756,23 +783,43 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
>  			.rates = ATMEL_SSC_RATES,
>  			.formats = ATMEL_SSC_FORMATS,},
>  		.ops = &atmel_ssc_dai_ops,
> -		.private_data = &ssc_info[2],
>  	},
>  #endif
>  };
> -EXPORT_SYMBOL_GPL(atmel_ssc_dai);
>  
> -static int __init atmel_ssc_modinit(void)
> +static __devinit int asoc_ssc_probe(struct platform_device *pdev)
> +{
> +	return snd_soc_register_dais(&pdev->dev, atmel_ssc_dai,
> +			ARRAY_SIZE(atmel_ssc_dai));
> +}
> +
> +static int __devexit asoc_ssc_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(atmel_ssc_dai));
> +	return 0;
> +}
> +
> +static struct platform_driver asoc_ssc_driver = {
> +	.driver = {
> +			.name = "atmel-ssc-dai",
> +			.owner = THIS_MODULE,
> +	},
> +
> +	.probe = asoc_ssc_probe,
> +	.remove = __devexit_p(asoc_ssc_remove),
> +};
> +
> +static int __init snd_atmel_ssc_init(void)
>  {
> -	return snd_soc_register_dais(atmel_ssc_dai, ARRAY_SIZE(atmel_ssc_dai));
> +	return platform_driver_register(&asoc_ssc_driver);
>  }
> -module_init(atmel_ssc_modinit);
> +module_init(snd_atmel_ssc_init);
>  
> -static void __exit atmel_ssc_modexit(void)
> +static void __exit snd_atmel_ssc_exit(void)
>  {
> -	snd_soc_unregister_dais(atmel_ssc_dai, ARRAY_SIZE(atmel_ssc_dai));
> +	platform_driver_unregister(&asoc_ssc_driver);
>  }
> -module_exit(atmel_ssc_modexit);
> +module_exit(snd_atmel_ssc_exit);
>  
>  /* Module information */
>  MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");
> diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
> index 391135f..392a469 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.h
> +++ b/sound/soc/atmel/atmel_ssc_dai.h
> @@ -116,6 +116,5 @@ struct atmel_ssc_info {
>  	struct atmel_pcm_dma_params *dma_params[2];
>  	struct atmel_ssc_state ssc_state;
>  };
> -extern struct snd_soc_dai atmel_ssc_dai[];
>  
>  #endif /* _AT91_SSC_DAI_H */
> diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
> index 9df4c68..5f4e59f 100644
> --- a/sound/soc/atmel/playpaq_wm8510.c
> +++ b/sound/soc/atmel/playpaq_wm8510.c
> @@ -83,7 +83,7 @@ static struct ssc_clock_data playpaq_wm8510_calc_ssc_clock(
>  	struct snd_pcm_hw_params *params,
>  	struct snd_soc_dai *cpu_dai)
>  {
> -	struct at32_ssc_info *ssc_p = cpu_dai->private_data;
> +	struct at32_ssc_info *ssc_p = snd_soc_dai_get_drvdata(cpu_dai);
>  	struct ssc_device *ssc = ssc_p->ssc;
>  	struct ssc_clock_data cd;
>  	unsigned int rate, width_bits, channels;
> @@ -131,9 +131,9 @@ static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
>  				    struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> -	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> -	struct at32_ssc_info *ssc_p = cpu_dai->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct at32_ssc_info *ssc_p = snd_soc_dai_get_drvdata(cpu_dai);
>  	struct ssc_device *ssc = ssc_p->ssc;
>  	unsigned int pll_out = 0, bclk = 0, mclk_div = 0;
>  	int ret;
> @@ -315,8 +315,9 @@ static const struct snd_soc_dapm_route intercon[] = {
>  
>  
>  
> -static int playpaq_wm8510_init(struct snd_soc_codec *codec)
> +static int playpaq_wm8510_init(struct snd_soc_pcm_runtime *rtd)
>  {
> +	struct snd_soc_codec *codec = rtd->codec;
>  	int i;
>  
>  	/*
> @@ -342,7 +343,7 @@ static int playpaq_wm8510_init(struct snd_soc_codec *codec)
>  
>  
>  	/* Make CSB show PLL rate */
> -	snd_soc_dai_set_clkdiv(codec->dai, WM8510_OPCLKDIV,
> +	snd_soc_dai_set_clkdiv(rtd->codec_dai, WM8510_OPCLKDIV,
>  				       WM8510_OPCLKDIV_1 | 4);
>  
>  	return 0;
> @@ -353,8 +354,10 @@ static int playpaq_wm8510_init(struct snd_soc_codec *codec)
>  static struct snd_soc_dai_link playpaq_wm8510_dai = {
>  	.name = "WM8510",
>  	.stream_name = "WM8510 PCM",
> -	.cpu_dai = &at32_ssc_dai[0],
> -	.codec_dai = &wm8510_dai,
> +	.cpu_dai_name= "atmel-ssc-dai.0",
> +	.platform_name = "atmel-pcm-audio",
> +	.codec_name = "wm8510-codec.0-0x1a",
> +	.codec_dai_name = "wm8510-hifi",
>  	.init = playpaq_wm8510_init,
>  	.ops = &playpaq_wm8510_ops,
>  };
> @@ -363,46 +366,16 @@ static struct snd_soc_dai_link playpaq_wm8510_dai = {
>  
>  static struct snd_soc_card snd_soc_playpaq = {
>  	.name = "LRS_PlayPaq_WM8510",
> -	.platform = &at32_soc_platform,
>  	.dai_link = &playpaq_wm8510_dai,
>  	.num_links = 1,
>  };
>  
> -
> -
> -static struct wm8510_setup_data playpaq_wm8510_setup = {
> -	.i2c_bus = 0,
> -	.i2c_address = 0x1a,
> -};
> -
> -
> -
> -static struct snd_soc_device playpaq_wm8510_snd_devdata = {
> -	.card = &snd_soc_playpaq,
> -	.codec_dev = &soc_codec_dev_wm8510,
> -	.codec_data = &playpaq_wm8510_setup,
> -};
> -
>  static struct platform_device *playpaq_snd_device;
>  
>  
>  static int __init playpaq_asoc_init(void)
>  {
>  	int ret = 0;
> -	struct at32_ssc_info *ssc_p = playpaq_wm8510_dai.cpu_dai->private_data;
> -	struct ssc_device *ssc = NULL;
> -
> -
> -	/*
> -	 * Request SSC device
> -	 */
> -	ssc = ssc_request(0);
> -	if (IS_ERR(ssc)) {
> -		ret = PTR_ERR(ssc);
> -		goto err_ssc;
> -	}
> -	ssc_p->ssc = ssc;
> -
>  
>  	/*
>  	 * Configure MCLK for WM8510
> @@ -439,8 +412,7 @@ static int __init playpaq_asoc_init(void)
>  		goto err_device_alloc;
>  	}
>  
> -	platform_set_drvdata(playpaq_snd_device, &playpaq_wm8510_snd_devdata);
> -	playpaq_wm8510_snd_devdata.dev = &playpaq_snd_device->dev;
> +	platform_set_drvdata(playpaq_snd_device, &snd_soc_playpaq);
>  
>  	ret = platform_device_add(playpaq_snd_device);
>  	if (ret) {
> @@ -468,25 +440,12 @@ err_pll0:
>  		clk_put(_gclk0);
>  		_gclk0 = NULL;
>  	}
> -err_gclk0:
> -	ssc_free(ssc);
> -err_ssc:
>  	return ret;
>  }
>  
>  
>  static void __exit playpaq_asoc_exit(void)
>  {
> -	struct at32_ssc_info *ssc_p = playpaq_wm8510_dai.cpu_dai->private_data;
> -	struct ssc_device *ssc;
> -
> -	if (ssc_p != NULL) {
> -		ssc = ssc_p->ssc;
> -		if (ssc != NULL)
> -			ssc_free(ssc);
> -		ssc_p->ssc = NULL;
> -	}
> -
>  	if (_gclk0 != NULL) {
>  		clk_put(_gclk0);
>  		_gclk0 = NULL;
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index e028744..cf9f6c9 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -69,8 +69,8 @@ static int at91sam9g20ek_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> -	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	int ret;
>  
>  	/* set codec DAI configuration */
> @@ -136,9 +136,10 @@ static const struct snd_soc_dapm_route intercon[] = {
>  /*
>   * Logic for a wm8731 as connected on a at91sam9g20ek board.
>   */
> -static int at91sam9g20ek_wm8731_init(struct snd_soc_codec *codec)
> +static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
>  {
> -	struct snd_soc_dai *codec_dai = &codec->dai[0];
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>  	int ret;
>  
>  	printk(KERN_DEBUG
> @@ -179,31 +180,25 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_codec *codec)
>  static struct snd_soc_dai_link at91sam9g20ek_dai = {
>  	.name = "WM8731",
>  	.stream_name = "WM8731 PCM",
> -	.cpu_dai = &atmel_ssc_dai[0],
> -	.codec_dai = &wm8731_dai,
> +	.cpu_dai_name = "atmel-ssc-dai.0",
> +	.codec_dai_name = "wm8731-hifi",
>  	.init = at91sam9g20ek_wm8731_init,
> +	.platform_name = "atmel_pcm-audio",
> +	.codec_name = "wm8731-codec.0-0x1a",
>  	.ops = &at91sam9g20ek_ops,
>  };
>  
>  static struct snd_soc_card snd_soc_at91sam9g20ek = {
>  	.name = "AT91SAMG20-EK",
> -	.platform = &atmel_soc_platform,
>  	.dai_link = &at91sam9g20ek_dai,
>  	.num_links = 1,
>  	.set_bias_level = at91sam9g20ek_set_bias_level,
>  };
>  
> -static struct snd_soc_device at91sam9g20ek_snd_devdata = {
> -	.card = &snd_soc_at91sam9g20ek,
> -	.codec_dev = &soc_codec_dev_wm8731,
> -};
> -
>  static struct platform_device *at91sam9g20ek_snd_device;
>  
>  static int __init at91sam9g20ek_init(void)
>  {
> -	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
> -	struct ssc_device *ssc = NULL;
>  	struct clk *pllb;
>  	int ret;
>  
> @@ -235,18 +230,6 @@ static int __init at91sam9g20ek_init(void)
>  
>  	clk_set_rate(mclk, MCLK_RATE);
>  
> -	/*
> -	 * Request SSC device
> -	 */
> -	ssc = ssc_request(0);
> -	if (IS_ERR(ssc)) {
> -		printk(KERN_ERR "ASoC: Failed to request SSC 0\n");
> -		ret = PTR_ERR(ssc);
> -		ssc = NULL;
> -		goto err_ssc;
> -	}
> -	ssc_p->ssc = ssc;
> -
>  	at91sam9g20ek_snd_device = platform_device_alloc("soc-audio", -1);
>  	if (!at91sam9g20ek_snd_device) {
>  		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
> @@ -254,8 +237,7 @@ static int __init at91sam9g20ek_init(void)
>  	}
>  
>  	platform_set_drvdata(at91sam9g20ek_snd_device,
> -			&at91sam9g20ek_snd_devdata);
> -	at91sam9g20ek_snd_devdata.dev = &at91sam9g20ek_snd_device->dev;
> +			&snd_soc_at91sam9g20ek);
>  
>  	ret = platform_device_add(at91sam9g20ek_snd_device);
>  	if (ret) {
> @@ -265,9 +247,6 @@ static int __init at91sam9g20ek_init(void)
>  
>  	return ret;
>  
> -err_ssc:
> -	ssc_free(ssc);
> -	ssc_p->ssc = NULL;
>  err_mclk:
>  	clk_put(mclk);
>  	mclk = NULL;
> @@ -277,16 +256,6 @@ err:
>  
>  static void __exit at91sam9g20ek_exit(void)
>  {
> -	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
> -	struct ssc_device *ssc;
> -
> -	if (ssc_p != NULL) {
> -		ssc = ssc_p->ssc;
> -		if (ssc != NULL)
> -			ssc_free(ssc);
> -		ssc_p->ssc = NULL;
> -	}
> -
>  	platform_device_unregister(at91sam9g20ek_snd_device);
>  	at91sam9g20ek_snd_device = NULL;
>  	clk_put(mclk);
> diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
> index 23349de..e3d2835 100644
> --- a/sound/soc/atmel/snd-soc-afeb9260.c
> +++ b/sound/soc/atmel/snd-soc-afeb9260.c
> @@ -46,8 +46,8 @@ static int afeb9260_hw_params(struct snd_pcm_substream *substream,
>  			 struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> -	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	int err;
>  
>  	/* Set codec DAI configuration */
> @@ -102,8 +102,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
>  	{"MICIN", NULL, "Mic Jack"},
>  };
>  
> -static int afeb9260_tlv320aic23_init(struct snd_soc_codec *codec)
> +static int afeb9260_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
>  {
> +	struct snd_soc_codec *codec = rtd->codec;
>  
>  	/* Add afeb9260 specific widgets */
>  	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
> @@ -125,8 +126,10 @@ static int afeb9260_tlv320aic23_init(struct snd_soc_codec *codec)
>  static struct snd_soc_dai_link afeb9260_dai = {
>  	.name = "TLV320AIC23",
>  	.stream_name = "AIC23",
> -	.cpu_dai = &atmel_ssc_dai[0],
> -	.codec_dai = &tlv320aic23_dai,
> +	.cpu_dai_name = "atmel-ssc-dai.0",
> +	.codec_dai_name = "tlv320aic23-hifi",
> +	.platform_name = "atmel_pcm-audio",
> +	.codec_name = "tlv320aic23-codec.0-0x1a",
>  	.init = afeb9260_tlv320aic23_init,
>  	.ops = &afeb9260_ops,
>  };
> @@ -134,37 +137,20 @@ static struct snd_soc_dai_link afeb9260_dai = {
>  /* Audio machine driver */
>  static struct snd_soc_card snd_soc_machine_afeb9260 = {
>  	.name = "AFEB9260",
> -	.platform = &atmel_soc_platform,
>  	.dai_link = &afeb9260_dai,
>  	.num_links = 1,
>  };
>  
> -/* Audio subsystem */
> -static struct snd_soc_device afeb9260_snd_devdata = {
> -	.card = &snd_soc_machine_afeb9260,
> -	.codec_dev = &soc_codec_dev_tlv320aic23,
> -};
> -
>  static struct platform_device *afeb9260_snd_device;
>  
>  static int __init afeb9260_soc_init(void)
>  {
>  	int err;
>  	struct device *dev;
> -	struct atmel_ssc_info *ssc_p = afeb9260_dai.cpu_dai->private_data;
> -	struct ssc_device *ssc = NULL;
>  
>  	if (!(machine_is_afeb9260()))
>  		return -ENODEV;
>  
> -	ssc = ssc_request(0);
> -	if (IS_ERR(ssc)) {
> -		printk(KERN_ERR "ASoC: Failed to request SSC 0\n");
> -		err = PTR_ERR(ssc);
> -		ssc = NULL;
> -		goto err_ssc;
> -	}
> -	ssc_p->ssc = ssc;
>  
>  	afeb9260_snd_device = platform_device_alloc("soc-audio", -1);
>  	if (!afeb9260_snd_device) {
> @@ -172,8 +158,7 @@ static int __init afeb9260_soc_init(void)
>  		return -ENOMEM;
>  	}
>  
> -	platform_set_drvdata(afeb9260_snd_device, &afeb9260_snd_devdata);
> -	afeb9260_snd_devdata.dev = &afeb9260_snd_device->dev;
> +	platform_set_drvdata(afeb9260_snd_device, &snd_soc_machine_afeb9260);
>  	err = platform_device_add(afeb9260_snd_device);
>  	if (err)
>  		goto err1;
> @@ -184,9 +169,7 @@ static int __init afeb9260_soc_init(void)
>  err1:
>  	platform_device_del(afeb9260_snd_device);
>  	platform_device_put(afeb9260_snd_device);
> -err_ssc:
>  	return err;
> -
>  }
>  
>  static void __exit afeb9260_soc_exit(void)


-- 
Nicolas Ferre
