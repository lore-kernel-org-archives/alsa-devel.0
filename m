From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/10] sound/soc/ux500/ux500_msp_i2s.c: better use devm
 functions and fix error return code
Date: Sun, 5 Apr 2015 14:12:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1504051412500.2038@localhost6.localdomain6>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr> <1428233914-4503-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1428233914-4503-3-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Liam Girdwood <lrg@ti.com>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Please ignore. Wrong patch set.

On Sun, 5 Apr 2015, Julia Lawall wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Remove unnecessary calls to devm_kfree and replace iounmap by devm_iounmap
> (and use resource_size for the third argument).  These changes make it
> possible to remove the error-handling code at the end of
> ux500_msp_i2s_init_msp, and all of the gotos become direct returns.
> 
> In the case of the second call to devm_kzalloc, the return variable ret was
> not initialized.  Here it is changed to a direct return of -ENOMEM.
> 
> A simplified version of the semantic match that finds the second problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  sound/soc/ux500/ux500_msp_i2s.c |   25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
> index 36be11e..1b7c2f5 100644
> --- a/sound/soc/ux500/ux500_msp_i2s.c
> +++ b/sound/soc/ux500/ux500_msp_i2s.c
> @@ -663,7 +663,6 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
>  			struct ux500_msp **msp_p,
>  			struct msp_i2s_platform_data *platform_data)
>  {
> -	int ret = 0;
>  	struct resource *res = NULL;
>  	struct i2s_controller *i2s_cont;
>  	struct ux500_msp *msp;
> @@ -687,15 +686,14 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
>  	if (res == NULL) {
>  		dev_err(&pdev->dev, "%s: ERROR: Unable to get resource!\n",
>  			__func__);
> -		ret = -ENOMEM;
> -		goto err_res;
> +		return -ENOMEM;
>  	}
>  
> -	msp->registers = ioremap(res->start, (res->end - res->start + 1));
> +	msp->registers = devm_ioremap(&pdev->dev, res->start,
> +				      resource_size(res));
>  	if (msp->registers == NULL) {
>  		dev_err(&pdev->dev, "%s: ERROR: ioremap failed!\n", __func__);
> -		ret = -ENOMEM;
> -		goto err_res;
> +		return -ENOMEM;
>  	}
>  
>  	msp->msp_state = MSP_STATE_IDLE;
> @@ -707,7 +705,7 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
>  		dev_err(&pdev->dev,
>  			"%s: ERROR: Failed to allocate I2S-controller!\n",
>  			__func__);
> -		goto err_i2s_cont;
> +		return -ENOMEM;
>  	}
>  	i2s_cont->dev.parent = &pdev->dev;
>  	i2s_cont->data = (void *)msp;
> @@ -718,14 +716,6 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
>  	msp->i2s_cont = i2s_cont;
>  
>  	return 0;
> -
> -err_i2s_cont:
> -	iounmap(msp->registers);
> -
> -err_res:
> -	devm_kfree(&pdev->dev, msp);
> -
> -	return ret;
>  }
>  
>  void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
> @@ -734,11 +724,6 @@ void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
>  	dev_dbg(msp->dev, "%s: Enter (id = %d).\n", __func__, msp->id);
>  
>  	device_unregister(&msp->i2s_cont->dev);
> -	devm_kfree(&pdev->dev, msp->i2s_cont);
> -
> -	iounmap(msp->registers);
> -
> -	devm_kfree(&pdev->dev, msp);
>  }
>  
>  MODULE_LICENSE("GPL v2");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
