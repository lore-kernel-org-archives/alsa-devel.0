From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: hda - Add Geminilake PCI ID
Date: Sat, 25 Feb 2017 04:12:40 +0530
Message-ID: <1487976160-25293-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 074B72668C0
 for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2017 23:42:01 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Geminilake is another Intel part, so need to add PCI ID for it.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 16108f0eb688..c8256a89375a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2255,6 +2255,9 @@ static void azx_shutdown(struct pci_dev *pci)
 	/* Broxton-T */
 	{ PCI_DEVICE(0x8086, 0x1a98),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
+	/* Gemini-Lake */
+	{ PCI_DEVICE(0x8086, 0x3198),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
-- 
1.9.1
