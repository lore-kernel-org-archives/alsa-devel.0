From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ALSA: HD-Audio: SKL+: force HDaudio legacy
	or SKL+ driver selection
Date: Fri,  7 Dec 2018 18:00:39 -0600
Message-ID: <20181208000039.23384-3-pierre-louis.bossart@linux.intel.com>
References: <20181208000039.23384-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AD5F5267D20
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 01:00:55 +0100 (CET)
In-Reply-To: <20181208000039.23384-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

For HDaudio and Skylake drivers, add module parameter "pci_binding"

When pci_binding == 0 (AUTO), the PCI class/subclass info is used to
select drivers based on the presence of the DSP.

pci_binding == 1 (LEGACY) forces the use of the HDAudio legacy driver,
even if the DSP is present.

pci_binding == 2 (ASOC) forces the use of the ASOC driver. The
information on the DSP presence is bypassed.

The value for the module parameter needs to be identical for both
drivers. This parameter is intended as a back-up solution if the
automatic detection fails or when the DSP usage fails. Such cases
should be reported on the alsa-devel mailing list for analysis.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/hdaudio.h       |  6 +++++
 sound/pci/hda/hda_intel.c     | 25 +++++++++++++++++---
 sound/soc/intel/skylake/skl.c | 44 ++++++++++++++++++++++++-----------
 3 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index cd1773d0e08f..5934d7f228f0 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -99,6 +99,12 @@ enum {
 	HDA_DEV_ASOC,
 };
 
+enum {
+	SND_SKL_PCI_BIND_AUTO,	/* automatic selection based on pci class */
+	SND_SKL_PCI_BIND_LEGACY,/* bind only with legacy driver */
+	SND_SKL_PCI_BIND_ASOC	/* bind only with ASoC driver */
+};
+
 /* direction */
 enum {
 	HDA_INPUT, HDA_OUTPUT
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0c76713ac5c0..4e1aee5167a1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -172,6 +172,9 @@ module_param_array(beep_mode, bool, NULL, 0444);
 MODULE_PARM_DESC(beep_mode, "Select HDA Beep registration mode "
 			    "(0=off, 1=on) (default=1).");
 #endif
+static int skl_pci_binding;
+module_param_named(pci_binding, skl_pci_binding, int, 0444);
+MODULE_PARM_DESC(legacy, "PCI binding (0=auto, 1=only legacy, 2=only asoc");
 
 #ifdef CONFIG_PM
 static int param_set_xint(const char *val, const struct kernel_param *kp);
@@ -2093,9 +2096,25 @@ static int azx_probe(struct pci_dev *pci,
 	int err;
 
 	/* check if this driver can be used on SKL+ Intel platforms */
-	if ((pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) &&
-	    pci->class != 0x040300)
-		return -ENODEV;
+	if (pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) {
+		switch (skl_pci_binding) {
+		case SND_SKL_PCI_BIND_AUTO:
+			if (pci->class != 0x040300) {
+				dev_warn(&pci->dev, "The DSP is enabled on this platform, aborting probe\n");
+				return -ENODEV;
+			}
+			break;
+		case SND_SKL_PCI_BIND_LEGACY:
+			dev_warn(&pci->dev, "Module parameter forced binding with HDaudio legacy, bypassed detection logic\n");
+			break;
+		case SND_SKL_PCI_BIND_ASOC:
+			dev_err(&pci->dev, "Module parameter forced binding with SKL+ ASoC driver, aborting probe\n");
+			return -ENODEV;
+		default:
+			dev_err(&pci->dev, "invalid value for skl_pci_binding module parameter, ignored\n");
+			break;
+		}
+	}
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index bb8257013c8b..ff5b8012eb2f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -40,6 +40,9 @@
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
 #include "../../../soc/codecs/hdac_hda.h"
 #endif
+static int skl_pci_binding;
+module_param_named(pci_binding, skl_pci_binding, int, 0444);
+MODULE_PARM_DESC(legacy, "PCI binding (0=auto, 1=only legacy, 2=only asoc");
 
 /*
  * initialize the PCI registers
@@ -987,22 +990,35 @@ static int skl_probe(struct pci_dev *pci,
 	struct hdac_bus *bus = NULL;
 	int err;
 
-	/*
-	 * detect DSP by checking class/subclass/prog-id information
-	 * class=04 subclass 03 prog-if 00: no DSP, legacy driver required
-	 * class=04 subclass 01 prog-if 00: DSP is present
-	 *   (and may be required e.g. for DMIC or SSP support)
-	 * class=04 subclass 03 prog-if 80: DSP or legacy mode can be used
-	 */
-	if (pci->class == 0x040300) {
-		dev_err(&pci->dev, "The DSP is not enabled on this platform, aborting probe\n");
-		return -ENODEV;
-	}
-	if (pci->class != 0x040100 && pci->class != 0x040380) {
-		dev_err(&pci->dev, "Unknown PCI class/subclass/prog-if information (0x%06x) found, aborting probe\n", pci->class);
+	switch (skl_pci_binding) {
+	case SND_SKL_PCI_BIND_AUTO:
+		/*
+		 * detect DSP by checking class/subclass/prog-id information
+		 * class=04 subclass 03 prog-if 00: no DSP, legacy driver required
+		 * class=04 subclass 01 prog-if 00: DSP is present
+		 *   (and may be required e.g. for DMIC or SSP support)
+		 * class=04 subclass 03 prog-if 80: DSP or legacy mode can be used
+		 */
+		if (pci->class == 0x040300) {
+			dev_err(&pci->dev, "The DSP is not enabled on this platform, aborting probe\n");
+			return -ENODEV;
+		}
+		if (pci->class != 0x040100 && pci->class != 0x040380) {
+			dev_err(&pci->dev, "Unknown PCI class/subclass/prog-if information (0x%06x) found, aborting probe\n", pci->class);
+			return -ENODEV;
+		}
+		dev_info(&pci->dev, "DSP detected with PCI class/subclass/prog-if info 0x%06x\n", pci->class);
+		break;
+	case SND_SKL_PCI_BIND_LEGACY:
+		dev_warn(&pci->dev, "Module parameter forced binding with HDaudio legacy, aborting probe\n");
 		return -ENODEV;
+	case SND_SKL_PCI_BIND_ASOC:
+		dev_warn(&pci->dev, "Module parameter forced binding with SKL driver, bypassed detection logic\n");
+		break;
+	default:
+		dev_err(&pci->dev, "invalid value for skl_pci_binding module parameter, ignored\n");
+		break;
 	}
-	dev_info(&pci->dev, "DSP detected with PCI class/subclass/prog-if info 0x%06x\n", pci->class);
 
 	/* we use ext core ops, so provide NULL for ops here */
 	err = skl_create(pci, NULL, &skl);
-- 
2.17.1
