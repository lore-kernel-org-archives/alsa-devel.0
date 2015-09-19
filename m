From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/15] ALSA: firewire-lib: rename parameter
	setting function for AM824 with FDF field
Date: Sat, 19 Sep 2015 11:21:56 +0900
Message-ID: <1442629322-15457-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 12A4C2604F4
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:14 +0200 (CEST)
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

The value of FDF field in CIP header is protocol-dependent. Thus, it's
better to allow data block processing layer to decide the value in any
timing.

In AM824 data format, the value of FDF field in CIP header indicates
N-flag and Nominal Sampling Frequency Code (sfc). The N-flag is for
switching 'Clock-based rate control mode' and 'Command-based rate control
mode'. In our implementation, 'Clock-based rate control mode' is just
supported. Therefore, When sampling transfer frequency is decided, then
the FDF can be set.

This commit replaces 'amdtp_stream_set_parameters' with
'amdtp_am824_set_parameters' to set the FDF. This is the same timing
to decide the ration between the number of data blocks and the number of
PCM frames.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c                | 42 +++++++++++++++++++++++++++++
 sound/firewire/amdtp-am824.h                |  5 ++++
 sound/firewire/amdtp-stream.c               | 21 ++-------------
 sound/firewire/amdtp-stream.h               |  3 +--
 sound/firewire/bebob/bebob_stream.c         | 12 ++++-----
 sound/firewire/dice/dice-stream.c           |  4 +--
 sound/firewire/fireworks/fireworks_stream.c |  4 +--
 sound/firewire/oxfw/oxfw-stream.c           |  4 +--
 8 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index da4b643..f5edcbf 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -10,6 +10,48 @@
 
 #define CIP_FMT_AM		0x10
 
+/* "Clock-based rate control mode" is just supported. */
+#define AMDTP_FDF_AM824		0x00
+
+/**
+ * amdtp_am824_set_parameters - set stream parameters
+ * @s: the AMDTP stream to configure
+ * @rate: the sample rate
+ * @pcm_channels: the number of PCM samples in each data block, to be encoded
+ *                as AM824 multi-bit linear audio
+ * @midi_ports: the number of MIDI ports (i.e., MPX-MIDI Data Channels)
+ * @double_pcm_frames: one data block transfers two PCM frames
+ *
+ * The parameters must be set before the stream is started, and must not be
+ * changed while the stream is running.
+ */
+int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			       unsigned int pcm_channels,
+			       unsigned int midi_ports,
+			       bool double_pcm_frames)
+{
+	int err;
+
+	err = amdtp_stream_set_parameters(s, rate, pcm_channels, midi_ports);
+	if (err < 0)
+		return err;
+
+	s->fdf = AMDTP_FDF_AM824 | s->sfc;
+
+	/*
+	 * In IEC 61883-6, one data block represents one event. In ALSA, one
+	 * event equals to one PCM frame. But Dice has a quirk at higher
+	 * sampling rate to transfer two PCM frames in one data block.
+	 */
+	if (double_pcm_frames)
+		s->frame_multiplier = 2;
+	else
+		s->frame_multiplier = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amdtp_am824_set_parameters);
+
 /**
  * amdtp_am824_init - initialize an AMDTP stream structure to handle AM824
  *		      data block
diff --git a/sound/firewire/amdtp-am824.h b/sound/firewire/amdtp-am824.h
index ed96ac5..cfc0d61 100644
--- a/sound/firewire/amdtp-am824.h
+++ b/sound/firewire/amdtp-am824.h
@@ -3,6 +3,11 @@
 
 #include "amdtp-stream.h"
 
+int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			       unsigned int pcm_channels,
+			       unsigned int midi_ports,
+			       bool double_pcm_frames);
+
 int amdtp_am824_init(struct amdtp_stream *s, struct fw_unit *unit,
 		     enum amdtp_stream_direction dir, enum cip_flags flags);
 #endif
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 62f98e1..39ad8e8 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -54,12 +54,8 @@
 #define CIP_SYT_MASK		0x0000ffff
 #define CIP_SYT_NO_INFO		0xffff
 
-/*
- * Audio and Music transfer protocol specific parameters
- * only "Clock-based rate control mode" is supported
- */
+/* Audio and Music transfer protocol specific parameters */
 #define CIP_FMT_AM		0x10
-#define AMDTP_FDF_AM824		0x00
 #define AMDTP_FDF_NO_DATA	0xff
 
 /* TODO: make these configurable */
@@ -204,8 +200,7 @@ EXPORT_SYMBOL(amdtp_stream_add_pcm_hw_constraints);
 int amdtp_stream_set_parameters(struct amdtp_stream *s,
 				unsigned int rate,
 				unsigned int pcm_channels,
-				unsigned int midi_ports,
-				bool double_pcm_frames)
+				unsigned int midi_ports)
 {
 	unsigned int i, sfc, midi_channels;
 
@@ -228,18 +223,6 @@ int amdtp_stream_set_parameters(struct amdtp_stream *s,
 	s->data_block_quadlets = s->pcm_channels + midi_channels;
 	s->midi_ports = midi_ports;
 
-	s->fdf = AMDTP_FDF_AM824 | s->sfc;
-
-	/*
-	 * In IEC 61883-6, one data block represents one event. In ALSA, one
-	 * event equals to one PCM frame. But Dice has a quirk at higher
-	 * sampling rate to transfer two PCM frames in one data block.
-	 */
-	if (double_pcm_frames)
-		s->frame_multiplier = 2;
-	else
-		s->frame_multiplier = 1;
-
 	s->syt_interval = amdtp_syt_intervals[sfc];
 
 	/* default buffering in the device */
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 5f96aff..d915940 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -181,8 +181,7 @@ void amdtp_stream_destroy(struct amdtp_stream *s);
 int amdtp_stream_set_parameters(struct amdtp_stream *s,
 				unsigned int rate,
 				unsigned int pcm_channels,
-				unsigned int midi_ports,
-				bool double_pcm_frames);
+				unsigned int midi_ports);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s);
 
 int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed);
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 34bc3a4..fa510f3 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -427,17 +427,17 @@ make_both_connections(struct snd_bebob *bebob, unsigned int rate)
 	index = get_formation_index(rate);
 	pcm_channels = bebob->tx_stream_formations[index].pcm;
 	midi_channels = bebob->tx_stream_formations[index].midi;
-	err = amdtp_stream_set_parameters(&bebob->tx_stream, rate,
-					  pcm_channels, midi_channels * 8,
-					  false);
+	err = amdtp_am824_set_parameters(&bebob->tx_stream, rate,
+					 pcm_channels, midi_channels * 8,
+					 false);
 	if (err < 0)
 		goto end;
 
 	pcm_channels = bebob->rx_stream_formations[index].pcm;
 	midi_channels = bebob->rx_stream_formations[index].midi;
-	err = amdtp_stream_set_parameters(&bebob->rx_stream, rate,
-					  pcm_channels, midi_channels * 8,
-					  false);
+	err = amdtp_am824_set_parameters(&bebob->rx_stream, rate,
+					 pcm_channels, midi_channels * 8,
+					 false);
 	if (err < 0)
 		goto end;
 
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 917860e..8948381 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -132,8 +132,8 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 		pcm_chs *= 2;
 	}
 
-	err = amdtp_stream_set_parameters(stream, rate, pcm_chs, midi_ports,
-					  false);
+	err = amdtp_am824_set_parameters(stream, rate, pcm_chs, midi_ports,
+					 double_pcm_frames);
 	if (err < 0)
 		goto end;
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 8cac5b9..759f6e3 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -73,8 +73,8 @@ start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
 		midi_ports = efw->midi_in_ports;
 	}
 
-	err = amdtp_stream_set_parameters(stream, sampling_rate,
-					  pcm_channels, midi_ports, false);
+	err = amdtp_am824_set_parameters(stream, sampling_rate,
+					 pcm_channels, midi_ports, false);
 	if (err < 0)
 		goto end;
 
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 8368341..4982bef 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -155,8 +155,8 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
 		err = -EINVAL;
 		goto end;
 	}
-	err = amdtp_stream_set_parameters(stream, rate,
-					  pcm_channels, midi_ports, false);
+	err = amdtp_am824_set_parameters(stream, rate, pcm_channels, midi_ports,
+					 false);
 	if (err < 0)
 		goto end;
 
-- 
2.1.4
