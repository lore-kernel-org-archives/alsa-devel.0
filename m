From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.32.3] hda_intel: ALSA HD Audio patch for Intel Cougar Point DeviceIDs
Date: Tue, 12 Jan 2010 17:03:35 -0800
Message-ID: <201001121703.36016.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753036Ab0AMBII@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Cc: seth.heasley@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the Intel Cougar Point (PCH) HD Audio Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.32.3/sound/pci/hda/hda_intel.c.orig	2010-01-06 15:07:45.000000000 -0800
+++ linux-2.6.32.3/sound/pci/hda/hda_intel.c	2010-01-07 13:10:28.000000000 -0800
@@ -116,6 +116,7 @@
 			 "{Intel, ICH9},"
 			 "{Intel, ICH10},"
 			 "{Intel, PCH},"
+			 "{Intel, CPT},"
 			 "{Intel, SCH},"
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
@@ -2648,6 +2649,8 @@
 	{ PCI_DEVICE(0x8086, 0x3a6e), .driver_data = AZX_DRIVER_ICH },
 	/* PCH */
 	{ PCI_DEVICE(0x8086, 0x3b56), .driver_data = AZX_DRIVER_ICH },
+	/* CPT */
+	{ PCI_DEVICE(0x8086, 0x1c20), .driver_data = AZX_DRIVER_ICH },
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b), .driver_data = AZX_DRIVER_SCH },
 	/* ATI SB 450/600 */
