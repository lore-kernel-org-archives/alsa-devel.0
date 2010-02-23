From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH linux-2.6] hda_intel: ALSA HD Audio patch for Intel Cougar Point DeviceIDs, enables snoop
Date: Mon, 22 Feb 2010 17:31:09 -0800
Message-ID: <201002221731.09814.seth.heasley@intel.com>
References: <201001121703.36016.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201001121703.36016.seth.heasley@intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, seth.heasley@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the Intel Cougar Point (PCH) HD Audio Controller DeviceIDs, and enables snoop, eliminating static during
playback.  This patch supersedes the previous Cougar Point audio patch.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- sound/pci/hda/hda_intel.c.orig	2010-02-11 11:37:43.000000000 -0800
+++ sound/pci/hda/hda_intel.c	2010-02-22 10:05:48.000000000 -0800
@@ -449,6 +449,7 @@
 /* driver types */
 enum {
 	AZX_DRIVER_ICH,
+	AZX_DRIVER_PCH,
 	AZX_DRIVER_SCH,
 	AZX_DRIVER_ATI,
 	AZX_DRIVER_ATIHDMI,
@@ -463,6 +464,7 @@
 
 static char *driver_short_names[] __devinitdata = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
+	[AZX_DRIVER_PCH] = "HDA Intel PCH",
 	[AZX_DRIVER_SCH] = "HDA Intel MID",
 	[AZX_DRIVER_ATI] = "HDA ATI SB",
 	[AZX_DRIVER_ATIHDMI] = "HDA ATI HDMI",
@@ -1065,6 +1067,7 @@
 				0x01, NVIDIA_HDA_ENABLE_COHBIT);
 		break;
 	case AZX_DRIVER_SCH:
+	case AZX_DRIVER_PCH:
 		pci_read_config_word(chip->pci, INTEL_SCH_HDA_DEVC, &snoop);
 		if (snoop & INTEL_SCH_HDA_DEVC_NOSNOOP) {
 			pci_write_config_word(chip->pci, INTEL_SCH_HDA_DEVC,
@@ -2415,6 +2418,7 @@
 	if (bdl_pos_adj[dev] < 0) {
 		switch (chip->driver_type) {
 		case AZX_DRIVER_ICH:
+		case AZX_DRIVER_PCH:
 			bdl_pos_adj[dev] = 1;
 			break;
 		default:
@@ -2693,6 +2697,7 @@
 	{ PCI_DEVICE(0x8086, 0x3a6e), .driver_data = AZX_DRIVER_ICH },
 	/* PCH */
 	{ PCI_DEVICE(0x8086, 0x3b56), .driver_data = AZX_DRIVER_ICH },
+	{ PCI_DEVICE(0x8086, 0x1c20), .driver_data = AZX_DRIVER_PCH },
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b), .driver_data = AZX_DRIVER_SCH },
 	/* ATI SB 450/600 */
