From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ALSA: hda: Add Raven PCI ID
Date: Thu, 23 Nov 2017 18:17:44 +0530
Message-ID: <1511441264-5851-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, Alexander.Deucher@amd.com
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

This commit adds PCI ID for Raven platform

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 01eb1dc..9c7d479 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2454,6 +2454,8 @@ static const struct pci_device_id azx_ids[] = {
 	/* AMD Hudson */
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	{ PCI_DEVICE(0x1022, 0x15e3),
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x0002),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
-- 
2.7.4
