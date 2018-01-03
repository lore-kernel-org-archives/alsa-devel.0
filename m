From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 5/9] ASoC: Intel: Fix nested/unnecessary Kconfig
 dependencies
Date: Wed, 03 Jan 2018 20:09:44 +0200
Message-ID: <1515002984.7000.600.camel@linux.intel.com>
References: <20180103165022.4984-1-pierre-louis.bossart@linux.intel.com>
         <20180103165022.4984-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103165022.4984-6-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-01-03 at 10:50 -0600, Pierre-Louis Bossart wrote:
> This patch fixes a number of issues:
> 1. IOSF_MBI is only needed for byt-cr detection, which is only
> supported
> on Baytrail/Cherrytrail, move to HiFi2 config
> 

>  	tristate "Intel ASoC SST driver for ACPI HiFi2 platforms
> (Baytrail, Cherrytrail)"
>  	depends on X86 && ACPI
>  	select SND_SST_IPC_ACPI
> +	select IOSF_MBI
>  	select SND_SOC_COMPRESS
>  	select SND_SOC_ACPI_INTEL_MATCH
>  	help

A nitpick: Perhaps not to split SND_* options and thus put IOSF_MBI as
last one in the list?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
