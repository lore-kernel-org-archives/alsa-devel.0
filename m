From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2 1/2] ASoC: fsl_esai: Wrap some operations to be
 functions
Date: Wed, 3 Jul 2019 02:10:46 -0700
Message-ID: <20190703091046.GA8764@Asurada>
References: <cover.1562136119.git.shengjiu.wang@nxp.com>
 <f57c5a045c6e5491b1bc9831388eab2c88773176.1562136119.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f57c5a045c6e5491b1bc9831388eab2c88773176.1562136119.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shengjiu.wang@nxp.com
Cc: timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Looks good to me, yet two small comments inline.

Please add this to this patch in the next version:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

On Wed, Jul 03, 2019 at 02:42:04PM +0800, shengjiu.wang@nxp.com wrote:
> +static int fsl_esai_register_restore(struct fsl_esai *esai_priv)
> +{
> +	int ret;
> +	/* FIFO reset for safety */
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,

Checkpatch script would probably warn this. Usually we add a blank
line after variable declarations.

> @@ -866,22 +935,9 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(&pdev->dev, esai_priv);
>  
> -	/* Reset ESAI unit */
> -	ret = regmap_write(esai_priv->regmap, REG_ESAI_ECR, ESAI_ECR_ERST);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to reset ESAI: %d\n", ret);
> +	ret = fsl_esai_init(esai_priv);

Could we rename this function to fsl_easi_hw_init() or something
clear like fsl_esai_register_init? fsl_easi_init() feels like a
driver init() function to me.

Thank you
Nicolin
