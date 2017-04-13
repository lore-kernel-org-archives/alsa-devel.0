From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/8] firewire-tascam: move message parameters
	for async midi port
Date: Thu, 13 Apr 2017 14:15:26 +0900
Message-ID: <20170413051527.21396-8-o-takashi@sakamocchi.jp>
References: <20170413051527.21396-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id E3362266A80
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 07:15:35 +0200 (CEST)
In-Reply-To: <20170413051527.21396-1-o-takashi@sakamocchi.jp>
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

Units on TASCAM FireWire series handle MIDI messages with support for
running status. Drivers for the series should remember current running
status and transfer valid MIDI messages. For this purpose, current
ALSA driver for the series has some members in its top-level structure.
This is due to better abstraction of async midi port. Nowadays, the
abstraction was localized just for the driver.

This commit moves the members to structure for async midi port.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-midi.c        |  3 ---
 sound/firewire/tascam/tascam-transaction.c | 33 +++++++++++++++---------------
 sound/firewire/tascam/tascam.h             |  4 ++--
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/sound/firewire/tascam/tascam-midi.c b/sound/firewire/tascam/tascam-midi.c
index 901df81..760f72a 100644
--- a/sound/firewire/tascam/tascam-midi.c
+++ b/sound/firewire/tascam/tascam-midi.c
@@ -20,9 +20,6 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 
 	snd_fw_async_midi_port_init(&tscm->out_ports[substream->number]);
 
-	/* Initialize internal status. */
-	tscm->running_status[substream->number] = 0;
-	tscm->on_sysex[substream->number] = 0;
 	return 0;
 }
 
diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index a248a4a..8967c52 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -58,39 +58,38 @@ static inline int calculate_message_bytes(u8 status)
 	return -EINVAL;
 }
 
-static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
+static int fill_message(struct snd_fw_async_midi_port *port,
+			struct snd_rawmidi_substream *substream)
 {
-	struct snd_tscm *tscm = substream->rmidi->private_data;
-	unsigned int port = substream->number;
 	int i, len, consume;
 	u8 *label, *msg;
 	u8 status;
 
 	/* The first byte is used for label, the rest for MIDI bytes. */
-	label = buf;
-	msg = buf + 1;
+	label = port->buf;
+	msg = port->buf + 1;
 
 	consume = snd_rawmidi_transmit_peek(substream, msg, 3);
 	if (consume == 0)
 		return 0;
 
 	/* On exclusive message. */
-	if (tscm->on_sysex[port]) {
+	if (port->on_sysex) {
 		/* Seek the end of exclusives. */
 		for (i = 0; i < consume; ++i) {
 			if (msg[i] == 0xf7) {
-				tscm->on_sysex[port] = false;
+				port->on_sysex = false;
 				break;
 			}
 		}
 
 		/* At the end of exclusive message, use label 0x07. */
-		if (!tscm->on_sysex[port]) {
+		if (!port->on_sysex) {
 			consume = i + 1;
-			*label = (port << 4) | 0x07;
+			*label = (substream->number << 4) | 0x07;
 		/* During exclusive message, use label 0x04. */
 		} else if (consume == 3) {
-			*label = (port << 4) | 0x04;
+			*label = (substream->number << 4) | 0x04;
 		/* We need to fill whole 3 bytes. Go to next change. */
 		} else {
 			return 0;
@@ -101,12 +100,12 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 		/* The beginning of exclusives. */
 		if (msg[0] == 0xf0) {
 			/* Transfer it in next chance in another condition. */
-			tscm->on_sysex[port] = true;
+			port->on_sysex = true;
 			return 0;
 		} else {
 			/* On running-status. */
 			if ((msg[0] & 0x80) != 0x80)
-				status = tscm->running_status[port];
+				status = port->running_status;
 			else
 				status = msg[0];
 
@@ -124,18 +123,18 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 
 				msg[2] = msg[1];
 				msg[1] = msg[0];
-				msg[0] = tscm->running_status[port];
+				msg[0] = port->running_status;
 			} else {
 				/* Enough MIDI bytes were not retrieved. */
 				if (consume < len)
 					return 0;
 				consume = len;
 
-				tscm->running_status[port] = msg[0];
+				port->running_status = msg[0];
 			}
 		}
 
-		*label = (port << 4) | (msg[0] >> 4);
+		*label = (substream->number << 4) | (msg[0] >> 4);
 	}
 
 	if (len > 0 && len < 3)
@@ -196,7 +195,7 @@ static void midi_port_work(struct work_struct *work)
 	 * Later, snd_rawmidi_transmit_ack() is called.
 	 */
 	memset(port->buf, 0, 4);
-	port->consume_bytes = fill_message(substream, port->buf);
+	port->consume_bytes = fill_message(port, substream);
 	if (port->consume_bytes <= 0) {
 		/* Do it in next chance, immediately. */
 		if (port->consume_bytes == 0) {
@@ -240,6 +239,8 @@ void snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port)
 {
 	port->idling = true;
 	port->error = false;
+	port->running_status = 0;
+	port->on_sysex = false;
 }
 
 static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index a5bbe02..35c3a23 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -55,6 +55,8 @@ struct snd_fw_async_midi_port {
 	struct fw_transaction transaction;
 
 	u8 buf[4];
+	u8 running_status;
+	bool on_sysex;
 
 	struct snd_rawmidi_substream *substream;
 	unsigned int consume_bytes;
@@ -87,8 +89,6 @@ struct snd_tscm {
 
 	/* For MIDI message outgoing transactions. */
 	struct snd_fw_async_midi_port out_ports[TSCM_MIDI_OUT_PORT_MAX];
-	u8 running_status[TSCM_MIDI_OUT_PORT_MAX];
-	bool on_sysex[TSCM_MIDI_OUT_PORT_MAX];
 };
 
 #define TSCM_ADDR_BASE			0xffff00000000ull
-- 
2.9.3
