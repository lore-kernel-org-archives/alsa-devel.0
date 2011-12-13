From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASoC: Staticise sst_pcm_new and
 sst_soc_platform_drv
Date: Tue, 13 Dec 2011 19:57:03 +0530
Message-ID: <1323786423.1641.98.camel@vkoul-udesk3>
References: <1323767625.2436.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C3FB103B8F
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 15:27:59 +0100 (CET)
In-Reply-To: <1323767625.2436.4.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Mark@alsa-project.org, Lu Guanqun <guanqun.lu@intel.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-12-13 at 17:13 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/mid-x86/sst_platform.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
> index 24f9471..5b936d5 100644
> --- a/sound/soc/mid-x86/sst_platform.c
> +++ b/sound/soc/mid-x86/sst_platform.c
> @@ -443,7 +443,7 @@ static void sst_pcm_free(struct snd_pcm *pcm)
>  	snd_pcm_lib_preallocate_free_for_all(pcm);
>  }
>  
> -int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
> +static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_soc_dai *dai = rtd->cpu_dai;
>  	struct snd_pcm *pcm = rtd->pcm;
> @@ -463,7 +463,7 @@ int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  	}
>  	return retval;
>  }
> -struct snd_soc_platform_driver sst_soc_platform_drv = {
> +static struct snd_soc_platform_driver sst_soc_platform_drv = {
>  	.ops		= &sst_platform_ops,
>  	.pcm_new	= sst_pcm_new,
>  	.pcm_free	= sst_pcm_free,

Acked-by Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
