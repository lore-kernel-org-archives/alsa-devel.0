From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/19] ALSA: oxfw: expand stop procedure for
	packet streaming
Date: Wed, 12 Jun 2019 17:44:18 +0900
Message-ID: <20190612084422.5344-16-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2A8FF8974B
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:51 +0200 (CEST)
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

The helper function stop packet streaming is not enough useful. This
commit obsoletes it and expands its code.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 68 ++++++++++++++++---------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 806a7fded99d..561ceb09d927 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -101,17 +101,6 @@ static int set_stream_format(struct snd_oxfw *oxfw, struct amdtp_stream *s,
 	return 0;
 }
 
-static void stop_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
-{
-	amdtp_stream_pcm_abort(stream);
-	amdtp_stream_stop(stream);
-
-	if (stream == &oxfw->tx_stream)
-		cmp_connection_break(&oxfw->out_conn);
-	else
-		cmp_connection_break(&oxfw->in_conn);
-}
-
 static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
 	u8 **formats;
@@ -158,28 +147,27 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	err = amdtp_am824_set_parameters(stream, formation.rate, formation.pcm,
 					 formation.midi * 8, false);
 	if (err < 0)
-		goto end;
+		return err;
 
 	err = cmp_connection_establish(conn,
 				       amdtp_stream_get_max_payload(stream));
 	if (err < 0)
-		goto end;
+		return err;
 
-	err = amdtp_stream_start(stream,
-				 conn->resources.channel,
-				 conn->speed);
+	err = amdtp_stream_start(stream, conn->resources.channel, conn->speed);
 	if (err < 0) {
 		cmp_connection_break(conn);
-		goto end;
+		return err;
 	}
 
-	/* Wait first packet */
+	// Wait first packet.
 	if (!amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT)) {
-		stop_stream(oxfw, stream);
-		err = -ETIMEDOUT;
+		amdtp_stream_stop(stream);
+		cmp_connection_break(conn);
+		return -ETIMEDOUT;
 	}
-end:
-	return err;
+
+	return 0;
 }
 
 static int check_connection_used_by_others(struct snd_oxfw *oxfw,
@@ -288,9 +276,13 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 	if (formation.rate != rate || formation.pcm != pcm_channels ||
 	    amdtp_streaming_error(&oxfw->rx_stream) ||
 	    amdtp_streaming_error(&oxfw->tx_stream)) {
-		stop_stream(oxfw, &oxfw->rx_stream);
-		if (oxfw->has_output)
-			stop_stream(oxfw, &oxfw->tx_stream);
+		amdtp_stream_stop(&oxfw->rx_stream);
+		cmp_connection_break(&oxfw->in_conn);
+
+		if (oxfw->has_output) {
+			amdtp_stream_stop(&oxfw->tx_stream);
+			cmp_connection_break(&oxfw->out_conn);
+		}
 
 		err = set_stream_format(oxfw, stream, rate, pcm_channels);
 		if (err < 0) {
@@ -322,10 +314,10 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 
 	return 0;
 error:
-	stop_stream(oxfw, &oxfw->rx_stream);
+	amdtp_stream_stop(&oxfw->rx_stream);
 	cmp_connection_break(&oxfw->in_conn);
 	if (oxfw->has_output) {
-		stop_stream(oxfw, &oxfw->tx_stream);
+		amdtp_stream_stop(&oxfw->tx_stream);
 		cmp_connection_break(&oxfw->out_conn);
 	}
 	return err;
@@ -335,10 +327,13 @@ void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
 				  struct amdtp_stream *stream)
 {
 	if (oxfw->capture_substreams == 0 && oxfw->playback_substreams == 0) {
-		stop_stream(oxfw, &oxfw->rx_stream);
+		amdtp_stream_stop(&oxfw->rx_stream);
+		cmp_connection_break(&oxfw->in_conn);
 
-		if (oxfw->has_output)
-			stop_stream(oxfw, &oxfw->tx_stream);
+		if (oxfw->has_output) {
+			amdtp_stream_stop(&oxfw->tx_stream);
+			cmp_connection_break(&oxfw->out_conn);
+		}
 	}
 }
 
@@ -363,10 +358,17 @@ void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
 void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw,
 				    struct amdtp_stream *stream)
 {
-	stop_stream(oxfw, &oxfw->rx_stream);
+	amdtp_stream_stop(&oxfw->rx_stream);
+	cmp_connection_break(&oxfw->in_conn);
 
-	if (oxfw->has_output)
-		stop_stream(oxfw, &oxfw->tx_stream);
+	amdtp_stream_pcm_abort(&oxfw->rx_stream);
+
+	if (oxfw->has_output) {
+		amdtp_stream_stop(&oxfw->tx_stream);
+		cmp_connection_break(&oxfw->out_conn);
+
+		amdtp_stream_pcm_abort(&oxfw->tx_stream);
+	}
 }
 
 int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
-- 
2.20.1
