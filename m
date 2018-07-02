From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 2/6] ASoC: AMD: Reset bytescount when starting transaction
Date: Mon,  2 Jul 2018 15:19:51 -0600
Message-ID: <20180702211956.149355-2-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The pointer() callback gets its value by reading the I2S BYTE_COUNT
register.  This is a 64-bit runnning transaction counter. If a
transaction was aborted in the middle of a sample buffer, the counter will
stop counting on a number divisible by the buffer size.  Since we actually
use it as a pointer into an aligned buffer, however, we do want to ensure
that it always starts at a number divisible by the buffer size when
starting a transaction, hence we reset it whenever starting a transaction.

To accomplish this, it wasn't necessary to zero bytescount at the
termination of each transaction, so remove this unnecessary code.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 4665ae12e74e4..e6f85f2e5ac2a 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1029,7 +1029,6 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
-	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1040,9 +1039,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd);
-		if (rtd->bytescount == 0)
-			rtd->bytescount = bytescount;
+		rtd->bytescount = acp_get_byte_count(rtd);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
@@ -1069,7 +1066,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 		ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.18.0.399.gad0ab374a1-goog
