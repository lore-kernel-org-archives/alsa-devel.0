From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 1/4] ASoC: Intel: add SSP BE DAIs
Date: Mon,  5 May 2014 23:31:45 +0530
Message-ID: <1399312908-20744-2-git-send-email-vinod.koul@intel.com>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F45526087E
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 20:18:32 +0200 (CEST)
In-Reply-To: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |  112 +++++++++++++++++++++++--------
 1 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 7c790f5..f4b85e5 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -92,35 +92,6 @@ static struct snd_pcm_hardware sst_platform_pcm_hw = {
 	.fifo_size = SST_FIFO_SIZE,
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
@@ -316,6 +287,89 @@ static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
 	return ret_val;
 }
 
+static struct snd_soc_dai_driver sst_platform_dai[] = {
+{
+	.name = "media-cpu-dai",
+	.playback = {
+		.stream_name = "Media Playback",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_44100|SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "Media Capture",
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
 static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
-- 
1.7.0.4
