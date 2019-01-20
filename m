From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/9] ALSA: fireface: add protocol-dependent
	operation to dump status
Date: Sun, 20 Jan 2019 17:25:48 +0900
Message-ID: <20190120082553.17347-5-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 369B22673E2
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:16 +0100 (CET)
Received: by mail-pf1-f196.google.com with SMTP id c73so8675989pfe.13
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:16 -0800 (PST)
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

This commit adds a member for a callback function to dump status and
move existing code to former protocol.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-proc.c            | 204 +-----------------
 sound/firewire/fireface/ff-protocol-former.c | 212 +++++++++++++++++++
 sound/firewire/fireface/ff.h                 |   2 +-
 3 files changed, 214 insertions(+), 204 deletions(-)

diff --git a/sound/firewire/fireface/ff-proc.c b/sound/firewire/fireface/ff-proc.c
index 37f84b7fc432..8a7cfb6ccce6 100644
--- a/sound/firewire/fireface/ff-proc.c
+++ b/sound/firewire/fireface/ff-proc.c
@@ -8,214 +8,12 @@
 
 #include "./ff.h"
 
-static void dump_clock_config(struct snd_ff *ff, struct snd_info_buffer *buffer)
-{
-	__le32 reg;
-	u32 data;
-	unsigned int rate;
-	const char *src;
-	int err;
-
-	err = snd_fw_transaction(ff->unit, TCODE_READ_BLOCK_REQUEST,
-				 SND_FF_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
-	if (err < 0)
-		return;
-
-	data = le32_to_cpu(reg);
-
-	snd_iprintf(buffer, "Output S/PDIF format: %s (Emphasis: %s)\n",
-		    (data & 0x20) ? "Professional" : "Consumer",
-		    (data & 0x40) ? "on" : "off");
-
-	snd_iprintf(buffer, "Optical output interface format: %s\n",
-		    ((data >> 8) & 0x01) ? "S/PDIF" : "ADAT");
-
-	snd_iprintf(buffer, "Word output single speed: %s\n",
-		    ((data >> 8) & 0x20) ? "on" : "off");
-
-	snd_iprintf(buffer, "S/PDIF input interface: %s\n",
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
-
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
-
-	snd_iprintf(buffer, "Sync to clock source: %s\n", src);
-}
-
-static void dump_sync_status(struct snd_ff *ff, struct snd_info_buffer *buffer)
-{
-	__le32 reg;
-	u32 data;
-	int err;
-
-	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
-				 SND_FF_REG_SYNC_STATUS, &reg, sizeof(reg), 0);
-	if (err < 0)
-		return;
-
-	data = le32_to_cpu(reg);
-
-	snd_iprintf(buffer, "External source detection:\n");
-
-	snd_iprintf(buffer, "Word Clock:");
-	if ((data >> 24) & 0x20) {
-		if ((data >> 24) & 0x40)
-			snd_iprintf(buffer, "sync\n");
-		else
-			snd_iprintf(buffer, "lock\n");
-	} else {
-		snd_iprintf(buffer, "none\n");
-	}
-
-	snd_iprintf(buffer, "S/PDIF:");
-	if ((data >> 16) & 0x10) {
-		if ((data >> 16) & 0x04)
-			snd_iprintf(buffer, "sync\n");
-		else
-			snd_iprintf(buffer, "lock\n");
-	} else {
-		snd_iprintf(buffer, "none\n");
-	}
-
-	snd_iprintf(buffer, "ADAT1:");
-	if ((data >> 8) & 0x04) {
-		if ((data >> 8) & 0x10)
-			snd_iprintf(buffer, "sync\n");
-		else
-			snd_iprintf(buffer, "lock\n");
-	} else {
-		snd_iprintf(buffer, "none\n");
-	}
-
-	snd_iprintf(buffer, "ADAT2:");
-	if ((data >> 8) & 0x08) {
-		if ((data >> 8) & 0x20)
-			snd_iprintf(buffer, "sync\n");
-		else
-			snd_iprintf(buffer, "lock\n");
-	} else {
-		snd_iprintf(buffer, "none\n");
-	}
-
-	snd_iprintf(buffer, "\nUsed external source:\n");
-
-	if (((data >> 22) & 0x07) == 0x07) {
-		snd_iprintf(buffer, "None\n");
-	} else {
-		switch ((data >> 22) & 0x07) {
-		case 0x00:
-			snd_iprintf(buffer, "ADAT1:");
-			break;
-		case 0x01:
-			snd_iprintf(buffer, "ADAT2:");
-			break;
-		case 0x03:
-			snd_iprintf(buffer, "S/PDIF:");
-			break;
-		case 0x04:
-			snd_iprintf(buffer, "Word:");
-			break;
-		case 0x07:
-			snd_iprintf(buffer, "Nothing:");
-			break;
-		case 0x02:
-		case 0x05:
-		case 0x06:
-		default:
-			snd_iprintf(buffer, "unknown:");
-			break;
-		}
-
-		if ((data >> 25) & 0x07) {
-			switch ((data >> 25) & 0x07) {
-			case 0x01:
-				snd_iprintf(buffer, "32000\n");
-				break;
-			case 0x02:
-				snd_iprintf(buffer, "44100\n");
-				break;
-			case 0x03:
-				snd_iprintf(buffer, "48000\n");
-				break;
-			case 0x04:
-				snd_iprintf(buffer, "64000\n");
-				break;
-			case 0x05:
-				snd_iprintf(buffer, "88200\n");
-				break;
-			case 0x06:
-				snd_iprintf(buffer, "96000\n");
-				break;
-			case 0x07:
-				snd_iprintf(buffer, "128000\n");
-				break;
-			case 0x08:
-				snd_iprintf(buffer, "176400\n");
-				break;
-			case 0x09:
-				snd_iprintf(buffer, "192000\n");
-				break;
-			case 0x00:
-				snd_iprintf(buffer, "unknown\n");
-				break;
-			}
-		}
-	}
-
-	snd_iprintf(buffer, "Multiplied:");
-	snd_iprintf(buffer, "%d\n", (data & 0x3ff) * 250);
-}
-
 static void proc_dump_status(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
 {
 	struct snd_ff *ff = entry->private_data;
 
-	dump_clock_config(ff, buffer);
-	dump_sync_status(ff, buffer);
+	ff->spec->protocol->dump_status(ff, buffer);
 }
 
 static void add_node(struct snd_ff *ff, struct snd_info_entry *root,
diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index ed1271a89484..5f97e7fc7281 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -9,6 +9,216 @@
 
 #include "ff.h"
 
+#define FORMER_REG_SYNC_STATUS		0x0000801c0000ull
+
+static void dump_clock_config(struct snd_ff *ff, struct snd_info_buffer *buffer)
+{
+	__le32 reg;
+	u32 data;
+	unsigned int rate;
+	const char *src;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_BLOCK_REQUEST,
+				 SND_FF_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
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
+			src = "ADAT1";
+			break;
+		case 0x01:
+			src = "ADAT2";
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
+static void dump_sync_status(struct snd_ff *ff, struct snd_info_buffer *buffer)
+{
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 FORMER_REG_SYNC_STATUS, &reg, sizeof(reg), 0);
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
+	snd_iprintf(buffer, "ADAT1:");
+	if ((data >> 8) & 0x04) {
+		if ((data >> 8) & 0x10)
+			snd_iprintf(buffer, "sync\n");
+		else
+			snd_iprintf(buffer, "lock\n");
+	} else {
+		snd_iprintf(buffer, "none\n");
+	}
+
+	snd_iprintf(buffer, "ADAT2:");
+	if ((data >> 8) & 0x08) {
+		if ((data >> 8) & 0x20)
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
+			snd_iprintf(buffer, "ADAT1:");
+			break;
+		case 0x01:
+			snd_iprintf(buffer, "ADAT2:");
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
+static void former_dump_status(struct snd_ff *ff,
+			       struct snd_info_buffer *buffer)
+{
+	dump_clock_config(ff, buffer);
+	dump_sync_status(ff, buffer);
+}
+
 #define FF800_STF		0x0000fc88f000
 #define FF800_RX_PACKET_FORMAT	0x0000fc88f004
 #define FF800_ALLOC_TX_STREAM	0x0000fc88f008
@@ -139,6 +349,7 @@ const struct snd_ff_protocol snd_ff_protocol_ff800 = {
 	.handle_midi_msg	= ff800_handle_midi_msg,
 	.begin_session		= ff800_begin_session,
 	.finish_session		= ff800_finish_session,
+	.dump_status		= former_dump_status,
 };
 
 #define FF400_STF		0x000080100500ull
@@ -286,4 +497,5 @@ const struct snd_ff_protocol snd_ff_protocol_ff400 = {
 	.handle_midi_msg	= ff400_handle_midi_msg,
 	.begin_session		= ff400_begin_session,
 	.finish_session		= ff400_finish_session,
+	.dump_status		= former_dump_status,
 };
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 7dfc7745a914..3f22b8d84e36 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -35,7 +35,6 @@
 #define SND_FF_IN_MIDI_PORTS		2
 #define SND_FF_OUT_MIDI_PORTS		2
 
-#define SND_FF_REG_SYNC_STATUS		0x0000801c0000ull
 /* For block write request. */
 #define SND_FF_REG_FETCH_PCM_FRAMES	0x0000801c0000ull
 #define SND_FF_REG_CLOCK_CONFIG		0x0000801c0004ull
@@ -111,6 +110,7 @@ struct snd_ff_protocol {
 	void (*handle_midi_msg)(struct snd_ff *ff, __le32 *buf, size_t length);
 	int (*begin_session)(struct snd_ff *ff, unsigned int rate);
 	void (*finish_session)(struct snd_ff *ff);
+	void (*dump_status)(struct snd_ff *ff, struct snd_info_buffer *buffer);
 };
 
 extern const struct snd_ff_protocol snd_ff_protocol_ff800;
-- 
2.19.1
