From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 01/13] ASoC: Intel: mfld-pcm: add FE and BE ops
Date: Wed, 30 Jul 2014 18:32:18 +0530
Message-ID: <1406725350-23275-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B424261647
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 15:23:54 +0200 (CEST)
In-Reply-To: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Now that we have added code for managing DSP pipelines we need to add the code
for DSPs FrontEnd and Backend dai.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 113 ++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 7de87887d9f8..3fcd35c73936 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -101,35 +101,6 @@ static struct sst_dev_stream_map dpcm_strm_map[] = {
 	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_CAPTURE, PIPE_PCM1_OUT, SST_TASK_ID_MEDIA, 0},
 };
 
-/* MFLD - MSIC */
-static struct snd_soc_dai_driver sst_platform_dai[] = {
-{
-	.name = "Headset-cpu-dai",
-	.id = 0,
-	.playback = {
-		.channels_min = SST_STEREO,
-		.channels_max = SST_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S24_LE,
-	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 5,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S24_LE,
-	},
-},
-{
-	.name = "Compress-cpu-dai",
-	.compress_dai = 1,
-	.playback = {
-		.channels_min = SST_STEREO,
-		.channels_max = SST_STEREO,
-		.rates = SNDRV_PCM_RATE_44100|SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-},
-};
 
 /* helper functions */
 void sst_set_stream_status(struct sst_runtime_stream *stream,
@@ -444,6 +415,90 @@ static struct snd_soc_dai_ops sst_media_dai_ops = {
 	.hw_free = sst_media_hw_free,
 };
 
+static struct snd_soc_dai_driver sst_platform_dai[] = {
+{
+	.name = "media-cpu-dai",
+	.ops = &sst_media_dai_ops,
+	.playback = {
+		.stream_name = "Headset Playback",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_44100|SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "Headset Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_44100|SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
+	.name = "compress-cpu-dai",
+	.compress_dai = 1,
+	.playback = {
+		.stream_name = "Compress Playback",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+/*BE CPU  Dais */
+{
+	.name = "ssp0-port",
+	.playback = {
+		.stream_name = "ssp0 Tx",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "ssp0 Rx",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
+	.name = "ssp1-port",
+	.playback = {
+		.stream_name = "ssp1 Tx",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "ssp1 Rx",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
+	.name = "ssp2-port",
+	.playback = {
+		.stream_name = "ssp2 Tx",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "ssp2 Rx",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+};
+
 static int sst_platform_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
-- 
1.9.0
