From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/13] ALSA: dice: Rename structure and its
	members
Date: Mon, 29 Sep 2014 00:58:11 +0900
Message-ID: <1411919903-10981-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id AE478260587
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 17:58:43 +0200 (CEST)
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

Currently, dice driver supports AMDTP out-stream. In followed commits, AMDTP
in-stream will be supported but current name of members in dice structure
are not propper. This commit renames these members to proper name.

Additionally, for easily distinguishing local symbols from structure tag,
rename dice tag into snd_dice.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice.c | 162 +++++++++++++++++++++++++-------------------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index e3a04d6..c7c8495 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -32,7 +32,7 @@
 #include "dice-interface.h"
 
 
-struct dice {
+struct snd_dice {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	spinlock_t lock;
@@ -50,8 +50,8 @@ struct dice {
 	struct completion clock_accepted;
 	wait_queue_head_t hwdep_wait;
 	u32 notification_bits;
-	struct fw_iso_resources resources;
-	struct amdtp_stream stream;
+	struct fw_iso_resources rx_resources;
+	struct amdtp_stream rx_stream;
 };
 
 MODULE_DESCRIPTION("DICE driver");
@@ -87,13 +87,13 @@ static unsigned int rate_index_to_mode(unsigned int rate_index)
 	return ((int)rate_index - 1) / 2;
 }
 
-static void dice_lock_changed(struct dice *dice)
+static void dice_lock_changed(struct snd_dice *dice)
 {
 	dice->dev_lock_changed = true;
 	wake_up(&dice->hwdep_wait);
 }
 
-static int dice_try_lock(struct dice *dice)
+static int dice_try_lock(struct snd_dice *dice)
 {
 	int err;
 
@@ -114,7 +114,7 @@ out:
 	return err;
 }
 
-static void dice_unlock(struct dice *dice)
+static void dice_unlock(struct snd_dice *dice)
 {
 	spin_lock_irq(&dice->lock);
 
@@ -128,18 +128,18 @@ out:
 	spin_unlock_irq(&dice->lock);
 }
 
-static inline u64 global_address(struct dice *dice, unsigned int offset)
+static inline u64 global_address(struct snd_dice *dice, unsigned int offset)
 {
 	return DICE_PRIVATE_SPACE + dice->global_offset + offset;
 }
 
 // TODO: rx index
-static inline u64 rx_address(struct dice *dice, unsigned int offset)
+static inline u64 rx_address(struct snd_dice *dice, unsigned int offset)
 {
 	return DICE_PRIVATE_SPACE + dice->rx_offset + offset;
 }
 
-static int dice_owner_set(struct dice *dice)
+static int dice_owner_set(struct snd_dice *dice)
 {
 	struct fw_device *device = fw_parent_device(dice->unit);
 	__be64 *buffer;
@@ -183,7 +183,7 @@ static int dice_owner_set(struct dice *dice)
 	return err;
 }
 
-static int dice_owner_update(struct dice *dice)
+static int dice_owner_update(struct snd_dice *dice)
 {
 	struct fw_device *device = fw_parent_device(dice->unit);
 	__be64 *buffer;
@@ -226,7 +226,7 @@ static int dice_owner_update(struct dice *dice)
 	return err;
 }
 
-static void dice_owner_clear(struct dice *dice)
+static void dice_owner_clear(struct snd_dice *dice)
 {
 	struct fw_device *device = fw_parent_device(dice->unit);
 	__be64 *buffer;
@@ -249,7 +249,7 @@ static void dice_owner_clear(struct dice *dice)
 	dice->owner_generation = -1;
 }
 
-static int dice_enable_set(struct dice *dice)
+static int dice_enable_set(struct snd_dice *dice)
 {
 	__be32 value;
 	int err;
@@ -267,7 +267,7 @@ static int dice_enable_set(struct dice *dice)
 	return 0;
 }
 
-static void dice_enable_clear(struct dice *dice)
+static void dice_enable_clear(struct snd_dice *dice)
 {
 	__be32 value;
 
@@ -288,7 +288,7 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 			      int generation, unsigned long long offset,
 			      void *data, size_t length, void *callback_data)
 {
-	struct dice *dice = callback_data;
+	struct snd_dice *dice = callback_data;
 	u32 bits;
 	unsigned long flags;
 
@@ -317,7 +317,7 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 static int dice_rate_constraint(struct snd_pcm_hw_params *params,
 				struct snd_pcm_hw_rule *rule)
 {
-	struct dice *dice = rule->private;
+	struct snd_dice *dice = rule->private;
 	const struct snd_interval *channels =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_interval *rate =
@@ -344,7 +344,7 @@ static int dice_rate_constraint(struct snd_pcm_hw_params *params,
 static int dice_channels_constraint(struct snd_pcm_hw_params *params,
 				    struct snd_pcm_hw_rule *rule)
 {
-	struct dice *dice = rule->private;
+	struct snd_dice *dice = rule->private;
 	const struct snd_interval *rate =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels =
@@ -384,7 +384,7 @@ static int dice_open(struct snd_pcm_substream *substream)
 		.periods_min = 1,
 		.periods_max = UINT_MAX,
 	};
-	struct dice *dice = substream->private_data;
+	struct snd_dice *dice = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int i;
 	int err;
@@ -420,7 +420,7 @@ static int dice_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto err_lock;
 
-	err = amdtp_stream_add_pcm_hw_constraints(&dice->stream, runtime);
+	err = amdtp_stream_add_pcm_hw_constraints(&dice->rx_stream, runtime);
 	if (err < 0)
 		goto err_lock;
 
@@ -434,47 +434,47 @@ error:
 
 static int dice_close(struct snd_pcm_substream *substream)
 {
-	struct dice *dice = substream->private_data;
+	struct snd_dice *dice = substream->private_data;
 
 	dice_unlock(dice);
 
 	return 0;
 }
 
-static int dice_stream_start_packets(struct dice *dice)
+static int dice_stream_start_packets(struct snd_dice *dice)
 {
 	int err;
 
-	if (amdtp_stream_running(&dice->stream))
+	if (amdtp_stream_running(&dice->rx_stream))
 		return 0;
 
-	err = amdtp_stream_start(&dice->stream, dice->resources.channel,
+	err = amdtp_stream_start(&dice->rx_stream, dice->rx_resources.channel,
 				 fw_parent_device(dice->unit)->max_speed);
 	if (err < 0)
 		return err;
 
 	err = dice_enable_set(dice);
 	if (err < 0) {
-		amdtp_stream_stop(&dice->stream);
+		amdtp_stream_stop(&dice->rx_stream);
 		return err;
 	}
 
 	return 0;
 }
 
-static int dice_stream_start(struct dice *dice)
+static int dice_stream_start(struct snd_dice *dice)
 {
 	__be32 channel;
 	int err;
 
-	if (!dice->resources.allocated) {
-		err = fw_iso_resources_allocate(&dice->resources,
-				amdtp_stream_get_max_payload(&dice->stream),
+	if (!dice->rx_resources.allocated) {
+		err = fw_iso_resources_allocate(&dice->rx_resources,
+				amdtp_stream_get_max_payload(&dice->rx_stream),
 				fw_parent_device(dice->unit)->max_speed);
 		if (err < 0)
 			goto error;
 
-		channel = cpu_to_be32(dice->resources.channel);
+		channel = cpu_to_be32(dice->rx_resources.channel);
 		err = snd_fw_transaction(dice->unit,
 					 TCODE_WRITE_QUADLET_REQUEST,
 					 rx_address(dice, RX_ISOCHRONOUS),
@@ -494,36 +494,36 @@ err_rx_channel:
 	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
 			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4, 0);
 err_resources:
-	fw_iso_resources_free(&dice->resources);
+	fw_iso_resources_free(&dice->rx_resources);
 error:
 	return err;
 }
 
-static void dice_stream_stop_packets(struct dice *dice)
+static void dice_stream_stop_packets(struct snd_dice *dice)
 {
-	if (amdtp_stream_running(&dice->stream)) {
+	if (amdtp_stream_running(&dice->rx_stream)) {
 		dice_enable_clear(dice);
-		amdtp_stream_stop(&dice->stream);
+		amdtp_stream_stop(&dice->rx_stream);
 	}
 }
 
-static void dice_stream_stop(struct dice *dice)
+static void dice_stream_stop(struct snd_dice *dice)
 {
 	__be32 channel;
 
 	dice_stream_stop_packets(dice);
 
-	if (!dice->resources.allocated)
+	if (!dice->rx_resources.allocated)
 		return;
 
 	channel = cpu_to_be32((u32)-1);
 	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
 			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4, 0);
 
-	fw_iso_resources_free(&dice->resources);
+	fw_iso_resources_free(&dice->rx_resources);
 }
 
-static int dice_change_rate(struct dice *dice, unsigned int clock_rate)
+static int dice_change_rate(struct snd_dice *dice, unsigned int clock_rate)
 {
 	__be32 value;
 	int err;
@@ -547,7 +547,7 @@ static int dice_change_rate(struct dice *dice, unsigned int clock_rate)
 static int dice_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *hw_params)
 {
-	struct dice *dice = substream->private_data;
+	struct snd_dice *dice = substream->private_data;
 	unsigned int rate_index, mode, rate, channels, i;
 	int err;
 
@@ -585,24 +585,24 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 
 		rate /= 2;
 		channels *= 2;
-		dice->stream.double_pcm_frames = true;
+		dice->rx_stream.double_pcm_frames = true;
 	} else {
-		dice->stream.double_pcm_frames = false;
+		dice->rx_stream.double_pcm_frames = false;
 	}
 
 	mode = rate_index_to_mode(rate_index);
-	amdtp_stream_set_parameters(&dice->stream, rate, channels,
+	amdtp_stream_set_parameters(&dice->rx_stream, rate, channels,
 				    dice->rx_midi_ports[mode]);
 	if (rate_index > 4) {
 		channels /= 2;
 
 		for (i = 0; i < channels; i++) {
-			dice->stream.pcm_positions[i] = i * 2;
-			dice->stream.pcm_positions[i + channels] = i * 2 + 1;
+			dice->rx_stream.pcm_positions[i] = i * 2;
+			dice->rx_stream.pcm_positions[i + channels] = i * 2 + 1;
 		}
 	}
 
-	amdtp_stream_set_pcm_format(&dice->stream,
+	amdtp_stream_set_pcm_format(&dice->rx_stream,
 				    params_format(hw_params));
 
 	return 0;
@@ -610,7 +610,7 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 
 static int dice_hw_free(struct snd_pcm_substream *substream)
 {
-	struct dice *dice = substream->private_data;
+	struct snd_dice *dice = substream->private_data;
 
 	mutex_lock(&dice->mutex);
 	dice_stream_stop(dice);
@@ -621,12 +621,12 @@ static int dice_hw_free(struct snd_pcm_substream *substream)
 
 static int dice_prepare(struct snd_pcm_substream *substream)
 {
-	struct dice *dice = substream->private_data;
+	struct snd_dice *dice = substream->private_data;
 	int err;
 
 	mutex_lock(&dice->mutex);
 
-	if (amdtp_streaming_error(&dice->stream))
+	if (amdtp_streaming_error(&dice->rx_stream))
 		dice_stream_stop_packets(dice);
 
 	err = dice_stream_start(dice);
@@ -637,14 +637,14 @@ static int dice_prepare(struct snd_pcm_substream *substream)
 
 	mutex_unlock(&dice->mutex);
 
-	amdtp_stream_pcm_prepare(&dice->stream);
+	amdtp_stream_pcm_prepare(&dice->rx_stream);
 
 	return 0;
 }
 
 static int dice_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct dice *dice = substream->private_data;
+	struct snd_dice *dice = substream->private_data;
 	struct snd_pcm_substream *pcm;
 
 	switch (cmd) {
@@ -657,19 +657,19 @@ static int dice_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		return -EINVAL;
 	}
-	amdtp_stream_pcm_trigger(&dice->stream, pcm);
+	amdtp_stream_pcm_trigger(&dice->rx_stream, pcm);
 
 	return 0;
 }
 
 static snd_pcm_uframes_t dice_pointer(struct snd_pcm_substream *substream)
 {
-	struct dice *dice = substream->private_data;
+	struct snd_dice *dice = substream->private_data;
 
-	return amdtp_stream_pcm_pointer(&dice->stream);
+	return amdtp_stream_pcm_pointer(&dice->rx_stream);
 }
 
-static int dice_create_pcm(struct dice *dice)
+static int dice_create_pcm(struct snd_dice *dice)
 {
 	static struct snd_pcm_ops ops = {
 		.open      = dice_open,
@@ -699,7 +699,7 @@ static int dice_create_pcm(struct dice *dice)
 static long dice_hwdep_read(struct snd_hwdep *hwdep, char __user *buf,
 			    long count, loff_t *offset)
 {
-	struct dice *dice = hwdep->private_data;
+	struct snd_dice *dice = hwdep->private_data;
 	DEFINE_WAIT(wait);
 	union snd_firewire_event event;
 
@@ -741,7 +741,7 @@ static long dice_hwdep_read(struct snd_hwdep *hwdep, char __user *buf,
 static unsigned int dice_hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
 				    poll_table *wait)
 {
-	struct dice *dice = hwdep->private_data;
+	struct snd_dice *dice = hwdep->private_data;
 	unsigned int events;
 
 	poll_wait(file, &dice->hwdep_wait, wait);
@@ -756,7 +756,7 @@ static unsigned int dice_hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
 	return events;
 }
 
-static int dice_hwdep_get_info(struct dice *dice, void __user *arg)
+static int dice_hwdep_get_info(struct snd_dice *dice, void __user *arg)
 {
 	struct fw_device *dev = fw_parent_device(dice->unit);
 	struct snd_firewire_get_info info;
@@ -775,7 +775,7 @@ static int dice_hwdep_get_info(struct dice *dice, void __user *arg)
 	return 0;
 }
 
-static int dice_hwdep_lock(struct dice *dice)
+static int dice_hwdep_lock(struct snd_dice *dice)
 {
 	int err;
 
@@ -793,7 +793,7 @@ static int dice_hwdep_lock(struct dice *dice)
 	return err;
 }
 
-static int dice_hwdep_unlock(struct dice *dice)
+static int dice_hwdep_unlock(struct snd_dice *dice)
 {
 	int err;
 
@@ -813,7 +813,7 @@ static int dice_hwdep_unlock(struct dice *dice)
 
 static int dice_hwdep_release(struct snd_hwdep *hwdep, struct file *file)
 {
-	struct dice *dice = hwdep->private_data;
+	struct snd_dice *dice = hwdep->private_data;
 
 	spin_lock_irq(&dice->lock);
 	if (dice->dev_lock_count == -1)
@@ -826,7 +826,7 @@ static int dice_hwdep_release(struct snd_hwdep *hwdep, struct file *file)
 static int dice_hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
 			    unsigned int cmd, unsigned long arg)
 {
-	struct dice *dice = hwdep->private_data;
+	struct snd_dice *dice = hwdep->private_data;
 
 	switch (cmd) {
 	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
@@ -851,7 +851,7 @@ static int dice_hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
 #define dice_hwdep_compat_ioctl NULL
 #endif
 
-static int dice_create_hwdep(struct dice *dice)
+static int dice_create_hwdep(struct snd_dice *dice)
 {
 	static const struct snd_hwdep_ops ops = {
 		.read         = dice_hwdep_read,
@@ -875,7 +875,7 @@ static int dice_create_hwdep(struct dice *dice)
 	return 0;
 }
 
-static int dice_proc_read_mem(struct dice *dice, void *buffer,
+static int dice_proc_read_mem(struct snd_dice *dice, void *buffer,
 			      unsigned int offset_q, unsigned int quadlets)
 {
 	unsigned int i;
@@ -898,8 +898,8 @@ static const char *str_from_array(const char *const strs[], unsigned int count,
 {
 	if (i < count)
 		return strs[i];
-	else
-		return "(unknown)";
+
+	return "(unknown)";
 }
 
 static void dice_proc_fixup_string(char *s, unsigned int size)
@@ -934,7 +934,7 @@ static void dice_proc_read(struct snd_info_entry *entry,
 		"32000", "44100", "48000", "88200", "96000", "176400", "192000",
 		"any low", "any mid", "any high", "none"
 	};
-	struct dice *dice = entry->private_data;
+	struct snd_dice *dice = entry->private_data;
 	u32 sections[ARRAY_SIZE(section_names) * 2];
 	struct {
 		u32 number;
@@ -1109,7 +1109,7 @@ static void dice_proc_read(struct snd_info_entry *entry,
 	}
 }
 
-static void dice_create_proc(struct dice *dice)
+static void dice_create_proc(struct snd_dice *dice)
 {
 	struct snd_info_entry *entry;
 
@@ -1119,9 +1119,9 @@ static void dice_create_proc(struct dice *dice)
 
 static void dice_card_free(struct snd_card *card)
 {
-	struct dice *dice = card->private_data;
+	struct snd_dice *dice = card->private_data;
 
-	amdtp_stream_destroy(&dice->stream);
+	amdtp_stream_destroy(&dice->rx_stream);
 	fw_core_remove_address_handler(&dice->notification_handler);
 	mutex_destroy(&dice->mutex);
 }
@@ -1216,7 +1216,7 @@ static int dice_interface_check(struct fw_unit *unit)
 	return 0;
 }
 
-static int highest_supported_mode_rate(struct dice *dice, unsigned int mode)
+static int highest_supported_mode_rate(struct snd_dice *dice, unsigned int mode)
 {
 	int i;
 
@@ -1228,7 +1228,7 @@ static int highest_supported_mode_rate(struct dice *dice, unsigned int mode)
 	return -1;
 }
 
-static int dice_read_mode_params(struct dice *dice, unsigned int mode)
+static int dice_read_mode_params(struct snd_dice *dice, unsigned int mode)
 {
 	__be32 values[2];
 	int rate_index, err;
@@ -1256,7 +1256,7 @@ static int dice_read_mode_params(struct dice *dice, unsigned int mode)
 	return 0;
 }
 
-static int dice_read_params(struct dice *dice)
+static int dice_read_params(struct snd_dice *dice)
 {
 	__be32 pointers[6];
 	__be32 value;
@@ -1297,7 +1297,7 @@ static int dice_read_params(struct dice *dice)
 	return 0;
 }
 
-static void dice_card_strings(struct dice *dice)
+static void dice_card_strings(struct snd_dice *dice)
 {
 	struct snd_card *card = dice->card;
 	struct fw_device *dev = fw_parent_device(dice->unit);
@@ -1335,7 +1335,7 @@ static void dice_card_strings(struct dice *dice)
 static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 {
 	struct snd_card *card;
-	struct dice *dice;
+	struct snd_dice *dice;
 	__be32 clock_sel;
 	int err;
 
@@ -1372,12 +1372,12 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto err_owner;
 
-	err = fw_iso_resources_init(&dice->resources, unit);
+	err = fw_iso_resources_init(&dice->rx_resources, unit);
 	if (err < 0)
 		goto err_owner;
-	dice->resources.channels_mask = 0x00000000ffffffffuLL;
+	dice->rx_resources.channels_mask = 0x00000000ffffffffuLL;
 
-	err = amdtp_stream_init(&dice->stream, unit, AMDTP_OUT_STREAM,
+	err = amdtp_stream_init(&dice->rx_stream, unit, AMDTP_OUT_STREAM,
 				CIP_BLOCKING);
 	if (err < 0)
 		goto err_resources;
@@ -1418,7 +1418,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	return 0;
 
 err_resources:
-	fw_iso_resources_destroy(&dice->resources);
+	fw_iso_resources_destroy(&dice->rx_resources);
 err_owner:
 	dice_owner_clear(dice);
 err_notification_handler:
@@ -1432,9 +1432,9 @@ error:
 
 static void dice_remove(struct fw_unit *unit)
 {
-	struct dice *dice = dev_get_drvdata(&unit->device);
+	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
-	amdtp_stream_pcm_abort(&dice->stream);
+	amdtp_stream_pcm_abort(&dice->rx_stream);
 
 	snd_card_disconnect(dice->card);
 
@@ -1450,7 +1450,7 @@ static void dice_remove(struct fw_unit *unit)
 
 static void dice_bus_reset(struct fw_unit *unit)
 {
-	struct dice *dice = dev_get_drvdata(&unit->device);
+	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
 	/*
 	 * On a bus reset, the DICE firmware disables streaming and then goes
@@ -1460,7 +1460,7 @@ static void dice_bus_reset(struct fw_unit *unit)
 	 * to stop so that the application can restart them in an orderly
 	 * manner.
 	 */
-	amdtp_stream_pcm_abort(&dice->stream);
+	amdtp_stream_pcm_abort(&dice->rx_stream);
 
 	mutex_lock(&dice->mutex);
 
@@ -1469,7 +1469,7 @@ static void dice_bus_reset(struct fw_unit *unit)
 
 	dice_owner_update(dice);
 
-	fw_iso_resources_update(&dice->resources);
+	fw_iso_resources_update(&dice->rx_resources);
 
 	mutex_unlock(&dice->mutex);
 }
-- 
1.9.1
