From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/19] ALSA: oxfw: unify substreams counter
Date: Wed, 12 Jun 2019 17:44:20 +0900
Message-ID: <20190612084422.5344-18-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D33FDF89759
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:54 +0200 (CEST)
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

In former commits, two isochronous contexts are handles at the same
time. This commit unifies stream counters to obsolete them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-midi.c   | 8 ++++----
 sound/firewire/oxfw/oxfw-pcm.c    | 8 ++++----
 sound/firewire/oxfw/oxfw-stream.c | 4 ++--
 sound/firewire/oxfw/oxfw.h        | 3 +--
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 31352cebdfe9..092493497f1a 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -19,7 +19,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	oxfw->capture_substreams++;
+	++oxfw->substreams_count;
 	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->tx_stream, 0, 0);
 
 	mutex_unlock(&oxfw->mutex);
@@ -41,7 +41,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	oxfw->playback_substreams++;
+	++oxfw->substreams_count;
 	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->rx_stream, 0, 0);
 
 	mutex_unlock(&oxfw->mutex);
@@ -58,7 +58,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	oxfw->capture_substreams--;
+	--oxfw->substreams_count;
 	snd_oxfw_stream_stop_duplex(oxfw);
 
 	mutex_unlock(&oxfw->mutex);
@@ -73,7 +73,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	oxfw->playback_substreams--;
+	--oxfw->substreams_count;
 	snd_oxfw_stream_stop_duplex(oxfw);
 
 	mutex_unlock(&oxfw->mutex);
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 253d79607bdf..79c8e514bed9 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -220,7 +220,7 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&oxfw->mutex);
-		oxfw->capture_substreams++;
+		++oxfw->substreams_count;
 		mutex_unlock(&oxfw->mutex);
 	}
 
@@ -239,7 +239,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&oxfw->mutex);
-		oxfw->playback_substreams++;
+		++oxfw->substreams_count;
 		mutex_unlock(&oxfw->mutex);
 	}
 
@@ -253,7 +253,7 @@ static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&oxfw->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		oxfw->capture_substreams--;
+		--oxfw->substreams_count;
 
 	snd_oxfw_stream_stop_duplex(oxfw);
 
@@ -268,7 +268,7 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&oxfw->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		oxfw->playback_substreams--;
+		--oxfw->substreams_count;
 
 	snd_oxfw_stream_stop_duplex(oxfw);
 
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 52cf815c27f7..ebfe0777773b 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -244,7 +244,7 @@ int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
 	enum avc_general_plug_dir dir;
 	int err = 0;
 
-	if (oxfw->capture_substreams == 0 && oxfw->playback_substreams == 0)
+	if (oxfw->substreams_count == 0)
 		return -EIO;
 
 	// Considering JACK/FFADO streaming:
@@ -323,7 +323,7 @@ int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
 
 void snd_oxfw_stream_stop_duplex(struct snd_oxfw *oxfw)
 {
-	if (oxfw->capture_substreams == 0 && oxfw->playback_substreams == 0) {
+	if (oxfw->substreams_count == 0) {
 		amdtp_stream_stop(&oxfw->rx_stream);
 		cmp_connection_break(&oxfw->in_conn);
 
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 911a452f94db..e0c825288a24 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -52,8 +52,7 @@ struct snd_oxfw {
 	struct cmp_connection in_conn;
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
-	unsigned int capture_substreams;
-	unsigned int playback_substreams;
+	unsigned int substreams_count;
 
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
-- 
2.20.1
