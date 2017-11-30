From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC PATCH v2 1/7] ASoC: Intel: Fix Kconfig with top-level
 selector
Date: Thu, 30 Nov 2017 17:54:32 +0530
Message-ID: <20171130122432.GX32417@localhost>
References: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
 <20171129014551.30552-2-pierre-louis.bossart@linux.intel.com>
 <20171129102734.GA32417@localhost>
 <8ba6af88-5cb4-8174-2ecc-46f80420ff28@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8ba6af88-5cb4-8174-2ecc-46f80420ff28@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 29, 2017 at 08:52:58AM -0600, Pierre-Louis Bossart wrote:
> On 11/29/17 4:27 AM, Vinod Koul wrote:
> >On Tue, Nov 28, 2017 at 07:45:45PM -0600, Pierre-Louis Bossart wrote:
> >
> >I am not sure about top level being default to Y...
> 
> It's standard procedure apparently, see Linus/Mark/Takashi's emails.
> 
> >
> >>  config SND_SST_ATOM_HIFI2_PLATFORM
> >>  	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
> >>-	depends on SND_SOC_INTEL_SST_TOPLEVEL && X86
> >>+	depends on X86
> >>  	select SND_SOC_COMPRESS
> >>+	select SND_SOC_INTEL_COMMON
> >>  config SND_SOC_INTEL_SKYLAKE
> >>  	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
> >>-	depends on SND_SOC_INTEL_SST_TOPLEVEL && PCI && ACPI
> >>+	depends on PCI && ACPI
> >>  	select SND_HDA_EXT_CORE
> >>  	select SND_HDA_DSP_LOADER
> >>  	select SND_SOC_TOPOLOGY
> >>  	select SND_SOC_INTEL_SST
> >>+	select SND_SOC_INTEL_COMMON
> >>+	help
> >>+	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
> >>+	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
> >>+	  then enable this option by saying Y or m.
> >
> >this is good stuff, helps in improving UX vastly. Btw can we have select ALL
> >machine also as an option for people who dont want to select a specfic one,
> >that one will really help for a better UX
> 
> no, we shouldn't select things, especially with the Baytrail legacy which is
> kept to avoid breaking existing setups but shouldn't be used any longer.
> And with SOF coming, we may have hybrid configurations with SOF used on
> Baytrail/Cherrytrail/APL/CNL but SST used on Skylake/Kabylake due to
> firmware authentication stuff.

Okay I am checking this out.

Btw you need to rebase this series I wasn't able to apply to mark/intel/topic
So I grabbed the branch from your github tree. Assuming I have the right
branch (topic/fix-kconfig)

At top level UX is bit confusing:

			[ ]   Intel ASoC SST drivers
			[*]   Intel ASoC machine drivers

And selecting first symbol shows me the platforms and once I select platform
then machines appear under second menu. Now this is really not a great way
from UX. Why are we adding platforms selectable? We might be able to
simplify this by getting rid of first set and let machine then select
Platfroms specfied.

			[*]   Intel ASoC SST drivers
			< >     Intel ASoC SST driver for Haswell/Broadwell (NEW)
			< >     Intel ASoC SST driver for Baytrail (legacy) (NEW)
			< >     Intel ASoC SST driver for PCI HiFi2 platforms (Medfield, Merrifield) (NEW)
			< >     Intel ASoC SST driver for ACPI HiFi2 platforms (Baytrail, Cherrytrail) (NEW)
			<*>     Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL
			[*]   Intel ASoC machine drivers
			< >     ASoC Audio driver for SKL with RT286 I2S mode (NEW)
			< >     ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode (NEW)
			< >     ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode (NEW) 

If we still want both I would like the machine to appear below the
respective platform, in above example, I would like to see:

			[*]   Intel ASoC SST drivers
			< >     Intel ASoC SST driver for Haswell/Broadwell (NEW)
			< >     Intel ASoC SST driver for Baytrail (legacy) (NEW)
			< >     Intel ASoC SST driver for PCI HiFi2 platforms (Medfield, Merrifield) (NEW)
			< >     Intel ASoC SST driver for ACPI HiFi2 platforms (Baytrail, Cherrytrail) (NEW)
			<*>     Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL
			< >       ASoC Audio driver for SKL with RT286 I2S mode (NEW)
			< >       ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode (NEW)
			< >       ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode (NEW) 

Then you can get rid of global mach symbol and select platform and then
respective machine and better UX :).

> >>+endif ## SND_SOC_INTEL_SST_TOPLEVEL
> >>  # ASoC codec drivers
> >>  source "sound/soc/intel/boards/Kconfig"
> >>+
> >>+# configs common to SST and SOF to compile sound/soc/intel/common
> >>+# directory and use matching tables
> >>+
> >>+config SND_SOC_INTEL_COMMON
> >>+	tristate
> >>+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
> >
> >common selects only MATCH
> 
> COMMON is only there to go compile the sound/soc/intel/common directory.
> That's not very useful indeed but otherwise the Makefile doesn't compile the
> match tables or the sst-ipc stuff. If you find a better solution I am all
> ears.

Coming to this topic (my original intention to check this), I found that
common symbol is not doing anything expect adding common directory, which is
not really needed as we have individual bits for files, so I kept this but
removed the match one.

-- >8 --

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index dee731d42634..33a05aa2cf32 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -99,8 +99,4 @@ source "sound/soc/intel/boards/Kconfig"

 config SND_SOC_INTEL_COMMON
        tristate
-       select SND_SOC_ACPI_INTEL_MATCH if ACPI
-
-config SND_SOC_ACPI_INTEL_MATCH
-       tristate
-       select SND_SOC_ACPI if ACPI
+       depends on ACPI
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index b973d457e834..8160520fd74c 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Core support
-obj-$(CONFIG_SND_SOC_INTEL_COMMON) += common/
+obj-$(CONFIG_SND_SOC) += common/

 # Platform Support
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
diff --git a/sound/soc/intel/common/Makefile
b/sound/soc/intel/common/Makefile
index 7379d8830c39..92c66c47eb78 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -8,4 +8,4 @@ snd-soc-acpi-intel-match-objs := soc-acpi-intel-byt-match.o
soc-acpi-intel-cht-m
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_FIRMWARE) += snd-soc-sst-firmware.o
-obj-$(CONFIG_SND_SOC_ACPI_INTEL_MATCH) += snd-soc-acpi-intel-match.o
+obj-$(CONFIG_SND_SOC_INTEL_COMMON) += snd-soc-acpi-intel-match.o

-- >8 --

This way we have one lesser symbol to manage :) I am okay if you want to
keep match and remove common.


> >>+	# this option controls the compilation of the sound/soc/intel/common
> >>+	# directory and is not meant to be selected by the user. It is
> >>+	# not filtered out on purpose by the top-level selector since
> >>+	# it will be selected by SST or SOF platform driver options
> >>+
> >>+config SND_SOC_ACPI_INTEL_MATCH
> >>+	tristate
> >>+	select SND_SOC_ACPI if ACPI
> >
> >then why keep common, lets remove one level and have
> >SND_SOC_ACPI_INTEL_MATCH selected. ACPI is must have at top level so we can
> >add depends on that symbol
> 
> we still have platforms which don't depend on ACPI, so we shouldn't take
> this out.

For the controllers which are PCI only, yes. But as a platform we won't boot
without ACPI :) so take your pick!

-- 
~Vinod
