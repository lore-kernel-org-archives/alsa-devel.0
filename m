From: libin.yang@intel.com
Subject: [PATCH] ALSA: hda_intel: apply the Seperate stream_tag
	for Sunrise Point
Date: Thu, 26 Mar 2015 13:28:39 +0800
Message-ID: <1427347719-121305-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FB4826065A
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 06:35:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

The total stream number of Sunrise Point's input and output stream
exceeds 15, which will cause some streams do not work because
of the overflow on SDxCTL.STRM field if using the legacy
stream tag allocation method.

This patch uses the new stream tag allocation method by add
the flag AZX_DCAPS_SEPARATE_STREAM_TAG for Skylake platform.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index feebc1d..15a8299 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1963,7 +1963,7 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Sunrise Point */
 	{ PCI_DEVICE(0x8086, 0xa170),
-	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
-- 
1.9.1
