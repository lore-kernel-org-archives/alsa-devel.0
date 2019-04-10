From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Make boards more available
	for compile test
Date: Wed, 10 Apr 2019 13:05:40 -0500
Message-ID: <765c0d7b-8589-b1ba-3592-59ecb0cc22d0@linux.intel.com>
References: <20190410163800.31376-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDAECF89616
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 20:05:43 +0200 (CEST)
In-Reply-To: <20190410163800.31376-1-broonie@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 4/10/19 11:38 AM, Mark Brown wrote:
> The Intel boards have very strict dependencies which make them less
> available for compile test than is desirable, with requirements for
> specific drivers that are only needed at runtime but not at build time.
> Relax this a bit if COMPILE_TEST is enabled to improve build coverage
> for these drivers.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

It's really asking for trouble but it's the right thing to do. Let's see 
how many issues get reported...

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/Kconfig | 79 +++++++++++++++++++++++-----------
>   1 file changed, 54 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index 12d6b73e9531..07b1a02934f1 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -16,7 +16,9 @@ if SND_SOC_INTEL_HASWELL
>   
>   config SND_SOC_INTEL_HASWELL_MACH
>   	tristate "Haswell Lynxpoint"
> -	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
> +	depends on I2C
> +	depends on I2C_DESIGNWARE_PLATFORM || COMPILE_TEST
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT5640
>   	help
>   	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
> @@ -26,7 +28,10 @@ config SND_SOC_INTEL_HASWELL_MACH
>   
>   config SND_SOC_INTEL_BDW_RT5677_MACH
>   	tristate "Broadwell with RT5677 codec"
> -	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM && GPIOLIB
> +	depends on I2C
> +	depends on I2C_DESIGNWARE_PLATFORM || COMPILE_TEST
> +	depends on GPIOLIB || COMPILE_TEST
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT5677
>   	help
>   	  This adds support for Intel Broadwell platform based boards with
> @@ -36,7 +41,9 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
>   
>   config SND_SOC_INTEL_BROADWELL_MACH
>   	tristate "Broadwell Wildcatpoint"
> -	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
> +	depends on I2C
> +	depends on I2C_DESIGNWARE_PLATFORM || COMPILE_TEST
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT286
>   	help
>   	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
> @@ -49,7 +56,8 @@ if SND_SOC_INTEL_BAYTRAIL
>   
>   config SND_SOC_INTEL_BYT_MAX98090_MACH
>   	tristate "Baytrail with MAX98090 codec"
> -	depends on X86_INTEL_LPSS && I2C
> +	depends on I2C
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_MAX98090
>   	help
>   	  This adds audio driver for Intel Baytrail platform based boards
> @@ -59,7 +67,8 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
>   
>   config SND_SOC_INTEL_BYT_RT5640_MACH
>   	tristate "Baytrail with RT5640 codec"
> -	depends on X86_INTEL_LPSS && I2C
> +	depends on I2C
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT5640
>   	help
>   	  This adds audio driver for Intel Baytrail platform based boards
> @@ -72,7 +81,8 @@ if SND_SST_ATOM_HIFI2_PLATFORM
>   
>   config SND_SOC_INTEL_BYTCR_RT5640_MACH
>   	tristate "Baytrail and Baytrail-CR with RT5640 codec"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_ACPI
>   	select SND_SOC_RT5640
>   	help
> @@ -83,7 +93,8 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
>   
>   config SND_SOC_INTEL_BYTCR_RT5651_MACH
>   	tristate "Baytrail and Baytrail-CR with RT5651 codec"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_ACPI
>   	select SND_SOC_RT5651
>   	help
> @@ -94,7 +105,8 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
>   
>   config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
>   	tristate "Cherrytrail & Braswell with RT5672 codec"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_ACPI
>   	select SND_SOC_RT5670
>           help
> @@ -105,7 +117,8 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
>   
>   config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
>   	tristate "Cherrytrail & Braswell with RT5645/5650 codec"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_ACPI
>   	select SND_SOC_RT5645
>   	help
> @@ -116,7 +129,8 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
>   
>   config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
>   	tristate "Cherrytrail & Braswell with MAX98090 & TI codec"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_MAX98090
>   	select SND_SOC_TS3A227E
>   	help
> @@ -127,7 +141,8 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
>   
>   config SND_SOC_INTEL_CHT_BSW_NAU8824_MACH
>   	tristate "Cherrytrail & Braswell with NAU88L24 codec"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_ACPI
>   	select SND_SOC_NAU8824
>   	help
> @@ -138,7 +153,8 @@ config SND_SOC_INTEL_CHT_BSW_NAU8824_MACH
>   
>   config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
>   	tristate "Baytrail & Cherrytrail with DA7212/7213 codec"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_ACPI
>   	select SND_SOC_DA7213
>   	help
> @@ -149,7 +165,8 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
>   
>   config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
>   	tristate "Baytrail & Cherrytrail with ES8316 codec"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_ACPI
>   	select SND_SOC_ES8316
>   	help
> @@ -160,7 +177,8 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
>   
>   config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
>   	tristate "Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
> -	depends on X86_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on X86_INTEL_LPSS || COMPILE_TEST
>   	help
>   	  This adds support for ASoC machine driver for the MinnowBoard Max or
>   	  Up boards and provides access to I2S signals on the Low-Speed
> @@ -176,7 +194,8 @@ if SND_SOC_INTEL_SKL
>   
>   config SND_SOC_INTEL_SKL_RT286_MACH
>   	tristate "SKL with RT286 I2S mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT286
>   	select SND_SOC_DMIC
>   	select SND_SOC_HDAC_HDMI
> @@ -188,7 +207,8 @@ config SND_SOC_INTEL_SKL_RT286_MACH
>   
>   config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
>   	tristate "SKL with NAU88L25 and SSM4567 in I2S Mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_NAU8825
>   	select SND_SOC_SSM4567
>   	select SND_SOC_DMIC
> @@ -201,7 +221,8 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
>   
>   config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
>   	tristate "SKL with NAU88L25 and MAX98357A in I2S Mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_NAU8825
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_DMIC
> @@ -218,7 +239,8 @@ if SND_SOC_INTEL_APL
>   
>   config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
>   	tristate "Broxton with DA7219 and MAX98357A in I2S Mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_DA7219
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_DMIC
> @@ -232,7 +254,8 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
>   
>   config SND_SOC_INTEL_BXT_RT298_MACH
>   	tristate "Broxton with RT298 I2S mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT298
>   	select SND_SOC_DMIC
>   	select SND_SOC_HDAC_HDMI
> @@ -249,7 +272,8 @@ if SND_SOC_INTEL_KBL
>   
>   config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
>   	tristate "KBL with RT5663 and MAX98927 in I2S Mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT5663
>   	select SND_SOC_MAX98927
>   	select SND_SOC_DMIC
> @@ -263,7 +287,8 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
>   
>   config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
>           tristate "KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
> -        depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>           depends on SPI
>           select SND_SOC_RT5663
>           select SND_SOC_RT5514
> @@ -278,7 +303,8 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
>   
>   config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
>   	tristate "KBL with DA7219 and MAX98357A in I2S Mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_DA7219
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_DMIC
> @@ -290,7 +316,8 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
>   
>   config SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH
>   	tristate "KBL with DA7219 and MAX98927 in I2S Mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_DA7219
>   	select SND_SOC_MAX98927
>   	select SND_SOC_MAX98373
> @@ -304,7 +331,8 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH
>   
>   config SND_SOC_INTEL_KBL_RT5660_MACH
>   	tristate "KBL with RT5660 in I2S Mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT5660
>   	select SND_SOC_HDAC_HDMI
>   	help
> @@ -318,7 +346,8 @@ if SND_SOC_INTEL_GLK
>   
>   config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
>   	tristate "GLK with RT5682 and MAX98357A in I2S Mode"
> -	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>   	select SND_SOC_RT5682
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_DMIC
> 
