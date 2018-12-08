From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ALSA: HD-Audio: SKL+: abort probe if DSP
	is present and Skylake driver selected
Date: Fri,  7 Dec 2018 18:00:38 -0600
Message-ID: <20181208000039.23384-2-pierre-louis.bossart@linux.intel.com>
References: <20181208000039.23384-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B348D267D2C
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 01:00:54 +0100 (CET)
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

Now that the SST/Skylake driver supports per platform selectors, we
can add logic to automatically select the right driver.

If the Skylake driver is selected, and the DSP is enable, the legacy
HDaudio driver aborts the probe. This will result in a single driver
probing and remove the need for modprobe blacklists.

Follow-up patches will add a module parameter to bypass the logic if
this automatic detection fails, or if the Skylake driver is unable to
actually support the platform (firmware authentication, missing
topology file, hardware issue, etc).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/Kconfig          | 46 ++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 34 +++++++++++++++++++------
 sound/soc/intel/Kconfig        |  6 +++++
 4 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 4235907b7858..634b7fe6a936 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -226,6 +226,52 @@ config SND_HDA_POWER_SAVE_DEFAULT
 	  The default time-out value in seconds for HD-audio automatic
 	  power-save mode.  0 means to disable the power-save mode.
 
+if SND_HDA_INTEL
+
+config SND_HDA_INTEL_DISABLE_SKL
+	bool
+	help
+	  This option disables HD-audio legacy for
+	  Skylake machines
+
+config SND_HDA_INTEL_DISABLE_APL
+	bool
+	help
+	  This option disables HD-audio legacy for
+	  Broxton/ApolloLake machines
+
+config SND_HDA_INTEL_DISABLE_KBL
+	bool
+	help
+	  This option disables HD-audio legacy for
+	  KabyLake machines
+
+config SND_HDA_INTEL_DISABLE_GLK
+	bool
+	help
+	  This option disables HD-audio legacy for
+	  GeminiLake machines
+
+config SND_HDA_INTEL_DISABLE_CNL
+	bool
+	help
+	  This option disables HD-audio legacy for
+	  CannonLake machines
+
+config SND_HDA_INTEL_DISABLE_CFL
+	bool
+	help
+	  This option disables HD-audio legacy for
+	  CoffeeLake machines
+
+config SND_HDA_INTEL_DISABLE_ICL
+	bool
+	help
+	  This option disables HD-audio legacy for
+	  IceLake machines
+
+endif ## SND_HDA_INTEL
+
 endif
 
 endmenu
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index c95097bb5a0c..2351115f922e 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -37,7 +37,7 @@
 #else
 #define AZX_DCAPS_I915_COMPONENT 0		/* NOP */
 #endif
-/* 14 unused */
+#define AZX_DCAPS_INTEL_SHARED	(1 << 14)	/* shared with ASoC */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
 /* 17 unused */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d8eb2b5f51ae..0c76713ac5c0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -360,6 +360,7 @@ enum {
 	 AZX_DCAPS_NO_64BIT |\
 	 AZX_DCAPS_4K_BDLE_BOUNDARY | AZX_DCAPS_SNOOP_OFF)
 
+#define AZX_DCAPS_INTEL_LEGACY_DISABLE(conf) (IS_ENABLED(CONFIG_SND_HDA_INTEL_DISABLE_##conf) ? AZX_DCAPS_INTEL_SHARED : 0)
 /*
  * vga_switcheroo support
  */
@@ -2091,6 +2092,11 @@ static int azx_probe(struct pci_dev *pci,
 	bool schedule_probe;
 	int err;
 
+	/* check if this driver can be used on SKL+ Intel platforms */
+	if ((pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) &&
+	    pci->class != 0x040300)
+		return -ENODEV;
+
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
@@ -2406,34 +2412,48 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
+	  AZX_DCAPS_INTEL_LEGACY_DISABLE(SKL)
+	},
 	/* Kabylake */
 	{ PCI_DEVICE(0x8086, 0xa171),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Kabylake-LP */
 	{ PCI_DEVICE(0x8086, 0x9d71),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
+	  AZX_DCAPS_INTEL_LEGACY_DISABLE(KBL)
+	},
 	/* Kabylake-H */
 	{ PCI_DEVICE(0x8086, 0xa2f0),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Coffelake */
 	{ PCI_DEVICE(0x8086, 0xa348),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
+	  AZX_DCAPS_INTEL_LEGACY_DISABLE(CFL)
+	},
 	/* Cannonlake */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
+	  AZX_DCAPS_INTEL_LEGACY_DISABLE(CNL)
+	},
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
+	  AZX_DCAPS_INTEL_LEGACY_DISABLE(ICL)
+	},
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON |
+	  AZX_DCAPS_INTEL_LEGACY_DISABLE(APL)
+	},
 	/* Broxton-T */
 	{ PCI_DEVICE(0x8086, 0x1a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
 	/* Gemini-Lake */
 	{ PCI_DEVICE(0x8086, 0x3198),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON |
+	  AZX_DCAPS_INTEL_LEGACY_DISABLE(GLK)
+	},
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 99a62ba409df..f817bda5cab5 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -188,6 +188,12 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
 	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
+	select SND_HDA_INTEL_DISABLE_SKL if SND_SOC_INTEL_SKL
+	select SND_HDA_INTEL_DISABLE_APL if SND_SOC_INTEL_APL
+	select SND_HDA_INTEL_DISABLE_KBL if SND_SOC_INTEL_KBL
+	select SND_HDA_INTEL_DISABLE_GLK if SND_SOC_INTEL_GLK
+	select SND_HDA_INTEL_DISABLE_CNL if SND_SOC_INTEL_CNL
+	select SND_HDA_INTEL_DISABLE_CFL if SND_SOC_INTEL_CFL
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
 	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
-- 
2.17.1
