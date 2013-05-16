From: Chew Chiau Ee <chiau.ee.chew@intel.com>
Subject: [PATCH] ALSA: hda - add PCI IDs for Intel BayTrail
Date: Thu, 16 May 2013 13:27:18 +0800
Message-ID: <1368682038-21434-1-git-send-email-chiau.ee.chew@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Chew, Chiau Ee <chiau.ee.chew@intel.com>

Add HD Audio Device PCI ID for the Intel BayTrail platform.

Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bcd40ee..18640d9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3811,6 +3811,9 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	/* CPT */
 	{ PCI_DEVICE(0x8086, 0x1c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
+	/* BayTrail */
+	{ PCI_DEVICE(0x8086, 0x0f04),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
 	/* PBG */
 	{ PCI_DEVICE(0x8086, 0x1d20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
-- 
1.7.4.4
