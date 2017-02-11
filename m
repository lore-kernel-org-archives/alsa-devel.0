From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/13] ALSA: fireface: add transaction support
Date: Sat, 11 Feb 2017 23:25:01 +0900
Message-ID: <20170211142509.4795-6-o-takashi@sakamocchi.jp>
References: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B2F6D266AFF
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 15:25:17 +0100 (CET)
In-Reply-To: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
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

As long as investigating Fireface 400, MIDI messages are transferred by
asynchronous communication over IEEE 1394 bus.

Fireface 400 receives MIDI messages by write transactions to two addresses;
0x'0000'0801'8000 and 0x'0000'0801'9000. Each of two seems to correspond to
MIDI port 1 and 2.

Fireface 400 transfers MIDI messages by write transactions to certain
addresses which configured by drivers. The drivers can decide upper 4 byte
of the addresses by write transactions to 0x'0000'0801'03f4. For the rest
part of the address, drivers can select from below options:
 * 0x'0000'0000
 * 0x'0000'0080
 * 0x'0000'0100
 * 0x'0000'0180

Selected options are represented in register 0x'0000'0801'051c as bit
flags. Due to this mechanism, drivers are restricted to use addresses on
'Memory space' of IEEE 1222, even if transactions to the address have
some side effects.

This commit adds transaction support for MIDI messaging, based on my
assumption that the similar mechanism is used on the other protocols. To
receive asynchronous transactions, the driver allocates a range of address
in 'Memory space'. I apply a strategy to use 0x'0000'0000 as lower 4 byte
of the address. This driver retries to allocate when getting failure from
Linux FireWire subsystem.

Unfortunately, read transaction to address 0x'0000'0801'051c returns zero
always, however write transactions have effects to the other features such
as status of sampling clock. For this reason, this commit delegates the
task to configure this register to user space applications. The
applications should set 3rd bit in LSB in little endian order.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile         |   2 +-
 sound/firewire/fireface/ff-transaction.c | 295 +++++++++++++++++++++++++++++++
 sound/firewire/fireface/ff.c             |   9 +
 sound/firewire/fireface/ff.h             |  23 +++
 4 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/ff-transaction.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 2c64ef6..864aacc 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,2 +1,2 @@
-snd-fireface-objs := ff.o
+snd-fireface-objs := ff.o ff-transaction.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
new file mode 100644
index 0000000..dd6c8e8
--- /dev/null
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -0,0 +1,295 @@
+/*
+ * ff-transaction.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "ff.h"
+
+static void finish_transmit_midi_msg(struct snd_ff *ff, unsigned int port,
+				     int rcode)
+{
+	struct snd_rawmidi_substream *substream =
+				ACCESS_ONCE(ff->rx_midi_substreams[port]);
+
+	if (rcode_is_permanent_error(rcode)) {
+		ff->rx_midi_error[port] = true;
+		return;
+	}
+
+	if (rcode != RCODE_COMPLETE) {
+		/* Transfer the message again, immediately. */
+		ff->next_ktime[port] = 0;
+		schedule_work(&ff->rx_midi_work[port]);
+		return;
+	}
+
+	snd_rawmidi_transmit_ack(substream, ff->rx_bytes[port]);
+	ff->rx_bytes[port] = 0;
+
+	if (!snd_rawmidi_transmit_empty(substream))
+		schedule_work(&ff->rx_midi_work[port]);
+}
+
+static void finish_transmit_midi0_msg(struct fw_card *card, int rcode,
+				      void *data, size_t length,
+				      void *callback_data)
+{
+	struct snd_ff *ff =
+		container_of(callback_data, struct snd_ff, transactions[0]);
+	finish_transmit_midi_msg(ff, 0, rcode);
+}
+
+static void finish_transmit_midi1_msg(struct fw_card *card, int rcode,
+				      void *data, size_t length,
+				      void *callback_data)
+{
+	struct snd_ff *ff =
+		container_of(callback_data, struct snd_ff, transactions[1]);
+	finish_transmit_midi_msg(ff, 1, rcode);
+}
+
+static inline void fill_midi_buf(struct snd_ff *ff, unsigned int port,
+				 unsigned int index, u8 byte)
+{
+	ff->msg_buf[port][index] = cpu_to_le32(byte);
+}
+
+static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
+{
+	struct snd_rawmidi_substream *substream =
+			ACCESS_ONCE(ff->rx_midi_substreams[port]);
+	u8 *buf = (u8 *)ff->msg_buf[port];
+	int i, len;
+
+	struct fw_device *fw_dev = fw_parent_device(ff->unit);
+	unsigned long long addr;
+	int generation;
+	fw_transaction_callback_t callback;
+
+	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
+		return;
+
+	if (ff->rx_bytes[port] > 0 || ff->rx_midi_error[port])
+		return;
+
+	/* Do it in next chance. */
+	if (ktime_after(ff->next_ktime[port], ktime_get())) {
+		schedule_work(&ff->rx_midi_work[port]);
+		return;
+	}
+
+	len = snd_rawmidi_transmit_peek(substream, buf,
+					SND_FF_MAXIMIM_MIDI_QUADS);
+	if (len <= 0)
+		return;
+
+	for (i = len - 1; i >= 0; i--)
+		fill_midi_buf(ff, port, i, buf[i]);
+
+	if (port == 0) {
+		addr = ff->spec->protocol->midi_rx_port_0_reg;
+		callback = finish_transmit_midi0_msg;
+	} else {
+		addr = ff->spec->protocol->midi_rx_port_1_reg;
+		callback = finish_transmit_midi1_msg;
+	}
+
+	/* Set interval to next transaction. */
+	ff->next_ktime[port] = ktime_add_ns(ktime_get(),
+					    len * 8 * NSEC_PER_SEC / 31250);
+	ff->rx_bytes[port] = len;
+
+	/*
+	 * In Linux FireWire core, when generation is updated with memory
+	 * barrier, node id has already been updated. In this module, After
+	 * this smp_rmb(), load/store instructions to memory are completed.
+	 * Thus, both of generation and node id are available with recent
+	 * values. This is a light-serialization solution to handle bus reset
+	 * events on IEEE 1394 bus.
+	 */
+	generation = fw_dev->generation;
+	smp_rmb();
+	fw_send_request(fw_dev->card, &ff->transactions[port],
+			TCODE_WRITE_BLOCK_REQUEST,
+			fw_dev->node_id, generation, fw_dev->max_speed,
+			addr, &ff->msg_buf[port], len * 4,
+			callback, &ff->transactions[port]);
+}
+
+static void transmit_midi0_msg(struct work_struct *work)
+{
+	struct snd_ff *ff = container_of(work, struct snd_ff, rx_midi_work[0]);
+
+	transmit_midi_msg(ff, 0);
+}
+
+static void transmit_midi1_msg(struct work_struct *work)
+{
+	struct snd_ff *ff = container_of(work, struct snd_ff, rx_midi_work[1]);
+
+	transmit_midi_msg(ff, 1);
+}
+
+static void handle_midi_msg(struct fw_card *card, struct fw_request *request,
+			    int tcode, int destination, int source,
+			    int generation, unsigned long long offset,
+			    void *data, size_t length, void *callback_data)
+{
+	struct snd_ff *ff = callback_data;
+	__le32 *buf = data;
+	u32 quad;
+	u8 byte;
+	unsigned int index;
+	struct snd_rawmidi_substream *substream;
+	int i;
+
+	fw_send_response(card, request, RCODE_COMPLETE);
+
+	for (i = 0; i < length / 4; i++) {
+		quad = le32_to_cpu(buf[i]);
+
+		/* Message in first port. */
+		/*
+		 * This value may represent the index of this unit when the same
+		 * units are on the same IEEE 1394 bus. This driver doesn't use
+		 * it.
+		 */
+		index = (quad >> 8) & 0xff;
+		if (index > 0) {
+			substream = ACCESS_ONCE(ff->tx_midi_substreams[0]);
+			if (substream != NULL) {
+				byte = quad & 0xff;
+				snd_rawmidi_receive(substream, &byte, 1);
+			}
+		}
+
+		/* Message in second port. */
+		index = (quad >> 24) & 0xff;
+		if (index > 0) {
+			substream = ACCESS_ONCE(ff->tx_midi_substreams[1]);
+			if (substream != NULL) {
+				byte = (quad >> 16) & 0xff;
+				snd_rawmidi_receive(substream, &byte, 1);
+			}
+		}
+	}
+}
+
+static int allocate_own_address(struct snd_ff *ff, int i)
+{
+	struct fw_address_region midi_msg_region;
+	int err;
+
+	ff->async_handler.length = SND_FF_MAXIMIM_MIDI_QUADS * 4;
+	ff->async_handler.address_callback = handle_midi_msg;
+	ff->async_handler.callback_data = ff;
+
+	midi_msg_region.start = 0x000100000000ull * i;
+	midi_msg_region.end = midi_msg_region.start + ff->async_handler.length;
+
+	err = fw_core_add_address_handler(&ff->async_handler, &midi_msg_region);
+	if (err >= 0) {
+		/* Controllers are allowed to register this region. */
+		if (ff->async_handler.offset & 0x0000ffffffff) {
+			fw_core_remove_address_handler(&ff->async_handler);
+			err = -EAGAIN;
+		}
+	}
+
+	return err;
+}
+
+/*
+ * The configuration to start asynchronous transactions for MIDI messages is in
+ * 0x'0000'8010'051c. This register includes the other options, thus this driver
+ * doesn't touch it and leaves the decision to userspace. The userspace MUST add
+ * 0x04000000 to write transactions to the register to receive any MIDI
+ * messages.
+ *
+ * Here, I just describe MIDI-related offsets of the register, in little-endian
+ * order.
+ *
+ * Controllers are allowed to register higher 4 bytes of address to receive
+ * the transactions. The register is 0x'0000'8010'03f4. On the other hand, the
+ * controllers are not allowed to register lower 4 bytes of the address. They
+ * are forced to select from 4 options by writing corresponding bits to
+ * 0x'0000'8010'051c.
+ *
+ * The 3rd-6th bits in MSB of this register are used to indicate lower 4 bytes
+ * of address to which the device transferrs the transactions.
+ *  - 6th: 0x'....'....'0000'0180
+ *  - 5th: 0x'....'....'0000'0100
+ *  - 4th: 0x'....'....'0000'0080
+ *  - 3rd: 0x'....'....'0000'0000
+ *
+ * This driver configure 0x'....'....'0000'0000 for units to receive MIDI
+ * messages. 3rd bit of the register should be configured, however this driver
+ * deligates this task to user space applications due to a restriction that
+ * this register is write-only and the other bits have own effects.
+ *
+ * The 1st and 2nd bits in LSB of this register are used to cancel transferring
+ * asynchronous transactions. These two bits have the same effect.
+ *  - 1st/2nd: cancel transferring
+ */
+int snd_ff_transaction_reregister(struct snd_ff *ff)
+{
+	struct fw_card *fw_card = fw_parent_device(ff->unit)->card;
+	u32 addr;
+	__le32 reg;
+
+	/*
+	 * Controllers are allowed to register its node ID and upper 2 byte of
+	 * local address to listen asynchronous transactions.
+	 */
+	addr = (fw_card->node_id << 16) | (ff->async_handler.offset >> 32);
+	reg = cpu_to_le32(addr);
+	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  ff->spec->protocol->midi_high_addr_reg,
+				  &reg, sizeof(reg), 0);
+}
+
+int snd_ff_transaction_register(struct snd_ff *ff)
+{
+	int i, err;
+
+	/*
+	 * Allocate in Memory Space of IEC 13213, but lower 4 byte in LSB should
+	 * be zero due to device specification.
+	 */
+	for (i = 0; i < 0xffff; i++) {
+		err = allocate_own_address(ff, i);
+		if (err != -EBUSY && err != -EAGAIN)
+			break;
+	}
+	if (err < 0)
+		return err;
+
+	err = snd_ff_transaction_reregister(ff);
+	if (err < 0)
+		return err;
+
+	INIT_WORK(&ff->rx_midi_work[0], transmit_midi0_msg);
+	INIT_WORK(&ff->rx_midi_work[1], transmit_midi1_msg);
+
+	return 0;
+}
+
+void snd_ff_transaction_unregister(struct snd_ff *ff)
+{
+	__le32 reg;
+
+	if (ff->async_handler.callback_data == NULL)
+		return;
+	ff->async_handler.callback_data = NULL;
+
+	/* Release higher 4 bytes of address. */
+	reg = cpu_to_le32(0x00000000);
+	snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   ff->spec->protocol->midi_high_addr_reg,
+			   &reg, sizeof(reg), 0);
+
+	fw_core_remove_address_handler(&ff->async_handler);
+}
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 5c2bd92..4db630f 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -29,6 +29,8 @@ static void name_card(struct snd_ff *ff)
 
 static void ff_free(struct snd_ff *ff)
 {
+	snd_ff_transaction_unregister(ff);
+
 	fw_unit_put(ff->unit);
 
 	mutex_destroy(&ff->mutex);
@@ -53,6 +55,10 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		return;
 
+	err = snd_ff_transaction_register(ff);
+	if (err < 0)
+		goto error;
+
 	name_card(ff);
 
 	err = snd_card_register(ff->card);
@@ -65,6 +71,7 @@ static void do_registration(struct work_struct *work)
 
 	return;
 error:
+	snd_ff_transaction_unregister(ff);
 	snd_card_free(ff->card);
 	dev_info(&ff->unit->device,
 		 "Sound card registration failed: %d\n", err);
@@ -101,6 +108,8 @@ static void snd_ff_update(struct fw_unit *unit)
 	/* Postpone a workqueue for deferred registration. */
 	if (!ff->registered)
 		snd_fw_schedule_registration(unit, &ff->dwork);
+
+	snd_ff_transaction_reregister(ff);
 }
 
 static void snd_ff_remove(struct fw_unit *unit)
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 7be0ea4..bac2e58 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -20,11 +20,16 @@
 
 #include <sound/core.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 
 #define SND_FF_STREAM_MODES		3
 
+#define SND_FF_MAXIMIM_MIDI_QUADS	9
+#define SND_FF_IN_MIDI_PORTS		2
+#define SND_FF_OUT_MIDI_PORTS		2
+
 struct snd_ff_protocol;
 struct snd_ff_spec {
 	const char *const name;
@@ -47,6 +52,20 @@ struct snd_ff {
 	struct delayed_work dwork;
 
 	const struct snd_ff_spec *spec;
+
+	/* To handle MIDI tx. */
+	struct snd_rawmidi_substream *tx_midi_substreams[SND_FF_IN_MIDI_PORTS];
+	struct fw_address_handler async_handler;
+
+	/* TO handle MIDI rx. */
+	struct snd_rawmidi_substream *rx_midi_substreams[SND_FF_OUT_MIDI_PORTS];
+	u8 running_status[SND_FF_OUT_MIDI_PORTS];
+	__le32 msg_buf[SND_FF_OUT_MIDI_PORTS][SND_FF_MAXIMIM_MIDI_QUADS];
+	struct work_struct rx_midi_work[SND_FF_OUT_MIDI_PORTS];
+	struct fw_transaction transactions[SND_FF_OUT_MIDI_PORTS];
+	ktime_t next_ktime[SND_FF_OUT_MIDI_PORTS];
+	bool rx_midi_error[SND_FF_OUT_MIDI_PORTS];
+	unsigned int rx_bytes[SND_FF_OUT_MIDI_PORTS];
 };
 
 enum snd_ff_clock_src {
@@ -75,4 +94,8 @@ struct snd_ff_protocol {
 	u64 midi_rx_port_1_reg;
 };
 
+int snd_ff_transaction_register(struct snd_ff *ff);
+int snd_ff_transaction_reregister(struct snd_ff *ff);
+void snd_ff_transaction_unregister(struct snd_ff *ff);
+
 #endif
-- 
2.9.3
