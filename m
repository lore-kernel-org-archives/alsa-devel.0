From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/19] ALSA: fireworks: configure stream
	parameters in pcm.hw_params callback
Date: Wed, 12 Jun 2019 17:44:12 +0900
Message-ID: <20190612084422.5344-10-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9815EF89731
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:42 +0200 (CEST)
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
 sound/firewire/fireworks/fireworks_stream.c | 82 ++++++++++++---------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index e1ebead583e9..1abc15760513 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -52,54 +52,38 @@ stop_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 		cmp_connection_break(&efw->in_conn);
 }
 
-static int
-start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
-	     unsigned int sampling_rate)
+static int start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
+			unsigned int rate)
 {
 	struct cmp_connection *conn;
-	unsigned int mode, pcm_channels, midi_ports;
 	int err;
 
-	err = snd_efw_get_multiplier_mode(sampling_rate, &mode);
-	if (err < 0)
-		goto end;
-	if (stream == &efw->tx_stream) {
+	if (stream == &efw->tx_stream)
 		conn = &efw->out_conn;
-		pcm_channels = efw->pcm_capture_channels[mode];
-		midi_ports = efw->midi_out_ports;
-	} else {
+	else
 		conn = &efw->in_conn;
-		pcm_channels = efw->pcm_playback_channels[mode];
-		midi_ports = efw->midi_in_ports;
-	}
 
-	err = amdtp_am824_set_parameters(stream, sampling_rate,
-					 pcm_channels, midi_ports, false);
-	if (err < 0)
-		goto end;
-
-	/*  establish connection via CMP */
+	// Establish connection via CMP.
 	err = cmp_connection_establish(conn,
-				amdtp_stream_get_max_payload(stream));
+				       amdtp_stream_get_max_payload(stream));
 	if (err < 0)
-		goto end;
+		return err;
 
-	/* start amdtp stream */
-	err = amdtp_stream_start(stream,
-				 conn->resources.channel,
-				 conn->speed);
+	// Start amdtp stream.
+	err = amdtp_stream_start(stream, conn->resources.channel, conn->speed);
 	if (err < 0) {
-		stop_stream(efw, stream);
-		goto end;
+		cmp_connection_break(conn);
+		return err;
 	}
 
-	/* wait first callback */
+	// Wait first callback.
 	if (!amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT)) {
-		stop_stream(efw, stream);
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
 
 /*
@@ -189,6 +173,24 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
 	return err;
 }
 
+static int keep_resources(struct snd_efw *efw, struct amdtp_stream *stream,
+			  unsigned int rate, unsigned int mode)
+{
+	unsigned int pcm_channels;
+	unsigned int midi_ports;
+
+	if (stream == &efw->tx_stream) {
+		pcm_channels = efw->pcm_capture_channels[mode];
+		midi_ports = efw->midi_out_ports;
+	} else {
+		pcm_channels = efw->pcm_playback_channels[mode];
+		midi_ports = efw->midi_in_ports;
+	}
+
+	return amdtp_am824_set_parameters(stream, rate, pcm_channels,
+					  midi_ports, false);
+}
+
 int snd_efw_stream_reserve_duplex(struct snd_efw *efw, unsigned int rate)
 {
 	unsigned int curr_rate;
@@ -212,9 +214,23 @@ int snd_efw_stream_reserve_duplex(struct snd_efw *efw, unsigned int rate)
 	}
 
 	if (efw->substreams_counter == 0 || rate != curr_rate) {
+		unsigned int mode;
+
 		err = snd_efw_command_set_sampling_rate(efw, rate);
 		if (err < 0)
 			return err;
+
+		err = snd_efw_get_multiplier_mode(rate, &mode);
+		if (err < 0)
+			return err;
+
+		err = keep_resources(efw, &efw->tx_stream, rate, mode);
+		if (err < 0)
+			return err;
+
+		err = keep_resources(efw, &efw->rx_stream, rate, mode);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
-- 
2.20.1
