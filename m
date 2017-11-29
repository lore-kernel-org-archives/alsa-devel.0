From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC PATCH v2 1/7] ASoC: Intel: Fix Kconfig with top-level
 selector
Date: Wed, 29 Nov 2017 15:57:34 +0530
Message-ID: <20171129102734.GA32417@localhost>
References: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
 <20171129014551.30552-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171129014551.30552-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 28, 2017 at 07:45:45PM -0600, Pierre-Louis Bossart wrote:

I am not sure about top level being default to Y...

>  config SND_SST_ATOM_HIFI2_PLATFORM
>  	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
> -	depends on SND_SOC_INTEL_SST_TOPLEVEL && X86
> +	depends on X86
>  	select SND_SOC_COMPRESS
> +	select SND_SOC_INTEL_COMMON
>  
>  config SND_SOC_INTEL_SKYLAKE
>  	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
> -	depends on SND_SOC_INTEL_SST_TOPLEVEL && PCI && ACPI
> +	depends on PCI && ACPI
>  	select SND_HDA_EXT_CORE
>  	select SND_HDA_DSP_LOADER
>  	select SND_SOC_TOPOLOGY
>  	select SND_SOC_INTEL_SST
> +	select SND_SOC_INTEL_COMMON
> +	help
> +	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
> +	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
> +	  then enable this option by saying Y or m.

this is good stuff, helps in improving UX vastly. Btw can we have select ALL
machine also as an option for people who dont want to select a specfic one,
that one will really help for a better UX

> +
> +endif ## SND_SOC_INTEL_SST_TOPLEVEL
>  
>  # ASoC codec drivers
>  source "sound/soc/intel/boards/Kconfig"
> +
> +# configs common to SST and SOF to compile sound/soc/intel/common
> +# directory and use matching tables
> +
> +config SND_SOC_INTEL_COMMON
> +	tristate
> +	select SND_SOC_ACPI_INTEL_MATCH if ACPI

common selects only MATCH

> +	# this option controls the compilation of the sound/soc/intel/common
> +	# directory and is not meant to be selected by the user. It is
> +	# not filtered out on purpose by the top-level selector since
> +	# it will be selected by SST or SOF platform driver options
> +
> +config SND_SOC_ACPI_INTEL_MATCH
> +	tristate
> +	select SND_SOC_ACPI if ACPI

then why keep common, lets remove one level and have
SND_SOC_ACPI_INTEL_MATCH selected. ACPI is must have at top level so we can
add depends on that symbol

-- 
~Vinod
