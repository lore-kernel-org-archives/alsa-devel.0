From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/47] ASoC: arizona: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:10:24 +0200
Message-ID: <1433146266-1599-5-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 713DC260504
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:14 +0200 (CEST)
In-Reply-To: <1433146266-1599-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to codec->dapm
with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/arizona.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index eff4b4d..0cb2962 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -208,11 +208,12 @@ static const struct snd_soc_dapm_widget arizona_spkr =
 
 int arizona_init_spk(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona *arizona = priv->arizona;
 	int ret;
 
-	ret = snd_soc_dapm_new_controls(&codec->dapm, &arizona_spkl, 1);
+	ret = snd_soc_dapm_new_controls(dapm, &arizona_spkl, 1);
 	if (ret != 0)
 		return ret;
 
@@ -220,8 +221,7 @@ int arizona_init_spk(struct snd_soc_codec *codec)
 	case WM8997:
 		break;
 	default:
-		ret = snd_soc_dapm_new_controls(&codec->dapm,
-						&arizona_spkr, 1);
+		ret = snd_soc_dapm_new_controls(dapm, &arizona_spkr, 1);
 		if (ret != 0)
 			return ret;
 		break;
@@ -258,13 +258,14 @@ static const struct snd_soc_dapm_route arizona_mono_routes[] = {
 
 int arizona_init_mono(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona *arizona = priv->arizona;
 	int i;
 
 	for (i = 0; i < ARIZONA_MAX_OUTPUT; ++i) {
 		if (arizona->pdata.out_mono[i])
-			snd_soc_dapm_add_routes(&codec->dapm,
+			snd_soc_dapm_add_routes(dapm,
 						&arizona_mono_routes[i], 1);
 	}
 
@@ -274,6 +275,7 @@ EXPORT_SYMBOL_GPL(arizona_init_mono);
 
 int arizona_init_gpio(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona *arizona = priv->arizona;
 	int i;
@@ -281,23 +283,21 @@ int arizona_init_gpio(struct snd_soc_codec *codec)
 	switch (arizona->type) {
 	case WM5110:
 	case WM8280:
-		snd_soc_dapm_disable_pin(&codec->dapm, "DRC2 Signal Activity");
+		snd_soc_dapm_disable_pin(dapm, "DRC2 Signal Activity");
 		break;
 	default:
 		break;
 	}
 
-	snd_soc_dapm_disable_pin(&codec->dapm, "DRC1 Signal Activity");
+	snd_soc_dapm_disable_pin(dapm, "DRC1 Signal Activity");
 
 	for (i = 0; i < ARRAY_SIZE(arizona->pdata.gpio_defaults); i++) {
 		switch (arizona->pdata.gpio_defaults[i] & ARIZONA_GPN_FN_MASK) {
 		case ARIZONA_GP_FN_DRC1_SIGNAL_DETECT:
-			snd_soc_dapm_enable_pin(&codec->dapm,
-						"DRC1 Signal Activity");
+			snd_soc_dapm_enable_pin(dapm, "DRC1 Signal Activity");
 			break;
 		case ARIZONA_GP_FN_DRC2_SIGNAL_DETECT:
-			snd_soc_dapm_enable_pin(&codec->dapm,
-						"DRC2 Signal Activity");
+			snd_soc_dapm_enable_pin(dapm, "DRC2 Signal Activity");
 			break;
 		default:
 			break;
@@ -1474,6 +1474,7 @@ static int arizona_dai_set_sysclk(struct snd_soc_dai *dai,
 				  int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
 	struct snd_soc_dapm_route routes[2];
@@ -1504,15 +1505,15 @@ static int arizona_dai_set_sysclk(struct snd_soc_dai *dai,
 
 	routes[0].source = arizona_dai_clk_str(dai_priv->clk);
 	routes[1].source = arizona_dai_clk_str(dai_priv->clk);
-	snd_soc_dapm_del_routes(&codec->dapm, routes, ARRAY_SIZE(routes));
+	snd_soc_dapm_del_routes(dapm, routes, ARRAY_SIZE(routes));
 
 	routes[0].source = arizona_dai_clk_str(clk_id);
 	routes[1].source = arizona_dai_clk_str(clk_id);
-	snd_soc_dapm_add_routes(&codec->dapm, routes, ARRAY_SIZE(routes));
+	snd_soc_dapm_add_routes(dapm, routes, ARRAY_SIZE(routes));
 
 	dai_priv->clk = clk_id;
 
-	return snd_soc_dapm_sync(&codec->dapm);
+	return snd_soc_dapm_sync(dapm);
 }
 
 static int arizona_set_tristate(struct snd_soc_dai *dai, int tristate)
-- 
2.1.4
