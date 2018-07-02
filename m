From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 6/6] ASoC: AMD: Simplify trigger handler
Date: Mon,  2 Jul 2018 15:19:55 -0600
Message-ID: <20180702211956.149355-6-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Now that the I2S channel names are fixed, and DMA data flow order is
consistent (ch1 then ch2), we can simplify channel start order:
start the upstream channel and then the downstream channel for both
playback and capture cases.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ab60129f4f266..65c1033bd51cc 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1024,10 +1024,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		rtd->bytescount = acp_get_byte_count(rtd);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_start(rtd->acp_mmio, rtd->ch1);
-			acp_dma_start(rtd->acp_mmio, rtd->ch2);
-		} else {
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 			if (rtd->capture_channel == CAP_CHANNEL0) {
 				acp_dma_cap_channel_disable(rtd->acp_mmio,
 							    CAP_CHANNEL1);
@@ -1040,9 +1037,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				acp_dma_cap_channel_enable(rtd->acp_mmio,
 							   CAP_CHANNEL1);
 			}
-			acp_dma_start(rtd->acp_mmio, rtd->ch2);
-			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 		}
+		acp_dma_start(rtd->acp_mmio, rtd->ch1);
+		acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.18.0.399.gad0ab374a1-goog
