From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v2] ASoC: AMD: Fix capture unstable in beginning for some runs
Date: Tue, 18 Sep 2018 12:53:13 +0530
Message-ID: <1537255398-25166-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: akshu.agrawal@amd.com, djkurtz@chromium.org, Alexander.Deucher@amd.com, cychiang@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

alsa_conformance_test -C hw:0,4 -p 1024 --debug
would sometime show:
TIME_DIFF(s)    HW_LEVEL       READ              RATE
0.000095970         1024       1024    10670001.041992
0.042609555         1024       2048       24032.168372
0.021330364         1024       3072       48006.681930
0.021339559         1024       4096       47985.996337
The issue is that in dma pointer function we can have stale value
of the register for current descriptor of channel.
The register retains the number of the last descriptor that
was transferred.

Fix ensures that we report position, 0, till the one period worth of
data is transferred.  After one period of data, in handler of period
completion interrupt we update the config and correct value of descriptor
starts reflecting.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

---
v2: fix overrun issue and missed case where bytescount = rtd->bytescount
 sound/soc/amd/acp-pcm-dma.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index b0e245c..0ac4b5b 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1035,16 +1035,22 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
-		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
-		if (dscr == rtd->dma_dscr_idx_1)
-			pos = period_bytes;
-		else
-			pos = 0;
 		bytescount = acp_get_byte_count(rtd);
-		if (bytescount > rtd->bytescount)
+		if (bytescount >= rtd->bytescount)
 			bytescount -= rtd->bytescount;
-		delay = do_div(bytescount, period_bytes);
-		runtime->delay = bytes_to_frames(runtime, delay);
+		if (bytescount < period_bytes) {
+			pos = 0;
+		} else {
+			dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+			if (dscr == rtd->dma_dscr_idx_1)
+				pos = period_bytes;
+			else
+				pos = 0;
+		}
+		if (bytescount > 0) {
+			delay = do_div(bytescount, period_bytes);
+			runtime->delay = bytes_to_frames(runtime, delay);
+		}
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
1.9.1
