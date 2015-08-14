From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: add wm8960 support
Date: Fri, 14 Aug 2015 12:19:02 -0700
Message-ID: <20150814191901.GA9884@Asurada>
References: <d873df2b23a6d39099b3c62db8901d78a60d9362.1439550574.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 04856266189
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 21:19:16 +0200 (CEST)
Received: by pacgr6 with SMTP id gr6so65484551pac.2
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 12:19:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d873df2b23a6d39099b3c62db8901d78a60d9362.1439550574.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 14, 2015 at 07:11:09PM +0800, Zidan Wang wrote:
> add wm8960 support for fsl-asoc-card
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---

Please put a change log between these two lines next time.

Thanks
Nicolin

>  sound/soc/fsl/fsl-asoc-card.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 040362f..5aeb6ed 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -23,6 +23,7 @@
>  
>  #include "../codecs/sgtl5000.h"
>  #include "../codecs/wm8962.h"
> +#include "../codecs/wm8960.h"
>  
>  #define RX 0
>  #define TX 1
> @@ -479,6 +480,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  		priv->codec_priv.fll_id = WM8962_SYSCLK_FLL;
>  		priv->codec_priv.pll_id = WM8962_FLL;
>  		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
> +	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8960")) {
> +		codec_dai_name = "wm8960-hifi";
> +		priv->card.set_bias_level = fsl_asoc_card_set_bias_level;
> +		priv->codec_priv.fll_id = WM8960_SYSCLK_AUTO;
> +		priv->codec_priv.pll_id = WM8960_SYSCLK_AUTO;
> +		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
>  	} else {
>  		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
>  		return -EINVAL;
> @@ -582,6 +589,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
>  	{ .compatible = "fsl,imx-audio-cs42888", },
>  	{ .compatible = "fsl,imx-audio-sgtl5000", },
>  	{ .compatible = "fsl,imx-audio-wm8962", },
> +	{ .compatible = "fsl,imx-audio-wm8960", },
>  	{}
>  };
>  
> -- 
> 1.9.1
> 
