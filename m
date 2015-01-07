From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: fsl_ssi: Make error message
	concise
Date: Wed, 7 Jan 2015 10:43:20 -0800
Message-ID: <20150107184319.GA2576@Asurada>
References: <1420645476-13193-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f45.google.com (mail-yh0-f45.google.com
 [209.85.213.45])
 by alsa0.perex.cz (Postfix) with ESMTP id D7D42260558
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 19:43:30 +0100 (CET)
Received: by mail-yh0-f45.google.com with SMTP id f10so897100yha.32
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 10:43:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420645476-13193-1-git-send-email-festevam@gmail.com>
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

On Wed, Jan 07, 2015 at 01:44:32PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Currently the error message uses 'np->full_name' which leads to a very verbose
> log as:
> 
> fsl-ssi-dai 202c000.ssi: no irq for node /soc/aips-bus@02000000/spba-bus@02000000/ssi@0202c000
> 
> We can have a concise log by using pdev->name instead:
> 
> fsl-ssi-dai 202c000.ssi: no irq for node 202c000.ssi
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

For all these 5 patches,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
Nicolin

> ---
>  sound/soc/fsl/fsl_ssi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index a65f17d..fa19507 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1363,7 +1363,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  
>  	ssi_private->irq = platform_get_irq(pdev, 0);
>  	if (!ssi_private->irq) {
> -		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
> +		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
>  		return -ENXIO;
>  	}
>  
> -- 
> 1.9.1
> 
