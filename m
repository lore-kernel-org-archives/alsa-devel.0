From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/15] ALSA: firewire-lib: move MIDI trigger
	helper function to AM824 layer
Date: Sat, 19 Sep 2015 11:21:59 +0900
Message-ID: <1442629322-15457-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0E8260513
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

In IEC 61883-6, MIDI messages are transferred in MIDI conformant data
channel. Essentially, packet streaming layer is not responsible for MIDI
functionality.

This commit moves MIDI trigger helper function from the layer to AM824
layer. The rest of codes related to MIDI functionality will be moved in
later commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c              | 18 ++++++++++++++++++
 sound/firewire/amdtp-am824.h              |  4 ++++
 sound/firewire/amdtp-stream.h             | 18 ------------------
 sound/firewire/bebob/bebob_midi.c         | 16 ++++++++--------
 sound/firewire/dice/dice-midi.c           | 12 ++++++------
 sound/firewire/fireworks/fireworks_midi.c | 12 ++++++------
 sound/firewire/oxfw/oxfw-midi.c           | 16 ++++++++--------
 7 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index 5d99a992..540a101 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -101,6 +101,24 @@ int amdtp_am824_add_pcm_hw_constraints(struct amdtp_stream *s,
 EXPORT_SYMBOL_GPL(amdtp_am824_add_pcm_hw_constraints);
 
 /**
+ * amdtp_am824_midi_trigger - start/stop playback/capture with a MIDI device
+ * @s: the AMDTP stream
+ * @port: index of MIDI port
+ * @midi: the MIDI device to be started, or %NULL to stop the current device
+ *
+ * Call this function on a running isochronous stream to enable the actual
+ * transmission of MIDI data.  This function should be called from the MIDI
+ * device's .trigger callback.
+ */
+void amdtp_am824_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			      struct snd_rawmidi_substream *midi)
+{
+	if (port < s->midi_ports)
+		ACCESS_ONCE(s->midi[port]) = midi;
+}
+EXPORT_SYMBOL_GPL(amdtp_am824_midi_trigger);
+
+/**
  * amdtp_am824_init - initialize an AMDTP stream structure to handle AM824
  *		      data block
  * @s: the AMDTP stream to initialize
diff --git a/sound/firewire/amdtp-am824.h b/sound/firewire/amdtp-am824.h
index 7c21e99..65e6093 100644
--- a/sound/firewire/amdtp-am824.h
+++ b/sound/firewire/amdtp-am824.h
@@ -2,6 +2,7 @@
 #define SOUND_FIREWIRE_AMDTP_AM824_H_INCLUDED
 
 #include <sound/pcm.h>
+#include <sound/rawmidi.h>
 
 #include "amdtp-stream.h"
 
@@ -19,6 +20,9 @@ void amdtp_am824_set_midi_position(struct amdtp_stream *s,
 int amdtp_am824_add_pcm_hw_constraints(struct amdtp_stream *s,
 				       struct snd_pcm_runtime *runtime);
 
+void amdtp_am824_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			      struct snd_rawmidi_substream *midi);
+
 int amdtp_am824_init(struct amdtp_stream *s, struct fw_unit *unit,
 		     enum amdtp_stream_direction dir, enum cip_flags flags);
 #endif
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index d915940..984f02a 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -248,24 +248,6 @@ static inline void amdtp_stream_pcm_trigger(struct amdtp_stream *s,
 	ACCESS_ONCE(s->pcm) = pcm;
 }
 
-/**
- * amdtp_stream_midi_trigger - start/stop playback/capture with a MIDI device
- * @s: the AMDTP stream
- * @port: index of MIDI port
- * @midi: the MIDI device to be started, or %NULL to stop the current device
- *
- * Call this function on a running isochronous stream to enable the actual
- * transmission of MIDI data.  This function should be called from the MIDI
- * device's .trigger callback.
- */
-static inline void amdtp_stream_midi_trigger(struct amdtp_stream *s,
-					     unsigned int port,
-					     struct snd_rawmidi_substream *midi)
-{
-	if (port < s->midi_ports)
-		ACCESS_ONCE(s->midi[port]) = midi;
-}
-
 static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
 {
 	return sfc & 1;
diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index 5681143..90d95be 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -72,11 +72,11 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&bebob->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&bebob->tx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&bebob->tx_stream,
+					 substrm->number, substrm);
 	else
-		amdtp_stream_midi_trigger(&bebob->tx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&bebob->tx_stream,
+					 substrm->number, NULL);
 
 	spin_unlock_irqrestore(&bebob->lock, flags);
 }
@@ -89,11 +89,11 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&bebob->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&bebob->rx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&bebob->rx_stream,
+					 substrm->number, substrm);
 	else
-		amdtp_stream_midi_trigger(&bebob->rx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&bebob->rx_stream,
+					 substrm->number, NULL);
 
 	spin_unlock_irqrestore(&bebob->lock, flags);
 }
diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index fe43ce7..151b09f 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -52,10 +52,10 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&dice->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&dice->tx_stream,
+		amdtp_am824_midi_trigger(&dice->tx_stream,
 					  substrm->number, substrm);
 	else
-		amdtp_stream_midi_trigger(&dice->tx_stream,
+		amdtp_am824_midi_trigger(&dice->tx_stream,
 					  substrm->number, NULL);
 
 	spin_unlock_irqrestore(&dice->lock, flags);
@@ -69,11 +69,11 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&dice->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&dice->rx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&dice->rx_stream,
+					 substrm->number, substrm);
 	else
-		amdtp_stream_midi_trigger(&dice->rx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&dice->rx_stream,
+					 substrm->number, NULL);
 
 	spin_unlock_irqrestore(&dice->lock, flags);
 }
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index cf9c652..fba01bb 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -73,10 +73,10 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&efw->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&efw->tx_stream,
+		amdtp_am824_midi_trigger(&efw->tx_stream,
 					  substrm->number, substrm);
 	else
-		amdtp_stream_midi_trigger(&efw->tx_stream,
+		amdtp_am824_midi_trigger(&efw->tx_stream,
 					  substrm->number, NULL);
 
 	spin_unlock_irqrestore(&efw->lock, flags);
@@ -90,11 +90,11 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&efw->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&efw->rx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&efw->rx_stream,
+					 substrm->number, substrm);
 	else
-		amdtp_stream_midi_trigger(&efw->rx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&efw->rx_stream,
+					 substrm->number, NULL);
 
 	spin_unlock_irqrestore(&efw->lock, flags);
 }
diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 540a303..37a86cf 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -90,11 +90,11 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&oxfw->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&oxfw->tx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&oxfw->tx_stream,
+					 substrm->number, substrm);
 	else
-		amdtp_stream_midi_trigger(&oxfw->tx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&oxfw->tx_stream,
+					 substrm->number, NULL);
 
 	spin_unlock_irqrestore(&oxfw->lock, flags);
 }
@@ -107,11 +107,11 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&oxfw->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&oxfw->rx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&oxfw->rx_stream,
+					 substrm->number, substrm);
 	else
-		amdtp_stream_midi_trigger(&oxfw->rx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&oxfw->rx_stream,
+					 substrm->number, NULL);
 
 	spin_unlock_irqrestore(&oxfw->lock, flags);
 }
-- 
2.1.4
