From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2] ASoC: Intel: Move capture PCM pin to PCM0
	for Broadwell/Haswell
Date: Fri, 28 Nov 2014 21:52:11 +0800
Message-ID: <1417182731-26576-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AC012260476
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 14:51:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Move capture PCM pin from PCM4 to PCM0 for Broadwell/Haswell.
This will allow us to integrate with pulseaudio better for
usually default device is set to 0.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/broadwell.c       | 15 ++-------------
 sound/soc/intel/haswell.c         | 14 ++------------
 sound/soc/intel/sst-haswell-pcm.c | 34 ++++++++++++++++------------------
 3 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index 52cb764..c256764 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -171,7 +171,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 	/* Front End DAI links */
 	{
 		.name = "System PCM",
-		.stream_name = "System Playback",
+		.stream_name = "System Playback/Capture",
 		.cpu_dai_name = "System Pin",
 		.platform_name = "haswell-pcm-audio",
 		.dynamic = 1,
@@ -180,6 +180,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.init = broadwell_rtd_init,
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
+		.dpcm_capture = 1,
 	},
 	{
 		.name = "Offload0",
@@ -214,18 +215,6 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_capture = 1,
 	},
-	{
-		.name = "Capture PCM",
-		.stream_name = "Capture",
-		.cpu_dai_name = "Capture Pin",
-		.platform_name = "haswell-pcm-audio",
-		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
-		.dpcm_capture = 1,
-	},
-
 	/* Back End DAI links */
 	{
 		/* SSP0 - Codec */
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/haswell.c
index 3981982..cb8a482 100644
--- a/sound/soc/intel/haswell.c
+++ b/sound/soc/intel/haswell.c
@@ -109,7 +109,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 	/* Front End DAI links */
 	{
 		.name = "System",
-		.stream_name = "System Playback",
+		.stream_name = "System Playback/Capture",
 		.cpu_dai_name = "System Pin",
 		.platform_name = "haswell-pcm-audio",
 		.dynamic = 1,
@@ -118,6 +118,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 		.init = haswell_rtd_init,
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
+		.dpcm_capture = 1,
 	},
 	{
 		.name = "Offload0",
@@ -152,17 +153,6 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_capture = 1,
 	},
-	{
-		.name = "Capture",
-		.stream_name = "Capture",
-		.cpu_dai_name = "Capture Pin",
-		.platform_name = "haswell-pcm-audio",
-		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
-		.dpcm_capture = 1,
-	},
 
 	/* Back End DAI links */
 	{
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 5f70d81..0180b38 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -309,7 +309,7 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
 		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
 	/* Mic Capture volume */
-	SOC_DOUBLE_EXT_TLV("Mic Capture Volume", 4, 0, 8,
+	SOC_DOUBLE_EXT_TLV("Mic Capture Volume", 0, 0, 8,
 		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
 };
@@ -396,8 +396,14 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 	/* DSP stream type depends on DAI ID */
 	switch (rtd->cpu_dai->id) {
 	case 0:
-		stream_type = SST_HSW_STREAM_TYPE_SYSTEM;
-		module_id = SST_HSW_MODULE_PCM_SYSTEM;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			stream_type = SST_HSW_STREAM_TYPE_SYSTEM;
+			module_id = SST_HSW_MODULE_PCM_SYSTEM;
+		}
+		else {
+			stream_type = SST_HSW_STREAM_TYPE_CAPTURE;
+			module_id = SST_HSW_MODULE_PCM_CAPTURE;
+		}
 		break;
 	case 1:
 	case 2:
@@ -410,10 +416,6 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 		path_id = SST_HSW_STREAM_PATH_SSP0_OUT;
 		module_id = SST_HSW_MODULE_PCM_REFERENCE;
 		break;
-	case 4:
-		stream_type = SST_HSW_STREAM_TYPE_CAPTURE;
-		module_id = SST_HSW_MODULE_PCM_CAPTURE;
-		break;
 	default:
 		dev_err(rtd->dev, "error: invalid DAI ID %d\n",
 			rtd->cpu_dai->id);
@@ -779,6 +781,13 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 			.rates = SNDRV_PCM_RATE_48000,
 			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
 		},
+		.capture = {
+			.stream_name = "Analog Capture",
+			.channels_min = 2,
+			.channels_max = 4,
+			.rates = SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
+		},
 	},
 	{
 		/* PCM */
@@ -815,17 +824,6 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
 		},
 	},
-	{
-		.name  = "Capture Pin",
-		.id = HSW_PCM_DAI_ID_CAPTURE,
-		.capture = {
-			.stream_name = "Analog Capture",
-			.channels_min = 2,
-			.channels_max = 4,
-			.rates = SNDRV_PCM_RATE_48000,
-			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
-		},
-	},
 };
 
 static const struct snd_soc_dapm_widget widgets[] = {
-- 
1.9.1
