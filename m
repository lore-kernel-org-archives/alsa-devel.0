From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/18] ALSA: firewire-motu: add stream
	management functionality
Date: Wed, 22 Mar 2017 21:30:20 +0900
Message-ID: <20170322123028.24148-11-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E63172673C2
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:42 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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

This commit adds a functionality to manage packet streaming for MOTU
FireWire series.

The streaming is not controlled by CMP, thus against IEC 61883-1. Write
transaction to certain addresses start/stop packet streaming.

Transactions to 0x'ffff'f000'0b00 results in isochronous channel number for
both directions and starting/stopping transmission of packets. The
isochronous channel number is represented in 6 bit field, thus units can
identify the channels up to 64, as IEEE 1394 bus specification described.

Transactions to 0x'ffff'f000'0b10 results in packet format for both
directions and transmission speed. When each of data block includes fixed
part of data chunks only, corresponding flags stand.

When bus reset occurs, the units continue to transmit packets with
non-contiguous data block counter. This causes discontinuity detection in
packet streaming engine and ALSA PCM applications receives EPIPE from any
I/O operation. In this case, typical applications manage to recover
corresponding PCM substream. This behaviour is kicked much earlier than
callback of bus reset handler by Linux FireWire subsystem, therefore
status of packet streaming is not changed in the handler.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile      |   2 +-
 sound/firewire/motu/motu-stream.c | 340 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c        |   5 +
 sound/firewire/motu/motu.h        |  10 ++
 4 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-stream.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index 03b0769..504a4f9 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o
+snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
new file mode 100644
index 0000000..9aa698f
--- /dev/null
+++ b/sound/firewire/motu/motu-stream.c
@@ -0,0 +1,340 @@
+/*
+ * motu-stream.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "motu.h"
+
+#define	CALLBACK_TIMEOUT	200
+
+#define ISOC_COMM_CONTROL_OFFSET		0x0b00
+#define  ISOC_COMM_CONTROL_MASK			0xffff0000
+#define  CHANGE_RX_ISOC_COMM_STATE		0x80000000
+#define  RX_ISOC_COMM_IS_ACTIVATED		0x40000000
+#define  RX_ISOC_COMM_CHANNEL_MASK		0x3f000000
+#define  RX_ISOC_COMM_CHANNEL_SHIFT		24
+#define  CHANGE_TX_ISOC_COMM_STATE		0x00800000
+#define  TX_ISOC_COMM_IS_ACTIVATED		0x00400000
+#define  TX_ISOC_COMM_CHANNEL_MASK		0x003f0000
+#define  TX_ISOC_COMM_CHANNEL_SHIFT		16
+
+#define PACKET_FORMAT_OFFSET			0x0b10
+#define  TX_PACKET_EXCLUDE_DIFFERED_DATA_CHUNKS	0x00000080
+#define  RX_PACKET_EXCLUDE_DIFFERED_DATA_CHUNKS	0x00000040
+#define  TX_PACKET_TRANSMISSION_SPEED_MASK	0x0000000f
+
+static int start_both_streams(struct snd_motu *motu, unsigned int rate)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	/* Set packet formation to our packet streaming engine. */
+	err = amdtp_motu_set_parameters(&motu->rx_stream, rate,
+					&motu->rx_packet_formats);
+	if (err < 0)
+		return err;
+
+	err = amdtp_motu_set_parameters(&motu->tx_stream, rate,
+					&motu->tx_packet_formats);
+	if (err < 0)
+		return err;
+
+
+	/* Get isochronous resources on the bus. */
+	err = fw_iso_resources_allocate(&motu->rx_resources,
+				amdtp_stream_get_max_payload(&motu->rx_stream),
+				fw_parent_device(motu->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	err = fw_iso_resources_allocate(&motu->tx_resources,
+				amdtp_stream_get_max_payload(&motu->tx_stream),
+				fw_parent_device(motu->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	/* Configure the unit to start isochronous communication. */
+	err = snd_motu_transaction_read(motu, ISOC_COMM_CONTROL_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg) & ~ISOC_COMM_CONTROL_MASK;
+
+	data |= CHANGE_RX_ISOC_COMM_STATE | RX_ISOC_COMM_IS_ACTIVATED |
+		(motu->rx_resources.channel << RX_ISOC_COMM_CHANNEL_SHIFT) |
+		CHANGE_TX_ISOC_COMM_STATE | TX_ISOC_COMM_IS_ACTIVATED |
+		(motu->tx_resources.channel << TX_ISOC_COMM_CHANNEL_SHIFT);
+
+	reg = cpu_to_be32(data);
+	return snd_motu_transaction_write(motu, ISOC_COMM_CONTROL_OFFSET, &reg,
+					  sizeof(reg));
+}
+
+static void stop_both_streams(struct snd_motu *motu)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = motu->spec->protocol->switch_fetching_mode(motu, false);
+	if (err < 0)
+		return;
+
+	err = snd_motu_transaction_read(motu, ISOC_COMM_CONTROL_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return;
+	data = be32_to_cpu(reg);
+
+	data &= ~(RX_ISOC_COMM_IS_ACTIVATED | TX_ISOC_COMM_IS_ACTIVATED);
+	data |= CHANGE_RX_ISOC_COMM_STATE | CHANGE_TX_ISOC_COMM_STATE;
+
+	reg = cpu_to_be32(data);
+	snd_motu_transaction_write(motu, ISOC_COMM_CONTROL_OFFSET, &reg,
+				   sizeof(reg));
+
+	fw_iso_resources_free(&motu->tx_resources);
+	fw_iso_resources_free(&motu->rx_resources);
+}
+
+static int start_isoc_ctx(struct snd_motu *motu, struct amdtp_stream *stream)
+{
+	struct fw_iso_resources *resources;
+	int err;
+
+	if (stream == &motu->rx_stream)
+		resources = &motu->rx_resources;
+	else
+		resources = &motu->tx_resources;
+
+	err = amdtp_stream_start(stream, resources->channel,
+				 fw_parent_device(motu->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	if (!amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT)) {
+		amdtp_stream_stop(stream);
+		fw_iso_resources_free(resources);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void stop_isoc_ctx(struct snd_motu *motu, struct amdtp_stream *stream)
+{
+	struct fw_iso_resources *resources;
+
+	if (stream == &motu->rx_stream)
+		resources = &motu->rx_resources;
+	else
+		resources = &motu->tx_resources;
+
+	amdtp_stream_stop(stream);
+	fw_iso_resources_free(resources);
+}
+
+static int ensure_packet_formats(struct snd_motu *motu)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_motu_transaction_read(motu, PACKET_FORMAT_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	data &= ~(TX_PACKET_EXCLUDE_DIFFERED_DATA_CHUNKS |
+		  RX_PACKET_EXCLUDE_DIFFERED_DATA_CHUNKS|
+		  TX_PACKET_TRANSMISSION_SPEED_MASK);
+	if (motu->tx_packet_formats.differed_part_pcm_chunks[0] == 0)
+		data |= TX_PACKET_EXCLUDE_DIFFERED_DATA_CHUNKS;
+	if (motu->rx_packet_formats.differed_part_pcm_chunks[0] == 0)
+		data |= RX_PACKET_EXCLUDE_DIFFERED_DATA_CHUNKS;
+	data |= fw_parent_device(motu->unit)->max_speed;
+
+	reg = cpu_to_be32(data);
+	return snd_motu_transaction_write(motu, PACKET_FORMAT_OFFSET, &reg,
+					  sizeof(reg));
+}
+
+int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
+{
+	const struct snd_motu_protocol *protocol = motu->spec->protocol;
+	unsigned int curr_rate;
+	int err = 0;
+
+	if (motu->capture_substreams == 0 && motu->playback_substreams == 0)
+		return 0;
+
+	/* Some packet queueing errors. */
+	if (amdtp_streaming_error(&motu->rx_stream) ||
+	    amdtp_streaming_error(&motu->tx_stream)) {
+		amdtp_stream_stop(&motu->rx_stream);
+		amdtp_stream_stop(&motu->tx_stream);
+		stop_both_streams(motu);
+	}
+
+	err = protocol->cache_packet_formats(motu);
+	if (err < 0)
+		return err;
+
+	/* Stop stream if rate is different. */
+	err = protocol->get_clock_rate(motu, &curr_rate);
+	if (err < 0) {
+		dev_err(&motu->unit->device,
+			"fail to get sampling rate: %d\n", err);
+		return err;
+	}
+	if (rate == 0)
+		rate = curr_rate;
+	if (rate != curr_rate) {
+		amdtp_stream_stop(&motu->rx_stream);
+		amdtp_stream_stop(&motu->tx_stream);
+		stop_both_streams(motu);
+	}
+
+	if (!amdtp_stream_running(&motu->rx_stream)) {
+		err = protocol->set_clock_rate(motu, rate);
+		if (err < 0) {
+			dev_err(&motu->unit->device,
+				"fail to set sampling rate: %d\n", err);
+			return err;
+		}
+
+		err = ensure_packet_formats(motu);
+		if (err < 0)
+			return err;
+
+		err = start_both_streams(motu, rate);
+		if (err < 0) {
+			dev_err(&motu->unit->device,
+				"fail to start isochronous comm: %d\n", err);
+			stop_both_streams(motu);
+			return err;
+		}
+
+		err = start_isoc_ctx(motu, &motu->rx_stream);
+		if (err < 0) {
+			dev_err(&motu->unit->device,
+				"fail to start IT context: %d\n", err);
+			stop_both_streams(motu);
+			return err;
+		}
+
+		err = protocol->switch_fetching_mode(motu, true);
+		if (err < 0) {
+			dev_err(&motu->unit->device,
+				"fail to enable frame fetching: %d\n", err);
+			stop_both_streams(motu);
+			return err;
+		}
+	}
+
+	if (!amdtp_stream_running(&motu->tx_stream) &&
+	    motu->capture_substreams > 0) {
+		err = start_isoc_ctx(motu, &motu->tx_stream);
+		if (err < 0) {
+			dev_err(&motu->unit->device,
+				"fail to start IR context: %d", err);
+			amdtp_stream_stop(&motu->rx_stream);
+			stop_both_streams(motu);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+void snd_motu_stream_stop_duplex(struct snd_motu *motu)
+{
+	if (motu->capture_substreams == 0) {
+		if (amdtp_stream_running(&motu->tx_stream))
+			stop_isoc_ctx(motu, &motu->tx_stream);
+
+		if (motu->playback_substreams == 0) {
+			if (amdtp_stream_running(&motu->rx_stream))
+				stop_isoc_ctx(motu, &motu->rx_stream);
+			stop_both_streams(motu);
+		}
+	}
+}
+
+static int init_stream(struct snd_motu *motu, enum amdtp_stream_direction dir)
+{
+	int err;
+	struct amdtp_stream *stream;
+	struct fw_iso_resources *resources;
+
+	if (dir == AMDTP_IN_STREAM) {
+		stream = &motu->tx_stream;
+		resources = &motu->tx_resources;
+	} else {
+		stream = &motu->rx_stream;
+		resources = &motu->rx_resources;
+	}
+
+	err = fw_iso_resources_init(resources, motu->unit);
+	if (err < 0)
+		return err;
+
+	err = amdtp_motu_init(stream, motu->unit, dir, motu->spec->protocol);
+	if (err < 0) {
+		amdtp_stream_destroy(stream);
+		fw_iso_resources_destroy(resources);
+	}
+
+	return err;
+}
+
+static void destroy_stream(struct snd_motu *motu,
+			   enum amdtp_stream_direction dir)
+{
+	struct amdtp_stream *stream;
+	struct fw_iso_resources *resources;
+
+	if (dir == AMDTP_IN_STREAM) {
+		stream = &motu->tx_stream;
+		resources = &motu->tx_resources;
+	} else {
+		stream = &motu->rx_stream;
+		resources = &motu->rx_resources;
+	}
+
+	amdtp_stream_destroy(stream);
+	fw_iso_resources_free(resources);
+}
+
+int snd_motu_stream_init_duplex(struct snd_motu *motu)
+{
+	int err;
+
+	err = init_stream(motu, AMDTP_IN_STREAM);
+	if (err < 0)
+		return err;
+
+	err = init_stream(motu, AMDTP_OUT_STREAM);
+	if (err < 0)
+		destroy_stream(motu, AMDTP_IN_STREAM);
+
+	return err;
+}
+
+/*
+ * This function should be called before starting streams or after stopping
+ * streams.
+ */
+void snd_motu_stream_destroy_duplex(struct snd_motu *motu)
+{
+	destroy_stream(motu, AMDTP_IN_STREAM);
+	destroy_stream(motu, AMDTP_OUT_STREAM);
+
+	motu->playback_substreams = 0;
+	motu->capture_substreams = 0;
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index db6014c..9d52238 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -56,6 +56,7 @@ static void motu_free(struct snd_motu *motu)
 {
 	snd_motu_transaction_unregister(motu);
 
+	snd_motu_stream_destroy_duplex(motu);
 	fw_unit_put(motu->unit);
 
 	mutex_destroy(&motu->mutex);
@@ -92,6 +93,10 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
+	err = snd_motu_stream_init_duplex(motu);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(motu->card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index ed1d779..90d2741 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -23,6 +23,7 @@
 
 #include "../lib.h"
 #include "../amdtp-stream.h"
+#include "../iso-resources.h"
 
 struct snd_motu_packet_format {
 	unsigned char pcm_byte_offset;
@@ -48,6 +49,10 @@ struct snd_motu {
 	struct snd_motu_packet_format rx_packet_formats;
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
+	struct fw_iso_resources tx_resources;
+	struct fw_iso_resources rx_resources;
+	unsigned int capture_substreams;
+	unsigned int playback_substreams;
 
 	/* For notification. */
 	struct fw_address_handler async_handler;
@@ -118,4 +123,9 @@ int snd_motu_transaction_write(struct snd_motu *motu, u32 offset, __be32 *reg,
 int snd_motu_transaction_register(struct snd_motu *motu);
 int snd_motu_transaction_reregister(struct snd_motu *motu);
 void snd_motu_transaction_unregister(struct snd_motu *motu);
+
+int snd_motu_stream_init_duplex(struct snd_motu *motu);
+void snd_motu_stream_destroy_duplex(struct snd_motu *motu);
+int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate);
+void snd_motu_stream_stop_duplex(struct snd_motu *motu);
 #endif
-- 
2.9.3
