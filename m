From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Define the DCAPS preset for
	the old Intel chipsets
Date: Wed,  3 Dec 2014 10:02:12 +0100
Message-ID: <1417597333-15749-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B5DA226043B
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 10:02:15 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7E946AD05
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 09:02:15 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Just for improving readability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fc7aff0eb562..53e43d111a3b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -276,6 +276,10 @@ enum {
 	(((chip)->driver_caps & AZX_DCAPS_SNOOP_MASK) >> 10)
 #define AZX_DCAPS_SNOOP_TYPE(type) ((AZX_SNOOP_TYPE_ ## type) << 10)
 
+/* quirks for old Intel chipsets */
+#define AZX_DCAPS_INTEL_ICH \
+	(AZX_DCAPS_OLD_SSYNC | AZX_DCAPS_BUFSIZE)
+
 /* quirks for Intel PCH */
 #define AZX_DCAPS_INTEL_PCH_NOPM \
 	(AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
@@ -2054,31 +2058,30 @@ static const struct pci_device_id azx_ids[] = {
 	/* Braswell */
 	{ PCI_DEVICE(0x8086, 0x2284),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
-	/* ICH */
+	/* ICH6 */
 	{ PCI_DEVICE(0x8086, 0x2668),
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-	  AZX_DCAPS_BUFSIZE },  /* ICH6 */
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
+	/* ICH7 */
 	{ PCI_DEVICE(0x8086, 0x27d8),
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-	  AZX_DCAPS_BUFSIZE },  /* ICH7 */
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
+	/* ESB2 */
 	{ PCI_DEVICE(0x8086, 0x269a),
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-	  AZX_DCAPS_BUFSIZE },  /* ESB2 */
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
+	/* ICH8 */
 	{ PCI_DEVICE(0x8086, 0x284b),
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-	  AZX_DCAPS_BUFSIZE },  /* ICH8 */
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
+	/* ICH9 */
 	{ PCI_DEVICE(0x8086, 0x293e),
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-	  AZX_DCAPS_BUFSIZE },  /* ICH9 */
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
+	/* ICH9 */
 	{ PCI_DEVICE(0x8086, 0x293f),
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-	  AZX_DCAPS_BUFSIZE },  /* ICH9 */
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
+	/* ICH10 */
 	{ PCI_DEVICE(0x8086, 0x3a3e),
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-	  AZX_DCAPS_BUFSIZE },  /* ICH10 */
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
+	/* ICH10 */
 	{ PCI_DEVICE(0x8086, 0x3a6e),
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-	  AZX_DCAPS_BUFSIZE },  /* ICH10 */
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
 	/* Generic Intel */
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
-- 
2.1.3
