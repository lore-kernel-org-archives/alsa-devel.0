From: han.lu@intel.com
Subject: [PATCH 1/1] ALSA: hda - add PCI ID for Intel Broxton-T
Date: Wed, 20 Apr 2016 10:08:43 +0800
Message-ID: <1461118123-24009-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A33A264F39
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 04:09:05 +0200 (CEST)
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
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add HD Audio Device PCI ID for the Intel Broxton-T platform.
It is an HDA Intel PCH controller.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b680be0..637b8a0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2232,6 +2232,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
+	/* Broxton-T */
+	{ PCI_DEVICE(0x8086, 0x1a98),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
-- 
2.5.0
