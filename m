From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add Kconfig to support
	SMDK4212
Date: Tue, 23 Aug 2011 20:25:55 +0100
Message-ID: <4E53FEC3.9070506@ti.com>
References: <1314093548-2208-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 132F3244A0
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 21:26:03 +0200 (CEST)
In-Reply-To: <1314093548-2208-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 23/08/11 10:59, Sangbeom Kim wrote:
> This patch adds Kconfig to support SMDK4212.
> SMDK4212 is based on samsung exynos4212 SoC.
> And WM8994 is used for audio codec.
> 
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/samsung/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index b99091f..9a3138b 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -63,7 +63,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
>  
>  config SND_SOC_SAMSUNG_SMDK_WM8994
>  	tristate "SoC I2S Audio support for WM8994 on SMDK"
> -	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
> +	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 || MACH_SMDK4212)
>  	select SND_SOC_WM8994
>  	select SND_SAMSUNG_I2S
>  	help
> @@ -158,7 +158,7 @@ config SND_SOC_GONI_AQUILA_WM8994
>  
>  config SND_SOC_SAMSUNG_SMDK_SPDIF
>  	tristate "SoC S/PDIF Audio support for SMDK"
> -	depends on SND_SOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210 || MACH_SMDKV310)
> +	depends on SND_SOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210 || MACH_SMDKV310 || MACH_SMDK4212)
>  	select SND_SAMSUNG_SPDIF
>  	help
>  	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
> @@ -173,7 +173,7 @@ config SND_SOC_SMDK_WM8580_PCM
>  
>  config SND_SOC_SMDK_WM8994_PCM
>  	tristate "SoC PCM Audio support for WM8994 on SMDK"
> -	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310)
> +	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310 || MACH_SMDK4212)
>  	select SND_SOC_WM8994
>  	select SND_SAMSUNG_PCM
>  	help
