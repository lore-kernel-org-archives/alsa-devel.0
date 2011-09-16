From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH 3/7] ASoC: edb93xx: convert to use
 snd_soc_register_card()
Date: Fri, 16 Sep 2011 18:45:55 +0200
Message-ID: <1316191555.17769.2.camel@r60e>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<0fef3fd00e8cdb8a606f4a81ad4e7f2b7014621c.1315732452.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward12.mail.yandex.net (forward12.mail.yandex.net
	[95.108.130.94]) by alsa0.perex.cz (Postfix) with ESMTP id 91376243B5
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:46:01 +0200 (CEST)
In-Reply-To: <0fef3fd00e8cdb8a606f4a81ad4e7f2b7014621c.1315732452.git.mika.westerberg@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: alsa-devel@alsa-project.org, rmallon@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hello, Mika!

Have you tried the driver on reference boards?
For me it doesn't work any more. Boot messages are ok, as before, but
alsa open produces such messages:
Jan  1 00:32:19 IPCUn user.err kernel: asoc: can't open platform
ep93xx-pcm-audio

and fails.
I'll try to investigate further...

On Sun, 2011-09-11 at 12:28 +0300, Mika Westerberg wrote:
> Current method for machine driver to register with the ASoC core is to use
> snd_soc_register_card() instead of creating a "soc-audio" platform device.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Alexander Sverdlin <subaparts@yandex.ru>
> ---
>  sound/soc/ep93xx/edb93xx.c |   60 ++++++++++++++++++++++++-------------------
>  1 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/edb93xx.c b/sound/soc/ep93xx/edb93xx.c
> index d3aa151..0134d4e 100644
> --- a/sound/soc/ep93xx/edb93xx.c
> +++ b/sound/soc/ep93xx/edb93xx.c
> @@ -28,12 +28,6 @@
>  #include <mach/hardware.h>
>  #include "ep93xx-pcm.h"
>  
> -#define edb93xx_has_audio() (machine_is_edb9301() ||	\
> -			     machine_is_edb9302() ||	\
> -			     machine_is_edb9302a() ||	\
> -			     machine_is_edb9307a() ||	\
> -			     machine_is_edb9315a())
> -
>  static int edb93xx_hw_params(struct snd_pcm_substream *substream,
>  			     struct snd_pcm_hw_params *params)
>  {
> @@ -94,49 +88,61 @@ static struct snd_soc_card snd_soc_edb93xx = {
>  	.num_links	= 1,
>  };
>  
> -static struct platform_device *edb93xx_snd_device;
> -
> -static int __init edb93xx_init(void)
> +static int __devinit edb93xx_probe(struct platform_device *pdev)
>  {
> +	struct snd_soc_card *card = &snd_soc_edb93xx;
>  	int ret;
>  
> -	if (!edb93xx_has_audio())
> -		return -ENODEV;
> -
>  	ret = ep93xx_i2s_acquire(EP93XX_SYSCON_DEVCFG_I2SONAC97,
>  				 EP93XX_SYSCON_I2SCLKDIV_ORIDE |
>  				 EP93XX_SYSCON_I2SCLKDIV_SPOL);
>  	if (ret)
>  		return ret;
>  
> -	edb93xx_snd_device = platform_device_alloc("soc-audio", -1);
> -	if (!edb93xx_snd_device) {
> -		ret = -ENOMEM;
> -		goto free_i2s;
> +	card->dev = &pdev->dev;
> +
> +	ret = snd_soc_register_card(card);
> +	if (ret) {
> +		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
> +			ret);
> +		ep93xx_i2s_release();
>  	}
>  
> -	platform_set_drvdata(edb93xx_snd_device, &snd_soc_edb93xx);
> -	ret = platform_device_add(edb93xx_snd_device);
> -	if (ret)
> -		goto device_put;
> +	return ret;
> +}
>  
> -	return 0;
> +static int __devexit edb93xx_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
>  
> -device_put:
> -	platform_device_put(edb93xx_snd_device);
> -free_i2s:
> +	snd_soc_unregister_card(card);
>  	ep93xx_i2s_release();
> -	return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver edb93xx_driver = {
> +	.driver		= {
> +		.name	= "edb93xx-audio",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= edb93xx_probe,
> +	.remove		= __devexit_p(edb93xx_remove),
> +};
> +
> +static int __init edb93xx_init(void)
> +{
> +	return platform_driver_register(&edb93xx_driver);
>  }
>  module_init(edb93xx_init);
>  
>  static void __exit edb93xx_exit(void)
>  {
> -	platform_device_unregister(edb93xx_snd_device);
> -	ep93xx_i2s_release();
> +	platform_driver_unregister(&edb93xx_driver);
>  }
>  module_exit(edb93xx_exit);
>  
>  MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
>  MODULE_DESCRIPTION("ALSA SoC EDB93xx");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:edb93xx-audio");
