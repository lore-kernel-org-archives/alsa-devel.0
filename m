From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: hda - Add PCI ID for Kabylake
Date: Thu,  9 Jun 2016 11:32:14 +0530
Message-ID: <1465452134-24200-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Kabylake shows up as PCI ID 0xa171. And Kabylake-LP as 0x9d71.
Since these are similar to Skylake add these to SKL_PLUS macro

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/hda_intel.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9a0d1445ca5c..94089fc71884 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -365,8 +365,11 @@ enum {
 
 #define IS_SKL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa170)
 #define IS_SKL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d70)
+#define IS_KBL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa171)
+#define IS_KBL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d71)
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
-#define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci))
+#define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
+			IS_KBL(pci) || IS_KBL_LP(pci)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -2181,6 +2184,12 @@ static const struct pci_device_id azx_ids[] = {
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
+	/* Kabylake */
+	{ PCI_DEVICE(0x8086, 0xa171),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
+	/* Kabylake-LP */
+	{ PCI_DEVICE(0x8086, 0x9d71),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
-- 
1.9.1
