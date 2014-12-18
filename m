From: libin.yang@intel.com
Subject: [PATCH 2/2] ALSA: hda_intel: apply the Seperate
	stream_tag for Skylake
Date: Thu, 18 Dec 2014 14:13:51 +0800
Message-ID: <1418883231-29170-2-git-send-email-libin.yang@intel.com>
References: <1418883231-29170-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4185E260467
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 07:18:45 +0100 (CET)
In-Reply-To: <1418883231-29170-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: libin.yang@intel.com, vinod.koul@intel.com, jayachandran.b@intel.com, rafal.f.redzimski@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

The total stream number of Skylake's input and output stream
exceeds 15, which will cause some streams do not work because
of the overflow on SDxCTL.STRM field if using the legacy
stream tag allocation method.

This patch uses the new stream tag allocation method by add
the flag AZX_DCAPS_SEPARATE_STREAM_TAG for Skylake platform.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_intel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5ac0d39..927daf4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -299,6 +299,9 @@ enum {
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
 	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
+#define AZX_DCAPS_INTEL_SKYLAKE \
+	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_SEPARATE_STREAM_TAG)
+
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
 	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB |\
@@ -2030,7 +2033,7 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
-	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
-- 
1.9.1
