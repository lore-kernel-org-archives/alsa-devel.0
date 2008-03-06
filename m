From: "peerchen" <peerchen@gmail.com>
Subject: [PATCH] hda_intel: Add the DIDs of nvidia MCP79 HD
	audio controller to hda_intel.c
Date: Thu, 6 Mar 2008 21:22:56 +0800
Message-ID: <200803062122514065891@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 35BDB244BC
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 14:23:15 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1932453wag.8
	for <alsa-devel@alsa-project.org>; Thu, 06 Mar 2008 05:23:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: tiwai <tiwai@suse.de>, akpm <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Add the Device IDs of nvidia MCP79 HD audio controller to hda_intel.c

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.25-rc4/sound/pci/hda/hda_intel.c.orig	2008-03-04 21:51:07.000000000 -0500
+++ linux-2.6.25-rc4/sound/pci/hda/hda_intel.c	2008-03-04 21:53:43.000000000 -0500
@@ -2036,6 +2036,10 @@ static struct pci_device_id azx_ids[] = 
 	{ 0x10de, 0x0ac1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP79 */
 	{ 0x10de, 0x0ac2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP79 */
 	{ 0x10de, 0x0ac3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP79 */
+	{ 0x10de, 0x0bd4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP7B */
+	{ 0x10de, 0x0bd5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP7B */
+	{ 0x10de, 0x0bd6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP7B */
+	{ 0x10de, 0x0bd7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP7B */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
-
