From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: firewire-lib: rename local functions
	for code cleanup
Date: Fri, 22 May 2015 23:21:11 +0900
Message-ID: <1432304474-6533-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C64ED265ADF
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 16:21:18 +0200 (CEST)
In-Reply-To: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The naming rule for local functions was inconsistent. This commit
rename them with a consistent manner.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 60 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 97afc88..9d72345 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -260,15 +260,15 @@ unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 }
 EXPORT_SYMBOL(amdtp_stream_get_max_payload);
 
-static void amdtp_write_s16(struct amdtp_stream *s,
-			    struct snd_pcm_substream *pcm,
-			    __be32 *buffer, unsigned int frames);
-static void amdtp_write_s32(struct amdtp_stream *s,
-			    struct snd_pcm_substream *pcm,
-			    __be32 *buffer, unsigned int frames);
-static void amdtp_read_s32(struct amdtp_stream *s,
-			   struct snd_pcm_substream *pcm,
-			   __be32 *buffer, unsigned int frames);
+static void write_pcm_s16(struct amdtp_stream *s,
+			  struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames);
+static void write_pcm_s32(struct amdtp_stream *s,
+			  struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames);
+static void read_pcm_s32(struct amdtp_stream *s,
+			 struct snd_pcm_substream *pcm,
+			 __be32 *buffer, unsigned int frames);
 
 /**
  * amdtp_stream_set_pcm_format - set the PCM format
@@ -291,16 +291,16 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 		/* fall through */
 	case SNDRV_PCM_FORMAT_S16:
 		if (s->direction == AMDTP_OUT_STREAM) {
-			s->transfer_samples = amdtp_write_s16;
+			s->transfer_samples = write_pcm_s16;
 			break;
 		}
 		WARN_ON(1);
 		/* fall through */
 	case SNDRV_PCM_FORMAT_S32:
 		if (s->direction == AMDTP_OUT_STREAM)
-			s->transfer_samples = amdtp_write_s32;
+			s->transfer_samples = write_pcm_s32;
 		else
-			s->transfer_samples = amdtp_read_s32;
+			s->transfer_samples = read_pcm_s32;
 		break;
 	}
 }
@@ -408,9 +408,9 @@ static unsigned int calculate_syt(struct amdtp_stream *s,
 	}
 }
 
-static void amdtp_write_s32(struct amdtp_stream *s,
-			    struct snd_pcm_substream *pcm,
-			    __be32 *buffer, unsigned int frames)
+static void write_pcm_s32(struct amdtp_stream *s,
+			  struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
 {
 	struct snd_pcm_runtime *runtime = pcm->runtime;
 	unsigned int channels, remaining_frames, i, c;
@@ -433,9 +433,9 @@ static void amdtp_write_s32(struct amdtp_stream *s,
 	}
 }
 
-static void amdtp_write_s16(struct amdtp_stream *s,
-			    struct snd_pcm_substream *pcm,
-			    __be32 *buffer, unsigned int frames)
+static void write_pcm_s16(struct amdtp_stream *s,
+			  struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
 {
 	struct snd_pcm_runtime *runtime = pcm->runtime;
 	unsigned int channels, remaining_frames, i, c;
@@ -458,9 +458,9 @@ static void amdtp_write_s16(struct amdtp_stream *s,
 	}
 }
 
-static void amdtp_read_s32(struct amdtp_stream *s,
-			   struct snd_pcm_substream *pcm,
-			   __be32 *buffer, unsigned int frames)
+static void read_pcm_s32(struct amdtp_stream *s,
+			 struct snd_pcm_substream *pcm,
+			 __be32 *buffer, unsigned int frames)
 {
 	struct snd_pcm_runtime *runtime = pcm->runtime;
 	unsigned int channels, remaining_frames, i, c;
@@ -482,8 +482,8 @@ static void amdtp_read_s32(struct amdtp_stream *s,
 	}
 }
 
-static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
-				   __be32 *buffer, unsigned int frames)
+static void write_pcm_silence(struct amdtp_stream *s,
+			      __be32 *buffer, unsigned int frames)
 {
 	unsigned int i, c;
 
@@ -524,8 +524,8 @@ static void midi_rate_use_one_byte(struct amdtp_stream *s, unsigned int port)
 	s->midi_fifo_used[port] += amdtp_rate_table[s->sfc];
 }
 
-static void amdtp_fill_midi(struct amdtp_stream *s,
-			    __be32 *buffer, unsigned int frames)
+static void write_midi_messages(struct amdtp_stream *s,
+				__be32 *buffer, unsigned int frames)
 {
 	unsigned int f, port;
 	u8 *b;
@@ -551,8 +551,8 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 	}
 }
 
-static void amdtp_pull_midi(struct amdtp_stream *s,
-			    __be32 *buffer, unsigned int frames)
+static void read_midi_messages(struct amdtp_stream *s,
+			       __be32 *buffer, unsigned int frames)
 {
 	unsigned int f, port;
 	int len;
@@ -666,9 +666,9 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	if (pcm)
 		s->transfer_samples(s, pcm, buffer, data_blocks);
 	else
-		amdtp_fill_pcm_silence(s, buffer, data_blocks);
+		write_pcm_silence(s, buffer, data_blocks);
 	if (s->midi_ports)
-		amdtp_fill_midi(s, buffer, data_blocks);
+		write_midi_messages(s, buffer, data_blocks);
 
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
@@ -766,7 +766,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 			s->transfer_samples(s, pcm, buffer, data_blocks);
 
 		if (s->midi_ports)
-			amdtp_pull_midi(s, buffer, data_blocks);
+			read_midi_messages(s, buffer, data_blocks);
 	}
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
-- 
2.1.4
