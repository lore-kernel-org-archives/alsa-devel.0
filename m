From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: hda - Drop hda_bus_template for
	snd_hda_bus_new()
Date: Fri, 20 Feb 2015 08:08:22 +0100
Message-ID: <1424416107-32470-2-git-send-email-tiwai@suse.de>
References: <1424416107-32470-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1310D2605D2
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 08:08:30 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5CFB1ACAA
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

Instead of copying from the given template, let the caller fills the
fields after creation.  This simplifies the code after all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 15 +-----------
 sound/pci/hda/hda_codec.h      | 13 +---------
 sound/pci/hda/hda_controller.c | 54 +++++++++++++++++++++++-------------------
 3 files changed, 32 insertions(+), 50 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 2fe86d2e1b09..215bf048c668 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -861,14 +861,12 @@ static int snd_hda_bus_dev_disconnect(struct snd_device *device)
 /**
  * snd_hda_bus_new - create a HDA bus
  * @card: the card entry
- * @temp: the template for hda_bus information
  * @busp: the pointer to store the created bus instance
  *
  * Returns 0 if successful, or a negative error code.
  */
 int snd_hda_bus_new(struct snd_card *card,
-			      const struct hda_bus_template *temp,
-			      struct hda_bus **busp)
+		    struct hda_bus **busp)
 {
 	struct hda_bus *bus;
 	int err;
@@ -877,11 +875,6 @@ int snd_hda_bus_new(struct snd_card *card,
 		.dev_free = snd_hda_bus_dev_free,
 	};
 
-	if (snd_BUG_ON(!temp))
-		return -EINVAL;
-	if (snd_BUG_ON(!temp->ops.command || !temp->ops.get_response))
-		return -EINVAL;
-
 	if (busp)
 		*busp = NULL;
 
@@ -892,12 +885,6 @@ int snd_hda_bus_new(struct snd_card *card,
 	}
 
 	bus->card = card;
-	bus->private_data = temp->private_data;
-	bus->pci = temp->pci;
-	bus->modelname = temp->modelname;
-	bus->power_save = temp->power_save;
-	bus->ops = temp->ops;
-
 	mutex_init(&bus->cmd_mutex);
 	mutex_init(&bus->prepare_mutex);
 	INIT_LIST_HEAD(&bus->codec_list);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 9c8820f21f94..5a6594884069 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -101,15 +101,6 @@ struct hda_bus_ops {
 #endif
 };
 
-/* template to pass to the bus constructor */
-struct hda_bus_template {
-	void *private_data;
-	struct pci_dev *pci;
-	const char *modelname;
-	int *power_save;
-	struct hda_bus_ops ops;
-};
-
 /*
  * codec bus
  *
@@ -119,7 +110,6 @@ struct hda_bus_template {
 struct hda_bus {
 	struct snd_card *card;
 
-	/* copied from template */
 	void *private_data;
 	struct pci_dev *pci;
 	const char *modelname;
@@ -420,8 +410,7 @@ enum {
 /*
  * constructors
  */
-int snd_hda_bus_new(struct snd_card *card, const struct hda_bus_template *temp,
-		    struct hda_bus **busp);
+int snd_hda_bus_new(struct snd_card *card, struct hda_bus **busp);
 int snd_hda_codec_new(struct hda_bus *bus, unsigned int codec_addr,
 		      struct hda_codec **codecp);
 int snd_hda_codec_configure(struct hda_codec *codec);
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index dfcb5e929f9f..31ff8b55f386 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1815,39 +1815,45 @@ static int get_jackpoll_interval(struct azx *chip)
 	return j;
 }
 
+static struct hda_bus_ops bus_ops = {
+	.command = azx_send_cmd,
+	.get_response = azx_get_response,
+	.attach_pcm = azx_attach_pcm_stream,
+	.bus_reset = azx_bus_reset,
+#ifdef CONFIG_PM
+	.pm_notify = azx_power_notify,
+#endif
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+	.load_dsp_prepare = azx_load_dsp_prepare,
+	.load_dsp_trigger = azx_load_dsp_trigger,
+	.load_dsp_cleanup = azx_load_dsp_cleanup,
+#endif
+};
+
 /* Codec initialization */
 int azx_codec_create(struct azx *chip, const char *model,
 		     unsigned int max_slots,
 		     int *power_save_to)
 {
-	struct hda_bus_template bus_temp;
+	struct hda_bus *bus;
 	int c, codecs, err;
 
-	memset(&bus_temp, 0, sizeof(bus_temp));
-	bus_temp.private_data = chip;
-	bus_temp.modelname = model;
-	bus_temp.pci = chip->pci;
-	bus_temp.ops.command = azx_send_cmd;
-	bus_temp.ops.get_response = azx_get_response;
-	bus_temp.ops.attach_pcm = azx_attach_pcm_stream;
-	bus_temp.ops.bus_reset = azx_bus_reset;
-#ifdef CONFIG_PM
-	bus_temp.power_save = power_save_to;
-	bus_temp.ops.pm_notify = azx_power_notify;
-#endif
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-	bus_temp.ops.load_dsp_prepare = azx_load_dsp_prepare;
-	bus_temp.ops.load_dsp_trigger = azx_load_dsp_trigger;
-	bus_temp.ops.load_dsp_cleanup = azx_load_dsp_cleanup;
-#endif
-
-	err = snd_hda_bus_new(chip->card, &bus_temp, &chip->bus);
+	err = snd_hda_bus_new(chip->card, &bus);
 	if (err < 0)
 		return err;
 
+	chip->bus = bus;
+	bus->private_data = chip;
+	bus->pci = chip->pci;
+	bus->modelname = model;
+	bus->ops = bus_ops;
+#ifdef CONFIG_PM
+	bus->power_save = power_save_to;
+#endif
+
 	if (chip->driver_caps & AZX_DCAPS_RIRB_DELAY) {
 		dev_dbg(chip->card->dev, "Enable delay in RIRB handling\n");
-		chip->bus->needs_damn_long_delay = 1;
+		bus->needs_damn_long_delay = 1;
 	}
 
 	codecs = 0;
@@ -1883,15 +1889,15 @@ int azx_codec_create(struct azx *chip, const char *model,
 	 */
 	if (chip->driver_caps & AZX_DCAPS_SYNC_WRITE) {
 		dev_dbg(chip->card->dev, "Enable sync_write for stable communication\n");
-		chip->bus->sync_write = 1;
-		chip->bus->allow_bus_reset = 1;
+		bus->sync_write = 1;
+		bus->allow_bus_reset = 1;
 	}
 
 	/* Then create codec instances */
 	for (c = 0; c < max_slots; c++) {
 		if ((chip->codec_mask & (1 << c)) & chip->codec_probe_mask) {
 			struct hda_codec *codec;
-			err = snd_hda_codec_new(chip->bus, c, &codec);
+			err = snd_hda_codec_new(bus, c, &codec);
 			if (err < 0)
 				continue;
 			codec->jackpoll_interval = get_jackpoll_interval(chip);
-- 
2.3.0
