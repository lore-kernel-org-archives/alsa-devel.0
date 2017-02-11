From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/13] ALSA: fireface: add support for Fireface
	400
Date: Sat, 11 Feb 2017 23:25:09 +0900
Message-ID: <20170211142509.4795-14-o-takashi@sakamocchi.jp>
References: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 2024A266C89
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 15:25:18 +0100 (CET)
In-Reply-To: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
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

Fireface 400 is a second model of RME Fireface series, released in 2006.
This commit adds support for this model.

This model supports 8 analog channels, 2 S/PDIF channels and 8 ADAT
channels in both of tx/rx packet. The number of ADAT channels differs
depending on each mode of sampling transmission frequency.

$ python2 linux-firewire-utils/src/crpp < /sys/bus/firewire/devices/fw1/config_rom
               ROM header and bus information block
               -----------------------------------------------------------------
400  04107768  bus_info_length 4, crc_length 16, crc 30568 (should be 61311)
404  31333934  bus_name "1394"
408  20009002  irmc 0, cmc 0, isc 1, bmc 0, cyc_clk_acc 0, max_rec 9 (1024)
40c  000a3501  company_id 000a35     |
410  1bd0862a  device_id 011bd0862a  | EUI-64 000a35011bd0862a

               root directory
               -----------------------------------------------------------------
414  000485ec  directory_length 4, crc 34284
418  03000a35  vendor
41c  0c0083c0  node capabilities per IEEE 1394
420  8d000006  --> eui-64 leaf at 438
424  d1000001  --> unit directory at 428

               unit directory at 428
               -----------------------------------------------------------------
428  000314c4  directory_length 3, crc 5316
42c  12000a35  specifier id
430  13000002  version
434  17101800  model

               eui-64 leaf at 438
               -----------------------------------------------------------------
438  000261a8  leaf_length 2, crc 25000
43c  000a3501  company_id 000a35     |
440  1bd0862a  device_id 011bd0862a  | EUI-64 000a35011bd0862a

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                      |   1 +
 sound/firewire/fireface/Makefile            |   2 +-
 sound/firewire/fireface/ff-protocol-ff400.c | 371 ++++++++++++++++++++++++++++
 sound/firewire/fireface/ff.c                |  21 ++
 sound/firewire/fireface/ff.h                |   2 +
 5 files changed, 396 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/ff-protocol-ff400.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 806d234..fc0a70c 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -159,5 +159,6 @@ config SND_FIREFACE
 	select SND_HWDEP
 	help
 	 Say Y here to include support for RME fireface series.
+	  * Fireface 400
 
 endif # SND_FIREWIRE
diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 8d6c612..8f80728 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,3 +1,3 @@
 snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o \
-		     ff-stream.o ff-pcm.o ff-hwdep.o
+		     ff-stream.o ff-pcm.o ff-hwdep.o ff-protocol-ff400.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
new file mode 100644
index 0000000..fcec6de
--- /dev/null
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -0,0 +1,371 @@
+/*
+ * ff-protocol-ff400.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <linux/delay.h>
+#include "ff.h"
+
+#define FF400_STF		0x000080100500ull
+#define FF400_RX_PACKET_FORMAT	0x000080100504ull
+#define FF400_ISOC_COMM_START	0x000080100508ull
+#define FF400_TX_PACKET_FORMAT	0x00008010050cull
+#define FF400_ISOC_COMM_STOP	0x000080100510ull
+#define FF400_SYNC_STATUS	0x0000801c0000ull
+#define FF400_FETCH_PCM_FRAMES	0x0000801c0000ull	/* For block request. */
+#define FF400_CLOCK_CONFIG	0x0000801c0004ull
+
+#define FF400_MIDI_HIGH_ADDR	0x0000801003f4ull
+#define FF400_MIDI_RX_PORT_0	0x000080180000ull
+#define FF400_MIDI_RX_PORT_1	0x000080190000ull
+
+static int ff400_get_clock(struct snd_ff *ff, unsigned int *rate,
+			   enum snd_ff_clock_src *src)
+{
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 FF400_SYNC_STATUS, &reg, sizeof(reg), 0);
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
+static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
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
+static int ff400_switch_fetching_mode(struct snd_ff *ff, bool enable)
+{
+	__le32 *reg;
+	int i;
+
+	reg = kzalloc(sizeof(__le32) * 18, GFP_KERNEL);
+	if (reg == NULL)
+		return -ENOMEM;
+
+	if (enable) {
+		/*
+		 * Each quadlet is corresponding to data channels in a data
+		 * blocks in reverse order. Precisely, quadlets for available
+		 * data channels should be enabled. Here, I take second best
+		 * to fetch PCM frames from all of data channels regardless of
+		 * stf.
+		 */
+		for (i = 0; i < 18; ++i)
+			reg[i] = cpu_to_le32(0x00000001);
+	}
+
+	return snd_fw_transaction(ff->unit, TCODE_WRITE_BLOCK_REQUEST,
+				  FF400_FETCH_PCM_FRAMES, reg,
+				  sizeof(__le32) * 18, 0);
+}
+
+static void ff400_dump_sync_status(struct snd_ff *ff,
+				   struct snd_info_buffer *buffer)
+{
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 FF400_SYNC_STATUS, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return;
+
+	data = le32_to_cpu(reg);
+
+	snd_iprintf(buffer, "External source detection:\n");
+
+	snd_iprintf(buffer, "Word Clock:");
+	if ((data >> 24) & 0x20) {
+		if ((data >> 24) & 0x40)
+			snd_iprintf(buffer, "sync\n");
+		else
+			snd_iprintf(buffer, "lock\n");
+	} else {
+		snd_iprintf(buffer, "none\n");
+	}
+
+	snd_iprintf(buffer, "S/PDIF:");
+	if ((data >> 16) & 0x10) {
+		if ((data >> 16) & 0x04)
+			snd_iprintf(buffer, "sync\n");
+		else
+			snd_iprintf(buffer, "lock\n");
+	} else {
+		snd_iprintf(buffer, "none\n");
+	}
+
+	snd_iprintf(buffer, "ADAT:");
+	if ((data >> 8) & 0x04) {
+		if ((data >> 8) & 0x10)
+			snd_iprintf(buffer, "sync\n");
+		else
+			snd_iprintf(buffer, "lock\n");
+	} else {
+		snd_iprintf(buffer, "none\n");
+	}
+
+	snd_iprintf(buffer, "\nUsed external source:\n");
+
+	if (((data >> 22) & 0x07) == 0x07) {
+		snd_iprintf(buffer, "None\n");
+	} else {
+		switch ((data >> 22) & 0x07) {
+		case 0x00:
+			snd_iprintf(buffer, "ADAT:");
+			break;
+		case 0x03:
+			snd_iprintf(buffer, "S/PDIF:");
+			break;
+		case 0x04:
+			snd_iprintf(buffer, "Word:");
+			break;
+		case 0x07:
+			snd_iprintf(buffer, "Nothing:");
+			break;
+		case 0x01:
+		case 0x02:
+		case 0x05:
+		case 0x06:
+		default:
+			snd_iprintf(buffer, "unknown:");
+			break;
+		}
+
+		if ((data >> 25) & 0x07) {
+			switch ((data >> 25) & 0x07) {
+			case 0x01:
+				snd_iprintf(buffer, "32000\n");
+				break;
+			case 0x02:
+				snd_iprintf(buffer, "44100\n");
+				break;
+			case 0x03:
+				snd_iprintf(buffer, "48000\n");
+				break;
+			case 0x04:
+				snd_iprintf(buffer, "64000\n");
+				break;
+			case 0x05:
+				snd_iprintf(buffer, "88200\n");
+				break;
+			case 0x06:
+				snd_iprintf(buffer, "96000\n");
+				break;
+			case 0x07:
+				snd_iprintf(buffer, "128000\n");
+				break;
+			case 0x08:
+				snd_iprintf(buffer, "176400\n");
+				break;
+			case 0x09:
+				snd_iprintf(buffer, "192000\n");
+				break;
+			case 0x00:
+				snd_iprintf(buffer, "unknown\n");
+				break;
+			}
+		}
+	}
+
+	snd_iprintf(buffer, "Multiplied:");
+	snd_iprintf(buffer, "%d\n", (data & 0x3ff) * 250);
+}
+
+static void ff400_dump_clock_config(struct snd_ff *ff,
+				    struct snd_info_buffer *buffer)
+{
+	__le32 reg;
+	u32 data;
+	unsigned int rate;
+	const char *src;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_BLOCK_REQUEST,
+				 FF400_CLOCK_CONFIG, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return;
+
+	data = le32_to_cpu(reg);
+
+	snd_iprintf(buffer, "Output S/PDIF format: %s (Emphasis: %s)\n",
+		    (data & 0x20) ? "Professional" : "Consumer",
+		    (data & 0x40) ? "on" : "off");
+
+	snd_iprintf(buffer, "Optical output interface format: %s\n",
+		    ((data >> 8) & 0x01) ? "S/PDIF" : "ADAT");
+
+	snd_iprintf(buffer, "Word output single speed: %s\n",
+		    ((data >> 8) & 0x20) ? "on" : "off");
+
+	snd_iprintf(buffer, "S/PDIF input interface: %s\n",
+		    ((data >> 8) & 0x02) ? "Optical" : "Coaxial");
+
+	switch ((data >> 1) & 0x03) {
+	case 0x01:
+		rate = 32000;
+		break;
+	case 0x00:
+		rate = 44100;
+		break;
+	case 0x03:
+		rate = 48000;
+		break;
+	case 0x02:
+	default:
+		return;
+	}
+
+	if (data & 0x08)
+		rate *= 2;
+	else if (data & 0x10)
+		rate *= 4;
+
+	snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+
+	if (data & 0x01) {
+		src = "Internal";
+	} else {
+		switch ((data >> 10) & 0x07) {
+		case 0x00:
+			src = "ADAT";
+			break;
+		case 0x03:
+			src = "S/PDIF";
+			break;
+		case 0x04:
+			src = "Word";
+			break;
+		case 0x05:
+			src = "LTC";
+			break;
+		default:
+			return;
+		}
+	}
+
+	snd_iprintf(buffer, "Sync to clock source: %s\n", src);
+}
+
+struct snd_ff_protocol snd_ff_protocol_ff400 = {
+	.get_clock		= ff400_get_clock,
+	.begin_session		= ff400_begin_session,
+	.finish_session		= ff400_finish_session,
+	.switch_fetching_mode	= ff400_switch_fetching_mode,
+
+	.dump_sync_status	= ff400_dump_sync_status,
+	.dump_clock_config	= ff400_dump_clock_config,
+
+	.midi_high_addr_reg	= FF400_MIDI_HIGH_ADDR,
+	.midi_rx_port_0_reg	= FF400_MIDI_RX_PORT_0,
+	.midi_rx_port_1_reg	= FF400_MIDI_RX_PORT_1,
+};
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index f57b434..3f66fa3 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -157,7 +157,28 @@ static void snd_ff_remove(struct fw_unit *unit)
 	}
 }
 
+static struct snd_ff_spec spec_ff400 = {
+	.name = "Fireface400",
+	.pcm_capture_channels = {18, 14, 10},
+	.pcm_playback_channels = {18, 14, 10},
+	.midi_in_ports = 1,
+	.midi_out_ports = 1,
+	.protocol = &snd_ff_protocol_ff400,
+};
+
 static const struct ieee1394_device_id snd_ff_id_table[] = {
+	/* Fireface 400 */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_SPECIFIER_ID |
+				  IEEE1394_MATCH_VERSION |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_RME,
+		.specifier_id	= 0x000a35,
+		.version	= 0x000002,
+		.model_id	= 0x101800,
+		.driver_data	= (kernel_ulong_t)&spec_ff400,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(ieee1394, snd_ff_id_table);
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 16839b7..ccc0aa2 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -111,6 +111,8 @@ struct snd_ff_protocol {
 	u64 midi_rx_port_1_reg;
 };
 
+extern struct snd_ff_protocol snd_ff_protocol_ff400;
+
 int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
-- 
2.9.3
