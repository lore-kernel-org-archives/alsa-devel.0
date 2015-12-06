From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] fireface: add transaction support
Date: Sun,  6 Dec 2015 22:23:43 +0900
Message-ID: <1449408224-13955-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id F3CA926546A
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 14:23:49 +0100 (CET)
In-Reply-To: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
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

RME Fireface series doesn't transfer MIDI messages on isochronous packets.
The messages are transferred in asynchronous transactions.

The unit handles MIDI messages in asynchronous transactions transmitted in
two addresses; 0x000008018000 and 0x000008019000. These two are
corresponding to physical MIDI port 1 and 2.

The unit transfers MIDI messages by asynchronous transactions to certain
addresses. Drivers can decide 4 byte in LSB of the addresses by a write
transaction to 0x0000801003f4. Drivers have four options to the rest;
0x000000000, 0x00000080, 0x00000100, 0x00000180. Drivers can enable them
by write transactions to 0x00008010051c. This register may consist of
bit flags and writing zero bit has no effect. Reading this register
always returns 0x00000000. In this mechanism, drivers cannot use Private
space of IEEE 1212 in which they allow to add some side effects to
read/write transactions.

This commit adds transaction support for MIDI messaging. To receive
asynchronous transactions, the driver allocates a range of address in
Memory space. The driver selects 0x00000000 as the 8 byte of LSB of the
address, thus the driver retries to allocate when gaining unusable range.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile               |   2 +-
 sound/firewire/fireface/fireface-transaction.c | 388 +++++++++++++++++++++++++
 sound/firewire/fireface/fireface.c             |  10 +-
 sound/firewire/fireface/fireface.h             |  30 ++
 4 files changed, 428 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/fireface/fireface-transaction.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index f7113ab..aa52e41 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,2 +1,2 @@
-snd-fireface-objs := fireface.o
+snd-fireface-objs := fireface.o fireface-transaction.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/fireface-transaction.c b/sound/firewire/fireface/fireface-transaction.c
new file mode 100644
index 0000000..07a2b9c
--- /dev/null
+++ b/sound/firewire/fireface/fireface-transaction.c
@@ -0,0 +1,388 @@
+/*
+ * fireface-transaction.c - a part of driver for RMW Fireface series
+ *
+ * Copyright (c) 2015-2016 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "fireface.h"
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
+		ff->next_ktime[port] = ktime_set(0, 0);
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
+	ff->msg_buf[port][index] = cpu_to_be32((byte << 8) << 16);
+}
+
+static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
+{
+	struct snd_rawmidi_substream *substream =
+			ACCESS_ONCE(ff->rx_midi_substreams[port]);
+	u8 *buf = (u8 *)ff->msg_buf[port];
+	u8 status;
+	int i, consume, len;
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
+	/* Retrieve one MIDI byte to calculate length of the message. */
+	len = snd_rawmidi_transmit_peek(substream, buf,
+					SND_FF_MAXIMIM_MIDI_QUADS);
+	if (len <= 0)
+		return;
+
+	/* Not on system exclusives. */
+	if (ff->running_status[port] != 0xf0 && *buf != 0xf0) {
+		/* On running-status. */
+		if ((*buf & 0x80) != 0x80)
+			status = ff->running_status[port];
+		else
+			status = *buf;
+
+		/* Calculate consume bytes. */
+		consume = calculate_message_bytes(status);
+		if (consume <= 0)
+			return;
+
+		/* On running-status. */
+		if ((*buf & 0x80) != 0x80) {
+			if (len < consume - 1)
+				return;
+			consume -= 1;
+		} else {
+			if (len < consume)
+				return;
+			ff->running_status[port] = *buf;
+		}
+	} else {
+		/* On system exclusives. */
+		ff->running_status[port] = 0xf0;
+
+		/* Seek the end of exclusives. */
+		consume = 1;
+		for (i = 0; i < len; i++) {
+			if (buf[i] == 0xf7) {
+				ff->running_status[port] = 0x00;
+				break;
+			}
+			consume++;
+		}
+	}
+
+	for (i = consume - 1; i >= 0; i--)
+		fill_midi_buf(ff, port, i, buf[i]);
+
+	if (port == 0) {
+		addr = SND_FF_ADDR_MIDI_RX_PORT_0;
+		callback = finish_transmit_midi0_msg;
+	} else {
+		addr = SND_FF_ADDR_MIDI_RX_PORT_1;
+		callback = finish_transmit_midi1_msg;
+	}
+
+	/* Set interval to next transaction. */
+	ff->next_ktime[port] = ktime_add_ns(ktime_get(),
+					    consume * NSEC_PER_SEC / 3125);
+	ff->rx_bytes[port] = consume;
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
+
+	/* Wait response. */
+	fw_send_request(fw_dev->card, &ff->transactions[port],
+			TCODE_WRITE_BLOCK_REQUEST,
+			fw_dev->node_id, generation, fw_dev->max_speed,
+			addr, &ff->msg_buf[port], consume * 4,
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
+	__be32 *buf = data;
+	u32 quad;
+	u8 byte;
+	unsigned int index;
+	struct snd_rawmidi_substream *substream;
+	int i;
+
+	fw_send_response(card, request, RCODE_COMPLETE);
+
+	for (i = 0; i < length / 4; i++) {
+		quad = be32_to_cpu(buf[i]);
+
+		/* Message in first port. */
+		/*
+		 * This value may represent the index of this unit when the
+		 * same units are on the same IEEE 1394 bus. This driver don't
+		 * use it.
+		 */
+		index = (quad >> 16) & 0xff;
+		if (index > 0) {
+			substream = ACCESS_ONCE(ff->tx_midi_substreams[0]);
+			if (substream != NULL) {
+				byte = (quad >> 24) & 0xff;
+				snd_rawmidi_receive(substream, &byte, 1);
+			}
+		}
+
+		/* Message in second port. */
+		index = quad & 0xff;
+		if (index > 0) {
+			substream = ACCESS_ONCE(ff->tx_midi_substreams[1]);
+			if (substream != NULL) {
+				byte = (quad >> 8) & 0xff;
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
+	midi_msg_region.start = 0x000100000000 * i;
+	midi_msg_region.end = midi_msg_region.start + ff->async_handler.length;
+
+	err = fw_core_add_address_handler(&ff->async_handler, &midi_msg_region);
+	if (err >= 0) {
+		/* Controllers register this region of address. */
+		if (ff->async_handler.offset & 0x0000ffffffff) {
+			fw_core_remove_address_handler(&ff->async_handler);
+			err = -EAGAIN;
+		}
+	}
+
+	return err;
+}
+
+int snd_ff_transaction_reregister(struct snd_ff *ff)
+{
+	struct fw_card *fw_card = fw_parent_device(ff->unit)->card;
+	u32 addr;
+	__be32 reg;
+	int err;
+
+	/*
+	 * Controllers are allowed to register its node ID and 2 byte in MSB of
+	 * address to listen asynchronous transactions. This is the reason we
+	 * should pay attension to allocating the address.
+	 *
+	 * And the value of this register is aligned to little endian.
+	 */
+	addr = (fw_card->node_id << 16) | (ff->async_handler.offset >> 32);
+	reg = cpu_to_le32(addr);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 SND_FF_ADDR_CONTROLLER_ADDR_HI,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	/*
+	 * The 3rd-6th bits in LSB of this register are used to indicate fixed
+	 * offset of address to transfer asynchronous transaction.
+	 *  - 6th: 0x00000180
+	 *  - 5th: 0x00000100
+	 *  - 4th: 0x00000080
+	 *  - 3rd: 0x00000000
+	 *
+	 * Here, 3rd bit is used because controllers are not allowed to register
+	 * arbitrary address for this purpose.
+	 *
+	 * The 7th-8th bits in LSB of this register are used to the other
+	 * purpose.
+	 *
+	 * The 1st-2nd bits in LSB of this register are used to cancel
+	 * transferring asynchronous transactions. These two bits have the same
+	 * effect.
+	 * - 1st/2nd: cancel transferring
+	 *
+	 * the value of zero for each bits has no meaning in this register.
+	 */
+	reg = cpu_to_be32(0x00000004);
+	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  SND_FF_ADDR_GENERAL_PARAMS,
+				  &reg, sizeof(reg), 0);
+}
+
+int snd_ff_transaction_register(struct snd_ff *ff)
+{
+	int i, err;
+
+	/*
+	 * Allocate in Memory Space of IEC 13213, but 8 byte in LSB should be
+	 * zero due to device specification.
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
+	__be32 reg;
+
+	/* Stop transferring and listening. */
+	reg = cpu_to_be32(0x00000003);
+	snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+			  SND_FF_ADDR_GENERAL_PARAMS,
+			  &reg, sizeof(reg), 0);
+
+	reg = cpu_to_le32(0x00000000);
+	snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   SND_FF_ADDR_CONTROLLER_ADDR_HI,
+			   &reg, sizeof(reg), 0);
+
+	fw_core_remove_address_handler(&ff->async_handler);
+}
diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
index 7e21667..d9cfac2 100644
--- a/sound/firewire/fireface/fireface.c
+++ b/sound/firewire/fireface/fireface.c
@@ -38,6 +38,8 @@ static void ff_card_free(struct snd_card *card)
 {
 	struct snd_ff *ff = card->private_data;
 
+	snd_ff_transaction_unregister(ff);
+
 	fw_unit_put(ff->unit);
 
 	mutex_destroy(&ff->mutex);
@@ -74,6 +76,10 @@ static int snd_ff_probe(struct fw_unit *unit,
 	 * bus resets.
 	 */
 
+	err = snd_ff_transaction_register(ff);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
@@ -86,7 +92,9 @@ error:
 
 static void snd_ff_update(struct fw_unit *unit)
 {
-	return;
+	struct snd_ff *ff = dev_get_drvdata(&unit->device);
+
+	snd_ff_transaction_reregister(ff);
 }
 
 static void snd_ff_remove(struct fw_unit *unit)
diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
index e72d53f..914472a 100644
--- a/sound/firewire/fireface/fireface.h
+++ b/sound/firewire/fireface/fireface.h
@@ -31,11 +31,41 @@
 #include "../amdtp-stream.h"
 #include "../iso-resources.h"
 
+#define SND_FF_MAXIMIM_MIDI_QUADS	9
+#define SND_FF_IN_MIDI_PORTS		2
+#define SND_FF_OUT_MIDI_PORTS		2
+
 struct snd_ff {
 	struct snd_card *card;
 	struct fw_unit *unit;
 
 	struct mutex mutex;
 	spinlock_t lock;
+
+	/* To handle MIDI tx. */
+	struct snd_rawmidi_substream *tx_midi_substreams[SND_FF_IN_MIDI_PORTS];
+	struct fw_address_handler async_handler;
+
+	/* TO handle MIDI rx. */
+	struct snd_rawmidi_substream *rx_midi_substreams[SND_FF_OUT_MIDI_PORTS];
+	u8 running_status[SND_FF_OUT_MIDI_PORTS];
+	__be32 msg_buf[SND_FF_OUT_MIDI_PORTS][SND_FF_MAXIMIM_MIDI_QUADS];
+	struct work_struct rx_midi_work[SND_FF_OUT_MIDI_PORTS];
+	struct fw_transaction transactions[SND_FF_OUT_MIDI_PORTS];
+	ktime_t next_ktime[SND_FF_OUT_MIDI_PORTS];
+	bool rx_midi_error[SND_FF_OUT_MIDI_PORTS];
+	unsigned int rx_bytes[SND_FF_OUT_MIDI_PORTS];
 };
+
+#define SND_FF_ADDR_CONTROLLER_ADDR_HI	0x0000801003f4
+#define SND_FF_ADDR_GENERAL_PARAMS	0x00008010051c
+#define SND_FF_ADDR_MIDI_RX_PORT_0	0x000080180000
+#define SND_FF_ADDR_MIDI_RX_PORT_1	0x000080190000
+
+#define SND_FF_ADDR_MIDI_TX		0x000100000000
+
+int snd_ff_transaction_register(struct snd_ff *ff);
+int snd_ff_transaction_reregister(struct snd_ff *ff);
+void snd_ff_transaction_unregister(struct snd_ff *ff);
+
 #endif
-- 
2.5.0
