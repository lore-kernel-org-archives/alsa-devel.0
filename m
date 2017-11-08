From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: improve DMADEVICES
	dependency
Date: Wed, 8 Nov 2017 19:39:11 +0530
Message-ID: <20171108140911.GT3187@localhost>
References: <20171108130354.86106-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EC080266D45
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 15:06:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171108130354.86106-1-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Harsha Priya N <harshapriya.n@intel.com>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 08, 2017 at 02:03:19PM +0100, Arnd Bergmann wrote:
> As pointed out by Pierre-Louis Bossart, the depndency I added

/s/depndency/dependency

> was broader than necessary, only Baytrail and Haswell/Broadwell
> actually need it, the others don't.
> 
> At the same time, we have individual entries for the codecs
> that all have the 'select' statement but now don't need it
> any more.
> 
> Fixes: f7a88db6fffd ("ASoC: Intel: fix Kconfig dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/intel/Kconfig        | 3 ++-
>  sound/soc/intel/boards/Kconfig | 5 -----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index e18118209b75..bb8be10b8437 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -32,19 +32,20 @@ config SND_SOC_ACPI_INTEL_MATCH
>  config SND_SOC_INTEL_SST_TOPLEVEL
>  	tristate "Intel ASoC SST drivers"
>  	depends on X86 || COMPILE_TEST
> -	depends on DMADEVICES
>  	select SND_SOC_INTEL_MACH
>  	select SND_SOC_INTEL_COMMON
>  
>  config SND_SOC_INTEL_HASWELL
>  	tristate "Intel ASoC SST driver for Haswell/Broadwell"
>  	depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
> +	depends on DMADEVICES
>  	select SND_SOC_INTEL_SST
>  	select SND_SOC_INTEL_SST_FIRMWARE
>  
>  config SND_SOC_INTEL_BAYTRAIL
>  	tristate "Intel ASoC SST driver for Baytrail (legacy)"
>  	depends on SND_SOC_INTEL_SST_TOPLEVEL
> +	depends on DMADEVICES
>  	select SND_SOC_INTEL_SST
>  	select SND_SOC_INTEL_SST_FIRMWARE
>  
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index 449bc8baaa60..5063f15b4ca4 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -19,7 +19,6 @@ config SND_SOC_INTEL_HASWELL_MACH
>  	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
>  	depends on SND_SOC_INTEL_MACH
>  	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
> -	depends on DMADEVICES

Per Liam this seems to be required for Haswell

>  	depends on SND_SOC_INTEL_HASWELL
>  	select SND_SOC_RT5640
>  	help
> @@ -32,7 +31,6 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
>  	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
>  	depends on SND_SOC_INTEL_MACH
>  	depends on X86_INTEL_LPSS && GPIOLIB && I2C
> -	depends on DMADEVICES
>  	depends on SND_SOC_INTEL_HASWELL
>  	select SND_SOC_RT5677
>  	help
> @@ -43,7 +41,6 @@ config SND_SOC_INTEL_BROADWELL_MACH
>  	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
>  	depends on SND_SOC_INTEL_MACH
>  	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
> -	depends on DMADEVICES
>  	depends on SND_SOC_INTEL_HASWELL
>  	select SND_SOC_RT286
>  	help
> @@ -56,7 +53,6 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
>  	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
>  	depends on SND_SOC_INTEL_MACH
>  	depends on X86_INTEL_LPSS && I2C
> -	depends on DMADEVICES
>  	depends on SND_SST_IPC_ACPI = n
>  	depends on SND_SOC_INTEL_BAYTRAIL
>  	select SND_SOC_MAX98090
> @@ -68,7 +64,6 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
>  	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
>  	depends on SND_SOC_INTEL_MACH
>  	depends on X86_INTEL_LPSS && I2C
> -	depends on DMADEVICES
>  	depends on SND_SST_IPC_ACPI = n
>  	depends on SND_SOC_INTEL_BAYTRAIL
>  	select SND_SOC_RT5640
> -- 
> 2.9.0
> 

-- 
~Vinod
