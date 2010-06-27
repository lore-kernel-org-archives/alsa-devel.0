From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC 12/15] ASoC: multi-component - Cirrus Logic
	ep93xx Platform
Date: Mon, 28 Jun 2010 09:38:23 +1200
Message-ID: <4C27C4CF.3010801@bluewatersys.com>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
	<1277639534-5104-13-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id A7A1624509
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 23:38:17 +0200 (CEST)
In-Reply-To: <1277639534-5104-13-git-send-email-lrg@slimlogic.co.uk>
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

On 06/27/2010 11:52 PM, Liam Girdwood wrote:
> Update the Cirrus Logic EP93xx platform and machines to new multi-component model.
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
>  o Add platform devices for I2S and PCM.
> 
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

Hi Liam,

Where does this patch apply to? The codec-id fix, along with the patch I
just posted for fixing the tlv320aic23 codec, gets the ep93xx/Snapper
CL15 audio working under on your multi-component branch, so this patch
should be fine. Would like to test though.

~Ryan

> ---
>  arch/arm/mach-ep93xx/core.c    |    6 ++++++
>  sound/soc/ep93xx/ep93xx-i2s.c  |   31 +++++++++++++------------------
>  sound/soc/ep93xx/ep93xx-i2s.h  |    2 +-
>  sound/soc/ep93xx/ep93xx-pcm.c  |   35 ++++++++++++++++++++++++++++-------
>  sound/soc/ep93xx/ep93xx-pcm.h  |    2 +-
>  sound/soc/ep93xx/snappercl15.c |   24 +++++++++++-------------
>  6 files changed, 60 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index b4ee540..b5261d4 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -732,9 +732,15 @@ static struct platform_device ep93xx_i2s_device = {
>  	.resource	= ep93xx_i2s_resource,
>  };
>  
> +static struct platform_device ep93xx_pcm_device = {
> +	.name		= "ep93xx-pcm-audio",
> +	.id		= -1,
> +};
> +
>  void __init ep93xx_register_i2s(void)
>  {
>  	platform_device_register(&ep93xx_i2s_device);
> +	platform_device_register(&ep93xx_pcm_device);
>  }
>  
>  #define EP93XX_SYSCON_DEVCFG_I2S_MASK	(EP93XX_SYSCON_DEVCFG_I2SONSSP | \
> diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
> index 00b9466..6e0fa03 100644
> --- a/sound/soc/ep93xx/ep93xx-i2s.c
> +++ b/sound/soc/ep93xx/ep93xx-i2s.c
> @@ -145,8 +145,8 @@ static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
>  			      struct snd_soc_dai *dai)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> -	struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
> +	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  
>  	snd_soc_dai_set_dma_data(cpu_dai, substream,
>  				 &info->dma_params[substream->stream]);
> @@ -156,8 +156,7 @@ static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
>  static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
>  				struct snd_soc_dai *dai)
>  {
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
> +	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
>  
>  	ep93xx_i2s_disable(info, substream->stream);
>  }
> @@ -165,7 +164,7 @@ static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
>  static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  				  unsigned int fmt)
>  {
> -	struct ep93xx_i2s_info *info = cpu_dai->private_data;
> +	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(cpu_dai);
>  	unsigned int clk_cfg, lin_ctrl;
>  
>  	clk_cfg  = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXCLKCFG);
> @@ -242,9 +241,7 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
>  				struct snd_pcm_hw_params *params,
>  				struct snd_soc_dai *dai)
>  {
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> -	struct ep93xx_i2s_info *info = cpu_dai->private_data;
> +	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
>  	unsigned word_len, div, sdiv, lrdiv;
>  	int found = 0, err;
>  
> @@ -302,7 +299,7 @@ out:
>  static int ep93xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
>  				 unsigned int freq, int dir)
>  {
> -	struct ep93xx_i2s_info *info = cpu_dai->private_data;
> +	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(cpu_dai);
>  
>  	if (dir == SND_SOC_CLOCK_IN || clk_id != 0)
>  		return -EINVAL;
> @@ -313,7 +310,7 @@ static int ep93xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
>  #ifdef CONFIG_PM
>  static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
>  {
> -	struct ep93xx_i2s_info *info = dai->private_data;
> +	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
>  
>  	if (!dai->active)
>  		return;
> @@ -324,7 +321,7 @@ static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
>  
>  static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
>  {
> -	struct ep93xx_i2s_info *info = dai->private_data;
> +	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
>  
>  	if (!dai->active)
>  		return;
> @@ -349,9 +346,8 @@ static struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
>  			    SNDRV_PCM_FMTBIT_S24_LE | \
>  			    SNDRV_PCM_FMTBIT_S32_LE)
>  
> -struct snd_soc_dai ep93xx_i2s_dai = {
> +struct snd_soc_dai_driver ep93xx_i2s_dai = {
>  	.name		= "ep93xx-i2s",
> -	.id		= 0,
>  	.symmetric_rates= 1,
>  	.suspend	= ep93xx_i2s_suspend,
>  	.resume		= ep93xx_i2s_resume,
> @@ -383,8 +379,7 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	ep93xx_i2s_dai.dev = &pdev->dev;
> -	ep93xx_i2s_dai.private_data = info;
> +	dev_set_drvdata(&pdev->dev, info);
>  	info->dma_params = ep93xx_i2s_dma_params;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -424,7 +419,7 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
>  		goto fail_put_sclk;
>  	}
>  
> -	err = snd_soc_register_dai(&ep93xx_i2s_dai);
> +	err = snd_soc_register_dai(&pdev->dev, pdev->id, &ep93xx_i2s_dai);
>  	if (err)
>  		goto fail_put_lrclk;
>  
> @@ -447,9 +442,9 @@ fail:
>  
>  static int __devexit ep93xx_i2s_remove(struct platform_device *pdev)
>  {
> -	struct ep93xx_i2s_info *info = ep93xx_i2s_dai.private_data;
> +	struct ep93xx_i2s_info *info = dev_get_drvdata(&pdev->dev);
>  
> -	snd_soc_unregister_dai(&ep93xx_i2s_dai);
> +	snd_soc_unregister_dai(&pdev->dev, pdev->id);
>  	clk_put(info->lrclk);
>  	clk_put(info->sclk);
>  	clk_put(info->mclk);
> diff --git a/sound/soc/ep93xx/ep93xx-i2s.h b/sound/soc/ep93xx/ep93xx-i2s.h
> index 3bd4ebf..2ebe2e2 100644
> --- a/sound/soc/ep93xx/ep93xx-i2s.h
> +++ b/sound/soc/ep93xx/ep93xx-i2s.h
> @@ -13,6 +13,6 @@
>  #ifndef _EP93XX_SND_SOC_I2S_H
>  #define _EP93XX_SND_SOC_I2S_H
>  
> -extern struct snd_soc_dai ep93xx_i2s_dai;
> +extern struct snd_soc_dai_driver ep93xx_i2s_dai;
>  
>  #endif /* _EP93XX_SND_SOC_I2S_H */
> diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
> index 4ba9384..97257ee 100644
> --- a/sound/soc/ep93xx/ep93xx-pcm.c
> +++ b/sound/soc/ep93xx/ep93xx-pcm.c
> @@ -95,7 +95,7 @@ static void ep93xx_pcm_buffer_finished(void *cookie,
>  static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
>  {
>  	struct snd_soc_pcm_runtime *soc_rtd = substream->private_data;
> -	struct snd_soc_dai *cpu_dai = soc_rtd->dai->cpu_dai;
> +	struct snd_soc_dai *cpu_dai = soc_rtd->cpu_dai;
>  	struct ep93xx_pcm_dma_params *dma_params;
>  	struct ep93xx_runtime_data *rtd;    
>  	int ret;
> @@ -276,14 +276,14 @@ static int ep93xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
>  	if (!card->dev->coherent_dma_mask)
>  		card->dev->coherent_dma_mask = 0xffffffff;
>  
> -	if (dai->playback.channels_min) {
> +	if (dai->driver->playback.channels_min) {
>  		ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
>  					SNDRV_PCM_STREAM_PLAYBACK);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	if (dai->capture.channels_min) {
> +	if (dai->driver->capture.channels_min) {
>  		ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
>  					SNDRV_PCM_STREAM_CAPTURE);
>  		if (ret)
> @@ -293,22 +293,43 @@ static int ep93xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
>  	return 0;
>  }
>  
> -struct snd_soc_platform ep93xx_soc_platform = {
> +struct snd_soc_platform_driver ep93xx_soc_platform = {
>  	.name		= "ep93xx-audio",
> -	.pcm_ops	= &ep93xx_pcm_ops,
> +	.ops		= &ep93xx_pcm_ops,
>  	.pcm_new	= &ep93xx_pcm_new,
>  	.pcm_free	= &ep93xx_pcm_free_dma_buffers,
>  };
>  EXPORT_SYMBOL_GPL(ep93xx_soc_platform);
>  
> +static int __devinit ep93xx_soc_platform_probe(struct platform_device *pdev)
> +{
> +	return snd_soc_register_platform(&pdev->dev, -1, &ep93xx_soc_platform);
> +}
> +
> +static int __devexit ep93xx_soc_platform_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_platform(&pdev->dev, -1);
> +	return 0;
> +}
> +
> +static struct platform_driver ep93xx_pcm_driver = {
> +	.driver = {
> +			.name = "ep93xx-pcm-audio",
> +			.owner = THIS_MODULE,
> +	},
> +
> +	.probe = ep93xx_soc_platform_probe,
> +	.remove = __devexit_p(ep93xx_soc_platform_remove),
> +};
> +
>  static int __init ep93xx_soc_platform_init(void)
>  {
> -	return snd_soc_register_platform(&ep93xx_soc_platform);
> +	return platform_driver_register(&ep93xx_pcm_driver);
>  }
>  
>  static void __exit ep93xx_soc_platform_exit(void)
>  {
> -	snd_soc_unregister_platform(&ep93xx_soc_platform);
> +	platform_driver_unregister(&ep93xx_pcm_driver);
>  }
>  
>  module_init(ep93xx_soc_platform_init);
> diff --git a/sound/soc/ep93xx/ep93xx-pcm.h b/sound/soc/ep93xx/ep93xx-pcm.h
> index 4ffdd3f..55b87b6 100644
> --- a/sound/soc/ep93xx/ep93xx-pcm.h
> +++ b/sound/soc/ep93xx/ep93xx-pcm.h
> @@ -17,6 +17,6 @@ struct ep93xx_pcm_dma_params {
>  	int	dma_port;
>  };
>  
> -extern struct snd_soc_platform ep93xx_soc_platform;
> +extern struct snd_soc_platform_driver ep93xx_soc_platform;
>  
>  #endif /* _EP93XX_SND_SOC_PCM_H */
> diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
> index 6495534..e2a6ade 100644
> --- a/sound/soc/ep93xx/snappercl15.c
> +++ b/sound/soc/ep93xx/snappercl15.c
> @@ -30,8 +30,8 @@ static int snappercl15_hw_params(struct snd_pcm_substream *substream,
>  				 struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> -	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	int err;
>  
>  	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> @@ -77,8 +77,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
>  	{"MICIN", NULL, "Mic Jack"},
>  };
>  
> -static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
> +static int snappercl15_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
>  {
> +	struct snd_soc_codec *codec = rtd->codec;
> +
>  	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
>  				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
>  
> @@ -89,24 +91,21 @@ static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
>  static struct snd_soc_dai_link snappercl15_dai = {
>  	.name		= "tlv320aic23",
>  	.stream_name	= "AIC23",
> -	.cpu_dai	= &ep93xx_i2s_dai,
> -	.codec_dai	= &tlv320aic23_dai,
> +	.cpu_dai_drv	= &ep93xx_i2s_dai,
> +	.codec_dai_drv	= &tlv320aic23_dai,
> +	.codec_drv	= &soc_codec_dev_tlv320aic23,
> +	.codec_id	= 0x1a,
> +	.platform_drv	= &ep93xx_soc_platform,
>  	.init		= snappercl15_tlv320aic23_init,
>  	.ops		= &snappercl15_ops,
>  };
>  
>  static struct snd_soc_card snd_soc_snappercl15 = {
>  	.name		= "Snapper CL15",
> -	.platform	= &ep93xx_soc_platform,
>  	.dai_link	= &snappercl15_dai,
>  	.num_links	= 1,
>  };
>  
> -static struct snd_soc_device snappercl15_snd_devdata = {
> -	.card		= &snd_soc_snappercl15,
> -	.codec_dev	= &soc_codec_dev_tlv320aic23,
> -};
> -
>  static struct platform_device *snappercl15_snd_device;
>  
>  static int __init snappercl15_init(void)
> @@ -126,8 +125,7 @@ static int __init snappercl15_init(void)
>  	if (!snappercl15_snd_device)
>  		return -ENOMEM;
>  	
> -	platform_set_drvdata(snappercl15_snd_device, &snappercl15_snd_devdata);
> -	snappercl15_snd_devdata.dev = &snappercl15_snd_device->dev;
> +	platform_set_drvdata(snappercl15_snd_device, &snd_soc_snappercl15);
>  	ret = platform_device_add(snappercl15_snd_device);
>  	if (ret)
>  		platform_device_put(snappercl15_snd_device);


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
