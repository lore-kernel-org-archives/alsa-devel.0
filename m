From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 03/10] ASoC: amd: removed separate byte count variables for playback and capture
Date: Tue, 8 May 2018 10:17:46 +0530
Message-ID: <1525754888-14124-3-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Kurtz <djkurtz@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Removed separate byte count variables for playback and capture.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
v1->v2: Fixed review comment in acp_dma_pointer callback
 sound/soc/amd/acp-pcm-dma.c | 19 +++++--------------
 sound/soc/amd/acp.h         |  3 +--
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 6e338fe..862c1cf 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -866,13 +866,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (bytescount > rtd->i2ssp_renderbytescount)
-			bytescount = bytescount - rtd->i2ssp_renderbytescount;
-	} else {
-		if (bytescount > rtd->i2ssp_capturebytescount)
-			bytescount = bytescount - rtd->i2ssp_capturebytescount;
-	}
+	if (bytescount > rtd->bytescount)
+		bytescount -= rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
@@ -921,9 +916,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		bytescount = acp_get_byte_count(rtd);
+		if (rtd->bytescount == 0)
+			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->i2ssp_renderbytescount == 0)
-				rtd->i2ssp_renderbytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
 				BIT(rtd->ch1)) {
@@ -934,9 +929,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-		} else {
-			if (rtd->i2ssp_capturebytescount == 0)
-				rtd->i2ssp_capturebytescount = bytescount;
 		}
 		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
@@ -955,12 +947,11 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			rtd->i2ssp_capturebytescount = 0;
 		}
+		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 3b076c6..82470bc 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -93,8 +93,7 @@ struct audio_substream_data {
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-	u64 i2ssp_renderbytescount;
-	u64 i2ssp_capturebytescount;
+	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
-- 
2.7.4
