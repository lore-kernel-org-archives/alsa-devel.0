From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/19] ALSA: bebob: code refactoring to
	initialize/destroy stream data
Date: Wed, 12 Jun 2019 17:44:07 +0900
Message-ID: <20190612084422.5344-5-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CA8EF806F5
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:35 +0200 (CEST)
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

This commit changes helper functions to initialize/destroy stream
data so that it has an argument for direction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 121 ++++++++++++++--------------
 1 file changed, 61 insertions(+), 60 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index c3cc31df49e0..6aab3dc99bef 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -376,24 +376,6 @@ map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 	return err;
 }
 
-static int
-init_both_connections(struct snd_bebob *bebob)
-{
-	int err;
-
-	err = cmp_connection_init(&bebob->in_conn,
-				  bebob->unit, CMP_INPUT, 0);
-	if (err < 0)
-		goto end;
-
-	err = cmp_connection_init(&bebob->out_conn,
-				  bebob->unit, CMP_OUTPUT, 0);
-	if (err < 0)
-		cmp_connection_destroy(&bebob->in_conn);
-end:
-	return err;
-}
-
 static int
 check_connection_used_by_others(struct snd_bebob *bebob, struct amdtp_stream *s)
 {
@@ -448,13 +430,6 @@ break_both_connections(struct snd_bebob *bebob)
 		msleep(200);
 }
 
-static void
-destroy_both_connections(struct snd_bebob *bebob)
-{
-	cmp_connection_destroy(&bebob->in_conn);
-	cmp_connection_destroy(&bebob->out_conn);
-}
-
 static int
 start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream)
 {
@@ -481,49 +456,77 @@ start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream)
 	return err;
 }
 
-int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
+static int init_stream(struct snd_bebob *bebob, struct amdtp_stream *stream)
 {
+	enum amdtp_stream_direction dir_stream;
+	struct cmp_connection *conn;
+	enum cmp_direction dir_conn;
 	int err;
 
-	err = init_both_connections(bebob);
+	if (stream == &bebob->tx_stream) {
+		dir_stream = AMDTP_IN_STREAM;
+		conn = &bebob->out_conn;
+		dir_conn = CMP_OUTPUT;
+	} else {
+		dir_stream = AMDTP_OUT_STREAM;
+		conn = &bebob->in_conn;
+		dir_conn = CMP_INPUT;
+	}
+
+	err = cmp_connection_init(conn, bebob->unit, dir_conn, 0);
 	if (err < 0)
-		goto end;
+		return err;
 
-	err = amdtp_am824_init(&bebob->tx_stream, bebob->unit,
-			       AMDTP_IN_STREAM, CIP_BLOCKING);
+	err = amdtp_am824_init(stream, bebob->unit, dir_stream, CIP_BLOCKING);
 	if (err < 0) {
-		amdtp_stream_destroy(&bebob->tx_stream);
-		destroy_both_connections(bebob);
-		goto end;
+		cmp_connection_destroy(conn);
+		return err;
 	}
 
-	/*
-	 * BeBoB v3 transfers packets with these qurks:
-	 *  - In the beginning of streaming, the value of dbc is incremented
-	 *    even if no data blocks are transferred.
-	 *  - The value of dbc is reset suddenly.
-	 */
-	if (bebob->version > 2)
-		bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC |
-					  CIP_SKIP_DBC_ZERO_CHECK;
+	if (stream == &bebob->tx_stream) {
+		// BeBoB v3 transfers packets with these qurks:
+		//  - In the beginning of streaming, the value of dbc is
+		//    incremented even if no data blocks are transferred.
+		//  - The value of dbc is reset suddenly.
+		if (bebob->version > 2)
+			bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC |
+						  CIP_SKIP_DBC_ZERO_CHECK;
+
+		// At high sampling rate, M-Audio special firmware transmits
+		// empty packet with the value of dbc incremented by 8 but the
+		// others are valid to IEC 61883-1.
+		if (bebob->maudio_special_quirk)
+			bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC;
+	}
 
-	/*
-	 * At high sampling rate, M-Audio special firmware transmits empty
-	 * packet with the value of dbc incremented by 8 but the others are
-	 * valid to IEC 61883-1.
-	 */
-	if (bebob->maudio_special_quirk)
-		bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC;
+	return 0;
+}
+
+static void destroy_stream(struct snd_bebob *bebob, struct amdtp_stream *stream)
+{
+	amdtp_stream_destroy(stream);
+
+	if (stream == &bebob->tx_stream)
+		cmp_connection_destroy(&bebob->out_conn);
+	else
+		cmp_connection_destroy(&bebob->in_conn);
+}
 
-	err = amdtp_am824_init(&bebob->rx_stream, bebob->unit,
-			       AMDTP_OUT_STREAM, CIP_BLOCKING);
+int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
+{
+	int err;
+
+	err = init_stream(bebob, &bebob->tx_stream);
+	if (err < 0)
+		return err;
+
+	err = init_stream(bebob, &bebob->rx_stream);
 	if (err < 0) {
-		amdtp_stream_destroy(&bebob->tx_stream);
-		amdtp_stream_destroy(&bebob->rx_stream);
-		destroy_both_connections(bebob);
+		destroy_stream(bebob, &bebob->tx_stream);
+		return err;
 	}
-end:
-	return err;
+
+	return 0;
 }
 
 static int keep_resources(struct snd_bebob *bebob, struct amdtp_stream *stream,
@@ -693,10 +696,8 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
  */
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob)
 {
-	amdtp_stream_destroy(&bebob->rx_stream);
-	amdtp_stream_destroy(&bebob->tx_stream);
-
-	destroy_both_connections(bebob);
+	destroy_stream(bebob, &bebob->tx_stream);
+	destroy_stream(bebob, &bebob->rx_stream);
 }
 
 /*
-- 
2.20.1
