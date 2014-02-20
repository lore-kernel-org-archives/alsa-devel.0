From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 2/2] ASoC: fsl: Make Freescale SAI/ESAI/SPDIF to be
 visible in Kconfig
Date: Thu, 20 Feb 2014 02:06:20 +0000
Message-ID: <36d9c0a870604fbe87b129e95fea9da1@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392086825-15737-1-git-send-email-Li.Xiubo@freescale.com>
 <1392086825-15737-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392086825-15737-2-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
Cc: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I'm not very sure of this patch, maybe should we add one menu
in Kconfig for all visible CPU DAIs firstly like for code drivers?

Thanks,

--
Best Regards,
Xiubo


> Subject: [PATCH 2/2] ASoC: fsl: Make Freescale SAI/ESAI/SPDIF to be visible in
> Kconfig
> 
> For simple card since the whole idea is to support any CODEC and
> any CPU DAI with the same driver, we should probably just make sure
> that all the individual CODEC and CPU DAI drivers can be enabled in
> Kconfig. That way we don't have to have specific Kconfig entries for
> boards and loose some of the benefit of the generic card.
> 
> This will make the Freescale SAI/ESAI/SPDIF device be visible in
> Kconfig.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
> Cc: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/fsl/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index d0914c0..f397144 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -1,5 +1,5 @@
>  config SND_SOC_FSL_SAI
> -	tristate
> +	tristate "ALSA SoC support for the Freescale SAI device"
>  	select REGMAP_MMIO
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
> 
> @@ -7,11 +7,11 @@ config SND_SOC_FSL_SSI
>  	tristate
> 
>  config SND_SOC_FSL_SPDIF
> -	tristate
> +	tristate "ALSA SoC support for the Freescale SPDIF device"
>  	select REGMAP_MMIO
> 
>  config SND_SOC_FSL_ESAI
> -	tristate
> +	tristate "ALSA SoC support for the Freescale ESAI device"
>  	select REGMAP_MMIO
> 
>  config SND_SOC_FSL_UTILS
> --
> 1.8.4
> 
