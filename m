From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ALSA: hda - Add Coffelake PCI ID
Date: Wed, 14 Jun 2017 09:51:56 +0530
Message-ID: <1497414116-22733-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id BBCA426711B
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 06:36:52 +0200 (CEST)
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Megha Dey <megha.dey@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Megha Dey <megha.dey@intel.com>

Coffelake is another Intel part, so need to add PCI ID for it.

Signed-off-by: Megha Dey <megha.dey@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/pci/hda/hda_intel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1770f085c2a6..e3c696c46a21 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -371,9 +371,10 @@ enum {
 #define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
 #define IS_GLK(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x3198)
+#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
 #define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
 			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)	|| \
-			IS_GLK(pci)
+			IS_GLK(pci) || IS_CFL(pci)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -2378,6 +2379,9 @@ static void azx_shutdown(struct pci_dev *pci)
 	/* Kabylake-H */
 	{ PCI_DEVICE(0x8086, 0xa2f0),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
+	/* Coffelake */
+	{ PCI_DEVICE(0x8086, 0xa348),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
-- 
1.9.1
