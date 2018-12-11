From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/8] ALSA: fireface: add support for second
	optical interface for ADAT stream
Date: Tue, 11 Dec 2018 19:17:31 +0900
Message-ID: <20181211101735.13735-5-o-takashi@sakamocchi.jp>
References: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id CD2F5267ACE
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 11:17:51 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id 17so6438267pgg.1
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:17:51 -0800 (PST)
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

Unlike Fireface 400, Fireface 800 have two pair of optical interface
for ADAT signal and S/PDIF signal. ADAT signals for the interface
are handled for sampling clock source separately.

This commit modifies a parser for clock configuration to distinguish
these two ADAT signals.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-proc.c        | 23 +++++++++++++++++++----
 sound/firewire/fireface/ff-transaction.c | 12 ++++++++----
 sound/firewire/fireface/ff.h             |  5 +++--
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/fireface/ff-proc.c b/sound/firewire/fireface/ff-proc.c
index f5f3a1997a9e..a0c550dabe9a 100644
--- a/sound/firewire/fireface/ff-proc.c
+++ b/sound/firewire/fireface/ff-proc.c
@@ -65,7 +65,10 @@ static void proc_dump_clock_config(struct snd_info_entry *entry,
 	} else {
 		switch ((data >> 10) & 0x07) {
 		case 0x00:
-			src = "ADAT";
+			src = "ADAT1";
+			break;
+		case 0x01:
+			src = "ADAT2";
 			break;
 		case 0x03:
 			src = "S/PDIF";
@@ -121,7 +124,7 @@ static void proc_dump_sync_status(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "none\n");
 	}
 
-	snd_iprintf(buffer, "ADAT:");
+	snd_iprintf(buffer, "ADAT1:");
 	if ((data >> 8) & 0x04) {
 		if ((data >> 8) & 0x10)
 			snd_iprintf(buffer, "sync\n");
@@ -131,6 +134,16 @@ static void proc_dump_sync_status(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "none\n");
 	}
 
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
 	snd_iprintf(buffer, "\nUsed external source:\n");
 
 	if (((data >> 22) & 0x07) == 0x07) {
@@ -138,7 +151,10 @@ static void proc_dump_sync_status(struct snd_info_entry *entry,
 	} else {
 		switch ((data >> 22) & 0x07) {
 		case 0x00:
-			snd_iprintf(buffer, "ADAT:");
+			snd_iprintf(buffer, "ADAT1:");
+			break;
+		case 0x01:
+			snd_iprintf(buffer, "ADAT2:");
 			break;
 		case 0x03:
 			snd_iprintf(buffer, "S/PDIF:");
@@ -149,7 +165,6 @@ static void proc_dump_sync_status(struct snd_info_entry *entry,
 		case 0x07:
 			snd_iprintf(buffer, "Nothing:");
 			break;
-		case 0x01:
 		case 0x02:
 		case 0x05:
 		case 0x06:
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 1dad51da13e0..751662b62389 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -46,8 +46,14 @@ int snd_ff_transaction_get_clock(struct snd_ff *ff, unsigned int *rate,
 	if (data & 0x01) {
 		*src = SND_FF_CLOCK_SRC_INTERNAL;
 	} else {
-		/* TODO: 0x00, 0x01, 0x02, 0x06, 0x07? */
+		/* TODO: 0x02, 0x06, 0x07? */
 		switch ((data >> 10) & 0x07) {
+		case 0x00:
+			*src = SND_FF_CLOCK_SRC_ADAT1;
+			break;
+		case 0x01:
+			*src = SND_FF_CLOCK_SRC_ADAT2;
+			break;
 		case 0x03:
 			*src = SND_FF_CLOCK_SRC_SPDIF;
 			break;
@@ -57,10 +63,8 @@ int snd_ff_transaction_get_clock(struct snd_ff *ff, unsigned int *rate,
 		case 0x05:
 			*src = SND_FF_CLOCK_SRC_LTC;
 			break;
-		case 0x00:
 		default:
-			*src = SND_FF_CLOCK_SRC_ADAT;
-			break;
+			return -EIO;
 		}
 	}
 
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index cdb1326f65b7..95cf90b4b533 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -94,10 +94,11 @@ struct snd_ff {
 enum snd_ff_clock_src {
 	SND_FF_CLOCK_SRC_INTERNAL,
 	SND_FF_CLOCK_SRC_SPDIF,
-	SND_FF_CLOCK_SRC_ADAT,
+	SND_FF_CLOCK_SRC_ADAT1,
+	SND_FF_CLOCK_SRC_ADAT2,
 	SND_FF_CLOCK_SRC_WORD,
 	SND_FF_CLOCK_SRC_LTC,
-	/* TODO: perhaps ADAT2 and TCO exists. */
+	/* TODO: perhaps TCO exists. */
 };
 
 struct snd_ff_protocol {
-- 
2.19.1
