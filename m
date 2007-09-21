From: "Peer Chen" <peerchen@gmail.com>
Subject: [PATCH] alsa: Add the MCP79 support to hda_intel driver
Date: Fri, 21 Sep 2007 14:18:19 +0800
Message-ID: <200709211418128243692@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756195AbXIUGSe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, akpm <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Resend the patch for description modification and send to correct alsa maillist.

Add the MCP79 support to hda driver.
The patch base on kernel 2.6.23-rc7
 
Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.23-rc7/sound/pci/hda/hda_intel.c.orig	2007-09-20 15:40:51.000000000 -0400
+++ linux-2.6.23-rc7/sound/pci/hda/hda_intel.c	2007-09-21 13:50:33.000000000 -0400
@@ -1791,6 +1791,10 @@ static struct pci_device_id azx_ids[] = 
 	{ 0x10de, 0x0775, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP77 */
 	{ 0x10de, 0x0776, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP77 */
 	{ 0x10de, 0x0777, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP77 */
+	{ 0x10de, 0x0ac0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP79 */
+	{ 0x10de, 0x0ac1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP79 */
+	{ 0x10de, 0x0ac2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP79 */
+	{ 0x10de, 0x0ac3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP79 */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
-
 				
--------------
Peer Chen
2007-09-21
