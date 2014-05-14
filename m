From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/6] ASoC: ak4642: Add support for extended
	sysclk frequencies of the ak4648
Date: Wed, 14 May 2014 09:37:36 +0200
Message-ID: <1400053058-1115-5-git-send-email-s.hauer@pengutronix.de>
References: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 785AB261A0A
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 09:37:42 +0200 (CEST)
In-Reply-To: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Additionally to the ak4642 pll frequencies the ak4648 also supports 13MHz,
19.2MHz and 26MHz. This adds support for these frequencies.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/ak4642.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index b568692..3ba4c0f 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -136,6 +136,7 @@
 
 struct ak4642_drvdata {
 	const struct regmap_config *regmap_config;
+	int extended_frequencies;
 };
 
 struct ak4642_priv {
@@ -297,7 +298,9 @@ static int ak4642_dai_set_sysclk(struct snd_soc_dai *codec_dai,
 	int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
 	u8 pll;
+	int extended_freq = 0;
 
 	switch (freq) {
 	case 11289600:
@@ -318,9 +321,25 @@ static int ak4642_dai_set_sysclk(struct snd_soc_dai *codec_dai,
 	case 27000000:
 		pll = PLL3 | PLL2 | PLL0;
 		break;
+	case 19200000:
+		pll = PLL3;
+		extended_freq = 1;
+		break;
+	case 13000000:
+		pll = PLL3 | PLL2 | PLL1;
+		extended_freq = 1;
+		break;
+	case 26000000:
+		pll = PLL3 | PLL2 | PLL1 | PLL0;
+		extended_freq = 1;
+		break;
 	default:
 		return -EINVAL;
 	}
+
+	if (extended_freq && !priv->drvdata->extended_frequencies)
+		return -EINVAL;
+
 	snd_soc_update_bits(codec, MD_CTL1, PLL_MASK, pll);
 
 	return 0;
@@ -525,6 +544,7 @@ static const struct ak4642_drvdata ak4643_drvdata = {
 
 static const struct ak4642_drvdata ak4648_drvdata = {
 	.regmap_config = &ak4648_regmap,
+	.extended_frequencies = 1,
 };
 
 static struct of_device_id ak4642_of_match[];
-- 
2.0.0.rc0
