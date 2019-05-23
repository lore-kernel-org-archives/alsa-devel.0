From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoc: fix
 sound/soc/intel/skylake/slk-ssp-clk.c build error on IA64
Date: Thu, 23 May 2019 06:28:26 -0500
Message-ID: <6b89e370-90e3-6962-c71a-80919b7c6154@linux.intel.com>
References: <9019c87f-cf1a-b59f-d87e-8169b247cf88@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9019c87f-cf1a-b59f-d87e-8169b247cf88@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org



On 5/22/19 10:58 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> skl-ssp-clk.c does not build on IA64 because the driver
> uses the common clock interface, so make the driver depend
> on COMMON_CLK.
> 
> Fixes this build error:
> ../sound/soc/intel/skylake/skl-ssp-clk.c:26:16: error: field 'hw' has incomplete type
>    struct clk_hw hw;
>                  ^~
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: alsa-devel@alsa-project.org
> ---
>   sound/soc/intel/Kconfig        |    3 ++-
>   sound/soc/intel/boards/Kconfig |    2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> --- lnx-52-rc1.orig/sound/soc/intel/Kconfig
> +++ lnx-52-rc1/sound/soc/intel/Kconfig
> @@ -104,7 +104,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>   config SND_SOC_INTEL_SKYLAKE
>   	tristate "All Skylake/SST Platforms"
>   	depends on PCI && ACPI
> -	select SND_SOC_INTEL_SKL
> +	select SND_SOC_INTEL_SKL if COMMON_CLK

Is this really necessary? The COMMON_CLK is only needed for the 
SND_SOC_INTEL_SKYLAKE_SSP_CLK option, isn't it?

>   	select SND_SOC_INTEL_APL
>   	select SND_SOC_INTEL_KBL
>   	select SND_SOC_INTEL_GLK
> @@ -120,6 +120,7 @@ config SND_SOC_INTEL_SKYLAKE
>   config SND_SOC_INTEL_SKL
>   	tristate "Skylake Platforms"
>   	depends on PCI && ACPI
> +	depends on COMMON_CLK
>   	select SND_SOC_INTEL_SKYLAKE_FAMILY
>   	help
>   	  If you have a Intel Skylake platform with the DSP enabled
> --- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
> +++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
> @@ -286,7 +286,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927
>   	select SND_SOC_MAX98927
>   	select SND_SOC_DMIC
>   	select SND_SOC_HDAC_HDMI
> -	select SND_SOC_INTEL_SKYLAKE_SSP_CLK
> +	select SND_SOC_INTEL_SKYLAKE_SSP_CLK if COMMON_CLK

and here I would make it a depend. I guess your solution solves the 
compilation but doesn't fully represent the fact that this machine 
driver is not functional without COMMON_CLK+SKYLAKE_SSP_CLK.


>   	help
>   	  This adds support for ASoC Onboard Codec I2S machine driver. This will
>   	  create an alsa sound card for RT5663 + MAX98927.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
