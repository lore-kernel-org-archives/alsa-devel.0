From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Clean up the code to check
	bdl_pos_adj option
Date: Tue, 15 Dec 2015 14:02:55 +0100
Message-ID: <1450184576-11227-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 73340261B01
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 14:02:55 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0EA07ADAA
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 13:02:55 +0000 (UTC)
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

Just a minor cleanup; instead of passing an array, pass the assigned
bdl_pos_adj option value directory in struct azx.  Also split the code
to get the default bdl_pos_adj value for the change that will follow
after this.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c |  3 +--
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 29 ++++++++++++++++-------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 22dbfa563919..10c77074b4dc 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1050,8 +1050,7 @@ int azx_bus_init(struct azx *chip, const char *model,
 	if (chip->get_position[0] != azx_get_pos_lpib ||
 	    chip->get_position[1] != azx_get_pos_lpib)
 		bus->core.use_posbuf = true;
-	if (chip->bdl_pos_adj)
-		bus->core.bdl_pos_adj = chip->bdl_pos_adj[chip->dev_index];
+	bus->core.bdl_pos_adj = chip->bdl_pos_adj;
 	if (chip->driver_caps & AZX_DCAPS_CORBRP_SELF_CLEAR)
 		bus->core.corbrp_self_clear = true;
 
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index c1d28a657f19..a32ec9004edd 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -147,7 +147,7 @@ struct azx {
 #endif
 
 	/* flags */
-	const int *bdl_pos_adj;
+	int bdl_pos_adj;
 	int poll_count;
 	unsigned int running:1;
 	unsigned int single_cmd:1;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fe9bef339cea..a17bf0467edc 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -632,7 +632,7 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 	if (wallclk < (azx_dev->core.period_wallclk * 5) / 4 &&
 	    pos % azx_dev->core.period_bytes > azx_dev->core.period_bytes / 2)
 		/* NG - it's below the first next period boundary */
-		return chip->bdl_pos_adj[chip->dev_index] ? 0 : -1;
+		return chip->bdl_pos_adj ? 0 : -1;
 	azx_dev->core.start_wallclk += wallclk;
 	return 1; /* OK, it's fine */
 }
@@ -1488,6 +1488,17 @@ static void azx_probe_work(struct work_struct *work)
 	azx_probe_continue(&hda->chip);
 }
 
+static int default_bdl_pos_adj(struct azx *chip)
+{
+	switch (chip->driver_type) {
+	case AZX_DRIVER_ICH:
+	case AZX_DRIVER_PCH:
+		return 1;
+	default:
+		return 32;
+	}
+}
+
 /*
  * constructor
  */
@@ -1541,18 +1552,10 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	chip->single_cmd = single_cmd;
 	azx_check_snoop_available(chip);
 
-	if (bdl_pos_adj[dev] < 0) {
-		switch (chip->driver_type) {
-		case AZX_DRIVER_ICH:
-		case AZX_DRIVER_PCH:
-			bdl_pos_adj[dev] = 1;
-			break;
-		default:
-			bdl_pos_adj[dev] = 32;
-			break;
-		}
-	}
-	chip->bdl_pos_adj = bdl_pos_adj;
+	if (bdl_pos_adj[dev] < 0)
+		chip->bdl_pos_adj = default_bdl_pos_adj(chip);
+	else
+		chip->bdl_pos_adj = bdl_pos_adj[dev];
 
 	err = azx_bus_init(chip, model[dev], &pci_hda_io_ops);
 	if (err < 0) {
-- 
2.6.4
