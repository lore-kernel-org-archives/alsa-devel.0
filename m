From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 1/6] hda_intel: Add Lynx Point HD Audio Controller DeviceIDs
Date: Mon, 23 Jan 2012 16:24:31 -0800
Message-ID: <201201231624.31275.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, perex@perex.cz
Cc: linux-kernel@vger.kernel.org, james.d.ralston@intel.com, seth.heasley@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the HD Audio DeviceIDs for the Intel Lynx Point PCH.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
---
 sound/pci/hda/hda_intel.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0852e20..adb4fa7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -148,6 +148,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},"
 			 "{Intel, PCH},"
 			 "{Intel, CPT},"
 			 "{Intel, PPT},"
+			 "{Intel, LPT},"
 			 "{Intel, PBG},"
 			 "{Intel, SCH},"
 			 "{ATI, SB450},"
@@ -2989,6 +2990,10 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	{ PCI_DEVICE(0x8086, 0x1e20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
 	  AZX_DCAPS_BUFSIZE},
+	/* Lynx Point */
+	{ PCI_DEVICE(0x8086, 0x8c20),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
+	  AZX_DCAPS_BUFSIZE},
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-- 
1.7.4.4
