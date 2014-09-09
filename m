From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v6 08/10] ASoC: Intel: mfld-pcm: add FE and BE
	ops
Date: Tue,  9 Sep 2014 15:11:31 +0530
Message-ID: <1410255693-6958-9-git-send-email-subhransu.s.prusty@intel.com>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B219D264F0F
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 12:04:33 +0200 (CEST)
In-Reply-To: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
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

Now that we have added code for managing DSP pipelines we need to
add the code for DSPs FrontEnd and Backend dai.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 149 ++++++++++++++++++++++++++------
 1 file changed, 121 insertions(+), 28 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 6f5edd6..5a9e84c 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -101,35 +101,11 @@ static struct sst_dev_stream_map dpcm_strm_map[] = {
 	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_CAPTURE, PIPE_PCM1_OUT, SST_TASK_ID_MEDIA, 0},
 };
 
-/* MFLD - MSIC */
-static struct snd_soc_dai_driver sst_platform_dai[] = {
+static int sst_media_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 {
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
+
+	return sst_send_pipe_gains(dai, stream, mute);
+}
 
 /* helper functions */
 void sst_set_stream_status(struct sst_runtime_stream *stream,
@@ -451,12 +427,129 @@ static int sst_media_hw_free(struct snd_pcm_substream *substream,
 	return snd_pcm_lib_free_pages(substream);
 }
 
+static int sst_enable_ssp(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	if (!dai->active) {
+		sst_handle_vb_timer(dai, true);
+		send_ssp_cmd(dai, dai->name, 1);
+	}
+	return 0;
+}
+
+static void sst_disable_ssp(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	if (!dai->active) {
+		send_ssp_cmd(dai, dai->name, 0);
+		sst_handle_vb_timer(dai, false);
+	}
+}
+
 static struct snd_soc_dai_ops sst_media_dai_ops = {
 	.startup = sst_media_open,
 	.shutdown = sst_media_close,
 	.prepare = sst_media_prepare,
 	.hw_params = sst_media_hw_params,
 	.hw_free = sst_media_hw_free,
+	.mute_stream = sst_media_digital_mute,
+};
+
+static struct snd_soc_dai_ops sst_compr_dai_ops = {
+	.mute_stream = sst_media_digital_mute,
+};
+
+static struct snd_soc_dai_ops sst_be_dai_ops = {
+	.startup = sst_enable_ssp,
+	.shutdown = sst_disable_ssp,
+};
+
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
+	.ops = &sst_compr_dai_ops,
+	.playback = {
+		.stream_name = "Compress Playback",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+/*BE CPU  Dais*/
+{
+	.name = "ssp0-port",
+	.ops = &sst_be_dai_ops,
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
+	.ops = &sst_be_dai_ops,
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
+	.ops = &sst_be_dai_ops,
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
 };
 
 static int sst_platform_open(struct snd_pcm_substream *substream)
-- 
1.9.0
