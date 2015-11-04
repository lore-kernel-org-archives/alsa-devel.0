From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V2] Intel device IDs Audio
Date: Wed,  4 Nov 2015 15:56:09 -0800
Message-ID: <1446681369-15596-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V2] Intel device IDs Audio>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <[PATCH V2] Intel device IDs Audio>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Adding Intel codename Lewisburg platform device IDs for audio.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c38c68f..e8d1151 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2168,6 +2168,11 @@ static const struct pci_device_id azx_ids[] = {
 	/* ICH10 */
 	{ PCI_DEVICE(0x8086, 0x3a6e),
 	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
+	/* Lewisburg */
+	{ PCI_DEVICE(0x8086, 0xa1f0),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
+	{ PCI_DEVICE(0x8086, 0xa270),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Generic Intel */
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
-- 
1.9.1
