From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Use dev_name() for
	registering the irq
Date: Mon, 29 Dec 2014 15:54:24 -0800
Message-ID: <20141229235424.GA2870@Alpha>
References: <1419890246-21985-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f48.google.com (mail-yh0-f48.google.com
 [209.85.213.48])
 by alsa0.perex.cz (Postfix) with ESMTP id DB42426058F
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 00:54:42 +0100 (CET)
Received: by mail-yh0-f48.google.com with SMTP id i57so6845318yha.7
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 15:54:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419890246-21985-1-git-send-email-festevam@gmail.com>
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

On Mon, Dec 29, 2014 at 07:57:26PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The 'name' array is currently stored inside the fsl_esai private structure only
> for registering the interrupt name.
> 
> This can be simplified by registering it with dev_name() instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

The name from dev_name() is a little different but doesn't matter.
The code looks neater now. I think we may also apply similar ones
to other drivers as well -- ASRC, SPDIF, etc. Would you like to
send the patches? Otherwise, I can do this instead :)

> ---
>  sound/soc/fsl/fsl_esai.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 1c08ab1..dbe9204 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -44,7 +44,6 @@
>   * @sck_div: if using PSR/PM dividers for SCKx clock
>   * @slave_mode: if fully using DAI slave mode
>   * @synchronous: if using tx/rx synchronous mode
> - * @name: driver name
>   */
>  struct fsl_esai {
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
> @@ -63,7 +62,6 @@ struct fsl_esai {
>  	bool sck_div[2];
>  	bool slave_mode;
>  	bool synchronous;
> -	char name[32];
>  };
>  
>  static irqreturn_t esai_isr(int irq, void *devid)
> @@ -739,7 +737,6 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	esai_priv->pdev = pdev;
> -	strncpy(esai_priv->name, np->name, sizeof(esai_priv->name) - 1);
>  
>  	/* Get the addresses and IRQ */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -779,7 +776,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = devm_request_irq(&pdev->dev, irq, esai_isr, 0,
> -			       esai_priv->name, esai_priv);
> +			       dev_name(&pdev->dev), esai_priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to claim irq %u\n", irq);
>  		return ret;
> -- 
> 1.9.1
> 
