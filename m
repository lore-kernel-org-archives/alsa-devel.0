From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: firewire-tascam: add support for
	outgoing MIDI messages by asynchronous transaction
Date: Mon, 12 Oct 2015 19:10:22 +0900
Message-ID: <1444644625-30189-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E6D42610A7
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

TASCAM FireWire series use asynchronous transaction to receive MIDI
messages. The transaction should be sent to a certain address.

This commit supports the outgoing MIDI messages. The messages in the
transaction includes some quirks:
 * One MIDI message is transferred in one quadlet transaction, except for
   system exclusives.
 * MIDI running status is not allowed, thus transactions always include
   status byte.
 * The basic data format is the same as transferring MIDI messages
   supported in previous commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 95 +++++++++++++++++++++++++++++-
 sound/firewire/tascam/tascam.h             |  8 +++
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 853438d..6b74fb5 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -58,6 +58,83 @@ static inline int calculate_message_bytes(u8 status)
 	return -EINVAL;
 }
 
+static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
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
+	if (tscm->on_sysex[port]) {
+		/* Seek the end of exclusives. */
+		for (i = 1; i < 4 || i < len; ++i) {
+			if (buf[i] == 0xf7) {
+				tscm->on_sysex[port] = false;
+				break;
+			}
+		}
+
+		/* At the end of exclusive message, use label 0x07. */
+		if (!tscm->on_sysex[port]) {
+			len = i;
+			buf[0] = (port << 4) | 0x07;
+		/* During exclusive message, use label 0x04. */
+		} else if (len == 3) {
+			buf[0] = (port << 4) | 0x04;
+		/* We need to fill whole 3 bytes. Go to next change. */
+		} else {
+			len = 0;
+		}
+	} else {
+		/* The beginning of exclusives. */
+		if (buf[1] == 0xf0) {
+			/* Transfer it in next chance in another condition. */
+			tscm->on_sysex[port] = true;
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
+
+		buf[0] = (port << 4) | (buf[1] >> 4);
+	}
+
+	return len;
+}
+
 static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
 			   int tcode, int destination, int source,
 			   int generation, unsigned long long offset,
@@ -111,6 +188,7 @@ int snd_tscm_transaction_register(struct snd_tscm *tscm)
 		.start	= 0xffffe0000000ull,
 		.end	= 0xffffe000ffffull,
 	};
+	unsigned int i;
 	int err;
 
 	/*
@@ -129,9 +207,21 @@ int snd_tscm_transaction_register(struct snd_tscm *tscm)
 
 	err = snd_tscm_transaction_reregister(tscm);
 	if (err < 0)
-		fw_core_remove_address_handler(&tscm->async_handler);
+		goto error;
+
+	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++) {
+		err = snd_fw_async_midi_port_init(
+				&tscm->out_ports[i], tscm->unit,
+				TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_RX_QUAD,
+				4, fill_message);
+		if (err < 0)
+			goto error;
+	}
 
 	return err;
+error:
+	fw_core_remove_address_handler(&tscm->async_handler);
+	return err;
 }
 
 /* At bus reset, these registers are cleared. */
@@ -167,6 +257,7 @@ int snd_tscm_transaction_reregister(struct snd_tscm *tscm)
 void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
 {
 	__be32 reg;
+	unsigned int i;
 
 	/* Turn off messaging. */
 	reg = cpu_to_be32(0x00000000);
@@ -183,4 +274,6 @@ void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
 			   &reg, sizeof(reg), 0);
 
 	fw_core_remove_address_handler(&tscm->async_handler);
+	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++)
+		snd_fw_async_midi_port_destroy(&tscm->out_ports[i]);
 }
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index b0e602b..c2f0c74 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -67,6 +67,14 @@ struct snd_tscm {
 	/* For MIDI message incoming transactions. */
 	struct fw_address_handler async_handler;
 	struct snd_rawmidi_substream *tx_midi_substreams[TSCM_MIDI_IN_PORT_MAX];
+
+	/* For MIDI message outgoing transactions. */
+	struct snd_fw_async_midi_port out_ports[TSCM_MIDI_OUT_PORT_MAX];
+	u8 running_status[TSCM_MIDI_OUT_PORT_MAX];
+	bool on_sysex[TSCM_MIDI_OUT_PORT_MAX];
+
+	/* For control messages. */
+	struct snd_firewire_tascam_status *status;
 };
 
 #define TSCM_ADDR_BASE			0xffff00000000ull
-- 
2.1.4
