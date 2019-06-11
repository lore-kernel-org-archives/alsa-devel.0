From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/12] ALSA: dice: code refactoring for
	pcm.hw_params/hw_free callbacks
Date: Tue, 11 Jun 2019 22:21:18 +0900
Message-ID: <20190611132118.8378-13-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6B36F89733
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:45 +0200 (CEST)
In-Reply-To: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
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
 sound/firewire/dice/dice-pcm.c | 54 +++++-----------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 6c7a6b7ed743..00b55dfc3b2c 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -231,8 +231,8 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int capture_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *hw_params)
+static int pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
 	int err;
@@ -254,48 +254,8 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 
 	return err;
 }
-static int playback_hw_params(struct snd_pcm_substream *substream,
-			      struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_dice *dice = substream->private_data;
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
-		mutex_lock(&dice->mutex);
-		err = snd_dice_stream_reserve_duplex(dice, rate);
-		if (err >= 0)
-			++dice->substreams_counter;
-		mutex_unlock(&dice->mutex);
-	}
-
-	return err;
-}
-
-static int capture_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_dice *dice = substream->private_data;
-
-	mutex_lock(&dice->mutex);
-
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		--dice->substreams_counter;
-
-	snd_dice_stream_stop_duplex(dice);
-	snd_dice_stream_release_duplex(dice);
-
-	mutex_unlock(&dice->mutex);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
 
-static int playback_hw_free(struct snd_pcm_substream *substream)
+static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
 
@@ -415,8 +375,8 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
-		.hw_params = capture_hw_params,
-		.hw_free   = capture_hw_free,
+		.hw_params = pcm_hw_params,
+		.hw_free   = pcm_hw_free,
 		.prepare   = capture_prepare,
 		.trigger   = capture_trigger,
 		.pointer   = capture_pointer,
@@ -427,8 +387,8 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
-		.hw_params = playback_hw_params,
-		.hw_free   = playback_hw_free,
+		.hw_params = pcm_hw_params,
+		.hw_free   = pcm_hw_free,
 		.prepare   = playback_prepare,
 		.trigger   = playback_trigger,
 		.pointer   = playback_pointer,
-- 
2.20.1
