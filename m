From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 4/4] ASoC: Intel: rename
 SND_SST_MFLD_PLATFORM to SND_SST_MID_PLATFORM
Date: Mon, 2 Jan 2017 10:05:40 -0600
Message-ID: <c5228e73-d5cf-e4cd-b78b-24334e1fb5f3@linux.intel.com>
References: <20170102152017.13938-1-andriy.shevchenko@linux.intel.com>
 <20170102152017.13938-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D2552667F9
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 17:05:42 +0100 (CET)
In-Reply-To: <20170102152017.13938-5-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 01/02/2017 09:20 AM, Andy Shevchenko wrote:
> Rename SND_SST_MFLD_PLATFORM to SND_SST_MID_PLATFORM to make it clear that is
> not only about Medfield platform.
Does this change make sense? Medfield was a completely different 
platform and lumping everything under the same Kconfig option doesn't 
seem right to me... Plus we've stopped using 'mid' for years, no one 
would know what it stands for. The only clear architecture feature is 
the presence of the switch matrix that uniquely identifies all platforms 
based on Baytrail, Cherrytrail, Merrifield and Anniedale. 
Medfield/Clovertrail did not expose a switch matrix.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   sound/soc/intel/Kconfig       | 14 +++++++-------
>   sound/soc/intel/Makefile      |  2 +-
>   sound/soc/intel/atom/Makefile |  7 ++++---
>   3 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 7da8b9ceb728..c44da83c71a8 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -2,7 +2,7 @@ config SND_MFLD_MACHINE
>   	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
>   	depends on INTEL_SCU_IPC
>   	select SND_SOC_SN95031
> -	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_MID_PLATFORM
>   	select SND_SST_IPC_PCI
>   	help
>             This adds support for ASoC machine driver for Intel(R) MID Medfield platform
> @@ -10,7 +10,7 @@ config SND_MFLD_MACHINE
>             Say Y if you have such a device.
>             If unsure select "N".
>   
> -config SND_SST_MFLD_PLATFORM
> +config SND_SST_MID_PLATFORM
>   	tristate
>   	select SND_SOC_COMPRESS
>   
> @@ -137,7 +137,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
>           tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
>   	depends on X86 && I2C && ACPI
>   	select SND_SOC_RT5640
> -	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_MID_PLATFORM
>   	select SND_SST_IPC_ACPI
>   	select SND_SOC_INTEL_SST_MATCH if ACPI
>   	help
> @@ -150,7 +150,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
>           tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
>   	depends on X86 && I2C && ACPI
>   	select SND_SOC_RT5651
> -	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_MID_PLATFORM
>   	select SND_SST_IPC_ACPI
>   	select SND_SOC_INTEL_SST_MATCH if ACPI
>   	help
> @@ -163,7 +163,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
>           tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
>           depends on X86_INTEL_LPSS && I2C && ACPI
>           select SND_SOC_RT5670
> -        select SND_SST_MFLD_PLATFORM
> +        select SND_SST_MID_PLATFORM
>           select SND_SST_IPC_ACPI
>   	select SND_SOC_INTEL_SST_MATCH if ACPI
>           help
> @@ -176,7 +176,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
>   	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
>   	depends on X86_INTEL_LPSS && I2C && ACPI
>   	select SND_SOC_RT5645
> -	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_MID_PLATFORM
>   	select SND_SST_IPC_ACPI
>   	select SND_SOC_INTEL_SST_MATCH if ACPI
>   	help
> @@ -189,7 +189,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
>   	depends on X86_INTEL_LPSS && I2C && ACPI
>   	select SND_SOC_MAX98090
>   	select SND_SOC_TS3A227E
> -	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_MID_PLATFORM
>   	select SND_SST_IPC_ACPI
>   	select SND_SOC_INTEL_SST_MATCH if ACPI
>   	help
> diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
> index 2b45435e6245..58578f8a3b45 100644
> --- a/sound/soc/intel/Makefile
> +++ b/sound/soc/intel/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
>   # Platform Support
>   obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
>   obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
> -obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
> +obj-$(CONFIG_SND_SST_MID_PLATFORM) += atom/
>   obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += skylake/
>   
>   # Machine support
> diff --git a/sound/soc/intel/atom/Makefile b/sound/soc/intel/atom/Makefile
> index ce8074fa6d66..a1f2f1ba158d 100644
> --- a/sound/soc/intel/atom/Makefile
> +++ b/sound/soc/intel/atom/Makefile
> @@ -1,7 +1,8 @@
> -snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o \
> -	        sst-mfld-platform-compress.o sst-atom-controls.o
> +snd-soc-sst-mid-platform-objs := sst-mfld-platform-pcm.o \
> +				 sst-mfld-platform-compress.o \
> +				 sst-atom-controls.o
>   
> -obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
> +obj-$(CONFIG_SND_SST_MID_PLATFORM) += snd-soc-sst-mid-platform.o
>   
>   # DSP driver
>   obj-$(CONFIG_SND_SST_IPC) += sst/
