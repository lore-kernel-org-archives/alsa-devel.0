From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 3/3] ASoC: Blackfin: fix bug - kernel will
	crash when record and play in bf527-ezkit
Date: Fri,  6 Feb 2009 18:12:36 +0800
Message-ID: <1233915156-17985-4-git-send-email-cooloney@kernel.org>
References: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E1991037EE
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 11:10:44 +0100 (CET)
In-Reply-To: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

set constraint only if the value is not 0, change the configuring way for sport

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |   25 ++++---------------------
 sound/soc/codecs/ssm2602.c     |   29 ++++++++++++++---------------
 2 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index d1d95d2..29cd5a4 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -49,7 +49,7 @@ struct bf5xx_i2s_port {
 	u16 rcr1;
 	u16 tcr2;
 	u16 rcr2;
-	int counter;
+	int configured;
 };
 
 static struct bf5xx_i2s_port bf5xx_i2s;
@@ -132,16 +132,6 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	return ret;
 }
 
-static int bf5xx_i2s_startup(struct snd_pcm_substream *substream,
-			     struct snd_soc_dai *dai)
-{
-	pr_debug("%s enter\n", __func__);
-
-	/*this counter is used for counting how many pcm streams are opened*/
-	bf5xx_i2s.counter++;
-	return 0;
-}
-
 static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -168,7 +158,7 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	if (bf5xx_i2s.counter == 1) {
+	if (!bf5xx_i2s.configured) {
 		/*
 		 * TX and RX are not independent,they are enabled at the
 		 * same time, even if only one side is running. So, we
@@ -195,13 +185,6 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	pr_debug("%s enter\n", __func__);
-	bf5xx_i2s.counter--;
-}
-
 static int bf5xx_i2s_probe(struct platform_device *pdev,
 			   struct snd_soc_dai *dai)
 {
@@ -219,6 +202,8 @@ static int bf5xx_i2s_probe(struct platform_device *pdev,
 		return -ENODEV;
 	}
 
+	bf5xx_i2s.configured = 1;
+
 	return 0;
 }
 
@@ -305,8 +290,6 @@ struct snd_soc_dai bf5xx_i2s_dai = {
 		.rates = BF5XX_I2S_RATES,
 		.formats = BF5XX_I2S_FORMATS,},
 	.ops = {
-		.startup   = bf5xx_i2s_startup,
-		.shutdown  = bf5xx_i2s_shutdown,
 		.hw_params = bf5xx_i2s_hw_params,
 		.set_fmt = bf5xx_i2s_set_dai_fmt,
 	},
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index cac3736..3fdba6a 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -49,8 +49,8 @@ struct snd_soc_codec_device soc_codec_dev_ssm2602;
 /* codec private data */
 struct ssm2602_priv {
 	unsigned int sysclk;
-	struct snd_pcm_substream *master_substream;
-	struct snd_pcm_substream *slave_substream;
+	unsigned int master_rate;
+	unsigned int master_sample_bits;
 };
 
 /*
@@ -339,31 +339,30 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = socdev->codec;
 	struct ssm2602_priv *ssm2602 = codec->private_data;
 	struct i2c_client *i2c = codec->control_data;
-	struct snd_pcm_runtime *master_runtime;
 
 	/* The DAI has shared clocks so if we already have a playback or
 	 * capture going then constrain this substream to match it.
 	 * TODO: the ssm2602 allows pairs of non-matching PB/REC rates
 	 */
-	if (ssm2602->master_substream) {
-		master_runtime = ssm2602->master_substream->runtime;
+	if (ssm2602->master_rate) {
 		dev_dbg(&i2c->dev, "Constraining to %d bits at %dHz\n",
-			master_runtime->sample_bits,
-			master_runtime->rate);
+			ssm2602->master_sample_bits,
+			ssm2602->master_rate);
 
 		snd_pcm_hw_constraint_minmax(substream->runtime,
 					     SNDRV_PCM_HW_PARAM_RATE,
-					     master_runtime->rate,
-					     master_runtime->rate);
-
+ 					     ssm2602->master_rate,
+ 					     ssm2602->master_rate);
+ 	} else
+ 		ssm2602->master_rate = substream->runtime->rate;
+  
+ 	if (ssm2602->master_sample_bits) {
 		snd_pcm_hw_constraint_minmax(substream->runtime,
 					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-					     master_runtime->sample_bits,
-					     master_runtime->sample_bits);
-
-		ssm2602->slave_substream = substream;
+ 					     ssm2602->master_sample_bits,
+ 					     ssm2602->master_sample_bits);
 	} else
-		ssm2602->master_substream = substream;
+ 		ssm2602->master_sample_bits = substream->runtime->sample_bits;
 
 	return 0;
 }
-- 
1.5.6.3
