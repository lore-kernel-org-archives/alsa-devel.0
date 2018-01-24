From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: atom: fix ACPI/PCI Kconfig
Date: Wed, 24 Jan 2018 08:46:33 +0200
Message-ID: <1516776393.7000.1207.camel@linux.intel.com>
References: <20180124002712.28984-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124002712.28984-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-01-23 at 18:27 -0600, Pierre-Louis Bossart wrote:
> The split between ACPI and PCI platforms generated issues with
> randconfig:
> 
> with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
> SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:
> 
> ERROR: "sst_context_init"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "sst_context_cleanup"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "sst_alloc_drv_context"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko]
> undefined!
> 
> ERROR: "sst_configure_runtime_pm"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> To keep things simple, let's expose two configs for
> SND_SST_ATOM_HIFI2_PLATFORM_PCI and SND_SST_ATOM_HIFI2_PLATFORM_ACPI,
> which select a common SND_SST_ATOM_HIFI2_PLATFORM option. To avoid
> breaking existing solutions with the semantics change,
> SND_SST_ATOM_HIFI2_PLATFORM_ACPI uses "default ACPI" so that "make
> oldnoconfig" and "make olddefconfig" still work as expected.
> 
> Also remove mentions of Medfield while we are at it since it was
> removed recently.

Thanks for taking care of this! FWIW,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Arnd Bergmann <arnd@arndb.de>

> Fixes: 4772c16ede52 ("ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI
> dependencies")

Do we need / can keep this on one line?

> Signed-off-by: Pierre-Louis Bossart <pierre-
> louis.bossart@linux.intel.com>
> ---
>  sound/soc/intel/Kconfig | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index f2c9e8c5970a..d7ac77b0197b 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -72,24 +72,28 @@ config SND_SOC_INTEL_BAYTRAIL
>  	  for Baytrail Chromebooks but this option is now deprecated
> and is
>  	  not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
>  
> +config SND_SST_ATOM_HIFI2_PLATFORM
> +	tristate
> +	select SND_SOC_COMPRESS
> +
>  config SND_SST_ATOM_HIFI2_PLATFORM_PCI
> -	tristate "PCI HiFi2 (Medfield, Merrifield) Platforms"
> +	tristate "PCI HiFi2 (Merrifield) Platforms"
>  	depends on X86 && PCI
>  	select SND_SST_IPC_PCI
> -	select SND_SOC_COMPRESS
> +	select SND_SST_ATOM_HIFI2_PLATFORM
>  	help
> -	  If you have a Intel Medfield or Merrifield/Edison platform,
> then
> +	  If you have a Intel Merrifield/Edison platform, then
>  	  enable this option by saying Y or m. Distros will typically
> not
> -	  enable this option: Medfield devices are not available to
> -	  developers and while Merrifield/Edison can run a mainline
> kernel with
> -	  limited functionality it will require a firmware file which
> -	  is not in the standard firmware tree
> +	  enable this option: while Merrifield/Edison can run a
> mainline
> +	  kernel with limited functionality it will require a
> firmware file
> +	  which is not in the standard firmware tree
>  
> -config SND_SST_ATOM_HIFI2_PLATFORM
> +config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>  	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
> +	default ACPI
>  	depends on X86 && ACPI
>  	select SND_SST_IPC_ACPI
> -	select SND_SOC_COMPRESS
> +	select SND_SST_ATOM_HIFI2_PLATFORM
>  	select SND_SOC_ACPI_INTEL_MATCH
>  	select IOSF_MBI
>  	help

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
