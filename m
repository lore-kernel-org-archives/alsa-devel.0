From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/17] firewire-lib: Add support for MIDI
	capture/playback
Date: Sat, 23 Nov 2013 15:07:53 +0900
Message-ID: <1385186884-8259-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A73D5261A04
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:12 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For capturing/playbacking MIDI message, this commit adds the functionality to
multiplex/demultiplex MIDI messages into AMDTP sream in IEC 61883-6. As a
result, the number of MIDI ports is limited by 16 ports, for my convinience.

And this commit allows to set PCM format even if AMDTP stream already starts.
I suppose the case that PCM data starts to be multiplexed/demultiplexed after
AMDTP stream is already started for MIDI. To distinguish whether PCM or MIDI
functionality starts AMDTP stream, this commit adds amdtp_stream_pcm_running()
and amdtp_stream_midi_running(). I think this is better than reference-counter.

IEC 61883-6 refers to AMEI/MMA RP-027 for implementation of MIDI conformant
data. This module implement 'MIDI1.0-1x-SPEED' mode. In the specification,
'MIDI1.0-2x/3x-SPEED' mode is defined with 'negotiation procedure' and
'encapsulation details'. But I cannot find specifications about them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 76 ++++++++++++++++++++++++++++++++++++++++++--------
 sound/firewire/amdtp.h | 30 +++++++++++++++++++-
 2 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 456eb64..ebdaf76 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
+#include <sound/rawmidi.h>
 #include "amdtp.h"
 
 #define TICKS_PER_CYCLE		3072
@@ -122,9 +123,11 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 		[CIP_SFC_176400] = 176400,
 		[CIP_SFC_192000] = 192000,
 	};
-	unsigned int sfc;
+	unsigned int sfc, midi_channels;
 
-	if (WARN_ON(amdtp_stream_running(s)))
+	midi_channels = DIV_ROUND_UP(midi_ports, 8);
+	if (WARN_ON(amdtp_stream_running(s)) ||
+	    WARN_ON(midi_channels > AMDTP_MAX_CHANNELS_FOR_MIDI))
 		return;
 
 	for (sfc = 0; sfc < CIP_SFC_COUNT; ++sfc)
@@ -143,7 +146,7 @@ sfc_found:
 	s->sfc = sfc;
 	s->data_block_quadlets = pcm_channels + DIV_ROUND_UP(midi_ports, 8);
 	s->pcm_channels = pcm_channels;
-	s->midi_ports = midi_ports;
+	s->midi_channels = midi_channels;
 
 	s->syt_interval = amdtp_syt_intervals[sfc];
 
@@ -205,7 +208,7 @@ static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
 void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 				 snd_pcm_format_t format)
 {
-	if (WARN_ON(amdtp_stream_running(s)))
+	if (WARN_ON(amdtp_stream_pcm_running(s)))
 		return;
 
 	switch (format) {
@@ -566,11 +569,58 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 static void amdtp_fill_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
-	unsigned int i;
+	unsigned int m, f, c, port;
+	int len;
+	u8 b[2];
+
+	for (f = 0; f < frames; f++) {
+		m = (s->data_block_counter + f) % 8;
+		for (c = 0; c < s->midi_channels; c++) {
+			b[0] = 0x80;
+			b[1] = 0x00;
+			len = 0;
+
+			port = c * 8 + m;
+			if ((s->midi[port] != NULL) &&
+			    test_bit(port, &s->midi_triggered)) {
+				len = snd_rawmidi_transmit(s->midi[port],
+								b + 1, 1);
+				if (len <= 0)
+					b[1] = 0x00;
+				else
+					b[0] = 0x81;
+			}
+			buffer[s->pcm_channels + c] =
+				be32_to_cpu((b[0] << 24) | (b[1] << 16));
+		}
+		buffer += s->data_block_quadlets;
+	}
+}
 
-	for (i = 0; i < frames; ++i)
-		buffer[s->pcm_channels + i * s->data_block_quadlets] =
-						cpu_to_be32(0x80000000);
+static void amdtp_pull_midi(struct amdtp_stream *s,
+			    __be32 *buffer, unsigned int frames)
+{
+	unsigned int m, f, c, port;
+	int len;
+	u8 *b;
+
+	for (f = 0; f < frames; f++) {
+		m = (s->data_block_counter + f) % 8;
+		for (c = 0; c < s->midi_channels; c++) {
+			b = (u8 *)&buffer[s->pcm_channels + c];
+			if (b[0] < 0x81 || 0x83 < b[0])
+				continue;
+
+			port = c * 8 + m;
+			if ((s->midi[port] == NULL) ||
+			    !test_bit(port, &s->midi_triggered))
+				continue;
+
+			len = b[0] - 0x80;
+			snd_rawmidi_receive(s->midi[port], b + 1, len);
+		}
+		buffer += s->data_block_quadlets;
+	}
 }
 
 static void check_pcm_pointer(struct amdtp_stream *s,
@@ -674,7 +724,7 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 		s->transfer_samples(s, pcm, buffer, data_blocks);
 	else
 		amdtp_fill_pcm_silence(s, buffer, data_blocks);
-	if (s->midi_ports)
+	if (s->midi_channels)
 		amdtp_fill_midi(s, buffer, data_blocks);
 
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
@@ -743,10 +793,14 @@ static void handle_in_packet(struct amdtp_stream *s,
 	buffer += 2;
 
 	pcm = ACCESS_ONCE(s->pcm);
-	if (pcm) {
+	if (pcm)
 		s->transfer_samples(s, pcm, buffer, data_blocks);
+
+	if (s->midi_channels)
+		amdtp_pull_midi(s, buffer, data_blocks);
+
+	if (pcm)
 		check_pcm_pointer(s, pcm, data_blocks);
-	}
 }
 
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 6d7aa36..93489d8 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -44,9 +44,17 @@ enum cip_sfc {
 #define AMDTP_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
 					 SNDRV_PCM_FMTBIT_S32)
 
+/*
+ * This module supports maximum 2 MIDI channels.
+ * Then AMDTP packets include maximum 16 MIDI streams multiplexed.
+ * This is for our convinience.
+ */
+#define AMDTP_MAX_CHANNELS_FOR_MIDI	2
+
 struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
+struct snd_rawmidi_substream;
 
 enum amdtp_stream_direction {
 	AMDTP_RECEIVE_STREAM = 0,
@@ -64,7 +72,7 @@ struct amdtp_stream {
 	bool dual_wire;
 	unsigned int data_block_quadlets;
 	unsigned int pcm_channels;
-	unsigned int midi_ports;
+	unsigned int midi_channels;
 	void (*transfer_samples)(struct amdtp_stream *s,
 				 struct snd_pcm_substream *pcm,
 				 __be32 *buffer, unsigned int frames);
@@ -88,6 +96,9 @@ struct amdtp_stream {
 	unsigned int pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 	bool pointer_flush;
+
+	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
+	unsigned long midi_triggered;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -124,6 +135,12 @@ static inline bool amdtp_stream_running(struct amdtp_stream *s)
 	return !IS_ERR(s->context);
 }
 
+void amdtp_stream_midi_add(struct amdtp_stream *s,
+			   struct snd_rawmidi_substream *substream);
+void amdtp_stream_midi_remove(struct amdtp_stream *s,
+			      struct snd_rawmidi_substream *substream);
+bool amdtp_stream_midi_running(struct amdtp_stream *s);
+
 /**
  * amdtp_stream_set_pcm - configure format of PCM samples
  * @s: the AMDTP stream to be configured
@@ -151,6 +168,17 @@ static inline bool amdtp_streaming_error(struct amdtp_stream *s)
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
-- 
1.8.3.2
