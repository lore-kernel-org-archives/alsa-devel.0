From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/9] ALSA: fireface: add protocol-dependent
	operation to switch mode to fetch PCM frame
Date: Sun, 20 Jan 2019 17:25:49 +0900
Message-ID: <20190120082553.17347-6-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 431C52673F9
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:18 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id u18so8307955plq.7
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:18 -0800 (PST)
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

This commit adds a member for a callback function to switch frame
fetching mode to former protocol.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-former.c | 38 ++++++++++++++++++++
 sound/firewire/fireface/ff-stream.c          | 38 ++------------------
 sound/firewire/fireface/ff.h                 |  3 +-
 3 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index 5f97e7fc7281..279bd032acf0 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -10,6 +10,42 @@
 #include "ff.h"
 
 #define FORMER_REG_SYNC_STATUS		0x0000801c0000ull
+/* For block write request. */
+#define FORMER_REG_FETCH_PCM_FRAMES	0x0000801c0000ull
+
+static int former_switch_fetching_mode(struct snd_ff *ff, bool enable)
+{
+	unsigned int count;
+	__le32 *reg;
+	int i;
+	int err;
+
+	count = 0;
+	for (i = 0; i < SND_FF_STREAM_MODE_COUNT; ++i)
+		count = max(count, ff->spec->pcm_playback_channels[i]);
+
+	reg = kcalloc(count, sizeof(__le32), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	if (!enable) {
+		/*
+		 * Each quadlet is corresponding to data channels in a data
+		 * blocks in reverse order. Precisely, quadlets for available
+		 * data channels should be enabled. Here, I take second best
+		 * to fetch PCM frames from all of data channels regardless of
+		 * stf.
+		 */
+		for (i = 0; i < count; ++i)
+			reg[i] = cpu_to_le32(0x00000001);
+	}
+
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_BLOCK_REQUEST,
+				 FORMER_REG_FETCH_PCM_FRAMES, reg,
+				 sizeof(__le32) * count, 0);
+	kfree(reg);
+	return err;
+}
 
 static void dump_clock_config(struct snd_ff *ff, struct snd_info_buffer *buffer)
 {
@@ -347,6 +383,7 @@ static void ff800_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
 
 const struct snd_ff_protocol snd_ff_protocol_ff800 = {
 	.handle_midi_msg	= ff800_handle_midi_msg,
+	.switch_fetching_mode	= former_switch_fetching_mode,
 	.begin_session		= ff800_begin_session,
 	.finish_session		= ff800_finish_session,
 	.dump_status		= former_dump_status,
@@ -495,6 +532,7 @@ static void ff400_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
 
 const struct snd_ff_protocol snd_ff_protocol_ff400 = {
 	.handle_midi_msg	= ff400_handle_midi_msg,
+	.switch_fetching_mode	= former_switch_fetching_mode,
 	.begin_session		= ff400_begin_session,
 	.finish_session		= ff400_finish_session,
 	.dump_status		= former_dump_status,
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index a490e4553721..43e1e2679798 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -37,44 +37,10 @@ static void release_resources(struct snd_ff *ff)
 	fw_iso_resources_free(&ff->rx_resources);
 }
 
-static int switch_fetching_mode(struct snd_ff *ff, bool enable)
-{
-	unsigned int count;
-	__le32 *reg;
-	int i;
-	int err;
-
-	count = 0;
-	for (i = 0; i < SND_FF_STREAM_MODE_COUNT; ++i)
-		count = max(count, ff->spec->pcm_playback_channels[i]);
-
-	reg = kcalloc(count, sizeof(__le32), GFP_KERNEL);
-	if (!reg)
-		return -ENOMEM;
-
-	if (!enable) {
-		/*
-		 * Each quadlet is corresponding to data channels in a data
-		 * blocks in reverse order. Precisely, quadlets for available
-		 * data channels should be enabled. Here, I take second best
-		 * to fetch PCM frames from all of data channels regardless of
-		 * stf.
-		 */
-		for (i = 0; i < count; ++i)
-			reg[i] = cpu_to_le32(0x00000001);
-	}
-
-	err = snd_fw_transaction(ff->unit, TCODE_WRITE_BLOCK_REQUEST,
-				 SND_FF_REG_FETCH_PCM_FRAMES, reg,
-				 sizeof(__le32) * count, 0);
-	kfree(reg);
-	return err;
-}
-
 static inline void finish_session(struct snd_ff *ff)
 {
 	ff->spec->protocol->finish_session(ff);
-	switch_fetching_mode(ff, false);
+	ff->spec->protocol->switch_fetching_mode(ff, false);
 }
 
 static int init_stream(struct snd_ff *ff, enum amdtp_stream_direction dir)
@@ -206,7 +172,7 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 			goto error;
 		}
 
-		err = switch_fetching_mode(ff, true);
+		err = ff->spec->protocol->switch_fetching_mode(ff, true);
 		if (err < 0)
 			goto error;
 	}
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 3f22b8d84e36..29f55518bf85 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -35,8 +35,6 @@
 #define SND_FF_IN_MIDI_PORTS		2
 #define SND_FF_OUT_MIDI_PORTS		2
 
-/* For block write request. */
-#define SND_FF_REG_FETCH_PCM_FRAMES	0x0000801c0000ull
 #define SND_FF_REG_CLOCK_CONFIG		0x0000801c0004ull
 
 enum snd_ff_stream_mode {
@@ -108,6 +106,7 @@ enum snd_ff_clock_src {
 
 struct snd_ff_protocol {
 	void (*handle_midi_msg)(struct snd_ff *ff, __le32 *buf, size_t length);
+	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
 	int (*begin_session)(struct snd_ff *ff, unsigned int rate);
 	void (*finish_session)(struct snd_ff *ff);
 	void (*dump_status)(struct snd_ff *ff, struct snd_info_buffer *buffer);
-- 
2.19.1
