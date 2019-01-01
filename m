From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] ALSA: hda - Revert DSP detection on legacy
	HD-audio driver
Date: Tue,  1 Jan 2019 09:08:40 +0100
Message-ID: <20190101080840.15395-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 03673267B24
 for <alsa-devel@alsa-project.org>; Tue,  1 Jan 2019 09:08:44 +0100 (CET)
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
Cc: Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Azat Khuzhin <dohardgopro@gmail.com>
List-Id: alsa-devel@alsa-project.org

This essentially reverts the commits
  c337104b1a16 ("ALSA: HD-Audio: SKL+: abort probe if DSP is present
  and Skylake driver selected")
and
  d82b51c855a2 ("ALSA: HD-Audio: SKL+: force HDaudio legacy or SKL+
  driver selection")
for the path of legacy HD-audio controller (snd-hda-intel).

The automatic DSP detection and skip of binding with the legacy driver
caused regressions on several machines like Dell XPS13.  They give the
PCI class 0x40380 indicating the availability of DSP while they don't
work with ASoC SKL driver (yet).

As the support of ASoC driver for such devices isn't available, it's
better to revert the whole DSP-detection-and-skip behavior of the
legacy driver, so that we can get the old good driver working on such
devices.

The pci_binding option for ASoC SKL driver is still kept so that it
can work without blacklisting.

Fixes: c337104b1a16 ("ALSA: HD-Audio: SKL+: abort probe if DSP is present and Skylake driver selected")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Hans de Goede <hdegoede@redhat.com>
Reported-by: Azat Khuzhin <dohardgopro@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Fix build error in sound/soc/intel/skylake/

 sound/pci/hda/Kconfig          | 62 ----------------------------------
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 54 ++++-------------------------
 sound/soc/intel/Kconfig        |  6 ----
 4 files changed, 8 insertions(+), 116 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 0d38c006e182..4235907b7858 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -226,68 +226,6 @@ config SND_HDA_POWER_SAVE_DEFAULT
 	  The default time-out value in seconds for HD-audio automatic
 	  power-save mode.  0 means to disable the power-save mode.
 
-if SND_HDA_INTEL
-
-# The options below should not be enabled by distributions or
-# users. They are selected by Intel/Skylake or SOF drivers when they
-# register for a PCI ID which is also handled by the HDAudio legacy
-# driver. When this option is selected and the DSP is detected based on
-# the PCI class/subclass/prog-if, the probe of the HDAudio legacy
-# aborts. This mechanism removes the need for distributions to use
-# blacklists. It can be bypassed with module parameters should the
-# Intel/Skylake or SOF drivers fail to handle a specific platform.
-
-config SND_HDA_INTEL_DSP_DETECTION_SKL
-	bool
-	help
-	  This option is selected by SOF or SST drivers, not users or distros.
-	  It enables DSP detection based on PCI class information for
-	  Skylake machines.
-
-config SND_HDA_INTEL_DSP_DETECTION_APL
-	bool
-	help
-	  This option is selected by SOF or SST drivers, not users or distros.
-	  It enables DSP detection based on PCI class information for
-	  Broxton/ApolloLake machines
-
-config SND_HDA_INTEL_DSP_DETECTION_KBL
-	bool
-	help
-	  This option is selected by SOF or SST drivers, not users or distros.
-	  It enables DSP detection based on PCI class information for
-	  KabyLake machines
-
-config SND_HDA_INTEL_DSP_DETECTION_GLK
-	bool
-	help
-	  This option is selected by SOF or SST drivers, not users or distros.
-	  It enables DSP detection based on PCI class information for
-	  GeminiLake machines
-
-config SND_HDA_INTEL_DSP_DETECTION_CNL
-	bool
-	help
-	  This option is selected by SOF or SST drivers, not users or distros.
-	  It enables DSP detection based on PCI class information for
-	  CannonLake machines
-
-config SND_HDA_INTEL_DSP_DETECTION_CFL
-	bool
-	help
-	  This option is selected by SOF or SST drivers, not users or distros.
-	  It enables DSP detection based on PCI class information for
-	  CoffeeLake machines
-
-config SND_HDA_INTEL_DSP_DETECTION_ICL
-	bool
-	help
-	  This option is selected by SOF or SST drivers, not users or distros.
-	  It enables DSP detection based on PCI class information for
-	  IceLake machines
-
-endif ## SND_HDA_INTEL
-
 endif
 
 endmenu
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index e0c3fcbaa028..7185ed574b41 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -37,7 +37,7 @@
 #else
 #define AZX_DCAPS_I915_COMPONENT 0		/* NOP */
 #endif
-#define AZX_DCAPS_INTEL_SHARED	(1 << 14)	/* shared with ASoC */
+/* 14 unused */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
 /* 17 unused */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e42cc2230977..e784130ea4e0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -172,9 +172,6 @@ module_param_array(beep_mode, bool, NULL, 0444);
 MODULE_PARM_DESC(beep_mode, "Select HDA Beep registration mode "
 			    "(0=off, 1=on) (default=1).");
 #endif
-static int skl_pci_binding;
-module_param_named(pci_binding, skl_pci_binding, int, 0444);
-MODULE_PARM_DESC(pci_binding, "PCI binding (0=auto, 1=only legacy, 2=only asoc");
 
 #ifdef CONFIG_PM
 static int param_set_xint(const char *val, const struct kernel_param *kp);
@@ -360,7 +357,6 @@ enum {
 	 AZX_DCAPS_NO_64BIT |\
 	 AZX_DCAPS_4K_BDLE_BOUNDARY | AZX_DCAPS_SNOOP_OFF)
 
-#define AZX_DCAPS_INTEL_DSP_DETECTION(conf) (IS_ENABLED(CONFIG_SND_HDA_INTEL_DSP_DETECTION_##conf) ? AZX_DCAPS_INTEL_SHARED : 0)
 /*
  * vga_switcheroo support
  */
@@ -2052,28 +2048,6 @@ static int azx_probe(struct pci_dev *pci,
 	bool schedule_probe;
 	int err;
 
-	/* check if this driver can be used on SKL+ Intel platforms */
-	if (pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) {
-		switch (skl_pci_binding) {
-		case SND_SKL_PCI_BIND_AUTO:
-			if (pci->class != 0x040300) {
-				dev_info(&pci->dev, "The DSP is enabled on this platform, aborting probe\n");
-				return -ENODEV;
-			}
-			dev_info(&pci->dev, "No DSP detected, continuing HDaudio legacy probe\n");
-			break;
-		case SND_SKL_PCI_BIND_LEGACY:
-			dev_info(&pci->dev, "Module parameter forced binding with HDaudio legacy, bypassed detection logic\n");
-			break;
-		case SND_SKL_PCI_BIND_ASOC:
-			dev_info(&pci->dev, "Module parameter forced binding with SKL+ ASoC driver, aborting probe\n");
-			return -ENODEV;
-		default:
-			dev_err(&pci->dev, "invalid value for skl_pci_binding module parameter, ignored\n");
-			break;
-		}
-	}
-
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
@@ -2380,48 +2354,34 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
-	  AZX_DCAPS_INTEL_DSP_DETECTION(SKL)
-	},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Kabylake */
 	{ PCI_DEVICE(0x8086, 0xa171),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Kabylake-LP */
 	{ PCI_DEVICE(0x8086, 0x9d71),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
-	  AZX_DCAPS_INTEL_DSP_DETECTION(KBL)
-	},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Kabylake-H */
 	{ PCI_DEVICE(0x8086, 0xa2f0),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Coffelake */
 	{ PCI_DEVICE(0x8086, 0xa348),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
-	  AZX_DCAPS_INTEL_DSP_DETECTION(CFL)
-	},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Cannonlake */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
-	  AZX_DCAPS_INTEL_DSP_DETECTION(CNL)
-	},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
-	  AZX_DCAPS_INTEL_DSP_DETECTION(ICL)
-	},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON |
-	  AZX_DCAPS_INTEL_DSP_DETECTION(APL)
-	},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
 	/* Broxton-T */
 	{ PCI_DEVICE(0x8086, 0x1a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
 	/* Gemini-Lake */
 	{ PCI_DEVICE(0x8086, 0x3198),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON |
-	  AZX_DCAPS_INTEL_DSP_DETECTION(GLK)
-	},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2fd1b61e8331..99a62ba409df 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -188,12 +188,6 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
 	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
-	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL
-	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL
-	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL
-	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK
-	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL
-	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
 	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
-- 
2.19.2
