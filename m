From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: hda - Move Nvidia-specific check
	into hda_intel.c
Date: Thu, 17 Dec 2015 08:35:44 +0100
Message-ID: <1450337746-4580-3-git-send-email-tiwai@suse.de>
References: <1450337746-4580-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C89062654EF
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 08:35:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 85A2AABBB
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

AZX_DCAPS_RIRB_DELAY is dedicated only for Nvidia, so it's better to
be set in hda_intel.c instead of the common hda_controller.c.  This
also allows us to strip this flag from dcaps, so save one more bit
there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 5 -----
 sound/pci/hda/hda_controller.h | 2 +-
 sound/pci/hda/hda_intel.c      | 7 ++++++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 34022a36e5c5..37cf9cee9835 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1054,11 +1054,6 @@ int azx_bus_init(struct azx *chip, const char *model,
 	if (chip->driver_caps & AZX_DCAPS_CORBRP_SELF_CLEAR)
 		bus->core.corbrp_self_clear = true;
 
-	if (chip->driver_caps & AZX_DCAPS_RIRB_DELAY) {
-		dev_dbg(chip->card->dev, "Enable delay in RIRB handling\n");
-		bus->needs_damn_long_delay = 1;
-	}
-
 	if (chip->driver_caps & AZX_DCAPS_4K_BDLE_BOUNDARY)
 		bus->core.align_bdle_4k = true;
 
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index c723bcc7fcef..65401372a7c8 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -32,7 +32,7 @@
 #define AZX_DCAPS_NO_MSI	(1 << 9)	/* No MSI support */
 #define AZX_DCAPS_SNOOP_MASK	(3 << 10)	/* snoop type mask */
 #define AZX_DCAPS_SNOOP_OFF	(1 << 12)	/* snoop default off */
-#define AZX_DCAPS_RIRB_DELAY	(1 << 13)	/* Long delay in read loop */
+/* 13 unused */
 /* 14 unused */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2d2f14830df7..bcb526103ecb 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -338,7 +338,7 @@ enum {
 
 /* quirks for Nvidia */
 #define AZX_DCAPS_PRESET_NVIDIA \
-	(AZX_DCAPS_RIRB_DELAY | AZX_DCAPS_NO_MSI | /*AZX_DCAPS_ALIGN_BUFSIZE |*/ \
+	(AZX_DCAPS_NO_MSI | /*AZX_DCAPS_ALIGN_BUFSIZE |*/ \
 	 AZX_DCAPS_NO_64BIT | AZX_DCAPS_CORBRP_SELF_CLEAR |\
 	 AZX_DCAPS_SNOOP_TYPE(NVIDIA))
 
@@ -1573,6 +1573,11 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 		return err;
 	}
 
+	if (chip->driver_type == AZX_DRIVER_NVIDIA) {
+		dev_dbg(chip->card->dev, "Enable delay in RIRB handling\n");
+		chip->bus.needs_damn_long_delay = 1;
+	}
+
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
 		dev_err(card->dev, "Error creating device [card]!\n");
-- 
2.6.4
