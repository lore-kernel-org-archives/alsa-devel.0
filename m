From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/19] firewire-motu: add support for MOTU
	828mk2 as a model with protocol version 2
Date: Sun, 29 Jan 2017 12:54:15 +0900
Message-ID: <20170129035417.2095-18-o-takashi@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C498C266A54
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

MOTU 828mk2 is one of second generation in MOTU FireWire series, produced in
2003. This model consists of four chips:
 * TI TSB41AB2 (Physical layer for IEEE 1394 bus)
 * PDI 1394L40BE (Link layer for IEEE 1394 bus and packet processing layer)
 * ALTERA ACEX 1K EP1K30 Series FPGA (Data block processing layer)
 * TI TMS320VC5402 (Digital signal processing)

This commit adds a support for this model, with its unique protocol as
version 2. The feature of this protocol are:

 * Support data chunks for status and control messages for both
   directions.
 * Support a pair of MIDI input/output.
 * Support a data chunk for mic/instrument independent of analog line in.
 * Support a data chunk for return capture.
 * Support independent data chunks for S/PDIF of both optical/coaxial
   interfaces.
 * Support independent data chunks for each of main out and phone out.

Status of clock is configured by write transactions to 0x'ffff'f000'0b14.
Modes of optical interfaces are configured by write transactions to
0x'ffff'f000'0c04.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                 |   1 +
 sound/firewire/motu/Makefile           |   2 +-
 sound/firewire/motu/motu-protocol-v2.c | 237 +++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c             |  14 ++
 sound/firewire/motu/motu.h             |   1 +
 5 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-protocol-v2.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index a031b9c..1053a1b 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -147,6 +147,7 @@ config SND_FIREWIRE_MOTU
 	help
 	 Say Y here to enable support for FireWire devices which MOTU produced:
 	  * 828
+	  * 828mk2
 
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-motu.
diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index 15090be..d3b9abc 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,4 +1,4 @@
 snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o \
 			  motu-proc.o motu-pcm.o motu-midi.o motu-hwdep.o \
-			  motu-protocol-v1.o
+			  motu-protocol-v1.o motu-protocol-v2.o
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
new file mode 100644
index 0000000..05b5d287
--- /dev/null
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -0,0 +1,237 @@
+/*
+ * motu-protocol-v2.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "motu.h"
+
+#define V2_CLOCK_STATUS_OFFSET			0x0b14
+#define  V2_CLOCK_RATE_MASK			0x00000038
+#define  V2_CLOCK_RATE_SHIFT			3
+#define  V2_CLOCK_SRC_MASK			0x00000007
+#define  V2_CLOCK_SRC_SHIFT			0
+
+#define V2_IN_OUT_CONF_OFFSET			0x0c04
+#define  V2_OPT_OUT_IFACE_MASK			0x00000c00
+#define  V2_OPT_OUT_IFACE_SHIFT			10
+#define  V2_OPT_IN_IFACE_MASK			0x00000300
+#define  V2_OPT_IN_IFACE_SHIFT			8
+#define  V2_OPT_IFACE_MODE_NONE			0
+#define  V2_OPT_IFACE_MODE_ADAT			1
+#define  V2_OPT_IFACE_MODE_SPDIF		2
+
+static int v2_get_clock_rate(struct snd_motu *motu, unsigned int *rate)
+{
+	__be32 reg;
+	unsigned int index;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V2_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+
+	index = (be32_to_cpu(reg) & V2_CLOCK_RATE_MASK) >> V2_CLOCK_RATE_SHIFT;
+	if (index >= ARRAY_SIZE(snd_motu_clock_rates))
+		return -EIO;
+
+	*rate = snd_motu_clock_rates[index];
+
+	return 0;
+}
+
+static int v2_set_clock_rate(struct snd_motu *motu, unsigned int rate)
+{
+	__be32 reg;
+	u32 data;
+	int i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_clock_rates); ++i) {
+		if (snd_motu_clock_rates[i] == rate)
+			break;
+	}
+	if (i == ARRAY_SIZE(snd_motu_clock_rates))
+		return -EINVAL;
+
+	err = snd_motu_transaction_read(motu, V2_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	data &= ~V2_CLOCK_RATE_MASK;
+	data |= i << V2_CLOCK_RATE_SHIFT;
+
+	reg = cpu_to_be32(data);
+	return snd_motu_transaction_write(motu, V2_CLOCK_STATUS_OFFSET, &reg,
+					  sizeof(reg));
+}
+
+static int v2_get_clock_source(struct snd_motu *motu,
+			       enum snd_motu_clock_source *src)
+{
+	__be32 reg;
+	unsigned int index;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V2_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+
+	index = be32_to_cpu(reg) & V2_CLOCK_SRC_MASK;
+	if (index > 5)
+		return -EIO;
+
+	/* To check the configuration of optical interface. */
+	err = snd_motu_transaction_read(motu, V2_IN_OUT_CONF_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+
+	switch (index) {
+	case 0:
+		*src = SND_MOTU_CLOCK_SOURCE_INTERNAL;
+		break;
+	case 1:
+		if (be32_to_cpu(reg) & 0x00000200)
+			*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT;
+		else
+			*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT;
+		break;
+	case 2:
+		*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX;
+		break;
+	case 4:
+		*src = SND_MOTU_CLOCK_SOURCE_WORD_ON_BNC;
+		break;
+	case 5:
+		*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_DSUB;
+		break;
+	default:
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int v2_switch_fetching_mode(struct snd_motu *motu, bool enable)
+{
+	/* V2 protocol doesn't have this feature. */
+	return 0;
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
+		}
+		if (flags & SND_MOTU_SPEC_TX_RETURN_CHUNK) {
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
+	 * All of v2 models have a pair of coaxial interfaces for digital in/out
+	 * port. At 44.1/48.0/88.2/96.0 kHz, packets includes PCM from these
+	 * ports.
+	 */
+	pcm_chunks[0] += 2;
+	pcm_chunks[1] += 2;
+
+	/* This part should be multiples of 4. */
+	formats->fixed_part_pcm_chunks[0] = round_up(2 + pcm_chunks[0], 4) - 2;
+	formats->fixed_part_pcm_chunks[1] = round_up(2 + pcm_chunks[1], 4) - 2;
+	if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X4)
+		formats->fixed_part_pcm_chunks[2] =
+					round_up(2 + pcm_chunks[2], 4) - 2;
+}
+
+static void calculate_differed_part(struct snd_motu_packet_format *formats,
+				    enum snd_motu_spec_flags flags,
+				    u32 data, u32 mask, u32 shift)
+{
+	unsigned char pcm_chunks[3] = {0, 0};
+
+	/*
+	 * When optical interfaces are configured for S/PDIF (TOSLINK),
+	 * the above PCM frames come from them, instead of coaxial
+	 * interfaces.
+	 */
+	data = (data & mask) >> shift;
+	if ((flags & SND_MOTU_SPEC_HAS_OPT_IFACE_A) &&
+	    data == V2_OPT_IFACE_MODE_ADAT) {
+		pcm_chunks[0] += 8;
+		pcm_chunks[1] += 4;
+	}
+
+	/* At mode x4, no data chunks are supported in this part. */
+	formats->differed_part_pcm_chunks[0] = pcm_chunks[0];
+	formats->differed_part_pcm_chunks[1] = pcm_chunks[1];
+}
+
+static int v2_cache_packet_formats(struct snd_motu *motu)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = snd_motu_transaction_read(motu, V2_IN_OUT_CONF_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	calculate_fixed_part(&motu->tx_packet_formats, AMDTP_IN_STREAM,
+			     motu->spec->flags, motu->spec->analog_in_ports);
+	calculate_differed_part(&motu->tx_packet_formats, motu->spec->flags,
+			data, V2_OPT_IN_IFACE_MASK, V2_OPT_IN_IFACE_SHIFT);
+
+	calculate_fixed_part(&motu->rx_packet_formats, AMDTP_OUT_STREAM,
+			     motu->spec->flags, motu->spec->analog_out_ports);
+	calculate_differed_part(&motu->rx_packet_formats, motu->spec->flags,
+			data, V2_OPT_OUT_IFACE_MASK, V2_OPT_OUT_IFACE_SHIFT);
+
+	motu->tx_packet_formats.midi_flag_offset = 4;
+	motu->tx_packet_formats.midi_byte_offset = 6;
+	motu->tx_packet_formats.pcm_byte_offset = 10;
+
+	motu->rx_packet_formats.midi_flag_offset = 4;
+	motu->rx_packet_formats.midi_byte_offset = 6;
+	motu->rx_packet_formats.pcm_byte_offset = 10;
+
+	return 0;
+}
+
+const struct snd_motu_protocol snd_motu_protocol_v2 = {
+	.get_clock_rate		= v2_get_clock_rate,
+	.set_clock_rate		= v2_set_clock_rate,
+	.get_clock_source	= v2_get_clock_source,
+	.switch_fetching_mode	= v2_switch_fetching_mode,
+	.cache_packet_formats	= v2_cache_packet_formats,
+};
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index e9705e3..d8dada1 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -198,6 +198,19 @@ static struct snd_motu_spec motu_828orig = {
 	.analog_out_ports = 8,
 };
 
+static struct snd_motu_spec motu_828mk2 = {
+	.name = "828mk2",
+	.protocol = &snd_motu_protocol_v2,
+	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
+		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
+		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
+		 SND_MOTU_SPEC_HAS_OPT_IFACE_A |
+		 SND_MOTU_SPEC_HAS_MIDI,
+
+	.analog_in_ports = 8,
+	.analog_out_ports = 8,
+};
+
 #define SND_MOTU_DEV_ENTRY(model, data)			\
 {							\
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID |	\
@@ -211,6 +224,7 @@ static struct snd_motu_spec motu_828orig = {
 
 static const struct ieee1394_device_id motu_id_table[] = {
 	SND_MOTU_DEV_ENTRY(0x102802, &motu_828orig),
+	SND_MOTU_DEV_ENTRY(0x101800, &motu_828mk2),
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, motu_id_table);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index d091f68..65585e7 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -122,6 +122,7 @@ struct snd_motu_spec {
 };
 
 extern const struct snd_motu_protocol snd_motu_protocol_v1;
+extern const struct snd_motu_protocol snd_motu_protocol_v2;
 
 int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 		    enum amdtp_stream_direction dir,
-- 
2.9.3
