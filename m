From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: fix build when ACPI is not
 enabled
Date: Mon, 13 Jun 2016 09:52:33 +0530
Message-ID: <20160613042233.GX16910@localhost>
References: <575A0362.2080604@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575A0362.2080604@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2016 at 05:01:38PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> kconfig tools generate the following warning when CONFIG_ACPI is not
> enabled:
> 
> warning: (SND_SOC_INTEL_BYTCR_RT5640_MACH && SND_SOC_INTEL_BYTCR_RT5651_MACH && SND_SOC_INTEL_CHT_BSW_RT5672_MACH && SND_SOC_INTEL_CHT_BSW_RT5645_MACH && SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) selects SND_SST_IPC_ACPI which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && ACPI)
> 
> causing these build errors:
> 
> In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:40:0:
> ../include/acpi/acpi_bus.h:65:20: error: conflicting types for 'acpi_evaluate_dsm'
>  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
> In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:31:0:
> ../include/linux/acpi.h:676:34: note: previous definition of 'acpi_evaluate_dsm' was here
>  static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,
> 
> I am told that ACPI is a requirement for these drivers, so make that
> explicit. Also end help text sentences with a period.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	Jie Yang <yang.jie@linux.intel.com>
> Cc:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc:	alsa-devel@alsa-project.org
> ---
>  sound/soc/intel/Kconfig |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Should SND_SOC_INTEL_SST and possibly other similar drivers get this
> same change?

The SND_SST_IPC_ACPI has depends on ACPI.

Can you send me your config for this.


> 
> --- linux-next-20160607.orig/sound/soc/intel/Kconfig
> +++ linux-next-20160607/sound/soc/intel/Kconfig
> @@ -128,28 +128,28 @@ config SND_SOC_INTEL_BROADWELL_MACH
>  
>  config SND_SOC_INTEL_BYTCR_RT5640_MACH
>          tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
> -	depends on X86 && I2C
> +	depends on X86 && I2C && ACPI
>  	select SND_SOC_RT5640
>  	select SND_SST_MFLD_PLATFORM
>  	select SND_SST_IPC_ACPI
> -	select SND_SOC_INTEL_SST_MATCH if ACPI
> +	select SND_SOC_INTEL_SST_MATCH
>  	help
>            This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
>            platforms with RT5640 audio codec.
> -          Say Y if you have such a device
> +          Say Y if you have such a device.
>            If unsure select "N".
>  
>  config SND_SOC_INTEL_BYTCR_RT5651_MACH
>          tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
> -	depends on X86 && I2C
> +	depends on X86 && I2C && ACPI
>  	select SND_SOC_RT5651
>  	select SND_SST_MFLD_PLATFORM
>  	select SND_SST_IPC_ACPI
> -	select SND_SOC_INTEL_SST_MATCH if ACPI
> +	select SND_SOC_INTEL_SST_MATCH
>  	help
>            This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
>            platforms with RT5651 audio codec.
> -          Say Y if you have such a device
> +          Say Y if you have such a device.
>            If unsure select "N".
>  
>  config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
