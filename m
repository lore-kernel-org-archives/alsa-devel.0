From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/6] ALSA: bebob: code rafactoring for callback
	functions to PCM interface
Date: Sat, 15 Jun 2019 18:10:56 +0900
Message-ID: <20190615091101.7515-2-o-takashi@sakamocchi.jp>
References: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70F4AF8076F
 for <alsa-devel@alsa-project.org>; Sat, 15 Jun 2019 11:11:12 +0200 (CEST)
In-Reply-To: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
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

The pairs of pcm.hw_params callback functions and .hw_free callback
functions for both direction have no differences.

This commit unifies the pairs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_pcm.c | 55 ++++----------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 71b6ede31bb2..530db7a7844c 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -185,33 +185,8 @@ pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int
-pcm_capture_hw_params(struct snd_pcm_substream *substream,
-		      struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_bebob *bebob = substream->private_data;
-	int err;
-
-	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-					       params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
-
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
-		unsigned int rate = params_rate(hw_params);
-
-		mutex_lock(&bebob->mutex);
-		err = snd_bebob_stream_reserve_duplex(bebob, rate);
-		if (err >= 0)
-			++bebob->substreams_counter;
-		mutex_unlock(&bebob->mutex);
-	}
-
-	return err;
-}
-static int
-pcm_playback_hw_params(struct snd_pcm_substream *substream,
-		       struct snd_pcm_hw_params *hw_params)
+static int pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_bebob *bebob = substream->private_data;
 	int err;
@@ -234,23 +209,7 @@ pcm_playback_hw_params(struct snd_pcm_substream *substream,
 	return err;
 }
 
-static int
-pcm_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_bebob *bebob = substream->private_data;
-
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
-		mutex_lock(&bebob->mutex);
-		bebob->substreams_counter--;
-		mutex_unlock(&bebob->mutex);
-	}
-
-	snd_bebob_stream_stop_duplex(bebob);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
-static int
-pcm_playback_hw_free(struct snd_pcm_substream *substream)
+static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
 
@@ -360,8 +319,8 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob)
 		.open		= pcm_open,
 		.close		= pcm_close,
 		.ioctl		= snd_pcm_lib_ioctl,
-		.hw_params	= pcm_capture_hw_params,
-		.hw_free	= pcm_capture_hw_free,
+		.hw_params	= pcm_hw_params,
+		.hw_free	= pcm_hw_free,
 		.prepare	= pcm_capture_prepare,
 		.trigger	= pcm_capture_trigger,
 		.pointer	= pcm_capture_pointer,
@@ -372,8 +331,8 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob)
 		.open		= pcm_open,
 		.close		= pcm_close,
 		.ioctl		= snd_pcm_lib_ioctl,
-		.hw_params	= pcm_playback_hw_params,
-		.hw_free	= pcm_playback_hw_free,
+		.hw_params	= pcm_hw_params,
+		.hw_free	= pcm_hw_free,
 		.prepare	= pcm_playback_prepare,
 		.trigger	= pcm_playback_trigger,
 		.pointer	= pcm_playback_pointer,
-- 
2.20.1
