From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ALSA: hda: Add Raven PCI ID
Date: Thu, 23 Nov 2017 20:07:00 +0530
Message-ID: <1511447820-6720-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, Alexander.Deucher@amd.com
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

This commit adds PCI ID for Raven platform
v2: Comment added for Raven

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 01eb1dc..44babe5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2454,6 +2454,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* AMD Hudson */
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	/* AMD Raven */
+	{ PCI_DEVICE(0x1022, 0x15e3),
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x0002),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
-- 
2.7.4
