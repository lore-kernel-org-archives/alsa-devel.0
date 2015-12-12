From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/10] ALSA: dice: postpone probe processing
Date: Sat, 12 Dec 2015 12:06:04 +0900
Message-ID: <1449889570-26641-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B5D826549A
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 04:06:15 +0100 (CET)
In-Reply-To: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
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

Some models based on ASIC for Dice II (STD, CP) change their hardware
configurations after appearing on IEEE 1394 bus. This is due to
interactions of boot loader (RedBoot), firmwares with eCos, and vendor's
configurations.

It may takes a bit time (less than 1 seconds) to load and execute the
firmware. Then it initializes the hardware according to vendor's
configurations. After configured, it generate bus reset. These operations
finished within 1 to 1.5 seconds. As a result, successive several bus reset
are observed in probe processing of IEEE 1394 unit drivers and it sometimes
causes troubles.

This commit offloads probe processing into workqueue to postpone it after
the hardware initialization and bus resets. For simplicity, this change
effects all of Dice-based models, thus Dice II, Dice Jr., Dice Mini and
Dice III.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 107 +++++++++++++++++++++++++++++++++------------
 sound/firewire/dice/dice.h |   3 ++
 2 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 26271cc..c7d5e05 100644
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
@@ -185,17 +187,70 @@ static void dice_card_free(struct snd_card *card)
 {
 	struct snd_dice *dice = card->private_data;
 
+	/* The workqueue for registration uses the memory block. */
+	cancel_work_sync(&dice->dwork.work);
+
 	snd_dice_stream_destroy_duplex(dice);
+
 	snd_dice_transaction_destroy(dice);
+
 	fw_unit_put(dice->unit);
 
 	mutex_destroy(&dice->mutex);
 }
 
+static void do_probe(struct work_struct *work)
+{
+	struct snd_dice *dice = container_of(work, struct snd_dice, dwork.work);
+	int err;
+
+	mutex_lock(&dice->mutex);
+
+	if (dice->card->shutdown || dice->probed)
+		goto end;
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
+	if (err < 0) {
+		snd_dice_stream_destroy_duplex(dice);
+		goto end;
+	}
+
+	dice->probed = true;
+end:
+	mutex_unlock(&dice->mutex);
+
+	/*
+	 * It's a difficult work to manage a race condition between workqueue,
+	 * unit event handlers and processes. The memory block for this card
+	 * is released as the same way that usual sound cards are going to be
+	 * released.
+	 */
+}
+
 static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 {
+	struct fw_card *fw_card = fw_parent_device(unit)->card;
 	struct snd_card *card;
 	struct snd_dice *dice;
+	unsigned long delay;
 	int err;
 
 	err = check_dice_category(unit);
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
 
@@ -237,23 +283,13 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	snd_dice_create_proc(dice);
 
-	err = snd_dice_create_midi(dice);
-	if (err < 0)
-		goto error;
-
-	err = snd_dice_stream_init_duplex(dice);
-	if (err < 0)
-		goto error;
-
-	err = snd_card_register(card);
-	if (err < 0) {
-		snd_dice_stream_destroy_duplex(dice);
-		goto error;
-	}
+	/* Register this sound card later. */
+	INIT_DEFERRABLE_WORK(&dice->dwork, do_probe);
+	delay = msecs_to_jiffies(PROBE_DELAY_MS) +
+				fw_card->reset_jiffies - get_jiffies_64();
+	schedule_delayed_work(&dice->dwork, delay);
 
-	dev_set_drvdata(&unit->device, dice);
-end:
-	return err;
+	return 0;
 error:
 	snd_card_free(card);
 	return err;
@@ -263,13 +299,28 @@ static void dice_remove(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
+	/* For a race condition of struct snd_card.shutdown. */
+	mutex_lock(&dice->mutex);
+
 	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(dice->card);
+
+	mutex_unlock(&dice->mutex);
 }
 
 static void dice_bus_reset(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
+	struct fw_card *fw_card = fw_parent_device(unit)->card;
+	unsigned long delay;
+
+	/* Postpone a workqueue for deferred registration. */
+	if (!dice->probed) {
+		delay = msecs_to_jiffies(PROBE_DELAY_MS) -
+				(get_jiffies_64() - fw_card->reset_jiffies);
+		mod_delayed_work(dice->dwork.wq, &dice->dwork, delay);
+		return;
+	}
 
 	/* The handler address register becomes initialized. */
 	snd_dice_transaction_reinit(dice);
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 101550ac..4741113 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -45,6 +45,9 @@ struct snd_dice {
 	spinlock_t lock;
 	struct mutex mutex;
 
+	bool probed;
+	struct delayed_work dwork;
+
 	/* Offsets for sub-addresses */
 	unsigned int global_offset;
 	unsigned int rx_offset;
-- 
2.5.0
