From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 1/5] hda - show HBR(High Bit Rate) pin cap in
	procfs
Date: Fri, 11 Dec 2009 12:28:33 +0800
Message-ID: <20091211043212.871707533@intel.com>
References: <20091211042832.691808920@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E3BF243CF
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 05:32:42 +0100 (CET)
Content-Disposition: inline; filename=hda-proc-hbr.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

Note that the HBR capability only applies to HDMI pin.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.h |    1 +
 sound/pci/hda/hda_proc.c  |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_codec.h	2009-12-02 10:11:39.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.h	2009-12-02 10:12:00.000000000 +0800
@@ -258,6 +258,7 @@ enum {
 #define AC_PINCAP_VREF			(0x37<<8)
 #define AC_PINCAP_VREF_SHIFT		8
 #define AC_PINCAP_EAPD			(1<<16)	/* EAPD capable */
+#define AC_PINCAP_HBR			(1<<27)	/* High Bit Rate */
 /* Vref status (used in pin cap) */
 #define AC_PINCAP_VREF_HIZ		(1<<0)	/* Hi-Z */
 #define AC_PINCAP_VREF_50		(1<<1)	/* 50% */
--- sound-2.6.orig/sound/pci/hda/hda_proc.c	2009-12-02 10:11:39.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_proc.c	2009-12-02 10:12:00.000000000 +0800
@@ -240,8 +240,11 @@ static void print_pin_caps(struct snd_in
 		/* Realtek uses this bit as a different meaning */
 		if ((codec->vendor_id >> 16) == 0x10ec)
 			snd_iprintf(buffer, " R/L");
-		else
+		else {
+			if (caps & AC_PINCAP_HBR)
+				snd_iprintf(buffer, " HBR");
 			snd_iprintf(buffer, " HDMI");
+		}
 	}
 	if (caps & AC_PINCAP_TRIG_REQ)
 		snd_iprintf(buffer, " Trigger");
