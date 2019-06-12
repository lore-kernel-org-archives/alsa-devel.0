From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/19] ALSA: oxfw: start duplex streams if
	supported
Date: Wed, 12 Jun 2019 17:44:16 +0900
Message-ID: <20190612084422.5344-14-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F29DCF89743
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:48 +0200 (CEST)
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

It's inconvenient to handle two isochronous context separately
each other. This commit unifies the counters to handle the two
at the same time.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 102 ++++++++++++++----------------
 1 file changed, 49 insertions(+), 53 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 1691fdc1a575..bb4ba6c196ea 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -254,96 +254,92 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 				  struct amdtp_stream *stream,
 				  unsigned int rate, unsigned int pcm_channels)
 {
-	struct amdtp_stream *opposite;
 	struct snd_oxfw_stream_formation formation;
 	enum avc_general_plug_dir dir;
-	unsigned int substreams, opposite_substreams;
 	int err = 0;
 
-	if (stream == &oxfw->tx_stream) {
-		substreams = oxfw->capture_substreams;
-		opposite = &oxfw->rx_stream;
-		opposite_substreams = oxfw->playback_substreams;
-		dir = AVC_GENERAL_PLUG_DIR_OUT;
-	} else {
-		substreams = oxfw->playback_substreams;
-		opposite_substreams = oxfw->capture_substreams;
+	if (oxfw->capture_substreams == 0 && oxfw->playback_substreams == 0)
+		return -EIO;
 
-		if (oxfw->has_output)
-			opposite = &oxfw->rx_stream;
-		else
-			opposite = NULL;
-
-		dir = AVC_GENERAL_PLUG_DIR_IN;
+	// Considering JACK/FFADO streaming:
+	// TODO: This can be removed hwdep functionality becomes popular.
+	err = check_connection_used_by_others(oxfw, &oxfw->rx_stream);
+	if (err < 0)
+		return err;
+	if (oxfw->has_output) {
+		err = check_connection_used_by_others(oxfw, &oxfw->tx_stream);
+		if (err < 0)
+			return err;
 	}
 
-	if (substreams == 0)
-		goto end;
-
-	/*
-	 * Considering JACK/FFADO streaming:
-	 * TODO: This can be removed hwdep functionality becomes popular.
-	 */
-	err = check_connection_used_by_others(oxfw, stream);
-	if (err < 0)
-		goto end;
+	if (stream == &oxfw->tx_stream)
+		dir = AVC_GENERAL_PLUG_DIR_OUT;
+	else
+		dir = AVC_GENERAL_PLUG_DIR_IN;
 
 	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
 	if (err < 0)
-		goto end;
+		return err;
 	if (rate == 0)
 		rate = formation.rate;
 	if (pcm_channels == 0)
 		pcm_channels = formation.pcm;
 
 	if (formation.rate != rate || formation.pcm != pcm_channels ||
-	    amdtp_streaming_error(stream)) {
-		if (opposite != NULL) {
-			err = check_connection_used_by_others(oxfw, opposite);
-			if (err < 0)
-				goto end;
-			stop_stream(oxfw, opposite);
-		}
-		stop_stream(oxfw, stream);
+	    amdtp_streaming_error(&oxfw->rx_stream) ||
+	    amdtp_streaming_error(&oxfw->tx_stream)) {
+		stop_stream(oxfw, &oxfw->rx_stream);
+		if (oxfw->has_output)
+			stop_stream(oxfw, &oxfw->tx_stream);
 
 		err = set_stream_format(oxfw, stream, rate, pcm_channels);
 		if (err < 0) {
 			dev_err(&oxfw->unit->device,
 				"fail to set stream format: %d\n", err);
-			goto end;
+			return err;
+		}
+	}
+
+	if (!amdtp_stream_running(&oxfw->rx_stream)) {
+		err = start_stream(oxfw, &oxfw->rx_stream);
+		if (err < 0) {
+			dev_err(&oxfw->unit->device,
+				"fail to start rx stream: %d\n", err);
+			goto error;
 		}
+	}
 
-		/* Start opposite stream if needed. */
-		if (opposite && !amdtp_stream_running(opposite) &&
-		    (opposite_substreams > 0)) {
-			err = start_stream(oxfw, opposite);
+	if (oxfw->has_output) {
+		if (!amdtp_stream_running(&oxfw->tx_stream)) {
+			err = start_stream(oxfw, &oxfw->tx_stream);
 			if (err < 0) {
 				dev_err(&oxfw->unit->device,
-					"fail to restart stream: %d\n", err);
-				goto end;
+					"fail to start tx stream: %d\n", err);
+				goto error;
 			}
 		}
 	}
 
-	/* Start requested stream. */
-	if (!amdtp_stream_running(stream)) {
-		err = start_stream(oxfw, stream);
-		if (err < 0)
-			dev_err(&oxfw->unit->device,
-				"fail to start stream: %d\n", err);
+	return 0;
+error:
+	stop_stream(oxfw, &oxfw->rx_stream);
+	cmp_connection_break(&oxfw->in_conn);
+	if (oxfw->has_output) {
+		stop_stream(oxfw, &oxfw->tx_stream);
+		cmp_connection_break(&oxfw->out_conn);
 	}
-end:
 	return err;
 }
 
 void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
 				  struct amdtp_stream *stream)
 {
-	if (((stream == &oxfw->tx_stream) && (oxfw->capture_substreams > 0)) ||
-	    ((stream == &oxfw->rx_stream) && (oxfw->playback_substreams > 0)))
-		return;
+	if (oxfw->capture_substreams == 0 && oxfw->playback_substreams == 0) {
+		stop_stream(oxfw, &oxfw->rx_stream);
 
-	stop_stream(oxfw, stream);
+		if (oxfw->has_output)
+			stop_stream(oxfw, &oxfw->tx_stream);
+	}
 }
 
 /*
-- 
2.20.1
