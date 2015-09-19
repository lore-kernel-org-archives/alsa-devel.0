From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/15] ALSA: firewire-lib: return error code
	when amdtp_stream_set_parameters() detects error
Date: Sat, 19 Sep 2015 11:21:49 +0900
Message-ID: <1442629322-15457-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4090D2604A4
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:11 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Currently, amdtp_stream_set_parameters() returns no error even if wrong
arguments are given. This is not good for streaming layer because drivers
can continue processing ignoring capability of streaming layer.

This commit changes this function to return error code.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c                      | 22 ++++++++++++----------
 sound/firewire/amdtp.h                      |  8 ++++----
 sound/firewire/bebob/bebob_stream.c         | 13 +++++++++----
 sound/firewire/dice/dice-stream.c           |  5 ++++-
 sound/firewire/fireworks/fireworks_stream.c |  6 ++++--
 sound/firewire/oxfw/oxfw-stream.c           |  5 ++++-
 6 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 2a153d2..2bacb51 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -197,10 +197,10 @@ EXPORT_SYMBOL(amdtp_stream_add_pcm_hw_constraints);
  * The parameters must be set before the stream is started, and must not be
  * changed while the stream is running.
  */
-void amdtp_stream_set_parameters(struct amdtp_stream *s,
-				 unsigned int rate,
-				 unsigned int pcm_channels,
-				 unsigned int midi_ports)
+int amdtp_stream_set_parameters(struct amdtp_stream *s,
+				unsigned int rate,
+				unsigned int pcm_channels,
+				unsigned int midi_ports)
 {
 	unsigned int i, sfc, midi_channels;
 
@@ -209,15 +209,15 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 	if (WARN_ON(amdtp_stream_running(s)) |
 	    WARN_ON(pcm_channels > AMDTP_MAX_CHANNELS_FOR_PCM) |
 	    WARN_ON(midi_channels > AMDTP_MAX_CHANNELS_FOR_MIDI))
-		return;
+		return -EINVAL;
 
-	for (sfc = 0; sfc < ARRAY_SIZE(amdtp_rate_table); ++sfc)
+	for (sfc = 0; sfc < ARRAY_SIZE(amdtp_rate_table); ++sfc) {
 		if (amdtp_rate_table[sfc] == rate)
-			goto sfc_found;
-	WARN_ON(1);
-	return;
+			break;
+	}
+	if (sfc == ARRAY_SIZE(amdtp_rate_table))
+		return -EINVAL;
 
-sfc_found:
 	s->pcm_channels = pcm_channels;
 	s->sfc = sfc;
 	s->data_block_quadlets = s->pcm_channels + midi_channels;
@@ -243,6 +243,8 @@ sfc_found:
 	 * (The value here is adjusted for midi_ratelimit_per_packet().)
 	 */
 	s->midi_fifo_limit = rate - MIDI_BYTES_PER_SECOND * s->syt_interval + 1;
+
+	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_set_parameters);
 
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 4640d2b..3fb8db7 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -174,10 +174,10 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 		      enum cip_flags flags);
 void amdtp_stream_destroy(struct amdtp_stream *s);
 
-void amdtp_stream_set_parameters(struct amdtp_stream *s,
-				 unsigned int rate,
-				 unsigned int pcm_channels,
-				 unsigned int midi_ports);
+int amdtp_stream_set_parameters(struct amdtp_stream *s,
+				unsigned int rate,
+				unsigned int pcm_channels,
+				unsigned int midi_ports);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s);
 
 int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed);
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 5be5242..c642b79 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -427,12 +427,17 @@ make_both_connections(struct snd_bebob *bebob, unsigned int rate)
 	index = get_formation_index(rate);
 	pcm_channels = bebob->tx_stream_formations[index].pcm;
 	midi_channels = bebob->tx_stream_formations[index].midi;
-	amdtp_stream_set_parameters(&bebob->tx_stream,
-				    rate, pcm_channels, midi_channels * 8);
+	err = amdtp_stream_set_parameters(&bebob->tx_stream, rate,
+					  pcm_channels, midi_channels * 8);
+	if (err < 0)
+		goto end;
+
 	pcm_channels = bebob->rx_stream_formations[index].pcm;
 	midi_channels = bebob->rx_stream_formations[index].midi;
-	amdtp_stream_set_parameters(&bebob->rx_stream,
-				    rate, pcm_channels, midi_channels * 8);
+	err = amdtp_stream_set_parameters(&bebob->rx_stream, rate,
+					  pcm_channels, midi_channels * 8);
+	if (err < 0)
+		goto end;
 
 	/* establish connections for both streams */
 	err = cmp_connection_establish(&bebob->out_conn,
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 07dbd01..c96306a 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -133,7 +133,10 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 		stream->double_pcm_frames = false;
 	}
 
-	amdtp_stream_set_parameters(stream, rate, pcm_chs, midi_ports);
+	err = amdtp_stream_set_parameters(stream, rate, pcm_chs, midi_ports);
+	if (err < 0)
+		goto end;
+
 	if (mode > 1) {
 		pcm_chs /= 2;
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 7e353f1..dfefccf 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -73,8 +73,10 @@ start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
 		midi_ports = efw->midi_in_ports;
 	}
 
-	amdtp_stream_set_parameters(stream, sampling_rate,
-				    pcm_channels, midi_ports);
+	err = amdtp_stream_set_parameters(stream, sampling_rate,
+					  pcm_channels, midi_ports);
+	if (err < 0)
+		goto end;
 
 	/*  establish connection via CMP */
 	err = cmp_connection_establish(conn,
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 77ad5b9..d119468 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -155,7 +155,10 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
 		err = -EINVAL;
 		goto end;
 	}
-	amdtp_stream_set_parameters(stream, rate, pcm_channels, midi_ports);
+	err = amdtp_stream_set_parameters(stream, rate,
+					  pcm_channels, midi_ports);
+	if (err < 0)
+		goto end;
 
 	err = cmp_connection_establish(conn,
 				       amdtp_stream_get_max_payload(stream));
-- 
2.1.4
