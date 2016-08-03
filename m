From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Subject: [PATCH] ALSA: hda: add AMD Bonaire AZ PCI ID with proper driver caps
Date: Wed, 3 Aug 2016 16:46:39 +0530
Message-ID: <1470222999-8291-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: alexander.deucher@amd.com, stable@vger.kernel.org, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
List-Id: alsa-devel@alsa-project.org

This commit fixes garbled audio on Bonaire HDMI

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 6f8ea13..89dacf9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2265,6 +2265,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* ATI HDMI */
+	{ PCI_DEVICE(0x1002, 0x0002),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0x1308),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0x157a),
-- 
1.9.1
