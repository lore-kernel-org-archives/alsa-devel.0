From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 23/25] ALSA: firewire-tascam: add transaction
	functionality
Date: Thu, 13 Aug 2015 09:20:19 +0900
Message-ID: <1439425221-30826-24-git-send-email-o-takashi@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id EE4CE2615C0
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 02:20:37 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

TASCAM FireWire series use asynchronous transaction for transmittion of
MIDI messages.

The messages in the transferred transaction include quirks:
 * Several MIDI messages are transferred in one block transaction, up to 8.
 * Two quadlets are used for one MIDI message and one timestamp.
 * A quadlet includes bytes up to 3, the first byte is used to indicate
   MIDI port and MSB 4 bit of MIDI status.

The messages in the received transaction includes quirks:
 * One MIDI message is transferred in one quadlet transaction.
 * MIDI running status is not allowed, thus transactions always include
   status byte.
 * The protocol for MIDI exclusive message is not clear. Therefore,
   this commit drop the message.

This commit supports the transmittion.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/Makefile             |   2 +-
 sound/firewire/tascam/tascam-transaction.c | 291 +++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.c             |   7 +
 sound/firewire/tascam/tascam.h             |  25 +++
 4 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/tascam/tascam-transaction.c

diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
index 84391ac..1f39e02 100644
--- a/sound/firewire/tascam/Makefile
+++ b/sound/firewire/tascam/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-tascam-objs := tascam-proc.o amdtp-tascam.o tascam-stream.o \
-			    tascam-pcm.o tascam.o
+			    tascam-pcm.o tascam-transaction.o tascam.o
 obj-m += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
new file mode 100644
index 0000000..084d7d9
--- /dev/null
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -0,0 +1,291 @@
+/*
+ * tascam-transaction.c - a part of driver for TASCAM FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "tascam.h"
+
+/*
+ * When return minus value, given argument is not MIDI status.
+ * When return 0, given argument is a beginning of system exclusive.
+ * When return the others, given argument is MIDI data.
+ */
+static inline int calculate_message_bytes(u8 status)
+{
+	switch (status) {
+	case 0xf6:	/* Tune request. */
+	case 0xf8:	/* Timing clock. */
+	case 0xfa:	/* Start. */
+	case 0xfb:	/* Continue. */
+	case 0xfc:	/* Stop. */
+	case 0xfe:	/* Active sensing. */
+	case 0xff:	/* System reset. */
+		return 1;
+	case 0xf1:	/* MIDI time code quarter frame. */
+	case 0xf3:	/* Song select. */
+		return 2;
+	case 0xf2:	/* Song position pointer. */
+		return 3;
+	case 0xf0:	/* Exclusive. */
+		return 0;
+	case 0xf7:	/* End of exclusive. */
+		break;
+	case 0xf4:	/* Undefined. */
+	case 0xf5:	/* Undefined. */
+	case 0xf9:	/* Undefined. */
+	case 0xfd:	/* Undefined. */
+		break;
+	default:
+		switch (status & 0xf0) {
+		case 0x80:	/* Note on. */
+		case 0x90:	/* Note off. */
+		case 0xa0:	/* Polyphonic key pressure. */
+		case 0xb0:	/* Control change and Mode change. */
+		case 0xe0:	/* Pitch bend change. */
+			return 3;
+		case 0xc0:	/* Program change. */
+		case 0xd0:	/* Channel pressure. */
+			return 2;
+		default:
+		break;
+		}
+	break;
+	}
+
+	return -EINVAL;
+}
+
+static int packetize_message(struct snd_rawmidi_substream *substream, __u8 *buf)
+{
+	struct snd_tscm *tscm = substream->rmidi->private_data;
+	unsigned int port = substream->number;
+	unsigned int len;
+	unsigned int i;
+	u8 status;
+	int consume;
+
+	buf[0] = buf[1] = buf[2] = buf[3] = 0x00;
+
+	len = snd_rawmidi_transmit_peek(substream, buf + 1, 3);
+	if (len == 0)
+		return 0;
+
+	/* On exclusive message. */
+	if (tscm->on_sysex[port] > 0) {
+		/* Seek the end of exclusives. */
+		for (i = 1; i < 4; ++i) {
+			if (buf[i] == 0xf7) {
+				tscm->on_sysex[port] = 0;
+				break;
+			}
+		}
+		if (i == 4)
+			i = 3;
+		/* Currently, the exclusives are not supported. */
+		snd_rawmidi_transmit_ack(substream, i);
+		return 0;
+	} else {
+		/* The beginning of exclusives. */
+		if (buf[1] == 0xf0) {
+			/* Currently, the exclusives are not supported. */
+			snd_rawmidi_transmit_ack(substream, 1);
+			tscm->on_sysex[port] = 1;
+			return 0;
+		} else {
+			/* On running-status. */
+			if ((buf[1] & 0x80) != 0x80)
+				status = tscm->running_status[port];
+			else
+				status = buf[1];
+
+			/* Calculate consume bytes. */
+			consume = calculate_message_bytes(status);
+			if (consume <= 0)
+				return 0;
+
+			/* On running-status. */
+			if ((buf[1] & 0x80) != 0x80) {
+				buf[3] = buf[2];
+				buf[2] = buf[1];
+				buf[1] = tscm->running_status[port];
+				consume--;
+			} else {
+				tscm->running_status[port] = buf[1];
+			}
+
+			/* Confirm length. */
+			if (len < consume)
+				return 0;
+			if (len > consume)
+				len = consume;
+		}
+	}
+
+	buf[0] = (port << 4) | (buf[1] >> 4);
+
+	return len;
+}
+
+static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
+			   int tcode, int destination, int source,
+			   int generation, unsigned long long offset,
+			   void *data, size_t length, void *callback_data)
+{
+	struct snd_tscm *tscm = callback_data;
+	__u32 *buf = (__u32 *)data;
+	unsigned int messages;
+	unsigned int i;
+	unsigned int port;
+	struct snd_rawmidi_substream *substream;
+	__u8 *b;
+	int bytes;
+
+	if (offset != tscm->async_handler.offset)
+		goto end;
+
+	messages = length / 8;
+	for (i = 0; i < messages; i++) {
+		b = (__u8 *)(buf + i * 2);
+
+		port = b[0] >> 4;
+		if (port >= tscm->spec->midi_capture_ports) {
+			/* 0x5 = VP1, 0x6 = VP2. */
+			port = tscm->spec->midi_capture_ports + port - 5;
+			if (port >= TSCM_MIDI_IN_PORT_MAX)
+				goto end;
+		}
+
+		/* Assume the message length. */
+		bytes = calculate_message_bytes(b[1]);
+		/* On MIDI data or exclusives. */
+		if (bytes <= 0) {
+			/* Seek the end of exclusives. */
+			for (bytes = 1; bytes < 4; bytes++) {
+				if (b[bytes] == 0xf7)
+					break;
+			}
+			if (bytes == 4)
+				bytes = 3;
+		}
+
+		substream = ACCESS_ONCE(tscm->tx_midi_substreams[port]);
+		if (substream != NULL)
+			snd_rawmidi_receive(substream, b + 1, bytes);
+	}
+end:
+	fw_send_response(card, request, RCODE_COMPLETE);
+}
+
+int snd_tscm_transaction_register(struct snd_tscm *tscm)
+{
+	static const struct fw_address_region resp_register_region = {
+		.start	= 0xffffe0000000ull,
+		.end	= 0xffffe000ffffull,
+	};
+	unsigned int i;
+	int err;
+
+	/*
+	 * Usually, two quadlets are transferred by one transaction. The first
+	 * quadlet has MIDI messages, the rest includes timestamp.
+	 * Sometimes, 8 set of the data is transferred by a block transaction.
+	 */
+	tscm->async_handler.length = 8 * 8;
+	tscm->async_handler.address_callback = handle_midi_tx;
+	tscm->async_handler.callback_data = tscm;
+
+	err = fw_core_add_address_handler(&tscm->async_handler,
+					  &resp_register_region);
+	if (err < 0)
+		return err;
+
+	err = snd_tscm_transaction_reregister(tscm);
+	if (err < 0) {
+		fw_core_remove_address_handler(&tscm->async_handler);
+		return err;
+	}
+
+	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++) {
+		err = snd_fw_async_midi_port_init(
+				&tscm->out_ports[i], tscm->unit,
+				TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_RX_QUAD,
+				4, packetize_message);
+		if (err < 0)
+			break;
+	}
+
+	return err;
+}
+
+/* At bus reset, these registers are cleared. */
+int snd_tscm_transaction_reregister(struct snd_tscm *tscm)
+{
+	struct fw_device *device = fw_parent_device(tscm->unit);
+	__be32 reg;
+	int err;
+
+	/* Register messaging address. Block transaction is not allowed. */
+	reg = cpu_to_be32((device->card->node_id << 16) |
+			  (tscm->async_handler.offset >> 32));
+	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ADDR_HI,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	reg = cpu_to_be32(tscm->async_handler.offset);
+	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ADDR_LO,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	/* Turn on messaging. */
+	reg = cpu_to_be32(0x00000001);
+	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ON,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	/* Turn on FireWire LED. */
+	reg = cpu_to_be32(0x0001008e);
+	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 TSCM_ADDR_BASE + TSCM_OFFSET_LED_TURN_ON,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	reg = cpu_to_be32(0x000100f2);
+	return snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  TSCM_ADDR_BASE + TSCM_OFFSET_LED_TURN_ON,
+				  &reg, sizeof(reg), 0);
+}
+
+void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
+{
+	unsigned int i;
+	__be32 reg;
+
+	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++)
+		snd_fw_async_midi_port_destroy(&tscm->out_ports[i]);
+
+	fw_core_remove_address_handler(&tscm->async_handler);
+
+	/* Turn off messaging. */
+	reg = cpu_to_be32(0x00000000);
+	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ON,
+			   &reg, sizeof(reg), 0);
+
+	/* Unregister the address. */
+	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ADDR_HI,
+			   &reg, sizeof(reg), 0);
+	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ADDR_LO,
+			   &reg, sizeof(reg), 0);
+}
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 18a7e70..5e770e5 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -93,6 +93,7 @@ static void tscm_card_free(struct snd_card *card)
 {
 	struct snd_tscm *tscm = card->private_data;
 
+	snd_tscm_transaction_unregister(tscm);
 	snd_tscm_stream_destroy_duplex(tscm);
 
 	fw_unit_put(tscm->unit);
@@ -135,6 +136,10 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_tscm_transaction_register(tscm);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
@@ -151,6 +156,8 @@ static void snd_tscm_update(struct fw_unit *unit)
 {
 	struct snd_tscm *tscm = dev_get_drvdata(&unit->device);
 
+	snd_tscm_transaction_reregister(tscm);
+
 	mutex_lock(&tscm->mutex);
 	snd_tscm_stream_update_duplex(tscm);
 	mutex_unlock(&tscm->mutex);
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index ab922d8..920bf30 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -20,6 +20,7 @@
 #include <sound/info.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../packets-buffer.h"
@@ -37,6 +38,9 @@ struct snd_tscm_spec {
 	bool is_controller;
 };
 
+#define TSCM_MIDI_IN_PORT_MAX	7
+#define TSCM_MIDI_OUT_PORT_MAX	4
+
 struct snd_tscm {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -50,6 +54,15 @@ struct snd_tscm {
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
 	unsigned int substreams_counter;
+
+	/* For MIDI message incoming transactions. */
+	struct fw_address_handler async_handler;
+	struct snd_rawmidi_substream *tx_midi_substreams[TSCM_MIDI_IN_PORT_MAX];
+
+	/* For MIDI message outgoing transactions. */
+	struct snd_fw_async_midi_port out_ports[TSCM_MIDI_OUT_PORT_MAX];
+	u8 running_status[TSCM_MIDI_OUT_PORT_MAX];
+	u8 on_sysex[TSCM_MIDI_OUT_PORT_MAX];
 };
 
 #define TSCM_ADDR_BASE			0xffff00000000ull
@@ -72,6 +85,14 @@ struct snd_tscm {
 #define TSCM_OFFSET_CLOCK_STATUS	0x0228
 #define TSCM_OFFSET_SET_OPTION		0x022c
 
+#define TSCM_OFFSET_MIDI_TX_ON		0x0300
+#define TSCM_OFFSET_MIDI_TX_ADDR_HI	0x0304
+#define TSCM_OFFSET_MIDI_TX_ADDR_LO	0x0308
+
+#define TSCM_OFFSET_LED_TURN_ON		0x0404
+
+#define TSCM_OFFSET_MIDI_RX_QUAD	0x4000
+
 enum snd_tscm_clock {
 	SND_TSCM_CLOCK_INTERNAL = 0,
 	SND_TSCM_CLOCK_WORD	= 1,
@@ -95,6 +116,10 @@ void snd_tscm_stream_destroy_duplex(struct snd_tscm *tscm);
 int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate);
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm);
 
+int snd_tscm_transaction_register(struct snd_tscm *tscm);
+int snd_tscm_transaction_reregister(struct snd_tscm *tscm);
+void snd_tscm_transaction_unregister(struct snd_tscm *tscm);
+
 void snd_tscm_proc_init(struct snd_tscm *tscm);
 
 int snd_tscm_create_pcm_devices(struct snd_tscm *tscm);
-- 
2.1.4
