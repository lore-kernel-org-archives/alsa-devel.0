From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/9] ALSA: fireface: add protocol-dependent
	operation to get clock status
Date: Sun, 20 Jan 2019 17:25:50 +0900
Message-ID: <20190120082553.17347-7-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 53341267419
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:20 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id a14so8289199plm.12
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:19 -0800 (PST)
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

This commit adds a member for a callback function to get clock status
to former protocol.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-pcm.c             |  2 +-
 sound/firewire/fireface/ff-protocol-former.c | 68 +++++++++++++++++++-
 sound/firewire/fireface/ff-stream.c          |  2 +-
 sound/firewire/fireface/ff-transaction.c     | 63 ------------------
 sound/firewire/fireface/ff.h                 |  6 +-
 5 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index d0bc96b20a65..5adf04b95c04 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -152,7 +152,7 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto release_lock;
 
-	err = snd_ff_transaction_get_clock(ff, &rate, &src);
+	err = ff->spec->protocol->get_clock(ff, &rate, &src);
 	if (err < 0)
 		goto release_lock;
 
diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index 279bd032acf0..d32104ed0c08 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -12,6 +12,70 @@
 #define FORMER_REG_SYNC_STATUS		0x0000801c0000ull
 /* For block write request. */
 #define FORMER_REG_FETCH_PCM_FRAMES	0x0000801c0000ull
+#define FORMER_REG_CLOCK_CONFIG		0x0000801c0004ull
+
+static int former_get_clock(struct snd_ff *ff, unsigned int *rate,
+			    enum snd_ff_clock_src *src)
+{
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 FORMER_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
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
+		/* TODO: 0x02, 0x06, 0x07? */
+		switch ((data >> 10) & 0x07) {
+		case 0x00:
+			*src = SND_FF_CLOCK_SRC_ADAT1;
+			break;
+		case 0x01:
+			*src = SND_FF_CLOCK_SRC_ADAT2;
+			break;
+		case 0x03:
+			*src = SND_FF_CLOCK_SRC_SPDIF;
+			break;
+		case 0x04:
+			*src = SND_FF_CLOCK_SRC_WORD;
+			break;
+		case 0x05:
+			*src = SND_FF_CLOCK_SRC_LTC;
+			break;
+		default:
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
 
 static int former_switch_fetching_mode(struct snd_ff *ff, bool enable)
 {
@@ -56,7 +120,7 @@ static void dump_clock_config(struct snd_ff *ff, struct snd_info_buffer *buffer)
 	int err;
 
 	err = snd_fw_transaction(ff->unit, TCODE_READ_BLOCK_REQUEST,
-				 SND_FF_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
+				 FORMER_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
 	if (err < 0)
 		return;
 
@@ -383,6 +447,7 @@ static void ff800_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
 
 const struct snd_ff_protocol snd_ff_protocol_ff800 = {
 	.handle_midi_msg	= ff800_handle_midi_msg,
+	.get_clock		= former_get_clock,
 	.switch_fetching_mode	= former_switch_fetching_mode,
 	.begin_session		= ff800_begin_session,
 	.finish_session		= ff800_finish_session,
@@ -532,6 +597,7 @@ static void ff400_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
 
 const struct snd_ff_protocol snd_ff_protocol_ff400 = {
 	.handle_midi_msg	= ff400_handle_midi_msg,
+	.get_clock		= former_get_clock,
 	.switch_fetching_mode	= former_switch_fetching_mode,
 	.begin_session		= ff400_begin_session,
 	.finish_session		= ff400_finish_session,
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index 43e1e2679798..a8a90f1ae09e 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -113,7 +113,7 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 	if (ff->substreams_counter == 0)
 		return 0;
 
-	err = snd_ff_transaction_get_clock(ff, &curr_rate, &src);
+	err = ff->spec->protocol->get_clock(ff, &curr_rate, &src);
 	if (err < 0)
 		return err;
 	if (curr_rate != rate ||
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 5f4ddfd55403..065e045d3fb5 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -11,69 +11,6 @@
 #define SND_FF_REG_MIDI_RX_PORT_0	0x000080180000ull
 #define SND_FF_REG_MIDI_RX_PORT_1	0x000080190000ull
 
-int snd_ff_transaction_get_clock(struct snd_ff *ff, unsigned int *rate,
-				 enum snd_ff_clock_src *src)
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
-}
-
 static void finish_transmit_midi_msg(struct snd_ff *ff, unsigned int port,
 				     int rcode)
 {
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 29f55518bf85..1de2f5ec26fd 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -35,8 +35,6 @@
 #define SND_FF_IN_MIDI_PORTS		2
 #define SND_FF_OUT_MIDI_PORTS		2
 
-#define SND_FF_REG_CLOCK_CONFIG		0x0000801c0004ull
-
 enum snd_ff_stream_mode {
 	SND_FF_STREAM_MODE_LOW = 0,
 	SND_FF_STREAM_MODE_MID,
@@ -106,6 +104,8 @@ enum snd_ff_clock_src {
 
 struct snd_ff_protocol {
 	void (*handle_midi_msg)(struct snd_ff *ff, __le32 *buf, size_t length);
+	int (*get_clock)(struct snd_ff *ff, unsigned int *rate,
+			 enum snd_ff_clock_src *src);
 	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
 	int (*begin_session)(struct snd_ff *ff, unsigned int rate);
 	void (*finish_session)(struct snd_ff *ff);
@@ -115,8 +115,6 @@ struct snd_ff_protocol {
 extern const struct snd_ff_protocol snd_ff_protocol_ff800;
 extern const struct snd_ff_protocol snd_ff_protocol_ff400;
 
-int snd_ff_transaction_get_clock(struct snd_ff *ff, unsigned int *rate,
-				 enum snd_ff_clock_src *src);
 int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
-- 
2.19.1
