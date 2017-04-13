From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/8] firewire-tascam: send fixed-length
	transaction for async midi port
Date: Thu, 13 Apr 2017 14:15:22 +0900
Message-ID: <20170413051527.21396-4-o-takashi@sakamocchi.jp>
References: <20170413051527.21396-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 68EB72669CD
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 07:15:32 +0200 (CEST)
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

TASCAM FireWire series uses asynchronous transactions with fixed length
payload for MIDI messaging. On the other hand, ALSA driver for the series
has a redundant design to handle different length of payload.

This commit removes the redundant abstraction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 22 +++++++---------------
 sound/firewire/tascam/tascam.h             |  3 +--
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index dcbc003..2f5e20c 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -176,7 +176,6 @@ static void midi_port_work(struct work_struct *work)
 			container_of(work, struct snd_fw_async_midi_port, work);
 	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
 	int generation;
-	int type;
 
 	/* Under transacting or error state. */
 	if (!port->idling || port->error)
@@ -196,7 +195,7 @@ static void midi_port_work(struct work_struct *work)
 	 * Fill the buffer. The callee must use snd_rawmidi_transmit_peek().
 	 * Later, snd_rawmidi_transmit_ack() is called.
 	 */
-	memset(port->buf, 0, port->len);
+	memset(port->buf, 0, 4);
 	port->consume_bytes = fill_message(substream, port->buf);
 	if (port->consume_bytes <= 0) {
 		/* Do it in next chance, immediately. */
@@ -210,12 +209,6 @@ static void midi_port_work(struct work_struct *work)
 		return;
 	}
 
-	/* Calculate type of transaction. */
-	if (port->len == 4)
-		type = TCODE_WRITE_QUADLET_REQUEST;
-	else
-		type = TCODE_WRITE_BLOCK_REQUEST;
-
 	/* Set interval to next transaction. */
 	port->next_ktime = ktime_add_ns(ktime_get(),
 				port->consume_bytes * 8 * NSEC_PER_SEC / 31250);
@@ -234,18 +227,18 @@ static void midi_port_work(struct work_struct *work)
 	generation = port->parent->generation;
 	smp_rmb();
 
-	fw_send_request(port->parent->card, &port->transaction, type,
+	fw_send_request(port->parent->card, &port->transaction,
+			TCODE_WRITE_QUADLET_REQUEST,
 			port->parent->node_id, generation,
 			port->parent->max_speed, port->addr,
-			port->buf, port->len, async_midi_port_callback,
+			port->buf, 4, async_midi_port_callback,
 			port);
 }
 
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit, u64 addr, unsigned int len)
+		struct fw_unit *unit, u64 addr)
 {
-	port->len = DIV_ROUND_UP(len, 4) * 4;
-	port->buf = kzalloc(port->len, GFP_KERNEL);
+	port->buf = kzalloc(4, GFP_KERNEL);
 	if (port->buf == NULL)
 		return -ENOMEM;
 
@@ -344,8 +337,7 @@ int snd_tscm_transaction_register(struct snd_tscm *tscm)
 	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++) {
 		err = snd_fw_async_midi_port_init(
 				&tscm->out_ports[i], tscm->unit,
-				TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_RX_QUAD,
-				4);
+				TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_RX_QUAD);
 		if (err < 0)
 			goto error;
 	}
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 08e626e..c1becc6 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -56,7 +56,6 @@ struct snd_fw_async_midi_port {
 	struct fw_transaction transaction;
 
 	u8 *buf;
-	unsigned int len;
 
 	struct snd_rawmidi_substream *substream;
 	unsigned int consume_bytes;
@@ -149,7 +148,7 @@ int snd_tscm_stream_lock_try(struct snd_tscm *tscm);
 void snd_tscm_stream_lock_release(struct snd_tscm *tscm);
 
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit, u64 addr, unsigned int len);
+		struct fw_unit *unit, u64 addr);
 void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port);
 
 static inline void
-- 
2.9.3
