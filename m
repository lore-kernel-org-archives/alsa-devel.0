From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: fix TXCLK_DF mask
Date: Tue, 19 Feb 2019 10:56:07 -0800
Message-ID: <20190219185606.GA13373@Asurada-Nvidia.nvidia.com>
References: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2019 at 02:12:17PM +0000, Viorel Suman wrote:
> According to RM SPDIF TXCLK_DF mask is 7-bit wide.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
> index 7666dab..e6c61e0 100644
> --- a/sound/soc/fsl/fsl_spdif.h
> +++ b/sound/soc/fsl/fsl_spdif.h
> @@ -152,7 +152,7 @@ enum spdif_gainsel {
>  #define STC_TXCLK_ALL_EN_MASK		(1 << STC_TXCLK_ALL_EN_OFFSET)
>  #define STC_TXCLK_ALL_EN		(1 << STC_TXCLK_ALL_EN_OFFSET)
>  #define STC_TXCLK_DF_OFFSET		0
> -#define STC_TXCLK_DF_MASK		(0x7ff << STC_TXCLK_DF_OFFSET)
> +#define STC_TXCLK_DF_MASK		(0x7f << STC_TXCLK_DF_OFFSET)
>  #define STC_TXCLK_DF(x)		((((x) - 1) << STC_TXCLK_DF_OFFSET) & STC_TXCLK_DF_MASK)
>  #define STC_TXCLK_SRC_MAX		8
>  
> -- 
> 2.7.4
> 
