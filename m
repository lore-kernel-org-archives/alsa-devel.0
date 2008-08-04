From: "peerchen" <peerchen@gmail.com>
Subject: [alsa-devel][PATCH] hda_intel: enable snoop for nvidia HDA controller
Date: Mon, 4 Aug 2008 17:57:18 +0800
Message-ID: <200808041757132250842@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754162AbYHDJ5d@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
Cc: akpm <akpm@linux-foundation.org>, pchen <pchen@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Enable the snoop for nvidia hda controller to avoid data coherence issue.

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.27-rc1/sound/pci/hda/hda_intel.c.orig	2008-08-01 14:14:54.000000000 -0400
+++ linux-2.6.27-rc1/sound/pci/hda/hda_intel.c	2008-08-01 14:31:38.000000000 -0400
@@ -277,6 +277,9 @@ enum {
 /* Defines for Nvidia HDA support */
 #define NVIDIA_HDA_TRANSREG_ADDR      0x4e
 #define NVIDIA_HDA_ENABLE_COHBITS     0x0f
+#define NVIDIA_HDA_ISTRM_COH          0x4d
+#define NVIDIA_HDA_OSTRM_COH          0x4c
+#define NVIDIA_HDA_ENABLE_COHBIT      0x01
 
 /* Defines for Intel SCH HDA snoop control */
 #define INTEL_SCH_HDA_DEVC      0x78
@@ -899,6 +902,12 @@ static void azx_init_pci(struct azx *chi
 		update_pci_byte(chip->pci,
 				NVIDIA_HDA_TRANSREG_ADDR,
 				0x0f, NVIDIA_HDA_ENABLE_COHBITS);
+		update_pci_byte(chip->pci,
+				NVIDIA_HDA_ISTRM_COH,
+				0x01, NVIDIA_HDA_ENABLE_COHBIT);
+		update_pci_byte(chip->pci,
+				NVIDIA_HDA_OSTRM_COH,
+				0x01, NVIDIA_HDA_ENABLE_COHBIT);				
 		break;
 	case AZX_DRIVER_SCH:
 		pci_read_config_word(chip->pci, INTEL_SCH_HDA_DEVC, &snoop);
-
