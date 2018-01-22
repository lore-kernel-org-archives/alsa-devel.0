From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: intel: clean up CONFIG_SND_SST_IPC handling
Date: Mon, 22 Jan 2018 11:51:32 +0200
Message-ID: <1516614692.7000.1155.camel@linux.intel.com>
References: <20180121221505.196163-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180121221505.196163-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2018-01-21 at 23:14 +0100, Arnd Bergmann wrote:
> In a configuration with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
> SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:
> 
> ERROR: "sst_context_init" [sound/soc/intel/atom/sst/snd-intel-sst-
> acpi.ko] undefined!
> ERROR: "sst_context_cleanup" [sound/soc/intel/atom/sst/snd-intel-sst-
> acpi.ko] undefined!
> ERROR: "sst_alloc_drv_context" [sound/soc/intel/atom/sst/snd-intel-
> sst-acpi.ko] undefined!
> ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] 
> undefined!
> ERROR: "sst_configure_runtime_pm" [sound/soc/intel/atom/sst/snd-intel-
> sst-acpi.ko] undefined!
> 
> The problem is that the sound/soc/intel/atom/ directory only gets
> entered by Kbuild when SND_SST_ATOM_HIFI2_PLATFORM is set, so we
> only build modules (obj-m) under here but not built-in files (obj-y)
> including the snd-intel-sst-core that we clearly want need here.
> 
> Before commit 4772c16ede52 ("ASoC: Intel: Kconfig: Simplify-clarify
> ACPI/PCI
> dependencies"), this could not happen as all files in
> sound/soc/intel/atom/
> depended on CONFIG_SND_SST_ATOM_HIFI2_PLATFORM anyway.
> 
> Slightly later, commit 05f4434bc130 ("ASoC: Intel: remove
> mfld_machine")
> was added, which then removed the Merrifield machine code that
> happened
> to be the only user of SND_SST_ATOM_HIFI2_PLATFORM_PCI. With that
> gone,

That's what I afraid of. Intel Merrifield *should* be there. What Vinod
did, AFAIU, is removal of Intel Medfield support, which is fine with me.

So, before this can go, we need to get confirmation from Vinod and
Pierre, that Merrifield still stays there.

> it appears that we can completely remove that symbol as well, along
> with
> the SND_SST_IPC_PCI code and everything associated with it that is now
> unused.
> 
> For clarify, this also removes the SND_SST_IPC_ACPI symbol that is now
> synonymous with SND_SST_IPC, and links both into a single loadable
> module.

> I checked that this patch leads to a clean compilation, and that the
> code I'm removing is only used for the now-obsolete Merrifield PCI ID.

NACK for this part.

> If I got something else wrong, or you want a different fix, please
> just send a replacement patch and treat this as a bug report.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
