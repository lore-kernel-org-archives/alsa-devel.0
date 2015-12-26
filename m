From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: dice: postpone card registration
Date: Sat, 26 Dec 2015 12:35:23 +0900
Message-ID: <1451100926-20637-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1451100926-20637-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A117261497
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2015 04:35:36 +0100 (CET)
In-Reply-To: <1451100926-20637-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, Yoshifuji Hideaki <hideaki@yoshifuji.org>, ffado-devel@lists.sf.net
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
Dice II, Dice Jr., Dice Mini and Dice III. Due to the same reason, sound
card instance is kept till .remove function even if some errors are
detected in the workqueue.

I use a loose strategy to manage a race condition between the workqueue and
the bus reset. This is due to a specification of dice transaction. When bus
reset occurs, registered address for the transaction is cleared. Drivers
must re-register their own address again. While, this operation is
required for the workqueue because the workqueue includes to wait for the
transaction. This commit uses no lock primitives for the race condition in
bus reset handler. Instead, checking 'registered' member of
'struct snd_dice' avoid executing the workqueue several times.

When .remove callback is executed, the sound card is going to be released.
The registration work should not be pending or executed in the releasing.
This commit uses cancel_delayed_work_sync() in .remove callback and wait
till the pending work finished. After .remove callback, .update callback
is not executed, therefore no works are scheduled again.

Cc: Yoshifuji Hideaki <hideaki@yoshifuji.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 113 ++++++++++++++++++++++++++++++++-------------
 sound/firewire/dice/dice.h |   3 ++
 2 files changed, 85 insertions(+), 31 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 26271cc..0bc7d08 100644
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
@@ -192,6 +194,59 @@ static void dice_card_free(struct snd_card *card)
 	mutex_destroy(&dice->mutex);
 }
 
+static void do_registration(struct work_struct *work)
+{
+	struct snd_dice *dice = container_of(work, struct snd_dice, dwork.work);
+	int err;
+
+	if (dice->card->shutdown || dice->registered)
+		return;
+
+	err = snd_dice_transaction_init(dice);
+	if (err < 0)
+		goto end;
+
+	err = dice_read_params(dice);
+	if (err < 0)
+		goto end;
+
+	dice_card_strings(dice);
+
+	err = snd_dice_create_pcm(dice);
+	if (err < 0)
+		goto end;
+
+	err = snd_dice_create_midi(dice);
+	if (err < 0)
+		goto end;
+
+	err = snd_card_register(dice->card);
+	if (err < 0)
+		goto end;
+
+	dice->registered = true;
+end:
+	if (err < 0)
+		dev_info(&dice->unit->device,
+			 "Sound card registration failed: %d\n", err);
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
 static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 {
 	struct snd_card *card;
@@ -205,29 +260,20 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
 			   sizeof(*dice), &card);
 	if (err < 0)
-		goto end;
+		return err;
 
 	dice = card->private_data;
 	dice->card = card;
 	dice->unit = fw_unit_get(unit);
 	card->private_free = dice_card_free;
+	dev_set_drvdata(&unit->device, dice);
 
 	spin_lock_init(&dice->lock);
 	mutex_init(&dice->mutex);
 	init_completion(&dice->clock_accepted);
 	init_waitqueue_head(&dice->hwdep_wait);
 
-	err = snd_dice_transaction_init(dice);
-	if (err < 0)
-		goto error;
-
-	err = dice_read_params(dice);
-	if (err < 0)
-		goto error;
-
-	dice_card_strings(dice);
-
-	err = snd_dice_create_pcm(dice);
+	err = snd_dice_stream_init_duplex(dice);
 	if (err < 0)
 		goto error;
 
@@ -237,23 +283,11 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	snd_dice_create_proc(dice);
 
-	err = snd_dice_create_midi(dice);
-	if (err < 0)
-		goto error;
-
-	err = snd_dice_stream_init_duplex(dice);
-	if (err < 0)
-		goto error;
+	/* Register this sound card later. */
+	INIT_DEFERRABLE_WORK(&dice->dwork, do_registration);
+	schedule_registration(dice);
 
-	err = snd_card_register(card);
-	if (err < 0) {
-		snd_dice_stream_destroy_duplex(dice);
-		goto error;
-	}
-
-	dev_set_drvdata(&unit->device, dice);
-end:
-	return err;
+	return 0;
 error:
 	snd_card_free(card);
 	return err;
@@ -263,6 +297,13 @@ static void dice_remove(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
+	/*
+	 * Confirm to stop the work for registration before the sound card is
+	 * going to be released. The work is not scheduled again because bus
+	 * reset handler is not called anymore.
+	 */
+	cancel_delayed_work_sync(&dice->dwork);
+
 	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(dice->card);
 }
@@ -271,12 +312,22 @@ static void dice_bus_reset(struct fw_unit *unit)
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
