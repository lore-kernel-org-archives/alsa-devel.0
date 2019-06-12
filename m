From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/19] ALSA: oxfw: rename helper functions for
	duplex streams
Date: Wed, 12 Jun 2019 17:44:19 +0900
Message-ID: <20190612084422.5344-17-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89C94F89754
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:53 +0200 (CEST)
In-Reply-To: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In former commits, ALSA oxfw driver handles two isochronous contexts
at the same time, except for some devices which supports one endpoint
of isochronous packet stream.

This commit renames some helper functions so that they handles duplex
streams.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-midi.c   |  8 ++---
 sound/firewire/oxfw/oxfw-pcm.c    | 12 +++----
 sound/firewire/oxfw/oxfw-stream.c | 60 ++++++++++++++++++++-----------
 sound/firewire/oxfw/oxfw.c        | 17 ++-------
 sound/firewire/oxfw/oxfw.h        | 14 +++-----
 5 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index b7bbd77dfff1..31352cebdfe9 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -20,7 +20,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	mutex_lock(&oxfw->mutex);
 
 	oxfw->capture_substreams++;
-	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->tx_stream, 0, 0);
+	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->tx_stream, 0, 0);
 
 	mutex_unlock(&oxfw->mutex);
 
@@ -42,7 +42,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	mutex_lock(&oxfw->mutex);
 
 	oxfw->playback_substreams++;
-	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->rx_stream, 0, 0);
+	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->rx_stream, 0, 0);
 
 	mutex_unlock(&oxfw->mutex);
 
@@ -59,7 +59,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 	mutex_lock(&oxfw->mutex);
 
 	oxfw->capture_substreams--;
-	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->tx_stream);
+	snd_oxfw_stream_stop_duplex(oxfw);
 
 	mutex_unlock(&oxfw->mutex);
 
@@ -74,7 +74,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 	mutex_lock(&oxfw->mutex);
 
 	oxfw->playback_substreams--;
-	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
+	snd_oxfw_stream_stop_duplex(oxfw);
 
 	mutex_unlock(&oxfw->mutex);
 
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index b3f6503dd34d..253d79607bdf 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -255,7 +255,7 @@ static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
 		oxfw->capture_substreams--;
 
-	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->tx_stream);
+	snd_oxfw_stream_stop_duplex(oxfw);
 
 	mutex_unlock(&oxfw->mutex);
 
@@ -270,7 +270,7 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
 		oxfw->playback_substreams--;
 
-	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
+	snd_oxfw_stream_stop_duplex(oxfw);
 
 	mutex_unlock(&oxfw->mutex);
 
@@ -284,8 +284,8 @@ static int pcm_capture_prepare(struct snd_pcm_substream *substream)
 	int err;
 
 	mutex_lock(&oxfw->mutex);
-	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->tx_stream,
-					    runtime->rate, runtime->channels);
+	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->tx_stream,
+					   runtime->rate, runtime->channels);
 	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		goto end;
@@ -301,8 +301,8 @@ static int pcm_playback_prepare(struct snd_pcm_substream *substream)
 	int err;
 
 	mutex_lock(&oxfw->mutex);
-	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->rx_stream,
-					    runtime->rate, runtime->channels);
+	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->rx_stream,
+					   runtime->rate, runtime->channels);
 	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		goto end;
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 561ceb09d927..52cf815c27f7 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -194,8 +194,7 @@ static int check_connection_used_by_others(struct snd_oxfw *oxfw,
 	return err;
 }
 
-int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
-				 struct amdtp_stream *stream)
+static int init_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
 	struct cmp_connection *conn;
 	enum cmp_direction c_dir;
@@ -214,13 +213,12 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
 
 	err = cmp_connection_init(conn, oxfw->unit, c_dir, 0);
 	if (err < 0)
-		goto end;
+		return err;
 
 	err = amdtp_am824_init(stream, oxfw->unit, s_dir, CIP_NONBLOCKING);
 	if (err < 0) {
-		amdtp_stream_destroy(stream);
 		cmp_connection_destroy(conn);
-		goto end;
+		return err;
 	}
 
 	/*
@@ -234,13 +232,13 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
 		if (oxfw->wrong_dbs)
 			oxfw->tx_stream.flags |= CIP_WRONG_DBS;
 	}
-end:
-	return err;
+
+	return 0;
 }
 
-int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
-				  struct amdtp_stream *stream,
-				  unsigned int rate, unsigned int pcm_channels)
+int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
+				 struct amdtp_stream *stream,
+				 unsigned int rate, unsigned int pcm_channels)
 {
 	struct snd_oxfw_stream_formation formation;
 	enum avc_general_plug_dir dir;
@@ -323,8 +321,7 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 	return err;
 }
 
-void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
-				  struct amdtp_stream *stream)
+void snd_oxfw_stream_stop_duplex(struct snd_oxfw *oxfw)
 {
 	if (oxfw->capture_substreams == 0 && oxfw->playback_substreams == 0) {
 		amdtp_stream_stop(&oxfw->rx_stream);
@@ -337,12 +334,7 @@ void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
 	}
 }
 
-/*
- * This function should be called before starting the stream or after stopping
- * the streams.
- */
-void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
-				     struct amdtp_stream *stream)
+static void destroy_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
 	struct cmp_connection *conn;
 
@@ -355,8 +347,36 @@ void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
 	cmp_connection_destroy(conn);
 }
 
-void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw,
-				    struct amdtp_stream *stream)
+int snd_oxfw_stream_init_duplex(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	err = init_stream(oxfw, &oxfw->rx_stream);
+	if (err < 0)
+		return err;
+
+	if (oxfw->has_output) {
+		err = init_stream(oxfw, &oxfw->tx_stream);
+		if (err < 0) {
+			destroy_stream(oxfw, &oxfw->rx_stream);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+// This function should be called before starting the stream or after stopping
+// the streams.
+void snd_oxfw_stream_destroy_duplex(struct snd_oxfw *oxfw)
+{
+	destroy_stream(oxfw, &oxfw->rx_stream);
+
+	if (oxfw->has_output)
+		destroy_stream(oxfw, &oxfw->tx_stream);
+}
+
+void snd_oxfw_stream_update_duplex(struct snd_oxfw *oxfw)
 {
 	amdtp_stream_stop(&oxfw->rx_stream);
 	cmp_connection_break(&oxfw->in_conn);
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 3d27f3378d5d..2de26a9987f8 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -118,9 +118,7 @@ static void oxfw_card_free(struct snd_card *card)
 {
 	struct snd_oxfw *oxfw = card->private_data;
 
-	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
-	if (oxfw->has_output)
-		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
+	snd_oxfw_stream_destroy_duplex(oxfw);
 }
 
 static int detect_quirks(struct snd_oxfw *oxfw)
@@ -211,14 +209,9 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
-	err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->rx_stream);
+	err = snd_oxfw_stream_init_duplex(oxfw);
 	if (err < 0)
 		goto error;
-	if (oxfw->has_output) {
-		err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->tx_stream);
-		if (err < 0)
-			goto error;
-	}
 
 	err = snd_oxfw_create_pcm(oxfw);
 	if (err < 0)
@@ -285,11 +278,7 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 
 	if (oxfw->registered) {
 		mutex_lock(&oxfw->mutex);
-
-		snd_oxfw_stream_update_simplex(oxfw, &oxfw->rx_stream);
-		if (oxfw->has_output)
-			snd_oxfw_stream_update_simplex(oxfw, &oxfw->tx_stream);
-
+		snd_oxfw_stream_update_duplex(oxfw);
 		mutex_unlock(&oxfw->mutex);
 
 		if (oxfw->entry->vendor_id == OUI_STANTON)
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index d54d4a9ac4a1..911a452f94db 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -99,17 +99,13 @@ int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
 				enum avc_general_plug_dir dir,
 				unsigned short pid);
 
-int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
-				 struct amdtp_stream *stream);
-int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
+int snd_oxfw_stream_init_duplex(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
 				  struct amdtp_stream *stream,
 				  unsigned int rate, unsigned int pcm_channels);
-void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
-				  struct amdtp_stream *stream);
-void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
-				     struct amdtp_stream *stream);
-void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw,
-				    struct amdtp_stream *stream);
+void snd_oxfw_stream_stop_duplex(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_destroy_duplex(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_update_duplex(struct snd_oxfw *oxfw);
 
 struct snd_oxfw_stream_formation {
 	unsigned int rate;
-- 
2.20.1
