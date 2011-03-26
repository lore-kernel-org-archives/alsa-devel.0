From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/2] ASoC: SSM2602: drop rate and sample bits
	constraints
Date: Sat, 26 Mar 2011 03:28:58 -0400
Message-ID: <1301124539-527-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 47C5524476
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 08:28:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ssm2602.c |   53 --------------------------------------------
 1 files changed, 0 insertions(+), 53 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 2727bef..70a33414 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -49,8 +49,6 @@ struct ssm2602_priv {
 	unsigned int sysclk;
 	enum snd_soc_control_type control_type;
 	void *control_data;
-	struct snd_pcm_substream *master_substream;
-	struct snd_pcm_substream *slave_substream;
 };
 
 /*
@@ -278,15 +276,9 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = codec->control_data;
 	u16 iface = ssm2602_read_reg_cache(codec, SSM2602_IFACE) & 0xfff3;
 	int i = get_coeff(ssm2602->sysclk, params_rate(params));
 
-	if (substream == ssm2602->slave_substream) {
-		dev_dbg(&i2c->dev, "Ignoring hw_params for slave substream\n");
-		return 0;
-	}
-
 	/*no match is found*/
 	if (i == ARRAY_SIZE(coeff_div))
 		return -EINVAL;
@@ -316,44 +308,6 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int ssm2602_startup(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = codec->control_data;
-	struct snd_pcm_runtime *master_runtime;
-
-	/* The DAI has shared clocks so if we already have a playback or
-	 * capture going then constrain this substream to match it.
-	 * TODO: the ssm2602 allows pairs of non-matching PB/REC rates
-	 */
-	if (ssm2602->master_substream) {
-		master_runtime = ssm2602->master_substream->runtime;
-		dev_dbg(&i2c->dev, "Constraining to %d bits at %dHz\n",
-			master_runtime->sample_bits,
-			master_runtime->rate);
-
-		if (master_runtime->rate != 0)
-			snd_pcm_hw_constraint_minmax(substream->runtime,
-						     SNDRV_PCM_HW_PARAM_RATE,
-						     master_runtime->rate,
-						     master_runtime->rate);
-
-		if (master_runtime->sample_bits != 0)
-			snd_pcm_hw_constraint_minmax(substream->runtime,
-						     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-						     master_runtime->sample_bits,
-						     master_runtime->sample_bits);
-
-		ssm2602->slave_substream = substream;
-	} else
-		ssm2602->master_substream = substream;
-
-	return 0;
-}
-
 static int ssm2602_pcm_prepare(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
@@ -370,16 +324,10 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 
 	/* deactivate */
 	if (!codec->active)
 		ssm2602_write(codec, SSM2602_ACTIVE, 0);
-
-	if (ssm2602->master_substream == substream)
-		ssm2602->master_substream = ssm2602->slave_substream;
-
-	ssm2602->slave_substream = NULL;
 }
 
 static int ssm2602_mute(struct snd_soc_dai *dai, int mute)
@@ -505,7 +453,6 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_ops ssm2602_dai_ops = {
-	.startup	= ssm2602_startup,
 	.prepare	= ssm2602_pcm_prepare,
 	.hw_params	= ssm2602_hw_params,
 	.shutdown	= ssm2602_shutdown,
-- 
1.7.4.1
