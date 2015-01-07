From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: fsl_dma: Do not use 'full_name'
 node reference
Date: Wed, 07 Jan 2015 18:26:45 +0100
Message-ID: <54AD6C55.7030600@metafoo.de>
References: <1420651312-21671-1-git-send-email-festevam@gmail.com>
 <1420651312-21671-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-020.synserver.de (smtp-out-020.synserver.de
 [212.40.185.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A3F26516E
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:26:45 +0100 (CET)
In-Reply-To: <1420651312-21671-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

On 01/07/2015 06:21 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> The only usage of 'full_name' is inside an error message, which provides a
> rather verbose node path.
>
> A more concise error message can be obtained by using 'pdev->name' instead.

It's probably best to drop it altogether in that case. dev_err() already 
prints the name of the device.

  It
> also makes the kzalloc calculation simpler, as we don't need to take the length
> of full_name into account.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Buit tested only.
>
>   sound/soc/fsl/fsl_dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> index 026da0a..770de20 100644
> --- a/sound/soc/fsl/fsl_dma.c
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -897,12 +897,12 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
>   	ret = of_address_to_resource(ssi_np, 0, &res);
>   	if (ret) {
>   		dev_err(&pdev->dev, "could not determine resources for %s\n",
> -			ssi_np->full_name);
> +			pdev->name);
>   		of_node_put(ssi_np);
>   		return ret;
>   	}
>
> -	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
> +	dma = kzalloc(sizeof(*dma), GFP_KERNEL);

This should probably be part of patch 1.

>   	if (!dma) {
>   		dev_err(&pdev->dev, "could not allocate dma object\n");
>   		of_node_put(ssi_np);
>
