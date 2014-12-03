From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Drop AZX_DCAPS_ALIGN_BUFSIZE
Date: Wed,  3 Dec 2014 10:02:13 +0100
Message-ID: <1417597333-15749-2-git-send-email-tiwai@suse.de>
References: <1417597333-15749-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B7B29260448
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 10:02:15 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7E7F6AD01
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 09:02:15 +0000 (UTC)
In-Reply-To: <1417597333-15749-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We introduced AZX_DCAPS_ALIGN_BUFSIZE to explicity show that the
controller needs the alignment, with a slight hope that the buffer
size alignment will be disabled as default in future.  But the reality
tells that most chips need the buffer size alignment, and it'll be
likely enabled in future, too.

This patch drops AZX_DCAPS_ALIGN_BUFSIZE to give back one more
previous DCAPS bit for future use.  At the same time, rename
AZX_DCAPS_BUFSIZE with AZX_DCAPS_NO_ALIGN_BUFSIZE for avoiding
confusion.

AZX_DCAPS_ALIGN_BUFSIZE are still kept (but commented out) in each
DCAPS presets for a purpose as markers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 16 +++++++---------
 sound/pci/hda/hda_priv.h  |  4 ++--
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 53e43d111a3b..5ac0d39d59bc 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -278,24 +278,24 @@ enum {
 
 /* quirks for old Intel chipsets */
 #define AZX_DCAPS_INTEL_ICH \
-	(AZX_DCAPS_OLD_SSYNC | AZX_DCAPS_BUFSIZE)
+	(AZX_DCAPS_OLD_SSYNC | AZX_DCAPS_NO_ALIGN_BUFSIZE)
 
 /* quirks for Intel PCH */
 #define AZX_DCAPS_INTEL_PCH_NOPM \
-	(AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
+	(AZX_DCAPS_NO_ALIGN_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
 	 AZX_DCAPS_REVERSE_ASSIGN | AZX_DCAPS_SNOOP_TYPE(SCH))
 
 #define AZX_DCAPS_INTEL_PCH \
 	(AZX_DCAPS_INTEL_PCH_NOPM | AZX_DCAPS_PM_RUNTIME)
 
 #define AZX_DCAPS_INTEL_HASWELL \
-	(AZX_DCAPS_ALIGN_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
+	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_COUNT_LPIB_DELAY |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
 	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 /* Broadwell HDMI can't use position buffer reliably, force to use LPIB */
 #define AZX_DCAPS_INTEL_BROADWELL \
-	(AZX_DCAPS_ALIGN_BUFSIZE | AZX_DCAPS_POSFIX_LPIB |\
+	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_POSFIX_LPIB |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
 	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
@@ -315,7 +315,7 @@ enum {
 
 /* quirks for Nvidia */
 #define AZX_DCAPS_PRESET_NVIDIA \
-	(AZX_DCAPS_RIRB_DELAY | AZX_DCAPS_NO_MSI | AZX_DCAPS_ALIGN_BUFSIZE |\
+	(AZX_DCAPS_RIRB_DELAY | AZX_DCAPS_NO_MSI | /*AZX_DCAPS_ALIGN_BUFSIZE |*/ \
 	 AZX_DCAPS_NO_64BIT | AZX_DCAPS_CORBRP_SELF_CLEAR |\
 	 AZX_DCAPS_SNOOP_TYPE(NVIDIA))
 
@@ -1568,10 +1568,8 @@ static int azx_first_init(struct azx *chip)
 	if (align_buffer_size >= 0)
 		chip->align_buffer_size = !!align_buffer_size;
 	else {
-		if (chip->driver_caps & AZX_DCAPS_BUFSIZE)
+		if (chip->driver_caps & AZX_DCAPS_NO_ALIGN_BUFSIZE)
 			chip->align_buffer_size = 0;
-		else if (chip->driver_caps & AZX_DCAPS_ALIGN_BUFSIZE)
-			chip->align_buffer_size = 1;
 		else
 			chip->align_buffer_size = 1;
 	}
@@ -2086,7 +2084,7 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
-	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_BUFSIZE },
+	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_NO_ALIGN_BUFSIZE },
 	/* ATI SB 450/600/700/800/900 */
 	{ PCI_DEVICE(0x1002, 0x437b),
 	  .driver_data = AZX_DRIVER_ATI | AZX_DCAPS_PRESET_ATI_SB },
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index a09703a2b2c1..aa484fdf4338 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -162,8 +162,8 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_DCAPS_NO_64BIT	(1 << 18)	/* No 64bit address */
 #define AZX_DCAPS_SYNC_WRITE	(1 << 19)	/* sync each cmd write */
 #define AZX_DCAPS_OLD_SSYNC	(1 << 20)	/* Old SSYNC reg for ICH */
-#define AZX_DCAPS_BUFSIZE	(1 << 21)	/* no buffer size alignment */
-#define AZX_DCAPS_ALIGN_BUFSIZE	(1 << 22)	/* buffer size alignment */
+#define AZX_DCAPS_NO_ALIGN_BUFSIZE (1 << 21)	/* no buffer size alignment */
+/* 22 unused */
 #define AZX_DCAPS_4K_BDLE_BOUNDARY (1 << 23)	/* BDLE in 4k boundary */
 #define AZX_DCAPS_REVERSE_ASSIGN (1 << 24)	/* Assign devices in reverse order */
 #define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)	/* Take LPIB as delay */
-- 
2.1.3
