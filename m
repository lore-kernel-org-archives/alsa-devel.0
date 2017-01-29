From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/19] firewire-motu: add support for MOTU 828
	as a model with protocol version 1
Date: Sun, 29 Jan 2017 12:54:14 +0900
Message-ID: <20170129035417.2095-17-o-takashi@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 0B1792669F3
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 04:54:28 +0100 (CET)
In-Reply-To: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
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

MOTU 828 is a first model in this series, produced in 2001. This model
consists of three chips:
 * TI TSB41AB1 (Physical layer for IEEE 1394 bus)
 * PDI 1394L21BE (Link layer for IEEE 1394 bus and packet processing layer)
 * QuickLogic DA828FW (Data block processing layer and digital signal
   processing)

This commit adds a support for this model, with its unique protocol as
version 1. The features of this protocol are:

 * no MIDI support.
 * Rx packets have no data chunks for control and status messages.
 * Tx packets have data chunks for control and status messages in the end
   of each data block.
 * All of settings are represented in bit flag in one quadlet address
   (0x'ffff'f000'0b00).
 * When optical interface is configured as S/PDIF, signals of the interface
   is multiplexed for packets, instead of signals of coaxial interface.
   Thus, differed part of data chunks is not used.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                 |   1 +
 sound/firewire/motu/Makefile           |   3 +-
 sound/firewire/motu/motu-protocol-v1.c | 204 +++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c             |   9 ++
 sound/firewire/motu/motu.h             |   2 +
 5 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-protocol-v1.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 11a3285..a031b9c 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -146,6 +146,7 @@ config SND_FIREWIRE_MOTU
 	select SND_HWDEP
 	help
 	 Say Y here to enable support for FireWire devices which MOTU produced:
+	  * 828
 
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-motu.
diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index cc195d5..15090be 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,3 +1,4 @@
 snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o \
-			  motu-proc.o motu-pcm.o motu-midi.o motu-hwdep.o
+			  motu-proc.o motu-pcm.o motu-midi.o motu-hwdep.o \
+			  motu-protocol-v1.o
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-protocol-v1.c b/sound/firewire/motu/motu-protocol-v1.c
new file mode 100644
index 0000000..1087f46
--- /dev/null
+++ b/sound/firewire/motu/motu-protocol-v1.c
@@ -0,0 +1,204 @@
+/*
+ * motu-protocol-v1.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "motu.h"
+
+#define V1_CLOCK_STATUS_OFFSET			0x0b00
+#define  V1_OPT_IN_IFACE_IS_SPDIF		0x00008000
+#define  V1_OPT_OUT_IFACE_IS_SPDIF		0x00004000
+#define  V1_FETCH_PCM_FRAMES			0x00000080
+#define  V1_CLOCK_SRC_IS_NOT_FROM_ADAT_DSUB	0x00000020
+#define  V1_CLOCK_RATE_BASED_ON_48000		0x00000004
+#define  V1_CLOCK_SRC_SPDIF_ON_OPT_OR_COAX	0x00000002
+#define  V1_CLOCK_SRC_ADAT_ON_OPT_OR_DSUB	0x00000001
+
+static int v1_get_clock_rate(struct snd_motu *motu, unsigned int *rate)
+{
+	__be32 reg;
+	u32 data;
+	int index, err;
+
+	err = snd_motu_transaction_read(motu, V1_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	if (data & V1_CLOCK_RATE_BASED_ON_48000)
+		index = 1;
+	else
+		index = 0;
+
+	*rate = snd_motu_clock_rates[index];
+
+	return 0;
+}
+
+static int v1_set_clock_rate(struct snd_motu *motu, unsigned int rate)
+{
+	__be32 reg;
+	u32 data;
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_clock_rates); ++i) {
+		if (snd_motu_clock_rates[i] == rate)
+			break;
+	}
+	if (i == ARRAY_SIZE(snd_motu_clock_rates))
+		return -EINVAL;
+
+	err = snd_motu_transaction_read(motu, V1_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	data &= ~V1_FETCH_PCM_FRAMES;
+	if (rate == 48000)
+		data |= V1_CLOCK_RATE_BASED_ON_48000;
+	else
+		data &= ~V1_CLOCK_RATE_BASED_ON_48000;
+
+	reg = cpu_to_be32(data);
+	return snd_motu_transaction_write(motu, V1_CLOCK_STATUS_OFFSET, &reg,
+					  sizeof(reg));
+}
+
+static int v1_get_clock_source(struct snd_motu *motu,
+			       enum snd_motu_clock_source *src)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V1_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+
+	data = be32_to_cpu(reg);
+	if (data & V1_CLOCK_SRC_ADAT_ON_OPT_OR_DSUB) {
+		if (data & V1_CLOCK_SRC_IS_NOT_FROM_ADAT_DSUB)
+			*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT;
+		else
+			*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_DSUB;
+	} else if (data & V1_CLOCK_SRC_SPDIF_ON_OPT_OR_COAX) {
+		if (data & V1_OPT_IN_IFACE_IS_SPDIF)
+			*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT;
+		else
+			*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX;
+	} else {
+		*src = SND_MOTU_CLOCK_SOURCE_INTERNAL;
+	}
+
+	return 0;
+}
+
+static int v1_switch_fetching_mode(struct snd_motu *motu, bool enable)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V1_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	if (enable)
+		data |= V1_FETCH_PCM_FRAMES;
+	else
+		data &= ~V1_FETCH_PCM_FRAMES;
+
+	reg = cpu_to_be32(data);
+	return snd_motu_transaction_write(motu, V1_CLOCK_STATUS_OFFSET, &reg,
+					  sizeof(reg));
+}
+
+static void calculate_fixed_part(struct snd_motu_packet_format *formats,
+				 enum amdtp_stream_direction dir,
+				 enum snd_motu_spec_flags flags,
+				 unsigned char analog_ports)
+{
+	unsigned char pcm_chunks[3] = {0, 0, 0};
+	int i;
+
+	if (dir == AMDTP_IN_STREAM)
+		formats->msg_chunks = 2;
+	else
+		formats->msg_chunks = 0;
+
+	pcm_chunks[0] = analog_ports;
+	if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X2)
+		pcm_chunks[1] = analog_ports;
+	if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X4)
+		pcm_chunks[2] = analog_ports;
+
+	pcm_chunks[0] += 2;
+	if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X2)
+		pcm_chunks[1] += 2;
+
+	for (i = 0; i < 3; ++i)
+		formats->fixed_part_pcm_chunks[i] = pcm_chunks[i];
+}
+
+static void calculate_differed_part(struct snd_motu_packet_format *formats,
+				    enum snd_motu_spec_flags flags,
+				    u32 opt_iface_mode_data,
+				    u32 opt_iface_mode_mask)
+{
+	unsigned char pcm_chunks[3] = {0, 0, 0};
+	int i;
+
+	/* Packet includes PCM frames from ADAT on optical interface. */
+	if (!(opt_iface_mode_data & opt_iface_mode_mask)) {
+		pcm_chunks[0] += 8;
+		if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X2)
+			pcm_chunks[1] += 4;
+	}
+
+	for (i = 0; i < 3; ++i)
+		formats->differed_part_pcm_chunks[i] = pcm_chunks[i];
+}
+
+static int v1_cache_packet_formats(struct snd_motu *motu)
+{
+	__be32 reg;
+	u32 opt_iface_mode_data;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V1_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	opt_iface_mode_data = be32_to_cpu(reg);
+
+	calculate_fixed_part(&motu->tx_packet_formats, AMDTP_IN_STREAM,
+			     motu->spec->flags, motu->spec->analog_in_ports);
+	calculate_differed_part(&motu->tx_packet_formats, motu->spec->flags,
+				opt_iface_mode_data, V1_OPT_IN_IFACE_IS_SPDIF);
+
+	calculate_fixed_part(&motu->rx_packet_formats, AMDTP_OUT_STREAM,
+			     motu->spec->flags, motu->spec->analog_out_ports);
+	calculate_differed_part(&motu->rx_packet_formats, motu->spec->flags,
+				opt_iface_mode_data, V1_OPT_OUT_IFACE_IS_SPDIF);
+
+	motu->tx_packet_formats.pcm_byte_offset = 4;
+	motu->rx_packet_formats.pcm_byte_offset = 4;
+
+	return 0;
+}
+
+const struct snd_motu_protocol snd_motu_protocol_v1 = {
+	.get_clock_rate		= v1_get_clock_rate,
+	.set_clock_rate		= v1_set_clock_rate,
+	.get_clock_source	= v1_get_clock_source,
+	.switch_fetching_mode	= v1_switch_fetching_mode,
+	.cache_packet_formats	= v1_cache_packet_formats,
+};
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 619554b..e9705e3 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -190,6 +190,14 @@ static void motu_bus_update(struct fw_unit *unit)
 	snd_motu_transaction_reregister(motu);
 }
 
+static struct snd_motu_spec motu_828orig = {
+	.name = "828",
+	.protocol = &snd_motu_protocol_v1,
+
+	.analog_in_ports = 8,
+	.analog_out_ports = 8,
+};
+
 #define SND_MOTU_DEV_ENTRY(model, data)			\
 {							\
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID |	\
@@ -202,6 +210,7 @@ static void motu_bus_update(struct fw_unit *unit)
 }
 
 static const struct ieee1394_device_id motu_id_table[] = {
+	SND_MOTU_DEV_ENTRY(0x102802, &motu_828orig),
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, motu_id_table);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 407ce09..d091f68 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -121,6 +121,8 @@ struct snd_motu_spec {
 	const struct snd_motu_protocol *const protocol;
 };
 
+extern const struct snd_motu_protocol snd_motu_protocol_v1;
+
 int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 		    enum amdtp_stream_direction dir,
 		    const struct snd_motu_protocol *const protocol);
-- 
2.9.3
