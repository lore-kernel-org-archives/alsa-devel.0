From: "peerchen" <peerchen@gmail.com>
Subject: [alsa-devel][PATCH] hda_intel: Add the Device IDs for MCP89 and remove IDs of MCP7B to/from hda_intel.c
Date: Fri, 27 Feb 2009 17:03:19 +0800
Message-ID: <200902271703145182134@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756272AbZB0JEc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, akpm <akpm@linux-foundation.org>, pchen <pchen@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Added the Device IDs for MCP89 HD audio controller.
Removed the IDs of MCP7B cause this chipset had been cancelled.

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.29-rc6/sound/pci/hda/hda_intel.c.orig	2009-02-26 08:51:02.000000000 -0500
+++ linux-2.6.29-rc6/sound/pci/hda/hda_intel.c	2009-02-26 08:51:23.000000000 -0500
@@ -2442,10 +2442,10 @@ static struct pci_device_id azx_ids[] = 
 	{ PCI_DEVICE(0x10de, 0x0ac1), .driver_data = AZX_DRIVER_NVIDIA },
 	{ PCI_DEVICE(0x10de, 0x0ac2), .driver_data = AZX_DRIVER_NVIDIA },
 	{ PCI_DEVICE(0x10de, 0x0ac3), .driver_data = AZX_DRIVER_NVIDIA },
-	{ PCI_DEVICE(0x10de, 0x0bd4), .driver_data = AZX_DRIVER_NVIDIA },
-	{ PCI_DEVICE(0x10de, 0x0bd5), .driver_data = AZX_DRIVER_NVIDIA },
-	{ PCI_DEVICE(0x10de, 0x0bd6), .driver_data = AZX_DRIVER_NVIDIA },
-	{ PCI_DEVICE(0x10de, 0x0bd7), .driver_data = AZX_DRIVER_NVIDIA },
+	{ PCI_DEVICE(0x10de, 0x0d94), .driver_data = AZX_DRIVER_NVIDIA },
+	{ PCI_DEVICE(0x10de, 0x0d95), .driver_data = AZX_DRIVER_NVIDIA },
+	{ PCI_DEVICE(0x10de, 0x0d96), .driver_data = AZX_DRIVER_NVIDIA },
+	{ PCI_DEVICE(0x10de, 0x0d97), .driver_data = AZX_DRIVER_NVIDIA },
 	/* Teradici */
 	{ PCI_DEVICE(0x6549, 0x1200), .driver_data = AZX_DRIVER_TERA },
 	/* AMD Generic, PCI class code and Vendor ID for HD Audio */
-
