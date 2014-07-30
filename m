From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 12/13] ASoC: Intel: mfld-pcm: add the fe & be dai
	ops
Date: Wed, 30 Jul 2014 18:32:29 +0530
Message-ID: <1406725350-23275-13-git-send-email-subhransu.s.prusty@intel.com>
References: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 37F1A261A5E
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 15:24:18 +0200 (CEST)
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

Now that the DSP topology is added, add the FE and BE dai ops for controls DSP as
well mute/unmute of FE through ASoC

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 2fb079c6a931..d48d23bbf5cd 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -101,6 +101,11 @@ static struct sst_dev_stream_map dpcm_strm_map[] = {
 	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_CAPTURE, PIPE_PCM1_OUT, SST_TASK_ID_MEDIA, 0},
 };
 
+static int sst_media_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+
+	return sst_send_pipe_gains(dai, stream, mute);
+}
 
 /* helper functions */
 void sst_set_stream_status(struct sst_runtime_stream *stream,
@@ -421,12 +426,41 @@ static int sst_media_hw_free(struct snd_pcm_substream *substream,
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
 };
 
 static int sst_media_dai_probe(struct snd_soc_dai *cpu_dai)
@@ -436,6 +470,7 @@ static int sst_media_dai_probe(struct snd_soc_dai *cpu_dai)
 	snd_soc_dai_set_drvdata(cpu_dai, sst);
 	return 0;
 }
+
 static struct snd_soc_dai_driver sst_platform_dai[] = {
 {
 	.probe = sst_media_dai_probe,
@@ -459,6 +494,7 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 {
 	.name = "compress-cpu-dai",
 	.compress_dai = 1,
+	.ops = &sst_compr_dai_ops,
 	.playback = {
 		.stream_name = "Compress Playback",
 		.channels_min = SST_STEREO,
@@ -470,6 +506,7 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 /*BE CPU  Dais */
 {
 	.name = "ssp0-port",
+	.ops = &sst_be_dai_ops,
 	.playback = {
 		.stream_name = "ssp0 Tx",
 		.channels_min = SST_STEREO,
@@ -487,6 +524,7 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 },
 {
 	.name = "ssp1-port",
+	.ops = &sst_be_dai_ops,
 	.playback = {
 		.stream_name = "ssp1 Tx",
 		.channels_min = SST_STEREO,
@@ -504,6 +542,7 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 },
 {
 	.name = "ssp2-port",
+	.ops = &sst_be_dai_ops,
 	.playback = {
 		.stream_name = "ssp2 Tx",
 		.channels_min = SST_STEREO,
-- 
1.9.0
