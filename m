From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/38] firewire-lib: Add support for MIDI capture/playback
Date: Fri, 20 Dec 2013 22:13:57 +0900
Message-ID: <1387545269-3875-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

For capturing/playbacking MIDI messages, this commit adds one MIDI conformant
data channel. This channel supports 8 MPX-MIDI data streams then maximum number
of supported MIDI ports is limited by 8.

And this commit allows to set PCM format even if AMDTP stream already starts.
I suppose the case that PCM data starts to be joined into AMDTP streams after
AMDTP stream is already started for MIDI. To distinguish whether PCM or MIDI
functionality starts AMDTP stream, this commit adds amdtp_stream_pcm_running()
and amdtp_stream_midi_running(). I think this is better than reference-counter.

IEC 61883-6 refers to AMEI/MMA RP-027 for implementation of MIDI conformant
data. In the specification, 'MIDI1.0-2x/3x-SPEED' mode are described with
'negotiation procedure' and 'encapsulation details'. But there is no
specifications to define them. This module implement 'MIDI1.0-1x-SPEED' mode.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 79 +++++++++++++++++++++++++++++++++++++++++++-------
 sound/firewire/amdtp.h | 45 ++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 4ebfd67..7ed8d49 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
+#include <sound/rawmidi.h>
 #include "amdtp.h"
 
 #define TICKS_PER_CYCLE		3072
@@ -123,9 +124,12 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 		[CIP_SFC_176400] = 176400,
 		[CIP_SFC_192000] = 192000,
 	};
-	unsigned int sfc;
+	unsigned int sfc, midi_channels;
 
-	if (WARN_ON(amdtp_stream_running(s)))
+	midi_channels = DIV_ROUND_UP(midi_ports, 8);
+
+	if (WARN_ON(amdtp_stream_running(s)) ||
+	    WARN_ON(midi_channels > AMDTP_MAX_CHANNELS_FOR_MIDI))
 		return;
 
 	for (sfc = 0; sfc < CIP_SFC_COUNT; ++sfc)
@@ -142,7 +146,7 @@ sfc_found:
 		pcm_channels *= 2;
 	}
 	s->sfc = sfc;
-	s->data_block_quadlets = pcm_channels + DIV_ROUND_UP(midi_ports, 8);
+	s->data_block_quadlets = pcm_channels + midi_channels;
 	s->pcm_channels = pcm_channels;
 	s->midi_ports = midi_ports;
 
@@ -200,7 +204,7 @@ static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
 void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 				 snd_pcm_format_t format)
 {
-	if (WARN_ON(amdtp_stream_running(s)))
+	if (WARN_ON(amdtp_stream_pcm_running(s)))
 		return;
 
 	switch (format) {
@@ -505,11 +509,46 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 static void amdtp_fill_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
-	unsigned int i;
+	unsigned int f, port;
+	u8 *b;
+
+	for (f = 0; f < frames; f++) {
+		buffer[s->pcm_channels + 1] = 0x00;
+		b = (u8 *)&buffer[s->pcm_channels + 1];
+
+		port = (s->data_block_counter + f) % 8;
+		if ((s->midi[port] == NULL) ||
+		    (snd_rawmidi_transmit(s->midi[port], b + 1, 1) <= 0)) {
+			b[0] = 0x80;
+			b[1] = 0x00;	/* confirm to be zero */
+		} else {
+			b[0] = 0x81;
+		}
+		buffer += s->data_block_quadlets;
+	}
+}
+
+static void amdtp_pull_midi(struct amdtp_stream *s,
+			    __be32 *buffer, unsigned int frames)
+{
+	unsigned int f, port;
+	int len;
+	u8 *b;
+
+	for (f = 0; f < frames; f++) {
+		port = (s->data_block_counter + f) % 8;
+		b = (u8 *)&buffer[s->pcm_channels + 1];
+
+		len = b[0] - 0x80;
+		if (len < 1 || 3 < len)
+			continue;
 
-	for (i = 0; i < frames; ++i)
-		buffer[s->pcm_channels + i * s->data_block_quadlets] =
-						cpu_to_be32(0x80000000);
+		if (s->midi[port] == NULL)
+			continue;
+
+		snd_rawmidi_receive(s->midi[port], b + 1, len);
+		buffer += s->data_block_quadlets;
+	}
 }
 
 static void update_pcm_pointers(struct amdtp_stream *s,
@@ -683,10 +722,14 @@ static void handle_in_packet(struct amdtp_stream *s,
 	buffer += 2;
 
 	pcm = ACCESS_ONCE(s->pcm);
-	if (pcm) {
+	if (pcm)
 		s->transfer_samples(s, pcm, buffer, data_blocks);
+
+	if (s->midi_ports)
+		amdtp_pull_midi(s, buffer, data_blocks);
+
+	if (pcm)
 		update_pcm_pointers(s, pcm, data_blocks);
-	}
 }
 
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
@@ -916,3 +959,19 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s)
 	}
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_abort);
+
+/**
+ * amdtp_stream_midi_running - check any MIDI streams are running or not
+ * @s: the AMDTP stream
+ *
+ * If this function returns true, any MIDI streams are running.
+ */
+bool amdtp_stream_midi_running(struct amdtp_stream *s)
+{
+	int i;
+	for (i = 0; i < AMDTP_MAX_CHANNELS_FOR_MIDI * 8; i++)
+		if (!IS_ERR_OR_NULL(s->midi[i]))
+			return true;
+	return false;
+}
+EXPORT_SYMBOL(amdtp_stream_midi_running);
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 019134e..6e8081c 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -44,9 +44,21 @@ enum cip_sfc {
 #define AMDTP_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
 					 SNDRV_PCM_FMTBIT_S32)
 
+
+/*
+ * AMDTP packet can include channels for MIDI conformant data.
+ * Each MIDI conformant data channel includes 8 MPX-MIDI data stream.
+ * Each MPX-MIDI data stream includes one data stream from/to MIDI ports.
+ *
+ * This module supports maximum 1 MIDI conformant data channels.
+ * Then this AMDTP packets can transfer maximum 8 MIDI data streams.
+ */
+#define AMDTP_MAX_CHANNELS_FOR_MIDI	1
+
 struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
+struct snd_rawmidi_substream;
 
 enum amdtp_stream_direction {
 	AMDTP_OUT_STREAM = 0,
@@ -88,6 +100,8 @@ struct amdtp_stream {
 	unsigned int pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 	bool pointer_flush;
+
+	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -124,6 +138,8 @@ static inline bool amdtp_stream_running(struct amdtp_stream *s)
 	return !IS_ERR(s->context);
 }
 
+bool amdtp_stream_midi_running(struct amdtp_stream *s);
+
 /**
  * amdtp_streaming_error - check for streaming error
  * @s: the AMDTP stream
@@ -137,6 +153,17 @@ static inline bool amdtp_streaming_error(struct amdtp_stream *s)
 }
 
 /**
+ * amdtp_stream_pcm_running - check PCM stream is running or not
+ * @s: the AMDTP stream
+ *
+ * If this function returns true, PCM stream in the stream is running.
+ */
+static inline bool amdtp_stream_pcm_running(struct amdtp_stream *s)
+{
+	return !IS_ERR_OR_NULL(s->pcm);
+}
+
+/**
  * amdtp_stream_pcm_trigger - start/stop playback from a PCM device
  * @s: the AMDTP stream
  * @pcm: the PCM device to be started, or %NULL to stop the current device
@@ -151,6 +178,24 @@ static inline void amdtp_stream_pcm_trigger(struct amdtp_stream *s,
 	ACCESS_ONCE(s->pcm) = pcm;
 }
 
+/**
+ * amdtp_stream_midi_trigger - start/stop playback/capture with a MIDI device
+ * @s: the AMDTP stream
+ * @port: index of MIDI port
+ * @midi: the MIDI device to be started, or %NULL to stop the current device
+ *
+ * Call this function on a running isochronous stream to enable the actual
+ * transmission of MIDI data.  This function should be called from the MIDI
+ * device's .trigger callback.
+ */
+static inline void amdtp_stream_midi_trigger(struct amdtp_stream *s,
+					     unsigned int port,
+					     struct snd_rawmidi_substream *midi)
+{
+	if (port < s->midi_ports)
+		ACCESS_ONCE(s->midi[port]) = midi;
+}
+
 static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
 {
 	return sfc & 1;
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
