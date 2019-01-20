From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/9] ALSA: fireface: code refactoring to parse
	of clock configuration
Date: Sun, 20 Jan 2019 17:25:52 +0900
Message-ID: <20190120082553.17347-9-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E24826742B
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:23 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id y126so8702400pfb.4
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:23 -0800 (PST)
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

A procedure to retrieve clock configuration is used by two callers.
Each of caller has duplicated code to parse bits.

This commit adds refactoring to remove the duplicated code.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-proc.c            |  17 ++
 sound/firewire/fireface/ff-protocol-former.c | 172 ++++++++-----------
 sound/firewire/fireface/ff.h                 |   1 +
 3 files changed, 89 insertions(+), 101 deletions(-)

diff --git a/sound/firewire/fireface/ff-proc.c b/sound/firewire/fireface/ff-proc.c
index 8a7cfb6ccce6..a55e68ec1832 100644
--- a/sound/firewire/fireface/ff-proc.c
+++ b/sound/firewire/fireface/ff-proc.c
@@ -8,6 +8,23 @@
 
 #include "./ff.h"
 
+const char *snd_ff_proc_get_clk_label(enum snd_ff_clock_src src)
+{
+	static const char *const labels[] = {
+		"Internal",
+		"S/PDIF",
+		"ADAT1",
+		"ADAT2",
+		"Word",
+		"LTC",
+	};
+
+	if (src >= ARRAY_SIZE(labels))
+		return NULL;
+
+	return labels[src];
+}
+
 static void proc_dump_status(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
 {
diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index fb2af10d2690..9c0ae50e88d1 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -14,6 +14,62 @@
 #define FORMER_REG_FETCH_PCM_FRAMES	0x0000801c0000ull
 #define FORMER_REG_CLOCK_CONFIG		0x0000801c0004ull
 
+static int parse_clock_bits(u32 data, unsigned int *rate,
+			    enum snd_ff_clock_src *src)
+{
+	static const struct {
+		unsigned int rate;
+		u32 mask;
+	} *rate_entry, rate_entries[] = {
+		{  32000, 0x00000002, },
+		{  44100, 0x00000000, },
+		{  48000, 0x00000006, },
+		{  64000, 0x0000000a, },
+		{  88200, 0x00000008, },
+		{  96000, 0x0000000e, },
+		{ 128000, 0x00000012, },
+		{ 176400, 0x00000010, },
+		{ 192000, 0x00000016, },
+	};
+	static const struct {
+		enum snd_ff_clock_src src;
+		u32 mask;
+	} *clk_entry, clk_entries[] = {
+		{ SND_FF_CLOCK_SRC_ADAT1,	0x00000000, },
+		{ SND_FF_CLOCK_SRC_ADAT2,	0x00000400, },
+		{ SND_FF_CLOCK_SRC_SPDIF,	0x00000c00, },
+		{ SND_FF_CLOCK_SRC_WORD,	0x00001000, },
+		{ SND_FF_CLOCK_SRC_LTC,		0x00001800, },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rate_entries); ++i) {
+		rate_entry = rate_entries + i;
+		if ((data & 0x0000001e) == rate_entry->mask) {
+			*rate = rate_entry->rate;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(rate_entries))
+		return -EIO;
+
+	if (data & 0x00000001) {
+		*src = SND_FF_CLOCK_SRC_INTERNAL;
+	} else {
+		for (i = 0; i < ARRAY_SIZE(clk_entries); ++i) {
+			clk_entry = clk_entries + i;
+			if ((data & 0x00001c00) == clk_entry->mask) {
+				*src = clk_entry->src;
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(clk_entries))
+			return -EIO;
+	}
+
+	return 0;
+}
+
 static int former_get_clock(struct snd_ff *ff, unsigned int *rate,
 			    enum snd_ff_clock_src *src)
 {
@@ -27,54 +83,7 @@ static int former_get_clock(struct snd_ff *ff, unsigned int *rate,
 		return err;
 	data = le32_to_cpu(reg);
 
-	/* Calculate sampling rate. */
-	switch ((data >> 1) & 0x03) {
-	case 0x01:
-		*rate = 32000;
-		break;
-	case 0x00:
-		*rate = 44100;
-		break;
-	case 0x03:
-		*rate = 48000;
-		break;
-	case 0x02:
-	default:
-		return -EIO;
-	}
-
-	if (data & 0x08)
-		*rate *= 2;
-	else if (data & 0x10)
-		*rate *= 4;
-
-	/* Calculate source of clock. */
-	if (data & 0x01) {
-		*src = SND_FF_CLOCK_SRC_INTERNAL;
-	} else {
-		/* TODO: 0x02, 0x06, 0x07? */
-		switch ((data >> 10) & 0x07) {
-		case 0x00:
-			*src = SND_FF_CLOCK_SRC_ADAT1;
-			break;
-		case 0x01:
-			*src = SND_FF_CLOCK_SRC_ADAT2;
-			break;
-		case 0x03:
-			*src = SND_FF_CLOCK_SRC_SPDIF;
-			break;
-		case 0x04:
-			*src = SND_FF_CLOCK_SRC_WORD;
-			break;
-		case 0x05:
-			*src = SND_FF_CLOCK_SRC_LTC;
-			break;
-		default:
-			return -EIO;
-		}
-	}
-
-	return 0;
+	return parse_clock_bits(data, rate, src);
 }
 
 static int former_switch_fetching_mode(struct snd_ff *ff, bool enable)
@@ -116,76 +125,37 @@ static void dump_clock_config(struct snd_ff *ff, struct snd_info_buffer *buffer)
 	__le32 reg;
 	u32 data;
 	unsigned int rate;
-	const char *src;
+	enum snd_ff_clock_src src;
+	const char *label;
 	int err;
 
 	err = snd_fw_transaction(ff->unit, TCODE_READ_BLOCK_REQUEST,
 				 FORMER_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
 	if (err < 0)
 		return;
-
 	data = le32_to_cpu(reg);
 
 	snd_iprintf(buffer, "Output S/PDIF format: %s (Emphasis: %s)\n",
-		    (data & 0x20) ? "Professional" : "Consumer",
-		    (data & 0x40) ? "on" : "off");
+		    (data & 0x00000020) ? "Professional" : "Consumer",
+		    (data & 0x00000040) ? "on" : "off");
 
 	snd_iprintf(buffer, "Optical output interface format: %s\n",
-		    ((data >> 8) & 0x01) ? "S/PDIF" : "ADAT");
+		    (data & 0x00000100) ? "S/PDIF" : "ADAT");
 
 	snd_iprintf(buffer, "Word output single speed: %s\n",
-		    ((data >> 8) & 0x20) ? "on" : "off");
+		    (data & 0x00002000) ? "on" : "off");
 
 	snd_iprintf(buffer, "S/PDIF input interface: %s\n",
-		    ((data >> 8) & 0x02) ? "Optical" : "Coaxial");
-
-	switch ((data >> 1) & 0x03) {
-	case 0x01:
-		rate = 32000;
-		break;
-	case 0x00:
-		rate = 44100;
-		break;
-	case 0x03:
-		rate = 48000;
-		break;
-	case 0x02:
-	default:
-		return;
-	}
-
-	if (data & 0x08)
-		rate *= 2;
-	else if (data & 0x10)
-		rate *= 4;
-
-	snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+		    (data & 0x00000200) ? "Optical" : "Coaxial");
 
-	if (data & 0x01) {
-		src = "Internal";
-	} else {
-		switch ((data >> 10) & 0x07) {
-		case 0x00:
-			src = "ADAT1";
-			break;
-		case 0x01:
-			src = "ADAT2";
-			break;
-		case 0x03:
-			src = "S/PDIF";
-			break;
-		case 0x04:
-			src = "Word";
-			break;
-		case 0x05:
-			src = "LTC";
-			break;
-		default:
-			return;
-		}
-	}
+	err = parse_clock_bits(data, &rate, &src);
+	if (err < 0)
+		return;
+	label = snd_ff_proc_get_clk_label(src);
+	if (!label)
+		return;
 
-	snd_iprintf(buffer, "Sync to clock source: %s\n", src);
+	snd_iprintf(buffer, "Clock configuration: %d %s\n", rate, label);
 }
 
 static void dump_sync_status(struct snd_ff *ff, struct snd_info_buffer *buffer)
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 1de2f5ec26fd..cdb16e931c31 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -139,6 +139,7 @@ int snd_ff_stream_lock_try(struct snd_ff *ff);
 void snd_ff_stream_lock_release(struct snd_ff *ff);
 
 void snd_ff_proc_init(struct snd_ff *ff);
+const char *snd_ff_proc_get_clk_label(enum snd_ff_clock_src src);
 
 int snd_ff_create_midi_devices(struct snd_ff *ff);
 
-- 
2.19.1
