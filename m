From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/19] ALSA: fireworks: code refactoring for
	pcm.hw_params/hw_free
Date: Wed, 12 Jun 2019 17:44:10 +0900
Message-ID: <20190612084422.5344-8-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B78E5F896CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:39 +0200 (CEST)
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

Two sets of callbacks for pcm.hw_params/hw_free but they have the same
codes. This commit unifies each of the callbacks.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_pcm.c | 45 ++++--------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index a66f6a381dac..398a6ad04c5f 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -219,7 +219,7 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
+static int pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_efw *efw = substream->private_data;
@@ -238,41 +238,8 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	return 0;
 }
-static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_efw *efw = substream->private_data;
-	int err;
-
-	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-					       params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
-
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
-		mutex_lock(&efw->mutex);
-		++efw->substreams_counter;
-		mutex_unlock(&efw->mutex);
-	}
-
-	return 0;
-}
-
-static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_efw *efw = substream->private_data;
 
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
-		mutex_lock(&efw->mutex);
-		--efw->substreams_counter;
-		mutex_unlock(&efw->mutex);
-	}
-
-	snd_efw_stream_stop_duplex(efw);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
-static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
+static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_efw *efw = substream->private_data;
 
@@ -378,8 +345,8 @@ int snd_efw_create_pcm_devices(struct snd_efw *efw)
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
@@ -390,8 +357,8 @@ int snd_efw_create_pcm_devices(struct snd_efw *efw)
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
