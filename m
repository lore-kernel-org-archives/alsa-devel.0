From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/25] ALSA: firewire-digi00x: add stream
	functionality
Date: Thu, 13 Aug 2015 09:20:06 +0900
Message-ID: <1439425221-30826-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FD44261507
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 02:20:36 +0200 (CEST)
In-Reply-To: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, Damien Zammit <damien@zamaudio.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a functionality to manage streaming.

The streaming is not controlled by CMP, against IEC 61883-1. It's
controlled by IEEE 1394 write transaction to certain addresses.

Several clock sources are available, while there're no differences about
packet transmission among clock sources. The value of SYT field in
transmitted packets is always zero. Thus, streams in both direction
don't build synchronization.

And the device always requires received packets to transmit packets, thus
this driver keep to transfer outgoing packets even if it's not required.

Cc: Damien Zammit <damien@zamaudio.com>
Cc: Robin Gareus <robin@gareus.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile         |   2 +-
 sound/firewire/digi00x/digi00x-stream.c | 383 ++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c        |  12 +-
 sound/firewire/digi00x/digi00x.h        |  74 ++++++
 4 files changed, 469 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/digi00x/digi00x-stream.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index a5d1a60..b7c783d 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-digi00x-objs := amdtp-dot.o digi00x.o
+snd-firewire-digi00x-objs := amdtp-dot.o digi00x-stream.o digi00x.o
 obj-m += snd-firewire-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
new file mode 100644
index 0000000..2956283
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -0,0 +1,383 @@
+/*
+ * digi00x-stream.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "digi00x.h"
+
+#define CALLBACK_TIMEOUT 500
+
+const unsigned int snd_dg00x_stream_rates[SND_DG00X_RATE_COUNT] = {
+	[SND_DG00X_RATE_44100] = 44100,
+	[SND_DG00X_RATE_48000] = 48000,
+	[SND_DG00X_RATE_88200] = 88200,
+	[SND_DG00X_RATE_96000] = 96000,
+};
+
+/* Multi Bit Linear Audio data channels for each sampling transfer frequency. */
+const unsigned int
+snd_dg00x_stream_pcm_channels[SND_DG00X_RATE_COUNT] = {
+	/* Analog/ADAT/SPDIF */
+	[SND_DG00X_RATE_44100] = (8 + 8 + 2),
+	[SND_DG00X_RATE_48000] = (8 + 8 + 2),
+	/* Analog/SPDIF */
+	[SND_DG00X_RATE_88200] = (8 + 2),
+	[SND_DG00X_RATE_96000] = (8 + 2),
+};
+
+int snd_dg00x_stream_get_local_rate(struct snd_dg00x *dg00x, unsigned int *rate)
+{
+	u32 data;
+	__be32 reg;
+	int err;
+
+	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_LOCAL_RATE,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	data = be32_to_cpu(reg) & 0x0f;
+	if (data < ARRAY_SIZE(snd_dg00x_stream_rates))
+		*rate = snd_dg00x_stream_rates[data];
+	else
+		err = -EIO;
+
+	return err;
+}
+
+int snd_dg00x_stream_set_local_rate(struct snd_dg00x *dg00x, unsigned int rate)
+{
+	__be32 reg;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_dg00x_stream_rates); i++) {
+		if (rate == snd_dg00x_stream_rates[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(snd_dg00x_stream_rates))
+		return -EIO;
+
+	reg = cpu_to_be32(i);
+	return snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  DG00X_ADDR_BASE + DG00X_OFFSET_LOCAL_RATE,
+				  &reg, sizeof(reg), 0);
+}
+
+int snd_dg00x_stream_get_clock(struct snd_dg00x *dg00x,
+			       enum snd_dg00x_clock *clock)
+{
+	__be32 reg;
+	int err;
+
+	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_CLOCK_SOURCE,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	*clock = be32_to_cpu(reg) & 0x0f;
+	if (*clock >= SND_DG00X_CLOCK_COUNT)
+		err = -EIO;
+
+	return err;
+}
+
+int snd_dg00x_stream_check_external_clock(struct snd_dg00x *dg00x, bool *detect)
+{
+	__be32 reg;
+	int err;
+
+	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_DETECT_EXTERNAL,
+				 &reg, sizeof(reg), 0);
+	if (err >= 0)
+		*detect = be32_to_cpu(reg) > 0;
+
+	return err;
+}
+
+int snd_dg00x_stream_get_external_rate(struct snd_dg00x *dg00x,
+				       unsigned int *rate)
+{
+	u32 data;
+	__be32 reg;
+	int err;
+
+	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_EXTERNAL_RATE,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	data = be32_to_cpu(reg) & 0x0f;
+	if (data < ARRAY_SIZE(snd_dg00x_stream_rates))
+		*rate = snd_dg00x_stream_rates[data];
+	/* This means desync. */
+	else
+		err = -EBUSY;
+
+	return err;
+}
+
+static void finish_session(struct snd_dg00x *dg00x)
+{
+	__be32 data = cpu_to_be32(0x00000003);
+
+	snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   DG00X_ADDR_BASE + DG00X_OFFSET_STREAMING_SET,
+			   &data, sizeof(data), 0);
+}
+
+static int begin_session(struct snd_dg00x *dg00x)
+{
+	__be32 data;
+	u32 curr;
+	int err;
+
+	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_STREAMING_STATE,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		goto error;
+	curr = be32_to_cpu(data);
+
+	if (curr == 0)
+		curr = 2;
+
+	curr--;
+	while (curr > 0) {
+		data = cpu_to_be32(curr);
+		err = snd_fw_transaction(dg00x->unit,
+					 TCODE_WRITE_QUADLET_REQUEST,
+					 DG00X_ADDR_BASE +
+					 DG00X_OFFSET_STREAMING_SET,
+					 &data, sizeof(data), 0);
+		if (err < 0)
+			goto error;
+
+		msleep(20);
+		curr--;
+	}
+
+	return 0;
+error:
+	finish_session(dg00x);
+	return err;
+}
+
+static void release_resources(struct snd_dg00x *dg00x)
+{
+	__be32 data = 0;
+
+	/* Unregister isochronous channels for both direction. */
+	snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   DG00X_ADDR_BASE + DG00X_OFFSET_ISOC_CHANNELS,
+			   &data, sizeof(data), 0);
+
+	/* Release isochronous resources. */
+	fw_iso_resources_free(&dg00x->tx_resources);
+	fw_iso_resources_free(&dg00x->rx_resources);
+}
+
+static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
+{
+	unsigned int i;
+	__be32 data;
+	int err;
+
+	/* Check sampling rate. */
+	for (i = 0; i < SND_DG00X_RATE_COUNT; i++) {
+		if (snd_dg00x_stream_rates[i] == rate)
+			break;
+	}
+	if (i == SND_DG00X_RATE_COUNT)
+		return -EINVAL;
+
+	/* Keep resources for out-stream. */
+	amdtp_dot_set_parameters(&dg00x->rx_stream, rate,
+				 snd_dg00x_stream_pcm_channels[i], 2);
+	err = fw_iso_resources_allocate(&dg00x->rx_resources,
+				amdtp_stream_get_max_payload(&dg00x->rx_stream),
+				fw_parent_device(dg00x->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for in-stream. */
+	amdtp_dot_set_parameters(&dg00x->tx_stream, rate,
+				 snd_dg00x_stream_pcm_channels[i], 1);
+	err = fw_iso_resources_allocate(&dg00x->tx_resources,
+				amdtp_stream_get_max_payload(&dg00x->tx_stream),
+				fw_parent_device(dg00x->unit)->max_speed);
+	if (err < 0)
+		goto error;
+
+	/* Register isochronous channels for both direction. */
+	data = cpu_to_be32((dg00x->tx_resources.channel << 16) |
+			   dg00x->rx_resources.channel);
+	err = snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_ISOC_CHANNELS,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		goto error;
+
+	return 0;
+error:
+	release_resources(dg00x);
+	return err;
+}
+
+int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x)
+{
+	int err;
+
+	/* For out-stream. */
+	err = fw_iso_resources_init(&dg00x->rx_resources, dg00x->unit);
+	if (err < 0)
+		goto error;
+	err = amdtp_dot_init(&dg00x->rx_stream, dg00x->unit, AMDTP_OUT_STREAM);
+	if (err < 0)
+		goto error;
+
+	/* For in-stream. */
+	err = fw_iso_resources_init(&dg00x->tx_resources, dg00x->unit);
+	if (err < 0)
+		goto error;
+	err = amdtp_dot_init(&dg00x->tx_stream, dg00x->unit, AMDTP_IN_STREAM);
+	if (err < 0)
+		goto error;
+
+	return 0;
+error:
+	amdtp_stream_destroy(&dg00x->tx_stream);
+	amdtp_stream_destroy(&dg00x->rx_stream);
+	fw_iso_resources_destroy(&dg00x->tx_resources);
+	fw_iso_resources_destroy(&dg00x->rx_resources);
+	return err;
+}
+
+/*
+ * This function should be called before starting streams or after stopping
+ * streams.
+ */
+void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x)
+{
+	amdtp_stream_destroy(&dg00x->rx_stream);
+	fw_iso_resources_destroy(&dg00x->rx_resources);
+
+	amdtp_stream_destroy(&dg00x->tx_stream);
+	fw_iso_resources_destroy(&dg00x->tx_resources);
+}
+
+int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate)
+{
+	unsigned int curr_rate;
+	int err = 0;
+
+	if (dg00x->substreams_counter == 0)
+		goto end;
+
+	/* Check current sampling rate. */
+	err = snd_dg00x_stream_get_local_rate(dg00x, &curr_rate);
+	if (err < 0)
+		goto error;
+	/* For MIDI substreams. */
+	if (rate == 0)
+		rate = curr_rate;
+	if (curr_rate != rate ||
+	    amdtp_streaming_error(&dg00x->tx_stream) ||
+	    amdtp_streaming_error(&dg00x->rx_stream)) {
+		finish_session(dg00x);
+
+		amdtp_stream_stop(&dg00x->tx_stream);
+		amdtp_stream_stop(&dg00x->rx_stream);
+		release_resources(dg00x);
+	}
+
+	/*
+	 * No packets are transmitted without receiving packets, reagardless of
+	 * which sources of clock is used.
+	 */
+	if (!amdtp_stream_running(&dg00x->rx_stream)) {
+		err = snd_dg00x_stream_set_local_rate(dg00x, rate);
+		if (err < 0)
+			goto error;
+
+		err = keep_resources(dg00x, rate);
+		if (err < 0)
+			goto error;
+
+		err = begin_session(dg00x);
+		if (err < 0)
+			goto error;
+
+		err = amdtp_stream_start(&dg00x->rx_stream,
+				dg00x->rx_resources.channel,
+				fw_parent_device(dg00x->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		if (!amdtp_stream_wait_callback(&dg00x->rx_stream,
+					      CALLBACK_TIMEOUT)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+	}
+
+	/*
+	 * The value of SYT field in transmitted packets is always 0x0000. Thus,
+	 * duplex streams with timestamp synchronization cannot be built.
+	 */
+	if (!amdtp_stream_running(&dg00x->tx_stream)) {
+		err = amdtp_stream_start(&dg00x->tx_stream,
+				dg00x->tx_resources.channel,
+				fw_parent_device(dg00x->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		if (!amdtp_stream_wait_callback(&dg00x->tx_stream,
+					      CALLBACK_TIMEOUT)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+	}
+end:
+	return err;
+error:
+	finish_session(dg00x);
+
+	amdtp_stream_stop(&dg00x->tx_stream);
+	amdtp_stream_stop(&dg00x->rx_stream);
+	release_resources(dg00x);
+
+	return err;
+}
+
+void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x)
+{
+	if (dg00x->substreams_counter > 0)
+		return;
+
+	amdtp_stream_stop(&dg00x->tx_stream);
+	amdtp_stream_stop(&dg00x->rx_stream);
+	finish_session(dg00x);
+	release_resources(dg00x);
+
+	/*
+	 * Just after finishing the session, the device may lost transmitting
+	 * functionality for a short time.
+	 */
+	msleep(50);
+}
+
+void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x)
+{
+	fw_iso_resources_update(&dg00x->tx_resources);
+	fw_iso_resources_update(&dg00x->rx_resources);
+
+	amdtp_stream_update(&dg00x->tx_stream);
+	amdtp_stream_update(&dg00x->rx_stream);
+}
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 2bdf987..2c517ec 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -47,6 +47,8 @@ static void dg00x_card_free(struct snd_card *card)
 {
 	struct snd_dg00x *dg00x = card->private_data;
 
+	snd_dg00x_stream_destroy_duplex(dg00x);
+
 	fw_unit_put(dg00x->unit);
 
 	mutex_destroy(&dg00x->mutex);
@@ -77,6 +79,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_dg00x_stream_init_duplex(dg00x);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
@@ -91,7 +97,11 @@ error:
 
 static void snd_dg00x_update(struct fw_unit *unit)
 {
-	return;
+	struct snd_dg00x *dg00x = dev_get_drvdata(&unit->device);
+
+	mutex_lock(&dg00x->mutex);
+	snd_dg00x_stream_update_duplex(dg00x);
+	mutex_unlock(&dg00x->mutex);
 }
 
 static void snd_dg00x_remove(struct fw_unit *unit)
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index f761d74..f4ce90e 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -33,6 +33,63 @@ struct snd_dg00x {
 	struct fw_unit *unit;
 
 	struct mutex mutex;
+
+	struct amdtp_stream tx_stream;
+	struct fw_iso_resources tx_resources;
+
+	struct amdtp_stream rx_stream;
+	struct fw_iso_resources rx_resources;
+
+	unsigned int substreams_counter;
+};
+
+#define DG00X_ADDR_BASE		0xffffe0000000ull
+
+#define DG00X_OFFSET_STREAMING_STATE	0x0000
+#define DG00X_OFFSET_STREAMING_SET	0x0004
+#define DG00X_OFFSET_MIDI_CTL_ADDR	0x0008
+/* For LSB of the address		0x000c */
+/* unknown				0x0010 */
+#define DG00X_OFFSET_MESSAGE_ADDR	0x0014
+/* For LSB of the address		0x0018 */
+/* unknown				0x001c */
+/* unknown				0x0020 */
+/* not used			0x0024--0x00ff */
+#define DG00X_OFFSET_ISOC_CHANNELS	0x0100
+/* unknown				0x0104 */
+/* unknown				0x0108 */
+/* unknown				0x010c */
+#define DG00X_OFFSET_LOCAL_RATE		0x0110
+#define DG00X_OFFSET_EXTERNAL_RATE	0x0114
+#define DG00X_OFFSET_CLOCK_SOURCE	0x0118
+#define DG00X_OFFSET_OPT_IFACE_MODE	0x011c
+/* unknown				0x0120 */
+/* Mixer control on/off			0x0124 */
+/* unknown				0x0128 */
+#define DG00X_OFFSET_DETECT_EXTERNAL	0x012c
+/* unknown				0x0138 */
+#define DG00X_OFFSET_MMC		0x0400
+
+enum snd_dg00x_rate {
+	SND_DG00X_RATE_44100 = 0,
+	SND_DG00X_RATE_48000,
+	SND_DG00X_RATE_88200,
+	SND_DG00X_RATE_96000,
+	SND_DG00X_RATE_COUNT,
+};
+
+enum snd_dg00x_clock {
+	SND_DG00X_CLOCK_INTERNAL = 0,
+	SND_DG00X_CLOCK_SPDIF,
+	SND_DG00X_CLOCK_ADAT,
+	SND_DG00X_CLOCK_WORD,
+	SND_DG00X_CLOCK_COUNT,
+};
+
+enum snd_dg00x_optical_mode {
+	SND_DG00X_OPT_IFACE_MODE_ADAT = 0,
+	SND_DG00X_OPT_IFACE_MODE_SPDIF,
+	SND_DG00X_OPT_IFACE_MODE_COUNT,
 };
 
 int amdtp_dot_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -47,4 +104,21 @@ void amdtp_dot_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
 void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
 			    struct snd_rawmidi_substream *midi);
 
+extern const unsigned int snd_dg00x_stream_rates[SND_DG00X_RATE_COUNT];
+extern const unsigned int snd_dg00x_stream_pcm_channels[SND_DG00X_RATE_COUNT];
+int snd_dg00x_stream_get_external_rate(struct snd_dg00x *dg00x,
+				       unsigned int *rate);
+int snd_dg00x_stream_get_local_rate(struct snd_dg00x *dg00x,
+				    unsigned int *rate);
+int snd_dg00x_stream_set_local_rate(struct snd_dg00x *dg00x, unsigned int rate);
+int snd_dg00x_stream_get_clock(struct snd_dg00x *dg00x,
+			       enum snd_dg00x_clock *clock);
+int snd_dg00x_stream_check_external_clock(struct snd_dg00x *dg00x,
+					  bool *detect);
+int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x);
+int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate);
+void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x);
+void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
+void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
+
 #endif
-- 
2.1.4
