From: James Ralston <james.d.ralston@intel.com>
Subject: [PATCH 2/5] hda_intel: Add Device IDs for Intel Wellsburg PCH
Date: Fri,  8 Feb 2013 17:29:40 -0800
Message-ID: <1360373380-2016-1-git-send-email-james.d.ralston@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Seth Heasley <seth.heasley@intel.com>, James Ralston <james.d.ralston@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the HD Audio Device IDs for the Intel Wellsburg PCH

Signed-off-by: James Ralston <james.d.ralston@intel.com>
---
 sound/pci/hda/hda_intel.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c78286f..3218f4a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3611,6 +3611,11 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	/* Lynx Point */
 	{ PCI_DEVICE(0x8086, 0x8c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
+	/* Wellsburg */
+	{ PCI_DEVICE(0x8086, 0x8d20),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
+	{ PCI_DEVICE(0x8086, 0x8d21),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Lynx Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
-- 
1.7.7.6
