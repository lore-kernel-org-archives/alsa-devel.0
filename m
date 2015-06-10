From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [patch] ASoC: fsl: add an error check
Date: Wed, 10 Jun 2015 09:55:45 -0700
Message-ID: <20150610165544.GA8552@Asurada>
References: <20150610153723.GB10549@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150610153723.GB10549@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 10, 2015 at 06:37:23PM +0300, Dan Carpenter wrote:
> My static checker complains that:
> 
> 	sound/soc/fsl/imx-wm8962.c:196 imx_wm8962_probe() warn:
> 	we tested 'ret' before and it was 'false'
> 
> The intent was that we use "ret" to check imx_audmux_v2_configure_port().
> 
> Fixes: 8de2ae2a7f1f ('ASoC: fsl: add imx-wm8962 machine driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Could you please use an subject like:
ASoC: imx-wm8962: Add a missing error check
(Since it only applies to this file)

Otherwise, Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you indeed for the fix
Nicolin

> ---
> I assume checking for an error here will not change anything but I have
> not tested this patch.
> 
> diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
> index cd146d4..b38b98c 100644
> --- a/sound/soc/fsl/imx-wm8962.c
> +++ b/sound/soc/fsl/imx-wm8962.c
> @@ -190,7 +190,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "audmux internal port setup failed\n");
>  		return ret;
>  	}
> -	imx_audmux_v2_configure_port(ext_port,
> +	ret = imx_audmux_v2_configure_port(ext_port,
>  			IMX_AUDMUX_V2_PTCR_SYN,
>  			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
>  	if (ret) {
