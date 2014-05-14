From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Only export one Baytrail DAI
Date: Wed, 14 May 2014 17:20:54 +0300
Message-ID: <1400077254-31465-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400077254-31465-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id D58FD261B03
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 16:21:12 +0200 (CEST)
In-Reply-To: <1400077254-31465-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

We don't need more than one DAI for Baytrail SST. Usage becomes also more
straightforward by grouping playback and capture streams under the same PCM
device.

[Jarkko: I made Liam's sst-baytrail-pcm.c change a few lines smaller and
squashed together with my byt-rt5640.c change]

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c       | 14 +-------------
 sound/soc/intel/sst-baytrail-pcm.c |  7 ++-----
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index 9061616f0f45..dbc63d09f424 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -117,7 +117,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 	{
 		.name = "Baytrail Audio",
 		.stream_name = "Audio",
-		.cpu_dai_name = "Front-cpu-dai",
+		.cpu_dai_name = "baytrail-pcm-audio",
 		.codec_dai_name = "rt5640-aif1",
 		.codec_name = "i2c-10EC5640:00",
 		.platform_name = "baytrail-pcm-audio",
@@ -126,18 +126,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.init = byt_rt5640_init,
 		.ops = &byt_rt5640_ops,
 	},
-	{
-		.name = "Baytrail Voice",
-		.stream_name = "Voice",
-		.cpu_dai_name = "Mic1-cpu-dai",
-		.codec_dai_name = "rt5640-aif1",
-		.codec_name = "i2c-10EC5640:00",
-		.platform_name = "baytrail-pcm-audio",
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			   SND_SOC_DAIFMT_CBS_CFS,
-		.init = NULL,
-		.ops = &byt_rt5640_ops,
-	},
 };
 
 static struct snd_soc_card byt_rt5640_card = {
diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 73bb68119b9e..23a25c0627bd 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -342,7 +342,7 @@ static int sst_byt_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 static struct snd_soc_dai_driver byt_dais[] = {
 	{
-		.name  = "Front-cpu-dai",
+		.name  = "Baytrail PCM",
 		.playback = {
 			.stream_name = "System Playback",
 			.channels_min = 2,
@@ -351,9 +351,6 @@ static struct snd_soc_dai_driver byt_dais[] = {
 			.formats = SNDRV_PCM_FMTBIT_S24_3LE |
 				   SNDRV_PCM_FMTBIT_S16_LE,
 		},
-	},
-	{
-		.name  = "Mic1-cpu-dai",
 		.capture = {
 			.stream_name = "Analog Capture",
 			.channels_min = 2,
@@ -378,7 +375,7 @@ static int sst_byt_pcm_probe(struct snd_soc_platform *platform)
 	priv_data->byt = plat_data->dsp;
 	snd_soc_platform_set_drvdata(platform, priv_data);
 
-	for (i = 0; i < ARRAY_SIZE(byt_dais); i++) {
+	for (i = 0; i < BYT_PCM_COUNT; i++) {
 		mutex_init(&priv_data->pcm[i].mutex);
 		INIT_WORK(&priv_data->pcm[i].work, sst_byt_pcm_work);
 	}
-- 
2.0.0.rc0
