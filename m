From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/8] ALSA: fireface: share status and
	configuration dump
Date: Tue, 11 Dec 2018 19:17:29 +0900
Message-ID: <20181211101735.13735-3-o-takashi@sakamocchi.jp>
References: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A96F267B8F
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 11:17:48 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id 80so6436801pge.4
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:17:48 -0800 (PST)
In-Reply-To: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
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

As long as investigating packet dumps from Fireface 400/800, bits on
status registers for clock synchronization are the same.

This commit moves a parser for the registers to obsolete model-specific
operations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-proc.c           | 178 +++++++++++++++++-
 sound/firewire/fireface/ff-protocol-ff400.c | 191 --------------------
 sound/firewire/fireface/ff.h                |   5 -
 3 files changed, 176 insertions(+), 198 deletions(-)

diff --git a/sound/firewire/fireface/ff-proc.c b/sound/firewire/fireface/ff-proc.c
index 40ccbfd8ef89..f5f3a1997a9e 100644
--- a/sound/firewire/fireface/ff-proc.c
+++ b/sound/firewire/fireface/ff-proc.c
@@ -12,16 +12,190 @@ static void proc_dump_clock_config(struct snd_info_entry *entry,
 				   struct snd_info_buffer *buffer)
 {
 	struct snd_ff *ff = entry->private_data;
+	__le32 reg;
+	u32 data;
+	unsigned int rate;
+	const char *src;
+	int err;
 
-	ff->spec->protocol->dump_clock_config(ff, buffer);
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
 }
 
 static void proc_dump_sync_status(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct snd_ff *ff = entry->private_data;
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 SND_FF_REG_SYNC_STATUS, &reg, sizeof(reg), 0);
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
 
-	ff->spec->protocol->dump_sync_status(ff, buffer);
+	snd_iprintf(buffer, "Multiplied:");
+	snd_iprintf(buffer, "%d\n", (data & 0x3ff) * 250);
 }
 
 static void add_node(struct snd_ff *ff, struct snd_info_entry *root,
diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index 20e0c0ec3a58..31c381dcb452 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -168,203 +168,12 @@ static int ff400_switch_fetching_mode(struct snd_ff *ff, bool enable)
 	return err;
 }
 
-static void ff400_dump_sync_status(struct snd_ff *ff,
-				   struct snd_info_buffer *buffer)
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
-	snd_iprintf(buffer, "ADAT:");
-	if ((data >> 8) & 0x04) {
-		if ((data >> 8) & 0x10)
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
-			snd_iprintf(buffer, "ADAT:");
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
-		case 0x01:
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
-static void ff400_dump_clock_config(struct snd_ff *ff,
-				    struct snd_info_buffer *buffer)
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
-			src = "ADAT";
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
 const struct snd_ff_protocol snd_ff_protocol_ff400 = {
 	.get_clock		= ff400_get_clock,
 	.begin_session		= ff400_begin_session,
 	.finish_session		= ff400_finish_session,
 	.switch_fetching_mode	= ff400_switch_fetching_mode,
 
-	.dump_sync_status	= ff400_dump_sync_status,
-	.dump_clock_config	= ff400_dump_clock_config,
-
 	.midi_high_addr_reg	= FF400_MIDI_HIGH_ADDR,
 	.midi_rx_port_0_reg	= FF400_MIDI_RX_PORT_0,
 	.midi_rx_port_1_reg	= FF400_MIDI_RX_PORT_1,
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 9122fb6ed8fd..6dc36a2623b3 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -107,11 +107,6 @@ struct snd_ff_protocol {
 	void (*finish_session)(struct snd_ff *ff);
 	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
 
-	void (*dump_sync_status)(struct snd_ff *ff,
-				 struct snd_info_buffer *buffer);
-	void (*dump_clock_config)(struct snd_ff *ff,
-				  struct snd_info_buffer *buffer);
-
 	u64 midi_high_addr_reg;
 	u64 midi_rx_port_0_reg;
 	u64 midi_rx_port_1_reg;
-- 
2.19.1
