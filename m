From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 1/8] ALSA: firewire-lib/firewire-tascam:
	localize async midi port
Date: Fri, 14 Apr 2017 16:46:25 +0900
Message-ID: <20170414074632.13453-2-o-takashi@sakamocchi.jp>
References: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 3B42626716A
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 09:46:36 +0200 (CEST)
In-Reply-To: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, dev@andree.sk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In Linux kernel 4.4, firewire-lib got a feature called as 'async midi port'
for transmission of MIDI message via IEEE 1394 asynchronous communication,
however actual consumer of this feature is ALSA driver for TASCAM FireWire
series only. When adding this feature, I assumed that ALSA driver for
Digi00x might also be a consumer, actually it's not.

This commit moves the feature from firewire-lib to firewire-tascam module.
Two minor kernel APIs are removed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c                       | 141 -----------------------------
 sound/firewire/lib.h                       |  54 -----------
 sound/firewire/tascam/tascam-transaction.c | 125 +++++++++++++++++++++++++
 sound/firewire/tascam/tascam.h             |  45 +++++++++
 4 files changed, 170 insertions(+), 195 deletions(-)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 7683238..39dfa74 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -99,147 +99,6 @@ void snd_fw_schedule_registration(struct fw_unit *unit,
 }
 EXPORT_SYMBOL(snd_fw_schedule_registration);
 
-static void async_midi_port_callback(struct fw_card *card, int rcode,
-				     void *data, size_t length,
-				     void *callback_data)
-{
-	struct snd_fw_async_midi_port *port = callback_data;
-	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
-
-	/* This port is closed. */
-	if (substream == NULL)
-		return;
-
-	if (rcode == RCODE_COMPLETE)
-		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
-	else if (!rcode_is_permanent_error(rcode))
-		/* To start next transaction immediately for recovery. */
-		port->next_ktime = 0;
-	else
-		/* Don't continue processing. */
-		port->error = true;
-
-	port->idling = true;
-
-	if (!snd_rawmidi_transmit_empty(substream))
-		schedule_work(&port->work);
-}
-
-static void midi_port_work(struct work_struct *work)
-{
-	struct snd_fw_async_midi_port *port =
-			container_of(work, struct snd_fw_async_midi_port, work);
-	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
-	int generation;
-	int type;
-
-	/* Under transacting or error state. */
-	if (!port->idling || port->error)
-		return;
-
-	/* Nothing to do. */
-	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
-		return;
-
-	/* Do it in next chance. */
-	if (ktime_after(port->next_ktime, ktime_get())) {
-		schedule_work(&port->work);
-		return;
-	}
-
-	/*
-	 * Fill the buffer. The callee must use snd_rawmidi_transmit_peek().
-	 * Later, snd_rawmidi_transmit_ack() is called.
-	 */
-	memset(port->buf, 0, port->len);
-	port->consume_bytes = port->fill(substream, port->buf);
-	if (port->consume_bytes <= 0) {
-		/* Do it in next chance, immediately. */
-		if (port->consume_bytes == 0) {
-			port->next_ktime = 0;
-			schedule_work(&port->work);
-		} else {
-			/* Fatal error. */
-			port->error = true;
-		}
-		return;
-	}
-
-	/* Calculate type of transaction. */
-	if (port->len == 4)
-		type = TCODE_WRITE_QUADLET_REQUEST;
-	else
-		type = TCODE_WRITE_BLOCK_REQUEST;
-
-	/* Set interval to next transaction. */
-	port->next_ktime = ktime_add_ns(ktime_get(),
-				port->consume_bytes * 8 * NSEC_PER_SEC / 31250);
-
-	/* Start this transaction. */
-	port->idling = false;
-
-	/*
-	 * In Linux FireWire core, when generation is updated with memory
-	 * barrier, node id has already been updated. In this module, After
-	 * this smp_rmb(), load/store instructions to memory are completed.
-	 * Thus, both of generation and node id are available with recent
-	 * values. This is a light-serialization solution to handle bus reset
-	 * events on IEEE 1394 bus.
-	 */
-	generation = port->parent->generation;
-	smp_rmb();
-
-	fw_send_request(port->parent->card, &port->transaction, type,
-			port->parent->node_id, generation,
-			port->parent->max_speed, port->addr,
-			port->buf, port->len, async_midi_port_callback,
-			port);
-}
-
-/**
- * snd_fw_async_midi_port_init - initialize asynchronous MIDI port structure
- * @port: the asynchronous MIDI port to initialize
- * @unit: the target of the asynchronous transaction
- * @addr: the address to which transactions are transferred
- * @len: the length of transaction
- * @fill: the callback function to fill given buffer, and returns the
- *	       number of consumed bytes for MIDI message.
- *
- */
-int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit, u64 addr, unsigned int len,
-		snd_fw_async_midi_port_fill fill)
-{
-	port->len = DIV_ROUND_UP(len, 4) * 4;
-	port->buf = kzalloc(port->len, GFP_KERNEL);
-	if (port->buf == NULL)
-		return -ENOMEM;
-
-	port->parent = fw_parent_device(unit);
-	port->addr = addr;
-	port->fill = fill;
-	port->idling = true;
-	port->next_ktime = 0;
-	port->error = false;
-
-	INIT_WORK(&port->work, midi_port_work);
-
-	return 0;
-}
-EXPORT_SYMBOL(snd_fw_async_midi_port_init);
-
-/**
- * snd_fw_async_midi_port_destroy - free asynchronous MIDI port structure
- * @port: the asynchronous MIDI port structure
- */
-void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port)
-{
-	snd_fw_async_midi_port_finish(port);
-	cancel_work_sync(&port->work);
-	kfree(port->buf);
-}
-EXPORT_SYMBOL(snd_fw_async_midi_port_destroy);
-
 MODULE_DESCRIPTION("FireWire audio helper functions");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index c3768cd..eef7092 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -25,58 +25,4 @@ static inline bool rcode_is_permanent_error(int rcode)
 void snd_fw_schedule_registration(struct fw_unit *unit,
 				  struct delayed_work *dwork);
 
-struct snd_fw_async_midi_port;
-typedef int (*snd_fw_async_midi_port_fill)(
-				struct snd_rawmidi_substream *substream,
-				u8 *buf);
-
-struct snd_fw_async_midi_port {
-	struct fw_device *parent;
-	struct work_struct work;
-	bool idling;
-	ktime_t next_ktime;
-	bool error;
-
-	u64 addr;
-	struct fw_transaction transaction;
-
-	u8 *buf;
-	unsigned int len;
-
-	struct snd_rawmidi_substream *substream;
-	snd_fw_async_midi_port_fill fill;
-	int consume_bytes;
-};
-
-int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit, u64 addr, unsigned int len,
-		snd_fw_async_midi_port_fill fill);
-void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port);
-
-/**
- * snd_fw_async_midi_port_run - run transactions for the async MIDI port
- * @port: the asynchronous MIDI port
- * @substream: the MIDI substream
- */
-static inline void
-snd_fw_async_midi_port_run(struct snd_fw_async_midi_port *port,
-			   struct snd_rawmidi_substream *substream)
-{
-	if (!port->error) {
-		port->substream = substream;
-		schedule_work(&port->work);
-	}
-}
-
-/**
- * snd_fw_async_midi_port_finish - finish the asynchronous MIDI port
- * @port: the asynchronous MIDI port
- */
-static inline void
-snd_fw_async_midi_port_finish(struct snd_fw_async_midi_port *port)
-{
-	port->substream = NULL;
-	port->error = false;
-}
-
 #endif
diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 040a96d..8ba006e 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -144,6 +144,131 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 	return consume;
 }
 
+static void async_midi_port_callback(struct fw_card *card, int rcode,
+				     void *data, size_t length,
+				     void *callback_data)
+{
+	struct snd_fw_async_midi_port *port = callback_data;
+	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
+
+	/* This port is closed. */
+	if (substream == NULL)
+		return;
+
+	if (rcode == RCODE_COMPLETE)
+		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
+	else if (!rcode_is_permanent_error(rcode))
+		/* To start next transaction immediately for recovery. */
+		port->next_ktime = 0;
+	else
+		/* Don't continue processing. */
+		port->error = true;
+
+	port->idling = true;
+
+	if (!snd_rawmidi_transmit_empty(substream))
+		schedule_work(&port->work);
+}
+
+static void midi_port_work(struct work_struct *work)
+{
+	struct snd_fw_async_midi_port *port =
+			container_of(work, struct snd_fw_async_midi_port, work);
+	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
+	int generation;
+	int type;
+
+	/* Under transacting or error state. */
+	if (!port->idling || port->error)
+		return;
+
+	/* Nothing to do. */
+	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
+		return;
+
+	/* Do it in next chance. */
+	if (ktime_after(port->next_ktime, ktime_get())) {
+		schedule_work(&port->work);
+		return;
+	}
+
+	/*
+	 * Fill the buffer. The callee must use snd_rawmidi_transmit_peek().
+	 * Later, snd_rawmidi_transmit_ack() is called.
+	 */
+	memset(port->buf, 0, port->len);
+	port->consume_bytes = port->fill(substream, port->buf);
+	if (port->consume_bytes <= 0) {
+		/* Do it in next chance, immediately. */
+		if (port->consume_bytes == 0) {
+			port->next_ktime = 0;
+			schedule_work(&port->work);
+		} else {
+			/* Fatal error. */
+			port->error = true;
+		}
+		return;
+	}
+
+	/* Calculate type of transaction. */
+	if (port->len == 4)
+		type = TCODE_WRITE_QUADLET_REQUEST;
+	else
+		type = TCODE_WRITE_BLOCK_REQUEST;
+
+	/* Set interval to next transaction. */
+	port->next_ktime = ktime_add_ns(ktime_get(),
+				port->consume_bytes * 8 * NSEC_PER_SEC / 31250);
+
+	/* Start this transaction. */
+	port->idling = false;
+
+	/*
+	 * In Linux FireWire core, when generation is updated with memory
+	 * barrier, node id has already been updated. In this module, After
+	 * this smp_rmb(), load/store instructions to memory are completed.
+	 * Thus, both of generation and node id are available with recent
+	 * values. This is a light-serialization solution to handle bus reset
+	 * events on IEEE 1394 bus.
+	 */
+	generation = port->parent->generation;
+	smp_rmb();
+
+	fw_send_request(port->parent->card, &port->transaction, type,
+			port->parent->node_id, generation,
+			port->parent->max_speed, port->addr,
+			port->buf, port->len, async_midi_port_callback,
+			port);
+}
+
+int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
+		struct fw_unit *unit, u64 addr, unsigned int len,
+		snd_fw_async_midi_port_fill fill)
+{
+	port->len = DIV_ROUND_UP(len, 4) * 4;
+	port->buf = kzalloc(port->len, GFP_KERNEL);
+	if (port->buf == NULL)
+		return -ENOMEM;
+
+	port->parent = fw_parent_device(unit);
+	port->addr = addr;
+	port->fill = fill;
+	port->idling = true;
+	port->next_ktime = 0;
+	port->error = false;
+
+	INIT_WORK(&port->work, midi_port_work);
+
+	return 0;
+}
+
+void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port)
+{
+	snd_fw_async_midi_port_finish(port);
+	cancel_work_sync(&port->work);
+	kfree(port->buf);
+}
+
 static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
 			   int tcode, int destination, int source,
 			   int generation, unsigned long long offset,
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index d3cd406..de76313 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -45,6 +45,29 @@ struct snd_tscm_spec {
 #define TSCM_MIDI_IN_PORT_MAX	4
 #define TSCM_MIDI_OUT_PORT_MAX	4
 
+struct snd_fw_async_midi_port;
+typedef int (*snd_fw_async_midi_port_fill)(
+				struct snd_rawmidi_substream *substream,
+				u8 *buf);
+
+struct snd_fw_async_midi_port {
+	struct fw_device *parent;
+	struct work_struct work;
+	bool idling;
+	ktime_t next_ktime;
+	bool error;
+
+	u64 addr;
+	struct fw_transaction transaction;
+
+	u8 *buf;
+	unsigned int len;
+
+	struct snd_rawmidi_substream *substream;
+	snd_fw_async_midi_port_fill fill;
+	int consume_bytes;
+};
+
 struct snd_tscm {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -131,6 +154,28 @@ void snd_tscm_stream_lock_changed(struct snd_tscm *tscm);
 int snd_tscm_stream_lock_try(struct snd_tscm *tscm);
 void snd_tscm_stream_lock_release(struct snd_tscm *tscm);
 
+int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
+		struct fw_unit *unit, u64 addr, unsigned int len,
+		snd_fw_async_midi_port_fill fill);
+void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port);
+
+static inline void
+snd_fw_async_midi_port_run(struct snd_fw_async_midi_port *port,
+			   struct snd_rawmidi_substream *substream)
+{
+	if (!port->error) {
+		port->substream = substream;
+		schedule_work(&port->work);
+	}
+}
+
+static inline void
+snd_fw_async_midi_port_finish(struct snd_fw_async_midi_port *port)
+{
+	port->substream = NULL;
+	port->error = false;
+}
+
 int snd_tscm_transaction_register(struct snd_tscm *tscm);
 int snd_tscm_transaction_reregister(struct snd_tscm *tscm);
 void snd_tscm_transaction_unregister(struct snd_tscm *tscm);
-- 
2.9.3
