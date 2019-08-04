From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/19] ALSA: oxfw: support AMDTP domain
Date: Sun,  4 Aug 2019 15:21:32 +0900
Message-ID: <20190804062138.1217-14-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 434DEF805A1
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:22:03 +0200 (CEST)
In-Reply-To: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
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

This commit adds AMDTP domain support for ALSA oxfw driver.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 72 ++++++++++++++++++-------------
 sound/firewire/oxfw/oxfw.h        |  2 +
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 74c972d25c66..0318dc4dcc55 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -114,19 +114,13 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	if (err < 0)
 		return err;
 
-	err = amdtp_stream_start(stream, conn->resources.channel, conn->speed);
+	err = amdtp_domain_add_stream(&oxfw->domain, stream,
+				      conn->resources.channel, conn->speed);
 	if (err < 0) {
 		cmp_connection_break(conn);
 		return err;
 	}
 
-	// Wait first packet.
-	if (!amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT)) {
-		amdtp_stream_stop(stream);
-		cmp_connection_break(conn);
-		return -ETIMEDOUT;
-	}
-
 	return 0;
 }
 
@@ -280,12 +274,12 @@ int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
 		pcm_channels = formation.pcm;
 	}
 	if (formation.rate != rate || formation.pcm != pcm_channels) {
-		amdtp_stream_stop(&oxfw->rx_stream);
+		amdtp_domain_stop(&oxfw->domain);
+
 		cmp_connection_break(&oxfw->in_conn);
 		cmp_connection_release(&oxfw->in_conn);
 
 		if (oxfw->has_output) {
-			amdtp_stream_stop(&oxfw->tx_stream);
 			cmp_connection_break(&oxfw->out_conn);
 			cmp_connection_release(&oxfw->out_conn);
 		}
@@ -325,55 +319,66 @@ int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw)
 
 	if (amdtp_streaming_error(&oxfw->rx_stream) ||
 	    amdtp_streaming_error(&oxfw->tx_stream)) {
-		amdtp_stream_stop(&oxfw->rx_stream);
-		cmp_connection_break(&oxfw->in_conn);
+		amdtp_domain_stop(&oxfw->domain);
 
-		if (oxfw->has_output) {
-			amdtp_stream_stop(&oxfw->tx_stream);
+		cmp_connection_break(&oxfw->in_conn);
+		if (oxfw->has_output)
 			cmp_connection_break(&oxfw->out_conn);
-		}
 	}
 
 	if (!amdtp_stream_running(&oxfw->rx_stream)) {
 		err = start_stream(oxfw, &oxfw->rx_stream);
 		if (err < 0) {
 			dev_err(&oxfw->unit->device,
-				"fail to start rx stream: %d\n", err);
+				"fail to prepare rx stream: %d\n", err);
 			goto error;
 		}
-	}
 
-	if (oxfw->has_output) {
-		if (!amdtp_stream_running(&oxfw->tx_stream)) {
+		if (oxfw->has_output &&
+		    !amdtp_stream_running(&oxfw->tx_stream)) {
 			err = start_stream(oxfw, &oxfw->tx_stream);
 			if (err < 0) {
 				dev_err(&oxfw->unit->device,
-					"fail to start tx stream: %d\n", err);
+					"fail to prepare tx stream: %d\n", err);
 				goto error;
 			}
 		}
+
+		err = amdtp_domain_start(&oxfw->domain);
+		if (err < 0)
+			goto error;
+
+		// Wait first packet.
+		if (!amdtp_stream_wait_callback(&oxfw->rx_stream,
+						CALLBACK_TIMEOUT) ||
+		    !amdtp_stream_wait_callback(&oxfw->tx_stream,
+						CALLBACK_TIMEOUT)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+
 	}
 
 	return 0;
 error:
-	amdtp_stream_stop(&oxfw->rx_stream);
+	amdtp_domain_stop(&oxfw->domain);
+
 	cmp_connection_break(&oxfw->in_conn);
-	if (oxfw->has_output) {
-		amdtp_stream_stop(&oxfw->tx_stream);
+	if (oxfw->has_output)
 		cmp_connection_break(&oxfw->out_conn);
-	}
+
 	return err;
 }
 
 void snd_oxfw_stream_stop_duplex(struct snd_oxfw *oxfw)
 {
 	if (oxfw->substreams_count == 0) {
-		amdtp_stream_stop(&oxfw->rx_stream);
+		amdtp_domain_stop(&oxfw->domain);
+
 		cmp_connection_break(&oxfw->in_conn);
 		cmp_connection_release(&oxfw->in_conn);
 
 		if (oxfw->has_output) {
-			amdtp_stream_stop(&oxfw->tx_stream);
 			cmp_connection_break(&oxfw->out_conn);
 			cmp_connection_release(&oxfw->out_conn);
 		}
@@ -409,13 +414,22 @@ int snd_oxfw_stream_init_duplex(struct snd_oxfw *oxfw)
 		}
 	}
 
-	return 0;
+	err = amdtp_domain_init(&oxfw->domain);
+	if (err < 0) {
+		destroy_stream(oxfw, &oxfw->rx_stream);
+		if (oxfw->has_output)
+			destroy_stream(oxfw, &oxfw->tx_stream);
+	}
+
+	return err;
 }
 
 // This function should be called before starting the stream or after stopping
 // the streams.
 void snd_oxfw_stream_destroy_duplex(struct snd_oxfw *oxfw)
 {
+	amdtp_domain_destroy(&oxfw->domain);
+
 	destroy_stream(oxfw, &oxfw->rx_stream);
 
 	if (oxfw->has_output)
@@ -424,13 +438,13 @@ void snd_oxfw_stream_destroy_duplex(struct snd_oxfw *oxfw)
 
 void snd_oxfw_stream_update_duplex(struct snd_oxfw *oxfw)
 {
-	amdtp_stream_stop(&oxfw->rx_stream);
+	amdtp_domain_stop(&oxfw->domain);
+
 	cmp_connection_break(&oxfw->in_conn);
 
 	amdtp_stream_pcm_abort(&oxfw->rx_stream);
 
 	if (oxfw->has_output) {
-		amdtp_stream_stop(&oxfw->tx_stream);
 		cmp_connection_break(&oxfw->out_conn);
 
 		amdtp_stream_pcm_abort(&oxfw->tx_stream);
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index cb69ab87bb14..c9627b8c5d6e 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -63,6 +63,8 @@ struct snd_oxfw {
 
 	const struct ieee1394_device_id *entry;
 	void *spec;
+
+	struct amdtp_domain domain;
 };
 
 /*
-- 
2.20.1
