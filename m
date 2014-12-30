From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_spdif: Use dev_name() for
 registering the irq
Date: Mon, 29 Dec 2014 19:06:39 -0800
Message-ID: <20141230030638.GB2870@Alpha>
References: <1419904356-6865-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DDB2605B2
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 04:06:44 +0100 (CET)
Received: by mail-yk0-f170.google.com with SMTP id q200so6866404ykb.15
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:06:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419904356-6865-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 29, 2014 at 11:52:35PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The 'name' array is currently stored inside the fsl_spdif_priv private structure
> only for registering the interrupt name.
> 
> This can be simplified by registering it with dev_name() instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

For both patches.

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
Nicolin

> ---
>  sound/soc/fsl/fsl_spdif.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index af042942..73da1f0 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -90,7 +90,6 @@ struct spdif_mixer_control {
>   * @sysclk: system clock for rx clock rate measurement
>   * @dma_params_tx: DMA parameters for transmit channel
>   * @dma_params_rx: DMA parameters for receive channel
> - * @name: driver name
>   */
>  struct fsl_spdif_priv {
>  	struct spdif_mixer_control fsl_spdif_control;
> @@ -109,12 +108,8 @@ struct fsl_spdif_priv {
>  	struct clk *sysclk;
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
> -
> -	/* The name space will be allocated dynamically */
> -	char name[0];
>  };
>  
> -
>  /* DPLL locked and lock loss interrupt handler */
>  static void spdif_irq_dpll_lock(struct fsl_spdif_priv *spdif_priv)
>  {
> @@ -1169,19 +1164,15 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  	if (!np)
>  		return -ENODEV;
>  
> -	spdif_priv = devm_kzalloc(&pdev->dev,
> -			sizeof(struct fsl_spdif_priv) + strlen(np->name) + 1,
> -			GFP_KERNEL);
> +	spdif_priv = devm_kzalloc(&pdev->dev, sizeof(*spdif_priv), GFP_KERNEL);
>  	if (!spdif_priv)
>  		return -ENOMEM;
>  
> -	strcpy(spdif_priv->name, np->name);
> -
>  	spdif_priv->pdev = pdev;
>  
>  	/* Initialize this copy of the CPU DAI driver structure */
>  	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
> -	spdif_priv->cpu_dai_drv.name = spdif_priv->name;
> +	spdif_priv->cpu_dai_drv.name = dev_name(&pdev->dev);
>  
>  	/* Get the addresses and IRQ */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1203,7 +1194,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
> -			spdif_priv->name, spdif_priv);
> +			       dev_name(&pdev->dev), spdif_priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not claim irq %u\n", irq);
>  		return ret;
> -- 
> 1.9.1
> 
