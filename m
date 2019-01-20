From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/9] ALSA: fireface: code refactoring for dump
	of sync status
Date: Sun, 20 Jan 2019 17:25:51 +0900
Message-ID: <20190120082553.17347-8-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 35FB9267350
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:21 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id e11so8293111plt.11
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:21 -0800 (PST)
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

This commit adds refactoring for dump of sync status by adding
tables for check bits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-former.c | 176 ++++++++-----------
 1 file changed, 75 insertions(+), 101 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index d32104ed0c08..fb2af10d2690 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -190,126 +190,100 @@ static void dump_clock_config(struct snd_ff *ff, struct snd_info_buffer *buffer)
 
 static void dump_sync_status(struct snd_ff *ff, struct snd_info_buffer *buffer)
 {
-	__le32 reg;
-	u32 data;
+	static const struct {
+		char *const label;
+		u32 locked_mask;
+		u32 synced_mask;
+	} *clk_entry, clk_entries[] = {
+		{ "WDClk",	0x40000000, 0x20000000, },
+		{ "S/PDIF",	0x00080000, 0x00040000, },
+		{ "ADAT1",	0x00000400, 0x00001000, },
+		{ "ADAT2",	0x00000800, 0x00002000, },
+	};
+	static const struct {
+		char *const label;
+		u32 mask;
+	} *referred_entry, referred_entries[] = {
+		{ "ADAT1",	0x00000000, },
+		{ "ADAT2",	0x00400000, },
+		{ "S/PDIF",	0x00c00000, },
+		{ "WDclk",	0x01000000, },
+		{ "TCO",	0x01400000, },
+	};
+	static const struct {
+		unsigned int rate;
+		u32 mask;
+	} *rate_entry, rate_entries[] = {
+		{ 32000,	0x02000000, },
+		{ 44100,	0x04000000, },
+		{ 48000,	0x06000000, },
+		{ 64000,	0x08000000, },
+		{ 88200,	0x0a000000, },
+		{ 96000,	0x0c000000, },
+		{ 128000,	0x0e000000, },
+		{ 176400,	0x10000000, },
+		{ 192000,	0x12000000, },
+	};
+	__le32 reg[2];
+	u32 data[2];
+	int i;
 	int err;
 
-	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
-				 FORMER_REG_SYNC_STATUS, &reg, sizeof(reg), 0);
+	err = snd_fw_transaction(ff->unit, TCODE_READ_BLOCK_REQUEST,
+				 FORMER_REG_SYNC_STATUS, reg, sizeof(reg), 0);
 	if (err < 0)
 		return;
-
-	data = le32_to_cpu(reg);
+	data[0] = le32_to_cpu(reg[0]);
+	data[1] = le32_to_cpu(reg[1]);
 
 	snd_iprintf(buffer, "External source detection:\n");
 
-	snd_iprintf(buffer, "Word Clock:");
-	if ((data >> 24) & 0x20) {
-		if ((data >> 24) & 0x40)
-			snd_iprintf(buffer, "sync\n");
-		else
-			snd_iprintf(buffer, "lock\n");
-	} else {
-		snd_iprintf(buffer, "none\n");
-	}
+	for (i = 0; i < ARRAY_SIZE(clk_entries); ++i) {
+		const char *state;
+
+		clk_entry = clk_entries + i;
+		if (data[0] & clk_entry->locked_mask) {
+			if (data[0] & clk_entry->synced_mask)
+				state = "sync";
+			else
+				state = "lock";
+		} else {
+			state = "none";
+		}
 
-	snd_iprintf(buffer, "S/PDIF:");
-	if ((data >> 16) & 0x10) {
-		if ((data >> 16) & 0x04)
-			snd_iprintf(buffer, "sync\n");
-		else
-			snd_iprintf(buffer, "lock\n");
-	} else {
-		snd_iprintf(buffer, "none\n");
+		snd_iprintf(buffer, "%s: %s\n", clk_entry->label, state);
 	}
 
-	snd_iprintf(buffer, "ADAT1:");
-	if ((data >> 8) & 0x04) {
-		if ((data >> 8) & 0x10)
-			snd_iprintf(buffer, "sync\n");
-		else
-			snd_iprintf(buffer, "lock\n");
-	} else {
-		snd_iprintf(buffer, "none\n");
-	}
+	snd_iprintf(buffer, "Referred clock:\n");
 
-	snd_iprintf(buffer, "ADAT2:");
-	if ((data >> 8) & 0x08) {
-		if ((data >> 8) & 0x20)
-			snd_iprintf(buffer, "sync\n");
-		else
-			snd_iprintf(buffer, "lock\n");
+	if (data[1] & 0x00000001) {
+		snd_iprintf(buffer, "Internal\n");
 	} else {
-		snd_iprintf(buffer, "none\n");
-	}
+		unsigned int rate;
+		const char *label;
 
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
+		for (i = 0; i < ARRAY_SIZE(referred_entries); ++i) {
+			referred_entry = referred_entries + i;
+			if ((data[0] & 0x1e0000) == referred_entry->mask) {
+				label = referred_entry->label;
+				break;
+			}
 		}
+		if (i == ARRAY_SIZE(referred_entries))
+			label = "none";
 
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
+		for (i = 0; i < ARRAY_SIZE(rate_entries); ++i) {
+			rate_entry = rate_entries + i;
+			if ((data[0] & 0x1e000000) == rate_entry->mask) {
+				rate = rate_entry->rate;
 				break;
 			}
 		}
-	}
+		if (i == ARRAY_SIZE(rate_entries))
+			rate = 0;
 
-	snd_iprintf(buffer, "Multiplied:");
-	snd_iprintf(buffer, "%d\n", (data & 0x3ff) * 250);
+		snd_iprintf(buffer, "%s %d\n", label, rate);
+	}
 }
 
 static void former_dump_status(struct snd_ff *ff,
-- 
2.19.1
