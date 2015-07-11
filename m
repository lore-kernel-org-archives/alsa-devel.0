From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 32/37] ALSA: firewire-motu: add stream
	functionality
Date: Sat, 11 Jul 2015 23:12:43 +0900
Message-ID: <1436623968-10780-33-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E2AF2605D3
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:07 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a functionality to manage streaming.

The streaming is not controlled by CMP, against IEC 61883-1. It's
controlled by writing to certain addresses.

Several clock sources are available, while there're no differences about
packet transmission among clock sources. The value of SYT field in
transferred packets is always zero. Thus, streams in both direction
don't build synchronization.

The number of data chunks for PCM samples is decided according to current
sampling rate, optical mode for digital input/output interfaces. For PCM
functionality, the number of data blocks is cached in device instance.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile      |   2 +-
 sound/firewire/motu/motu-stream.c | 632 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c        |  15 +-
 sound/firewire/motu/motu.h        |  39 +++
 4 files changed, 684 insertions(+), 4 deletions(-)
 create mode 100644 sound/firewire/motu/motu-stream.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index 5c35d77..1547a98 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-motu-objs := amdtp-motu.o motu.o
+snd-firewire-motu-objs := amdtp-motu.o motu-stream.o motu.o
 obj-m += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
new file mode 100644
index 0000000..d6fc84f
--- /dev/null
+++ b/sound/firewire/motu/motu-stream.c
@@ -0,0 +1,632 @@
+/*
+ * motu-stream.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "motu.h"
+
+#define	CALLBACK_TIMEOUT	200
+
+#define CLOCK_STATUS_OFFSET	0x0b14
+#define G2_CLOCK_RATE_SHIFT	3
+#define G2_CLOCK_RATE_MASK	0x00000038
+#define G2_CLOCK_SRC_SHIFT	0
+#define G2_CLOCK_SRC_MASK	0x00000007
+
+const unsigned int snd_motu_rates[SND_MOTU_RATES_COUNT] = {
+	/* mode 0 */
+	[0] =  44100,
+	[1] =  48000,
+	/* mode 1 */
+	[2] =  88200,
+	[3] =  96000,
+	/* mode 2 */
+	[4] = 176400,
+	[5] = 192000,
+};
+
+static int get_rate_g2(struct snd_motu *motu, unsigned int *rate)
+{
+	__be32 data;
+	unsigned int index;
+	int err;
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 MOTU_REG_BASE + CLOCK_STATUS_OFFSET,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	index = (be32_to_cpu(data) & G2_CLOCK_RATE_MASK) >> G2_CLOCK_RATE_SHIFT;
+	*rate = snd_motu_rates[index];
+
+	return 0;
+}
+
+static int set_rate_g2(struct snd_motu *motu, unsigned int rate)
+{
+	__u32 data;
+	__be32 reg;
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_rates); i++) {
+		if (snd_motu_rates[i] == rate)
+			break;
+	}
+	if (i == ARRAY_SIZE(snd_motu_rates))
+		return -EINVAL;
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 MOTU_REG_BASE + CLOCK_STATUS_OFFSET,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	data &= ~G2_CLOCK_RATE_MASK;
+	data |= i << G2_CLOCK_RATE_SHIFT;
+	data |= 0x07000000;
+
+	reg = cpu_to_be32(data);
+	return snd_fw_transaction(motu->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  MOTU_REG_BASE + CLOCK_STATUS_OFFSET,
+				  &reg, sizeof(reg), 0);
+}
+
+static int get_rate_g3(struct snd_motu *motu, unsigned int *rate)
+{
+	__be32 data;
+	unsigned int index;
+	int err;
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 MOTU_REG_BASE + CLOCK_STATUS_OFFSET,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	index = (be32_to_cpu(data) & 0x00000700) >> 8;
+	if (index > SND_MOTU_RATES_COUNT)
+		return -EIO;
+
+	*rate = snd_motu_rates[index];
+
+	return 0;
+}
+
+static int set_rate_g3(struct snd_motu *motu, unsigned int rate)
+{
+	__u32 reg;
+	__be32 data;
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_rates); i++) {
+		if (snd_motu_rates[i] == rate)
+			break;
+	}
+	if (i == ARRAY_SIZE(snd_motu_rates))
+		return -EINVAL;
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 MOTU_REG_BASE + CLOCK_STATUS_OFFSET,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+	reg = be32_to_cpu(data);
+
+	reg &= 0xf8fff8ff;
+	reg |= i << 8;
+	reg |= 0x07000000;
+
+	data = cpu_to_be32(reg);
+	return snd_fw_transaction(motu->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  MOTU_REG_BASE + CLOCK_STATUS_OFFSET,
+				  &data, sizeof(data), 0);
+}
+
+static int get_clock_g2(struct snd_motu *motu, enum snd_motu_clock *src)
+{
+	__be32 data;
+	unsigned int index;
+	int err;
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 MOTU_REG_BASE + CLOCK_STATUS_OFFSET,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	index = be32_to_cpu(data) & G2_CLOCK_SRC_MASK;
+	if (index > 5)
+		return -EIO;
+
+	switch (index) {
+	case 0:
+		*src = SND_MOTU_CLOCK_INTERNAL;
+		break;
+	case 1:
+		*src = SND_MOTU_CLOCK_OPT;
+		break;
+	case 2:
+		*src = SND_MOTU_CLOCK_SPDIF_COAX;
+		break;
+	case 3:
+		*src = SND_MOTU_CLOCK_SPH;
+		break;
+	case 4:
+		*src = SND_MOTU_CLOCK_WORD_BNC;
+		break;
+	case 5:
+		*src = SND_MOTU_CLOCK_ADAT_DSUB;
+		break;
+	case 6:
+		*src = SND_MOTU_CLOCK_AESEBU_XLR;
+		break;
+	default:
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int get_clock_g3(struct snd_motu *motu, enum snd_motu_clock *src)
+{
+	__be32 data;
+	unsigned int index;
+	int err;
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 MOTU_REG_BASE + CLOCK_STATUS_OFFSET,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	index = be32_to_cpu(data) & 0x0000001b;
+	switch (index) {
+	case 0:
+		*src = SND_MOTU_CLOCK_INTERNAL;
+		break;
+	case 1:
+		*src = SND_MOTU_CLOCK_WORD_BNC;
+		break;
+	case 2:
+		*src = SND_MOTU_CLOCK_SPH;
+		break;
+	case 16:
+		*src = SND_MOTU_CLOCK_SPDIF_COAX;
+		break;
+	case 18:
+	case 19:
+		*src = SND_MOTU_CLOCK_OPT;
+		break;
+	default:
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int snd_motu_stream_get_rate(struct snd_motu *motu, unsigned int *rate)
+{
+	if (motu->spec->generation == 2)
+		return get_rate_g2(motu, rate);
+	else
+		return get_rate_g3(motu, rate);
+}
+
+int snd_motu_stream_set_rate(struct snd_motu *motu, unsigned int rate)
+{
+	if (motu->spec->generation == 2)
+		return set_rate_g2(motu, rate);
+	else
+		return set_rate_g3(motu, rate);
+}
+
+int snd_motu_stream_get_clock(struct snd_motu *motu,
+				   enum snd_motu_clock *src)
+{
+	if (motu->spec->generation == 2)
+		return get_clock_g2(motu, src);
+	else
+		return get_clock_g3(motu, src);
+}
+
+static int update_channel_cache_g2(struct snd_motu *motu)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 0xfffff0000c04,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	/* ADAT is available in input optical interface. */
+	if ((data & 0x00000100) && motu->spec->tx_optical_ifaces == 1) {
+		motu->tx_pcm_channels[0] += 8;
+		motu->tx_pcm_channels[1] += 4;
+	}
+
+	/* ADAT is available in output optical interface. */
+	if ((data & 0x00000400) && motu->spec->rx_optical_ifaces == 1) {
+		motu->rx_pcm_channels[0] += 8;
+		motu->rx_pcm_channels[1] += 4;
+	}
+
+	return 0;
+}
+
+static int update_channel_cache_g3(struct snd_motu *motu)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 0xfffff0000c04,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	if (motu->spec->tx_optical_ifaces > 0) {
+		/* The optical input interface A is enabled. */
+		if (data & 0x00000001) {
+			/* It's S/PDIF. */
+			if (data & 0x00010000) {
+				motu->tx_pcm_channels[0] += 4;
+				motu->tx_pcm_channels[1] += 4;
+			/* It's ADAT. */
+			} else {
+				motu->tx_pcm_channels[0] += 8;
+				motu->tx_pcm_channels[1] += 4;
+			}
+		}
+
+		/* The optical input interface B is enabled. */
+		if (data & 0x00000002) {
+			/* It's S/PDIF. */
+			if (data & 0x00100000) {
+				motu->tx_pcm_channels[0] += 4;
+				motu->tx_pcm_channels[1] += 4;
+			/* It's ADAT. */
+			} else {
+				motu->tx_pcm_channels[0] += 8;
+				motu->tx_pcm_channels[1] += 4;
+			}
+		}
+	}
+
+	if (motu->spec->rx_optical_ifaces > 0) {
+		/* The optical output interface A is enabled. */
+		if (data & 0x00000100) {
+			/* It's S/PDIF. */
+			if (data & 0x00040000) {
+				motu->rx_pcm_channels[0] += 4;
+				motu->rx_pcm_channels[1] += 4;
+			/* It's ADAT. */
+			} else {
+				motu->rx_pcm_channels[0] += 8;
+				motu->rx_pcm_channels[1] += 4;
+			}
+		}
+
+		/* The optical output interface B is enabled. */
+		if (data & 0x00000200) {
+			/* It's S/PDIF. */
+			if (data & 0x00400000) {
+				motu->rx_pcm_channels[0] += 4;
+				motu->rx_pcm_channels[1] += 4;
+			/* It's ADAT. */
+			} else {
+				motu->rx_pcm_channels[0] += 8;
+				motu->rx_pcm_channels[1] += 4;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int snd_motu_stream_update_current_channels(struct snd_motu *motu)
+{
+	struct snd_motu_spec *spec = motu->spec;
+	unsigned int i;
+	int err;
+
+	/* Initializing. */
+	for (i = 0; i < 3; i++) {
+		motu->tx_pcm_channels[i] = spec->tx_common_pcm_channels[i];
+		motu->rx_pcm_channels[i] = spec->rx_common_pcm_channels[i];
+	}
+
+	if (spec->generation == 2)
+		err = update_channel_cache_g2(motu);
+	else
+		err = update_channel_cache_g3(motu);
+
+	return err;
+}
+
+static void stop_stream(struct snd_motu *motu, struct amdtp_stream *stream)
+{
+	__u32 reg;
+	__be32 data;
+	struct fw_iso_resources *resources;
+	int err;
+
+	amdtp_stream_pcm_abort(stream);
+	amdtp_stream_stop(stream);
+
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 0xfffff0000b00ull,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return;
+
+	if (stream == &motu->tx_stream) {
+		reg = be32_to_cpu(data) & 0x00ffffff;
+		reg |= 0x80000000;
+		resources = &motu->tx_resources;
+	} else {
+		reg = be32_to_cpu(data) & 0xff00ffff;
+		reg |= 0x00800000;
+		resources = &motu->rx_resources;
+	}
+
+	data = cpu_to_be32(reg);
+	snd_fw_transaction(motu->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   0xfffff0000b00ull,
+			   &data, sizeof(data), 0);
+
+	fw_iso_resources_free(resources);
+}
+
+static int start_stream(struct snd_motu *motu, struct amdtp_stream *stream,
+			unsigned int rate)
+{
+	__u32 reg;
+	__be32 data;
+	struct fw_iso_resources *resources;
+	unsigned int pcm_chs, midi_ports;
+	unsigned int i, mode;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_rates); i++) {
+		if (snd_motu_rates[i] == rate) {
+			mode = i / 2;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(snd_motu_rates))
+		return -EINVAL;
+
+	if (stream == &motu->tx_stream) {
+		resources = &motu->tx_resources;
+		pcm_chs = motu->tx_pcm_channels[mode];
+		midi_ports = motu->spec->tx_midi_ports;
+	} else {
+		resources = &motu->rx_resources;
+		pcm_chs = motu->rx_pcm_channels[mode];
+		midi_ports = motu->spec->rx_midi_ports;
+	}
+
+	err = amdtp_motu_set_parameters(stream, rate, pcm_chs, midi_ports);
+	if (err < 0)
+		return err;
+
+	/* Get current status. */
+	err = snd_fw_transaction(motu->unit, TCODE_READ_QUADLET_REQUEST,
+				 0xfffff0000b00ull,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	/* Get isochronous resources. */
+	err = fw_iso_resources_allocate(resources,
+				amdtp_stream_get_max_payload(stream),
+				fw_parent_device(motu->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	/* Start isochronous context. */
+	err = amdtp_stream_start(stream, resources->channel,
+			       fw_parent_device(motu->unit)->max_speed);
+	if (err < 0)
+		goto error;
+
+	/* Start packet stream with the isochronous channel. */
+	if (resources == &motu->tx_resources) {
+		reg = be32_to_cpu(data) & 0xff00ffff;
+		reg |= resources->channel << 16;
+		reg |= 0x00c00000;
+	} else {
+		reg = be32_to_cpu(data) & 0x00ffffff;
+		reg |= resources->channel << 24;
+		reg |= 0xc0000000;
+	}
+	data = cpu_to_be32(reg);
+	err = snd_fw_transaction(motu->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 0xfffff0000b00ull,
+				 &data, sizeof(data), 0);
+	if (err < 0) {
+		amdtp_stream_stop(stream);
+		goto error;
+	}
+
+	return 0;
+error:
+	fw_iso_resources_free(resources);
+	return err;
+}
+
+int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
+{
+	unsigned int curr_rate;
+	int err = 0;
+
+	if (motu->substreams_counter == 0)
+		goto end;
+
+	/* Some packet queueing errors. */
+	if (amdtp_streaming_error(&motu->tx_stream) ||
+	    amdtp_streaming_error(&motu->rx_stream)) {
+		stop_stream(motu, &motu->tx_stream);
+		stop_stream(motu, &motu->rx_stream);
+	}
+
+	err = snd_motu_stream_update_current_channels(motu);
+	if (err < 0)
+		return err;
+
+	/* Stop stream if rate is different. */
+	err = snd_motu_stream_get_rate(motu, &curr_rate);
+	if (err < 0) {
+		dev_err(&motu->unit->device,
+			"fail to get sampling rate\n");
+		goto end;
+	}
+	if (rate == 0)
+		rate = curr_rate;
+	if (rate != curr_rate) {
+		stop_stream(motu, &motu->tx_stream);
+		stop_stream(motu, &motu->rx_stream);
+	}
+
+	if (!amdtp_stream_running(&motu->rx_stream)) {
+		err = snd_motu_stream_set_rate(motu, rate);
+		if (err < 0) {
+			dev_err(&motu->unit->device,
+				"fail to set sampling rate\n");
+			goto end;
+		}
+
+		/* Start both streams. */
+		err = start_stream(motu, &motu->rx_stream, rate);
+		if (err < 0) {
+			dev_err(&motu->unit->device,
+				"fail to start AMDTP master stream\n");
+			goto end;
+		}
+
+		if (!amdtp_stream_wait_callback(&motu->rx_stream,
+						CALLBACK_TIMEOUT)) {
+			stop_stream(motu, &motu->rx_stream);
+			err = -ETIMEDOUT;
+			goto end;
+		}
+	}
+
+	if (!amdtp_stream_running(&motu->tx_stream)) {
+		err = start_stream(motu, &motu->tx_stream, rate);
+		if (err < 0) {
+			dev_err(&motu->unit->device,
+				"fail to start AMDTP slave stream\n");
+			stop_stream(motu, &motu->rx_stream);
+			goto end;
+		}
+		if (!amdtp_stream_wait_callback(&motu->tx_stream,
+						CALLBACK_TIMEOUT)) {
+			stop_stream(motu, &motu->rx_stream);
+			stop_stream(motu, &motu->tx_stream);
+			err = -ETIMEDOUT;
+		}
+	}
+end:
+	return err;
+}
+
+void snd_motu_stream_stop_duplex(struct snd_motu *motu)
+{
+	if (motu->substreams_counter > 0)
+		return;
+
+	stop_stream(motu, &motu->tx_stream);
+	stop_stream(motu, &motu->rx_stream);
+}
+
+static int init_stream(struct snd_motu *motu, struct amdtp_stream *stream)
+{
+	int err;
+	struct fw_iso_resources *resources;
+	enum amdtp_stream_direction dir;
+
+	if (stream == &motu->tx_stream) {
+		resources = &motu->tx_resources;
+		dir = AMDTP_IN_STREAM;
+	} else {
+		resources = &motu->rx_resources;
+		dir = AMDTP_OUT_STREAM;
+	}
+
+	err = fw_iso_resources_init(resources, motu->unit);
+	if (err < 0)
+		return err;
+
+	err = amdtp_motu_init(stream, motu->unit, dir);
+	if (err < 0) {
+		amdtp_stream_destroy(stream);
+		fw_iso_resources_destroy(resources);
+	}
+
+	return err;
+}
+
+/*
+ * This function should be called before starting streams or after stopping
+ * streams.
+ */
+static void destroy_stream(struct snd_motu *motu, struct amdtp_stream *stream)
+{
+	struct fw_iso_resources *resources;
+
+	if (stream == &motu->tx_stream)
+		resources = &motu->tx_resources;
+	else
+		resources = &motu->rx_resources;
+
+	amdtp_stream_destroy(stream);
+	fw_iso_resources_destroy(resources);
+}
+
+int snd_motu_stream_init_duplex(struct snd_motu *motu)
+{
+	int err;
+
+	motu->substreams_counter = 0;
+
+	err = init_stream(motu, &motu->tx_stream);
+	if (err < 0)
+		return err;
+
+	err = init_stream(motu, &motu->rx_stream);
+	if (err < 0)
+		destroy_stream(motu, &motu->tx_stream);
+
+	return err;
+}
+
+void snd_motu_stream_destroy_duplex(struct snd_motu *motu)
+{
+	destroy_stream(motu, &motu->tx_stream);
+	destroy_stream(motu, &motu->rx_stream);
+
+	motu->substreams_counter = 0;
+}
+
+void snd_motu_stream_update_duplex(struct snd_motu *motu)
+{
+	stop_stream(motu, &motu->tx_stream);
+	stop_stream(motu, &motu->rx_stream);
+
+	fw_iso_resources_update(&motu->tx_resources);
+	fw_iso_resources_update(&motu->rx_resources);
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index eb83e87..8666819 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -41,6 +41,7 @@ static void motu_card_free(struct snd_card *card)
 {
 	struct snd_motu *motu = card->private_data;
 
+	snd_motu_stream_destroy_duplex(motu);
 	fw_unit_put(motu->unit);
 
 	mutex_destroy(&motu->mutex);
@@ -66,6 +67,10 @@ static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	name_card(motu);
 
+	err = snd_motu_stream_init_duplex(motu);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
@@ -86,9 +91,13 @@ static void motu_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(motu->card);
 }
 
-static void motu_bus_reset(struct fw_unit *unit)
+static void motu_bus_update(struct fw_unit *unit)
 {
-	return;
+	struct snd_motu *motu = dev_get_drvdata(&unit->device);
+
+	mutex_lock(&motu->mutex);
+	snd_motu_stream_update_duplex(motu);
+	mutex_unlock(&motu->mutex);
 }
 
 static struct snd_motu_spec motu_828mk2 = {
@@ -259,7 +268,7 @@ static struct fw_driver motu_driver = {
 		.bus	= &fw_bus_type,
 	},
 	.probe    = motu_probe,
-	.update   = motu_bus_reset,
+	.update   = motu_bus_update,
 	.remove   = motu_remove,
 	.id_table = motu_id_table,
 };
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 690818f..b3fc558 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -49,6 +49,32 @@ struct snd_motu {
 
 	/* Model dependent information. */
 	struct snd_motu_spec *spec;
+
+	/* For streaming */
+	struct fw_iso_resources tx_resources;
+	struct fw_iso_resources rx_resources;
+	struct amdtp_stream tx_stream;
+	struct amdtp_stream rx_stream;
+	unsigned int substreams_counter;
+
+	/* Between pcm.open() and pcm.prepare(). */
+	unsigned int tx_pcm_channels[3];
+	unsigned int rx_pcm_channels[3];
+};
+
+#define MOTU_REG_BASE		0xfffff0000000ull
+
+#define SND_MOTU_RATES_COUNT	6
+extern const unsigned int snd_motu_rates[SND_MOTU_RATES_COUNT];
+
+enum snd_motu_clock {
+	SND_MOTU_CLOCK_INTERNAL = 0,
+	SND_MOTU_CLOCK_OPT,		/* S/PDIF or ADAT */
+	SND_MOTU_CLOCK_SPDIF_COAX,
+	SND_MOTU_CLOCK_SPH,		/* SMPTE */
+	SND_MOTU_CLOCK_ADAT_DSUB,
+	SND_MOTU_CLOCK_AESEBU_XLR,
+	SND_MOTU_CLOCK_WORD_BNC,
 };
 
 int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -59,4 +85,17 @@ int amdtp_motu_set_parameters(struct amdtp_stream *s, unsigned int rate,
 void amdtp_motu_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
 void amdtp_motu_midi_trigger(struct amdtp_stream *s, unsigned int port,
 			     struct snd_rawmidi_substream *midi);
+
+int snd_motu_stream_init_duplex(struct snd_motu *motu);
+void snd_motu_stream_destroy_duplex(struct snd_motu *motu);
+int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate);
+void snd_motu_stream_stop_duplex(struct snd_motu *motu);
+void snd_motu_stream_update_duplex(struct snd_motu *motu);
+
+int snd_motu_stream_get_rate(struct snd_motu *motu, unsigned int *rate);
+int snd_motu_stream_set_rate(struct snd_motu *motu, unsigned int rate);
+int snd_motu_stream_get_clock(struct snd_motu *motu,
+			      enum snd_motu_clock *src);
+int snd_motu_stream_update_current_channels(struct snd_motu *motu);
+
 #endif
-- 
2.1.4
