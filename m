From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [14/29] ALSA: firewire: extend snd_fw_transaction()
Date: Mon, 21 Oct 2013 21:28:47 +0200
Message-ID: <5265806F.3040702@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Add a flag to snd_fw_transaction() to allow it to abort when a bus reset
happens.  This removes most of the duplicated error handling loops that
were required around calls to the low-level fw_run_transaction().

Also add a flag to suppress error messages; errors are expected when we
attempt to clean up after the device was unplugged.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/cmp.c      |   50 +++++------
 sound/firewire/dice.c     |  207 ++++++++++++++-------------------------------
 sound/firewire/fcp.c      |    2
 sound/firewire/isight.c   |   43 ++++-----
 sound/firewire/lib.c      |   24 ++++-
 sound/firewire/lib.h      |    7 +-
 sound/firewire/scs1x.c    |    8 +-
 sound/firewire/speakers.c |    2
 8 files changed, 137 insertions(+), 206 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index 645cb0b..efdbf58 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -48,9 +48,6 @@ static int pcr_modify(struct cmp_connection *c,
 		      int (*check)(struct cmp_connection *c, __be32 pcr),
 		      enum bus_reset_handling bus_reset_handling)
 {
-	struct fw_device *device = fw_parent_device(c->resources.unit);
-	int generation = c->resources.generation;
-	int rcode, errors = 0;
 	__be32 old_arg, buffer[2];
 	int err;

@@ -59,36 +56,31 @@ static int pcr_modify(struct cmp_connection *c,
 		old_arg = buffer[0];
 		buffer[1] = modify(c, buffer[0]);

-		rcode = fw_run_transaction(
-				device->card, TCODE_LOCK_COMPARE_SWAP,
-				device->node_id, generation, device->max_speed,
+		err = snd_fw_transaction(
+				c->resources.unit, TCODE_LOCK_COMPARE_SWAP,
 				CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index),
-				buffer, 8);
-
-		if (rcode == RCODE_COMPLETE) {
-			if (buffer[0] == old_arg) /* success? */
-				break;
-
-			if (check) {
-				err = check(c, buffer[0]);
-				if (err < 0)
-					return err;
-			}
-		} else if (rcode == RCODE_GENERATION)
-			goto bus_reset;
-		else if (rcode_is_permanent_error(rcode) || ++errors >= 3)
-			goto io_error;
+				buffer, 8,
+				FW_FIXED_GENERATION | c->resources.generation);
+
+		if (err < 0) {
+			if (err == -EAGAIN &&
+			    bus_reset_handling == SUCCEED_ON_BUS_RESET)
+				err = 0;
+			return err;
+		}
+
+		if (buffer[0] == old_arg) /* success? */
+			break;
+
+		if (check) {
+			err = check(c, buffer[0]);
+			if (err < 0)
+				return err;
+		}
 	}
 	c->last_pcr_value = buffer[1];

 	return 0;
-
-io_error:
-	cmp_error(c, "transaction failed: %s\n", fw_rcode_string(rcode));
-	return -EIO;
-
-bus_reset:
-	return bus_reset_handling == ABORT_ON_BUS_RESET ? -EAGAIN : 0;
 }


@@ -108,7 +100,7 @@ int cmp_connection_init(struct cmp_connection *c,

 	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
 				 CSR_REGISTER_BASE + CSR_IMPR,
-				 &impr_be, 4);
+				 &impr_be, 4, 0);
 	if (err < 0)
 		return err;
 	impr = be32_to_cpu(impr_be);
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index e1d8dff..59d5ca4 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -118,7 +118,7 @@ static int dice_owner_set(struct dice *dice)
 {
 	struct fw_device *device = fw_parent_device(dice->unit);
 	__be64 *buffer;
-	int rcode, err, errors = 0;
+	int err, errors = 0;

 	buffer = kmalloc(2 * 8, GFP_KERNEL);
 	if (!buffer)
@@ -132,31 +132,24 @@ static int dice_owner_set(struct dice *dice)

 		dice->owner_generation = device->generation;
 		smp_rmb(); /* node_id vs. generation */
-		rcode = fw_run_transaction(device->card,
-					   TCODE_LOCK_COMPARE_SWAP,
-					   device->node_id,
-					   dice->owner_generation,
-					   device->max_speed,
-					   global_address(dice, GLOBAL_OWNER),
-					   buffer, 2 * 8);
-
-		if (rcode == RCODE_COMPLETE) {
-			if (buffer[0] == cpu_to_be64(OWNER_NO_OWNER)) {
-				err = 0;
-			} else {
+		err = snd_fw_transaction(dice->unit,
+					 TCODE_LOCK_COMPARE_SWAP,
+					 global_address(dice, GLOBAL_OWNER),
+					 buffer, 2 * 8,
+					 FW_FIXED_GENERATION |
+							dice->owner_generation);
+
+		if (err == 0) {
+			if (buffer[0] != cpu_to_be64(OWNER_NO_OWNER)) {
 				dev_err(&dice->unit->device,
 					"device is already in use\n");
 				err = -EBUSY;
 			}
 			break;
 		}
-		if (rcode_is_permanent_error(rcode) || ++errors >= 3) {
-			dev_err(&dice->unit->device,
-				"setting device owner failed: %s\n",
-				fw_rcode_string(rcode));
-			err = -EIO;
+		if (err != -EAGAIN || ++errors >= 3)
 			break;
-		}
+
 		msleep(20);
 	}

@@ -169,7 +162,7 @@ static int dice_owner_update(struct dice *dice)
 {
 	struct fw_device *device = fw_parent_device(dice->unit);
 	__be64 *buffer;
-	int rcode, err, errors = 0;
+	int err;

 	if (dice->owner_generation == -1)
 		return 0;
@@ -178,44 +171,26 @@ static int dice_owner_update(struct dice *dice)
 	if (!buffer)
 		return -ENOMEM;

-	for (;;) {
-		buffer[0] = cpu_to_be64(OWNER_NO_OWNER);
-		buffer[1] = cpu_to_be64(
-			((u64)device->card->node_id << OWNER_NODE_SHIFT) |
-			dice->notification_handler.offset);
+	buffer[0] = cpu_to_be64(OWNER_NO_OWNER);
+	buffer[1] = cpu_to_be64(
+		((u64)device->card->node_id << OWNER_NODE_SHIFT) |
+		dice->notification_handler.offset);

-		dice->owner_generation = device->generation;
-		smp_rmb(); /* node_id vs. generation */
-		rcode = fw_run_transaction(device->card,
-					   TCODE_LOCK_COMPARE_SWAP,
-					   device->node_id,
-					   dice->owner_generation,
-					   device->max_speed,
-					   global_address(dice, GLOBAL_OWNER),
-					   buffer, 2 * 8);
-
-		if (rcode == RCODE_COMPLETE) {
-			if (buffer[0] == cpu_to_be64(OWNER_NO_OWNER)) {
-				err = 0;
-			} else {
-				dev_err(&dice->unit->device,
-					"device is already in use\n");
-				err = -EBUSY;
-			}
-			break;
-		}
-		if (rcode == RCODE_GENERATION) {
-			err = 0; /* try again later */
-			break;
-		}
-		if (rcode_is_permanent_error(rcode) || ++errors >= 3) {
+	dice->owner_generation = device->generation;
+	smp_rmb(); /* node_id vs. generation */
+	err = snd_fw_transaction(dice->unit, TCODE_LOCK_COMPARE_SWAP,
+				 global_address(dice, GLOBAL_OWNER),
+				 buffer, 2 * 8,
+				 FW_FIXED_GENERATION | dice->owner_generation);
+
+	if (err == 0) {
+		if (buffer[0] != cpu_to_be64(OWNER_NO_OWNER)) {
 			dev_err(&dice->unit->device,
-				"setting device owner failed: %s\n",
-				fw_rcode_string(rcode));
-			err = -EIO;
-			break;
+				"device is already in use\n");
+			err = -EBUSY;
 		}
-		msleep(20);
+	} else if (err == -EAGAIN) {
+		err = 0; /* try again later */
 	}

 	kfree(buffer);
@@ -230,38 +205,19 @@ static void dice_owner_clear(struct dice *dice)
 {
 	struct fw_device *device = fw_parent_device(dice->unit);
 	__be64 *buffer;
-	int rcode, errors = 0;

 	buffer = kmalloc(2 * 8, GFP_KERNEL);
 	if (!buffer)
 		return;

-	for (;;) {
-		buffer[0] = cpu_to_be64(
-			((u64)device->card->node_id << OWNER_NODE_SHIFT) |
-			dice->notification_handler.offset);
-		buffer[1] = cpu_to_be64(OWNER_NO_OWNER);
-
-		rcode = fw_run_transaction(device->card,
-					   TCODE_LOCK_COMPARE_SWAP,
-					   device->node_id,
-					   dice->owner_generation,
-					   device->max_speed,
-					   global_address(dice, GLOBAL_OWNER),
-					   buffer, 2 * 8);
-
-		if (rcode == RCODE_COMPLETE)
-			break;
-		if (rcode == RCODE_GENERATION)
-			break;
-		if (rcode_is_permanent_error(rcode) || ++errors >= 3) {
-			dev_err(&dice->unit->device,
-				"clearing device owner failed: %s\n",
-				fw_rcode_string(rcode));
-			break;
-		}
-		msleep(20);
-	}
+	buffer[0] = cpu_to_be64(
+		((u64)device->card->node_id << OWNER_NODE_SHIFT) |
+		dice->notification_handler.offset);
+	buffer[1] = cpu_to_be64(OWNER_NO_OWNER);
+	snd_fw_transaction(dice->unit, TCODE_LOCK_COMPARE_SWAP,
+			   global_address(dice, GLOBAL_OWNER),
+			   buffer, 2 * 8, FW_QUIET |
+			   FW_FIXED_GENERATION | dice->owner_generation);

 	kfree(buffer);

@@ -270,67 +226,32 @@ static void dice_owner_clear(struct dice *dice)

 static int dice_enable_set(struct dice *dice)
 {
-	struct fw_device *device = fw_parent_device(dice->unit);
 	__be32 value;
-	int rcode, err, errors = 0;
+	int err;

 	value = cpu_to_be32(1);
-	for (;;) {
-		rcode = fw_run_transaction(device->card,
-					   TCODE_WRITE_QUADLET_REQUEST,
-					   device->node_id,
-					   dice->owner_generation,
-					   device->max_speed,
-					   global_address(dice, GLOBAL_ENABLE),
-					   &value, 4);
-		if (rcode == RCODE_COMPLETE) {
-			dice->global_enabled = true;
-			err = 0;
-			break;
-		}
-		if (rcode == RCODE_GENERATION) {
-			err = -EAGAIN;
-			break;
-		}
-		if (rcode_is_permanent_error(rcode) || ++errors >= 3) {
-			dev_err(&dice->unit->device,
-				"device enabling failed: %s\n",
-				fw_rcode_string(rcode));
-			err = -EIO;
-			break;
-		}
-		msleep(20);
-	}
+	err = snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 global_address(dice, GLOBAL_ENABLE),
+				 &value, 4,
+				 FW_FIXED_GENERATION | dice->owner_generation);
+	if (err < 0)
+		return err;

-	return err;
+	dice->global_enabled = true;
+
+	return 0;
 }

 static void dice_enable_clear(struct dice *dice)
 {
-	struct fw_device *device = fw_parent_device(dice->unit);
 	__be32 value;
-	int rcode, errors = 0;

 	value = 0;
-	for (;;) {
-		rcode = fw_run_transaction(device->card,
-					   TCODE_WRITE_QUADLET_REQUEST,
-					   device->node_id,
-					   dice->owner_generation,
-					   device->max_speed,
-					   global_address(dice, GLOBAL_ENABLE),
-					   &value, 4);
-		if (rcode == RCODE_COMPLETE ||
-		    rcode == RCODE_GENERATION)
-			break;
-		if (rcode_is_permanent_error(rcode) || ++errors >= 3) {
-			dev_err(&dice->unit->device,
-				"device disabling failed: %s\n",
-				fw_rcode_string(rcode));
-			break;
-		}
-		msleep(20);
-	}
+	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   global_address(dice, GLOBAL_ENABLE),
+			   &value, 4, FW_QUIET |
+			   FW_FIXED_GENERATION | dice->owner_generation);
+
 	dice->global_enabled = false;
 }

@@ -384,7 +305,7 @@ static int dice_open(struct snd_pcm_substream *substream)

 	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
 				 global_address(dice, GLOBAL_CLOCK_SELECT),
-				 &clock_sel, 4);
+				 &clock_sel, 4, 0);
 	if (err < 0)
 		goto err_lock;
 	rate_index = (be32_to_cpu(clock_sel) & CLOCK_RATE_MASK)
@@ -396,7 +317,7 @@ static int dice_open(struct snd_pcm_substream *substream)

 	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
 				 rx_address(dice, RX_NUMBER_AUDIO),
-				 data, 2 * 4);
+				 data, 2 * 4, 0);
 	if (err < 0)
 		goto err_lock;
 	number_audio = be32_to_cpu(data[0]);
@@ -488,7 +409,7 @@ static int dice_stream_start(struct dice *dice)
 		err = snd_fw_transaction(dice->unit,
 					 TCODE_WRITE_QUADLET_REQUEST,
 					 rx_address(dice, RX_ISOCHRONOUS),
-					 &channel, 4);
+					 &channel, 4, 0);
 		if (err < 0)
 			goto err_resources;
 	}
@@ -502,7 +423,7 @@ static int dice_stream_start(struct dice *dice)
 err_rx_channel:
 	channel = cpu_to_be32((u32)-1);
 	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4);
+			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4, 0);
 err_resources:
 	fw_iso_resources_free(&dice->resources);
 error:
@@ -528,7 +449,7 @@ static void dice_stream_stop(struct dice *dice)

 	channel = cpu_to_be32((u32)-1);
 	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4);
+			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4, 0);

 	fw_iso_resources_free(&dice->resources);
 }
@@ -880,7 +801,7 @@ static int dice_interface_check(struct fw_unit *unit)
 	 */
 	err = snd_fw_transaction(unit, TCODE_READ_BLOCK_REQUEST,
 				 DICE_PRIVATE_SPACE,
-				 pointers, sizeof(pointers));
+				 pointers, sizeof(pointers), 0);
 	if (err < 0)
 		return -ENODEV;
 	for (i = 0; i < ARRAY_SIZE(pointers); ++i) {
@@ -896,7 +817,7 @@ static int dice_interface_check(struct fw_unit *unit)
 	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
 				 DICE_PRIVATE_SPACE +
 				 be32_to_cpu(pointers[0]) * 4 + GLOBAL_VERSION,
-				 &version, 4);
+				 &version, 4, 0);
 	if (err < 0)
 		return -ENODEV;
 	if ((version & cpu_to_be32(0xff000000)) != cpu_to_be32(0x01000000)) {
@@ -915,7 +836,7 @@ static int dice_init_offsets(struct dice *dice)

 	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
 				 DICE_PRIVATE_SPACE,
-				 pointers, sizeof(pointers));
+				 pointers, sizeof(pointers), 0);
 	if (err < 0)
 		return err;

@@ -939,7 +860,7 @@ static void dice_card_strings(struct dice *dice)
 	BUILD_BUG_ON(NICK_NAME_SIZE < sizeof(card->shortname));
 	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
 				 global_address(dice, GLOBAL_NICK_NAME),
-				 card->shortname, sizeof(card->shortname));
+				 card->shortname, sizeof(card->shortname), 0);
 	if (err >= 0) {
 		/* DICE strings are returned in "always-wrong" endianness */
 		BUILD_BUG_ON(sizeof(card->shortname) % 4 != 0);
@@ -1015,14 +936,14 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)

 	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
 				 global_address(dice, GLOBAL_CLOCK_SELECT),
-				 &clock_sel, 4);
+				 &clock_sel, 4, 0);
 	if (err < 0)
 		goto error;
 	clock_sel &= cpu_to_be32(~CLOCK_SOURCE_MASK);
 	clock_sel |= cpu_to_be32(CLOCK_SOURCE_ARX1);
 	err = snd_fw_transaction(unit, TCODE_WRITE_QUADLET_REQUEST,
 				 global_address(dice, GLOBAL_CLOCK_SELECT),
-				 &clock_sel, 4);
+				 &clock_sel, 4, 0);
 	if (err < 0)
 		goto error;

diff --git a/sound/firewire/fcp.c b/sound/firewire/fcp.c
index ec578b5..860c080 100644
--- a/sound/firewire/fcp.c
+++ b/sound/firewire/fcp.c
@@ -90,7 +90,7 @@ int fcp_avc_transaction(struct fw_unit *unit,
 					  : TCODE_WRITE_BLOCK_REQUEST;
 		ret = snd_fw_transaction(t.unit, tcode,
 					 CSR_REGISTER_BASE + CSR_FCP_COMMAND,
-					 (void *)command, command_size);
+					 (void *)command, command_size, 0);
 		if (ret < 0)
 			break;

diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 58a5afe..fd42e6b 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -217,7 +217,7 @@ static void isight_packet(struct fw_iso_context *context, u32 cycle,

 static int isight_connect(struct isight *isight)
 {
-	int ch, err, rcode, errors = 0;
+	int ch, err;
 	__be32 value;

 retry_after_bus_reset:
@@ -230,27 +230,19 @@ retry_after_bus_reset:
 	}

 	value = cpu_to_be32(ch | (isight->device->max_speed << SPEED_SHIFT));
-	for (;;) {
-		rcode = fw_run_transaction(
-				isight->device->card,
-				TCODE_WRITE_QUADLET_REQUEST,
-				isight->device->node_id,
-				isight->resources.generation,
-				isight->device->max_speed,
-				isight->audio_base + REG_ISO_TX_CONFIG,
-				&value, 4);
-		if (rcode == RCODE_COMPLETE) {
-			return 0;
-		} else if (rcode == RCODE_GENERATION) {
-			fw_iso_resources_free(&isight->resources);
-			goto retry_after_bus_reset;
-		} else if (rcode_is_permanent_error(rcode) || ++errors >= 3) {
-			err = -EIO;
-			goto err_resources;
-		}
-		msleep(5);
+	err = snd_fw_transaction(isight->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 isight->audio_base + REG_ISO_TX_CONFIG,
+				 &value, 4, FW_FIXED_GENERATION |
+				 isight->resources.generation);
+	if (err == -EAGAIN) {
+		fw_iso_resources_free(&isight->resources);
+		goto retry_after_bus_reset;
+	} else if (err < 0) {
+		goto err_resources;
 	}

+	return 0;
+
 err_resources:
 	fw_iso_resources_free(&isight->resources);
 error:
@@ -315,17 +307,19 @@ static int isight_hw_params(struct snd_pcm_substream *substream,
 static int reg_read(struct isight *isight, int offset, __be32 *value)
 {
 	return snd_fw_transaction(isight->unit, TCODE_READ_QUADLET_REQUEST,
-				  isight->audio_base + offset, value, 4);
+				  isight->audio_base + offset, value, 4, 0);
 }

 static int reg_write(struct isight *isight, int offset, __be32 value)
 {
 	return snd_fw_transaction(isight->unit, TCODE_WRITE_QUADLET_REQUEST,
-				  isight->audio_base + offset, &value, 4);
+				  isight->audio_base + offset, &value, 4, 0);
 }

 static void isight_stop_streaming(struct isight *isight)
 {
+	__be32 value;
+
 	if (!isight->context)
 		return;

@@ -333,7 +327,10 @@ static void isight_stop_streaming(struct isight *isight)
 	fw_iso_context_destroy(isight->context);
 	isight->context = NULL;
 	fw_iso_resources_free(&isight->resources);
-	reg_write(isight, REG_AUDIO_ENABLE, 0);
+	value = 0;
+	snd_fw_transaction(isight->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   isight->audio_base + REG_AUDIO_ENABLE,
+			   &value, 4, FW_QUIET);
 }

 static int isight_hw_free(struct snd_pcm_substream *substream)
diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 14eb414..7409edb 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include "lib.h"

-#define ERROR_RETRY_DELAY_MS	5
+#define ERROR_RETRY_DELAY_MS	20

 /**
  * snd_fw_transaction - send a request and wait for its completion
@@ -20,6 +20,9 @@
  * @offset: the address in the target's address space
  * @buffer: input/output data
  * @length: length of @buffer
+ * @flags: use %FW_FIXED_GENERATION and add the generation value to attempt the
+ *         request only in that generation; use %FW_QUIET to suppress error
+ *         messages
  *
  * Submits an asynchronous request to the target device, and waits for the
  * response.  The node ID and the current generation are derived from @unit.
@@ -27,14 +30,18 @@
  * Returns zero on success, or a negative error code.
  */
 int snd_fw_transaction(struct fw_unit *unit, int tcode,
-		       u64 offset, void *buffer, size_t length)
+		       u64 offset, void *buffer, size_t length,
+		       unsigned int flags)
 {
 	struct fw_device *device = fw_parent_device(unit);
 	int generation, rcode, tries = 0;

+	generation = flags & FW_GENERATION_MASK;
 	for (;;) {
-		generation = device->generation;
-		smp_rmb(); /* node_id vs. generation */
+		if (!(flags & FW_FIXED_GENERATION)) {
+			generation = device->generation;
+			smp_rmb(); /* node_id vs. generation */
+		}
 		rcode = fw_run_transaction(device->card, tcode,
 					   device->node_id, generation,
 					   device->max_speed, offset,
@@ -43,9 +50,14 @@ int snd_fw_transaction(struct fw_unit *unit, int tcode,
 		if (rcode == RCODE_COMPLETE)
 			return 0;

+		if (rcode == RCODE_GENERATION && (flags & FW_FIXED_GENERATION))
+			return -EAGAIN;
+
 		if (rcode_is_permanent_error(rcode) || ++tries >= 3) {
-			dev_err(&unit->device, "transaction failed: %s\n",
-				fw_rcode_string(rcode));
+			if (!(flags & FW_QUIET))
+				dev_err(&unit->device,
+					"transaction failed: %s\n",
+					fw_rcode_string(rcode));
 			return -EIO;
 		}

diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index aef3014..02cfabc 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -6,8 +6,13 @@

 struct fw_unit;

+#define FW_GENERATION_MASK	0x00ff
+#define FW_FIXED_GENERATION	0x0100
+#define FW_QUIET		0x0200
+
 int snd_fw_transaction(struct fw_unit *unit, int tcode,
-		       u64 offset, void *buffer, size_t length);
+		       u64 offset, void *buffer, size_t length,
+		       unsigned int flags);

 /* returns true if retrying the transaction would not make sense */
 static inline bool rcode_is_permanent_error(int rcode)
diff --git a/sound/firewire/scs1x.c b/sound/firewire/scs1x.c
index 505fc81..858023c 100644
--- a/sound/firewire/scs1x.c
+++ b/sound/firewire/scs1x.c
@@ -369,7 +369,7 @@ static int scs_init_hss_address(struct scs *scs)
 	data = cpu_to_be64(((u64)HSS1394_TAG_CHANGE_ADDRESS << 56) |
 			   scs->hss_handler.offset);
 	err = snd_fw_transaction(scs->unit, TCODE_WRITE_BLOCK_REQUEST,
-				 HSS1394_ADDRESS, &data, 8);
+				 HSS1394_ADDRESS, &data, 8, 0);
 	if (err < 0)
 		dev_err(&scs->unit->device, "HSS1394 communication failed\n");

@@ -455,12 +455,16 @@ err_card:
 static void scs_update(struct fw_unit *unit)
 {
 	struct scs *scs = dev_get_drvdata(&unit->device);
+	int generation;
 	__be64 data;

 	data = cpu_to_be64(((u64)HSS1394_TAG_CHANGE_ADDRESS << 56) |
 			   scs->hss_handler.offset);
+	generation = fw_parent_device(unit)->generation;
+	smp_rmb(); /* node_id vs. generation */
 	snd_fw_transaction(scs->unit, TCODE_WRITE_BLOCK_REQUEST,
-			   HSS1394_ADDRESS, &data, 8);
+			   HSS1394_ADDRESS, &data, 8,
+			   FW_FIXED_GENERATION | generation);
 }

 static void scs_remove(struct fw_unit *unit)
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 6a68caf..eb3f7dc 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -647,7 +647,7 @@ static u32 fwspk_read_firmware_version(struct fw_unit *unit)
 	int err;

 	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
-				 OXFORD_FIRMWARE_ID_ADDRESS, &data, 4);
+				 OXFORD_FIRMWARE_ID_ADDRESS, &data, 4, 0);
 	return err >= 0 ? be32_to_cpu(data) : 0;
 }


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
