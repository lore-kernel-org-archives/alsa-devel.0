From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: hda - Add PCI ID for Kabylake-H
Date: Wed, 29 Jun 2016 10:27:52 +0530
Message-ID: <1467176272-13994-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Kabylake-H shows up as PCI ID 0xa2f0. We missed adding this
earlier with other KBL IDs.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/hda_intel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 94089fc71884..e320c44714b1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -367,9 +367,10 @@ enum {
 #define IS_SKL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d70)
 #define IS_KBL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa171)
 #define IS_KBL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d71)
+#define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
 #define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
-			IS_KBL(pci) || IS_KBL_LP(pci)
+			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -2190,6 +2191,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Kabylake-LP */
 	{ PCI_DEVICE(0x8086, 0x9d71),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
+	/* Kabylake-H */
+	{ PCI_DEVICE(0x8086, 0xa2f0),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
-- 
1.9.1
