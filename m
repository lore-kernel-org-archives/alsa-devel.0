From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/8] ALSA: firewire-digi00x: delayed
	registration of sound card
Date: Thu, 31 Mar 2016 08:47:08 +0900
Message-ID: <1459381629-24189-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 178C82664EB
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

When some digi00x units are connected sequentially, userspace
applications are involved at bus-reset state on IEEE 1394 bus. In the
state, any communications can be canceled. Therefore, sound card
registration should be delayed till the bus gets calm.

This commit achieves it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-transaction.c |   7 +-
 sound/firewire/digi00x/digi00x.c             | 107 +++++++++++++++++++--------
 sound/firewire/digi00x/digi00x.h             |   3 +
 3 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-transaction.c b/sound/firewire/digi00x/digi00x-transaction.c
index 554324d..735d356 100644
--- a/sound/firewire/digi00x/digi00x-transaction.c
+++ b/sound/firewire/digi00x/digi00x-transaction.c
@@ -126,12 +126,17 @@ int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
 	return err;
 error:
 	fw_core_remove_address_handler(&dg00x->async_handler);
-	dg00x->async_handler.address_callback = NULL;
+	dg00x->async_handler.callback_data = NULL;
 	return err;
 }
 
 void snd_dg00x_transaction_unregister(struct snd_dg00x *dg00x)
 {
+	if (dg00x->async_handler.callback_data == NULL)
+		return;
+
 	snd_fw_async_midi_port_destroy(&dg00x->out_control);
 	fw_core_remove_address_handler(&dg00x->async_handler);
+
+	dg00x->async_handler.callback_data = NULL;
 }
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 1f33b7a..cc4776c 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -40,10 +40,8 @@ static int name_card(struct snd_dg00x *dg00x)
 	return 0;
 }
 
-static void dg00x_card_free(struct snd_card *card)
+static void dg00x_free(struct snd_dg00x *dg00x)
 {
-	struct snd_dg00x *dg00x = card->private_data;
-
 	snd_dg00x_stream_destroy_duplex(dg00x);
 	snd_dg00x_transaction_unregister(dg00x);
 
@@ -52,28 +50,24 @@ static void dg00x_card_free(struct snd_card *card)
 	mutex_destroy(&dg00x->mutex);
 }
 
-static int snd_dg00x_probe(struct fw_unit *unit,
-			   const struct ieee1394_device_id *entry)
+static void dg00x_card_free(struct snd_card *card)
 {
-	struct snd_card *card;
-	struct snd_dg00x *dg00x;
-	int err;
+	dg00x_free(card->private_data);
+}
 
-	/* create card */
-	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
-			   sizeof(struct snd_dg00x), &card);
-	if (err < 0)
-		return err;
-	card->private_free = dg00x_card_free;
+static void do_registration(struct work_struct *work)
+{
+	struct snd_dg00x *dg00x =
+			container_of(work, struct snd_dg00x, dwork.work);
+	int err;
 
-	/* initialize myself */
-	dg00x = card->private_data;
-	dg00x->card = card;
-	dg00x->unit = fw_unit_get(unit);
+	if (dg00x->registered)
+		return;
 
-	mutex_init(&dg00x->mutex);
-	spin_lock_init(&dg00x->lock);
-	init_waitqueue_head(&dg00x->hwdep_wait);
+	err = snd_card_new(&dg00x->unit->device, -1, NULL, THIS_MODULE, 0,
+			   &dg00x->card);
+	if (err < 0)
+		return;
 
 	err = name_card(dg00x);
 	if (err < 0)
@@ -101,35 +95,86 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_card_register(card);
+	err = snd_card_register(dg00x->card);
 	if (err < 0)
 		goto error;
 
-	dev_set_drvdata(&unit->device, dg00x);
+	dg00x->card->private_free = dg00x_card_free;
+	dg00x->card->private_data = dg00x;
+	dg00x->registered = true;
 
-	return err;
+	return;
 error:
-	snd_card_free(card);
-	return err;
+	snd_dg00x_transaction_unregister(dg00x);
+	snd_dg00x_stream_destroy_duplex(dg00x);
+	snd_card_free(dg00x->card);
+	dev_info(&dg00x->unit->device,
+		 "Sound card registration failed: %d\n", err);
+}
+
+static int snd_dg00x_probe(struct fw_unit *unit,
+			   const struct ieee1394_device_id *entry)
+{
+	struct snd_dg00x *dg00x;
+
+	/* Allocate this independent of sound card instance. */
+	dg00x = kzalloc(sizeof(struct snd_dg00x), GFP_KERNEL);
+	if (dg00x == NULL)
+		return -ENOMEM;
+
+	dg00x->unit = fw_unit_get(unit);
+	dev_set_drvdata(&unit->device, dg00x);
+
+	mutex_init(&dg00x->mutex);
+	spin_lock_init(&dg00x->lock);
+	init_waitqueue_head(&dg00x->hwdep_wait);
+
+	/* Allocate and register this sound card later. */
+	INIT_DEFERRABLE_WORK(&dg00x->dwork, do_registration);
+	snd_fw_schedule_registration(unit, &dg00x->dwork);
+
+	return 0;
 }
 
 static void snd_dg00x_update(struct fw_unit *unit)
 {
 	struct snd_dg00x *dg00x = dev_get_drvdata(&unit->device);
 
+	/* Postpone a workqueue for deferred registration. */
+	if (!dg00x->registered)
+		snd_fw_schedule_registration(unit, &dg00x->dwork);
+
 	snd_dg00x_transaction_reregister(dg00x);
 
-	mutex_lock(&dg00x->mutex);
-	snd_dg00x_stream_update_duplex(dg00x);
-	mutex_unlock(&dg00x->mutex);
+	/*
+	 * After registration, userspace can start packet streaming, then this
+	 * code block works fine.
+	 */
+	if (dg00x->registered) {
+		mutex_lock(&dg00x->mutex);
+		snd_dg00x_stream_update_duplex(dg00x);
+		mutex_unlock(&dg00x->mutex);
+	}
 }
 
 static void snd_dg00x_remove(struct fw_unit *unit)
 {
 	struct snd_dg00x *dg00x = dev_get_drvdata(&unit->device);
 
-	/* No need to wait for releasing card object in this context. */
-	snd_card_free_when_closed(dg00x->card);
+	/*
+	 * Confirm to stop the work for registration before the sound card is
+	 * going to be released. The work is not scheduled again because bus
+	 * reset handler is not called anymore.
+	 */
+	cancel_delayed_work_sync(&dg00x->dwork);
+
+	if (dg00x->registered) {
+		/* No need to wait for releasing card object in this context. */
+		snd_card_free_when_closed(dg00x->card);
+	} else {
+		/* Don't forget this case. */
+		dg00x_free(dg00x);
+	}
 }
 
 static const struct ieee1394_device_id snd_dg00x_id_table[] = {
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 907e739..2cd465c 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -37,6 +37,9 @@ struct snd_dg00x {
 	struct mutex mutex;
 	spinlock_t lock;
 
+	bool registered;
+	struct delayed_work dwork;
+
 	struct amdtp_stream tx_stream;
 	struct fw_iso_resources tx_resources;
 
-- 
2.7.4
