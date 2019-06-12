From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/19] ALSA: oxfw: set packet parameter
	according to current configuration
Date: Wed, 12 Jun 2019 17:44:15 +0900
Message-ID: <20190612084422.5344-13-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36BD5F8973E
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:47 +0200 (CEST)
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

After a call of pcm.hw_params, the state of target device is expected
for applications. This commit retrieves the state and start packet
streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 48 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 34ff673e6ff8..1691fdc1a575 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -112,51 +112,51 @@ static void stop_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 		cmp_connection_break(&oxfw->in_conn);
 }
 
-static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
-			unsigned int rate, unsigned int pcm_channels)
+static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
 	u8 **formats;
+	enum avc_general_plug_dir dir;
 	struct cmp_connection *conn;
 	struct snd_oxfw_stream_formation formation;
-	unsigned int i, midi_ports;
+	int i;
 	int err;
 
 	if (stream == &oxfw->rx_stream) {
+		dir = AVC_GENERAL_PLUG_DIR_IN;
 		formats = oxfw->rx_stream_formats;
 		conn = &oxfw->in_conn;
 	} else {
+		dir = AVC_GENERAL_PLUG_DIR_OUT;
 		formats = oxfw->tx_stream_formats;
 		conn = &oxfw->out_conn;
 	}
 
-	/* Get stream format */
+	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
+	if (err < 0)
+		return err;
+
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		struct snd_oxfw_stream_formation fmt;
+
 		if (formats[i] == NULL)
 			break;
 
-		err = snd_oxfw_stream_parse_format(formats[i], &formation);
+		err = snd_oxfw_stream_parse_format(formats[i], &fmt);
 		if (err < 0)
-			goto end;
-		if (rate != formation.rate)
-			continue;
-		if (pcm_channels == 0 ||  pcm_channels == formation.pcm)
+			return err;
+		if (fmt.rate == formation.rate && fmt.pcm == formation.pcm &&
+		    fmt.midi == formation.midi)
 			break;
 	}
-	if (i == SND_OXFW_STREAM_FORMAT_ENTRIES) {
-		err = -EINVAL;
-		goto end;
-	}
+	if (i == SND_OXFW_STREAM_FORMAT_ENTRIES)
+		return -EINVAL;
 
-	pcm_channels = formation.pcm;
-	midi_ports = formation.midi * 8;
+	// The stream should have one pcm channels at least.
+	if (formation.pcm == 0)
+		return -EINVAL;
 
-	/* The stream should have one pcm channels at least */
-	if (pcm_channels == 0) {
-		err = -EINVAL;
-		goto end;
-	}
-	err = amdtp_am824_set_parameters(stream, rate, pcm_channels, midi_ports,
-					 false);
+	err = amdtp_am824_set_parameters(stream, formation.rate, formation.pcm,
+					 formation.midi * 8, false);
 	if (err < 0)
 		goto end;
 
@@ -316,7 +316,7 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 		/* Start opposite stream if needed. */
 		if (opposite && !amdtp_stream_running(opposite) &&
 		    (opposite_substreams > 0)) {
-			err = start_stream(oxfw, opposite, rate, 0);
+			err = start_stream(oxfw, opposite);
 			if (err < 0) {
 				dev_err(&oxfw->unit->device,
 					"fail to restart stream: %d\n", err);
@@ -327,7 +327,7 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 
 	/* Start requested stream. */
 	if (!amdtp_stream_running(stream)) {
-		err = start_stream(oxfw, stream, rate, pcm_channels);
+		err = start_stream(oxfw, stream);
 		if (err < 0)
 			dev_err(&oxfw->unit->device,
 				"fail to start stream: %d\n", err);
-- 
2.20.1
