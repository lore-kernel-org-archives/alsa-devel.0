From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: intel: clean up CONFIG_SND_SST_IPC handling
Date: Mon, 22 Jan 2018 11:58:34 +0100
Message-ID: <CAK8P3a0H6CbFgqQijFRYsDoYq3mEPcuBL6x01Ppp7P+_81t++A@mail.gmail.com>
References: <20180121221505.196163-1-arnd@arndb.de> <1516614692.7000.1155.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516614692.7000.1155.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 22, 2018 at 10:51 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sun, 2018-01-21 at 23:14 +0100, Arnd Bergmann wrote:
>> In a configuration with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
>> SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:
>>
>> ERROR: "sst_context_init" [sound/soc/intel/atom/sst/snd-intel-sst-
>> acpi.ko] undefined!
>> ERROR: "sst_context_cleanup" [sound/soc/intel/atom/sst/snd-intel-sst-
>> acpi.ko] undefined!
>> ERROR: "sst_alloc_drv_context" [sound/soc/intel/atom/sst/snd-intel-
>> sst-acpi.ko] undefined!
>> ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko]
>> undefined!
>> ERROR: "sst_configure_runtime_pm" [sound/soc/intel/atom/sst/snd-intel-
>> sst-acpi.ko] undefined!
>>
>> The problem is that the sound/soc/intel/atom/ directory only gets
>> entered by Kbuild when SND_SST_ATOM_HIFI2_PLATFORM is set, so we
>> only build modules (obj-m) under here but not built-in files (obj-y)
>> including the snd-intel-sst-core that we clearly want need here.
>>
>> Before commit 4772c16ede52 ("ASoC: Intel: Kconfig: Simplify-clarify
>> ACPI/PCI
>> dependencies"), this could not happen as all files in
>> sound/soc/intel/atom/
>> depended on CONFIG_SND_SST_ATOM_HIFI2_PLATFORM anyway.
>>
>> Slightly later, commit 05f4434bc130 ("ASoC: Intel: remove
>> mfld_machine")
>> was added, which then removed the Merrifield machine code that
>> happened
>> to be the only user of SND_SST_ATOM_HIFI2_PLATFORM_PCI. With that
>> gone,
>
> That's what I afraid of. Intel Merrifield *should* be there. What Vinod
> did, AFAIU, is removal of Intel Medfield support, which is fine with me.
>
> So, before this can go, we need to get confirmation from Vinod and
> Pierre, that Merrifield still stays there.

Ok, I see. Checking further, I see that SND_SST_ATOM_HIFI2_PLATFORM_PCI
cannot be built without SND_SST_ATOM_HIFI2_PLATFORM:

sound/soc/intel/atom/sst/sst_drv_interface.o: In function `sst_register':
sst_drv_interface.c:(.text+0xc3e): undefined reference to `sst_register_dsp'
sound/soc/intel/atom/sst/sst_drv_interface.o: In function `sst_unregister':
sst_drv_interface.c:(.text+0xc67): undefined reference to `sst_unregister_dsp'

How about this instead:

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index f2c9e8c5970a..16344bd24eb0 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -72,21 +72,8 @@ config SND_SOC_INTEL_BAYTRAIL
          for Baytrail Chromebooks but this option is now deprecated and is
          not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.

-config SND_SST_ATOM_HIFI2_PLATFORM_PCI
-       tristate "PCI HiFi2 (Medfield, Merrifield) Platforms"
-       depends on X86 && PCI
-       select SND_SST_IPC_PCI
-       select SND_SOC_COMPRESS
-       help
-         If you have a Intel Medfield or Merrifield/Edison platform, then
-         enable this option by saying Y or m. Distros will typically not
-         enable this option: Medfield devices are not available to
-         developers and while Merrifield/Edison can run a mainline kernel with
-         limited functionality it will require a firmware file which
-         is not in the standard firmware tree
-
 config SND_SST_ATOM_HIFI2_PLATFORM
-       tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
+       tristate "ACPI HiFi2 (Baytrail, Cherrytrail, Merrifield) Platforms"
        depends on X86 && ACPI
        select SND_SST_IPC_ACPI
        select SND_SOC_COMPRESS
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index d4e103615f51..c73b19292fda 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -159,6 +159,19 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH

          If unsure select "N".

+config SND_SOC_INTEL_MRFLD_MACH
+       tristate "Merrifield/Edison platform"
+       depends on X86_INTEL_LPSS && I2C && PCI
+       select SND_SST_IPC_PCI
+       help
+         This adds support for ASoC PCI driver for the Merrifield
+         (platform) used e.g. on Intel Edison.  If you have
+         Merrifield/Edison platform, then enable this option by saying
+         Y or m. Distros will typically not enable this option: while
+         Merrifield/Edison can run a mainline kernel with limited
+         functionality it will require a firmware file which is not in
+         the standard firmware tree.
+
 endif ## SND_SST_ATOM_HIFI2_PLATFORM

 if SND_SOC_INTEL_SKYLAKE
