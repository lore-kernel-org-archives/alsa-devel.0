From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASoC: Convert mid-x86 directory to
 module_platform_driver
Date: Thu, 24 Nov 2011 14:10:55 +0530
Message-ID: <1322124055.1516.952.camel@vkoul-udesk3>
References: <1322106716.16201.13.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id E5EF12449E
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 09:44:20 +0100 (CET)
In-Reply-To: <1322106716.16201.13.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lu Guanqun <guanqun.lu@intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-11-24 at 11:51 +0800, Axel Lin wrote:
> Factor out some boilerplate code.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/mid-x86/mfld_machine.c |   14 +-------------
>  sound/soc/mid-x86/sst_platform.c |   14 +-------------
>  2 files changed, 2 insertions(+), 26 deletions(-)
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

> 
> diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
> index cca693a..e53f8e4 100644
> --- a/sound/soc/mid-x86/mfld_machine.c
> +++ b/sound/soc/mid-x86/mfld_machine.c
> @@ -428,19 +428,7 @@ static struct platform_driver snd_mfld_mc_driver = {
>  	.remove = __devexit_p(snd_mfld_mc_remove),
>  };
>  
> -static int __init snd_mfld_driver_init(void)
> -{
> -	pr_debug("snd_mfld_driver_init called\n");
> -	return platform_driver_register(&snd_mfld_mc_driver);
> -}
> -module_init(snd_mfld_driver_init);
> -
> -static void __exit snd_mfld_driver_exit(void)
> -{
> -	pr_debug("snd_mfld_driver_exit called\n");
> -	platform_driver_unregister(&snd_mfld_mc_driver);
> -}
> -module_exit(snd_mfld_driver_exit);
> +module_platform_driver(snd_mfld_mc_driver);
>  
>  MODULE_DESCRIPTION("ASoC Intel(R) MID Machine driver");
>  MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
> diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
> index 2305702..94f70b3 100644
> --- a/sound/soc/mid-x86/sst_platform.c
> +++ b/sound/soc/mid-x86/sst_platform.c
> @@ -472,19 +472,7 @@ static struct platform_driver sst_platform_driver = {
>  	.remove		= sst_platform_remove,
>  };
>  
> -static int __init sst_soc_platform_init(void)
> -{
> -	pr_debug("sst_soc_platform_init called\n");
> -	return platform_driver_register(&sst_platform_driver);
> -}
> -module_init(sst_soc_platform_init);
> -
> -static void __exit sst_soc_platform_exit(void)
> -{
> -	platform_driver_unregister(&sst_platform_driver);
> -	pr_debug("sst_soc_platform_exit success\n");
> -}
> -module_exit(sst_soc_platform_exit);
> +module_platform_driver(sst_platform_driver);
>  
>  MODULE_DESCRIPTION("ASoC Intel(R) MID Platform driver");
>  MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");


-- 
~Vinod
