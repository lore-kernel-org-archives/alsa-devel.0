From: Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH 1/3] ASoC: fsl_sai: add of_match data
Date: Wed, 17 Jul 2019 07:42:52 -0600
Message-ID: <aed115b1fce5cc3e7a81b60efbc01536@akkea.ca>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-2-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF194F8015B
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 15:42:55 +0200 (CEST)
In-Reply-To: <20190717105635.18514-2-l.stach@pengutronix.de>
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
> New revisions of the SAI IP block have even more differences that need
> be taken into account by the driver. To avoid sprinking compatible
> checks all over the driver move the current differences into 
> of_match_data.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>

> ---
>  sound/soc/fsl/fsl_sai.c | 22 ++++++++++++++--------
>  sound/soc/fsl/fsl_sai.h |  6 +++++-
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 812c94fbb160..3a1ed8b857d6 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -9,6 +9,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -798,10 +799,7 @@ static int fsl_sai_probe(struct platform_device 
> *pdev)
>  		return -ENOMEM;
> 
>  	sai->pdev = pdev;
> -
> -	if (of_device_is_compatible(np, "fsl,imx6sx-sai") ||
> -	    of_device_is_compatible(np, "fsl,imx6ul-sai"))
> -		sai->sai_on_imx = true;
> +	sai->soc_data = of_device_get_match_data(&pdev->dev);
> 
>  	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
> 
> @@ -910,7 +908,7 @@ static int fsl_sai_probe(struct platform_device 
> *pdev)
>  	if (ret)
>  		return ret;
> 
> -	if (sai->sai_on_imx)
> +	if (sai->soc_data->use_imx_pcm)
>  		return imx_pcm_dma_init(pdev, IMX_SAI_DMABUF_SIZE);
>  	else
>  		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> @@ -923,10 +921,18 @@ static int fsl_sai_remove(struct platform_device 
> *pdev)
>  	return 0;
>  }
> 
> +static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
> +	.use_imx_pcm = false,
> +};
> +
> +static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
> +	.use_imx_pcm = true,
> +};
> +
>  static const struct of_device_id fsl_sai_ids[] = {
> -	{ .compatible = "fsl,vf610-sai", },
> -	{ .compatible = "fsl,imx6sx-sai", },
> -	{ .compatible = "fsl,imx6ul-sai", },
> +	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
> +	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
> +	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 24cb156bf995..83e2bfe05b1b 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -126,6 +126,10 @@
>  #define FSL_SAI_MAXBURST_TX 6
>  #define FSL_SAI_MAXBURST_RX 6
> 
> +struct fsl_sai_soc_data {
> +	bool use_imx_pcm;
> +};
> +
>  struct fsl_sai {
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
> @@ -135,7 +139,6 @@ struct fsl_sai {
>  	bool is_slave_mode;
>  	bool is_lsb_first;
>  	bool is_dsp_mode;
> -	bool sai_on_imx;
>  	bool synchronous[2];
> 
>  	unsigned int mclk_id[2];
> @@ -143,6 +146,7 @@ struct fsl_sai {
>  	unsigned int slots;
>  	unsigned int slot_width;
> 
> +	const struct fsl_sai_soc_data *soc_data;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  };
