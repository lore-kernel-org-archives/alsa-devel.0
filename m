From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 9/9] ASoC: Intel: kconfig: add some comments for if
 symbols
Date: Wed, 03 Jan 2018 19:07:50 +0200
Message-ID: <1514999270.7000.595.camel@linux.intel.com>
References: <20180103165022.4984-1-pierre-louis.bossart@linux.intel.com>
         <20180103165022.4984-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103165022.4984-10-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-01-03 at 10:50 -0600, Pierre-Louis Bossart wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> Helps in finding if endings

Seems some (all?) comments not been addressed.
See below.
 
>  config SND_SOC_INTEL_BAYTRAIL
> -	tristate "Intel ASoC SST driver for Baytrail (legacy)"
> +	tristate "Baytrail (legacy) Platforms"
>  	depends on DMADEVICES && ACPI
>  	select SND_SOC_INTEL_SST
>  	select SND_SOC_INTEL_SST_ACPI
> @@ -73,7 +73,7 @@ config SND_SOC_INTEL_BAYTRAIL
>  	  not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
>  
>  config SND_SST_ATOM_HIFI2_PLATFORM_PCI
> -	tristate "Intel ASoC SST driver for PCI HiFi2 platforms
> (Medfield, Merrifield)"
> +	tristate "PCI HiFi2 platforms (Medfield, Merrifield)
> platforms"

platforms ... platforms.

Moreover, perhaps use above pattern "... Platforms" ?

>  	depends on X86 && PCI
>  	select SND_SST_IPC_PCI
>  	select SND_SOC_COMPRESS
> @@ -87,7 +87,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>  	  is not in the standard firmware tree
>  
>  config SND_SST_ATOM_HIFI2_PLATFORM
> -	tristate "Intel ASoC SST driver for ACPI HiFi2 platforms
> (Baytrail, Cherrytrail)"
> +	tristate "ACPI HiFi2 platforms (Baytrail, Cherrytrail)
> Platforms"

Ditto.
 
>  config SND_MFLD_MACHINE
> -	tristate "SOC Machine Audio driver for Intel Medfield MID
> platform"
> +	tristate "Intel Medfield MID"

Perhaps "Medfield (Intel MID)" ?

At least it looks to me more consistent with the rest.

>  config SND_SOC_INTEL_HASWELL_MACH
> -	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
> +	tristate "Haswell Lynxpoint"
>  	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
>  	select SND_SOC_RT5640
>  	help

>  config SND_SOC_INTEL_BROADWELL_MACH
> -	tristate "ASoC Audio DSP support for Intel Broadwell
> Wildcatpoint"
> +	tristate "Intel Broadwell Wildcatpoint"

Drop Intel.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
