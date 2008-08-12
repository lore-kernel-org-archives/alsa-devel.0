From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.26.2][RESEND] hda_intel: ALSA HD patch for Intel Ibex Peak DeviceIDs
Date: Mon, 11 Aug 2008 17:02:58 -0700
Message-ID: <200808111702.58184.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758726AbYHKX6h@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Cc: seth.heasley@intel.com
List-Id: alsa-devel@alsa-project.org

Resend with proper whitespace.

This patch adds the Intel Ibex Peak (PCH) HD Audio Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.26.2/sound/pci/hda/hda_intel.c.orig	2008-08-08 11:25:05.000000000 -0700
+++ linux-2.6.26.2/sound/pci/hda/hda_intel.c	2008-08-08 11:27:24.000000000 -0700
@@ -98,6 +98,7 @@
 			 "{Intel, ICH8},"
 			 "{Intel, ICH9},"
 			 "{Intel, ICH10},"
+			 "{Intel, PCH},"
 			 "{Intel, SCH},"
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
@@ -2181,6 +2182,8 @@
 	{ PCI_DEVICE(0x8086, 0x293f), .driver_data = AZX_DRIVER_ICH },
 	{ PCI_DEVICE(0x8086, 0x3a3e), .driver_data = AZX_DRIVER_ICH },
 	{ PCI_DEVICE(0x8086, 0x3a6e), .driver_data = AZX_DRIVER_ICH },
+	/* PCH */
+	{ PCI_DEVICE(0x8086, 0x3b56), .driver_data = AZX_DRIVER_ICH },
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b), .driver_data = AZX_DRIVER_SCH },
 	/* ATI SB 450/600 */
