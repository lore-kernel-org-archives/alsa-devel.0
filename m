From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/13] ALSA: dice: Split transaction
	functionality into a file
Date: Mon, 29 Sep 2014 00:58:13 +0900
Message-ID: <1411919903-10981-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CB7A26058E
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 17:58:48 +0200 (CEST)
In-Reply-To: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds a file with some helper functions for transaction, and move
some codes into the file with some arrangements.

For Dice chipset, well-known FCP or AV/C commands are not used to control
devices. It's achieved by read/write transactions into specific addresses.

Dice's address area is split into 5 areas. Each area has its own role. The
offset for each area can be got by reading head of the address area. By
reading these areas, drivers can get to know device status. By writing these
areas, drivers can change device status.

It's not so rate to use read/write transaction to control devices, but Dice
has a specific mechanism called as 'notification'. When device status is
changed, Dice devices tells the event by sending transaction. This
notification is sent to an address which drivers register in advance. But
this causes an issue to drivers.

To handle the notification, drivers need to allocate its own callback function
to the address region in host controller. This region is exclusive. For the
other applications, drivers must give a mechanism to read the received
notification. For this purpose, Dice driver already implements hwdep interface.

Dice chipset doesn't allow drivers to register several addresses. In this
reason, when this driver is applied to a device, the other drivers should
_not_ try to register its own address to the device.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/Makefile           |   2 +-
 sound/firewire/dice/dice-transaction.c | 375 +++++++++++++++++++++++++
 sound/firewire/dice/dice.c             | 492 ++++++++-------------------------
 sound/firewire/dice/dice.h             | 160 +++++++++++
 4 files changed, 645 insertions(+), 384 deletions(-)
 create mode 100644 sound/firewire/dice/dice-transaction.c
 create mode 100644 sound/firewire/dice/dice.h

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index af05d7e..9f473cb 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,2 +1,2 @@
-snd-dice-objs := dice.o
+snd-dice-objs := dice-transaction.o dice.o
 obj-m += snd-dice.o
diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
new file mode 100644
index 0000000..3e76219
--- /dev/null
+++ b/sound/firewire/dice/dice-transaction.c
@@ -0,0 +1,375 @@
+/*
+ * dice_transaction.c - a part of driver for Dice based devices
+ *
+ * Copyright (c) Clemens Ladisch
+ * Copyright (c) 2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "dice.h"
+
+#define NOTIFICATION_TIMEOUT_MS	100
+
+static u64 get_subaddr(struct snd_dice *dice, enum snd_dice_addr_type type,
+		       u64 offset)
+{
+	switch (type) {
+	case SND_DICE_ADDR_TYPE_TX:
+		offset += dice->tx_offset;
+		break;
+	case SND_DICE_ADDR_TYPE_RX:
+		offset += dice->rx_offset;
+		break;
+	case SND_DICE_ADDR_TYPE_SYNC:
+		offset += dice->sync_offset;
+		break;
+	case SND_DICE_ADDR_TYPE_RSRV:
+		offset += dice->rsrv_offset;
+		break;
+	case SND_DICE_ADDR_TYPE_GLOBAL:
+	default:
+		offset += dice->global_offset;
+		break;
+	};
+	offset += DICE_PRIVATE_SPACE;
+	return offset;
+}
+
+int snd_dice_transaction_write(struct snd_dice *dice,
+			       enum snd_dice_addr_type type,
+			       unsigned int offset, void *buf, unsigned int len)
+{
+	return snd_fw_transaction(dice->unit,
+				  (len == 4) ? TCODE_WRITE_QUADLET_REQUEST :
+					       TCODE_WRITE_BLOCK_REQUEST,
+				  get_subaddr(dice, type, offset), buf, len, 0);
+}
+
+int snd_dice_transaction_read(struct snd_dice *dice,
+			      enum snd_dice_addr_type type, unsigned int offset,
+			      void *buf, unsigned int len)
+{
+	return snd_fw_transaction(dice->unit,
+				  (len == 4) ? TCODE_READ_QUADLET_REQUEST :
+					       TCODE_READ_BLOCK_REQUEST,
+				  get_subaddr(dice, type, offset), buf, len, 0);
+}
+
+static unsigned int get_clock_info(struct snd_dice *dice, __be32 *info)
+{
+	return snd_dice_transaction_read_global(dice, GLOBAL_CLOCK_SELECT,
+						info, 4);
+}
+
+static int set_clock_info(struct snd_dice *dice,
+			  unsigned int rate, unsigned int source)
+{
+	unsigned int i;
+	__be32 info;
+	u32 mask;
+	u32 clock;
+	int err;
+
+	err = get_clock_info(dice, &info);
+	if (err < 0)
+		goto end;
+
+	clock = be32_to_cpu(info);
+	if (source != UINT_MAX) {
+		mask = CLOCK_SOURCE_MASK;
+		clock &= ~mask;
+		clock |= source;
+	}
+	if (rate != UINT_MAX) {
+		for (i = 0; i < ARRAY_SIZE(snd_dice_rates); i++) {
+			if (snd_dice_rates[i] == rate)
+				break;
+		}
+		if (i == ARRAY_SIZE(snd_dice_rates)) {
+			err = -EINVAL;
+			goto end;
+		}
+
+		mask = CLOCK_RATE_MASK;
+		clock &= ~mask;
+		clock |= i << CLOCK_RATE_SHIFT;
+	}
+	info = cpu_to_be32(clock);
+
+	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
+						&info, 4);
+	if (err < 0)
+		goto end;
+
+	if (wait_for_completion_timeout(&dice->clock_accepted,
+			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0) {
+		/* Notification time out. Do confirmation. */
+		err = get_clock_info(dice, &info);
+		if (err == 0 && clock != be32_to_cpu(info))
+			err = -ETIMEDOUT;
+
+		goto end;
+	}
+
+	/* Check valid notification. */
+	if (!(dice->notification_bits & NOTIFY_CLOCK_ACCEPTED))
+		err = -EIO;
+end:
+	return err;
+}
+
+int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
+					  unsigned int *source)
+{
+	__be32 info;
+	int err;
+
+	err = get_clock_info(dice, &info);
+	if (err >= 0)
+		*source = be32_to_cpu(info) & CLOCK_SOURCE_MASK;
+
+	return err;
+}
+int snd_dice_transaction_set_clock_source(struct snd_dice *dice,
+					  unsigned int source)
+{
+	return set_clock_info(dice, UINT_MAX, source);
+}
+
+int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate)
+{
+	__be32 info;
+	unsigned int index;
+	int err;
+
+	err = get_clock_info(dice, &info);
+	if (err < 0)
+		goto end;
+
+	index = (be32_to_cpu(info) & CLOCK_RATE_MASK) >> CLOCK_RATE_SHIFT;
+	if (index >= SND_DICE_RATES_COUNT)
+		err = -ENOSYS;
+	else
+		*rate = snd_dice_rates[index];
+end:
+	return err;
+}
+int snd_dice_transaction_set_rate(struct snd_dice *dice, unsigned int rate)
+{
+	return set_clock_info(dice, rate, UINT_MAX);
+}
+
+int snd_dice_transaction_set_enable(struct snd_dice *dice)
+{
+	__be32 value;
+	int err = 0;
+
+	if (dice->global_enabled)
+		goto end;
+
+	value = cpu_to_be32(1);
+	err = snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 get_subaddr(dice, SND_DICE_ADDR_TYPE_GLOBAL,
+					     GLOBAL_ENABLE),
+				 &value, 4,
+				 FW_FIXED_GENERATION | dice->owner_generation);
+	if (err < 0)
+		goto end;
+
+	dice->global_enabled = true;
+end:
+	return err;
+}
+
+void snd_dice_transaction_clear_enable(struct snd_dice *dice)
+{
+	__be32 value;
+
+	value = 0;
+	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   get_subaddr(dice, SND_DICE_ADDR_TYPE_GLOBAL,
+				       GLOBAL_ENABLE),
+			   &value, 4, FW_QUIET |
+			   FW_FIXED_GENERATION | dice->owner_generation);
+
+	dice->global_enabled = false;
+}
+
+static void dice_notification(struct fw_card *card, struct fw_request *request,
+			      int tcode, int destination, int source,
+			      int generation, unsigned long long offset,
+			      void *data, size_t length, void *callback_data)
+{
+	struct snd_dice *dice = callback_data;
+	u32 bits;
+	unsigned long flags;
+
+	if (tcode != TCODE_WRITE_QUADLET_REQUEST) {
+		fw_send_response(card, request, RCODE_TYPE_ERROR);
+		return;
+	}
+	if ((offset & 3) != 0) {
+		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
+		return;
+	}
+
+	bits = be32_to_cpup(data);
+
+	spin_lock_irqsave(&dice->lock, flags);
+	dice->notification_bits |= bits;
+	spin_unlock_irqrestore(&dice->lock, flags);
+
+	fw_send_response(card, request, RCODE_COMPLETE);
+
+	if (bits & NOTIFY_CLOCK_ACCEPTED)
+		complete(&dice->clock_accepted);
+	wake_up(&dice->hwdep_wait);
+}
+
+static int register_notification_address(struct snd_dice *dice, bool retry)
+{
+	struct fw_device *device = fw_parent_device(dice->unit);
+	__be64 *buffer;
+	unsigned int retries;
+	int err;
+
+	retries = (retry) ? 3 : 0;
+
+	buffer = kmalloc(2 * 8, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	for (;;) {
+		buffer[0] = cpu_to_be64(OWNER_NO_OWNER);
+		buffer[1] = cpu_to_be64(
+			((u64)device->card->node_id << OWNER_NODE_SHIFT) |
+			dice->notification_handler.offset);
+
+		dice->owner_generation = device->generation;
+		smp_rmb(); /* node_id vs. generation */
+		err = snd_fw_transaction(dice->unit, TCODE_LOCK_COMPARE_SWAP,
+					 get_subaddr(dice,
+						     SND_DICE_ADDR_TYPE_GLOBAL,
+						     GLOBAL_OWNER),
+					 buffer, 2 * 8,
+					 FW_FIXED_GENERATION |
+							dice->owner_generation);
+		if (err == 0) {
+			/* success */
+			if (buffer[0] == cpu_to_be64(OWNER_NO_OWNER))
+				break;
+
+			dev_err(&dice->unit->device,
+				"device is already in use\n");
+			err = -EBUSY;
+		}
+		if (err != -EAGAIN || retries-- > 0)
+			break;
+
+		msleep(20);
+	}
+
+	kfree(buffer);
+
+	if (err < 0)
+		dice->owner_generation = -1;
+
+	return err;
+}
+
+static void unregister_notification_address(struct snd_dice *dice)
+{
+	struct fw_device *device = fw_parent_device(dice->unit);
+	__be64 *buffer;
+
+	buffer = kmalloc(2 * 8, GFP_KERNEL);
+	if (buffer == NULL)
+		return;
+
+	buffer[0] = cpu_to_be64(
+		((u64)device->card->node_id << OWNER_NODE_SHIFT) |
+		dice->notification_handler.offset);
+	buffer[1] = cpu_to_be64(OWNER_NO_OWNER);
+	snd_fw_transaction(dice->unit, TCODE_LOCK_COMPARE_SWAP,
+			   get_subaddr(dice, SND_DICE_ADDR_TYPE_GLOBAL,
+				       GLOBAL_OWNER),
+			   buffer, 2 * 8, FW_QUIET |
+			   FW_FIXED_GENERATION | dice->owner_generation);
+
+	kfree(buffer);
+
+	dice->owner_generation = -1;
+}
+
+void snd_dice_transaction_destroy(struct snd_dice *dice)
+{
+	struct fw_address_handler *handler = &dice->notification_handler;
+
+	if (handler->callback_data == NULL)
+		return;
+
+	unregister_notification_address(dice);
+	fw_core_remove_address_handler(handler);
+	handler->callback_data = NULL;
+}
+
+int snd_dice_transaction_reinit(struct snd_dice *dice)
+{
+	struct fw_address_handler *handler = &dice->notification_handler;
+
+	if (handler->callback_data == NULL)
+		return -EINVAL;
+
+	return register_notification_address(dice, false);
+}
+
+int snd_dice_transaction_init(struct snd_dice *dice)
+{
+	struct fw_address_handler *handler = &dice->notification_handler;
+	__be32 *pointers;
+	int err;
+
+	/* Use the same way which dice_interface_check() does. */
+	pointers = kmalloc(sizeof(__be32) * 10, GFP_KERNEL);
+	if (pointers == NULL)
+		return -ENOMEM;
+
+	/* Get offsets for sub-addresses */
+	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
+				 DICE_PRIVATE_SPACE,
+				 pointers, sizeof(__be32) * 10, 0);
+	if (err < 0)
+		goto end;
+
+	/* Allocation callback in address space over host controller */
+	handler->length = 4;
+	handler->address_callback = dice_notification;
+	handler->callback_data = dice;
+	err = fw_core_add_address_handler(handler, &fw_high_memory_region);
+	if (err < 0) {
+		handler->callback_data = NULL;
+		goto end;
+	}
+
+	/* Register the address space */
+	err = register_notification_address(dice, true);
+	if (err < 0) {
+		fw_core_remove_address_handler(handler);
+		handler->callback_data = NULL;
+		goto end;
+	}
+
+	dice->global_offset = be32_to_cpu(pointers[0]) * 4;
+	dice->tx_offset = be32_to_cpu(pointers[2]) * 4;
+	dice->rx_offset = be32_to_cpu(pointers[4]) * 4;
+	dice->sync_offset = be32_to_cpu(pointers[6]) * 4;
+	dice->rsrv_offset = be32_to_cpu(pointers[8]) * 4;
+
+	/* Set up later. */
+	if (be32_to_cpu(pointers[1]) * 4 >= GLOBAL_CLOCK_CAPABILITIES + 4)
+		dice->clock_caps = 1;
+end:
+	kfree(pointers);
+	return err;
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index d3ec778..890dcb4 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -5,60 +5,13 @@
  * Licensed under the terms of the GNU General Public License, version 2.
  */
 
-#include <linux/compat.h>
-#include <linux/completion.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/firewire.h>
-#include <linux/firewire-constants.h>
-#include <linux/jiffies.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/mutex.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/wait.h>
-#include <sound/control.h>
-#include <sound/core.h>
-#include <sound/firewire.h>
-#include <sound/hwdep.h>
-#include <sound/info.h>
-#include <sound/initval.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include "../amdtp.h"
-#include "../iso-resources.h"
-#include "../lib.h"
-#include "dice-interface.h"
-
-
-struct snd_dice {
-	struct snd_card *card;
-	struct fw_unit *unit;
-	spinlock_t lock;
-	struct mutex mutex;
-	unsigned int global_offset;
-	unsigned int rx_offset;
-	unsigned int clock_caps;
-	unsigned int rx_channels[3];
-	unsigned int rx_midi_ports[3];
-	struct fw_address_handler notification_handler;
-	int owner_generation;
-	int dev_lock_count; /* > 0 driver, < 0 userspace */
-	bool dev_lock_changed;
-	bool global_enabled;
-	struct completion clock_accepted;
-	wait_queue_head_t hwdep_wait;
-	u32 notification_bits;
-	struct fw_iso_resources rx_resources;
-	struct amdtp_stream rx_stream;
-};
+#include "dice.h"
 
 MODULE_DESCRIPTION("DICE driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
-static const unsigned int dice_rates[] = {
+const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
 	/* mode 0 */
 	[0] =  32000,
 	[1] =  44100,
@@ -75,8 +28,8 @@ static unsigned int rate_to_index(unsigned int rate)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(dice_rates); ++i)
-		if (dice_rates[i] == rate)
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i)
+		if (snd_dice_rates[i] == rate)
 			return i;
 
 	return 0;
@@ -128,192 +81,6 @@ out:
 	spin_unlock_irq(&dice->lock);
 }
 
-static inline u64 global_address(struct snd_dice *dice, unsigned int offset)
-{
-	return DICE_PRIVATE_SPACE + dice->global_offset + offset;
-}
-
-/* TODO: rx index */
-static inline u64 rx_address(struct snd_dice *dice, unsigned int offset)
-{
-	return DICE_PRIVATE_SPACE + dice->rx_offset + offset;
-}
-
-static int dice_owner_set(struct snd_dice *dice)
-{
-	struct fw_device *device = fw_parent_device(dice->unit);
-	__be64 *buffer;
-	int err, errors = 0;
-
-	buffer = kmalloc(2 * 8, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	for (;;) {
-		buffer[0] = cpu_to_be64(OWNER_NO_OWNER);
-		buffer[1] = cpu_to_be64(
-			((u64)device->card->node_id << OWNER_NODE_SHIFT) |
-			dice->notification_handler.offset);
-
-		dice->owner_generation = device->generation;
-		smp_rmb(); /* node_id vs. generation */
-		err = snd_fw_transaction(dice->unit,
-					 TCODE_LOCK_COMPARE_SWAP,
-					 global_address(dice, GLOBAL_OWNER),
-					 buffer, 2 * 8,
-					 FW_FIXED_GENERATION |
-							dice->owner_generation);
-
-		if (err == 0) {
-			if (buffer[0] != cpu_to_be64(OWNER_NO_OWNER)) {
-				dev_err(&dice->unit->device,
-					"device is already in use\n");
-				err = -EBUSY;
-			}
-			break;
-		}
-		if (err != -EAGAIN || ++errors >= 3)
-			break;
-
-		msleep(20);
-	}
-
-	kfree(buffer);
-
-	return err;
-}
-
-static int dice_owner_update(struct snd_dice *dice)
-{
-	struct fw_device *device = fw_parent_device(dice->unit);
-	__be64 *buffer;
-	int err;
-
-	if (dice->owner_generation == -1)
-		return 0;
-
-	buffer = kmalloc(2 * 8, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	buffer[0] = cpu_to_be64(OWNER_NO_OWNER);
-	buffer[1] = cpu_to_be64(
-		((u64)device->card->node_id << OWNER_NODE_SHIFT) |
-		dice->notification_handler.offset);
-
-	dice->owner_generation = device->generation;
-	smp_rmb(); /* node_id vs. generation */
-	err = snd_fw_transaction(dice->unit, TCODE_LOCK_COMPARE_SWAP,
-				 global_address(dice, GLOBAL_OWNER),
-				 buffer, 2 * 8,
-				 FW_FIXED_GENERATION | dice->owner_generation);
-
-	if (err == 0) {
-		if (buffer[0] != cpu_to_be64(OWNER_NO_OWNER)) {
-			dev_err(&dice->unit->device,
-				"device is already in use\n");
-			err = -EBUSY;
-		}
-	} else if (err == -EAGAIN) {
-		err = 0; /* try again later */
-	}
-
-	kfree(buffer);
-
-	if (err < 0)
-		dice->owner_generation = -1;
-
-	return err;
-}
-
-static void dice_owner_clear(struct snd_dice *dice)
-{
-	struct fw_device *device = fw_parent_device(dice->unit);
-	__be64 *buffer;
-
-	buffer = kmalloc(2 * 8, GFP_KERNEL);
-	if (!buffer)
-		return;
-
-	buffer[0] = cpu_to_be64(
-		((u64)device->card->node_id << OWNER_NODE_SHIFT) |
-		dice->notification_handler.offset);
-	buffer[1] = cpu_to_be64(OWNER_NO_OWNER);
-	snd_fw_transaction(dice->unit, TCODE_LOCK_COMPARE_SWAP,
-			   global_address(dice, GLOBAL_OWNER),
-			   buffer, 2 * 8, FW_QUIET |
-			   FW_FIXED_GENERATION | dice->owner_generation);
-
-	kfree(buffer);
-
-	dice->owner_generation = -1;
-}
-
-static int dice_enable_set(struct snd_dice *dice)
-{
-	__be32 value;
-	int err;
-
-	value = cpu_to_be32(1);
-	err = snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 global_address(dice, GLOBAL_ENABLE),
-				 &value, 4,
-				 FW_FIXED_GENERATION | dice->owner_generation);
-	if (err < 0)
-		return err;
-
-	dice->global_enabled = true;
-
-	return 0;
-}
-
-static void dice_enable_clear(struct snd_dice *dice)
-{
-	__be32 value;
-
-	if (!dice->global_enabled)
-		return;
-
-	value = 0;
-	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   global_address(dice, GLOBAL_ENABLE),
-			   &value, 4, FW_QUIET |
-			   FW_FIXED_GENERATION | dice->owner_generation);
-
-	dice->global_enabled = false;
-}
-
-static void dice_notification(struct fw_card *card, struct fw_request *request,
-			      int tcode, int destination, int source,
-			      int generation, unsigned long long offset,
-			      void *data, size_t length, void *callback_data)
-{
-	struct snd_dice *dice = callback_data;
-	u32 bits;
-	unsigned long flags;
-
-	if (tcode != TCODE_WRITE_QUADLET_REQUEST) {
-		fw_send_response(card, request, RCODE_TYPE_ERROR);
-		return;
-	}
-	if ((offset & 3) != 0) {
-		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
-		return;
-	}
-
-	bits = be32_to_cpup(data);
-
-	spin_lock_irqsave(&dice->lock, flags);
-	dice->notification_bits |= bits;
-	spin_unlock_irqrestore(&dice->lock, flags);
-
-	fw_send_response(card, request, RCODE_COMPLETE);
-
-	if (bits & NOTIFY_CLOCK_ACCEPTED)
-		complete(&dice->clock_accepted);
-	wake_up(&dice->hwdep_wait);
-}
-
 static int dice_rate_constraint(struct snd_pcm_hw_params *params,
 				struct snd_pcm_hw_rule *rule)
 {
@@ -327,14 +94,14 @@ static int dice_rate_constraint(struct snd_pcm_hw_params *params,
 	};
 	unsigned int i, mode;
 
-	for (i = 0; i < ARRAY_SIZE(dice_rates); ++i) {
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
 		mode = rate_index_to_mode(i);
 		if ((dice->clock_caps & (1 << i)) &&
 		    snd_interval_test(channels, dice->rx_channels[mode])) {
 			allowed_rates.min = min(allowed_rates.min,
-						dice_rates[i]);
+						snd_dice_rates[i]);
 			allowed_rates.max = max(allowed_rates.max,
-						dice_rates[i]);
+						snd_dice_rates[i]);
 		}
 	}
 
@@ -354,9 +121,9 @@ static int dice_channels_constraint(struct snd_pcm_hw_params *params,
 	};
 	unsigned int i, mode;
 
-	for (i = 0; i < ARRAY_SIZE(dice_rates); ++i)
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i)
 		if ((dice->clock_caps & (1 << i)) &&
-		    snd_interval_test(rate, dice_rates[i])) {
+		    snd_interval_test(rate, snd_dice_rates[i])) {
 			mode = rate_index_to_mode(i);
 			allowed_channels.min = min(allowed_channels.min,
 						   dice->rx_channels[mode]);
@@ -395,10 +162,10 @@ static int dice_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = hardware;
 
-	for (i = 0; i < ARRAY_SIZE(dice_rates); ++i)
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i)
 		if (dice->clock_caps & (1 << i))
 			runtime->hw.rates |=
-				snd_pcm_rate_to_rate_bit(dice_rates[i]);
+				snd_pcm_rate_to_rate_bit(snd_dice_rates[i]);
 	snd_pcm_limit_hw_rates(runtime);
 
 	for (i = 0; i < 3; ++i)
@@ -453,7 +220,7 @@ static int dice_stream_start_packets(struct snd_dice *dice)
 	if (err < 0)
 		return err;
 
-	err = dice_enable_set(dice);
+	err = snd_dice_transaction_set_enable(dice);
 	if (err < 0) {
 		amdtp_stream_stop(&dice->rx_stream);
 		return err;
@@ -475,10 +242,8 @@ static int dice_stream_start(struct snd_dice *dice)
 			goto error;
 
 		channel = cpu_to_be32(dice->rx_resources.channel);
-		err = snd_fw_transaction(dice->unit,
-					 TCODE_WRITE_QUADLET_REQUEST,
-					 rx_address(dice, RX_ISOCHRONOUS),
-					 &channel, 4, 0);
+		err = snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
+						    &channel, 4);
 		if (err < 0)
 			goto err_resources;
 	}
@@ -491,8 +256,7 @@ static int dice_stream_start(struct snd_dice *dice)
 
 err_rx_channel:
 	channel = cpu_to_be32((u32)-1);
-	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4, 0);
+	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
 err_resources:
 	fw_iso_resources_free(&dice->rx_resources);
 error:
@@ -502,7 +266,7 @@ error:
 static void dice_stream_stop_packets(struct snd_dice *dice)
 {
 	if (amdtp_stream_running(&dice->rx_stream)) {
-		dice_enable_clear(dice);
+		snd_dice_transaction_clear_enable(dice);
 		amdtp_stream_stop(&dice->rx_stream);
 	}
 }
@@ -517,33 +281,11 @@ static void dice_stream_stop(struct snd_dice *dice)
 		return;
 
 	channel = cpu_to_be32((u32)-1);
-	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4, 0);
+	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
 
 	fw_iso_resources_free(&dice->rx_resources);
 }
 
-static int dice_change_rate(struct snd_dice *dice, unsigned int clock_rate)
-{
-	__be32 value;
-	int err;
-
-	reinit_completion(&dice->clock_accepted);
-
-	value = cpu_to_be32(clock_rate | CLOCK_SOURCE_ARX1);
-	err = snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 global_address(dice, GLOBAL_CLOCK_SELECT),
-				 &value, 4, 0);
-	if (err < 0)
-		return err;
-
-	if (!wait_for_completion_timeout(&dice->clock_accepted,
-					 msecs_to_jiffies(100)))
-		dev_warn(&dice->unit->device, "clock change timed out\n");
-
-	return 0;
-}
-
 static int dice_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *hw_params)
 {
@@ -561,8 +303,7 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	rate = params_rate(hw_params);
-	rate_index = rate_to_index(rate);
-	err = dice_change_rate(dice, rate_index << CLOCK_RATE_SHIFT);
+	err = snd_dice_transaction_set_rate(dice, rate);
 	if (err < 0)
 		return err;
 
@@ -577,6 +318,7 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 	 * be aligned to SYT_INTERVAL.
 	 */
 	channels = params_channels(hw_params);
+	rate_index = rate_to_index(rate);
 	if (rate_index > 4) {
 		if (channels > AMDTP_MAX_CHANNELS_FOR_PCM / 2) {
 			err = -ENOSYS;
@@ -1118,15 +860,6 @@ static void dice_create_proc(struct snd_dice *dice)
 		snd_info_set_text_ops(entry, dice, dice_proc_read);
 }
 
-static void dice_card_free(struct snd_card *card)
-{
-	struct snd_dice *dice = card->private_data;
-
-	amdtp_stream_destroy(&dice->rx_stream);
-	fw_core_remove_address_handler(&dice->notification_handler);
-	mutex_destroy(&dice->mutex);
-}
-
 #define OUI_WEISS		0x001c6a
 
 #define DICE_CATEGORY_ID	0x04
@@ -1143,12 +876,17 @@ static int dice_interface_check(struct fw_unit *unit)
 	};
 	struct fw_device *device = fw_parent_device(unit);
 	struct fw_csr_iterator it;
-	int key, value, vendor = -1, model = -1, err;
+	int key, val, vendor = -1, model = -1, err;
 	unsigned int category, i;
-	__be32 pointers[ARRAY_SIZE(min_values)];
+	__be32 *pointers, value;
 	__be32 tx_data[4];
 	__be32 version;
 
+	pointers = kmalloc_array(ARRAY_SIZE(min_values), sizeof(__be32),
+				 GFP_KERNEL);
+	if (pointers == NULL)
+		return -ENOMEM;
+
 	/*
 	 * Check that GUID and unit directory are constructed according to DICE
 	 * rules, i.e., that the specifier ID is the GUID's OUI, and that the
@@ -1156,13 +894,13 @@ static int dice_interface_check(struct fw_unit *unit)
 	 * ID, and a 22-bit serial number.
 	 */
 	fw_csr_iterator_init(&it, unit->directory);
-	while (fw_csr_iterator_next(&it, &key, &value)) {
+	while (fw_csr_iterator_next(&it, &key, &val)) {
 		switch (key) {
 		case CSR_SPECIFIER_ID:
-			vendor = value;
+			vendor = val;
 			break;
 		case CSR_MODEL:
-			model = value;
+			model = val;
 			break;
 		}
 	}
@@ -1171,8 +909,10 @@ static int dice_interface_check(struct fw_unit *unit)
 	else
 		category = DICE_CATEGORY_ID;
 	if (device->config_rom[3] != ((vendor << 8) | category) ||
-	    device->config_rom[4] >> 22 != model)
-		return -ENODEV;
+	    device->config_rom[4] >> 22 != model) {
+		err = -ENODEV;
+		goto end;
+	}
 
 	/*
 	 * Check that the sub address spaces exist and are located inside the
@@ -1180,14 +920,18 @@ static int dice_interface_check(struct fw_unit *unit)
 	 * minimally required registers are included.
 	 */
 	err = snd_fw_transaction(unit, TCODE_READ_BLOCK_REQUEST,
-				 DICE_PRIVATE_SPACE,
-				 pointers, sizeof(pointers), 0);
-	if (err < 0)
-		return -ENODEV;
-	for (i = 0; i < ARRAY_SIZE(pointers); ++i) {
+				 DICE_PRIVATE_SPACE, pointers,
+				 sizeof(__be32) * ARRAY_SIZE(min_values), 0);
+	if (err < 0) {
+		err = -ENODEV;
+		goto end;
+	}
+	for (i = 0; i < ARRAY_SIZE(min_values); ++i) {
 		value = be32_to_cpu(pointers[i]);
-		if (value < min_values[i] || value >= 0x40000)
-			return -ENODEV;
+		if (value < min_values[i] || value >= 0x40000) {
+			err = -ENODEV;
+			goto end;
+		}
 	}
 
 	/* We support playback only. Let capture devices be handled by FFADO. */
@@ -1195,8 +939,10 @@ static int dice_interface_check(struct fw_unit *unit)
 				 DICE_PRIVATE_SPACE +
 				 be32_to_cpu(pointers[2]) * 4,
 				 tx_data, sizeof(tx_data), 0);
-	if (err < 0 || (tx_data[0] && tx_data[3]))
-		return -ENODEV;
+	if (err < 0 || (tx_data[0] && tx_data[3])) {
+		err = -ENODEV;
+		goto end;
+	}
 
 	/*
 	 * Check that the implemented DICE driver specification major version
@@ -1206,22 +952,25 @@ static int dice_interface_check(struct fw_unit *unit)
 				 DICE_PRIVATE_SPACE +
 				 be32_to_cpu(pointers[0]) * 4 + GLOBAL_VERSION,
 				 &version, 4, 0);
-	if (err < 0)
-		return -ENODEV;
+	if (err < 0) {
+		err = -ENODEV;
+		goto end;
+	}
 	if ((version & cpu_to_be32(0xff000000)) != cpu_to_be32(0x01000000)) {
 		dev_err(&unit->device,
 			"unknown DICE version: 0x%08x\n", be32_to_cpu(version));
-		return -ENODEV;
+		err = -ENODEV;
+		goto end;
 	}
-
-	return 0;
+end:
+	return err;
 }
 
 static int highest_supported_mode_rate(struct snd_dice *dice, unsigned int mode)
 {
 	int i;
 
-	for (i = ARRAY_SIZE(dice_rates) - 1; i >= 0; --i)
+	for (i = ARRAY_SIZE(snd_dice_rates) - 1; i >= 0; --i)
 		if ((dice->clock_caps & (1 << i)) &&
 		    rate_index_to_mode(i) == mode)
 			return i;
@@ -1241,13 +990,12 @@ static int dice_read_mode_params(struct snd_dice *dice, unsigned int mode)
 		return 0;
 	}
 
-	err = dice_change_rate(dice, rate_index << CLOCK_RATE_SHIFT);
+	err = snd_dice_transaction_set_rate(dice, snd_dice_rates[rate_index]);
 	if (err < 0)
 		return err;
 
-	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
-				 rx_address(dice, RX_NUMBER_AUDIO),
-				 values, 2 * 4, 0);
+	err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
+					   values, sizeof(values));
 	if (err < 0)
 		return err;
 
@@ -1259,25 +1007,14 @@ static int dice_read_mode_params(struct snd_dice *dice, unsigned int mode)
 
 static int dice_read_params(struct snd_dice *dice)
 {
-	__be32 pointers[6];
 	__be32 value;
 	int mode, err;
 
-	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
-				 DICE_PRIVATE_SPACE,
-				 pointers, sizeof(pointers), 0);
-	if (err < 0)
-		return err;
-
-	dice->global_offset = be32_to_cpu(pointers[0]) * 4;
-	dice->rx_offset = be32_to_cpu(pointers[4]) * 4;
-
 	/* some very old firmwares don't tell about their clock support */
-	if (be32_to_cpu(pointers[1]) * 4 >= GLOBAL_CLOCK_CAPABILITIES + 4) {
-		err = snd_fw_transaction(
-				dice->unit, TCODE_READ_QUADLET_REQUEST,
-				global_address(dice, GLOBAL_CLOCK_CAPABILITIES),
-				&value, 4, 0);
+	if (dice->clock_caps > 0) {
+		err = snd_dice_transaction_read_global(dice,
+						GLOBAL_CLOCK_CAPABILITIES,
+						&value, 4);
 		if (err < 0)
 			return err;
 		dice->clock_caps = be32_to_cpu(value);
@@ -1310,9 +1047,9 @@ static void dice_card_strings(struct snd_dice *dice)
 
 	strcpy(card->shortname, "DICE");
 	BUILD_BUG_ON(NICK_NAME_SIZE < sizeof(card->shortname));
-	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
-				 global_address(dice, GLOBAL_NICK_NAME),
-				 card->shortname, sizeof(card->shortname), 0);
+	err = snd_dice_transaction_read_global(dice, GLOBAL_NICK_NAME,
+					       card->shortname,
+					       sizeof(card->shortname));
 	if (err >= 0) {
 		/* DICE strings are returned in "always-wrong" endianness */
 		BUILD_BUG_ON(sizeof(card->shortname) % 4 != 0);
@@ -1333,70 +1070,50 @@ static void dice_card_strings(struct snd_dice *dice)
 	strcpy(card->mixername, "DICE");
 }
 
+static void dice_card_free(struct snd_card *card)
+{
+	struct snd_dice *dice = card->private_data;
+
+	snd_dice_transaction_destroy(dice);
+	mutex_destroy(&dice->mutex);
+}
+
 static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 {
 	struct snd_card *card;
 	struct snd_dice *dice;
-	__be32 clock_sel;
 	int err;
 
 	err = dice_interface_check(unit);
 	if (err < 0)
-		return err;
+		goto end;
 
 	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
 			   sizeof(*dice), &card);
 	if (err < 0)
-		return err;
+		goto end;
 
 	dice = card->private_data;
 	dice->card = card;
+	dice->unit = unit;
+	card->private_free = dice_card_free;
+
 	spin_lock_init(&dice->lock);
 	mutex_init(&dice->mutex);
-	dice->unit = unit;
 	init_completion(&dice->clock_accepted);
 	init_waitqueue_head(&dice->hwdep_wait);
 
-	dice->notification_handler.length = 4;
-	dice->notification_handler.address_callback = dice_notification;
-	dice->notification_handler.callback_data = dice;
-	err = fw_core_add_address_handler(&dice->notification_handler,
-					  &fw_high_memory_region);
-	if (err < 0)
-		goto err_mutex;
-
-	err = dice_owner_set(dice);
+	err = snd_dice_transaction_init(dice);
 	if (err < 0)
-		goto err_notification_handler;
+		goto error;
 
 	err = dice_read_params(dice);
 	if (err < 0)
-		goto err_owner;
-
-	err = fw_iso_resources_init(&dice->rx_resources, unit);
-	if (err < 0)
-		goto err_owner;
-	dice->rx_resources.channels_mask = 0x00000000ffffffffuLL;
-
-	err = amdtp_stream_init(&dice->rx_stream, unit, AMDTP_OUT_STREAM,
-				CIP_BLOCKING);
-	if (err < 0)
-		goto err_resources;
-
-	card->private_free = dice_card_free;
+		goto error;
 
 	dice_card_strings(dice);
 
-	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
-				 global_address(dice, GLOBAL_CLOCK_SELECT),
-				 &clock_sel, 4, 0);
-	if (err < 0)
-		goto error;
-	clock_sel &= cpu_to_be32(~CLOCK_SOURCE_MASK);
-	clock_sel |= cpu_to_be32(CLOCK_SOURCE_ARX1);
-	err = snd_fw_transaction(unit, TCODE_WRITE_QUADLET_REQUEST,
-				 global_address(dice, GLOBAL_CLOCK_SELECT),
-				 &clock_sel, 4, 0);
+	err = snd_dice_transaction_set_clock_source(dice, CLOCK_SOURCE_ARX1);
 	if (err < 0)
 		goto error;
 
@@ -1410,22 +1127,28 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	dice_create_proc(dice);
 
-	err = snd_card_register(card);
+	err = fw_iso_resources_init(&dice->rx_resources, unit);
 	if (err < 0)
 		goto error;
+	dice->rx_resources.channels_mask = 0x00000000ffffffffuLL;
 
-	dev_set_drvdata(&unit->device, dice);
+	err = amdtp_stream_init(&dice->rx_stream, unit, AMDTP_OUT_STREAM,
+				CIP_BLOCKING);
+	if (err < 0) {
+		fw_iso_resources_destroy(&dice->rx_resources);
+		goto error;
+	}
 
-	return 0;
+	err = snd_card_register(card);
+	if (err < 0) {
+		amdtp_stream_destroy(&dice->rx_stream);
+		fw_iso_resources_destroy(&dice->rx_resources);
+		goto error;
+	}
 
-err_resources:
-	fw_iso_resources_destroy(&dice->rx_resources);
-err_owner:
-	dice_owner_clear(dice);
-err_notification_handler:
-	fw_core_remove_address_handler(&dice->notification_handler);
-err_mutex:
-	mutex_destroy(&dice->mutex);
+	dev_set_drvdata(&unit->device, dice);
+end:
+	return err;
 error:
 	snd_card_free(card);
 	return err;
@@ -1442,7 +1165,6 @@ static void dice_remove(struct fw_unit *unit)
 	mutex_lock(&dice->mutex);
 
 	dice_stream_stop(dice);
-	dice_owner_clear(dice);
 
 	mutex_unlock(&dice->mutex);
 
@@ -1453,6 +1175,14 @@ static void dice_bus_reset(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
+	/* The handler address becomes clear. */
+	if (snd_dice_transaction_reinit(dice) < 0) {
+		dev_err(&dice->unit->device,
+			"failed to register notification handler\n");
+		return;
+	}
+	dice->global_enabled = false;
+
 	/*
 	 * On a bus reset, the DICE firmware disables streaming and then goes
 	 * off contemplating its own navel for hundreds of milliseconds before
@@ -1465,11 +1195,7 @@ static void dice_bus_reset(struct fw_unit *unit)
 
 	mutex_lock(&dice->mutex);
 
-	dice->global_enabled = false;
 	dice_stream_stop_packets(dice);
-
-	dice_owner_update(dice);
-
 	fw_iso_resources_update(&dice->rx_resources);
 
 	mutex_unlock(&dice->mutex);
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
new file mode 100644
index 0000000..c756e62
--- /dev/null
+++ b/sound/firewire/dice/dice.h
@@ -0,0 +1,160 @@
+/*
+ * dice.h - a part of driver for Dice based devices
+ *
+ * Copyright (c) Clemens Ladisch
+ * Copyright (c) 2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef SOUND_DICE_H_INCLUDED
+#define SOUND_DICE_H_INCLUDED
+
+#include <linux/compat.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firewire.h>
+#include <linux/firewire-constants.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
+#include <sound/info.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include "../amdtp.h"
+#include "../iso-resources.h"
+#include "../lib.h"
+#include "dice-interface.h"
+
+struct snd_dice {
+	struct snd_card *card;
+	struct fw_unit *unit;
+	spinlock_t lock;
+	struct mutex mutex;
+
+	/* Offsets for sub-addresses */
+	unsigned int global_offset;
+	unsigned int rx_offset;
+	unsigned int tx_offset;
+	unsigned int sync_offset;
+	unsigned int rsrv_offset;
+
+	unsigned int clock_caps;
+	unsigned int rx_channels[3];
+	unsigned int rx_midi_ports[3];
+	struct fw_address_handler notification_handler;
+	int owner_generation;
+	int dev_lock_count; /* > 0 driver, < 0 userspace */
+	bool dev_lock_changed;
+	bool global_enabled;
+	struct completion clock_accepted;
+	wait_queue_head_t hwdep_wait;
+	u32 notification_bits;
+	struct fw_iso_resources rx_resources;
+	struct amdtp_stream rx_stream;
+};
+
+enum snd_dice_addr_type {
+	SND_DICE_ADDR_TYPE_PRIVATE,
+	SND_DICE_ADDR_TYPE_GLOBAL,
+	SND_DICE_ADDR_TYPE_TX,
+	SND_DICE_ADDR_TYPE_RX,
+	SND_DICE_ADDR_TYPE_SYNC,
+	SND_DICE_ADDR_TYPE_RSRV,
+};
+
+int snd_dice_transaction_write(struct snd_dice *dice,
+			       enum snd_dice_addr_type type,
+			       unsigned int offset,
+			       void *buf, unsigned int len);
+int snd_dice_transaction_read(struct snd_dice *dice,
+			      enum snd_dice_addr_type type, unsigned int offset,
+			      void *buf, unsigned int len);
+
+static inline int snd_dice_transaction_write_global(struct snd_dice *dice,
+						    unsigned int offset,
+						    void *buf, unsigned int len)
+{
+	return snd_dice_transaction_write(dice,
+					  SND_DICE_ADDR_TYPE_GLOBAL, offset,
+					  buf, len);
+}
+static inline int snd_dice_transaction_read_global(struct snd_dice *dice,
+						   unsigned int offset,
+						   void *buf, unsigned int len)
+{
+	return snd_dice_transaction_read(dice,
+					 SND_DICE_ADDR_TYPE_GLOBAL, offset,
+					 buf, len);
+}
+static inline int snd_dice_transaction_write_tx(struct snd_dice *dice,
+						unsigned int offset,
+						void *buf, unsigned int len)
+{
+	return snd_dice_transaction_write(dice, SND_DICE_ADDR_TYPE_TX, offset,
+					  buf, len);
+}
+static inline int snd_dice_transaction_read_tx(struct snd_dice *dice,
+					       unsigned int offset,
+					       void *buf, unsigned int len)
+{
+	return snd_dice_transaction_read(dice, SND_DICE_ADDR_TYPE_TX, offset,
+					 buf, len);
+}
+static inline int snd_dice_transaction_write_rx(struct snd_dice *dice,
+						unsigned int offset,
+						void *buf, unsigned int len)
+{
+	return snd_dice_transaction_write(dice, SND_DICE_ADDR_TYPE_RX, offset,
+					  buf, len);
+}
+static inline int snd_dice_transaction_read_rx(struct snd_dice *dice,
+					       unsigned int offset,
+					       void *buf, unsigned int len)
+{
+	return snd_dice_transaction_read(dice, SND_DICE_ADDR_TYPE_RX, offset,
+					 buf, len);
+}
+static inline int snd_dice_transaction_write_sync(struct snd_dice *dice,
+						  unsigned int offset,
+						  void *buf, unsigned int len)
+{
+	return snd_dice_transaction_write(dice, SND_DICE_ADDR_TYPE_SYNC, offset,
+					  buf, len);
+}
+static inline int snd_dice_transaction_read_sync(struct snd_dice *dice,
+						 unsigned int offset,
+						 void *buf, unsigned int len)
+{
+	return snd_dice_transaction_read(dice, SND_DICE_ADDR_TYPE_SYNC, offset,
+					 buf, len);
+}
+
+int snd_dice_transaction_set_clock_source(struct snd_dice *dice,
+					  unsigned int source);
+int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
+					  unsigned int *source);
+int snd_dice_transaction_set_rate(struct snd_dice *dice, unsigned int rate);
+int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate);
+int snd_dice_transaction_set_enable(struct snd_dice *dice);
+void snd_dice_transaction_clear_enable(struct snd_dice *dice);
+int snd_dice_transaction_init(struct snd_dice *dice);
+int snd_dice_transaction_reinit(struct snd_dice *dice);
+void snd_dice_transaction_destroy(struct snd_dice *dice);
+
+#define SND_DICE_RATES_COUNT	7
+extern const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT];
+
+#endif
-- 
1.9.1
