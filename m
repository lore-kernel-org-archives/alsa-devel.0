From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Add PCI DFI vendor ID
Date: Wed, 21 Jan 2009 17:45:12 -0500
Message-ID: <4977A578.7060805@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id B0A64103873
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 23:45:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Add a define for DFI PCI vendor id.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d56ad9c..c33d50c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2106,6 +2106,8 @@
 #define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
 #define PCI_DEVICE_ID_MELLANOX_SINAI	0x6274
 
+#define PCI_VENDOR_ID_DFI		0x15bd
+
 #define PCI_VENDOR_ID_QUICKNET		0x15e2
 #define PCI_DEVICE_ID_QUICKNET_XJ	0x0500
