From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireworks/bebob/dice/oxfw: fix
	substreams counting at vmalloc failure
Date: Sat, 29 Aug 2015 10:38:46 +0900
Message-ID: <1440812326-6008-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B1AFC265E23
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 03:38:52 +0200 (CEST)
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

In PCM core, when hw_params() in each driver returns error, the state of
PCM substream is kept as 'open'. In this case, current drivers for sound
units on IEEE 1394 bus doesn't decrement substream counter in hw_free()
correctly. This causes these drivers to keep streams even if not
required.

This commit fixes this bug. When snd_pcm_lib_alloc_vmalloc_buffer()
fails, hw_params function in each driver returns without incrementing the
counter.

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_pcm.c         | 20 ++++++++++++++++----
 sound/firewire/dice/dice-pcm.c           | 18 ++++++++++++++----
 sound/firewire/fireworks/fireworks_pcm.c | 18 ++++++++++++++----
 sound/firewire/oxfw/oxfw-pcm.c           | 17 +++++++++++++----
 4 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 7a2c1f5..c0f018a 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -211,26 +211,38 @@ pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_bebob *bebob = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&bebob->substreams_counter);
 	amdtp_stream_set_pcm_format(&bebob->tx_stream,
 				    params_format(hw_params));
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+
+	return 0;
 }
 static int
 pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		       struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_bebob *bebob = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&bebob->substreams_counter);
 	amdtp_stream_set_pcm_format(&bebob->rx_stream,
 				    params_format(hw_params));
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+
+	return 0;
 }
 
 static int
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index f7771451..4e67b1d 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -230,6 +230,12 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&dice->mutex);
@@ -240,13 +246,18 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 	amdtp_stream_set_pcm_format(&dice->tx_stream,
 				    params_format(hw_params));
 
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+	return 0;
 }
 static int playback_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&dice->mutex);
@@ -257,8 +268,7 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 	amdtp_stream_set_pcm_format(&dice->rx_stream,
 				    params_format(hw_params));
 
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+	return 0;
 }
 
 static int capture_hw_free(struct snd_pcm_substream *substream)
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 8a34753..c30b2ff 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -244,25 +244,35 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_efw *efw = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&efw->capture_substreams);
 	amdtp_stream_set_pcm_format(&efw->tx_stream, params_format(hw_params));
 
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+	return 0;
 }
 static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_efw *efw = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&efw->playback_substreams);
 	amdtp_stream_set_pcm_format(&efw->rx_stream, params_format(hw_params));
 
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+	return 0;
 }
 
 static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 67ade07..9c73930 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -231,7 +231,12 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
+	int err;
 
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&oxfw->mutex);
@@ -241,13 +246,18 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	amdtp_stream_set_pcm_format(&oxfw->tx_stream, params_format(hw_params));
 
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+	return 0;
 }
 static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&oxfw->mutex);
@@ -257,8 +267,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	amdtp_stream_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
 
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+	return 0;
 }
 
 static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
-- 
2.1.4
