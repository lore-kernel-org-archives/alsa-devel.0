From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: wm8400: Use regmap for I/O
Date: Sat, 31 Aug 2013 13:22:35 +0100
Message-ID: <1377951755-27028-2-git-send-email-broonie@kernel.org>
References: <1377951755-27028-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 82EA4261A06
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 14:22:49 +0200 (CEST)
In-Reply-To: <1377951755-27028-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since we no longer have a fake register to simulate we can use the
framework for I/O.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8400.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 95c33d1..48dc7d2 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -67,25 +67,6 @@ struct wm8400_priv {
 	int fll_in, fll_out;
 };
 
-static inline unsigned int wm8400_read(struct snd_soc_codec *codec,
-				       unsigned int reg)
-{
-	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
-
-	return wm8400_reg_read(wm8400->wm8400, reg);
-}
-
-/*
- * write to the wm8400 register space
- */
-static int wm8400_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
-
-	return wm8400_set_bits(wm8400->wm8400, reg, 0xffff, value);
-}
-
 static void wm8400_codec_reset(struct snd_soc_codec *codec)
 {
 	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
@@ -1328,9 +1309,12 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 		return -ENOMEM;
 
 	snd_soc_codec_set_drvdata(codec, priv);
-	codec->control_data = priv->wm8400 = wm8400;
+	priv->wm8400 = wm8400;
+	codec->control_data = wm8400->regmap;
 	priv->codec = codec;
 
+	snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
+
 	ret = devm_regulator_bulk_get(wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
 	if (ret != 0) {
@@ -1377,8 +1361,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 	.remove =	wm8400_codec_remove,
 	.suspend =	wm8400_suspend,
 	.resume =	wm8400_resume,
-	.read = snd_soc_read,
-	.write = wm8400_write,
 	.set_bias_level = wm8400_set_bias_level,
 
 	.controls = wm8400_snd_controls,
-- 
1.8.4.rc3
