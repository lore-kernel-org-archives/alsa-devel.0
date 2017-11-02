From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: fix Kconfig dependencies
Date: Thu, 2 Nov 2017 21:34:07 +0530
Message-ID: <20171102160406.GG3187@localhost>
References: <20171102110737.2813128-1-arnd@arndb.de>
 <48ffc83d-6ab0-3388-fade-9e02dc4459cf@linux.intel.com>
 <CAK8P3a3p4k=iU9Ym_h-Ahq5y93ga2yhDLO6S_6+g7dLN5aGbQQ@mail.gmail.com>
 <CAK8P3a3DhaUvQiyggVopT=DnRV2octdx8Qh8EeYmHd6fKaYHkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B69DD266DEA
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 17:01:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAK8P3a3DhaUvQiyggVopT=DnRV2octdx8Qh8EeYmHd6fKaYHkg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Harsha Priya N <harshapriya.n@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 02, 2017 at 02:12:11PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 2, 2017 at 2:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Nov 2, 2017 at 1:43 PM, Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >> On 11/2/17 6:07 AM, Arnd Bergmann wrote:
> >>>
> >>> I ran into multiple problems during randconfig builds of the
> >>> recently changed Kconfig logic for Intel ASoC drivers:
> >>
> >>
> >> we did quite a bit of testing on this change, looks like we missed a number
> >> of cases. Gah.
> >>
> >>>
> >>> - Building without DMADEVICES doesn't work in general
> >>
> >>
> >> the Intel audio hardware has its own DMA in general, be it based on
> >> DesignWare controlled by audio firmware or HDaudio, not sure if/why this
> >> dependency is needed across the board?
> >
> > Probably my mistake. I'll try again without the dependency and see
> > what problems I run into then and what the correct fix is.
> 
> I immediately ran into this Kconfig warning, so this is clearly for the two
> users of SND_SOC_INTEL_SST_FIRMWARE:
> 
> warning: (SATA_DWC_OLD_DMA && SERIAL_8250_LPSS &&
> SND_SOC_INTEL_SST_FIRMWARE) selects DW_DMAC_CORE which has unmet
> direct dependencies (DMADEVICES)

The BYT legacy drivers used DMAengine (dw) to load the firmware and hence the
dependency. The Skylake and other drivers do not need that, so we should
move this from toplevel to the BYT driver only.

> 
> I'm testing with this fixup now:
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index e18118209b75..89126fa3f846 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -20,7 +20,6 @@ config SND_SOC_INTEL_SST
> 
>  config SND_SOC_INTEL_SST_FIRMWARE
>         tristate
> -       select DW_DMAC_CORE

this is required as we need this DMA driver. It might not have issues on
compile but functionality would be broken.

>  config SND_SOC_INTEL_SST_ACPI
>         tristate
> @@ -32,19 +31,20 @@ config SND_SOC_ACPI_INTEL_MATCH
>  config SND_SOC_INTEL_SST_TOPLEVEL
>         tristate "Intel ASoC SST drivers"
>         depends on X86 || COMPILE_TEST
> -       depends on DMADEVICES

This is fine

>         select SND_SOC_INTEL_MACH
>         select SND_SOC_INTEL_COMMON
> 
>  config SND_SOC_INTEL_HASWELL
>         tristate "Intel ASoC SST driver for Haswell/Broadwell"
>         depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
> +       depends on DMADEVICES

yes this and below seems right fix to me.

>         select SND_SOC_INTEL_SST
>         select SND_SOC_INTEL_SST_FIRMWARE
> 
>  config SND_SOC_INTEL_BAYTRAIL
>         tristate "Intel ASoC SST driver for Baytrail (legacy)"
>         depends on SND_SOC_INTEL_SST_TOPLEVEL
> +       depends on DMADEVICES
>         select SND_SOC_INTEL_SST
>         select SND_SOC_INTEL_SST_FIRMWARE
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index 449bc8baaa60..5063f15b4ca4 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -19,7 +19,6 @@ config SND_SOC_INTEL_HASWELL_MACH
>         tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
>         depends on SND_SOC_INTEL_MACH
>         depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
> -       depends on DMADEVICES
>         depends on SND_SOC_INTEL_HASWELL
>         select SND_SOC_RT5640
>         help
> @@ -32,7 +31,6 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
>         tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
>         depends on SND_SOC_INTEL_MACH
>         depends on X86_INTEL_LPSS && GPIOLIB && I2C
> -       depends on DMADEVICES
>         depends on SND_SOC_INTEL_HASWELL
>         select SND_SOC_RT5677
>         help
> @@ -43,7 +41,6 @@ config SND_SOC_INTEL_BROADWELL_MACH
>         tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
>         depends on SND_SOC_INTEL_MACH
>         depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
> -       depends on DMADEVICES
>         depends on SND_SOC_INTEL_HASWELL
>         select SND_SOC_RT286
>         help
> @@ -56,7 +53,6 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
>         tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
>         depends on SND_SOC_INTEL_MACH
>         depends on X86_INTEL_LPSS && I2C
> -       depends on DMADEVICES
>         depends on SND_SST_IPC_ACPI = n
>         depends on SND_SOC_INTEL_BAYTRAIL
>         select SND_SOC_MAX98090
> @@ -68,7 +64,6 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
>         tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
>         depends on SND_SOC_INTEL_MACH
>         depends on X86_INTEL_LPSS && I2C
> -       depends on DMADEVICES
>         depends on SND_SST_IPC_ACPI = n
>         depends on SND_SOC_INTEL_BAYTRAIL
>         select SND_SOC_RT5640

-- 
~Vinod
