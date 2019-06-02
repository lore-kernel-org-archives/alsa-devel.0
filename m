From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/15] ALSA: firewire-tascam: code refactoring
	for pcm.hw_params/hw_free callbacks
Date: Sun,  2 Jun 2019 16:12:51 +0900
Message-ID: <20190602071259.21622-8-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9157FF896F7
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:16 +0200 (CEST)
In-Reply-To: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
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

The pairs of pcm.hw_params callbacks and .hw_free callbacks for both
direction have no differences.

This commit unifies the pairs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-pcm.c | 55 ++++--------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index 962ef1212ac0..450711bef508 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -84,8 +84,8 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *hw_params)
+static int pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_tscm *tscm = substream->private_data;
 	int err;
@@ -108,48 +108,7 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 	return err;
 }
 
-static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_tscm *tscm = substream->private_data;
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
-		mutex_lock(&tscm->mutex);
-		err = snd_tscm_stream_reserve_duplex(tscm, rate);
-		if (err >= 0)
-			++tscm->substreams_counter;
-		mutex_unlock(&tscm->mutex);
-	}
-
-	return err;
-}
-
-static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_tscm *tscm = substream->private_data;
-
-	mutex_lock(&tscm->mutex);
-
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		--tscm->substreams_counter;
-
-	snd_tscm_stream_stop_duplex(tscm);
-	snd_tscm_stream_release_duplex(tscm);
-
-	mutex_unlock(&tscm->mutex);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
-
-static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
+static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_tscm *tscm = substream->private_data;
 
@@ -270,8 +229,8 @@ int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
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
@@ -282,8 +241,8 @@ int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
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
