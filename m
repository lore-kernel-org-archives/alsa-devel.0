From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.39-rc3] hda_intel: ALSA HD Audio patch for Intel Panther Point DeviceIDs
Date: Wed, 20 Apr 2011 10:59:57 -0700
Message-ID: <201104201059.57882.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the HD Audio Controller DeviceIDs for the Intel Panther Point PCH.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
---
--- linux-2.6.39-rc3/sound/pci/hda/hda_intel.c.orig	2011-04-11 17:21:51.000000000 -0700
+++ linux-2.6.39-rc3/sound/pci/hda/hda_intel.c	2011-04-14 11:44:40.000000000 -0700
@@ -126,6 +126,7 @@
 			 "{Intel, ICH10},"
 			 "{Intel, PCH},"
 			 "{Intel, CPT},"
+			 "{Intel, PPT},"
 			 "{Intel, PBG},"
 			 "{Intel, SCH},"
 			 "{ATI, SB450},"
@@ -2759,6 +2760,8 @@
 	{ PCI_DEVICE(0x8086, 0x1c20), .driver_data = AZX_DRIVER_PCH },
 	/* PBG */
 	{ PCI_DEVICE(0x8086, 0x1d20), .driver_data = AZX_DRIVER_PCH },
+	/* Panther Point */
+	{ PCI_DEVICE(0x8086, 0x1e20), .driver_data = AZX_DRIVER_PCH },
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b), .driver_data = AZX_DRIVER_SCH },
 	/* Generic Intel */
