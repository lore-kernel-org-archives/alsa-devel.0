From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: fsl_sai: Introduce a
 compatible string for MX6UL
Date: Wed, 4 May 2016 16:10:43 -0700
Message-ID: <20160504231042.GA17009@Asurada-Nvidia>
References: <1462401239-995-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id D6DEC2651FD
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 01:10:39 +0200 (CEST)
Received: by mail-pa0-f50.google.com with SMTP id iv1so28925111pac.2
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 16:10:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462401239-995-1-git-send-email-festevam@gmail.com>
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

On Wed, May 04, 2016 at 07:33:58PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> MX6UL may need to configure the General Purpose Register 1 (GPR1), so
> it is better to add a new compatible string to differentiate.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
Nicolin

> ---
> Changes since v2:
> - Add binding doc entry for mx6ul (Nicolin)
> 
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++--
>  sound/soc/fsl/fsl_sai.c                             | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 044e5d7..777b941 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -7,8 +7,8 @@ codec/DSP interfaces.
>  
>  Required properties:
>  
> -  - compatible		: Compatible list, contains "fsl,vf610-sai" or
> -			  "fsl,imx6sx-sai".
> +  - compatible		: Compatible list, contains "fsl,vf610-sai",
> +			  "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
>  
>    - reg			: Offset and length of the register set for the device.
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
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
> -- 
> 1.9.1
> 
