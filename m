From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [patch 2/2] ASoC: imx: add missing module
	informations
Date: Thu, 23 Jun 2011 09:50:43 +0200
Message-ID: <20110623075043.GS6069@pengutronix.de>
References: <20110622204442.159395380@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 72328103AB1
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 09:50:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110622204442.159395380@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 10:21:49PM +0200, Arnaud Patard wrote:
> - add some modules aliases
> - add module license to avoid tainted kernel when loading the imx-pcm-audio
>   driver
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> Index: sound-2.6/sound/soc/imx/imx-pcm-dma-mx2.c
> ===================================================================
> --- sound-2.6.orig/sound/soc/imx/imx-pcm-dma-mx2.c	2011-06-22 15:09:06.000000000 +0200
> +++ sound-2.6/sound/soc/imx/imx-pcm-dma-mx2.c	2011-06-22 15:36:36.000000000 +0200
> @@ -337,3 +337,5 @@ static void __exit snd_imx_pcm_exit(void
>  	platform_driver_unregister(&imx_pcm_driver);
>  }
>  module_exit(snd_imx_pcm_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:imx-pcm-audio");
> Index: sound-2.6/sound/soc/imx/imx-ssi.c
> ===================================================================
> --- sound-2.6.orig/sound/soc/imx/imx-ssi.c	2011-06-22 15:09:06.000000000 +0200
> +++ sound-2.6/sound/soc/imx/imx-ssi.c	2011-06-22 15:36:36.000000000 +0200
> @@ -775,4 +775,4 @@ module_exit(imx_ssi_exit);
>  MODULE_AUTHOR("Sascha Hauer, <s.hauer@pengutronix.de>");
>  MODULE_DESCRIPTION("i.MX I2S/ac97 SoC Interface");
>  MODULE_LICENSE("GPL");
> -
> +MODULE_ALIAS("platform:imx-ssi");
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
