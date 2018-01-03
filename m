From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/9] ASoC: Intel: Kconfig+acpi fixes
Date: Wed, 03 Jan 2018 19:09:00 +0200
Message-ID: <1514999340.7000.597.camel@linux.intel.com>
References: <20180103165022.4984-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103165022.4984-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-01-03 at 10:50 -0600, Pierre-Louis Bossart wrote:
> The first patch solves issues reported by 0day with non-ACPI platforms
> 
> The second patch implements what Linus, Takashi and Mark
> requested: a top-level selector defaulting to 'y' to easily filter all
> other options and with no impact on code generation. There should be
> no
> functionality change and will avoid breaking audio for people using
> make oldnoconfig.
> 
> The rest of the patch series does a more in-depth cleanup. It was
> tested
> on Baytrail/Cherrytrail/Skylake platforms with no regressions
> observed and no reports of any compilation issues with 0-day or
> randconfig.
> 
> The 5th patch is really the most important one, there were nested
> configs which made no sense to me. I don't know the history which led
> to such complicated stuff but simpler is better.
> 
> Patches 6..7 are just clean-ups of the machine driver configs,
> for some reason there is no consistency in the settings so I tried to
> apply common sense and use the same rules. At Andy Shevchenko's
> suggestion,
> I also replaced the broken dependency on X86_INTEL_LPSS by
> MFD_INTEL_LPSS
> for Skylake+ machines. No regressions were identified with this
> change.
> 
> Patch 9 is new in this series and are just cosmetic changes (comments
> and text simplification).
> 
> Thanks to Vinod Koul for his contributions and comments.

Couple of nitpicks and seems patch 9 missed some (all?) comments to be
addressed.

So, after fixing them:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Changes since v1:
>  fixed more 0-day warnings for e.g. s390 non-ACPI compilation
>  fixed use of depends
>  fixed use of CONFIG_
>  fixed indentations as needed
>  simplified text and comments
>  
> Changes since RFCv2:
>  Moved machine drivers to submenu
>  Dropped SND_SOC_INTEL_COMMON since it was not needed
>  Added more comments for if/endif
>  Simplified text for options (dropped "ASoC Intel driver....")
>  Fixed one 0-day warning
>  
> Changes since initial RFC:
>  Removed default n
>  Added help text for HASWELL, BAYTRAIL (legacy) and SKYLAKE options 
>  Made top level machine driver selection dependent on
> INTEL_SST_TOPLEVEL.
>  Added help text for PCI and HIFI2 platforms
>  Replaced X86_INTEL_LPSS by MFD_INTEL_LPSS for Skylake+ devices
>  Fixed a couple of indentation issues
> 
> Pierre-Louis Bossart (8):
>   ASoC: acpi: add missing includes for non-ACPI platforms
>   ASoC: Intel: Fix Kconfig with top-level selector
>   ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies
>   ASoC: Intel: document what Kconfig options do
>   ASoC: Intel: Fix nested/unnecessary Kconfig dependencies
>   ASoC: Intel: boards: align Kconfig dependencies for
> Haswell/Broadwell
>   ASoC: Intel: boards: align Kconfig configurations for HiFi2
>   ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs
> 
> Vinod Koul (1):
>   ASoC: Intel: kconfig: add some comments for if symbols
> 
>  include/sound/soc-acpi-intel-match.h |   1 +
>  include/sound/soc-acpi.h             |   1 +
>  sound/soc/intel/Kconfig              | 116 +++++++++++++++------
>  sound/soc/intel/Makefile             |   2 +-
>  sound/soc/intel/boards/Kconfig       | 191 ++++++++++++++++++------
> -----------
>  5 files changed, 186 insertions(+), 125 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
