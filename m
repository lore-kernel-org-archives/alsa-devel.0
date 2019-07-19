From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 5/5] ALSA: hda/intel: stop probe if DMICS
	are detected on Skylake+ platforms
Date: Fri, 19 Jul 2019 15:37:52 -0500
Message-ID: <20190719203752.11151-6-pierre-louis.bossart@linux.intel.com>
References: <20190719203752.11151-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21C73F800C4
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 22:38:00 +0200 (CEST)
In-Reply-To: <20190719203752.11151-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The legacy HD-Audio driver cannot handle Skylake+ platforms with
digital microphones. For those platforms, the SOF or SST drivers need
to be used.

This patch provides an automatic way of detecting the presence of
DMICs using NHTL information reported by the BIOS. A kernel kconfig
option or a kernel module parameter provide an opt-in means of
stopping the probe. The kernel would then look for an alternate driver
registered for the same PCI ID to probe.

With this capability, distros no longer have to blacklist
snd-hda-intel, but still need to make sure the SOF/SST drivers are
functional by providing the relevant firmware and topology files in
/lib/firmware/intel

The coexistence between SOF and SST drivers and their dynamic
detection is not addressed by this patch, different mechanisms need to
be used, e.g. DMI-based quirks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/Kconfig     | 10 ++++++++++
 sound/pci/hda/hda_intel.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 35d934309cb2..b5966014b5f7 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -12,6 +12,7 @@ config SND_HDA_INTEL
 	tristate "HD Audio PCI"
 	depends on SND_PCI
 	select SND_HDA
+	select SND_INTEL_NHLT if ACPI
 	help
 	  Say Y here to include support for Intel "High Definition
 	  Audio" (Azalia) and its compatible devices.
@@ -22,6 +23,15 @@ config SND_HDA_INTEL
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-hda-intel.
 
+config SND_HDA_INTEL_DETECT_DMIC
+	bool "DMIC detection and probe abort"
+	depends on SND_HDA_INTEL
+	help
+	  Say Y to detect digital microphones on SKL+ devices. DMICs
+	  cannot be handled by the HDaudio legacy driver and are
+	  currently only supported by the SOF driver.
+	  If unsure say N.
+
 config SND_HDA_TEGRA
 	tristate "NVIDIA Tegra HD Audio"
 	depends on ARCH_TEGRA
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cb8b0945547c..ae9c13248a1d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -46,6 +46,7 @@
 #include <sound/initval.h>
 #include <sound/hdaudio.h>
 #include <sound/hda_i915.h>
+#include <sound/intel-nhlt.h>
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/firmware.h>
@@ -124,6 +125,7 @@ static char *patch[SNDRV_CARDS];
 static bool beep_mode[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] =
 					CONFIG_SND_HDA_INPUT_BEEP_MODE};
 #endif
+static bool dmic_detect = IS_ENABLED(CONFIG_SND_HDA_INTEL_DETECT_DMIC);
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for Intel HD audio interface.");
@@ -158,6 +160,8 @@ module_param_array(beep_mode, bool, NULL, 0444);
 MODULE_PARM_DESC(beep_mode, "Select HDA Beep registration mode "
 			    "(0=off, 1=on) (default=1).");
 #endif
+module_param(dmic_detect, bool, 0444);
+MODULE_PARM_DESC(dmic_detect, "DMIC detect on SKL+ platforms");
 
 #ifdef CONFIG_PM
 static int param_set_xint(const char *val, const struct kernel_param *kp);
@@ -2025,6 +2029,25 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.position_check = azx_position_check,
 };
 
+static int azx_check_dmic(struct pci_dev *pci, struct azx *chip)
+{
+	struct nhlt_acpi_table *nhlt;
+	int ret = 0;
+
+	if (chip->driver_type == AZX_DRIVER_SKL &&
+	    pci->class != 0x040300) {
+		nhlt = intel_nhlt_init(&pci->dev);
+		if (nhlt) {
+			if (intel_nhlt_get_dmic_geo(&pci->dev, nhlt)) {
+				ret = -ENODEV;
+				dev_info(&pci->dev, "Digital mics found on Skylake+ platform, aborting probe\n");
+			}
+			intel_nhlt_free(nhlt);
+		}
+	}
+	return ret;
+}
+
 static int azx_probe(struct pci_dev *pci,
 		     const struct pci_device_id *pci_id)
 {
@@ -2055,6 +2078,17 @@ static int azx_probe(struct pci_dev *pci,
 	card->private_data = chip;
 	hda = container_of(chip, struct hda_intel, chip);
 
+	/*
+	 * stop probe if digital microphones detected on Skylake+ platform
+	 * with the DSP enabled. This is an opt-in behavior defined at build
+	 * time or at run-time with a module parameter
+	 */
+	if (dmic_detect) {
+		err = azx_check_dmic(pci, chip);
+		if (err < 0)
+			goto out_free;
+	}
+
 	pci_set_drvdata(pci, card);
 
 	err = register_vga_switcheroo(chip);
-- 
2.20.1
