From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/15] ALSA: firewire-lib: add helper functions
	to set positions of data channels
Date: Sat, 19 Sep 2015 11:21:58 +0900
Message-ID: <1442629322-15457-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FE322604F0
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

In IEC 61883-6, several types of data are available in AM824 format. The
data is transferred in each data channel. The position of data channel in
data block differs depending on model.

Current implementation has an array to map the index of data channel in an
data block to the position of actual data channel. The implementation
allows each driver to access the mapping directly.

In later commit, the mapping is in specific structure pushed into an
opaque pointer. Helper functions are required.

This commit adds the helper functions for this purpose. In IEC 61883-6,
AM824 format supports many data types, while this specification easily
causes over-engineering. Current AM824 implementation is allowed to handle
two types of data, Multi Bit Linear Audio data (=PCM samples) and MIDI
conformant data (=MIDI messages).

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c        | 28 ++++++++++++++++++++++++++++
 sound/firewire/amdtp-am824.h        |  6 ++++++
 sound/firewire/bebob/bebob_stream.c |  5 +++--
 sound/firewire/dice/dice-stream.c   |  5 +++--
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index 7adaba3..5d99a992 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -53,6 +53,34 @@ int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
 EXPORT_SYMBOL_GPL(amdtp_am824_set_parameters);
 
 /**
+ * amdtp_am824_set_pcm_position - set an index of data channel for a channel
+ *				  of PCM frame
+ * @s: the AMDTP stream
+ * @index: the index of data channel in an data block
+ * @position: the channel of PCM frame
+ */
+void amdtp_am824_set_pcm_position(struct amdtp_stream *s, unsigned int index,
+				 unsigned int position)
+{
+	if (index < s->pcm_channels)
+		s->pcm_positions[index] = position;
+}
+EXPORT_SYMBOL_GPL(amdtp_am824_set_pcm_position);
+
+/**
+ * amdtp_am824_set_midi_position - set a index of data channel for MIDI
+ *				   conformant data channel
+ * @s: the AMDTP stream
+ * @position: the index of data channel in an data block
+ */
+void amdtp_am824_set_midi_position(struct amdtp_stream *s,
+				   unsigned int position)
+{
+	s->midi_position = position;
+}
+EXPORT_SYMBOL_GPL(amdtp_am824_set_midi_position);
+
+/**
  * amdtp_am824_add_pcm_hw_constraints - add hw constraints for PCM substream
  * @s:		the AMDTP stream for AM824 data block, must be initialized.
  * @runtime:	the PCM substream runtime
diff --git a/sound/firewire/amdtp-am824.h b/sound/firewire/amdtp-am824.h
index 4aaed90..7c21e99 100644
--- a/sound/firewire/amdtp-am824.h
+++ b/sound/firewire/amdtp-am824.h
@@ -10,6 +10,12 @@ int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
 			       unsigned int midi_ports,
 			       bool double_pcm_frames);
 
+void amdtp_am824_set_pcm_position(struct amdtp_stream *s, unsigned int index,
+				 unsigned int position);
+
+void amdtp_am824_set_midi_position(struct amdtp_stream *s,
+				   unsigned int position);
+
 int amdtp_am824_add_pcm_hw_constraints(struct amdtp_stream *s,
 				       struct snd_pcm_runtime *runtime);
 
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index fa510f3..cf6402d 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -338,7 +338,7 @@ map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 					err = -ENOSYS;
 					goto end;
 				}
-				s->midi_position = stm_pos;
+				amdtp_am824_set_midi_position(s, stm_pos);
 				midi = stm_pos;
 				break;
 			/* for PCM data channel */
@@ -358,7 +358,8 @@ map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 					err = -ENOSYS;
 					goto end;
 				}
-				s->pcm_positions[location] = stm_pos;
+				amdtp_am824_set_pcm_position(s, location,
+							     stm_pos);
 				break;
 			}
 		}
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 8948381..2108f7f 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -141,8 +141,9 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 		pcm_chs /= 2;
 
 		for (i = 0; i < pcm_chs; i++) {
-			stream->pcm_positions[i] = i * 2;
-			stream->pcm_positions[i + pcm_chs] = i * 2 + 1;
+			amdtp_am824_set_pcm_position(stream, i, i * 2);
+			amdtp_am824_set_pcm_position(stream, i + pcm_chs,
+						     i * 2 + 1);
 		}
 	}
 
-- 
2.1.4
