From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/25] ALSA: firewire-digi00x: add support for
	MIDI ports for machine control
Date: Thu, 13 Aug 2015 09:20:12 +0900
Message-ID: <1439425221-30826-17-git-send-email-o-takashi@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CAC1261606
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 02:20:38 +0200 (CEST)
In-Reply-To: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, Damien Zammit <damien@zamaudio.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family uses asynchronous transactions for MIDI messages to
control the devices. The address to receive the messages is 0xffffe0000040.

This commit supports these MIDI ports.

Cc: Damien Zammit <damien@zamaudio.com>
Cc: Robin Gareus <robin@gareus.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-midi.c        | 65 ++++++++++++++++++++------
 sound/firewire/digi00x/digi00x-transaction.c | 70 +++++++++++++++++++++++++---
 sound/firewire/digi00x/digi00x.h             |  5 ++
 3 files changed, 118 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 241d93a..9051902 100644
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
 	dg00x->substreams_counter--;
 	snd_dg00x_stream_stop_duplex(dg00x);
@@ -63,6 +74,11 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 
+	if (substream->number == 0) {
+		snd_fw_async_midi_port_finish(&dg00x->out_control);
+		return 0;
+	}
+
 	mutex_lock(&dg00x->mutex);
 	dg00x->substreams_counter--;
 	snd_dg00x_stream_stop_duplex(dg00x);
@@ -79,12 +95,19 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
-	if (up)
-		amdtp_dot_midi_trigger(&dg00x->tx_stream,
-				       substrm->number - 1, substrm);
-	else
-		amdtp_dot_midi_trigger(&dg00x->tx_stream,
-				       substrm->number - 1, NULL);
+	if (substrm->number == 0) {
+		if (up)
+			dg00x->in_control = substrm;
+		else
+			dg00x->in_control = NULL;
+	} else {
+		if (up)
+			amdtp_dot_midi_trigger(&dg00x->tx_stream,
+					       substrm->number - 1, substrm);
+		else
+			amdtp_dot_midi_trigger(&dg00x->tx_stream,
+					       substrm->number - 1, NULL);
+	}
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
@@ -96,12 +119,18 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
-	if (up)
-		amdtp_dot_midi_trigger(&dg00x->rx_stream,
-				       substrm->number - 1, substrm);
-	else
-		amdtp_dot_midi_trigger(&dg00x->rx_stream,
-				       substrm->number - 1, NULL);
+	if (substrm->number == 0) {
+		if (up)
+			snd_fw_async_midi_port_run(&dg00x->out_control,
+						   substrm);
+	} else {
+		if (up)
+			amdtp_dot_midi_trigger(&dg00x->rx_stream,
+					       substrm->number - 1, substrm);
+		else
+			amdtp_dot_midi_trigger(&dg00x->rx_stream,
+					       substrm->number - 1, NULL);
+	}
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
@@ -124,9 +153,15 @@ static void set_midi_substream_names(struct snd_dg00x *dg00x,
 	struct snd_rawmidi_substream *subs;
 
 	list_for_each_entry(subs, &str->substreams, list) {
-		snprintf(subs->name, sizeof(subs->name),
-			 "%s MIDI %d",
-			 dg00x->card->shortname, subs->number);
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
 
diff --git a/sound/firewire/digi00x/digi00x-transaction.c b/sound/firewire/digi00x/digi00x-transaction.c
index 4568d98..5c66b17 100644
--- a/sound/firewire/digi00x/digi00x-transaction.c
+++ b/sound/firewire/digi00x/digi00x-transaction.c
@@ -9,6 +9,18 @@
 #include <sound/asound.h>
 #include "digi00x.h"
 
+static int packetize_message(struct snd_rawmidi_substream *substream, __u8 *buf)
+{
+	int bytes;
+
+	buf[0] = 0x80;
+	bytes = snd_rawmidi_transmit_peek(substream, buf + 1, 2);
+	if (bytes >= 0)
+		buf[3] = 0xc0 | bytes;
+
+	return bytes;
+}
+
 static void handle_unknown_message(struct snd_dg00x *dg00x,
 				   unsigned long long offset, u32 *buf)
 {
@@ -21,6 +33,28 @@ static void handle_unknown_message(struct snd_dg00x *dg00x,
 	wake_up(&dg00x->hwdep_wait);
 }
 
+static void handle_midi_control(struct snd_dg00x *dg00x, u32 *buf,
+				unsigned int length)
+{
+	struct snd_rawmidi_substream *substream;
+	unsigned int i;
+	unsigned int len;
+	u8 *b;
+
+	substream = ACCESS_ONCE(dg00x->in_control);
+	if (substream == NULL)
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
@@ -31,6 +65,8 @@ static void handle_message(struct fw_card *card, struct fw_request *request,
 
 	if (offset == dg00x->async_handler.offset)
 		handle_unknown_message(dg00x, offset, buf);
+	else if (offset == dg00x->async_handler.offset + 4)
+		handle_midi_control(dg00x, buf, length);
 
 	fw_send_response(card, request, RCODE_COMPLETE);
 }
@@ -39,14 +75,25 @@ int snd_dg00x_transaction_reregister(struct snd_dg00x *dg00x)
 {
 	struct fw_device *device = fw_parent_device(dg00x->unit);
 	__be32 data[2];
+	int err;
 
 	/* Unknown. 4bytes. */
 	data[0] = cpu_to_be32((device->card->node_id << 16) |
 			      (dg00x->async_handler.offset >> 32));
 	data[1] = cpu_to_be32(dg00x->async_handler.offset);
+	err = snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_MESSAGE_ADDR,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	/* Asynchronous transactions for MIDI control message. */
+	data[0] = cpu_to_be32((device->card->node_id << 16) |
+			      (dg00x->async_handler.offset >> 32));
+	data[1] = cpu_to_be32(dg00x->async_handler.offset + 4);
 	return snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
-				   DG00X_ADDR_BASE + DG00X_OFFSET_MESSAGE_ADDR,
-				   &data, sizeof(data), 0);
+				  DG00X_ADDR_BASE + DG00X_OFFSET_MIDI_CTL_ADDR,
+				  &data, sizeof(data), 0);
 }
 
 int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
@@ -57,7 +104,7 @@ int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
 	};
 	int err;
 
-	dg00x->async_handler.length = 4;
+	dg00x->async_handler.length = 12;
 	dg00x->async_handler.address_callback = handle_message;
 	dg00x->async_handler.callback_data = dg00x;
 
@@ -67,15 +114,24 @@ int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
 		return err;
 
 	err = snd_dg00x_transaction_reregister(dg00x);
-	if (err < 0) {
-		fw_core_remove_address_handler(&dg00x->async_handler);
-		dg00x->async_handler.address_callback = NULL;
-	}
+	if (err < 0)
+		goto error;
+
+	err = snd_fw_async_midi_port_init(&dg00x->out_control, dg00x->unit,
+					  DG00X_ADDR_BASE + DG00X_OFFSET_MMC,
+					  4, packetize_message);
+	if (err < 0)
+		goto error;
 
 	return err;
+error:
+	fw_core_remove_address_handler(&dg00x->async_handler);
+	dg00x->async_handler.address_callback = NULL;
+	return err;
 }
 
 void snd_dg00x_transaction_unregister(struct snd_dg00x *dg00x)
 {
+	snd_fw_async_midi_port_destroy(&dg00x->out_control);
 	fw_core_remove_address_handler(&dg00x->async_handler);
 }
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index bd759bf..9b54b5b 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -54,6 +54,11 @@ struct snd_dg00x {
 	/* For asynchronous messages. */
 	struct fw_address_handler async_handler;
 	u32 msg;
+
+	/* For asynchronous MIDI controls. */
+	struct tasklet_struct tasklet;
+	struct snd_rawmidi_substream *in_control;
+	struct snd_fw_async_midi_port out_control;
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
-- 
2.1.4
