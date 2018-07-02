From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 1/6] ASoC: AMD: Always stop ch2 first
Date: Mon,  2 Jul 2018 15:19:50 -0600
Message-ID: <20180702211956.149355-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Commit 6b116dfb4633a ("ASoC: AMD: make channel 1 dma as circular") made
both channels circular, so this comment and logic no longer applies.  Always
stop ch2 (the channel closest to the output) before ch1.  This ensures
that the downstream circular DMA channel does not continue to play/capture
repeated samples after the upstream circular DMA channel has already
stopped.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 3c3d398d0d0b1..4665ae12e74e4 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1067,21 +1067,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/* For playback, non circular dma should be stopped first
-		 * i.e Sysram to acp dma transfer channel(rtd->ch1) should be
-		 * stopped before stopping cirular dma which is acp sram to i2s
-		 * fifo dma transfer channel(rtd->ch2). Where as in Capture
-		 * scenario, i2s fifo to acp sram dma channel(rtd->ch2) stopped
-		 * first before stopping acp sram to sysram which is circular
-		 * dma(rtd->ch1).
-		 */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-		} else {
-			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-		}
+		acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+		ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		rtd->bytescount = 0;
 		break;
 	default:
-- 
2.18.0.399.gad0ab374a1-goog
