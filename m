From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
Date: Sun, 21 Apr 2019 18:09:46 -0700
Message-ID: <20190422010945.GB8364@Asurada>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-3-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-3-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 21, 2019 at 07:39:09PM +0000, Daniel Baluta wrote:
> Basically the same actions as for system PM, so make use
> of pm_runtime_force_suspend/pm_runtime_force_resume.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d9df98975cf8..8623b7f882b9 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -9,6 +9,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> @@ -900,6 +901,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sai);
>  
> +	pm_runtime_enable(&pdev->dev);
> +
>  	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
>  			&fsl_sai_dai, 1);
>  	if (ret)
> @@ -911,6 +914,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
>  }
>  
> +static int fsl_sai_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
>  static const struct of_device_id fsl_sai_ids[] = {
>  	{ .compatible = "fsl,vf610-sai", },
>  	{ .compatible = "fsl,imx6sx-sai", },
> @@ -919,8 +927,8 @@ static const struct of_device_id fsl_sai_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int fsl_sai_suspend(struct device *dev)
> +#ifdef CONFIG_PM
> +static int fsl_sai_runtime_suspend(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
>  
> @@ -930,7 +938,7 @@ static int fsl_sai_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int fsl_sai_resume(struct device *dev)
> +static int fsl_sai_runtime_resume(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
>  
> @@ -942,14 +950,18 @@ static int fsl_sai_resume(struct device *dev)
>  	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
>  	return regcache_sync(sai->regmap);
>  }
> -#endif /* CONFIG_PM_SLEEP */
> +#endif /* CONFIG_PM */
>  
>  static const struct dev_pm_ops fsl_sai_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)
> +	SET_RUNTIME_PM_OPS(fsl_sai_runtime_suspend,
> +			   fsl_sai_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  };
>  
>  static struct platform_driver fsl_sai_driver = {
>  	.probe = fsl_sai_probe,
> +	.remove = fsl_sai_remove,
>  	.driver = {
>  		.name = "fsl-sai",
>  		.pm = &fsl_sai_pm_ops,
> -- 
> 2.17.1
> 
