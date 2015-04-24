From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC] dice: simplifying address registration
Date: Fri, 24 Apr 2015 22:06:13 +0900
Message-ID: <553A3FC5.60809@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080307080506020601000800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E19926058F
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 15:06:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080307080506020601000800
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: quoted-printable

Clemens,

Would I request your comments about an attached patch?

Currently Dice driver keeps address ranges for each unit instance. But
there's a way to reuse the same address range. I think this idea can
simplify driver probe processing and save resources of host controller.


Regards

Takashi Sakamoto

--------------080307080506020601000800
Content-Type: text/x-diff;
 name="0001-ALSA-dice-use-the-same-address-space-for-Dice-transa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-dice-use-the-same-address-space-for-Dice-transa.pa";
 filename*1="tch"

>From 93c676c1f2a7b7a78b4de2877e2dfcf97e9e2e94 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Fri, 24 Apr 2015 11:25:13 +0900
Subject: [PATCH] ALSA: dice: use the same address space for Dice transaction

Current Dice driver implementation keeps address space for each
device instance. This is a waste of resources in host controller
and a bit complicity in device probing.

This commit applies the same address spaces for each device
instance. The range of address is kept in module initialization
process. When probing devices, the range is registered to
device's register by read transaction, then the device instance
is kept in module local list. When receiving transactions,
the local list is seeked to pick up the instance.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-transaction.c | 128 +++++++++++++++++++++------------
 sound/firewire/dice/dice.c             |  13 +++-
 sound/firewire/dice/dice.h             |   8 ++-
 3 files changed, 96 insertions(+), 53 deletions(-)

diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index aee74618..0c41193 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -11,6 +11,12 @@
 
 #define NOTIFICATION_TIMEOUT_MS	100
 
+static DEFINE_SPINLOCK(instances_lock);
+static struct snd_dice *instances[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+
+static struct fw_address_handler notification_handler;
+static int register_notification_address(struct snd_dice *dice, bool retry);
+
 static u64 get_subaddr(struct snd_dice *dice, enum snd_dice_addr_type type,
 		       u64 offset)
 {
@@ -114,7 +120,7 @@ retry:
 			goto end;
 		}
 
-		err = snd_dice_transaction_reinit(dice);
+		err = register_notification_address(dice, false);
 		if (err < 0)
 			goto end;
 
@@ -204,17 +210,39 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 			      int generation, unsigned long long offset,
 			      void *data, size_t length, void *callback_data)
 {
-	struct snd_dice *dice = callback_data;
+	struct snd_dice *dice;
+	struct fw_device *device;
 	u32 bits;
 	unsigned long flags;
+	unsigned int i;
+	int rcode;
 
 	if (tcode != TCODE_WRITE_QUADLET_REQUEST) {
-		fw_send_response(card, request, RCODE_TYPE_ERROR);
-		return;
+		rcode = RCODE_TYPE_ERROR;
+		goto end;
 	}
 	if ((offset & 3) != 0) {
-		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
-		return;
+		rcode = RCODE_ADDRESS_ERROR;
+		goto end;
+	}
+
+	spin_lock_irq(&instances_lock);
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		dice = instances[i];
+		if (dice == NULL)
+			continue;
+		device = fw_parent_device(dice->unit);
+		if (device->card != card ||
+		    device->generation != generation)
+			continue;
+		smp_rmb();	/* node_id vs. generation */
+		if (device->node_id != source)
+			continue;
+		break;
+	}
+	if (i == SNDRV_CARDS) {
+		rcode = RCODE_TYPE_ERROR;
+		goto end;
 	}
 
 	bits = be32_to_cpup(data);
@@ -223,11 +251,15 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 	dice->notification_bits |= bits;
 	spin_unlock_irqrestore(&dice->lock, flags);
 
-	fw_send_response(card, request, RCODE_COMPLETE);
-
 	if (bits & NOTIFY_CLOCK_ACCEPTED)
 		complete(&dice->clock_accepted);
 	wake_up(&dice->hwdep_wait);
+
+	spin_unlock_irq(&instances_lock);
+
+	rcode = RCODE_COMPLETE;
+end:
+	fw_send_response(card, request, rcode);
 }
 
 static int register_notification_address(struct snd_dice *dice, bool retry)
@@ -247,7 +279,7 @@ static int register_notification_address(struct snd_dice *dice, bool retry)
 		buffer[0] = cpu_to_be64(OWNER_NO_OWNER);
 		buffer[1] = cpu_to_be64(
 			((u64)device->card->node_id << OWNER_NODE_SHIFT) |
-			dice->notification_handler.offset);
+			notification_handler.offset);
 
 		dice->owner_generation = device->generation;
 		smp_rmb(); /* node_id vs. generation */
@@ -284,18 +316,28 @@ static int register_notification_address(struct snd_dice *dice, bool retry)
 	return err;
 }
 
-static void unregister_notification_address(struct snd_dice *dice)
+void snd_dice_transaction_unregister(struct snd_dice *dice)
 {
 	struct fw_device *device = fw_parent_device(dice->unit);
 	__be64 *buffer;
+	unsigned int i;
+
+	/* Remove from local list. */
+	spin_lock_irq(&instances_lock);
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		if (instances[i] != dice)
+			continue;
+		instances[i] = NULL;
+	}
+	spin_unlock_irq(&instances_lock);
 
 	buffer = kmalloc(2 * 8, GFP_KERNEL);
 	if (buffer == NULL)
 		return;
 
 	buffer[0] = cpu_to_be64(
-		((u64)device->card->node_id << OWNER_NODE_SHIFT) |
-		dice->notification_handler.offset);
+			((u64)device->card->node_id << OWNER_NODE_SHIFT) |
+			notification_handler.offset);
 	buffer[1] = cpu_to_be64(OWNER_NO_OWNER);
 	snd_fw_transaction(dice->unit, TCODE_LOCK_COMPARE_SWAP,
 			   get_subaddr(dice, SND_DICE_ADDR_TYPE_GLOBAL,
@@ -308,33 +350,15 @@ static void unregister_notification_address(struct snd_dice *dice)
 	dice->owner_generation = -1;
 }
 
-void snd_dice_transaction_destroy(struct snd_dice *dice)
-{
-	struct fw_address_handler *handler = &dice->notification_handler;
-
-	if (handler->callback_data == NULL)
-		return;
-
-	unregister_notification_address(dice);
-
-	fw_core_remove_address_handler(handler);
-	handler->callback_data = NULL;
-}
-
-int snd_dice_transaction_reinit(struct snd_dice *dice)
+int snd_dice_transaction_reregister(struct snd_dice *dice)
 {
-	struct fw_address_handler *handler = &dice->notification_handler;
-
-	if (handler->callback_data == NULL)
-		return -EINVAL;
-
 	return register_notification_address(dice, false);
 }
 
-int snd_dice_transaction_init(struct snd_dice *dice)
+int snd_dice_transaction_register(struct snd_dice *dice)
 {
-	struct fw_address_handler *handler = &dice->notification_handler;
 	__be32 *pointers;
+	unsigned int i;
 	int err;
 
 	/* Use the same way which dice_interface_check() does. */
@@ -349,23 +373,10 @@ int snd_dice_transaction_init(struct snd_dice *dice)
 	if (err < 0)
 		goto end;
 
-	/* Allocation callback in address space over host controller */
-	handler->length = 4;
-	handler->address_callback = dice_notification;
-	handler->callback_data = dice;
-	err = fw_core_add_address_handler(handler, &fw_high_memory_region);
-	if (err < 0) {
-		handler->callback_data = NULL;
-		goto end;
-	}
-
 	/* Register the address space */
 	err = register_notification_address(dice, true);
-	if (err < 0) {
-		fw_core_remove_address_handler(handler);
-		handler->callback_data = NULL;
+	if (err < 0)
 		goto end;
-	}
 
 	dice->global_offset = be32_to_cpu(pointers[0]) * 4;
 	dice->tx_offset = be32_to_cpu(pointers[2]) * 4;
@@ -376,7 +387,30 @@ int snd_dice_transaction_init(struct snd_dice *dice)
 	/* Set up later. */
 	if (be32_to_cpu(pointers[1]) * 4 >= GLOBAL_CLOCK_CAPABILITIES + 4)
 		dice->clock_caps = 1;
+
+	/* Insert into local list. */
+	spin_lock_irq(&instances_lock);
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		if (instances[i] != NULL)
+			continue;
+		instances[i] = dice;
+		break;
+	}
+	spin_unlock_irq(&instances_lock);
 end:
 	kfree(pointers);
 	return err;
 }
+
+int snd_dice_transaction_init(void)
+{
+	notification_handler.length = 4;
+	notification_handler.address_callback = dice_notification;
+	return fw_core_add_address_handler(&notification_handler,
+					   &fw_high_memory_region);
+}
+
+void snd_dice_transaction_destroy(void)
+{
+	fw_core_remove_address_handler(&notification_handler);
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 70a111d..251afc6 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -237,7 +237,7 @@ static void dice_card_free(struct snd_card *card)
 	struct snd_dice *dice = card->private_data;
 
 	snd_dice_stream_destroy_duplex(dice);
-	snd_dice_transaction_destroy(dice);
+	snd_dice_transaction_unregister(dice);
 	fw_unit_put(dice->unit);
 
 	mutex_destroy(&dice->mutex);
@@ -268,7 +268,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	init_completion(&dice->clock_accepted);
 	init_waitqueue_head(&dice->hwdep_wait);
 
-	err = snd_dice_transaction_init(dice);
+	err = snd_dice_transaction_register(dice);
 	if (err < 0)
 		goto error;
 
@@ -323,7 +323,7 @@ static void dice_bus_reset(struct fw_unit *unit)
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
 	/* The handler address register becomes initialized. */
-	snd_dice_transaction_reinit(dice);
+	snd_dice_transaction_reregister(dice);
 
 	mutex_lock(&dice->mutex);
 	snd_dice_stream_update_duplex(dice);
@@ -355,11 +355,18 @@ static struct fw_driver dice_driver = {
 
 static int __init alsa_dice_init(void)
 {
+	int err;
+
+	err = snd_dice_transaction_init();
+	if (err < 0)
+		return err;
+
 	return driver_register(&dice_driver.driver);
 }
 
 static void __exit alsa_dice_exit(void)
 {
+	snd_dice_transaction_destroy();
 	driver_unregister(&dice_driver.driver);
 }
 
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index d8b721c..85d5fcb 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -162,9 +162,11 @@ int snd_dice_transaction_set_rate(struct snd_dice *dice, unsigned int rate);
 int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate);
 int snd_dice_transaction_set_enable(struct snd_dice *dice);
 void snd_dice_transaction_clear_enable(struct snd_dice *dice);
-int snd_dice_transaction_init(struct snd_dice *dice);
-int snd_dice_transaction_reinit(struct snd_dice *dice);
-void snd_dice_transaction_destroy(struct snd_dice *dice);
+void snd_dice_transaction_unregister(struct snd_dice *dice);
+int snd_dice_transaction_reregister(struct snd_dice *dice);
+int snd_dice_transaction_register(struct snd_dice *dice);
+int snd_dice_transaction_init(void);
+void snd_dice_transaction_destroy(void);
 
 #define SND_DICE_RATES_COUNT	7
 extern const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT];
-- 
2.1.4


--------------080307080506020601000800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080307080506020601000800--
