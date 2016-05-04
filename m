From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_sai: Introduce a
 compatible string for MX6UL
Date: Wed, 4 May 2016 14:51:56 -0700
Message-ID: <20160504215155.GA11381@Asurada-Nvidia>
References: <1462398172-24377-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B45FD26524C
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 23:51:55 +0200 (CEST)
Received: by mail-pa0-f43.google.com with SMTP id bt5so28109865pac.3
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 14:51:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462398172-24377-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, broonie@kernel.org, shawnguo@kernel.org, brain@jikos.cz
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2016 at 06:42:51PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> MX6UL may need to configure the General Purpose Register 1 (GPR1), so
> it is better to add a new compatible string to differentiate.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v1:
> - Newly introduced in this series.
> 
>  sound/soc/fsl/fsl_sai.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 0754df7..d8b673f 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -797,7 +797,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  
>  	sai->pdev = pdev;
>  
> -	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
> +	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai") ||
> +	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx6ul-sai"))
>  		sai->sai_on_imx = true;
>  
>  	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
> @@ -898,6 +899,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  static const struct of_device_id fsl_sai_ids[] = {
>  	{ .compatible = "fsl,vf610-sai", },
>  	{ .compatible = "fsl,imx6sx-sai", },
> +	{ .compatible = "fsl,imx6ul-sai", },

We may need to update binding doc as well?

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
> -- 
> 1.9.1
> 
