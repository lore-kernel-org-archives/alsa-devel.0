From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/19] firewire-motu: add support for MOTU
	828mk3 (FireWire/Hybrid) as a model with protocol version 3
Date: Sun, 29 Jan 2017 12:54:17 +0900
Message-ID: <20170129035417.2095-20-o-takashi@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 3E961266A8F
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

MOTU 828mk3 (FireWire/Hybrid) is one of third generation in MOTU FireWire
series, produced in 2008/2014. This model consists of three chips for
functionality on IEEE 1394 bus:

 * TI TSB41AB2 (Physical layer for IEEE 1394 bus)
 * Xilinx Spartan-3E FPGA Family (Link layer for IEEE 1394 bus, packet
   processing and data block processing layer)
 * TI TMS320C6722 (Digital signal processing)

This commit adds a support for this model, with its unique protocol as
version 3. This protocol has some additional features to protocol
version 2.

 * Support several optical interfaces.
 * Support a data chunk for return of reverb effect.
 * Have a quirk of tx packets.
 * Support heartbeat asynchronous transaction.

In this protocol, series of transferred packets has some quirks. Below
fields in CIP headers of the packets are out of IEC 61883-1:
 - SID (source node id): always 0x0d
 - DBS (data block size): always always 0x04
 - DBC (data block counter): always 0x00
 - EOH (End of header): always 0x00

Below is an actual sample of transferred packets.

quads CIP1       CIP2
520   0x0D040400 0x22FFFFFF
  8   0x0D040400 0x22FFFFFF
520   0x0D040400 0x22FFFFFF
520   0x0D040400 0x22FFFFFF
  8   0x0D040400 0x22FFFFFF

Status of clock is configured by write transactions to 0x'ffff'f000'0b14,
as well as version 2, while meanings of fields are different. Modes of
optical interfaces are configured by write transactions to
0x'ffff'f000'0c94.

Drivers can register its address to receive the heatbeat transactions.
0x'ffff'f000'0b0c is for the higher part and 0x'ffff'f000'0b10 is for the
lower part. Nevertheless, this feature is not useless for this driver and
this commit ommits it.

Each data block consists of two parts in a point of the number of included
data chunks. In both of 'fixed' and 'differed' parts, the number of
included data blocks are a multiple of 4, thus depending on models there's
some empty data chunks. For example, 828mk3 includes one pair of empty
data chunks in its fixed part. When optical interface is configured to
S/PDIF, 828mk3 includes one pair of empty data chunks in its differed part.
To reduce consumption of CPU cycles with additional conditions/loops, this
commit just exposes these empty chunks to user space as PCM channels.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                 |   1 +
 sound/firewire/motu/Makefile           |   3 +-
 sound/firewire/motu/amdtp-motu.c       |  12 ++
 sound/firewire/motu/motu-protocol-v3.c | 312 +++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c             |  18 ++
 sound/firewire/motu/motu.h             |   1 +
 6 files changed, 346 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-protocol-v3.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 1053a1b..2a91fe8 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -148,6 +148,7 @@ config SND_FIREWIRE_MOTU
 	 Say Y here to enable support for FireWire devices which MOTU produced:
 	  * 828
 	  * 828mk2
+	  * 828mk3
 
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-motu.
diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index d3b9abc..c5d34df 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,4 +1,5 @@
 snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o \
 			  motu-proc.o motu-pcm.o motu-midi.o motu-hwdep.o \
-			  motu-protocol-v1.o motu-protocol-v2.o
+			  motu-protocol-v1.o motu-protocol-v2.o \
+			  motu-protocol-v3.o
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += snd-firewire-motu.o
diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 0930cd8..08bd176 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -11,6 +11,7 @@
 #include "motu.h"
 
 #define CIP_FMT_MOTU		0x02
+#define CIP_FMT_MOTU_TX_V3	0x22
 #define MOTU_FDF_AM824		0x22
 
 /*
@@ -359,6 +360,17 @@ int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 
 	if (dir == AMDTP_IN_STREAM) {
 		process_data_blocks = process_tx_data_blocks;
+
+		/*
+		 * Units of version 3 transmits packets with invalid CIP header
+		 * against IEC 61883-1.
+		 */
+		if (protocol == &snd_motu_protocol_v3) {
+			flags |= CIP_WRONG_DBS |
+				 CIP_SKIP_DBC_ZERO_CHECK |
+				 CIP_HEADER_WITHOUT_EOH;
+			fmt = CIP_FMT_MOTU_TX_V3;
+		}
 	} else {
 		process_data_blocks = process_rx_data_blocks;
 		flags |= CIP_DBC_IS_END_EVENT;
diff --git a/sound/firewire/motu/motu-protocol-v3.c b/sound/firewire/motu/motu-protocol-v3.c
new file mode 100644
index 0000000..b463da9
--- /dev/null
+++ b/sound/firewire/motu/motu-protocol-v3.c
@@ -0,0 +1,312 @@
+/*
+ * motu-protocol-v3.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <linux/delay.h>
+#include "motu.h"
+
+#define V3_CLOCK_STATUS_OFFSET		0x0b14
+#define  V3_FETCH_PCM_FRAMES		0x02000000
+#define  V3_CLOCK_RATE_MASK		0x0000ff00
+#define  V3_CLOCK_RATE_SHIFT		8
+#define  V3_CLOCK_SOURCE_MASK		0x000000ff
+#define  V3_CLOCK_SOURCE_SHIFT		8
+
+#define V3_OPT_IFACE_MODE_OFFSET	0x0c94
+#define  V3_ENABLE_OPT_IN_IFACE_A	0x00000001
+#define  V3_ENABLE_OPT_IN_IFACE_B	0x00000002
+#define  V3_ENABLE_OPT_OUT_IFACE_A	0x00000100
+#define  V3_ENABLE_OPT_OUT_IFACE_B	0x00000200
+#define  V3_NO_ADAT_OPT_IN_IFACE_A	0x00010000
+#define  V3_NO_ADAT_OPT_IN_IFACE_B	0x00100000
+#define  V3_NO_ADAT_OPT_OUT_IFACE_A	0x00040000
+#define  V3_NO_ADAT_OPT_OUT_IFACE_B	0x00400000
+
+static int v3_get_clock_rate(struct snd_motu *motu, unsigned int *rate)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V3_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	data = (data & V3_CLOCK_RATE_MASK) >> V3_CLOCK_RATE_SHIFT;
+	if (data >= ARRAY_SIZE(snd_motu_clock_rates))
+		return -EIO;
+
+	*rate = snd_motu_clock_rates[data];
+
+	return 0;
+}
+
+static int v3_set_clock_rate(struct snd_motu *motu, unsigned int rate)
+{
+	__be32 reg;
+	u32 data;
+	bool need_to_wait;
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_clock_rates); ++i) {
+		if (snd_motu_clock_rates[i] == rate)
+			break;
+	}
+	if (i == ARRAY_SIZE(snd_motu_clock_rates))
+		return -EINVAL;
+
+	err = snd_motu_transaction_read(motu, V3_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	data &= ~(V3_CLOCK_RATE_MASK | V3_FETCH_PCM_FRAMES);
+	data |= i << V3_CLOCK_RATE_SHIFT;
+
+	need_to_wait = data != be32_to_cpu(reg);
+
+	reg = cpu_to_be32(data);
+	err = snd_motu_transaction_write(motu, V3_CLOCK_STATUS_OFFSET, &reg,
+					 sizeof(reg));
+	if (err < 0)
+		return err;
+
+	if (need_to_wait) {
+		/* Cost expensive. */
+		if (msleep_interruptible(4000) > 0)
+			return -EINTR;
+	}
+
+	return 0;
+}
+
+static int v3_get_clock_source(struct snd_motu *motu,
+			       enum snd_motu_clock_source *src)
+{
+	__be32 reg;
+	u32 data;
+	unsigned int val;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V3_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	val = (data & V3_CLOCK_SOURCE_MASK) >> V3_CLOCK_SOURCE_SHIFT;
+	if (val == 0x00) {
+		*src = SND_MOTU_CLOCK_SOURCE_INTERNAL;
+	} else if (val == 0x01) {
+		*src = SND_MOTU_CLOCK_SOURCE_WORD_ON_BNC;
+	} else if (val == 0x10) {
+		*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX;
+	} else if (val == 0x18 || val == 0x19) {
+		err = snd_motu_transaction_read(motu, V3_OPT_IFACE_MODE_OFFSET,
+						&reg, sizeof(reg));
+		if (err < 0)
+			return err;
+		data = be32_to_cpu(reg);
+
+		if (val == 0x18) {
+			if (data & V3_NO_ADAT_OPT_IN_IFACE_A)
+				*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT_A;
+			else
+				*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT_A;
+		} else {
+			if (data & V3_NO_ADAT_OPT_IN_IFACE_B)
+				*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT_B;
+			else
+				*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT_B;
+		}
+	} else {
+		*src = SND_MOTU_CLOCK_SOURCE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int v3_switch_fetching_mode(struct snd_motu *motu, bool enable)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V3_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return 0;
+	data = be32_to_cpu(reg);
+
+	if (enable)
+		data |= V3_FETCH_PCM_FRAMES;
+	else
+		data &= ~V3_FETCH_PCM_FRAMES;
+
+	reg = cpu_to_be32(data);
+	return snd_motu_transaction_write(motu, V3_CLOCK_STATUS_OFFSET, &reg,
+					  sizeof(reg));
+}
+
+static void calculate_fixed_part(struct snd_motu_packet_format *formats,
+				 enum amdtp_stream_direction dir,
+				 enum snd_motu_spec_flags flags,
+				 unsigned char analog_ports)
+{
+	unsigned char pcm_chunks[3] = {0, 0, 0};
+
+	formats->msg_chunks = 2;
+
+	pcm_chunks[0] = analog_ports;
+	pcm_chunks[1] = analog_ports;
+	if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X4)
+		pcm_chunks[2] = analog_ports;
+
+	if (dir == AMDTP_IN_STREAM) {
+		if (flags & SND_MOTU_SPEC_TX_MICINST_CHUNK) {
+			pcm_chunks[0] += 2;
+			pcm_chunks[1] += 2;
+			if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X4)
+				pcm_chunks[2] += 2;
+		}
+
+		if (flags & SND_MOTU_SPEC_TX_RETURN_CHUNK) {
+			pcm_chunks[0] += 2;
+			pcm_chunks[1] += 2;
+			if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X4)
+				pcm_chunks[2] += 2;
+		}
+
+		if (flags & SND_MOTU_SPEC_TX_REVERB_CHUNK) {
+			pcm_chunks[0] += 2;
+			pcm_chunks[1] += 2;
+		}
+	} else {
+		/*
+		 * Packets to v2 units transfer main-out-1/2 and phone-out-1/2.
+		 */
+		pcm_chunks[0] += 4;
+		pcm_chunks[1] += 4;
+	}
+
+	/*
+	 * At least, packets have two data chunks for S/PDIF on coaxial
+	 * interface.
+	 */
+	pcm_chunks[0] += 2;
+	pcm_chunks[1] += 2;
+
+	/*
+	 * Fixed part consists of PCM chunks multiple of 4, with msg chunks. As
+	 * a result, this part can includes empty data chunks.
+	 */
+	formats->fixed_part_pcm_chunks[0] = round_up(2 + pcm_chunks[0], 4) - 2;
+	formats->fixed_part_pcm_chunks[1] = round_up(2 + pcm_chunks[1], 4) - 2;
+	if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X4)
+		formats->fixed_part_pcm_chunks[2] =
+					round_up(2 + pcm_chunks[2], 4) - 2;
+}
+
+static void calculate_differed_part(struct snd_motu_packet_format *formats,
+				    enum snd_motu_spec_flags flags, u32 data,
+				    u32 a_enable_mask, u32 a_no_adat_mask,
+				    u32 b_enable_mask, u32 b_no_adat_mask)
+{
+	unsigned char pcm_chunks[3] = {0, 0, 0};
+	int i;
+
+	if ((flags & SND_MOTU_SPEC_HAS_OPT_IFACE_A) && (data & a_enable_mask)) {
+		if (data & a_no_adat_mask) {
+			/*
+			 * Additional two data chunks for S/PDIF on optical
+			 * interface A. This includes empty data chunks.
+			 */
+			pcm_chunks[0] += 4;
+			pcm_chunks[1] += 4;
+		} else {
+			/*
+			 * Additional data chunks for ADAT on optical interface
+			 * A.
+			 */
+			pcm_chunks[0] += 8;
+			pcm_chunks[1] += 4;
+		}
+	}
+
+	if ((flags & SND_MOTU_SPEC_HAS_OPT_IFACE_B) && (data & b_enable_mask)) {
+		if (data & b_no_adat_mask) {
+			/*
+			 * Additional two data chunks for S/PDIF on optical
+			 * interface B. This includes empty data chunks.
+			 */
+			pcm_chunks[0] += 4;
+			pcm_chunks[1] += 4;
+		} else {
+			/*
+			 * Additional data chunks for ADAT on optical interface
+			 * B.
+			 */
+			pcm_chunks[0] += 8;
+			pcm_chunks[1] += 4;
+		}
+	}
+
+	for (i = 0; i < 3; ++i) {
+		if (pcm_chunks[i] > 0)
+			pcm_chunks[i] = round_up(pcm_chunks[i], 4);
+
+		formats->differed_part_pcm_chunks[i] = pcm_chunks[i];
+	}
+}
+
+static int v3_cache_packet_formats(struct snd_motu *motu)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V3_OPT_IFACE_MODE_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	calculate_fixed_part(&motu->tx_packet_formats, AMDTP_IN_STREAM,
+			     motu->spec->flags, motu->spec->analog_in_ports);
+	calculate_differed_part(&motu->tx_packet_formats,
+			motu->spec->flags, data,
+			V3_ENABLE_OPT_IN_IFACE_A, V3_NO_ADAT_OPT_IN_IFACE_A,
+			V3_ENABLE_OPT_IN_IFACE_B, V3_NO_ADAT_OPT_IN_IFACE_B);
+
+	calculate_fixed_part(&motu->rx_packet_formats, AMDTP_OUT_STREAM,
+			     motu->spec->flags, motu->spec->analog_out_ports);
+	calculate_differed_part(&motu->rx_packet_formats,
+			motu->spec->flags, data,
+			V3_ENABLE_OPT_OUT_IFACE_A, V3_NO_ADAT_OPT_OUT_IFACE_A,
+			V3_ENABLE_OPT_OUT_IFACE_B, V3_NO_ADAT_OPT_OUT_IFACE_B);
+
+	motu->tx_packet_formats.midi_flag_offset = 8;
+	motu->tx_packet_formats.midi_byte_offset = 7;
+	motu->tx_packet_formats.pcm_byte_offset = 10;
+
+	motu->rx_packet_formats.midi_flag_offset = 8;
+	motu->rx_packet_formats.midi_byte_offset = 7;
+	motu->rx_packet_formats.pcm_byte_offset = 10;
+
+	return 0;
+}
+
+const struct snd_motu_protocol snd_motu_protocol_v3 = {
+	.get_clock_rate		= v3_get_clock_rate,
+	.set_clock_rate		= v3_set_clock_rate,
+	.get_clock_source	= v3_get_clock_source,
+	.switch_fetching_mode	= v3_switch_fetching_mode,
+	.cache_packet_formats	= v3_cache_packet_formats,
+};
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index d8dada1..9399a03 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -211,6 +211,22 @@ static struct snd_motu_spec motu_828mk2 = {
 	.analog_out_ports = 8,
 };
 
+static struct snd_motu_spec motu_828mk3 = {
+	.name = "828mk3",
+	.protocol = &snd_motu_protocol_v3,
+	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
+		 SND_MOTU_SPEC_SUPPORT_CLOCK_X4 |
+		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
+		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
+		 SND_MOTU_SPEC_TX_REVERB_CHUNK |
+		 SND_MOTU_SPEC_HAS_OPT_IFACE_A |
+		 SND_MOTU_SPEC_HAS_OPT_IFACE_B |
+		 SND_MOTU_SPEC_HAS_MIDI,
+
+	.analog_in_ports = 8,
+	.analog_out_ports = 8,
+};
+
 #define SND_MOTU_DEV_ENTRY(model, data)			\
 {							\
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID |	\
@@ -225,6 +241,8 @@ static struct snd_motu_spec motu_828mk2 = {
 static const struct ieee1394_device_id motu_id_table[] = {
 	SND_MOTU_DEV_ENTRY(0x102802, &motu_828orig),
 	SND_MOTU_DEV_ENTRY(0x101800, &motu_828mk2),
+	SND_MOTU_DEV_ENTRY(0x106800, &motu_828mk3),	/* FireWire only. */
+	SND_MOTU_DEV_ENTRY(0x100800, &motu_828mk3),	/* Hybrid. */
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, motu_id_table);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 65585e7..d227afb 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -123,6 +123,7 @@ struct snd_motu_spec {
 
 extern const struct snd_motu_protocol snd_motu_protocol_v1;
 extern const struct snd_motu_protocol snd_motu_protocol_v2;
+extern const struct snd_motu_protocol snd_motu_protocol_v3;
 
 int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 		    enum amdtp_stream_direction dir,
-- 
2.9.3
