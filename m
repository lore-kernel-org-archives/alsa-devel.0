From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: fsl_sai: Allow setting the
 SAI MCLK direction
Date: Wed, 4 May 2016 16:11:49 -0700
Message-ID: <20160504231148.GB17009@Asurada-Nvidia>
References: <1462401239-995-1-git-send-email-festevam@gmail.com>
 <1462401239-995-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 11482265CC7
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 01:11:43 +0200 (CEST)
Received: by mail-pf0-f180.google.com with SMTP id 206so30501059pfu.0
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 16:11:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462401239-995-2-git-send-email-festevam@gmail.com>
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

On Wed, May 04, 2016 at 07:33:59PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> On mx6ul the General Purpose Register 1 (GPR1) contains the following
> bits for configuring the direction of the SAI MCLKs:
> SAI1_MCLK_DIR, SAI2_MCLK_DIR, SAI3_MCLK_DIR
> 
> Introduce  the "fsl,sai-mclk-direction-output" optional property to allow
> configuring the SAI_MCLK outputs.
> 
> Tested on a imx6ul-evk board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
Nicolin

> ---
> Changes since v2:
> - Use of_alias_get_id() (Nicolin)
> 
>  Documentation/devicetree/bindings/sound/fsl-sai.txt |  5 +++++
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h         |  6 ++++++
>  sound/soc/fsl/fsl_sai.c                             | 20 ++++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 777b941..740b467 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -48,6 +48,11 @@ Required properties:
>  			  receive data by following their own bit clocks and
>  			  frame sync clocks separately.
>  
> +Optional properties (for mx6ul):
> +
> +  - fsl,sai-mclk-direction-output: This is a boolean property. If present,
> +			 indicates that SAI will output the SAI MCLK clock.
> +
>  Note:
>  - If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
>    default synchronous mode (sync Rx with Tx) will be used, which means both
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index 238c8db..6835382 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -447,5 +447,11 @@
>  #define IMX6UL_GPR1_ENET2_CLK_OUTPUT		(0x1 << 18)
>  #define IMX6UL_GPR1_ENET_CLK_DIR		(0x3 << 17)
>  #define IMX6UL_GPR1_ENET_CLK_OUTPUT		(0x3 << 17)
> +#define IMX6UL_GPR1_SAI1_MCLK_DIR		(0x1 << 19)
> +#define IMX6UL_GPR1_SAI2_MCLK_DIR		(0x1 << 20)
> +#define IMX6UL_GPR1_SAI3_MCLK_DIR		(0x1 << 21)
> +#define IMX6UL_GPR1_SAI_MCLK_MASK		(0x7 << 19)
> +#define MCLK_DIR(x) (x == 1 ? IMX6UL_GPR1_SAI1_MCLK_DIR : x == 2 ? \
> +		     IMX6UL_GPR1_SAI2_MCLK_DIR : IMX6UL_GPR1_SAI3_MCLK_DIR)
>  
>  #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d8b673f..2147994 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -21,6 +21,8 @@
>  #include <sound/core.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm_params.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  
>  #include "fsl_sai.h"
>  #include "imx-pcm.h"
> @@ -786,10 +788,12 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct fsl_sai *sai;
> +	struct regmap *gpr;
>  	struct resource *res;
>  	void __iomem *base;
>  	char tmp[8];
>  	int irq, ret, i;
> +	int index;
>  
>  	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
>  	if (!sai)
> @@ -878,6 +882,22 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		fsl_sai_dai.symmetric_samplebits = 0;
>  	}
>  
> +	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
> +	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx6ul-sai")) {
> +		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
> +		if (IS_ERR(gpr)) {
> +			dev_err(&pdev->dev, "cannot find iomuxc registers\n");
> +			return PTR_ERR(gpr);
> +		}
> +
> +		index = of_alias_get_id(np, "sai");
> +		if (index < 0)
> +			return index;
> +
> +		regmap_update_bits(gpr, IOMUXC_GPR1, MCLK_DIR(index),
> +				   MCLK_DIR(index));
> +	}
> +
>  	sai->dma_params_rx.addr = res->start + FSL_SAI_RDR;
>  	sai->dma_params_tx.addr = res->start + FSL_SAI_TDR;
>  	sai->dma_params_rx.maxburst = FSL_SAI_MAXBURST_RX;
> -- 
> 1.9.1
> 
