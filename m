From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ASoC: ux500: adjust devm usage
Date: Mon, 20 Jul 2015 13:25:20 +0200
Message-ID: <CAPDyKFpih4xXG+JGkGcG=1wZf0jSEZ_a=fFP2FmB3iD2okO0DA@mail.gmail.com>
References: <1437333136-20908-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1437333136-20908-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 19 July 2015 at 21:12, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> The explicit call to devm_regulator_put in the probe and remove functions
> does not seem to be necessary.  In particular, the functions
> prcmu_qos_remove_requirement and ux500_msp_i2s_cleanup_msp in the remove
> function seem to do nothing that can interfere with devm_regulator_put,
> making it safe to allow devm_regulator_put to occur after the end of the
> remove function.
>
> Convert the calls to clk_get to devm_clk_get, and remove the corresponding
> calls to clk_put in the probe and remove functions.
>
> Replace various gotos by direct returns, and drop unneeded labels.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> ---
>  sound/soc/ux500/ux500_msp_dai.c |   29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
> index 978f2d7..f5df08d 100644
> --- a/sound/soc/ux500/ux500_msp_dai.c
> +++ b/sound/soc/ux500/ux500_msp_dai.c
> @@ -773,20 +773,22 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
>         }
>         prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP, (char *)pdev->name, 50);
>
> -       drvdata->pclk = clk_get(&pdev->dev, "apb_pclk");
> +       drvdata->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
>         if (IS_ERR(drvdata->pclk)) {
>                 ret = (int)PTR_ERR(drvdata->pclk);
> -               dev_err(&pdev->dev, "%s: ERROR: clk_get of pclk failed (%d)!\n",
> +               dev_err(&pdev->dev,
> +                       "%s: ERROR: devm_clk_get of pclk failed (%d)!\n",
>                         __func__, ret);
> -               goto err_pclk;
> +               return ret;
>         }
>
> -       drvdata->clk = clk_get(&pdev->dev, NULL);
> +       drvdata->clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(drvdata->clk)) {
>                 ret = (int)PTR_ERR(drvdata->clk);
> -               dev_err(&pdev->dev, "%s: ERROR: clk_get failed (%d)!\n",
> +               dev_err(&pdev->dev,
> +                       "%s: ERROR: devm_clk_get failed (%d)!\n",
>                         __func__, ret);
> -               goto err_clk;
> +               return ret;
>         }
>
>         ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp,
> @@ -795,7 +797,7 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev,
>                         "%s: ERROR: Failed to init MSP-struct (%d)!",
>                         __func__, ret);
> -               goto err_init_msp;
> +               return ret;
>         }
>         dev_set_drvdata(&pdev->dev, drvdata);
>
> @@ -804,7 +806,7 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Error: %s: Failed to register MSP%d!\n",
>                         __func__, drvdata->msp->id);
> -               goto err_init_msp;
> +               return ret;
>         }
>
>         ret = ux500_pcm_register_platform(pdev);
> @@ -819,13 +821,6 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
>
>  err_reg_plat:
>         snd_soc_unregister_component(&pdev->dev);
> -err_init_msp:
> -       clk_put(drvdata->clk);
> -err_clk:
> -       clk_put(drvdata->pclk);
> -err_pclk:
> -       devm_regulator_put(drvdata->reg_vape);
> -
>         return ret;
>  }
>
> @@ -837,12 +832,8 @@ static int ux500_msp_drv_remove(struct platform_device *pdev)
>
>         snd_soc_unregister_component(&pdev->dev);
>
> -       devm_regulator_put(drvdata->reg_vape);
>         prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP, "ux500_msp_i2s");
>
> -       clk_put(drvdata->clk);
> -       clk_put(drvdata->pclk);
> -
>         ux500_msp_i2s_cleanup_msp(pdev, drvdata->msp);
>
>         return 0;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
