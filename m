From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/6] ALSA: fireface: add protocol-specific
	operation to fill transaction buffer with MIDI messages
Date: Tue, 22 Jan 2019 22:17:04 +0900
Message-ID: <20190122131705.23213-6-o-takashi@sakamocchi.jp>
References: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A3D4D2674C0
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 14:17:23 +0100 (CET)
Received: by mail-pg1-f196.google.com with SMTP id n2so11073946pgm.3
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 05:17:23 -0800 (PST)
In-Reply-To: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Between former and latter models, content of asynchronous transaction
for MIDI messages from driver to device is different.

This commit is a preparation to support latter models. A protocol-specific
operation is added to encode MIDI messages to the transaction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-former.c | 23 +++++++++++++++
 sound/firewire/fireface/ff-transaction.c     | 31 ++++++++------------
 sound/firewire/fireface/ff.h                 |  3 ++
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index 266e4892a818..e0acf40a02ee 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -263,6 +263,27 @@ static void former_dump_status(struct snd_ff *ff,
 	dump_sync_status(ff, buffer);
 }
 
+static int former_fill_midi_msg(struct snd_ff *ff,
+				struct snd_rawmidi_substream *substream,
+				unsigned int port)
+{
+	u8 *buf = (u8 *)ff->msg_buf[port];
+	int len;
+	int i;
+
+	len = snd_rawmidi_transmit_peek(substream, buf,
+					SND_FF_MAXIMIM_MIDI_QUADS);
+	if (len <= 0)
+		return len;
+
+	// One quadlet includes one byte.
+	for (i = len - 1; i >= 0; --i)
+		ff->msg_buf[port][i] = cpu_to_le32(buf[i]);
+	ff->rx_bytes[port] = len;
+
+	return len;
+}
+
 #define FF800_STF		0x0000fc88f000
 #define FF800_RX_PACKET_FORMAT	0x0000fc88f004
 #define FF800_ALLOC_TX_STREAM	0x0000fc88f008
@@ -392,6 +413,7 @@ static void ff800_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
 
 const struct snd_ff_protocol snd_ff_protocol_ff800 = {
 	.handle_midi_msg	= ff800_handle_midi_msg,
+	.fill_midi_msg		= former_fill_midi_msg,
 	.get_clock		= former_get_clock,
 	.switch_fetching_mode	= former_switch_fetching_mode,
 	.begin_session		= ff800_begin_session,
@@ -543,6 +565,7 @@ static void ff400_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
 
 const struct snd_ff_protocol snd_ff_protocol_ff400 = {
 	.handle_midi_msg	= ff400_handle_midi_msg,
+	.fill_midi_msg		= former_fill_midi_msg,
 	.get_clock		= former_get_clock,
 	.switch_fetching_mode	= former_switch_fetching_mode,
 	.begin_session		= ff400_begin_session,
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 92ca76ab7537..d8a8b01b39a1 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -51,23 +51,17 @@ static void finish_transmit_midi1_msg(struct fw_card *card, int rcode,
 	finish_transmit_midi_msg(ff, 1, rcode);
 }
 
-static inline void fill_midi_buf(struct snd_ff *ff, unsigned int port,
-				 unsigned int index, u8 byte)
-{
-	ff->msg_buf[port][index] = cpu_to_le32(byte);
-}
-
 static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
 {
 	struct snd_rawmidi_substream *substream =
 			READ_ONCE(ff->rx_midi_substreams[port]);
-	u8 *buf = (u8 *)ff->msg_buf[port];
-	int i, len;
+	int quad_count;
 
 	struct fw_device *fw_dev = fw_parent_device(ff->unit);
 	unsigned long long addr;
 	int generation;
 	fw_transaction_callback_t callback;
+	int tcode;
 
 	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
 		return;
@@ -81,14 +75,10 @@ static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
 		return;
 	}
 
-	len = snd_rawmidi_transmit_peek(substream, buf,
-					SND_FF_MAXIMIM_MIDI_QUADS);
-	if (len <= 0)
+	quad_count = ff->spec->protocol->fill_midi_msg(ff, substream, port);
+	if (quad_count <= 0)
 		return;
 
-	for (i = len - 1; i >= 0; i--)
-		fill_midi_buf(ff, port, i, buf[i]);
-
 	if (port == 0) {
 		addr = ff->spec->midi_rx_addrs[0];
 		callback = finish_transmit_midi0_msg;
@@ -99,8 +89,12 @@ static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
 
 	/* Set interval to next transaction. */
 	ff->next_ktime[port] = ktime_add_ns(ktime_get(),
-					    len * 8 * NSEC_PER_SEC / 31250);
-	ff->rx_bytes[port] = len;
+				ff->rx_bytes[port] * 8 * NSEC_PER_SEC / 31250);
+
+	if (quad_count == 1)
+		tcode = TCODE_WRITE_QUADLET_REQUEST;
+	else
+		tcode = TCODE_WRITE_BLOCK_REQUEST;
 
 	/*
 	 * In Linux FireWire core, when generation is updated with memory
@@ -112,10 +106,9 @@ static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
 	 */
 	generation = fw_dev->generation;
 	smp_rmb();
-	fw_send_request(fw_dev->card, &ff->transactions[port],
-			TCODE_WRITE_BLOCK_REQUEST,
+	fw_send_request(fw_dev->card, &ff->transactions[port], tcode,
 			fw_dev->node_id, generation, fw_dev->max_speed,
-			addr, &ff->msg_buf[port], len * 4,
+			addr, &ff->msg_buf[port], quad_count * 4,
 			callback, &ff->transactions[port]);
 }
 
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index edad75a4b260..e52ad11803e0 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -107,6 +107,9 @@ enum snd_ff_clock_src {
 struct snd_ff_protocol {
 	void (*handle_midi_msg)(struct snd_ff *ff, unsigned int offset,
 				__le32 *buf, size_t length);
+	int (*fill_midi_msg)(struct snd_ff *ff,
+			     struct snd_rawmidi_substream *substream,
+			     unsigned int port);
 	int (*get_clock)(struct snd_ff *ff, unsigned int *rate,
 			 enum snd_ff_clock_src *src);
 	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
-- 
2.19.1
