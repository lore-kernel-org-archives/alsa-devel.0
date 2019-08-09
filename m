From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_esai: Add compatible string for imx6ull
Date: Fri, 9 Aug 2019 12:58:46 -0700
Message-ID: <20190809195845.GB8148@Asurada>
References: <1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 09, 2019 at 06:27:46PM +0800, Shengjiu Wang wrote:
> Add compatible string for imx6ull, from imx6ull platform,
> the issue of channel swap after xrun is fixed in hardware.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_esai.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 10d2210c91ef..4b4a8e831e9e 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -920,6 +920,7 @@ static int fsl_esai_remove(struct platform_device *pdev)
>  static const struct of_device_id fsl_esai_dt_ids[] = {
>  	{ .compatible = "fsl,imx35-esai", },
>  	{ .compatible = "fsl,vf610-esai", },
> +	{ .compatible = "fsl,imx6ull-esai", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
> -- 
> 2.21.0
> 
