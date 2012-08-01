From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] ASoC: Samsung: Update Kconfig for Exynos5250 and Exynos4412
Date: Wed, 01 Aug 2012 12:06:57 +0900
Message-ID: <030901cd6f92$b5fc6da0$21f548e0$%kim@samsung.com>
References: <1343218351-30577-1-git-send-email-padma.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1343218351-30577-1-git-send-email-padma.v@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Padmavathi Venna' <padma.v@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org
Cc: rcsekar@samsung.com, sbkim73@samsung.com, sangsu4u.park@samsung.com, ben-linux@fluff.org, olofj@google.com, thutt@chromium.org, joshi@samsung.com
List-Id: alsa-devel@alsa-project.org

Padmavathi Venna wrote:
> 
> Update Kconfig file to support the Exynos5250 and Exynos4412
> 
> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  sound/soc/samsung/Kconfig |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index fe3995c..d54e400 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -1,6 +1,6 @@
>  config SND_SOC_SAMSUNG
>  	tristate "ASoC support for Samsung"
> -	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 ||
> ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_EXYNOS4
> +	depends on PLAT_SAMSUNG
>  	select S3C64XX_DMA if ARCH_S3C64XX
>  	select S3C2410_DMA if ARCH_S3C24XX
>  	help
> @@ -63,7 +63,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
> 
>  config SND_SOC_SAMSUNG_SMDK_WM8994
>  	tristate "SoC I2S Audio support for WM8994 on SMDK"
> -	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 ||
> MACH_SMDK4212)
> +	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 ||
> MACH_SMDK4212 || MACH_SMDK4412 || SOC_EXYNOS5250)

Well, do you think _really_ all board which has a EXYNOS5250 SoC is needed
this config?

I don't think so?

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
