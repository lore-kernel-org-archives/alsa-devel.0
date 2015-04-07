From: libin.yang@intel.com
Subject: [PATCH] ALSA: hda_intel: add AZX_DCAPS_I915_POWERWELL
	for SKL and BSW
Date: Tue,  7 Apr 2015 20:32:20 +0800
Message-ID: <1428409940-141877-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8163526055F
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 14:39:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Libin Yang <libin.yang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

HDMI/DP codec on SKL/BSW is in the power well.
The power well must be turned on before probing the
HDMI/DP codec.

This is a temporary patch, which will power on the
powerwell by adding AZX_DCAPS_I915_POWERWELL for SKL
and BSW. After restructuring and new flag is added,
this patch will be reverted.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/hda_intel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 15a8299..e1c2105 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -297,8 +297,12 @@ enum {
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
 	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
+#define AZX_DCAPS_INTEL_BRASWELL \
+	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_I915_POWERWELL)
+
 #define AZX_DCAPS_INTEL_SKYLAKE \
-	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_SEPARATE_STREAM_TAG)
+	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_SEPARATE_STREAM_TAG |\
+	 AZX_DCAPS_I915_POWERWELL)
 
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
@@ -1991,7 +1995,7 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
 	/* Braswell */
 	{ PCI_DEVICE(0x8086, 0x2284),
-	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BRASWELL },
 	/* ICH6 */
 	{ PCI_DEVICE(0x8086, 0x2668),
 	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
-- 
1.9.1
