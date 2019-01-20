From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 9/9] ALSA: fireface: add support for Fireface
	UCX
Date: Sun, 20 Jan 2019 17:25:53 +0900
Message-ID: <20190120082553.17347-10-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A00267350
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:25 +0100 (CET)
Received: by mail-pg1-f196.google.com with SMTP id t13so8061355pgr.11
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:25 -0800 (PST)
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

Fireface UFX was shipped by RME GmbH in 2012. This model supports later
protocol for management of isochronous communication and synchronization
of sampling transmission frequency.

This commit adds support for the model. At present, it's not clear how
to encode MIDI messages and decide destination address for asynchronous
transaction, thus this commit adds support for isochronous communication
for PCM frames only.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                       |   1 +
 sound/firewire/fireface/Makefile             |   3 +-
 sound/firewire/fireface/ff-protocol-latter.c | 273 +++++++++++++++++++
 sound/firewire/fireface/ff.c                 |  41 ++-
 sound/firewire/fireface/ff.h                 |   1 +
 5 files changed, 310 insertions(+), 9 deletions(-)
 create mode 100644 sound/firewire/fireface/ff-protocol-latter.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 052e00590259..b9e96d0b3a0a 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -163,5 +163,6 @@ config SND_FIREFACE
 	 Say Y here to include support for RME fireface series.
 	  * Fireface 400
 	  * Fireface 800
+	  * Fireface UCX
 
 endif # SND_FIREWIRE
diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 62eb78962b93..d64f4e2a1096 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,3 +1,4 @@
 snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o \
-		     ff-stream.o ff-pcm.o ff-hwdep.o ff-protocol-former.o
+		     ff-stream.o ff-pcm.o ff-hwdep.o ff-protocol-former.o \
+		     ff-protocol-latter.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
new file mode 100644
index 000000000000..64767ba439db
--- /dev/null
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+// ff-protocol-latter - a part of driver for RME Fireface series
+//
+// Copyright (c) 2019 Takashi Sakamoto
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include <linux/delay.h>
+
+#include "ff.h"
+
+#define LATTER_STF		0xffff00000004
+#define LATTER_ISOC_CHANNELS	0xffff00000008
+#define LATTER_ISOC_START	0xffff0000000c
+#define LATTER_FETCH_MODE	0xffff00000010
+#define LATTER_SYNC_STATUS	0x0000801c0000
+
+static int parse_clock_bits(u32 data, unsigned int *rate,
+			    enum snd_ff_clock_src *src)
+{
+	static const struct {
+		unsigned int rate;
+		u32 flag;
+	} *rate_entry, rate_entries[] = {
+		{ 32000,	0x00000000, },
+		{ 44100,	0x01000000, },
+		{ 48000,	0x02000000, },
+		{ 64000,	0x04000000, },
+		{ 88200,	0x05000000, },
+		{ 96000,	0x06000000, },
+		{ 128000,	0x08000000, },
+		{ 176400,	0x09000000, },
+		{ 192000,	0x0a000000, },
+	};
+	static const struct {
+		enum snd_ff_clock_src src;
+		u32 flag;
+	} *clk_entry, clk_entries[] = {
+		{ SND_FF_CLOCK_SRC_SPDIF,	0x00000200, },
+		{ SND_FF_CLOCK_SRC_ADAT1,	0x00000400, },
+		{ SND_FF_CLOCK_SRC_WORD,	0x00000600, },
+		{ SND_FF_CLOCK_SRC_INTERNAL,	0x00000e00, },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rate_entries); ++i) {
+		rate_entry = rate_entries + i;
+		if ((data & 0x0f000000) == rate_entry->flag) {
+			*rate = rate_entry->rate;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(rate_entries))
+		return -EIO;
+
+	for (i = 0; i < ARRAY_SIZE(clk_entries); ++i) {
+		clk_entry = clk_entries + i;
+		if ((data & 0x000e00) == clk_entry->flag) {
+			*src = clk_entry->src;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(clk_entries))
+		return -EIO;
+
+	return 0;
+}
+
+static int latter_get_clock(struct snd_ff *ff, unsigned int *rate,
+			   enum snd_ff_clock_src *src)
+{
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 LATTER_SYNC_STATUS, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+	data = le32_to_cpu(reg);
+
+	return parse_clock_bits(data, rate, src);
+}
+
+static int latter_switch_fetching_mode(struct snd_ff *ff, bool enable)
+{
+	u32 data;
+	__le32 reg;
+
+	if (enable)
+		data = 0x00000000;
+	else
+		data = 0xffffffff;
+	reg = cpu_to_le32(data);
+
+	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  LATTER_FETCH_MODE, &reg, sizeof(reg), 0);
+}
+
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
+static int latter_begin_session(struct snd_ff *ff, unsigned int rate)
+{
+	static const struct {
+		unsigned int stf;
+		unsigned int code;
+		unsigned int flag;
+	} *entry, rate_table[] = {
+		{ 32000,  0x00, 0x92, },
+		{ 44100,  0x02, 0x92, },
+		{ 48000,  0x04, 0x92, },
+		{ 64000,  0x08, 0x8e, },
+		{ 88200,  0x0a, 0x8e, },
+		{ 96000,  0x0c, 0x8e, },
+		{ 128000, 0x10, 0x8c, },
+		{ 176400, 0x12, 0x8c, },
+		{ 192000, 0x14, 0x8c, },
+	};
+	u32 data;
+	__le32 reg;
+	unsigned int count;
+	int i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(rate_table); ++i) {
+		entry = rate_table + i;
+		if (entry->stf == rate)
+			break;
+	}
+	if (i == ARRAY_SIZE(rate_table))
+		return -EINVAL;
+
+	reg = cpu_to_le32(entry->code);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 LATTER_STF, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	// Confirm to shift transmission clock.
+	count = 0;
+	while (count++ < 10) {
+		unsigned int curr_rate;
+		enum snd_ff_clock_src src;
+
+		err = latter_get_clock(ff, &curr_rate, &src);
+		if (err < 0)
+			return err;
+
+		if (curr_rate == rate)
+			break;
+	}
+	if (count == 10)
+		return -ETIMEDOUT;
+
+	err = keep_resources(ff, rate);
+	if (err < 0)
+		return err;
+
+	data = (ff->tx_resources.channel << 8) | ff->rx_resources.channel;
+	reg = cpu_to_le32(data);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 LATTER_ISOC_CHANNELS, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	// Always use the maximum number of data channels in data block of
+	// packet.
+	reg = cpu_to_le32(entry->flag);
+	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  LATTER_ISOC_START, &reg, sizeof(reg), 0);
+}
+
+static void latter_finish_session(struct snd_ff *ff)
+{
+	__le32 reg;
+
+	reg = cpu_to_le32(0x00000000);
+	snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   LATTER_ISOC_START, &reg, sizeof(reg), 0);
+}
+
+static void latter_dump_status(struct snd_ff *ff, struct snd_info_buffer *buffer)
+{
+	static const struct {
+		char *const label;
+		u32 locked_mask;
+		u32 synced_mask;
+	} *clk_entry, clk_entries[] = {
+		{ "S/PDIF",	0x00000001, 0x00000010, },
+		{ "ADAT",	0x00000002, 0x00000020, },
+		{ "WDClk",	0x00000004, 0x00000040, },
+	};
+	__le32 reg;
+	u32 data;
+	unsigned int rate;
+	enum snd_ff_clock_src src;
+	const char *label;
+	int i;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 LATTER_SYNC_STATUS, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return;
+	data = le32_to_cpu(reg);
+
+	snd_iprintf(buffer, "External source detection:\n");
+
+	for (i = 0; i < ARRAY_SIZE(clk_entries); ++i) {
+		clk_entry = clk_entries + i;
+		snd_iprintf(buffer, "%s: ", clk_entry->label);
+		if (data & clk_entry->locked_mask) {
+			if (data & clk_entry->synced_mask)
+				snd_iprintf(buffer, "sync\n");
+			else
+				snd_iprintf(buffer, "lock\n");
+		} else {
+			snd_iprintf(buffer, "none\n");
+		}
+	}
+
+	err = parse_clock_bits(data, &rate, &src);
+	if (err < 0)
+		return;
+	label = snd_ff_proc_get_clk_label(src);
+	if (!label)
+		return;
+
+	snd_iprintf(buffer, "Referred clock: %s %d\n", label, rate);
+}
+
+const struct snd_ff_protocol snd_ff_protocol_latter = {
+	.get_clock		= latter_get_clock,
+	.switch_fetching_mode	= latter_switch_fetching_mode,
+	.begin_session		= latter_begin_session,
+	.finish_session		= latter_finish_session,
+	.dump_status		= latter_dump_status,
+};
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 36575f4159d1..fd9c980e3cf4 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -32,7 +32,8 @@ static void ff_card_free(struct snd_card *card)
 	struct snd_ff *ff = card->private_data;
 
 	snd_ff_stream_destroy_duplex(ff);
-	snd_ff_transaction_unregister(ff);
+	if (ff->spec->midi_high_addr > 0)
+		snd_ff_transaction_unregister(ff);
 }
 
 static void do_registration(struct work_struct *work)
@@ -50,9 +51,11 @@ static void do_registration(struct work_struct *work)
 	ff->card->private_free = ff_card_free;
 	ff->card->private_data = ff;
 
-	err = snd_ff_transaction_register(ff);
-	if (err < 0)
-		goto error;
+	if (ff->spec->midi_high_addr > 0) {
+		err = snd_ff_transaction_register(ff);
+		if (err < 0)
+			goto error;
+	}
 
 	name_card(ff);
 
@@ -62,9 +65,11 @@ static void do_registration(struct work_struct *work)
 
 	snd_ff_proc_init(ff);
 
-	err = snd_ff_create_midi_devices(ff);
-	if (err < 0)
-		goto error;
+	if (ff->spec->midi_in_ports > 0 || ff->spec->midi_out_ports > 0) {
+		err = snd_ff_create_midi_devices(ff);
+		if (err < 0)
+			goto error;
+	}
 
 	err = snd_ff_create_pcm_devices(ff);
 	if (err < 0)
@@ -119,7 +124,8 @@ static void snd_ff_update(struct fw_unit *unit)
 	if (!ff->registered)
 		snd_fw_schedule_registration(unit, &ff->dwork);
 
-	snd_ff_transaction_reregister(ff);
+	if (ff->spec->midi_high_addr > 0)
+		snd_ff_transaction_reregister(ff);
 
 	if (ff->registered)
 		snd_ff_stream_update_duplex(ff);
@@ -165,6 +171,13 @@ static const struct snd_ff_spec spec_ff400 = {
 	.midi_high_addr = 0x0000801003f4ull,
 };
 
+static const struct snd_ff_spec spec_ucx = {
+	.name = "FirefaceUCX",
+	.pcm_capture_channels = {18, 14, 12},
+	.pcm_playback_channels = {18, 14, 12},
+	.protocol = &snd_ff_protocol_latter,
+};
+
 static const struct ieee1394_device_id snd_ff_id_table[] = {
 	/* Fireface 800 */
 	{
@@ -190,6 +203,18 @@ static const struct ieee1394_device_id snd_ff_id_table[] = {
 		.model_id	= 0x101800,
 		.driver_data	= (kernel_ulong_t)&spec_ff400,
 	},
+	// Fireface UCX.
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_SPECIFIER_ID |
+				  IEEE1394_MATCH_VERSION |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_RME,
+		.specifier_id	= OUI_RME,
+		.version	= 0x000004,
+		.model_id	= 0x101800,
+		.driver_data	= (kernel_ulong_t)&spec_ucx,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(ieee1394, snd_ff_id_table);
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index cdb16e931c31..8aea7920b57f 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -114,6 +114,7 @@ struct snd_ff_protocol {
 
 extern const struct snd_ff_protocol snd_ff_protocol_ff800;
 extern const struct snd_ff_protocol snd_ff_protocol_ff400;
+extern const struct snd_ff_protocol snd_ff_protocol_latter;
 
 int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
-- 
2.19.1
