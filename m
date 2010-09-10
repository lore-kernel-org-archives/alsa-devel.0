From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.35.4] hda_intel: ALSA HD Audio patch for Intel Patsburg DeviceIDs
Date: Fri, 10 Sep 2010 16:29:56 -0700
Message-ID: <201009101629.56579.seth.heasley@intel.com>
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

This patch adds the Intel Patsburg (PCH) HD Audio Controller DeviceIDs.
 
Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.35.4/sound/pci/hda/hda_intel.c.orig	2010-08-26 16:47:12.000000000 -0700
+++ linux-2.6.35.4/sound/pci/hda/hda_intel.c	2010-09-01 13:25:54.429224879 -0700
@@ -126,6 +126,7 @@
 			 "{Intel, ICH10},"
 			 "{Intel, PCH},"
 			 "{Intel, CPT},"
+			 "{Intel, PBG},"
 			 "{Intel, SCH},"
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
@@ -2748,6 +2749,8 @@
 	{ PCI_DEVICE(0x8086, 0x3b57), .driver_data = AZX_DRIVER_ICH },
 	/* CPT */
 	{ PCI_DEVICE(0x8086, 0x1c20), .driver_data = AZX_DRIVER_PCH },
+	/* PBG */
+	{ PCI_DEVICE(0x8086, 0x1d20), .driver_data = AZX_DRIVER_PCH },
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b), .driver_data = AZX_DRIVER_SCH },
 	/* ATI SB 450/600 */
