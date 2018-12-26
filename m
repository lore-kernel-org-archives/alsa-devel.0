From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date: Wed, 26 Dec 2018 11:35:05 -0600
Message-ID: <39200a36-6592-f010-8309-a249a8d514f4@linux.intel.com>
References: <20181223232521.11320-1-okaya@kernel.org>
 <20181223232521.11320-9-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181223232521.11320-9-okaya@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


On 12/23/18 5:25 PM, Sinan Kaya wrote:
> Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> CONFIG_PCI set but this is not specified anywhere.

Can you please share the .config that exposes this problem? This hasn't 
changed in a long time and I wonder why this pops up now. You have 
similar cases elsewhere, e.g. arch/x86/Kconfig

config X86_INTEL_LPSS
     bool "Intel Low Power Subsystem Support"
     depends on X86 && ACPI
     select COMMON_CLK
     select PINCTRL
     select IOSF_MBI

or for the MMC.

config MMC_SDHCI_ACPI
     tristate "SDHCI support for ACPI enumerated SDHCI controllers"
     depends on MMC_SDHCI && ACPI
     select IOSF_MBI if X86

The use of IOSF_MBI is only for the Baytrail-CR detection and there are 
already in-flight patches to change the code and move it to a helper.

My understanding is that for compilation you only need CONFIG_x86 since 
there are fall-back routines available in iosf_mbi.h

Thanks!

>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>   sound/soc/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 2fd1b61e8331..b0764b2fe001 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>   config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>   	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>   	default ACPI
> -	depends on X86 && ACPI
> +	depends on X86 && ACPI && PCI
>   	select SND_SST_IPC_ACPI
>   	select SND_SST_ATOM_HIFI2_PLATFORM
>   	select SND_SOC_ACPI_INTEL_MATCH
