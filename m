From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/8] ALSA: fireface: share helper function to
	get current sampling rate and clock source
Date: Tue, 11 Dec 2018 19:17:30 +0900
Message-ID: <20181211101735.13735-4-o-takashi@sakamocchi.jp>
References: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FADD267B90
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 11:17:50 +0100 (CET)
Received: by mail-pf1-f196.google.com with SMTP id h3so6915245pfg.1
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:17:50 -0800 (PST)
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

This commit moves a parser for a register of clock configuration to
obsolete model-specific operations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-pcm.c            |  2 +-
 sound/firewire/fireface/ff-protocol-ff400.c | 60 ---------------------
 sound/firewire/fireface/ff-stream.c         |  2 +-
 sound/firewire/fireface/ff-transaction.c    | 59 ++++++++++++++++++++
 sound/firewire/fireface/ff.h                |  4 +-
 5 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index bf47f9ec8703..63b0be6f05e8 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -141,7 +141,7 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto release_lock;
 
-	err = ff->spec->protocol->get_clock(ff, &rate, &src);
+	err = snd_ff_transaction_get_clock(ff, &rate, &src);
 	if (err < 0)
 		goto release_lock;
 
diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index 31c381dcb452..d2fbb0382223 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -19,65 +19,6 @@
 #define FF400_MIDI_RX_PORT_0	0x000080180000ull
 #define FF400_MIDI_RX_PORT_1	0x000080190000ull
 
-static int ff400_get_clock(struct snd_ff *ff, unsigned int *rate,
-			   enum snd_ff_clock_src *src)
-{
-	__le32 reg;
-	u32 data;
-	int err;
-
-	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
-				 SND_FF_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
-	if (err < 0)
-		return err;
-	data = le32_to_cpu(reg);
-
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
-		/* TODO: 0x00, 0x01, 0x02, 0x06, 0x07? */
-		switch ((data >> 10) & 0x07) {
-		case 0x03:
-			*src = SND_FF_CLOCK_SRC_SPDIF;
-			break;
-		case 0x04:
-			*src = SND_FF_CLOCK_SRC_WORD;
-			break;
-		case 0x05:
-			*src = SND_FF_CLOCK_SRC_LTC;
-			break;
-		case 0x00:
-		default:
-			*src = SND_FF_CLOCK_SRC_ADAT;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
 {
 	__le32 reg;
@@ -169,7 +110,6 @@ static int ff400_switch_fetching_mode(struct snd_ff *ff, bool enable)
 }
 
 const struct snd_ff_protocol snd_ff_protocol_ff400 = {
-	.get_clock		= ff400_get_clock,
 	.begin_session		= ff400_begin_session,
 	.finish_session		= ff400_finish_session,
 	.switch_fetching_mode	= ff400_switch_fetching_mode,
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index 78880922120e..59ca2e84d41c 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -149,7 +149,7 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 	if (ff->substreams_counter == 0)
 		return 0;
 
-	err = ff->spec->protocol->get_clock(ff, &curr_rate, &src);
+	err = snd_ff_transaction_get_clock(ff, &curr_rate, &src);
 	if (err < 0)
 		return err;
 	if (curr_rate != rate ||
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 332b29f8ed75..1dad51da13e0 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -8,6 +8,65 @@
 
 #include "ff.h"
 
+int snd_ff_transaction_get_clock(struct snd_ff *ff, unsigned int *rate,
+				 enum snd_ff_clock_src *src)
+{
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 SND_FF_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
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
 static void finish_transmit_midi_msg(struct snd_ff *ff, unsigned int port,
 				     int rcode)
 {
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 6dc36a2623b3..cdb1326f65b7 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -101,8 +101,6 @@ enum snd_ff_clock_src {
 };
 
 struct snd_ff_protocol {
-	int (*get_clock)(struct snd_ff *ff, unsigned int *rate,
-			 enum snd_ff_clock_src *src);
 	int (*begin_session)(struct snd_ff *ff, unsigned int rate);
 	void (*finish_session)(struct snd_ff *ff);
 	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
@@ -114,6 +112,8 @@ struct snd_ff_protocol {
 
 extern const struct snd_ff_protocol snd_ff_protocol_ff400;
 
+int snd_ff_transaction_get_clock(struct snd_ff *ff, unsigned int *rate,
+				 enum snd_ff_clock_src *src);
 int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
-- 
2.19.1
