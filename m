From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix Kconfigs,
	make HDaudio codec optional" to the asoc tree
Date: Tue, 20 Nov 2018 17:01:57 +0000 (GMT)
Message-ID: <20181120170157.438BF1124DC2@debutante.sirena.org.uk>
References: <20181118223809.23314-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D9E826796A
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 18:02:03 +0100 (CET)
In-Reply-To: <20181118223809.23314-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: fix Kconfigs, make HDaudio codec optional

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8c4e7c2ee8096b5ca8214418f287b3878d578cc0 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sun, 18 Nov 2018 16:38:09 -0600
Subject: [PATCH] ASoC: Intel: Skylake: fix Kconfigs, make HDaudio codec
 optional

The Skylake driver currently has a set of problems supporting
load/unload modules. We need to make the HDaudio codec support
optional to help narrow down the issues.

Support for HDaudio codecs also leads to a Kconfig issue. We want the
hdac_hda codec to be compilable independently of Skylake (e.g. with
ALL_CODECS) but when Skylake is selected as built-in the hdac_hda
codec needs to use the same option due a a code dependency

Solve both problems by adding a user-selectable boolean Kconfig,
select HDAC_HDA as needed and make the HDaudio codec support in the
Skylake driver optional. Tests on a Chell Chromebook device without
HDaudio show no regression for speaker and HDMI playback.

This is submitted as an RFC to allow for comments and more validation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig        | 26 +++++++++++++++++++++++---
 sound/soc/intel/boards/Kconfig | 24 ++++++++++++++----------
 sound/soc/intel/skylake/skl.c  | 20 ++++++++++++++++++--
 3 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0caa1f4eb94d..18e717703685 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -101,22 +101,42 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 	  codec, then enable this option by saying Y or m. This is a
 	  recommended option
 
-config SND_SOC_INTEL_SKYLAKE_SSP_CLK
-	tristate
-
 config SND_SOC_INTEL_SKYLAKE
 	tristate "SKL/BXT/KBL/GLK/CNL... Platforms"
 	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_COMMON
+	help
+	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
+	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
+	  then enable this option by saying Y or m.
+
+if  SND_SOC_INTEL_SKYLAKE
+
+config SND_SOC_INTEL_SKYLAKE_SSP_CLK
+	tristate
+
+config SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
+	bool "HDAudio codec support"
+	help
+	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
+	  GeminiLake or CannonLake platform with an HDaudio codec
+	  then enable this option by saying Y
+
+config SND_SOC_INTEL_SKYLAKE_COMMON
+	tristate
 	select SND_HDA_EXT_CORE
 	select SND_HDA_DSP_LOADER
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
+	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
 	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
 	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
 	  then enable this option by saying Y or m.
 
+endif ## SND_SOC_INTEL_SKYLAKE
+
 config SND_SOC_ACPI_INTEL_MATCH
 	tristate
 	select SND_SOC_ACPI if ACPI
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 73ca1350aa31..b177db2a0dbb 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -293,16 +293,6 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
-config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
-	tristate "SKL/KBL/BXT/APL with HDA Codecs"
-	select SND_SOC_HDAC_HDMI
-	select SND_SOC_HDAC_HDA
-	help
-	  This adds support for ASoC machine driver for Intel platforms
-	  SKL/KBL/BXT/APL with iDisp, HDA audio codecs.
-          Say Y or m if you have such a device. This is a recommended option.
-	  If unsure select "N".
-
 config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	tristate "GLK with RT5682 and MAX98357A in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
@@ -319,4 +309,18 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 
 endif ## SND_SOC_INTEL_SKYLAKE
 
+if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
+
+config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
+	tristate "SKL/KBL/BXT/APL with HDA Codecs"
+	select SND_SOC_HDAC_HDMI
+	# SND_SOC_HDAC_HDA is already selected
+	help
+	  This adds support for ASoC machine driver for Intel platforms
+	  SKL/KBL/BXT/APL with iDisp, HDA audio codecs.
+          Say Y or m if you have such a device. This is a recommended option.
+	  If unsure select "N".
+
+endif ## SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
+
 endif ## SND_SOC_INTEL_MACH
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 1586c97d9450..7487f388e65d 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -37,7 +37,9 @@
 #include "skl.h"
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
 #include "../../../soc/codecs/hdac_hda.h"
+#endif
 
 /*
  * initialize the PCI registers
@@ -658,6 +660,8 @@ static void skl_clock_device_unregister(struct skl *skl)
 		platform_device_unregister(skl->clk_dev);
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
+
 #define IDISP_INTEL_VENDOR_ID	0x80860000
 
 /*
@@ -676,6 +680,8 @@ static void load_codec_module(struct hda_codec *codec)
 #endif
 }
 
+#endif /* CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC */
+
 /*
  * Probe the given codec address
  */
@@ -685,9 +691,11 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
 	struct skl *skl = bus_to_skl(bus);
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
 	struct hdac_hda_priv *hda_codec;
-	struct hdac_device *hdev;
 	int err;
+#endif
+	struct hdac_device *hdev;
 
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
@@ -697,6 +705,7 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		return -EIO;
 	dev_dbg(bus->dev, "codec #%d probed OK: %x\n", addr, res);
 
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
 	hda_codec = devm_kzalloc(&skl->pci->dev, sizeof(*hda_codec),
 				 GFP_KERNEL);
 	if (!hda_codec)
@@ -715,6 +724,13 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		load_codec_module(&hda_codec->codec);
 	}
 	return 0;
+#else
+	hdev = devm_kzalloc(&skl->pci->dev, sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	return snd_hdac_ext_bus_device_init(bus, addr, hdev);
+#endif /* CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC */
 }
 
 /* Codec initialization */
@@ -870,7 +886,7 @@ static int skl_create(struct pci_dev *pci,
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
 
-#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
 	ext_ops = snd_soc_hdac_hda_get_ops();
 #endif
 	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, ext_ops);
-- 
2.19.0.rc2
