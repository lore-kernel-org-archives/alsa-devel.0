From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] Fix PCI ID define for ICH6 in intel8x0
Date: Sat, 29 Jan 2005 18:05:34 +0100
Message-ID: <20050129180534.145ee817.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kraid.nerim.net (smtp-106-saturday.nerim.net [62.4.16.106])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 367AF22E
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2005 18:05:24 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi all,

While searching the Linux 2.6 kernel tree for ICH6 PCI IDs (for
something completely unrelated to ALSA) I noticed that the intel8x0 ALSA
sound driver is not using the correct PCI ID name for the ICH6 sound
device. Namely, it uses PCI_DEVICE_ID_INTEL_ICH6_3 instead of
PCI_DEVICE_ID_INTEL_ICH6_18.

Searching through the kernel history, I found that the 8086:266e device
actually had been named PCI_DEVICE_ID_INTEL_ICH6_3 for a short time,
before all ICH6 device IDs were added, at which time it became
PCI_DEVICE_ID_INTEL_ICH6_18 (in both the 2.4 and 2.6 Linux kernel
trees). This obviously explains the wrong name being used in the ALSA
driver.

This error could actually cause trouble in the 2.6 kernel tree, because
include/linux/pci_ids.h says:

#define PCI_DEVICE_ID_INTEL_ICH6_3	0x2651
(...)
#define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e

while the intel8x0 sound driver says:

#ifndef PCI_DEVICE_ID_INTEL_ICH6_3
#define PCI_DEVICE_ID_INTEL_ICH6_3	0x266e
#endif

Obviously PCI_DEVICE_ID_INTEL_ICH6_3 *is* defined, but not to the
correct value, causing the driver to use 0x2651 instead.

It doesn't seem to have too big an impact on the code, because 0x266e is
hardcoded in the pci_device_id table anyway, but in the "shortname"
table it isn't, so I guess the driver isn't currently able to properly
display the name of ICH6 devices.

The 2.4 kernel isn't affected because PCI_DEVICE_ID_INTEL_ICH6_3 isn't
defined there anymore.

An (untested) patch follows, which fixes the problem as far as I can
see.

--- alsa-driver-1.0.8/alsa-kernel/pci/intel8x0.c.orig	2005-01-07 19:48:43.000000000 +0100
+++ alsa-driver-1.0.8/alsa-kernel/pci/intel8x0.c	2005-01-29 17:48:35.000000000 +0100
@@ -117,8 +117,8 @@
 #ifndef PCI_DEVICE_ID_INTEL_ESB_5
 #define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
 #endif
-#ifndef PCI_DEVICE_ID_INTEL_ICH6_3
-#define PCI_DEVICE_ID_INTEL_ICH6_3	0x266e
+#ifndef PCI_DEVICE_ID_INTEL_ICH6_18
+#define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #endif
 #ifndef PCI_DEVICE_ID_SI_7012
 #define PCI_DEVICE_ID_SI_7012		0x7012
@@ -2702,7 +2702,7 @@
 	{ PCI_DEVICE_ID_INTEL_ICH4, "Intel 82801DB-ICH4" },
 	{ PCI_DEVICE_ID_INTEL_ICH5, "Intel ICH5" },
 	{ PCI_DEVICE_ID_INTEL_ESB_5, "Intel 6300ESB" },
-	{ PCI_DEVICE_ID_INTEL_ICH6_3, "Intel ICH6" },
+	{ PCI_DEVICE_ID_INTEL_ICH6_18, "Intel ICH6" },
 	{ PCI_DEVICE_ID_SI_7012, "SiS SI7012" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP_AUDIO, "NVidia nForce" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO, "NVidia nForce2" },


-- 
Jean Delvare
http://khali.linux-fr.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
