From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH] ALSA: hda: Add Icelake PCI ID
Date: Tue, 13 Mar 2018 16:40:08 +0530
Message-ID: <20180313111008.26099-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E686266F68
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 12:10:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Guneshwor Singh <guneshwor.o.singh@intel.com>
List-Id: alsa-devel@alsa-project.org

Icelake is a next generation Intel platform. Add PCI ID for
it.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 96143df19b21..32acab080781 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2426,6 +2426,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Cannonlake */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Icelake */
+	{ PCI_DEVICE(0x8086, 0x34c8),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
-- 
2.16.2
