From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/8] ALSA: fireworks: delayed registration of
	sound card
Date: Thu, 31 Mar 2016 08:47:06 +0900
Message-ID: <1459381629-24189-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F1FF266432
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

When some fireworks units are connected sequentially, userspace
applications are involved at bus-reset state on IEEE 1394 bus. In the
state, any communications can be canceled. Therefore, sound card
registration should be delayed till the bus gets calm.

This commit achieves it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.c | 147 ++++++++++++++++++++++++-----------
 sound/firewire/fireworks/fireworks.h |   3 +
 2 files changed, 103 insertions(+), 47 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 8380fb5..71a0613 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -184,6 +184,18 @@ end:
 	return err;
 }
 
+static void efw_free(struct snd_efw *efw)
+{
+	snd_efw_stream_destroy_duplex(efw);
+	snd_efw_transaction_remove_instance(efw);
+	fw_unit_put(efw->unit);
+
+	kfree(efw->resp_buf);
+
+	mutex_destroy(&efw->mutex);
+	kfree(efw);
+}
+
 /*
  * This module releases the FireWire unit data after all ALSA character devices
  * are released by applications. This is for releasing stream data or finishing
@@ -195,28 +207,24 @@ efw_card_free(struct snd_card *card)
 {
 	struct snd_efw *efw = card->private_data;
 
-	snd_efw_stream_destroy_duplex(efw);
-	snd_efw_transaction_remove_instance(efw);
-	fw_unit_put(efw->unit);
-
-	kfree(efw->resp_buf);
-
 	if (efw->card_index >= 0) {
 		mutex_lock(&devices_mutex);
 		clear_bit(efw->card_index, devices_used);
 		mutex_unlock(&devices_mutex);
 	}
 
-	mutex_destroy(&efw->mutex);
+	efw_free(card->private_data);
 }
 
-static int
-efw_probe(struct fw_unit *unit,
-	  const struct ieee1394_device_id *entry)
+static void
+do_registration(struct work_struct *work)
 {
-	struct snd_card *card;
-	struct snd_efw *efw;
-	int card_index, err;
+	struct snd_efw *efw = container_of(work, struct snd_efw, dwork.work);
+	unsigned int card_index;
+	int err;
+
+	if (efw->registered)
+		return;
 
 	mutex_lock(&devices_mutex);
 
@@ -226,24 +234,16 @@ efw_probe(struct fw_unit *unit,
 			break;
 	}
 	if (card_index >= SNDRV_CARDS) {
-		err = -ENOENT;
-		goto end;
+		mutex_unlock(&devices_mutex);
+		return;
 	}
 
-	err = snd_card_new(&unit->device, index[card_index], id[card_index],
-			   THIS_MODULE, sizeof(struct snd_efw), &card);
-	if (err < 0)
-		goto end;
-	efw = card->private_data;
-	efw->card_index = card_index;
-	set_bit(card_index, devices_used);
-	card->private_free = efw_card_free;
-
-	efw->card = card;
-	efw->unit = fw_unit_get(unit);
-	mutex_init(&efw->mutex);
-	spin_lock_init(&efw->lock);
-	init_waitqueue_head(&efw->hwdep_wait);
+	err = snd_card_new(&efw->unit->device, index[card_index],
+			   id[card_index], THIS_MODULE, 0, &efw->card);
+	if (err < 0) {
+		mutex_unlock(&devices_mutex);
+		return;
+	}
 
 	/* prepare response buffer */
 	snd_efw_resp_buf_size = clamp(snd_efw_resp_buf_size,
@@ -260,6 +260,10 @@ efw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_efw_stream_init_duplex(efw);
+	if (err < 0)
+		goto error;
+
 	snd_efw_proc_init(efw);
 
 	if (efw->midi_out_ports || efw->midi_in_ports) {
@@ -276,44 +280,93 @@ efw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_efw_stream_init_duplex(efw);
+	err = snd_card_register(efw->card);
 	if (err < 0)
 		goto error;
 
-	err = snd_card_register(card);
-	if (err < 0) {
-		snd_efw_stream_destroy_duplex(efw);
-		goto error;
-	}
-
-	dev_set_drvdata(&unit->device, efw);
-end:
+	set_bit(card_index, devices_used);
 	mutex_unlock(&devices_mutex);
-	return err;
+
+	/*
+	 * After registered, efw instance can be released corresponding to
+	 * releasing the sound card instance.
+	 */
+	efw->card->private_free = efw_card_free;
+	efw->card->private_data = efw;
+	efw->registered = true;
+
+	return;
 error:
-	snd_efw_transaction_remove_instance(efw);
 	mutex_unlock(&devices_mutex);
-	snd_card_free(card);
-	return err;
+	snd_efw_transaction_remove_instance(efw);
+	snd_efw_stream_destroy_duplex(efw);
+	snd_card_free(efw->card);
+	dev_info(&efw->unit->device,
+		 "Sound card registration failed: %d\n", err);
+}
+
+static int
+efw_probe(struct fw_unit *unit, const struct ieee1394_device_id *entry)
+{
+	struct snd_efw *efw;
+
+	efw = kzalloc(sizeof(struct snd_efw), GFP_KERNEL);
+	if (efw == NULL)
+		return -ENOMEM;
+
+	efw->unit = fw_unit_get(unit);
+	dev_set_drvdata(&unit->device, efw);
+
+	mutex_init(&efw->mutex);
+	spin_lock_init(&efw->lock);
+	init_waitqueue_head(&efw->hwdep_wait);
+
+	/* Allocate and register this sound card later. */
+	INIT_DEFERRABLE_WORK(&efw->dwork, do_registration);
+	snd_fw_schedule_registration(unit, &efw->dwork);
+
+	return 0;
 }
 
 static void efw_update(struct fw_unit *unit)
 {
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
 
+	/* Postpone a workqueue for deferred registration. */
+	if (!efw->registered)
+		snd_fw_schedule_registration(unit, &efw->dwork);
+
 	snd_efw_transaction_bus_reset(efw->unit);
 
-	mutex_lock(&efw->mutex);
-	snd_efw_stream_update_duplex(efw);
-	mutex_unlock(&efw->mutex);
+	/*
+	 * After registration, userspace can start packet streaming, then this
+	 * code block works fine.
+	 */
+	if (efw->registered) {
+		mutex_lock(&efw->mutex);
+		snd_efw_stream_update_duplex(efw);
+		mutex_unlock(&efw->mutex);
+	}
 }
 
 static void efw_remove(struct fw_unit *unit)
 {
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
 
-	/* No need to wait for releasing card object in this context. */
-	snd_card_free_when_closed(efw->card);
+	/*
+	 * Confirm to stop the work for registration before the sound card is
+	 * going to be released. The work is not scheduled again because bus
+	 * reset handler is not called anymore.
+	 */
+	cancel_delayed_work_sync(&efw->dwork);
+
+	if (efw->registered) {
+		/* No need to wait for releasing card object in this context. */
+		snd_card_free_when_closed(efw->card);
+	} else {
+		/* Don't forget this case. */
+		efw_free(efw);
+	}
 }
 
 static const struct ieee1394_device_id efw_id_table[] = {
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 96c4e0c..471c772 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -65,6 +65,9 @@ struct snd_efw {
 	struct mutex mutex;
 	spinlock_t lock;
 
+	bool registered;
+	struct delayed_work dwork;
+
 	/* for transaction */
 	u32 seqnum;
 	bool resp_addr_changable;
-- 
2.7.4
