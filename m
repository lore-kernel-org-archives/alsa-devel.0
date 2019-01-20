From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/9] ALSA: fireface: unify protocol layer for
	FF400/FF800
Date: Sun, 20 Jan 2019 17:25:46 +0900
Message-ID: <20190120082553.17347-3-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 753D5266A89
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:13 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id gn14so8299065plb.10
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:13 -0800 (PST)
In-Reply-To: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
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

This commit moves codes for Fireface 400 to a file of former protocol.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile             |   3 +-
 sound/firewire/fireface/ff-protocol-ff400.c  | 161 -------------------
 sound/firewire/fireface/ff-protocol-former.c | 147 +++++++++++++++++
 3 files changed, 148 insertions(+), 163 deletions(-)
 delete mode 100644 sound/firewire/fireface/ff-protocol-ff400.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 3fb586d32584..62eb78962b93 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,4 +1,3 @@
 snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o \
-		     ff-stream.o ff-pcm.o ff-hwdep.o ff-protocol-ff400.o \
-		     ff-protocol-former.o
+		     ff-stream.o ff-pcm.o ff-hwdep.o ff-protocol-former.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
deleted file mode 100644
index 2280fab9b3c7..000000000000
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * ff-protocol-ff400.c - a part of driver for RME Fireface series
- *
- * Copyright (c) 2015-2017 Takashi Sakamoto
- *
- * Licensed under the terms of the GNU General Public License, version 2.
- */
-
-#include <linux/delay.h>
-#include "ff.h"
-
-#define FF400_STF		0x000080100500ull
-#define FF400_RX_PACKET_FORMAT	0x000080100504ull
-#define FF400_ISOC_COMM_START	0x000080100508ull
-#define FF400_TX_PACKET_FORMAT	0x00008010050cull
-#define FF400_ISOC_COMM_STOP	0x000080100510ull
-
-/*
- * Fireface 400 manages isochronous channel number in 3 bit field. Therefore,
- * we can allocate between 0 and 7 channel.
- */
-static int keep_resources(struct snd_ff *ff, unsigned int rate)
-{
-	enum snd_ff_stream_mode mode;
-	int i;
-	int err;
-
-	// Check whether the given value is supported or not.
-	for (i = 0; i < CIP_SFC_COUNT; i++) {
-		if (amdtp_rate_table[i] == rate)
-			break;
-	}
-	if (i >= CIP_SFC_COUNT)
-		return -EINVAL;
-
-	err = snd_ff_stream_get_multiplier_mode(i, &mode);
-	if (err < 0)
-		return err;
-
-	/* Keep resources for in-stream. */
-	ff->tx_resources.channels_mask = 0x00000000000000ffuLL;
-	err = fw_iso_resources_allocate(&ff->tx_resources,
-			amdtp_stream_get_max_payload(&ff->tx_stream),
-			fw_parent_device(ff->unit)->max_speed);
-	if (err < 0)
-		return err;
-
-	/* Keep resources for out-stream. */
-	err = amdtp_ff_set_parameters(&ff->rx_stream, rate,
-				      ff->spec->pcm_playback_channels[mode]);
-	if (err < 0)
-		return err;
-	ff->rx_resources.channels_mask = 0x00000000000000ffuLL;
-	err = fw_iso_resources_allocate(&ff->rx_resources,
-			amdtp_stream_get_max_payload(&ff->rx_stream),
-			fw_parent_device(ff->unit)->max_speed);
-	if (err < 0)
-		fw_iso_resources_free(&ff->tx_resources);
-
-	return err;
-}
-
-static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
-{
-	__le32 reg;
-	int err;
-
-	err = keep_resources(ff, rate);
-	if (err < 0)
-		return err;
-
-	/* Set the number of data blocks transferred in a second. */
-	reg = cpu_to_le32(rate);
-	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 FF400_STF, &reg, sizeof(reg), 0);
-	if (err < 0)
-		return err;
-
-	msleep(100);
-
-	/*
-	 * Set isochronous channel and the number of quadlets of received
-	 * packets.
-	 */
-	reg = cpu_to_le32(((ff->rx_stream.data_block_quadlets << 3) << 8) |
-			  ff->rx_resources.channel);
-	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 FF400_RX_PACKET_FORMAT, &reg, sizeof(reg), 0);
-	if (err < 0)
-		return err;
-
-	/*
-	 * Set isochronous channel and the number of quadlets of transmitted
-	 * packet.
-	 */
-	/* TODO: investigate the purpose of this 0x80. */
-	reg = cpu_to_le32((0x80 << 24) |
-			  (ff->tx_resources.channel << 5) |
-			  (ff->tx_stream.data_block_quadlets));
-	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 FF400_TX_PACKET_FORMAT, &reg, sizeof(reg), 0);
-	if (err < 0)
-		return err;
-
-	/* Allow to transmit packets. */
-	reg = cpu_to_le32(0x00000001);
-	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 FF400_ISOC_COMM_START, &reg, sizeof(reg), 0);
-}
-
-static void ff400_finish_session(struct snd_ff *ff)
-{
-	__le32 reg;
-
-	reg = cpu_to_le32(0x80000000);
-	snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   FF400_ISOC_COMM_STOP, &reg, sizeof(reg), 0);
-}
-
-static void ff400_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
-{
-	int i;
-
-	for (i = 0; i < length / 4; i++) {
-		u32 quad = le32_to_cpu(buf[i]);
-		u8 byte;
-		unsigned int index;
-		struct snd_rawmidi_substream *substream;
-
-		/* Message in first port. */
-		/*
-		 * This value may represent the index of this unit when the same
-		 * units are on the same IEEE 1394 bus. This driver doesn't use
-		 * it.
-		 */
-		index = (quad >> 8) & 0xff;
-		if (index > 0) {
-			substream = READ_ONCE(ff->tx_midi_substreams[0]);
-			if (substream != NULL) {
-				byte = quad & 0xff;
-				snd_rawmidi_receive(substream, &byte, 1);
-			}
-		}
-
-		/* Message in second port. */
-		index = (quad >> 24) & 0xff;
-		if (index > 0) {
-			substream = READ_ONCE(ff->tx_midi_substreams[1]);
-			if (substream != NULL) {
-				byte = (quad >> 16) & 0xff;
-				snd_rawmidi_receive(substream, &byte, 1);
-			}
-		}
-	}
-}
-
-const struct snd_ff_protocol snd_ff_protocol_ff400 = {
-	.handle_midi_msg	= ff400_handle_midi_msg,
-	.begin_session		= ff400_begin_session,
-	.finish_session		= ff400_finish_session,
-};
diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index a383fd5fc879..ed1271a89484 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -140,3 +140,150 @@ const struct snd_ff_protocol snd_ff_protocol_ff800 = {
 	.begin_session		= ff800_begin_session,
 	.finish_session		= ff800_finish_session,
 };
+
+#define FF400_STF		0x000080100500ull
+#define FF400_RX_PACKET_FORMAT	0x000080100504ull
+#define FF400_ISOC_COMM_START	0x000080100508ull
+#define FF400_TX_PACKET_FORMAT	0x00008010050cull
+#define FF400_ISOC_COMM_STOP	0x000080100510ull
+
+/*
+ * Fireface 400 manages isochronous channel number in 3 bit field. Therefore,
+ * we can allocate between 0 and 7 channel.
+ */
+static int keep_resources(struct snd_ff *ff, unsigned int rate)
+{
+	enum snd_ff_stream_mode mode;
+	int i;
+	int err;
+
+	// Check whether the given value is supported or not.
+	for (i = 0; i < CIP_SFC_COUNT; i++) {
+		if (amdtp_rate_table[i] == rate)
+			break;
+	}
+	if (i >= CIP_SFC_COUNT)
+		return -EINVAL;
+
+	err = snd_ff_stream_get_multiplier_mode(i, &mode);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for in-stream. */
+	ff->tx_resources.channels_mask = 0x00000000000000ffuLL;
+	err = fw_iso_resources_allocate(&ff->tx_resources,
+			amdtp_stream_get_max_payload(&ff->tx_stream),
+			fw_parent_device(ff->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for out-stream. */
+	ff->rx_resources.channels_mask = 0x00000000000000ffuLL;
+	err = fw_iso_resources_allocate(&ff->rx_resources,
+			amdtp_stream_get_max_payload(&ff->rx_stream),
+			fw_parent_device(ff->unit)->max_speed);
+	if (err < 0)
+		fw_iso_resources_free(&ff->tx_resources);
+
+	return err;
+}
+
+static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
+{
+	__le32 reg;
+	int err;
+
+	err = keep_resources(ff, rate);
+	if (err < 0)
+		return err;
+
+	/* Set the number of data blocks transferred in a second. */
+	reg = cpu_to_le32(rate);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 FF400_STF, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	msleep(100);
+
+	/*
+	 * Set isochronous channel and the number of quadlets of received
+	 * packets.
+	 */
+	reg = cpu_to_le32(((ff->rx_stream.data_block_quadlets << 3) << 8) |
+			  ff->rx_resources.channel);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 FF400_RX_PACKET_FORMAT, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	/*
+	 * Set isochronous channel and the number of quadlets of transmitted
+	 * packet.
+	 */
+	/* TODO: investigate the purpose of this 0x80. */
+	reg = cpu_to_le32((0x80 << 24) |
+			  (ff->tx_resources.channel << 5) |
+			  (ff->tx_stream.data_block_quadlets));
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 FF400_TX_PACKET_FORMAT, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	/* Allow to transmit packets. */
+	reg = cpu_to_le32(0x00000001);
+	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 FF400_ISOC_COMM_START, &reg, sizeof(reg), 0);
+}
+
+static void ff400_finish_session(struct snd_ff *ff)
+{
+	__le32 reg;
+
+	reg = cpu_to_le32(0x80000000);
+	snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   FF400_ISOC_COMM_STOP, &reg, sizeof(reg), 0);
+}
+
+static void ff400_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
+{
+	int i;
+
+	for (i = 0; i < length / 4; i++) {
+		u32 quad = le32_to_cpu(buf[i]);
+		u8 byte;
+		unsigned int index;
+		struct snd_rawmidi_substream *substream;
+
+		/* Message in first port. */
+		/*
+		 * This value may represent the index of this unit when the same
+		 * units are on the same IEEE 1394 bus. This driver doesn't use
+		 * it.
+		 */
+		index = (quad >> 8) & 0xff;
+		if (index > 0) {
+			substream = READ_ONCE(ff->tx_midi_substreams[0]);
+			if (substream != NULL) {
+				byte = quad & 0xff;
+				snd_rawmidi_receive(substream, &byte, 1);
+			}
+		}
+
+		/* Message in second port. */
+		index = (quad >> 24) & 0xff;
+		if (index > 0) {
+			substream = READ_ONCE(ff->tx_midi_substreams[1]);
+			if (substream != NULL) {
+				byte = (quad >> 16) & 0xff;
+				snd_rawmidi_receive(substream, &byte, 1);
+			}
+		}
+	}
+}
+
+const struct snd_ff_protocol snd_ff_protocol_ff400 = {
+	.handle_midi_msg	= ff400_handle_midi_msg,
+	.begin_session		= ff400_begin_session,
+	.finish_session		= ff400_finish_session,
+};
-- 
2.19.1
