From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: Convert imx directory to
	module_platform_driver
Date: Mon, 28 Nov 2011 10:29:21 +0100
Message-ID: <20111128092921.GS27267@pengutronix.de>
References: <1322118230.19406.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 12D6924572
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 10:29:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322118230.19406.5.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2011 at 03:03:50PM +0800, Axel Lin wrote:
> Factor out some boilerplate code.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  sound/soc/imx/imx-pcm-dma-mx2.c |   12 +-----------
>  sound/soc/imx/imx-pcm-fiq.c     |   12 +-----------
>  sound/soc/imx/imx-ssi.c         |   13 +------------
>  3 files changed, 3 insertions(+), 34 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
> index 7d28de9..aecdba9 100644
> --- a/sound/soc/imx/imx-pcm-dma-mx2.c
> +++ b/sound/soc/imx/imx-pcm-dma-mx2.c
> @@ -326,16 +326,6 @@ static struct platform_driver imx_pcm_driver = {
>  	.remove = __devexit_p(imx_soc_platform_remove),
>  };
>  
> -static int __init snd_imx_pcm_init(void)
> -{
> -	return platform_driver_register(&imx_pcm_driver);
> -}
> -module_init(snd_imx_pcm_init);
> -
> -static void __exit snd_imx_pcm_exit(void)
> -{
> -	platform_driver_unregister(&imx_pcm_driver);
> -}
> -module_exit(snd_imx_pcm_exit);
> +module_platform_driver(imx_pcm_driver);
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:imx-pcm-audio");
> diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
> index 8df0fae2..d7ea0b3 100644
> --- a/sound/soc/imx/imx-pcm-fiq.c
> +++ b/sound/soc/imx/imx-pcm-fiq.c
> @@ -331,14 +331,4 @@ static struct platform_driver imx_pcm_driver = {
>  	.remove = __devexit_p(imx_soc_platform_remove),
>  };
>  
> -static int __init snd_imx_pcm_init(void)
> -{
> -	return platform_driver_register(&imx_pcm_driver);
> -}
> -module_init(snd_imx_pcm_init);
> -
> -static void __exit snd_imx_pcm_exit(void)
> -{
> -	platform_driver_unregister(&imx_pcm_driver);
> -}
> -module_exit(snd_imx_pcm_exit);
> +module_platform_driver(imx_pcm_driver);
> diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
> index 4c05e2b..d4b6367 100644
> --- a/sound/soc/imx/imx-ssi.c
> +++ b/sound/soc/imx/imx-ssi.c
> @@ -757,18 +757,7 @@ static struct platform_driver imx_ssi_driver = {
>  	},
>  };
>  
> -static int __init imx_ssi_init(void)
> -{
> -	return platform_driver_register(&imx_ssi_driver);
> -}
> -
> -static void __exit imx_ssi_exit(void)
> -{
> -	platform_driver_unregister(&imx_ssi_driver);
> -}
> -
> -module_init(imx_ssi_init);
> -module_exit(imx_ssi_exit);
> +module_platform_driver(imx_ssi_driver);
>  
>  /* Module information */
>  MODULE_AUTHOR("Sascha Hauer, <s.hauer@pengutronix.de>");
> -- 
> 1.7.5.4
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
