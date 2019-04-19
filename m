From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Date: Fri, 19 Apr 2019 11:01:21 +0000
Message-ID: <VE1PR04MB6479A85982748088CC42901DE3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70071.outbound.protection.outlook.com [40.107.7.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06462F801D9
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 13:01:23 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


Hi

> 
> 
> Add pm runtime support and move clock handling there.
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> Changes in v2
> -refine the commit comments.
> -move regcache_mark_dirty to runtime suspend.
> 
>  sound/soc/fsl/fsl_esai.c | 141 ++++++++++++++++++++++++++--------------------
> -
>  1 file changed, 77 insertions(+), 64 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> bad0dfed6b68..10d2210c91ef 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm_params.h>
> 
> @@ -466,30 +467,6 @@ static int fsl_esai_startup(struct
> snd_pcm_substream *substream,
>                             struct snd_soc_dai *dai)  {
>         struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
> -       int ret;
> -
> -       /*
> -        * Some platforms might use the same bit to gate all three or two of
> -        * clocks, so keep all clocks open/close at the same time for safety
> -        */
> -       ret = clk_prepare_enable(esai_priv->coreclk);
> -       if (ret)
> -               return ret;
> -       if (!IS_ERR(esai_priv->spbaclk)) {
> -               ret = clk_prepare_enable(esai_priv->spbaclk);
> -               if (ret)
> -                       goto err_spbaclk;
> -       }
> -       if (!IS_ERR(esai_priv->extalclk)) {
> -               ret = clk_prepare_enable(esai_priv->extalclk);
> -               if (ret)
> -                       goto err_extalck;
> -       }
> -       if (!IS_ERR(esai_priv->fsysclk)) {
> -               ret = clk_prepare_enable(esai_priv->fsysclk);
> -               if (ret)
> -                       goto err_fsysclk;
> -       }
> 
>         if (!dai->active) {
>                 /* Set synchronous mode */ @@ -506,16 +483,6 @@ static int
> fsl_esai_startup(struct snd_pcm_substream *substream,
> 
>         return 0;
> 
> -err_fsysclk:
> -       if (!IS_ERR(esai_priv->extalclk))
> -               clk_disable_unprepare(esai_priv->extalclk);
> -err_extalck:
> -       if (!IS_ERR(esai_priv->spbaclk))
> -               clk_disable_unprepare(esai_priv->spbaclk);
> -err_spbaclk:
> -       clk_disable_unprepare(esai_priv->coreclk);
> -
> -       return ret;
>  }
> 
>  static int fsl_esai_hw_params(struct snd_pcm_substream *substream, @@
> -576,20 +543,6 @@ static int fsl_esai_hw_params(struct
> snd_pcm_substream *substream,
>         return 0;
>  }
> 
> -static void fsl_esai_shutdown(struct snd_pcm_substream *substream,
> -                             struct snd_soc_dai *dai)
> -{
> -       struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
> -
> -       if (!IS_ERR(esai_priv->fsysclk))
> -               clk_disable_unprepare(esai_priv->fsysclk);
> -       if (!IS_ERR(esai_priv->extalclk))
> -               clk_disable_unprepare(esai_priv->extalclk);
> -       if (!IS_ERR(esai_priv->spbaclk))
> -               clk_disable_unprepare(esai_priv->spbaclk);
> -       clk_disable_unprepare(esai_priv->coreclk);
> -}
> -
>  static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>                             struct snd_soc_dai *dai)  { @@ -658,7 +611,6 @@ static int
> fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
> 
>  static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
>         .startup = fsl_esai_startup,
> -       .shutdown = fsl_esai_shutdown,
>         .trigger = fsl_esai_trigger,
>         .hw_params = fsl_esai_hw_params,
>         .set_sysclk = fsl_esai_set_dai_sysclk, @@ -947,6 +899,10 @@ static int
> fsl_esai_probe(struct platform_device *pdev)
>                 return ret;
>         }
> 
> +       pm_runtime_enable(&pdev->dev);
> +

I just have a question, do I need to add pm_runtime_idle(&pdev->dev)?

Best regards
Wang shengjiu
