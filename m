From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: hda - Split azx_codec_create() to
	two phases
Date: Fri, 20 Feb 2015 08:08:27 +0100
Message-ID: <1424416107-32470-7-git-send-email-tiwai@suse.de>
References: <1424416107-32470-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A885260600
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 08:08:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6BC1BACEB
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 07:08:30 +0000 (UTC)
In-Reply-To: <1424416107-32470-1-git-send-email-tiwai@suse.de>
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

azx_create_codec() function does actually two things: create a bus and
probe codecs.  For the future work, split this to two logical
functions, azx_bus_create() and azx_probe_codecs().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 40 ++++++++++++++++++++++++----------------
 sound/pci/hda/hda_controller.h |  5 ++---
 sound/pci/hda/hda_intel.c      |  8 +++++---
 sound/pci/hda/hda_tegra.c      |  6 +++++-
 4 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 6fab39133051..2a674525e56f 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1829,13 +1829,11 @@ static struct hda_bus_ops bus_ops = {
 #endif
 };
 
-/* Codec initialization */
-int azx_codec_create(struct azx *chip, const char *model,
-		     unsigned int max_slots,
-		     int *power_save_to)
+/* HD-audio bus initialization */
+int azx_bus_create(struct azx *chip, const char *model, int *power_save_to)
 {
 	struct hda_bus *bus;
-	int c, codecs, err;
+	int err;
 
 	err = snd_hda_bus_new(chip->card, &bus);
 	if (err < 0)
@@ -1855,6 +1853,26 @@ int azx_codec_create(struct azx *chip, const char *model,
 		bus->needs_damn_long_delay = 1;
 	}
 
+	/* AMD chipsets often cause the communication stalls upon certain
+	 * sequence like the pin-detection.  It seems that forcing the synced
+	 * access works around the stall.  Grrr...
+	 */
+	if (chip->driver_caps & AZX_DCAPS_SYNC_WRITE) {
+		dev_dbg(chip->card->dev, "Enable sync_write for stable communication\n");
+		bus->sync_write = 1;
+		bus->allow_bus_reset = 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(azx_bus_create);
+
+/* Probe codecs */
+int azx_probe_codecs(struct azx *chip, unsigned int max_slots)
+{
+	struct hda_bus *bus = chip->bus;
+	int c, codecs, err;
+
 	codecs = 0;
 	if (!max_slots)
 		max_slots = AZX_DEFAULT_CODECS;
@@ -1882,16 +1900,6 @@ int azx_codec_create(struct azx *chip, const char *model,
 		}
 	}
 
-	/* AMD chipsets often cause the communication stalls upon certain
-	 * sequence like the pin-detection.  It seems that forcing the synced
-	 * access works around the stall.  Grrr...
-	 */
-	if (chip->driver_caps & AZX_DCAPS_SYNC_WRITE) {
-		dev_dbg(chip->card->dev, "Enable sync_write for stable communication\n");
-		bus->sync_write = 1;
-		bus->allow_bus_reset = 1;
-	}
-
 	/* Then create codec instances */
 	for (c = 0; c < max_slots; c++) {
 		if ((chip->codec_mask & (1 << c)) & chip->codec_probe_mask) {
@@ -1910,7 +1918,7 @@ int azx_codec_create(struct azx *chip, const char *model,
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(azx_codec_create);
+EXPORT_SYMBOL_GPL(azx_probe_codecs);
 
 /* configure each codec instance */
 int azx_codec_configure(struct azx *chip)
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 79808e1a79ac..0d09aa6b49ac 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -432,9 +432,8 @@ void azx_enter_link_reset(struct azx *chip);
 irqreturn_t azx_interrupt(int irq, void *dev_id);
 
 /* Codec interface */
-int azx_codec_create(struct azx *chip, const char *model,
-		     unsigned int max_slots,
-		     int *power_save_to);
+int azx_bus_create(struct azx *chip, const char *model, int *power_save_to);
+int azx_probe_codecs(struct azx *chip, unsigned int max_slots);
 int azx_codec_configure(struct azx *chip);
 int azx_init_stream(struct azx *chip);
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b0a05691abe7..5e00cc4a722f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1893,12 +1893,14 @@ static int azx_probe_continue(struct azx *chip)
 #endif
 
 	/* create codec instances */
-	err = azx_codec_create(chip, model[dev],
-			       azx_max_codecs[chip->driver_type],
-			       power_save_addr);
+	err = azx_bus_create(chip, model[dev], power_save_addr);
+	if (err < 0)
+		goto out_free;
 
+	err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
 	if (err < 0)
 		goto out_free;
+
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 	if (chip->fw) {
 		err = snd_hda_load_patch(chip->bus, chip->fw->size,
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index f305c2a99206..1bd7a9e04046 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -502,7 +502,11 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		goto out_free;
 
 	/* create codec instances */
-	err = azx_codec_create(chip, NULL, 0, &power_save);
+	err = azx_bus_create(chip, NULL, &power_save);
+	if (err < 0)
+		goto out_free;
+
+	err = azx_probe_codecs(chip, 0);
 	if (err < 0)
 		goto out_free;
 
-- 
2.3.0
