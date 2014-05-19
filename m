From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] ALSA: pcm_dmaengine: Add check during device suspend
Date: Mon, 19 May 2014 14:53:53 +0530
Message-ID: <1400491433-16860-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Currently snd_dmaengine_pcm_trigger() calls dmaengine_pause()
unconditinally during device suspend. In case where DMA controller
doesn't support PAUSE/RESUME functionality, this call is not able
to stop the DMA controller. In this scenario, audio playback doesn't
resume after device resume.

Calling dmaengine_pause/dmaengine_terminate_all conditionally fixes
the issue.

It has been tested with audio playback on Samsung platform having
PL330 DMA controller which doesn't support PAUSE/RESUME.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 sound/core/pcm_dmaengine.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 94d0873..76cbb9e 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -182,6 +182,7 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 
 	switch (cmd) {
@@ -196,6 +197,11 @@ int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		dmaengine_resume(prtd->dma_chan);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (runtime->info & SNDRV_PCM_INFO_PAUSE)
+			dmaengine_pause(prtd->dma_chan);
+		else
+			dmaengine_terminate_all(prtd->dma_chan);
+		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		dmaengine_pause(prtd->dma_chan);
 		break;
-- 
1.7.9.5
