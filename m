From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Check clocking during hw_params
	rather than startup
Date: Fri, 24 Jan 2014 16:59:13 +0000
Message-ID: <1390582753-1026-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 406AC265372
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 18:07:29 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

It is a fairly common usage to configure SYSCLK as part of the hw_params
callback in the machine driver. The current driver applies PCM
constraints based on the value of SYSCLK during the startup callback
however because many systems will have not configured SYSCLK yet this
will often use the SYSCLK value that was used for the last stream.

The patch checks the clocking constraints as part of the hw_params
callback, which will be after any clocking changes have been made by
the machine driver.

Change-Id: I48e16256e9ed4df2f4ef1350c356b8b331d288bf
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   79 +++++++------------------------------------
 1 files changed, 13 insertions(+), 66 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e4295fe..ae5031b 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -990,29 +990,6 @@ static const int arizona_48k_bclk_rates[] = {
 	24576000,
 };
 
-static const unsigned int arizona_48k_rates[] = {
-	12000,
-	24000,
-	48000,
-	96000,
-	192000,
-	384000,
-	768000,
-	4000,
-	8000,
-	16000,
-	32000,
-	64000,
-	128000,
-	256000,
-	512000,
-};
-
-static const struct snd_pcm_hw_constraint_list arizona_48k_constraint = {
-	.count	= ARRAY_SIZE(arizona_48k_rates),
-	.list	= arizona_48k_rates,
-};
-
 static const int arizona_44k1_bclk_rates[] = {
 	-1,
 	44100,
@@ -1035,21 +1012,6 @@ static const int arizona_44k1_bclk_rates[] = {
 	22579200,
 };
 
-static const unsigned int arizona_44k1_rates[] = {
-	11025,
-	22050,
-	44100,
-	88200,
-	176400,
-	352800,
-	705600,
-};
-
-static const struct snd_pcm_hw_constraint_list arizona_44k1_constraint = {
-	.count	= ARRAY_SIZE(arizona_44k1_rates),
-	.list	= arizona_44k1_rates,
-};
-
 static int arizona_sr_vals[] = {
 	0,
 	12000,
@@ -1077,13 +1039,15 @@ static int arizona_sr_vals[] = {
 	512000,
 };
 
-static int arizona_startup(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *dai)
+static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
-	const struct snd_pcm_hw_constraint_list *constraint;
+	int base = dai->driver->base;
+	int i, sr_val;
 	unsigned int base_rate;
 
 	switch (dai_priv->clk) {
@@ -1094,31 +1058,16 @@ static int arizona_startup(struct snd_pcm_substream *substream,
 		base_rate = priv->asyncclk;
 		break;
 	default:
-		return 0;
+		arizona_aif_err(dai, "Unknown clock: %d\n", dai_priv->clk);
+		return -EINVAL;
 	}
 
-	if (base_rate == 0)
-		return 0;
-
-	if (base_rate % 8000)
-		constraint = &arizona_44k1_constraint;
-	else
-		constraint = &arizona_48k_constraint;
-
-	return snd_pcm_hw_constraint_list(substream->runtime, 0,
-					  SNDRV_PCM_HW_PARAM_RATE,
-					  constraint);
-}
-
-static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *params,
-				  struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
-	int base = dai->driver->base;
-	int i, sr_val;
+	if (!!(base_rate % 8000) != !!(params_rate(params) % 8000)) {
+		arizona_aif_err(dai,
+				"Rate %dHz not supported off %dHz clock\n",
+				params_rate(params), base_rate);
+		return -EINVAL;
+	}
 
 	/*
 	 * We will need to be more flexible than this in future,
@@ -1308,7 +1257,6 @@ static int arizona_set_tristate(struct snd_soc_dai *dai, int tristate)
 }
 
 const struct snd_soc_dai_ops arizona_dai_ops = {
-	.startup = arizona_startup,
 	.set_fmt = arizona_set_fmt,
 	.hw_params = arizona_hw_params,
 	.set_sysclk = arizona_dai_set_sysclk,
@@ -1317,7 +1265,6 @@ const struct snd_soc_dai_ops arizona_dai_ops = {
 EXPORT_SYMBOL_GPL(arizona_dai_ops);
 
 const struct snd_soc_dai_ops arizona_simple_dai_ops = {
-	.startup = arizona_startup,
 	.hw_params = arizona_hw_params_rate,
 	.set_sysclk = arizona_dai_set_sysclk,
 };
-- 
1.7.2.5
