From: Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH 2/3] ASoC: fsl_sai: derive TX FIFO
 watermark from FIFO depth
Date: Wed, 17 Jul 2019 07:43:18 -0600
Message-ID: <6cc95da1373307eb2bace8b4af3c884d@akkea.ca>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-3-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 074A2F8015B
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 15:43:21 +0200 (CEST)
In-Reply-To: <20190717105635.18514-3-l.stach@pengutronix.de>
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
> The DMA request schould be triggered as soon as the FIFO has space
> for another burst. As different versions of the SAI block have
> different FIFO sizes, the watrmark level needs to be derived from
> version specific data.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>

> ---
>  sound/soc/fsl/fsl_sai.c | 4 +++-
>  sound/soc/fsl/fsl_sai.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 3a1ed8b857d6..b3cd055a61c7 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -649,7 +649,7 @@ static int fsl_sai_dai_probe(struct snd_soc_dai 
> *cpu_dai)
>  	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
> 
>  	regmap_update_bits(sai->regmap, FSL_SAI_TCR1, FSL_SAI_CR1_RFW_MASK,
> -			   FSL_SAI_MAXBURST_TX * 2);
> +			   sai->soc_data->fifo_depth - FSL_SAI_MAXBURST_TX);
>  	regmap_update_bits(sai->regmap, FSL_SAI_RCR1, FSL_SAI_CR1_RFW_MASK,
>  			   FSL_SAI_MAXBURST_RX - 1);
> 
> @@ -923,10 +923,12 @@ static int fsl_sai_remove(struct platform_device 
> *pdev)
> 
>  static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
>  	.use_imx_pcm = false,
> +	.fifo_depth = 32,
>  };
> 
>  static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
>  	.use_imx_pcm = true,
> +	.fifo_depth = 32,
>  };
> 
>  static const struct of_device_id fsl_sai_ids[] = {
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 83e2bfe05b1b..7c1ef671da28 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -128,6 +128,7 @@
> 
>  struct fsl_sai_soc_data {
>  	bool use_imx_pcm;
> +	unsigned int fifo_depth;
>  };
> 
>  struct fsl_sai {
