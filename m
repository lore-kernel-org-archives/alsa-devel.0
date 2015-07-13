From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: uda134x: Use regmap_update_bits()
	were appropriate
Date: Mon, 13 Jul 2015 12:26:48 +0200
Message-ID: <1436783208-1529-5-git-send-email-lars@metafoo.de>
References: <1436783208-1529-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-236.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id F0CF32604D6
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 12:27:00 +0200 (CEST)
In-Reply-To: <1436783208-1529-1-git-send-email-lars@metafoo.de>
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

Instead of doing the read-modify-update cycle by hand when updating a
register use regmap_update_bits().

This also means we can now remove uda134x_read_reg_cache() and
uda134x_write() since they are unused.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/uda134x.c | 57 ++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index d25a9f3..e190263 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -61,31 +61,6 @@ static const struct reg_default uda134x_reg_defaults[] = {
 };
 
 /*
- * The codec has no support for reading its registers except for peak level...
- */
-static inline unsigned int uda134x_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(uda134x->regmap, reg, &val);
-	if (ret)
-		return -1;
-
-	return val;
-}
-
-static void uda134x_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int val)
-{
-	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
-
-	regmap_write(uda134x->regmap, reg, val);
-}
-
-/*
  * Write to the uda134x registers
  *
  */
@@ -137,27 +112,28 @@ static int uda134x_regmap_write(void *context, unsigned int reg,
 
 static inline void uda134x_reset(struct snd_soc_codec *codec)
 {
-	u8 reset_reg = uda134x_read_reg_cache(codec, UDA134X_STATUS0);
-	uda134x_write(codec, UDA134X_STATUS0, reset_reg | (1<<6));
+	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
+	unsigned int mask = 1<<6;
+
+	regmap_update_bits(uda134x->regmap, UDA134X_STATUS0, mask, mask);
 	msleep(1);
-	uda134x_write(codec, UDA134X_STATUS0, reset_reg & ~(1<<6));
+	regmap_update_bits(uda134x->regmap, UDA134X_STATUS0, mask, 0);
 }
 
 static int uda134x_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u8 mute_reg = uda134x_read_reg_cache(codec, UDA134X_DATA010);
+	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(dai->codec);
+	unsigned int mask = 1<<2;
+	unsigned int val;
 
 	pr_debug("%s mute: %d\n", __func__, mute);
 
 	if (mute)
-		mute_reg |= (1<<2);
+		val = mask;
 	else
-		mute_reg &= ~(1<<2);
-
-	uda134x_write(codec, UDA134X_DATA010, mute_reg);
+		val = 0;
 
-	return 0;
+	return regmap_update_bits(uda134x->regmap, UDA134X_DATA010, mask, val);
 }
 
 static int uda134x_startup(struct snd_pcm_substream *substream,
@@ -209,7 +185,7 @@ static int uda134x_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
-	u8 hw_params;
+	unsigned int hw_params = 0;
 
 	if (substream == uda134x->slave_substream) {
 		pr_debug("%s ignoring hw_params for slave substream\n",
@@ -217,10 +193,6 @@ static int uda134x_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
-	hw_params = uda134x_read_reg_cache(codec, UDA134X_STATUS0);
-	hw_params &= STATUS0_SYSCLK_MASK;
-	hw_params &= STATUS0_DAIFMT_MASK;
-
 	pr_debug("%s sysclk: %d, rate:%d\n", __func__,
 		 uda134x->sysclk, params_rate(params));
 
@@ -271,9 +243,8 @@ static int uda134x_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	uda134x_write(codec, UDA134X_STATUS0, hw_params);
-
-	return 0;
+	return regmap_update_bits(uda134x->regmap, UDA134X_STATUS0,
+		STATUS0_SYSCLK_MASK | STATUS0_DAIFMT_MASK, hw_params);
 }
 
 static int uda134x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-- 
2.1.4
