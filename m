From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: firewire-tascam: add support for
	incoming MIDI messages by asynchronous transaction
Date: Mon, 12 Oct 2015 19:10:21 +0900
Message-ID: <1444644625-30189-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 743562612D0
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 12:10:30 +0200 (CEST)
In-Reply-To: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
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

TASCAM FireWire series use asynchronous transaction to transfer MIDI
messages. The transaction is sent to a registered address.

This commit supports the incoming MIDI messages. The messages in the
transaction include some quirks:
 * Two quadlets are used for one MIDI message and one timestamp.
 * Usually, the first byte of the first quadlet includes MIDI port and MSB
   4 bit of MIDI status. For system exclusive message, the first byte
   includes MIDI port and 0x04, or 0x07 in the end of the message.
 * The rest of the first quadlet includes MIDI bytes up to 3.
 * Several set of MIDI messages and timestamp can be transferred in one
   block transaction, up to 8 sets.

I note that TASCAM FireWire series ignores ID bytes of system exclusive
message. When receiving system exclusive messages with ID bytes on physical
MIDI bus, the series transfers the messages without ID bytes on IEEE 1394
bus, and vice versa.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/Makefile             |   3 +-
 sound/firewire/tascam/tascam-transaction.c | 186 +++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.c             |   7 ++
 sound/firewire/tascam/tascam.h             |  18 +++
 4 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/tascam/tascam-transaction.c

diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
index 6beefc2..a1f9fe7 100644
--- a/sound/firewire/tascam/Makefile
+++ b/sound/firewire/tascam/Makefile
@@ -1,3 +1,4 @@
 snd-firewire-tascam-objs := tascam-proc.o amdtp-tascam.o tascam-stream.o \
-			    tascam-pcm.o tascam-hwdep.o tascam.o
+			    tascam-pcm.o tascam-hwdep.o tascam-transaction.o \
+			    tascam.o
 obj-$(CONFIG_SND_FIREWIRE_TASCAM) += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
new file mode 100644
index 0000000..853438d
--- /dev/null
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -0,0 +1,186 @@
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
+static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
+			   int tcode, int destination, int source,
+			   int generation, unsigned long long offset,
+			   void *data, size_t length, void *callback_data)
+{
+	struct snd_tscm *tscm = callback_data;
+	u32 *buf = (u32 *)data;
+	unsigned int messages;
+	unsigned int i;
+	unsigned int port;
+	struct snd_rawmidi_substream *substream;
+	u8 *b;
+	int bytes;
+
+	if (offset != tscm->async_handler.offset)
+		goto end;
+
+	messages = length / 8;
+	for (i = 0; i < messages; i++) {
+		b = (u8 *)(buf + i * 2);
+
+		port = b[0] >> 4;
+		/* TODO: support virtual MIDI ports. */
+		if (port > tscm->spec->midi_capture_ports)
+			goto end;
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
+	if (err < 0)
+		fw_core_remove_address_handler(&tscm->async_handler);
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
+	return snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ON,
+				  &reg, sizeof(reg), 0);
+}
+
+void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
+{
+	__be32 reg;
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
+
+	fw_core_remove_address_handler(&tscm->async_handler);
+}
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index ee2f498..de9e8df 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -82,6 +82,7 @@ static void tscm_card_free(struct snd_card *card)
 {
 	struct snd_tscm *tscm = card->private_data;
 
+	snd_tscm_transaction_unregister(tscm);
 	snd_tscm_stream_destroy_duplex(tscm);
 
 	fw_unit_put(tscm->unit);
@@ -127,6 +128,10 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_tscm_transaction_register(tscm);
+	if (err < 0)
+		goto error;
+
 	err = snd_tscm_create_hwdep_device(tscm);
 	if (err < 0)
 		goto error;
@@ -147,6 +152,8 @@ static void snd_tscm_update(struct fw_unit *unit)
 {
 	struct snd_tscm *tscm = dev_get_drvdata(&unit->device);
 
+	snd_tscm_transaction_reregister(tscm);
+
 	mutex_lock(&tscm->mutex);
 	snd_tscm_stream_update_duplex(tscm);
 	mutex_unlock(&tscm->mutex);
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 75a3b9a..b0e602b 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -25,6 +25,7 @@
 #include <sound/pcm_params.h>
 #include <sound/firewire.h>
 #include <sound/hwdep.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../amdtp-stream.h"
@@ -41,6 +42,9 @@ struct snd_tscm_spec {
 	bool is_controller;
 };
 
+#define TSCM_MIDI_IN_PORT_MAX	4
+#define TSCM_MIDI_OUT_PORT_MAX	4
+
 struct snd_tscm {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -59,6 +63,10 @@ struct snd_tscm {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
+
+	/* For MIDI message incoming transactions. */
+	struct fw_address_handler async_handler;
+	struct snd_rawmidi_substream *tx_midi_substreams[TSCM_MIDI_IN_PORT_MAX];
 };
 
 #define TSCM_ADDR_BASE			0xffff00000000ull
@@ -81,6 +89,12 @@ struct snd_tscm {
 #define TSCM_OFFSET_CLOCK_STATUS	0x0228
 #define TSCM_OFFSET_SET_OPTION		0x022c
 
+#define TSCM_OFFSET_MIDI_TX_ON		0x0300
+#define TSCM_OFFSET_MIDI_TX_ADDR_HI	0x0304
+#define TSCM_OFFSET_MIDI_TX_ADDR_LO	0x0308
+
+#define TSCM_OFFSET_MIDI_RX_QUAD	0x4000
+
 enum snd_tscm_clock {
 	SND_TSCM_CLOCK_INTERNAL = 0,
 	SND_TSCM_CLOCK_WORD	= 1,
@@ -108,6 +122,10 @@ void snd_tscm_stream_lock_changed(struct snd_tscm *tscm);
 int snd_tscm_stream_lock_try(struct snd_tscm *tscm);
 void snd_tscm_stream_lock_release(struct snd_tscm *tscm);
 
+int snd_tscm_transaction_register(struct snd_tscm *tscm);
+int snd_tscm_transaction_reregister(struct snd_tscm *tscm);
+void snd_tscm_transaction_unregister(struct snd_tscm *tscm);
+
 void snd_tscm_proc_init(struct snd_tscm *tscm);
 
 int snd_tscm_create_pcm_devices(struct snd_tscm *tscm);
-- 
2.1.4
