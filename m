From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 8/8] ASoC: phycore-ac97: fix resource leak
Date: Thu, 25 Nov 2010 10:19:31 +0100
Message-ID: <20101125091931.GU6017@pengutronix.de>
References: <1290668785.30158.7.camel@mola> <1290669243.30158.22.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A4ABE103BC4
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 10:19:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290669243.30158.22.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 25, 2010 at 03:14:03PM +0800, Axel Lin wrote:
> Fix imx_phycore_init() error path and imx_phycore_exit() to properly free
> allocated resources.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  sound/soc/imx/phycore-ac97.c |   28 +++++++++++++++++++++-------
>  1 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
> index db157f7..a7deb5c 100644
> --- a/sound/soc/imx/phycore-ac97.c
> +++ b/sound/soc/imx/phycore-ac97.c
> @@ -42,6 +42,7 @@ static struct snd_soc_card imx_phycore = {
>  	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
>  };
>  
> +static struct platform_device *imx_phycore_snd_ac97_device;
>  static struct platform_device *imx_phycore_snd_device;
>  
>  static int __init imx_phycore_init(void)
> @@ -52,29 +53,42 @@ static int __init imx_phycore_init(void)
>  		/* return happy. We might run on a totally different machine */
>  		return 0;
>  
> -	imx_phycore_snd_device = platform_device_alloc("soc-audio", -1);
> -	if (!imx_phycore_snd_device)
> +	imx_phycore_snd_ac97_device = platform_device_alloc("soc-audio", -1);
> +	if (!imx_phycore_snd_ac97_device)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(imx_phycore_snd_device, &imx_phycore);
> -	ret = platform_device_add(imx_phycore_snd_device);
> +	platform_set_drvdata(imx_phycore_snd_ac97_device, &imx_phycore);
> +	ret = platform_device_add(imx_phycore_snd_ac97_device);
> +	if (ret)
> +		goto fail1;
>  
>  	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
> -	if (!imx_phycore_snd_device)
> -		return -ENOMEM;
> +	if (!imx_phycore_snd_device) {
> +		ret = -ENOMEM;
> +		goto fail2;
> +	}
>  	ret = platform_device_add(imx_phycore_snd_device);
>  
>  	if (ret) {
>  		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
> -		platform_device_put(imx_phycore_snd_device);
> +		goto fail3;
>  	}
>  
> +	return 0;
> +
> +fail3:
> +	platform_device_put(imx_phycore_snd_device);
> +fail2:
> +	platform_device_del(imx_phycore_snd_ac97_device);
> +fail1:
> +	platform_device_put(imx_phycore_snd_ac97_device);
>  	return ret;
>  }
>  
>  static void __exit imx_phycore_exit(void)
>  {
>  	platform_device_unregister(imx_phycore_snd_device);
> +	platform_device_unregister(imx_phycore_snd_ac97_device);
>  }
>  
>  late_initcall(imx_phycore_init);
> -- 
> 1.7.2
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
