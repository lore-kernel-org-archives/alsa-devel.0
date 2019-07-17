From: Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add i.MX8M support
Date: Wed, 17 Jul 2019 07:45:00 -0600
Message-ID: <18b4d49b410248766e834f3a0444e106@akkea.ca>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-4-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5BC0F800C4
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 15:45:01 +0200 (CEST)
In-Reply-To: <20190717105635.18514-4-l.stach@pengutronix.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-17 04:56, Lucas Stach wrote:
> The SAI block on the i.MX8M moved the register layout, as 2 version
> registers were added at the start of the register map. We deal with
> this by moving the start of the regmap, so both register layouts
> look the same to accesses going through the regmap.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

checkpatch has a complaint about mixing code and device tree bindings.

Other than that

Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>

> ---
>  .../devicetree/bindings/sound/fsl-sai.txt     |  2 +-
>  sound/soc/fsl/fsl_sai.c                       | 19 +++++++++++++++++++
>  sound/soc/fsl/fsl_sai.h                       |  1 +
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2e726b983845..037871d2f505 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -8,7 +8,7 @@ codec/DSP interfaces.
>  Required properties:
> 
>    - compatible		: Compatible list, contains "fsl,vf610-sai",
> -			  "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
> +			  "fsl,imx6sx-sai", "fsl,imx6ul-sai" or "fsl,imx8mq-sai"
> 
>    - reg			: Offset and length of the register set for the device.
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index b3cd055a61c7..a10201078e40 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -808,6 +808,16 @@ static int fsl_sai_probe(struct platform_device 
> *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> 
> +	/*
> +	 * New versions of the SAI have 2 32bit version registers added at 
> the
> +	 * start of the register map. To avoid dealing with this shift all 
> over
> +	 * the driver, we move the start of the regmap to make both register
> +	 * layouts look the same to the regmap. This means we can't read the
> +	 * version registers through the regmap, but this is small price to 
> pay.
> +	 */
> +	if (sai->soc_data->has_version_registers)
> +		base += 8;
> +
>  	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
>  			"bus", base, &fsl_sai_regmap_config);
> 
> @@ -923,18 +933,27 @@ static int fsl_sai_remove(struct platform_device 
> *pdev)
> 
>  static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
>  	.use_imx_pcm = false,
> +	.has_version_registers = false,
>  	.fifo_depth = 32,
>  };
> 
>  static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
>  	.use_imx_pcm = true,
> +	.has_version_registers = false,
>  	.fifo_depth = 32,
>  };
> 
> +static const struct fsl_sai_soc_data fsl_sai_imx8m_data = {
> +	.use_imx_pcm = true,
> +	.has_version_registers = true,
> +	.fifo_depth = 128,
> +};
> +
>  static const struct of_device_id fsl_sai_ids[] = {
>  	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
>  	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
>  	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
> +	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8m_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 7c1ef671da28..b6a9053ed400 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -128,6 +128,7 @@
> 
>  struct fsl_sai_soc_data {
>  	bool use_imx_pcm;
> +	bool has_version_registers;
>  	unsigned int fifo_depth;
>  };
