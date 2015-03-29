From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/11] ALSA: digi00x: support MIDI ports for
	device control
Date: Mon, 30 Mar 2015 00:05:28 +0900
Message-ID: <1427641531-9047-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 722662606CF
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:45 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family uses asynchronous transactions for MIDI
device control message. The address to transfer is stored on
a certain address, while the address to receive is 0xffffe0000040.

This commit supports MIDI ports for this purpose. For capture
MIDI message, the handler of notification is extended. For playback
MIDI message, a workqueue is used because Linux FireWire subsystem
uses 'complete' to wait response event and this context needs to sleep,
thus tasklet is not better.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-midi.c     | 68 ++++++++++++++++++++------
 sound/firewire/digi00x/digi00x-protocol.c | 81 ++++++++++++++++++++++++++++++-
 sound/firewire/digi00x/digi00x.h          |  7 +++
 3 files changed, 138 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 460f8eb..adf31e2 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -13,6 +13,10 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 	int err;
 
+	/* This port is for Asynchronous transaction. */
+	if (substream->number == 0)
+		return 0;
+
 	err = snd_dg00x_stream_lock_try(dg00x);
 	if (err < 0)
 		return err;
@@ -32,6 +36,10 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 	int err;
 
+	/* This port is for Asynchronous transaction. */
+	if (substream->number == 0)
+		return 0;
+
 	err = snd_dg00x_stream_lock_try(dg00x);
 	if (err < 0)
 		return err;
@@ -50,6 +58,9 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 
+	if (substream->number == 0)
+		return 0;
+
 	mutex_lock(&dg00x->mutex);
 	dg00x->capture_substreams--;
 	snd_dg00x_stream_stop_duplex(dg00x);
@@ -63,6 +74,9 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 
+	if (substream->number == 0)
+		return 0;
+
 	mutex_lock(&dg00x->mutex);
 	dg00x->playback_substreams--;
 	snd_dg00x_stream_stop_duplex(dg00x);
@@ -79,12 +93,19 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
-	if (up)
-		amdtp_stream_midi_trigger(&dg00x->tx_stream,
-					  substrm->number, substrm);
-	else
-		amdtp_stream_midi_trigger(&dg00x->tx_stream,
-					  substrm->number, NULL);
+	if (substrm->number == 0) {
+		if (up)
+			dg00x->in_control = substrm;
+		else
+			dg00x->in_control = NULL;
+	} else {
+		if (up)
+			amdtp_stream_midi_trigger(&dg00x->tx_stream,
+						  substrm->number - 1, substrm);
+		else
+			amdtp_stream_midi_trigger(&dg00x->tx_stream,
+						  substrm->number - 1, NULL);
+	}
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
@@ -96,12 +117,21 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
-	if (up)
-		amdtp_stream_midi_trigger(&dg00x->rx_stream,
-					  substrm->number, substrm);
-	else
-		amdtp_stream_midi_trigger(&dg00x->rx_stream,
-					  substrm->number, NULL);
+	if (substrm->number == 0) {
+		if (up) {
+			dg00x->out_control = substrm;
+			snd_dg00x_protocol_queue_midi_message(dg00x);
+		} else {
+			dg00x->out_control = NULL;
+		}
+	} else {
+		if (up)
+			amdtp_stream_midi_trigger(&dg00x->rx_stream,
+						  substrm->number - 1, substrm);
+		else
+			amdtp_stream_midi_trigger(&dg00x->rx_stream,
+						  substrm->number - 1, NULL);
+	}
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
@@ -124,9 +154,15 @@ static void set_midi_substream_names(struct snd_dg00x *dg00x,
 	struct snd_rawmidi_substream *subs;
 
 	list_for_each_entry(subs, &str->substreams, list) {
-		snprintf(subs->name, sizeof(subs->name),
-			 "%s MIDI %d",
-			 dg00x->card->shortname, subs->number + 1);
+		/* This port is for device control. */
+		if (subs->number == 0) {
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s control", dg00x->card->shortname);
+		} else {
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s MIDI %d",
+				 dg00x->card->shortname, subs->number);
+		}
 	}
 }
 
@@ -137,7 +173,7 @@ int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
 	int err;
 
 	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, 0,
-			      1, 2, &rmidi);
+			      3, 2, &rmidi);
 	if (err < 0)
 		return err;
 
diff --git a/sound/firewire/digi00x/digi00x-protocol.c b/sound/firewire/digi00x/digi00x-protocol.c
index 72c942a..40aea36 100644
--- a/sound/firewire/digi00x/digi00x-protocol.c
+++ b/sound/firewire/digi00x/digi00x-protocol.c
@@ -8,6 +8,43 @@
 
 #include "digi00x.h"
 
+struct workqueue_struct *midi_wq;
+
+static void send_midi_control(struct work_struct *work)
+{
+	struct snd_dg00x *dg00x =
+			container_of(work, struct snd_dg00x, midi_control);
+	struct fw_device *device = fw_parent_device(dg00x->unit);
+
+	unsigned int len;
+	__be32 buf = 0;
+	u8 *b = (u8 *)&buf;
+
+	/* Send MIDI control. */
+	if (!dg00x->out_control)
+		return;
+
+	do {
+		len = snd_rawmidi_transmit(dg00x->out_control, b + 1, 2);
+		if (len > 0) {
+			b[0] = 0x80;
+			b[3] = 0xc0 | len;
+
+			/* Don't check transaction status. */
+			fw_run_transaction(device->card,
+					   TCODE_WRITE_QUADLET_REQUEST,
+					   device->node_id, device->generation,
+					   device->max_speed,
+					   0xffffe0000400, &buf, sizeof(buf));
+		}
+	} while (len > 0);
+}
+
+void snd_dg00x_protocol_queue_midi_message(struct snd_dg00x *dg00x)
+{
+	queue_work(midi_wq, &dg00x->midi_control);
+}
+
 static struct snd_dg00x *instances[SNDRV_CARDS];
 static DEFINE_SPINLOCK(instances_lock);
 
@@ -29,6 +66,26 @@ static void handle_unknown_message(struct snd_dg00x *dg00x,
 	wake_up(&dg00x->hwdep_wait);
 }
 
+static void handle_midi_control(struct snd_dg00x *dg00x, u32 *buf,
+				unsigned int length)
+{
+	unsigned int i;
+	unsigned int len;
+	u8 *b;
+
+	if (dg00x->in_control == NULL)
+		return;
+
+	length /= 4;
+
+	for (i = 0; i < length; i++) {
+		b = (u8 *)&buf[i];
+		len = b[3] & 0xf;
+		if (len > 0)
+			snd_rawmidi_receive(dg00x->in_control, b + 1, len);
+	}
+}
+
 static void handle_message(struct fw_card *card, struct fw_request *request,
 			   int tcode, int destination, int source,
 			   int generation, unsigned long long offset,
@@ -79,6 +136,16 @@ int snd_dg00x_protocol_add_instance(struct snd_dg00x *dg00x)
 	if (err < 0)
 		return err;
 
+	/* Asynchronous transactions for MIDI control message. */
+	data[0] = cpu_to_be32((device->card->node_id << 16) |
+			      (async_handler.offset >> 32));
+	data[1] = cpu_to_be32(async_handler.offset + 4);
+	err = snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_MIDI_CTL_ADDR,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
 	spin_lock_irq(&instances_lock);
 	for (i = 0; i < SNDRV_CARDS; i++) {
 		if (instances[i] != NULL)
@@ -88,6 +155,8 @@ int snd_dg00x_protocol_add_instance(struct snd_dg00x *dg00x)
 	}
 	spin_unlock_irq(&instances_lock);
 
+	INIT_WORK(&dg00x->midi_control, send_midi_control);
+
 	return 0;
 }
 
@@ -113,19 +182,27 @@ int snd_dg00x_protocol_register(void)
 	};
 	int err;
 
-	async_handler.length = 4;
+	midi_wq = alloc_workqueue("snd-digi00x",
+				  WQ_SYSFS | WQ_POWER_EFFICIENT, 0);
+	if (midi_wq == NULL)
+		return -ENOMEM;
+
+	async_handler.length = 12;
 	async_handler.address_callback = handle_message;
 	async_handler.callback_data = NULL;
 
 	err = fw_core_add_address_handler(&async_handler,
 					  &resp_register_region);
-	if (err < 0)
+	if (err < 0) {
+		destroy_workqueue(midi_wq);
 		return err;
+	}
 
 	return 0;
 }
 
 void snd_dg00x_protocol_unregister(void)
 {
+	destroy_workqueue(midi_wq);
 	fw_core_remove_address_handler(&async_handler);
 }
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 4e3d359..d534f90 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -56,6 +57,11 @@ struct snd_dg00x {
 
 	/* For asynchronous messages. */
 	u32 msg;
+
+	/* For asynchronous MIDI controls. */
+	struct work_struct midi_control;
+	struct snd_rawmidi_substream *in_control;
+	struct snd_rawmidi_substream *out_control;
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
@@ -106,6 +112,7 @@ enum snd_dg00x_optical_mode {
 	SND_DG00X_OPT_IFACE_MODE_COUNT,
 };
 
+void snd_dg00x_protocol_queue_midi_message(struct snd_dg00x *dg00x);
 int snd_dg00x_protocol_add_instance(struct snd_dg00x *dg00x);
 void snd_dg00x_protocol_remove_instance(struct snd_dg00x *dg00x);
 int snd_dg00x_protocol_register(void);
-- 
2.1.0
