From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH][RESEND] ASoC: Intel: atom: fix ACPI/PCI Kconfig
Date: Tue, 3 Apr 2018 10:25:56 +0530
Message-ID: <20180403045554.GT15443@localhost>
References: <20180402170614.5599-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180402170614.5599-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 02, 2018 at 12:06:14PM -0500, Pierre-Louis Bossart wrote:
> The split between ACPI and PCI platforms generated issues with randconfig:
> 
> with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
> SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:
> 
> ERROR: "sst_context_init"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "sst_context_cleanup"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "sst_alloc_drv_context"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko]
> undefined!
> 
> ERROR: "sst_configure_runtime_pm"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> To keep things simple, let's expose two configs for
> SND_SST_ATOM_HIFI2_PLATFORM_PCI and SND_SST_ATOM_HIFI2_PLATFORM_ACPI,
> which select a common SND_SST_ATOM_HIFI2_PLATFORM option. To avoid
> breaking existing solutions with the semantics change,
> SND_SST_ATOM_HIFI2_PLATFORM_ACPI uses "default ACPI" so that "make
> oldnoconfig" and "make olddefconfig" still work as expected.
> 
> Also remove mentions of Medfield while we are at it since it was
> removed recently.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
