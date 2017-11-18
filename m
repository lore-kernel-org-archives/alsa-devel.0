From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 7/7] ASoC: Intel: boards: align/fix
 SKL/BXT/KBL Kconfigs
Date: Sat, 18 Nov 2017 19:14:02 +0200
Message-ID: <1511025242.25007.321.camel@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 04EC5266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 18:14:06 +0100 (CET)
In-Reply-To: <20171118000202.22302-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-11-17 at 18:02 -0600, Pierre-Louis Bossart wrote:
> No reason why SND_SOC_INTEL_SST should be set here.
> Also make sure same dependencies are used everywhere (only last one
> has SPI
> in addition)

Regarding to my comment against previous patch...

>  config SND_SOC_INTEL_SKL_RT286_MACH
>  	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
> -	depends on X86 && ACPI && I2C
> +	depends on X86_INTEL_LPSS && I2C && ACPI

Skylake -> No.

>  config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
>  	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567
> in I2S Mode"
> -	depends on X86_INTEL_LPSS && I2C
> +	depends on X86_INTEL_LPSS && I2C && ACPI

Skylake -> No.

>  config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
>  	tristate "ASoC Audio driver for SKL with NAU88L25 and
> MAX98357A in I2S Mode"
> -	depends on X86_INTEL_LPSS && I2C
> +	depends on X86_INTEL_LPSS && I2C && ACPI

Skylake -> No.
 
>  config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
>  	tristate "ASoC Audio driver for Broxton with DA7219 and
> MAX98357A in I2S Mode"
> -	depends on X86 && ACPI && I2C
> +	depends on X86_INTEL_LPSS && I2C && ACPI

Broxton -> No.

>  config SND_SOC_INTEL_BXT_RT298_MACH
>  	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
> -	depends on X86 && ACPI && I2C
> +	depends on X86_INTEL_LPSS && I2C && ACPI

Broxton -> No.

>  config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
>  	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927
> in I2S Mode"
> -	depends on X86_INTEL_LPSS && I2C
> -	select SND_SOC_INTEL_SST
> +	depends on X86_INTEL_LPSS && I2C && ACPI

Kabylake -> No.
 
>  config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
>          tristate "ASoC Audio driver for KBL with RT5663, RT5514 and
> MAX98927 in I2S Mode"
> -        depends on X86_INTEL_LPSS && I2C && SPI
> -        select SND_SOC_INTEL_SST
> +        depends on X86_INTEL_LPSS && I2C && SPI && ACPI

Kabylake -> No.

This patch WRT X86_INTEL_LPSS for selected SoCs does not make any sense.


Perhaps you need to depend on

MFD_INTEL_LPSS (Skylake and newer)

instead.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
