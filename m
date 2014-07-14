From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Cleanup HSW pcm format support
Date: Mon, 14 Jul 2014 17:37:36 +0800
Message-ID: <1405330656-29569-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FB1C26172C
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 11:38:00 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This change removes unsupported formats from System,
Capture and Loopback FE DAIs.
Also it fixes S24_LE support on all DAIs.
While at this fix 24 bit flag for BYT as well.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-baytrail-pcm.c |  2 +-
 sound/soc/intel/sst-haswell-pcm.c  | 27 ++++++++++++++++++---------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 8eab973..599401c 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -32,7 +32,7 @@ static const struct snd_pcm_hardware sst_byt_pcm_hardware = {
 				  SNDRV_PCM_INFO_PAUSE |
 				  SNDRV_PCM_INFO_RESUME,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
-				  SNDRV_PCM_FORMAT_S24_LE,
+				  SNDRV_PCM_FMTBIT_S24_LE,
 	.period_bytes_min	= 384,
 	.period_bytes_max	= 48000,
 	.periods_min		= 2,
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 7ec97d7..9ee82ae 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -81,7 +81,7 @@ static const struct snd_pcm_hardware hsw_pcm_hardware = {
 				  SNDRV_PCM_INFO_PAUSE |
 				  SNDRV_PCM_INFO_RESUME |
 				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE |
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 	.period_bytes_min	= PAGE_SIZE,
 	.period_bytes_max	= (HSW_PCM_PERIODS_MAX / HSW_PCM_PERIODS_MIN) * PAGE_SIZE,
@@ -420,7 +420,15 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 		sst_hsw_stream_set_valid(hsw, pcm_data->stream, 16);
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		bits = SST_HSW_DEPTH_24BIT;
+		bits = SST_HSW_DEPTH_32BIT;
+		sst_hsw_stream_set_valid(hsw, pcm_data->stream, 24);
+		break;
+	case SNDRV_PCM_FORMAT_S8:
+		bits = SST_HSW_DEPTH_8BIT;
+		sst_hsw_stream_set_valid(hsw, pcm_data->stream, 8);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		bits = SST_HSW_DEPTH_32BIT;
 		sst_hsw_stream_set_valid(hsw, pcm_data->stream, 32);
 		break;
 	default:
@@ -710,8 +718,9 @@ static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 }
 
 #define HSW_FORMATS \
-	(SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S16_LE |\
-	 SNDRV_PCM_FMTBIT_S32_LE)
+	(SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S16_LE |\
+	SNDRV_PCM_FMTBIT_S8)
 
 static struct snd_soc_dai_driver hsw_dais[] = {
 	{
@@ -721,7 +730,7 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 			.channels_min = 2,
 			.channels_max = 2,
 			.rates = SNDRV_PCM_RATE_48000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
 		},
 	},
 	{
@@ -752,8 +761,8 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 			.stream_name = "Loopback Capture",
 			.channels_min = 2,
 			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_192000,
-			.formats = HSW_FORMATS,
+			.rates = SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
 		},
 	},
 	{
@@ -762,8 +771,8 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 			.stream_name = "Analog Capture",
 			.channels_min = 2,
 			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_192000,
-			.formats = HSW_FORMATS,
+			.rates = SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
 		},
 	},
 };
-- 
1.8.3.2
