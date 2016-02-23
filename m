From: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] ASoC: rt5640: add master clock handling for rt5640
Date: Tue, 23 Feb 2016 09:26:22 +0800
Message-ID: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

enable/disable master clock when codec is active or not.

Signed-off-by: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 Documentation/devicetree/bindings/sound/rt5640.txt |  3 +++
 sound/soc/codecs/rt5640.c                          | 31 ++++++++++++++++++++++
 sound/soc/codecs/rt5640.h                          |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
index 9e62f6e..57fe646 100644
--- a/Documentation/devicetree/bindings/sound/rt5640.txt
+++ b/Documentation/devicetree/bindings/sound/rt5640.txt
@@ -12,6 +12,9 @@ Required properties:
 
 Optional properties:
 
+- clocks: The phandle of the master clock to the CODEC
+- clock-names: Should be "mclk"
+
 - realtek,in1-differential
 - realtek,in2-differential
 - realtek,in3-differential
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 11d032c..6cd84fb 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1949,7 +1949,33 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
 	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		/*
+		 * SND_SOC_BIAS_PREPARE is called while preparing for a
+		 * transition to ON or away from ON. If current bias_level
+		 * is SND_SOC_BIAS_ON, then it is preparing for a transition
+		 * away from ON. Disable the clock in that case, otherwise
+		 * enable it.
+		 */
+		if (IS_ERR(rt5640->mclk))
+			break;
+
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
+			clk_disable_unprepare(rt5640->mclk);
+		} else {
+			ret = clk_prepare_enable(rt5640->mclk);
+			if (ret)
+				return ret;
+		}
+		break;
+
 	case SND_SOC_BIAS_STANDBY:
 		if (SND_SOC_BIAS_OFF == snd_soc_codec_get_bias_level(codec)) {
 			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
@@ -2088,6 +2114,11 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 
+	/* Check if MCLK provided */
+	rt5640->mclk = devm_clk_get(codec->dev, "mclk");
+	if (PTR_ERR(rt5640->mclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	rt5640->codec = codec;
 
 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 83a7150..1761c3a9 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -12,6 +12,7 @@
 #ifndef _RT5640_H
 #define _RT5640_H
 
+#include <linux/clk.h>
 #include <sound/rt5640.h>
 
 /* Info */
@@ -2097,6 +2098,7 @@ struct rt5640_priv {
 	struct snd_soc_codec *codec;
 	struct rt5640_platform_data pdata;
 	struct regmap *regmap;
+	struct clk *mclk;
 
 	int sysclk;
 	int sysclk_src;
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
