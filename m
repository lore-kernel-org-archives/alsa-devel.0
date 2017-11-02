From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: fix Kconfig dependencies
Date: Thu, 2 Nov 2017 07:43:41 -0500
Message-ID: <48ffc83d-6ab0-3388-fade-9e02dc4459cf@linux.intel.com>
References: <20171102110737.2813128-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id A6D97266E8B
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 13:43:43 +0100 (CET)
In-Reply-To: <20171102110737.2813128-1-arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 11/2/17 6:07 AM, Arnd Bergmann wrote:
> I ran into multiple problems during randconfig builds of the
> recently changed Kconfig logic for Intel ASoC drivers:

we did quite a bit of testing on this change, looks like we missed a 
number of cases. Gah.

> 
> - Building without DMADEVICES doesn't work in general

the Intel audio hardware has its own DMA in general, be it based on 
DesignWare controlled by audio firmware or HDaudio, not sure if/why this 
dependency is needed across the board?

> - With that dependency added, we can relax the 'depends
>    on X86' again and allow compile-testing, except for
>    SND_SST_ATOM_HIFI2_PLATFORM, which depends on X86
>    for asm/platform_sst_audio. > - Skylake requires SND_SOC_INTEL_SST_ACPI, so we
>    have to depend on ACPI in turn
> - Haswell needs SND_DMA_SGBUF for snd_sgbuf_aligned_pages()

This one is surprising as well, this was not there before so it either 
was not detected or is not needed?

> 
> With the new set of dependencies, I no longer get any build
> failures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/intel/Kconfig | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index a59dda39007e..e18118209b75 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -31,13 +31,14 @@ config SND_SOC_ACPI_INTEL_MATCH
>   
>   config SND_SOC_INTEL_SST_TOPLEVEL
>   	tristate "Intel ASoC SST drivers"
> -	depends on X86
> +	depends on X86 || COMPILE_TEST
> +	depends on DMADEVICES
>   	select SND_SOC_INTEL_MACH
>   	select SND_SOC_INTEL_COMMON
>   
>   config SND_SOC_INTEL_HASWELL
>   	tristate "Intel ASoC SST driver for Haswell/Broadwell"
> -	depends on SND_SOC_INTEL_SST_TOPLEVEL
> +	depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
>   	select SND_SOC_INTEL_SST
>   	select SND_SOC_INTEL_SST_FIRMWARE
>   
> @@ -49,12 +50,12 @@ config SND_SOC_INTEL_BAYTRAIL
>   
>   config SND_SST_ATOM_HIFI2_PLATFORM
>   	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
> -	depends on SND_SOC_INTEL_SST_TOPLEVEL
> +	depends on SND_SOC_INTEL_SST_TOPLEVEL && X86
>   	select SND_SOC_COMPRESS
>   
>   config SND_SOC_INTEL_SKYLAKE
>   	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
> -	depends on SND_SOC_INTEL_SST_TOPLEVEL
> +	depends on SND_SOC_INTEL_SST_TOPLEVEL && PCI && ACPI
>   	select SND_HDA_EXT_CORE
>   	select SND_HDA_DSP_LOADER
>   	select SND_SOC_TOPOLOGY
> 
