From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: firewire-lib: add helper functions
	for asynchronous transactions to transfer MIDI messages
Date: Fri,  9 Oct 2015 08:10:25 +0900
Message-ID: <1444345829-17408-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1444345829-17408-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C462650FA
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 01:10:34 +0200 (CEST)
In-Reply-To: <1444345829-17408-1-git-send-email-o-takashi@sakamocchi.jp>
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

Some models receive MIDI messages via IEEE 1394 asynchronous transactions.
In this case, MIDI messages are transferred in fixed-length payload. It's
nice that firewire-lib module has common helper functions.

This commit implements this idea. Each driver adds
'struct snd_fw_async_midi_port' in its instance structure. In probing,
it should call snd_fw_async_midi_port_init() to initialize the
structure with some parameters such as target address, the length
of payload in a transaction and a pointer for callback function
to fill the payload buffer. At 'struct snd_rawmidi_ops.trigger()'
callback, it should call 'snd_fw_async_midi_port_run()' to start
transactions. Each driver should ensure that the lifetime of MIDI
substream continues till calling 'snd_fw_async_midi_port_finish()'.

The helper functions support retries to transferring MIDI messages when
transmission errors occur. When transactions are successful, the helper
functions call 'snd_rawmidi_transmit_ack()' internally to consume MIDI
bytes in the buffer. Therefore, Each driver is expected to use
'snd_rawmidi_transmit_peek()' to tell the number of bytes to transfer to
return value of 'fill' callback.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/lib.h |  50 +++++++++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 7409edb..03ada3f 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/firewire.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include "lib.h"
 
 #define ERROR_RETRY_DELAY_MS	20
@@ -66,6 +67,108 @@ int snd_fw_transaction(struct fw_unit *unit, int tcode,
 }
 EXPORT_SYMBOL(snd_fw_transaction);
 
+static void async_midi_port_callback(struct fw_card *card, int rcode,
+				     void *data, size_t length,
+				     void *callback_data)
+{
+	struct snd_fw_async_midi_port *port = callback_data;
+	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
+
+	if (rcode == RCODE_COMPLETE && substream != NULL)
+		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
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
+	/* Nothing to do. */
+	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
+		return;
+
+	/*
+	 * Fill the buffer. The callee must use snd_rawmidi_transmit_peek().
+	 * Later, snd_rawmidi_transmit_ack() is called.
+	 */
+	memset(port->buf, 0, port->len);
+	port->consume_bytes = port->fill(substream, port->buf);
+	if (port->consume_bytes <= 0) {
+		/* Do it in next chance, immediately. */
+		if (port->consume_bytes == 0)
+			schedule_work(&port->work);
+		return;
+	}
+
+	/* Calculate type of transaction. */
+	if (port->len == 4)
+		type = TCODE_WRITE_QUADLET_REQUEST;
+	else
+		type = TCODE_WRITE_BLOCK_REQUEST;
+
+	/* Start this transaction. */
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
+/**
+ * snd_fw_async_midi_port_init - initialize asynchronous MIDI port structure
+ * @port: the asynchronous MIDI port to initialize
+ * @unit: the target of the asynchronous transaction
+ * @addr: the address to which transactions are transferred
+ * @len: the length of transaction
+ * @fill: the callback function to fill given buffer, and returns the
+ *	       number of consumed bytes for MIDI message.
+ *
+ */
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
+
+	INIT_WORK(&port->work, midi_port_work);
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_fw_async_midi_port_init);
+
+/**
+ * snd_fw_async_midi_port_destroy - free asynchronous MIDI port structure
+ * @port: the asynchronous MIDI port structure
+ */
+void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port)
+{
+	snd_fw_async_midi_port_finish(port);
+	cancel_work_sync(&port->work);
+	kfree(port->buf);
+}
+EXPORT_SYMBOL(snd_fw_async_midi_port_destroy);
+
 MODULE_DESCRIPTION("FireWire audio helper functions");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index 02cfabc..37a7fe4 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -3,6 +3,8 @@
 
 #include <linux/firewire-constants.h>
 #include <linux/types.h>
+#include <linux/sched.h>
+#include <sound/rawmidi.h>
 
 struct fw_unit;
 
@@ -20,4 +22,52 @@ static inline bool rcode_is_permanent_error(int rcode)
 	return rcode == RCODE_TYPE_ERROR || rcode == RCODE_ADDRESS_ERROR;
 }
 
+struct snd_fw_async_midi_port;
+typedef int (*snd_fw_async_midi_port_fill)(
+				struct snd_rawmidi_substream *substream,
+				u8 *buf);
+
+struct snd_fw_async_midi_port {
+	struct fw_device *parent;
+	struct work_struct work;
+
+	u64 addr;
+	struct fw_transaction transaction;
+
+	u8 *buf;
+	unsigned int len;
+
+	struct snd_rawmidi_substream *substream;
+	snd_fw_async_midi_port_fill fill;
+	unsigned int consume_bytes;
+};
+
+int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
+		struct fw_unit *unit, u64 addr, unsigned int len,
+		snd_fw_async_midi_port_fill fill);
+void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port);
+
+/**
+ * snd_fw_async_midi_port_run - run transactions for the async MIDI port
+ * @port: the asynchronous MIDI port
+ * @substream: the MIDI substream
+ */
+static inline void
+snd_fw_async_midi_port_run(struct snd_fw_async_midi_port *port,
+			   struct snd_rawmidi_substream *substream)
+{
+	port->substream = substream;
+	schedule_work(&port->work);
+}
+
+/**
+ * snd_fw_async_midi_port_finish - finish the asynchronous MIDI port
+ * @port: the asynchronous MIDI port
+ */
+static inline void
+snd_fw_async_midi_port_finish(struct snd_fw_async_midi_port *port)
+{
+	port->substream = NULL;
+}
+
 #endif
-- 
2.1.4
