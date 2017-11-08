From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: improve DMADEVICES dependency
Date: Wed, 8 Nov 2017 19:54:59 +0530
Message-ID: <20171108142459.GZ3187@localhost>
References: <20171108130354.86106-1-arnd@arndb.de>
 <20171108140911.GT3187@localhost>
 <CAK8P3a083zZnN1rZOV6Ox_pR24YJf9MCZiNV4KmpuTiMV_F8eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a083zZnN1rZOV6Ox_pR24YJf9MCZiNV4KmpuTiMV_F8eA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Harsha Priya N <harshapriya.n@intel.com>, Daniel Drake <drake@endlessm.com>, Naveen M <naveen.m@intel.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 08, 2017 at 03:10:18PM +0100, Arnd Bergmann wrote:
> On Wed, Nov 8, 2017 at 3:09 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Wed, Nov 08, 2017 at 02:03:19PM +0100, Arnd Bergmann wrote:
> >> As pointed out by Pierre-Louis Bossart, the depndency I added
> >
> > /s/depndency/dependency
> 
> Mark, can you fix that up when applying, or should I resend?
> 
> >> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> >> index e18118209b75..bb8be10b8437 100644
> >> --- a/sound/soc/intel/Kconfig
> >> +++ b/sound/soc/intel/Kconfig
> >> @@ -32,19 +32,20 @@ config SND_SOC_ACPI_INTEL_MATCH
> >>  config SND_SOC_INTEL_SST_TOPLEVEL
> >>       tristate "Intel ASoC SST drivers"
> >>       depends on X86 || COMPILE_TEST
> >> -     depends on DMADEVICES
> >>       select SND_SOC_INTEL_MACH
> >>       select SND_SOC_INTEL_COMMON
> >>
> >>  config SND_SOC_INTEL_HASWELL
> >>       tristate "Intel ASoC SST driver for Haswell/Broadwell"
> >>       depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
> >> +     depends on DMADEVICES
> >>       select SND_SOC_INTEL_SST
> >>       select SND_SOC_INTEL_SST_FIRMWARE
> >>
> 
> >> --- a/sound/soc/intel/boards/Kconfig
> >> +++ b/sound/soc/intel/boards/Kconfig
> >> @@ -19,7 +19,6 @@ config SND_SOC_INTEL_HASWELL_MACH
> >>       tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
> >>       depends on SND_SOC_INTEL_MACH
> >>       depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
> >> -     depends on DMADEVICES
> >
> > Per Liam this seems to be required for Haswell
> >
> >
> >>       depends on SND_SOC_INTEL_HASWELL
> 
> Correct, I just moved it to a different place above, we now get it through
> the SND_SOC_INTEL_HASWELL dependency.

Ah yes, sorry missed that part. This lgtm so:

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
