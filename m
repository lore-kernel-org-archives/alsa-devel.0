From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: hda - Merge RIRB_PRE_DELAY into
	CTX_WORKAROUND caps
Date: Thu, 17 Dec 2015 08:35:43 +0100
Message-ID: <1450337746-4580-2-git-send-email-tiwai@suse.de>
References: <1450337746-4580-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C78472654ED
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 08:35:46 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8A37EACB5
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 07:35:44 +0000 (UTC)
In-Reply-To: <1450337746-4580-1-git-send-email-tiwai@suse.de>
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

AZX_DCAPS_RIRB_PRE_DELAY is always tied with AZX_DCAPS_CTX_WORKAROUND,
which is Creative's XFi specific.  So, we can replace it and reduce
one more bit free for DCAPS.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 2 +-
 sound/pci/hda/hda_controller.h | 2 +-
 sound/pci/hda/hda_intel.c      | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 10c77074b4dc..34022a36e5c5 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -956,7 +956,7 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
 	status = azx_readb(chip, RIRBSTS);
 	if (status & RIRB_INT_MASK) {
 		if (status & RIRB_INT_RESPONSE) {
-			if (chip->driver_caps & AZX_DCAPS_RIRB_PRE_DELAY)
+			if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
 				udelay(80);
 			snd_hdac_bus_update_rirb(bus);
 		}
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index a32ec9004edd..c723bcc7fcef 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -33,7 +33,7 @@
 #define AZX_DCAPS_SNOOP_MASK	(3 << 10)	/* snoop type mask */
 #define AZX_DCAPS_SNOOP_OFF	(1 << 12)	/* snoop default off */
 #define AZX_DCAPS_RIRB_DELAY	(1 << 13)	/* Long delay in read loop */
-#define AZX_DCAPS_RIRB_PRE_DELAY (1 << 14)	/* Put a delay before read */
+/* 14 unused */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
 #define AZX_DCAPS_POSFIX_VIA	(1 << 17)	/* Use VIACOMBO as default */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 56ef6b6fb546..2d2f14830df7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2314,14 +2314,12 @@ static const struct pci_device_id azx_ids[] = {
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
 	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
-	  AZX_DCAPS_NO_64BIT |
-	  AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
+	  AZX_DCAPS_NO_64BIT | AZX_DCAPS_POSFIX_LPIB },
 #else
 	/* this entry seems still valid -- i.e. without emu20kx chip */
 	{ PCI_DEVICE(0x1102, 0x0009),
 	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
-	  AZX_DCAPS_NO_64BIT |
-	  AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
+	  AZX_DCAPS_NO_64BIT | AZX_DCAPS_POSFIX_LPIB },
 #endif
 	/* CM8888 */
 	{ PCI_DEVICE(0x13f6, 0x5011),
-- 
2.6.4
