From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/15] ALSA: fireface: code refactoring for
	pcm.hw_params/hw_free callbacks
Date: Sun,  2 Jun 2019 16:12:59 +0900
Message-ID: <20190602071259.21622-16-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7EF7F89756
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:28 +0200 (CEST)
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
 sound/firewire/fireface/ff-pcm.c | 55 ++++----------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index 53477404a58f..938985c2d4a8 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -199,8 +199,8 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *hw_params)
+static int pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_ff *ff = substream->private_data;
 	int err;
@@ -223,48 +223,7 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_ff *ff = substream->private_data;
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
-		mutex_lock(&ff->mutex);
-		err = snd_ff_stream_reserve_duplex(ff, rate);
-		if (err >= 0)
-			++ff->substreams_counter;
-		mutex_unlock(&ff->mutex);
-	}
-
-	return 0;
-}
-
-static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_ff *ff = substream->private_data;
-
-	mutex_lock(&ff->mutex);
-
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		--ff->substreams_counter;
-
-	snd_ff_stream_stop_duplex(ff);
-	snd_ff_stream_release_duplex(ff);
-
-	mutex_unlock(&ff->mutex);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
-
-static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
+static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_ff *ff = substream->private_data;
 
@@ -385,8 +344,8 @@ int snd_ff_create_pcm_devices(struct snd_ff *ff)
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
@@ -397,8 +356,8 @@ int snd_ff_create_pcm_devices(struct snd_ff *ff)
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
