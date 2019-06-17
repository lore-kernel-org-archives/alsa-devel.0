From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/10] ALSA: firewire-motu: code refactoring
	for pcm.hw_params/hw_free callbacks
Date: Mon, 17 Jun 2019 17:15:10 +0900
Message-ID: <20190617081510.11025-11-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB153F89739
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:32 +0200 (CEST)
In-Reply-To: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
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
 sound/firewire/motu/motu-pcm.c | 54 +++++-----------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index d4e75d3ee928..b9852c911b98 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -190,8 +190,8 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int capture_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *hw_params)
+static int pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_motu *motu = substream->private_data;
 	int err;
@@ -213,48 +213,8 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 
 	return err;
 }
-static int playback_hw_params(struct snd_pcm_substream *substream,
-			      struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_motu *motu = substream->private_data;
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
-		mutex_lock(&motu->mutex);
-		err = snd_motu_stream_reserve_duplex(motu, rate);
-		if (err >= 0)
-			++motu->substreams_counter;
-		mutex_unlock(&motu->mutex);
-	}
-
-	return err;
-}
-
-static int capture_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_motu *motu = substream->private_data;
-
-	mutex_lock(&motu->mutex);
-
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		--motu->substreams_counter;
-
-	snd_motu_stream_stop_duplex(motu);
-	snd_motu_stream_release_duplex(motu);
-
-	mutex_unlock(&motu->mutex);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
 
-static int playback_hw_free(struct snd_pcm_substream *substream)
+static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_motu *motu = substream->private_data;
 
@@ -366,8 +326,8 @@ int snd_motu_create_pcm_devices(struct snd_motu *motu)
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
@@ -378,8 +338,8 @@ int snd_motu_create_pcm_devices(struct snd_motu *motu)
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
