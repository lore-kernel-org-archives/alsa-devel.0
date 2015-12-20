From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/11] fireface: add stream management
	functionality
Date: Sun, 20 Dec 2015 21:28:41 +0900
Message-ID: <1450614523-9367-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4563E2606E9
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 13:28:50 +0100 (CET)
In-Reply-To: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds support of stream management functionality.

The device has three modes of streaming according to sampling transfer
frequency. Each mode has own number of data channels in an packet. The
set of the numbers may be model-specific, therefore this commit adds
some members into model-specific structure to describe it.

The length of registers for the number of isochronous channel is just
three bits, therefore 0-7ch are available.

When bus reset occurs on IEEE 1394 bus, the device discontinues to
transmit packets. This commit aborts PCM substreams at bus reset handler.

The device manages its sampling clock independently of sampling transfer
frequency, against IEC 61883-6. Thus, it's a lower cost to change the
sampling transfer frequency, while data fetch between streaming layer and
DSP require bigger buffer for resampling. As a result, device latency may
tend to be larger than ASICs for IEC 61883-1/6 such as DM1000/DM1100/DM1500
(BeBoB) and OXFW970/971.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile          |   2 +-
 sound/firewire/fireface/fireface-stream.c | 358 ++++++++++++++++++++++++++++++
 sound/firewire/fireface/fireface.c        |  10 +
 sound/firewire/fireface/fireface.h        |  28 +++
 4 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/fireface-stream.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index f22f0b5..5b4bb68 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,3 +1,3 @@
 snd-fireface-objs := fireface.o fireface-transaction.o fireface-midi.o \
-		     fireface-proc.o amdtp-ff.o
+		     fireface-proc.o amdtp-ff.o fireface-stream.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/fireface-stream.c b/sound/firewire/fireface/fireface-stream.c
new file mode 100644
index 0000000..c7743a8
--- /dev/null
+++ b/sound/firewire/fireface/fireface-stream.c
@@ -0,0 +1,358 @@
+/*
+ * fireface-stream.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2016 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <linux/delay.h>
+#include "fireface.h"
+
+#define CALLBACK_TIMEOUT_MS	200
+
+static int get_rate_mode(unsigned int rate, unsigned int *mode)
+{
+	int i;
+
+	for (i = 0; i < CIP_SFC_COUNT; i++) {
+		if (amdtp_rate_table[i] == rate)
+			break;
+	}
+
+	if (i == CIP_SFC_COUNT)
+		return -EINVAL;
+
+	*mode = ((int)i - 1) / 2;
+
+	return 0;
+}
+
+int snd_ff_stream_get_clock(struct snd_ff *ff, unsigned int *rate,
+			    enum snd_ff_clock_src *src)
+{
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 0x0000801C0004, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+	data = le32_to_cpu(reg);
+
+	/* Calculate sampling rate. */
+	switch ((data >> 1) & 0x03) {
+	case 0x01:
+		*rate = 32000;
+		break;
+	case 0x00:
+		*rate = 44100;
+		break;
+	case 0x03:
+		*rate = 48000;
+		break;
+	case 0x02:
+	default:
+		return -EIO;
+	}
+
+	if (data & 0x08)
+		*rate *= 2;
+	else if (data & 0x10)
+		*rate *= 4;
+
+	/* Calculate source of clock. */
+	if (data & 0x01) {
+		*src = SND_FF_CLOCK_SRC_INTERNAL;
+	} else {
+		/* TODO: 0x00, 0x01, 0x02, 0x06, 0x07? */
+		switch ((data >> 10) & 0x07) {
+		case 0x03:
+			*src = SND_FF_CLOCK_SRC_SPDIF;
+			break;
+		case 0x04:
+			*src = SND_FF_CLOCK_SRC_WORD;
+			break;
+		case 0x05:
+			*src = SND_FF_CLOCK_SRC_LTC;
+			break;
+		case 0x00:
+		default:
+			*src = SND_FF_CLOCK_SRC_ADAT;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * In this device, the length of register for isochronous channels is just
+ * three bits. Therefore, we can allocate between 0 and 7 channel.
+ */
+static int keep_resources(struct snd_ff *ff, unsigned int rate)
+{
+	int mode;
+	int err;
+
+	err = get_rate_mode(rate, &mode);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for in-stream. */
+	err = amdtp_ff_set_parameters(&ff->tx_stream, rate,
+				      ff->spec->pcm_capture_channels[mode]);
+	if (err < 0)
+		return err;
+	ff->tx_resources.channels_mask = 0x00000000000000ffuLL;
+	err = fw_iso_resources_allocate(&ff->tx_resources,
+			amdtp_stream_get_max_payload(&ff->tx_stream),
+			fw_parent_device(ff->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for out-stream. */
+	err = amdtp_ff_set_parameters(&ff->rx_stream, rate,
+				      ff->spec->pcm_playback_channels[mode]);
+	if (err < 0)
+		return err;
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
+static void release_resources(struct snd_ff *ff)
+{
+	fw_iso_resources_free(&ff->tx_resources);
+	fw_iso_resources_free(&ff->rx_resources);
+}
+
+static int begin_session(struct snd_ff *ff, unsigned int rate)
+{
+	__le32 reg;
+	int i, err;
+
+	/* Check whether the given value is supported or not. */
+	for (i = 0; i < CIP_SFC_COUNT; i++) {
+		if (amdtp_rate_table[i] == rate)
+			break;
+	}
+	if (i == CIP_SFC_COUNT)
+		return -EINVAL;
+
+	/* Set the number of data blocks transferred in a second. */
+	reg = cpu_to_le32(rate);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 0x000080100500, &reg, sizeof(reg), 0);
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
+				 0x000080100504, &reg, sizeof(reg), 0);
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
+				 0x00008010050c, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	/* Allow to transmit packets. */
+	reg = cpu_to_le32(0x00000001);
+	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 0x000080100508, &reg, sizeof(reg), 0);
+}
+
+static void finish_session(struct snd_ff *ff)
+{
+	__le32 reg;
+
+	reg = cpu_to_le32(0x80000000);
+	snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   0x000080100510, &reg, sizeof(reg), 0);
+}
+
+static int init_stream(struct snd_ff *ff, enum amdtp_stream_direction dir)
+{
+	int err;
+	struct fw_iso_resources *resources;
+	struct amdtp_stream *stream;
+
+	if (dir == AMDTP_IN_STREAM) {
+		resources = &ff->tx_resources;
+		stream = &ff->tx_stream;
+	} else {
+		resources = &ff->rx_resources;
+		stream = &ff->rx_stream;
+	}
+
+	err = fw_iso_resources_init(resources, ff->unit);
+	if (err < 0)
+		return err;
+
+	err = amdtp_ff_init(stream, ff->unit, dir);
+	if (err < 0)
+		fw_iso_resources_destroy(resources);
+
+	return err;
+}
+
+static void destroy_stream(struct snd_ff *ff, enum amdtp_stream_direction dir)
+{
+	if (dir == AMDTP_IN_STREAM) {
+		amdtp_stream_destroy(&ff->tx_stream);
+		fw_iso_resources_destroy(&ff->tx_resources);
+	} else {
+		amdtp_stream_destroy(&ff->rx_stream);
+		fw_iso_resources_destroy(&ff->rx_resources);
+	}
+}
+
+int snd_ff_stream_init_duplex(struct snd_ff *ff)
+{
+	int err;
+
+	err = init_stream(ff, AMDTP_OUT_STREAM);
+	if (err < 0)
+		goto end;
+
+	err = init_stream(ff, AMDTP_IN_STREAM);
+	if (err < 0)
+		destroy_stream(ff, AMDTP_OUT_STREAM);
+end:
+	return err;
+}
+
+/*
+ * This function should be called before starting streams or after stopping
+ * streams.
+ */
+void snd_ff_stream_destroy_duplex(struct snd_ff *ff)
+{
+	destroy_stream(ff, AMDTP_IN_STREAM);
+	destroy_stream(ff, AMDTP_OUT_STREAM);
+}
+
+int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
+{
+	unsigned int curr_rate;
+	enum snd_ff_clock_src src;
+	int err;
+
+	if (ff->substreams_counter == 0)
+		return 0;
+
+	err = snd_ff_stream_get_clock(ff, &curr_rate, &src);
+	if (err < 0)
+		return err;
+	if (curr_rate != rate ||
+	    amdtp_streaming_error(&ff->tx_stream) ||
+	    amdtp_streaming_error(&ff->rx_stream)) {
+		finish_session(ff);
+
+		amdtp_stream_stop(&ff->tx_stream);
+		amdtp_stream_stop(&ff->rx_stream);
+
+		release_resources(ff);
+	}
+
+	/*
+	 * Regardless of current source of clock signal, drivers transfer some
+	 * packets. Then, the device transfers packets.
+	 */
+	if (!amdtp_stream_running(&ff->rx_stream)) {
+		err = keep_resources(ff, rate);
+		if (err < 0)
+			goto error;
+
+		err = begin_session(ff, rate);
+		if (err < 0)
+			goto error;
+
+		err = amdtp_stream_start(&ff->rx_stream,
+					 ff->rx_resources.channel,
+					 fw_parent_device(ff->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		if (!amdtp_stream_wait_callback(&ff->rx_stream,
+						CALLBACK_TIMEOUT_MS)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+	}
+
+	/*
+	 * The incoming packets has no timestamp, thus no afraid of detecting
+	 * packet discontinuity.
+	 */
+	if (!amdtp_stream_running(&ff->tx_stream)) {
+		err = amdtp_stream_start(&ff->tx_stream,
+					 ff->tx_resources.channel,
+					 fw_parent_device(ff->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		if (!amdtp_stream_wait_callback(&ff->tx_stream,
+						CALLBACK_TIMEOUT_MS)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	amdtp_stream_stop(&ff->tx_stream);
+	amdtp_stream_stop(&ff->rx_stream);
+
+	finish_session(ff);
+	release_resources(ff);
+
+	return err;
+}
+
+void snd_ff_stream_stop_duplex(struct snd_ff *ff)
+{
+	if (ff->substreams_counter > 0)
+		return;
+
+	amdtp_stream_stop(&ff->tx_stream);
+	amdtp_stream_stop(&ff->rx_stream);
+	finish_session(ff);
+	release_resources(ff);
+}
+
+void snd_ff_stream_update_duplex(struct snd_ff *ff)
+{
+	/* The device discontinue to transfer packets.  */
+	amdtp_stream_pcm_abort(&ff->tx_stream);
+	amdtp_stream_stop(&ff->tx_stream);
+
+	amdtp_stream_pcm_abort(&ff->rx_stream);
+	amdtp_stream_stop(&ff->rx_stream);
+
+	fw_iso_resources_update(&ff->tx_resources);
+	fw_iso_resources_update(&ff->rx_resources);
+}
diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
index 2ea84ce..52efbd0 100644
--- a/sound/firewire/fireface/fireface.c
+++ b/sound/firewire/fireface/fireface.c
@@ -18,6 +18,8 @@ MODULE_LICENSE("GPL v2");
 
 struct snd_ff_spec spec_ff400 = {
 	.name = "Fireface400",
+	.pcm_capture_channels = {18, 14, 10},
+	.pcm_playback_channels = {18, 14, 10},
 };
 
 static void name_card(struct snd_ff *ff)
@@ -110,6 +112,12 @@ static int snd_ff_probe(struct fw_unit *unit,
 
 	snd_ff_proc_init(ff);
 
+	err = snd_ff_stream_init_duplex(ff);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
 	/* Register this sound card later. */
 	INIT_DEFERRABLE_WORK(&ff->dwork, do_probe);
 	delay = msecs_to_jiffies(PROBE_DELAY_MS) +
@@ -133,6 +141,8 @@ static void snd_ff_update(struct fw_unit *unit)
 	}
 
 	snd_ff_transaction_reregister(ff);
+
+	snd_ff_stream_update_duplex(ff);
 }
 
 static void snd_ff_remove(struct fw_unit *unit)
diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
index dd50261..991f9d4 100644
--- a/sound/firewire/fireface/fireface.h
+++ b/sound/firewire/fireface/fireface.h
@@ -35,8 +35,12 @@
 #define SND_FF_IN_MIDI_PORTS		2
 #define SND_FF_OUT_MIDI_PORTS		2
 
+#define SND_FF_STREAM_MODES		3
+
 struct snd_ff_spec {
 	const char *const name;
+	const unsigned int pcm_capture_channels[SND_FF_STREAM_MODES];
+	const unsigned int pcm_playback_channels[SND_FF_STREAM_MODES];
 };
 
 struct snd_ff {
@@ -63,6 +67,12 @@ struct snd_ff {
 	ktime_t next_ktime[SND_FF_OUT_MIDI_PORTS];
 	bool rx_midi_error[SND_FF_OUT_MIDI_PORTS];
 	unsigned int rx_bytes[SND_FF_OUT_MIDI_PORTS];
+
+	unsigned int substreams_counter;
+	struct amdtp_stream tx_stream;
+	struct amdtp_stream rx_stream;
+	struct fw_iso_resources tx_resources;
+	struct fw_iso_resources rx_resources;
 };
 
 #define SND_FF_ADDR_CONTROLLER_ADDR_HI	0x0000801003f4
@@ -72,6 +82,15 @@ struct snd_ff {
 
 #define SND_FF_ADDR_MIDI_TX		0x000100000000
 
+enum snd_ff_clock_src {
+	SND_FF_CLOCK_SRC_INTERNAL,
+	SND_FF_CLOCK_SRC_SPDIF,
+	SND_FF_CLOCK_SRC_ADAT,
+	SND_FF_CLOCK_SRC_WORD,
+	SND_FF_CLOCK_SRC_LTC,
+	/* TODO: perhaps ADAT2 and TCO exists. */
+};
+
 int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
@@ -84,6 +103,15 @@ int amdtp_ff_add_pcm_hw_constraints(struct amdtp_stream *s,
 int amdtp_ff_init(struct amdtp_stream *s, struct fw_unit *unit,
 		  enum amdtp_stream_direction dir);
 
+int snd_ff_stream_init_duplex(struct snd_ff *ff);
+void snd_ff_stream_destroy_duplex(struct snd_ff *ff);
+int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate);
+void snd_ff_stream_stop_duplex(struct snd_ff *ff);
+void snd_ff_stream_update_duplex(struct snd_ff *ff);
+
+int snd_ff_stream_get_clock(struct snd_ff *ff, unsigned int *rate,
+			    enum snd_ff_clock_src *src);
+
 void snd_ff_proc_init(struct snd_ff *ff);
 
 int snd_ff_create_midi_devices(struct snd_ff *ff);
-- 
2.5.0
