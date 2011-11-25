From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/8] ASoC: Convert atmel directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 09:22:15 +0100
Message-ID: <4ECF5037.2080609@atmel.com>
References: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CB61243D4
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 09:22:45 +0100 (CET)
In-Reply-To: <1322186745.8878.1.camel@phoenix>
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
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/25/2011 03:05 AM, Axel Lin :
> Factor out some boilerplate code.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  sound/soc/atmel/atmel-pcm.c     |   12 +-----------
>  sound/soc/atmel/atmel_ssc_dai.c |   12 +-----------
>  2 files changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
> index f81d4c3..60de055 100644
> --- a/sound/soc/atmel/atmel-pcm.c
> +++ b/sound/soc/atmel/atmel-pcm.c
> @@ -495,17 +495,7 @@ static struct platform_driver atmel_pcm_driver = {
>  	.remove = __devexit_p(atmel_soc_platform_remove),
>  };
>  
> -static int __init snd_atmel_pcm_init(void)
> -{
> -	return platform_driver_register(&atmel_pcm_driver);
> -}
> -module_init(snd_atmel_pcm_init);
> -
> -static void __exit snd_atmel_pcm_exit(void)
> -{
> -	platform_driver_unregister(&atmel_pcm_driver);
> -}
> -module_exit(snd_atmel_pcm_exit);
> +module_platform_driver(atmel_pcm_driver);
>  
>  MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
>  MODULE_DESCRIPTION("Atmel PCM module");
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index a67fc9b..354341e 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -859,17 +859,7 @@ int atmel_ssc_set_audio(int ssc_id)
>  }
>  EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
>  
> -static int __init snd_atmel_ssc_init(void)
> -{
> -	return platform_driver_register(&asoc_ssc_driver);
> -}
> -module_init(snd_atmel_ssc_init);
> -
> -static void __exit snd_atmel_ssc_exit(void)
> -{
> -	platform_driver_unregister(&asoc_ssc_driver);
> -}
> -module_exit(snd_atmel_ssc_exit);
> +module_platform_driver(asoc_ssc_driver);
>  
>  /* Module information */
>  MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");


-- 
Nicolas Ferre
