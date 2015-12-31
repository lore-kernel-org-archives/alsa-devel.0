From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: dice: postpone card registration
Date: Thu, 31 Dec 2015 13:58:12 +0900
Message-ID: <1451537894-28366-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1451537894-28366-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D5C1261A2C
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 05:58:24 +0100 (CET)
In-Reply-To: <1451537894-28366-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some models based on ASIC for Dice II series (STD, CP) change their
hardware configurations after appearing on IEEE 1394 bus. This is due to
interactions of boot loader (RedBoot), firmwares (eCos) and vendor's
configurations. This causes current ALSA dice driver to get wrong
information about the hardware's capability because its probe function
runs just after detecting unit of the model.

As long as I investigated, it takes a bit time (less than 1 second) to load
the firmware after bootstrap. Just after loaded, the driver can get
information about the unit. Then the hardware is initialized according to
vendor's configurations. After, the got information becomes wrong.
Between bootstrap, firmware loading and post configuration, some bus resets
are observed.

This commit offloads most processing of probe function into workqueue and
schedules the workqueue after successive bus resets. This has an effect to
get correct hardware information and avoid involvement to bus reset storm.

For code simplicity, this change effects all of Dice-based models, i.e.
Dice II, Dice Jr., Dice Mini and Dice III.

I use a loose strategy to manage a race condition between the work and the
bus reset. This is due to a specification of dice transaction. When bus
reset occurs, registered address for the transaction is cleared. Drivers
must re-register their own address again. While, this operation is required
for the work because the work includes to wait for the transaction. This
commit uses no lock primitives for the race condition. Instead, checking
'registered' member of 'struct snd_dice' avoid executing the work again.
If sound card is not registered, the work can be scheduled again by bus
reset handler.

When .remove callback is executed, the sound card is going to be released.
The work should not be pending or executed in the releasing. This commit
uses cancel_delayed_work_sync() in .remove callback and wait till the
pending work finished. After .remove callback, .update callback is not
executed, therefore no works are scheduled again.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 159 ++++++++++++++++++++++++++++++++-------------
 sound/firewire/dice/dice.h |   3 +
 2 files changed, 117 insertions(+), 45 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 26271cc..f5e15c4 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -18,6 +18,8 @@ MODULE_LICENSE("GPL v2");
 #define WEISS_CATEGORY_ID	0x00
 #define LOUD_CATEGORY_ID	0x10
 
+#define PROBE_DELAY_MS		(2 * MSEC_PER_SEC)
+
 static int check_dice_category(struct fw_unit *unit)
 {
 	struct fw_device *device = fw_parent_device(unit);
@@ -175,6 +177,16 @@ static void dice_card_strings(struct snd_dice *dice)
 	strcpy(card->mixername, "DICE");
 }
 
+static void dice_free(struct snd_dice *dice)
+{
+	snd_dice_stream_destroy_duplex(dice);
+	snd_dice_transaction_destroy(dice);
+	fw_unit_put(dice->unit);
+
+	mutex_destroy(&dice->mutex);
+	kfree(dice);
+}
+
 /*
  * This module releases the FireWire unit data after all ALSA character devices
  * are released by applications. This is for releasing stream data or finishing
@@ -183,39 +195,21 @@ static void dice_card_strings(struct snd_dice *dice)
  */
 static void dice_card_free(struct snd_card *card)
 {
-	struct snd_dice *dice = card->private_data;
-
-	snd_dice_stream_destroy_duplex(dice);
-	snd_dice_transaction_destroy(dice);
-	fw_unit_put(dice->unit);
-
-	mutex_destroy(&dice->mutex);
+	dice_free(card->private_data);
 }
 
-static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
+static void do_registration(struct work_struct *work)
 {
-	struct snd_card *card;
-	struct snd_dice *dice;
+	struct snd_dice *dice = container_of(work, struct snd_dice, dwork.work);
 	int err;
 
-	err = check_dice_category(unit);
-	if (err < 0)
-		return -ENODEV;
+	if (dice->registered)
+		return;
 
-	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
-			   sizeof(*dice), &card);
+	err = snd_card_new(&dice->unit->device, -1, NULL, THIS_MODULE, 0,
+			   &dice->card);
 	if (err < 0)
-		goto end;
-
-	dice = card->private_data;
-	dice->card = card;
-	dice->unit = fw_unit_get(unit);
-	card->private_free = dice_card_free;
-
-	spin_lock_init(&dice->lock);
-	mutex_init(&dice->mutex);
-	init_completion(&dice->clock_accepted);
-	init_waitqueue_head(&dice->hwdep_wait);
+		return;
 
 	err = snd_dice_transaction_init(dice);
 	if (err < 0)
@@ -227,56 +221,131 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	dice_card_strings(dice);
 
+	snd_dice_create_proc(dice);
+
 	err = snd_dice_create_pcm(dice);
 	if (err < 0)
 		goto error;
 
-	err = snd_dice_create_hwdep(dice);
+	err = snd_dice_create_midi(dice);
 	if (err < 0)
 		goto error;
 
-	snd_dice_create_proc(dice);
-
-	err = snd_dice_create_midi(dice);
+	err = snd_dice_create_hwdep(dice);
 	if (err < 0)
 		goto error;
 
-	err = snd_dice_stream_init_duplex(dice);
+	err = snd_card_register(dice->card);
 	if (err < 0)
 		goto error;
 
-	err = snd_card_register(card);
+	/*
+	 * After registered, dice instance can be released corresponding to
+	 * releasing the sound card instance.
+	 */
+	dice->card->private_free = dice_card_free;
+	dice->card->private_data = dice;
+	dice->registered = true;
+
+	return;
+error:
+	snd_dice_transaction_destroy(dice);
+	snd_card_free(dice->card);
+	dev_info(&dice->unit->device,
+		 "Sound card registration failed: %d\n", err);
+}
+
+static void schedule_registration(struct snd_dice *dice)
+{
+	struct fw_card *fw_card = fw_parent_device(dice->unit)->card;
+	u64 now, delay;
+
+	now = get_jiffies_64();
+	delay = fw_card->reset_jiffies + msecs_to_jiffies(PROBE_DELAY_MS);
+
+	if (time_after64(delay, now))
+		delay -= now;
+	else
+		delay = 0;
+
+	mod_delayed_work(system_wq, &dice->dwork, delay);
+}
+
+static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
+{
+	struct snd_dice *dice;
+	int err;
+
+	err = check_dice_category(unit);
+	if (err < 0)
+		return -ENODEV;
+
+	/* Allocate this independent of sound card instance. */
+	dice = kzalloc(sizeof(struct snd_dice), GFP_KERNEL);
+	if (dice == NULL)
+		return -ENOMEM;
+
+	dice->unit = fw_unit_get(unit);
+	dev_set_drvdata(&unit->device, dice);
+
+	spin_lock_init(&dice->lock);
+	mutex_init(&dice->mutex);
+	init_completion(&dice->clock_accepted);
+	init_waitqueue_head(&dice->hwdep_wait);
+
+	err = snd_dice_stream_init_duplex(dice);
 	if (err < 0) {
-		snd_dice_stream_destroy_duplex(dice);
-		goto error;
+		dice_free(dice);
+		return err;
 	}
 
-	dev_set_drvdata(&unit->device, dice);
-end:
-	return err;
-error:
-	snd_card_free(card);
-	return err;
+	/* Allocate and register this sound card later. */
+	INIT_DEFERRABLE_WORK(&dice->dwork, do_registration);
+	schedule_registration(dice);
+
+	return 0;
 }
 
 static void dice_remove(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
-	/* No need to wait for releasing card object in this context. */
-	snd_card_free_when_closed(dice->card);
+	/*
+	 * Confirm to stop the work for registration before the sound card is
+	 * going to be released. The work is not scheduled again because bus
+	 * reset handler is not called anymore.
+	 */
+	cancel_delayed_work_sync(&dice->dwork);
+
+	if (dice->registered) {
+		/* No need to wait for releasing card object in this context. */
+		snd_card_free_when_closed(dice->card);
+	} else {
+		/* Don't forget this case. */
+		dice_free(dice);
+	}
 }
 
 static void dice_bus_reset(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
+	/* Postpone a workqueue for deferred registration. */
+	if (!dice->registered)
+		schedule_registration(dice);
+
 	/* The handler address register becomes initialized. */
 	snd_dice_transaction_reinit(dice);
 
-	mutex_lock(&dice->mutex);
-	snd_dice_stream_update_duplex(dice);
-	mutex_unlock(&dice->mutex);
+	/*
+	 * After registration, userspace can start packet streaming, then this
+	 * code block works fine.
+	 */
+	if (dice->registered) {
+		mutex_lock(&dice->mutex);
+		snd_dice_stream_update_duplex(dice);
+		mutex_unlock(&dice->mutex);
+	}
 }
 
 #define DICE_INTERFACE	0x000001
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 101550ac..3d5ebeb 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -45,6 +45,9 @@ struct snd_dice {
 	spinlock_t lock;
 	struct mutex mutex;
 
+	bool registered;
+	struct delayed_work dwork;
+
 	/* Offsets for sub-addresses */
 	unsigned int global_offset;
 	unsigned int rx_offset;
-- 
2.5.0
