From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] hda: set proper caps for newer AMD hda audio in KB/KV
Date: Wed, 24 Jun 2015 14:37:18 -0400
Message-ID: <1435171038-3961-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes audio problems on newer asics.

Noticed by: Kelly Anderson <kelly@xilka.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 sound/pci/hda/hda_intel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a8a1e14..479ee25 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2056,6 +2056,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* ATI HDMI */
+	{ PCI_DEVICE(0x1002, 0x1308),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0x793b),
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
 	{ PCI_DEVICE(0x1002, 0x7919),
@@ -2064,6 +2066,8 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
 	{ PCI_DEVICE(0x1002, 0x970f),
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0x9840),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0xaa00),
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
 	{ PCI_DEVICE(0x1002, 0xaa08),
-- 
1.8.3.1
