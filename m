From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/8] ALSA: bebob: delayed registration of sound
	card
Date: Thu, 31 Mar 2016 08:47:05 +0900
Message-ID: <1459381629-24189-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B8A264FFF
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 01:47:14 +0200 (CEST)
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

Some bebob based units tends to fail asynchronous communication when
IEEE 1394 bus is under bus-reset state. When registering sound card
instance at unit probe callback, userspace applications can be involved
to the state.

This commit postpones the registration till the bus is calm.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c | 215 +++++++++++++++++++++++++------------------
 sound/firewire/bebob/bebob.h |   5 +-
 2 files changed, 131 insertions(+), 89 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 932901d..f7e2cbd 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -126,6 +126,17 @@ end:
 	return err;
 }
 
+static void bebob_free(struct snd_bebob *bebob)
+{
+	snd_bebob_stream_destroy_duplex(bebob);
+	fw_unit_put(bebob->unit);
+
+	kfree(bebob->maudio_special_quirk);
+
+	mutex_destroy(&bebob->mutex);
+	kfree(bebob);
+}
+
 /*
  * This module releases the FireWire unit data after all ALSA character devices
  * are released by applications. This is for releasing stream data or finishing
@@ -137,18 +148,11 @@ bebob_card_free(struct snd_card *card)
 {
 	struct snd_bebob *bebob = card->private_data;
 
-	snd_bebob_stream_destroy_duplex(bebob);
-	fw_unit_put(bebob->unit);
-
-	kfree(bebob->maudio_special_quirk);
-
-	if (bebob->card_index >= 0) {
-		mutex_lock(&devices_mutex);
-		clear_bit(bebob->card_index, devices_used);
-		mutex_unlock(&devices_mutex);
-	}
+	mutex_lock(&devices_mutex);
+	clear_bit(bebob->card_index, devices_used);
+	mutex_unlock(&devices_mutex);
 
-	mutex_destroy(&bebob->mutex);
+	bebob_free(card->private_data);
 }
 
 static const struct snd_bebob_spec *
@@ -176,16 +180,17 @@ check_audiophile_booted(struct fw_unit *unit)
 	return strncmp(name, "FW Audiophile Bootloader", 15) != 0;
 }
 
-static int
-bebob_probe(struct fw_unit *unit,
-	    const struct ieee1394_device_id *entry)
+static void
+do_registration(struct work_struct *work)
 {
-	struct snd_card *card;
-	struct snd_bebob *bebob;
-	const struct snd_bebob_spec *spec;
+	struct snd_bebob *bebob =
+			container_of(work, struct snd_bebob, dwork.work);
 	unsigned int card_index;
 	int err;
 
+	if (bebob->registered)
+		return;
+
 	mutex_lock(&devices_mutex);
 
 	for (card_index = 0; card_index < SNDRV_CARDS; card_index++) {
@@ -193,64 +198,39 @@ bebob_probe(struct fw_unit *unit,
 			break;
 	}
 	if (card_index >= SNDRV_CARDS) {
-		err = -ENOENT;
-		goto end;
+		mutex_unlock(&devices_mutex);
+		return;
 	}
 
-	if ((entry->vendor_id == VEN_FOCUSRITE) &&
-	    (entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH))
-		spec = get_saffire_spec(unit);
-	else if ((entry->vendor_id == VEN_MAUDIO1) &&
-		 (entry->model_id == MODEL_MAUDIO_AUDIOPHILE_BOTH) &&
-		 !check_audiophile_booted(unit))
-		spec = NULL;
-	else
-		spec = (const struct snd_bebob_spec *)entry->driver_data;
-
-	if (spec == NULL) {
-		if ((entry->vendor_id == VEN_MAUDIO1) ||
-		    (entry->vendor_id == VEN_MAUDIO2))
-			err = snd_bebob_maudio_load_firmware(unit);
-		else
-			err = -ENOSYS;
-		goto end;
+	err = snd_card_new(&bebob->unit->device, index[card_index],
+			   id[card_index], THIS_MODULE, 0, &bebob->card);
+	if (err < 0) {
+		mutex_unlock(&devices_mutex);
+		return;
 	}
 
-	err = snd_card_new(&unit->device, index[card_index], id[card_index],
-			   THIS_MODULE, sizeof(struct snd_bebob), &card);
-	if (err < 0)
-		goto end;
-	bebob = card->private_data;
-	bebob->card_index = card_index;
-	set_bit(card_index, devices_used);
-	card->private_free = bebob_card_free;
-
-	bebob->card = card;
-	bebob->unit = fw_unit_get(unit);
-	bebob->spec = spec;
-	mutex_init(&bebob->mutex);
-	spin_lock_init(&bebob->lock);
-	init_waitqueue_head(&bebob->hwdep_wait);
-
 	err = name_device(bebob);
 	if (err < 0)
 		goto error;
 
-	if ((entry->vendor_id == VEN_MAUDIO1) &&
-	    (entry->model_id == MODEL_MAUDIO_FW1814))
-		err = snd_bebob_maudio_special_discover(bebob, true);
-	else if ((entry->vendor_id == VEN_MAUDIO1) &&
-		 (entry->model_id == MODEL_MAUDIO_PROJECTMIX))
-		err = snd_bebob_maudio_special_discover(bebob, false);
-	else
+	if (bebob->spec == &maudio_special_spec) {
+		if (bebob->entry->model_id == MODEL_MAUDIO_FW1814)
+			err = snd_bebob_maudio_special_discover(bebob, true);
+		else
+			err = snd_bebob_maudio_special_discover(bebob, false);
+	} else {
 		err = snd_bebob_stream_discover(bebob);
+	}
+	if (err < 0)
+		goto error;
+
+	err = snd_bebob_stream_init_duplex(bebob);
 	if (err < 0)
 		goto error;
 
 	snd_bebob_proc_init(bebob);
 
-	if ((bebob->midi_input_ports > 0) ||
-	    (bebob->midi_output_ports > 0)) {
+	if (bebob->midi_input_ports > 0 || bebob->midi_output_ports > 0) {
 		err = snd_bebob_create_midi_devices(bebob);
 		if (err < 0)
 			goto error;
@@ -264,16 +244,75 @@ bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_bebob_stream_init_duplex(bebob);
+	err = snd_card_register(bebob->card);
 	if (err < 0)
 		goto error;
 
-	if (!bebob->maudio_special_quirk) {
-		err = snd_card_register(card);
-		if (err < 0) {
-			snd_bebob_stream_destroy_duplex(bebob);
-			goto error;
-		}
+	set_bit(card_index, devices_used);
+	mutex_unlock(&devices_mutex);
+
+	/*
+	 * After registered, bebob instance can be released corresponding to
+	 * releasing the sound card instance.
+	 */
+	bebob->card->private_free = bebob_card_free;
+	bebob->card->private_data = bebob;
+	bebob->registered = true;
+
+	return;
+error:
+	mutex_unlock(&devices_mutex);
+	snd_bebob_stream_destroy_duplex(bebob);
+	snd_card_free(bebob->card);
+	dev_info(&bebob->unit->device,
+		 "Sound card registration failed: %d\n", err);
+}
+
+static int
+bebob_probe(struct fw_unit *unit, const struct ieee1394_device_id *entry)
+{
+	struct snd_bebob *bebob;
+	const struct snd_bebob_spec *spec;
+
+	if (entry->vendor_id == VEN_FOCUSRITE &&
+	    entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH)
+		spec = get_saffire_spec(unit);
+	else if (entry->vendor_id == VEN_MAUDIO1 &&
+		 entry->model_id == MODEL_MAUDIO_AUDIOPHILE_BOTH &&
+		 !check_audiophile_booted(unit))
+		spec = NULL;
+	else
+		spec = (const struct snd_bebob_spec *)entry->driver_data;
+
+	if (spec == NULL) {
+		if (entry->vendor_id == VEN_MAUDIO1 ||
+		    entry->vendor_id == VEN_MAUDIO2)
+			return snd_bebob_maudio_load_firmware(unit);
+		else
+			return -ENODEV;
+	}
+
+	/* Allocate this independent of sound card instance. */
+	bebob = kzalloc(sizeof(struct snd_bebob), GFP_KERNEL);
+	if (bebob == NULL)
+		return -ENOMEM;
+
+	bebob->unit = fw_unit_get(unit);
+	bebob->entry = entry;
+	bebob->spec = spec;
+	dev_set_drvdata(&unit->device, bebob);
+
+	mutex_init(&bebob->mutex);
+	spin_lock_init(&bebob->lock);
+	init_waitqueue_head(&bebob->hwdep_wait);
+
+	/* Allocate and register this sound card later. */
+	INIT_DEFERRABLE_WORK(&bebob->dwork, do_registration);
+
+	if (entry->vendor_id != VEN_MAUDIO1 ||
+	    (entry->model_id != MODEL_MAUDIO_FW1814 &&
+	     entry->model_id != MODEL_MAUDIO_PROJECTMIX)) {
+		snd_fw_schedule_registration(unit, &bebob->dwork);
 	} else {
 		/*
 		 * This is a workaround. This bus reset seems to have an effect
@@ -285,19 +324,11 @@ bebob_probe(struct fw_unit *unit,
 		 * signals from dbus and starts I/Os. To avoid I/Os till the
 		 * future bus reset, registration is done in next update().
 		 */
-		bebob->deferred_registration = true;
 		fw_schedule_bus_reset(fw_parent_device(bebob->unit)->card,
 				      false, true);
 	}
 
-	dev_set_drvdata(&unit->device, bebob);
-end:
-	mutex_unlock(&devices_mutex);
-	return err;
-error:
-	mutex_unlock(&devices_mutex);
-	snd_card_free(card);
-	return err;
+	return 0;
 }
 
 /*
@@ -324,15 +355,11 @@ bebob_update(struct fw_unit *unit)
 	if (bebob == NULL)
 		return;
 
-	fcp_bus_reset(bebob->unit);
-
-	if (bebob->deferred_registration) {
-		if (snd_card_register(bebob->card) < 0) {
-			snd_bebob_stream_destroy_duplex(bebob);
-			snd_card_free(bebob->card);
-		}
-		bebob->deferred_registration = false;
-	}
+	/* Postpone a workqueue for deferred registration. */
+	if (!bebob->registered)
+		snd_fw_schedule_registration(unit, &bebob->dwork);
+	else
+		fcp_bus_reset(bebob->unit);
 }
 
 static void bebob_remove(struct fw_unit *unit)
@@ -342,8 +369,20 @@ static void bebob_remove(struct fw_unit *unit)
 	if (bebob == NULL)
 		return;
 
-	/* No need to wait for releasing card object in this context. */
-	snd_card_free_when_closed(bebob->card);
+	/*
+	 * Confirm to stop the work for registration before the sound card is
+	 * going to be released. The work is not scheduled again because bus
+	 * reset handler is not called anymore.
+	 */
+	cancel_delayed_work_sync(&bebob->dwork);
+
+	if (bebob->registered) {
+		/* No need to wait for releasing card object in this context. */
+		snd_card_free_when_closed(bebob->card);
+	} else {
+		/* Don't forget this case. */
+		bebob_free(bebob);
+	}
 }
 
 static const struct snd_bebob_rate_spec normal_rate_spec = {
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index b50bb33d..2a442a7 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -83,6 +83,10 @@ struct snd_bebob {
 	struct mutex mutex;
 	spinlock_t lock;
 
+	bool registered;
+	struct delayed_work dwork;
+
+	const struct ieee1394_device_id *entry;
 	const struct snd_bebob_spec *spec;
 
 	unsigned int midi_input_ports;
@@ -111,7 +115,6 @@ struct snd_bebob {
 
 	/* for M-Audio special devices */
 	void *maudio_special_quirk;
-	bool deferred_registration;
 
 	/* For BeBoB version quirk. */
 	unsigned int version;
-- 
2.7.4
