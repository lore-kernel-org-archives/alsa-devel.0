From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 6/7] ASoC: fsl_sai: Add support for imx7ulp/imx8mq
Date: Tue, 30 Jul 2019 01:05:52 -0700
Message-ID: <20190730080552.GC5892@Asurada>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-7-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-7-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, viorel.suman@nxp.com, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 28, 2019 at 10:24:28PM +0300, Daniel Baluta wrote:
> SAI module on imx7ulp/imx8m features 2 new registers (VERID and PARAM)
> at the beginning of register address space.
> 
> On imx7ulp FIFOs can held up to 16 x 32 bit samples.
> On imx8mq FIFOs can held up to 128 x 32 bit samples.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 54e5e9abae01..0fb6750fefd5 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1030,10 +1030,24 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
>  	.reg_offset = 0,
>  };
>  
> +static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
> +	.use_imx_pcm = true,
> +	.fifo_depth = 16,
> +	.reg_offset = 8,
> +};
> +
> +static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
> +	.use_imx_pcm = true,
> +	.fifo_depth = 128,
> +	.reg_offset = 8,
> +};
> +
>  static const struct of_device_id fsl_sai_ids[] = {
>  	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
>  	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
>  	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
> +	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
> +	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
> -- 
> 2.17.1
> 
