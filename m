From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/11] ALSA: digi00x: add streaming
	functionality
Date: Mon, 30 Mar 2015 00:05:22 +0900
Message-ID: <1427641531-9047-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C18C26049E
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:43 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a functionality to manage streaming and to handle packets.

As long as seeing Digi 002, the device uses usual CIP packets in IEC
61883-1/6. But the streaming is not controlled by CMP. It's controlled
by writing to certain addresses.

In Digi 002, several clock sources are available, while there're no
differences for packets in different clock sources. The value of SYT field
in transferred packets is always zero. Thus, streams in both direction
don't build synchronization. So this driver ignores the synchronization.

And the device always requires received-stream to transmit packets, thus
this driver transmits packets for both direction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                  |   1 +
 sound/firewire/digi00x/Makefile         |   2 +-
 sound/firewire/digi00x/digi00x-stream.c | 349 ++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c        |  16 ++
 sound/firewire/digi00x/digi00x.h        |  75 +++++++
 5 files changed, 442 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-stream.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 594b6d1..6b9b0a1 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -120,6 +120,7 @@ config SND_BEBOB
 
 config SND_DIGI00X
 	tristate "Digidesign 002/003 family support"
+	select SND_FIREWIRE_LIB
 	help
 	 Say Y here to include support for Digidesign 002/003 family.
 
diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index e30e233..fe8fceb 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,2 +1,2 @@
-snd-digi00x-objs := digi00x.o
+snd-digi00x-objs := digi00x.o digi00x-stream.o
 obj-m += snd-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
new file mode 100644
index 0000000..1d5ef01
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -0,0 +1,349 @@
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
+	[0] = 44100,
+	[1] = 48000,
+	[2] = 88200,
+	[3] = 96000,
+};
+
+/* Multi Bit Linear Audio data channels for each sampling transfer frequency. */
+const unsigned int
+snd_dg00x_stream_mbla_data_channels[SND_DG00X_RATE_COUNT] = {
+	/* Analog/ADAT/SPDIF */
+	[0] = (8 + 8 + 2),
+	[1] = (8 + 8 + 2),
+	/* Analog/SPDIF */
+	[2] = (8 + 2),
+	[3] = (8 + 2),
+};
+
+int snd_dg00x_stream_get_rate(struct snd_dg00x *dg00x, unsigned int *rate)
+{
+	__be32 data;
+	int err;
+
+	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_RATE_GET,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		goto end;
+
+	data = be32_to_cpu(data) & 0x0f;
+	if (data >= ARRAY_SIZE(snd_dg00x_stream_rates)) {
+		err = -EIO;
+		goto end;
+	}
+
+	*rate = snd_dg00x_stream_rates[data];
+end:
+	return err;
+}
+
+int snd_dg00x_stream_set_rate(struct snd_dg00x *dg00x, unsigned int rate)
+{
+	__be32 data;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_dg00x_stream_rates); i++) {
+		if (rate == snd_dg00x_stream_rates[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(snd_dg00x_stream_rates))
+		return -EIO;
+
+	data = cpu_to_be32(i);
+	return snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  DG00X_ADDR_BASE + DG00X_OFFSET_RATE_SET,
+				  &data, sizeof(data), 0);
+}
+
+int snd_dg00x_stream_get_clock(struct snd_dg00x *dg00x,
+			       enum snd_dg00x_clock *clock)
+{
+	__be32 data;
+	int err;
+
+	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_CLOCK_SOURCE,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	*clock = be32_to_cpu(data) & 0x0f;
+	if (*clock >= SND_DG00X_CLOCK_COUNT)
+		err = -EIO;
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
+	unsigned int i, c;
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
+	amdtp_stream_set_parameters(&dg00x->rx_stream, rate,
+				    snd_dg00x_stream_mbla_data_channels[i], 2);
+	err = fw_iso_resources_allocate(&dg00x->rx_resources,
+				amdtp_stream_get_max_payload(&dg00x->rx_stream),
+				fw_parent_device(dg00x->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for in-stream. */
+	amdtp_stream_set_parameters(&dg00x->tx_stream, rate,
+				    snd_dg00x_stream_mbla_data_channels[i], 1);
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
+	/* The first data channel in a packet is for MIDI conformant data. */
+	dg00x->rx_stream.midi_position = 0;
+	dg00x->tx_stream.midi_position = 0;
+	for (c = 0; c < snd_dg00x_stream_mbla_data_channels[i]; c++) {
+		dg00x->rx_stream.pcm_positions[c] = c + 1;
+		dg00x->tx_stream.pcm_positions[c] = c + 1;
+	}
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
+		return err;
+	err = amdtp_stream_init(&dg00x->rx_stream, dg00x->unit,
+				AMDTP_OUT_STREAM, CIP_NONBLOCKING);
+
+	/* For in-stream. */
+	err = fw_iso_resources_init(&dg00x->tx_resources, dg00x->unit);
+	if (err < 0)
+		return err;
+	err = amdtp_stream_init(&dg00x->tx_stream, dg00x->unit,
+				AMDTP_IN_STREAM,
+				CIP_BLOCKING | CIP_SKIP_INIT_DBC_CHECK);
+	if (err < 0)
+		amdtp_stream_destroy(&dg00x->rx_stream);
+
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
+	if (dg00x->playback_substreams == 0 &&
+	    dg00x->capture_substreams == 0)
+		goto end;
+
+	/* Check current sampling rate. */
+	err = snd_dg00x_stream_get_rate(dg00x, &curr_rate);
+	if (err < 0)
+		goto error;
+	if ((curr_rate != rate) |
+	    amdtp_streaming_error(&dg00x->tx_stream) |
+	    amdtp_streaming_error(&dg00x->rx_stream)) {
+		finish_session(dg00x);
+
+		amdtp_stream_stop(&dg00x->tx_stream);
+		amdtp_stream_stop(&dg00x->rx_stream);
+		release_resources(dg00x);
+	}
+
+	/* No streams are transmitted without receiving a stream. */
+	if (!amdtp_stream_running(&dg00x->rx_stream)) {
+		err = snd_dg00x_stream_set_rate(dg00x, rate);
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
+						CALLBACK_TIMEOUT)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+	}
+
+	/*
+	 * The value of SYT field in transmitted packets is always 0x0000. Thus,
+	 * duplex streams with timestamp synchronization cannot be built.
+	 */
+	if (dg00x->capture_substreams > 0 &&
+	    !amdtp_stream_running(&dg00x->tx_stream)) {
+		err = amdtp_stream_start(&dg00x->tx_stream,
+				dg00x->tx_resources.channel,
+				fw_parent_device(dg00x->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		if (!amdtp_stream_wait_callback(&dg00x->tx_stream,
+						CALLBACK_TIMEOUT)) {
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
+	if (dg00x->capture_substreams > 0)
+		return;
+	amdtp_stream_stop(&dg00x->tx_stream);
+
+	if (dg00x->playback_substreams > 0)
+		return;
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
+/* TODO: investigation. */
+void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x)
+{
+	fw_iso_resources_update(&dg00x->tx_resources);
+	fw_iso_resources_update(&dg00x->rx_resources);
+
+	amdtp_stream_update(&dg00x->tx_stream);
+	amdtp_stream_update(&dg00x->rx_stream);
+}
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 6f427a2..b82bce7 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -47,6 +47,8 @@ static void dg00x_card_free(struct snd_card *card)
 {
 	struct snd_dg00x *dg00x = card->private_data;
 
+	snd_dg00x_stream_destroy_duplex(dg00x);
+
 	fw_unit_put(dg00x->unit);
 
 	mutex_destroy(&dg00x->mutex);
@@ -78,6 +80,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_dg00x_stream_init_duplex(dg00x);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
@@ -90,6 +96,15 @@ error:
 	return err;
 }
 
+static void snd_dg00x_update(struct fw_unit *unit)
+{
+	struct snd_dg00x *dg00x = dev_get_drvdata(&unit->device);
+
+	mutex_lock(&dg00x->mutex);
+	snd_dg00x_stream_update_duplex(dg00x);
+	mutex_unlock(&dg00x->mutex);
+}
+
 static void snd_dg00x_remove(struct fw_unit *unit)
 {
 	struct snd_dg00x *dg00x = dev_get_drvdata(&unit->device);
@@ -118,6 +133,7 @@ static struct fw_driver dg00x_driver = {
 		.bus = &fw_bus_type,
 	},
 	.probe    = snd_dg00x_probe,
+	.update   = snd_dg00x_update,
 	.remove   = snd_dg00x_remove,
 	.id_table = snd_dg00x_id_table,
 };
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 59425cd..2e960c7 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -21,6 +21,11 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 
+#include "../lib.h"
+#include "../packets-buffer.h"
+#include "../iso-resources.h"
+#include "../amdtp.h"
+
 struct snd_dg00x {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -28,6 +33,76 @@ struct snd_dg00x {
 
 	struct mutex mutex;
 	spinlock_t lock;
+
+	struct amdtp_stream tx_stream;
+	struct fw_iso_resources tx_resources;
+
+	struct amdtp_stream rx_stream;
+	struct fw_iso_resources rx_resources;
+
+	unsigned int playback_substreams;
+	unsigned int capture_substreams;
 };
 
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
+/* unknown				0x0118 */
+/* unknown				0x010c */
+#define DG00X_OFFSET_RATE_SET		0x0110
+#define DG00X_OFFSET_RATE_GET		0x0114
+#define DG00X_OFFSET_CLOCK_SOURCE	0x0118
+#define DG00X_OFFSET_OPT_IFACE_MODE	0x011c
+/* unknown				0x0120 */
+/* unknown				0x0124 */
+/* unknown				0x0128 */
+/* unknown				0x012c */
+/* unknown				0x0138 */
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
+};
+
+extern const unsigned int snd_dg00x_stream_rates[SND_DG00X_RATE_COUNT];
+extern const unsigned int
+snd_dg00x_stream_mbla_data_channels[SND_DG00X_RATE_COUNT];
+int snd_dg00x_stream_get_rate(struct snd_dg00x *dg00x, unsigned int *rate);
+int snd_dg00x_stream_set_rate(struct snd_dg00x *dg00x, unsigned int rate);
+int snd_dg00x_stream_get_clock(struct snd_dg00x *dg00x,
+			       enum snd_dg00x_clock *clock);
+int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x);
+int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate);
+void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x);
+void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
+void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
+
 #endif
-- 
2.1.0
