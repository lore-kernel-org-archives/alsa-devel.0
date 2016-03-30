From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/8] ALSA: oxfw: delayed registration of sound
	card
Date: Thu, 31 Mar 2016 08:47:07 +0900
Message-ID: <1459381629-24189-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 121492664B6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 01:47:16 +0200 (CEST)
In-Reply-To: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some oxfw based units tends to fail asynchronous communication when
IEEE 1394 bus is under bus-reset state. When registering sound card
instance at unit probe callback, userspace applications can be involved
to the state.

This commit postpones the registration till the bus is calm.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 151 +++++++++++++++++++++++++++++----------------
 sound/firewire/oxfw/oxfw.h |   3 +
 2 files changed, 101 insertions(+), 53 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index abedc22..e629b88 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -118,15 +118,8 @@ end:
 	return err;
 }
 
-/*
- * This module releases the FireWire unit data after all ALSA character devices
- * are released by applications. This is for releasing stream data or finishing
- * transactions safely. Thus at returning from .remove(), this module still keep
- * references for the unit.
- */
-static void oxfw_card_free(struct snd_card *card)
+static void oxfw_free(struct snd_oxfw *oxfw)
 {
-	struct snd_oxfw *oxfw = card->private_data;
 	unsigned int i;
 
 	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
@@ -144,6 +137,17 @@ static void oxfw_card_free(struct snd_card *card)
 	mutex_destroy(&oxfw->mutex);
 }
 
+/*
+ * This module releases the FireWire unit data after all ALSA character devices
+ * are released by applications. This is for releasing stream data or finishing
+ * transactions safely. Thus at returning from .remove(), this module still keep
+ * references for the unit.
+ */
+static void oxfw_card_free(struct snd_card *card)
+{
+	oxfw_free(card->private_data);
+}
+
 static int detect_quirks(struct snd_oxfw *oxfw)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
@@ -205,41 +209,39 @@ static int detect_quirks(struct snd_oxfw *oxfw)
 	return 0;
 }
 
-static int oxfw_probe(struct fw_unit *unit,
-		      const struct ieee1394_device_id *entry)
+static void do_registration(struct work_struct *work)
 {
-	struct snd_card *card;
-	struct snd_oxfw *oxfw;
+	struct snd_oxfw *oxfw = container_of(work, struct snd_oxfw, dwork.work);
 	int err;
 
-	if (entry->vendor_id == VENDOR_LOUD && !detect_loud_models(unit))
-		return -ENODEV;
+	if (oxfw->registered)
+		return;
 
-	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
-			   sizeof(*oxfw), &card);
+	err = snd_card_new(&oxfw->unit->device, -1, NULL, THIS_MODULE, 0,
+			   &oxfw->card);
 	if (err < 0)
-		return err;
+		return;
 
-	card->private_free = oxfw_card_free;
-	oxfw = card->private_data;
-	oxfw->card = card;
-	mutex_init(&oxfw->mutex);
-	oxfw->unit = fw_unit_get(unit);
-	oxfw->entry = entry;
-	spin_lock_init(&oxfw->lock);
-	init_waitqueue_head(&oxfw->hwdep_wait);
+	err = name_card(oxfw);
+	if (err < 0)
+		goto error;
 
-	err = snd_oxfw_stream_discover(oxfw);
+	err = detect_quirks(oxfw);
 	if (err < 0)
 		goto error;
 
-	err = name_card(oxfw);
+	err = snd_oxfw_stream_discover(oxfw);
 	if (err < 0)
 		goto error;
 
-	err = detect_quirks(oxfw);
+	err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->rx_stream);
 	if (err < 0)
 		goto error;
+	if (oxfw->has_output) {
+		err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->tx_stream);
+		if (err < 0)
+			goto error;
+	}
 
 	err = snd_oxfw_create_pcm(oxfw);
 	if (err < 0)
@@ -255,54 +257,97 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->rx_stream);
+	err = snd_card_register(oxfw->card);
 	if (err < 0)
 		goto error;
-	if (oxfw->has_output) {
-		err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->tx_stream);
-		if (err < 0)
-			goto error;
-	}
 
-	err = snd_card_register(card);
-	if (err < 0) {
-		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
-		if (oxfw->has_output)
-			snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
-		goto error;
-	}
+	/*
+	 * After registered, oxfw instance can be released corresponding to
+	 * releasing the sound card instance.
+	 */
+	oxfw->card->private_free = oxfw_card_free;
+	oxfw->card->private_data = oxfw;
+	oxfw->registered = true;
+
+	return;
+error:
+	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
+	if (oxfw->has_output)
+		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
+	snd_card_free(oxfw->card);
+	dev_info(&oxfw->unit->device,
+		 "Sound card registration failed: %d\n", err);
+}
+
+static int oxfw_probe(struct fw_unit *unit,
+		      const struct ieee1394_device_id *entry)
+{
+	struct snd_oxfw *oxfw;
+
+	if (entry->vendor_id == VENDOR_LOUD && !detect_loud_models(unit))
+		return -ENODEV;
+
+	/* Allocate this independent of sound card instance. */
+	oxfw = kzalloc(sizeof(struct snd_oxfw), GFP_KERNEL);
+	if (oxfw == NULL)
+		return -ENOMEM;
+
+	oxfw->entry = entry;
+	oxfw->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, oxfw);
 
+	mutex_init(&oxfw->mutex);
+	spin_lock_init(&oxfw->lock);
+	init_waitqueue_head(&oxfw->hwdep_wait);
+
+	/* Allocate and register this sound card later. */
+	INIT_DEFERRABLE_WORK(&oxfw->dwork, do_registration);
+	snd_fw_schedule_registration(unit, &oxfw->dwork);
+
 	return 0;
-error:
-	snd_card_free(card);
-	return err;
 }
 
 static void oxfw_bus_reset(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
+	if (!oxfw->registered)
+		snd_fw_schedule_registration(unit, &oxfw->dwork);
+
 	fcp_bus_reset(oxfw->unit);
 
-	mutex_lock(&oxfw->mutex);
+	if (oxfw->registered) {
+		mutex_lock(&oxfw->mutex);
 
-	snd_oxfw_stream_update_simplex(oxfw, &oxfw->rx_stream);
-	if (oxfw->has_output)
-		snd_oxfw_stream_update_simplex(oxfw, &oxfw->tx_stream);
+		snd_oxfw_stream_update_simplex(oxfw, &oxfw->rx_stream);
+		if (oxfw->has_output)
+			snd_oxfw_stream_update_simplex(oxfw, &oxfw->tx_stream);
 
-	mutex_unlock(&oxfw->mutex);
+		mutex_unlock(&oxfw->mutex);
 
-	if (oxfw->entry->vendor_id == OUI_STANTON)
-		snd_oxfw_scs1x_update(oxfw);
+		if (oxfw->entry->vendor_id == OUI_STANTON)
+			snd_oxfw_scs1x_update(oxfw);
+	}
 }
 
 static void oxfw_remove(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	/* No need to wait for releasing card object in this context. */
-	snd_card_free_when_closed(oxfw->card);
+	/*
+	 * Confirm to stop the work for registration before the sound card is
+	 * going to be released. The work is not scheduled again because bus
+	 * reset handler is not called anymore.
+	 */
+	cancel_delayed_work_sync(&oxfw->dwork);
+
+	if (oxfw->registered) {
+		/* No need to wait for releasing card object in this context. */
+		snd_card_free_when_closed(oxfw->card);
+	} else {
+		/* Don't forget this case. */
+		oxfw_free(oxfw);
+	}
 }
 
 static const struct compat_info griffin_firewave = {
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 2c84714e..2047dcb 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -39,6 +39,9 @@ struct snd_oxfw {
 	struct mutex mutex;
 	spinlock_t lock;
 
+	bool registered;
+	struct delayed_work dwork;
+
 	bool wrong_dbs;
 	bool has_output;
 	u8 *tx_stream_formats[SND_OXFW_STREAM_FORMAT_ENTRIES];
-- 
2.7.4
