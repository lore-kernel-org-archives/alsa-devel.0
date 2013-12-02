From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ssm2602: Use core for applying symmetry
	constraints
Date: Mon,  2 Dec 2013 21:26:22 +0100
Message-ID: <1386015982-11346-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-110.synserver.de (smtp-out-003.synserver.de
 [212.40.185.3]) by alsa0.perex.cz (Postfix) with ESMTP id 0AF0F264F2C
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 21:25:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Let the core take care of applying sample rate and sample bits constraints
instead of open-coding this in the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c | 50 ++--------------------------------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 480074d..c6dd485 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -53,8 +53,6 @@ enum ssm2602_type {
 struct ssm2602_priv {
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
-	struct snd_pcm_substream *master_substream;
-	struct snd_pcm_substream *slave_substream;
 
 	struct regmap *regmap;
 
@@ -277,11 +275,6 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	int srate = ssm2602_get_coeff(ssm2602->sysclk, params_rate(params));
 	unsigned int iface;
 
-	if (substream == ssm2602->slave_substream) {
-		dev_dbg(codec->dev, "Ignoring hw_params for slave substream\n");
-		return 0;
-	}
-
 	if (srate < 0)
 		return srate;
 
@@ -314,33 +307,6 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-	struct snd_pcm_runtime *master_runtime;
-
-	/* The DAI has shared clocks so if we already have a playback or
-	 * capture going then constrain this substream to match it.
-	 * TODO: the ssm2602 allows pairs of non-matching PB/REC rates
-	 */
-	if (ssm2602->master_substream) {
-		master_runtime = ssm2602->master_substream->runtime;
-		dev_dbg(codec->dev, "Constraining to %d bits at %dHz\n",
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
 
 	if (ssm2602->sysclk_constraints) {
 		snd_pcm_hw_constraint_list(substream->runtime, 0,
@@ -351,19 +317,6 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void ssm2602_shutdown(struct snd_pcm_substream *substream,
-			     struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-
-	if (ssm2602->master_substream == substream)
-		ssm2602->master_substream = ssm2602->slave_substream;
-
-	ssm2602->slave_substream = NULL;
-}
-
-
 static int ssm2602_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(dai->codec);
@@ -530,7 +483,6 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 static const struct snd_soc_dai_ops ssm2602_dai_ops = {
 	.startup	= ssm2602_startup,
 	.hw_params	= ssm2602_hw_params,
-	.shutdown	= ssm2602_shutdown,
 	.digital_mute	= ssm2602_mute,
 	.set_sysclk	= ssm2602_set_dai_sysclk,
 	.set_fmt	= ssm2602_set_dai_fmt,
@@ -551,6 +503,8 @@ static struct snd_soc_dai_driver ssm2602_dai = {
 		.rates = SSM2602_RATES,
 		.formats = SSM2602_FORMATS,},
 	.ops = &ssm2602_dai_ops,
+	.symmetric_rates = 1,
+	.symmetric_samplebits = 1,
 };
 
 static int ssm2602_suspend(struct snd_soc_codec *codec)
-- 
1.8.0
