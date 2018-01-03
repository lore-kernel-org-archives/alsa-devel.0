From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 8/9] ASoC: Intel: boards: align/fix
 SKL/BXT/KBL Kconfigs
Date: Wed, 03 Jan 2018 19:00:29 +0200
Message-ID: <1514998829.7000.587.camel@linux.intel.com>
References: <20180103165022.4984-1-pierre-louis.bossart@linux.intel.com>
 <20180103165022.4984-9-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FAE72676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 18:10:39 +0100 (CET)
In-Reply-To: <20180103165022.4984-9-pierre-louis.bossart@linux.intel.com>
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

On Wed, 2018-01-03 at 10:50 -0600, Pierre-Louis Bossart wrote:

> Also make sure same dependencies are used everywhere (only last one
> has SPI
> in addition).

A nitpick:

>  config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
>  	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927
> in I2S Mode"
> -	depends on X86_INTEL_LPSS && I2C
> -	select SND_SOC_INTEL_SST
> +	depends on MFD_INTEL_LPSS && I2C && ACPI
>  	select SND_SOC_RT5663
>  	select SND_SOC_MAX98927
>  	select SND_SOC_DMIC
> @@ -257,8 +256,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
>  
>  config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
>          tristate "ASoC Audio driver for KBL with RT5663, RT5514 and
> MAX98927 in I2S Mode"
> -        depends on X86_INTEL_LPSS && I2C && SPI
> -        select SND_SOC_INTEL_SST
> +        depends on MFD_INTEL_LPSS && I2C && SPI && ACPI

Perhaps to split

 depends on SPI

to separate line to follow pattern with the rest ?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
