From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/19] ALSA: oxfw: configure stream parameter
	in pcm.hw_params callback
Date: Wed, 12 Jun 2019 17:44:22 +0900
Message-ID: <20190612084422.5344-20-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E7CEF89761
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:58 +0200 (CEST)
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

This commit is a part of preparation to perform allocation/release
of isochronous resources in pcm.hw_params/hw_free callbacks.

This commit splits out an operation to configure stream parameters into
pcm.hw_params callback. In pcm.prepare callback, establishing
connections and start isochronous contexts.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 97 ++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 40 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 373154d8ee0e..837733f10736 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -103,51 +103,13 @@ static int set_stream_format(struct snd_oxfw *oxfw, struct amdtp_stream *s,
 
 static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
-	u8 **formats;
-	enum avc_general_plug_dir dir;
 	struct cmp_connection *conn;
-	struct snd_oxfw_stream_formation formation;
-	int i;
 	int err;
 
-	if (stream == &oxfw->rx_stream) {
-		dir = AVC_GENERAL_PLUG_DIR_IN;
-		formats = oxfw->rx_stream_formats;
+	if (stream == &oxfw->rx_stream)
 		conn = &oxfw->in_conn;
-	} else {
-		dir = AVC_GENERAL_PLUG_DIR_OUT;
-		formats = oxfw->tx_stream_formats;
+	else
 		conn = &oxfw->out_conn;
-	}
-
-	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
-	if (err < 0)
-		return err;
-
-	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
-		struct snd_oxfw_stream_formation fmt;
-
-		if (formats[i] == NULL)
-			break;
-
-		err = snd_oxfw_stream_parse_format(formats[i], &fmt);
-		if (err < 0)
-			return err;
-		if (fmt.rate == formation.rate && fmt.pcm == formation.pcm &&
-		    fmt.midi == formation.midi)
-			break;
-	}
-	if (i == SND_OXFW_STREAM_FORMAT_ENTRIES)
-		return -EINVAL;
-
-	// The stream should have one pcm channels at least.
-	if (formation.pcm == 0)
-		return -EINVAL;
-
-	err = amdtp_am824_set_parameters(stream, formation.rate, formation.pcm,
-					 formation.midi * 8, false);
-	if (err < 0)
-		return err;
 
 	err = cmp_connection_establish(conn,
 				       amdtp_stream_get_max_payload(stream));
@@ -236,6 +198,51 @@ static int init_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	return 0;
 }
 
+static int keep_resources(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
+{
+	enum avc_general_plug_dir dir;
+	u8 **formats;
+	struct snd_oxfw_stream_formation formation;
+	int i;
+	int err;
+
+	if (stream == &oxfw->rx_stream) {
+		dir = AVC_GENERAL_PLUG_DIR_IN;
+		formats = oxfw->rx_stream_formats;
+	} else {
+		dir = AVC_GENERAL_PLUG_DIR_OUT;
+		formats = oxfw->tx_stream_formats;
+	}
+
+	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		struct snd_oxfw_stream_formation fmt;
+
+		if (formats[i] == NULL)
+			break;
+
+		err = snd_oxfw_stream_parse_format(formats[i], &fmt);
+		if (err < 0)
+			return err;
+
+		if (fmt.rate == formation.rate && fmt.pcm == formation.pcm &&
+		    fmt.midi == formation.midi)
+			break;
+	}
+	if (i == SND_OXFW_STREAM_FORMAT_ENTRIES)
+		return -EINVAL;
+
+	// The stream should have one pcm channels at least.
+	if (formation.pcm == 0)
+		return -EINVAL;
+
+	return amdtp_am824_set_parameters(stream, formation.rate, formation.pcm,
+					 formation.midi * 8, false);
+}
+
 int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
 				   struct amdtp_stream *stream,
 				   unsigned int rate, unsigned int pcm_channels)
@@ -285,6 +292,16 @@ int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
 				"fail to set stream format: %d\n", err);
 			return err;
 		}
+
+		err = keep_resources(oxfw, &oxfw->rx_stream);
+		if (err < 0)
+			return err;
+
+		if (oxfw->has_output) {
+			err = keep_resources(oxfw, &oxfw->tx_stream);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	return 0;
-- 
2.20.1
