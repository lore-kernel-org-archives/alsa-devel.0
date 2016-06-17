From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5514: Add the MCLK handling
Date: Fri, 17 Jun 2016 11:02:24 +0800
Message-ID: <1466132544-22916-2-git-send-email-oder_chiou@realtek.com>
References: <1466132544-22916-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E3892657F4
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 05:02:34 +0200 (CEST)
In-Reply-To: <1466132544-22916-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the control of MCLK that depends on the status of DAPM.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5514.txt |  5 ++++
 sound/soc/codecs/rt5514.c                          | 32 ++++++++++++++++++++++
 sound/soc/codecs/rt5514.h                          |  3 ++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
index e24436f..9cabfc1 100644
--- a/Documentation/devicetree/bindings/sound/rt5514.txt
+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
@@ -8,6 +8,11 @@ Required properties:
 
 - reg : The I2C address of the device.
 
+Optional properties:
+
+- clocks: The phandle of the master clock to the CODEC
+- clock-names: Should be "mclk"
+
 Pins on the device (for linking into audio routes) for RT5514:
 
   * DMIC1L
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index ecb0989..7162f05 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -932,10 +932,41 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	return 0;
 }
 
+static int rt5514_set_bias_level(struct snd_soc_codec *codec,
+			enum snd_soc_bias_level level)
+{
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (IS_ERR(rt5514->mclk))
+			break;
+
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
+			clk_disable_unprepare(rt5514->mclk);
+		} else {
+			ret = clk_prepare_enable(rt5514->mclk);
+			if (ret)
+				return ret;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int rt5514_probe(struct snd_soc_codec *codec)
 {
 	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
 
+	rt5514->mclk = devm_clk_get(codec->dev, "mclk");
+	if (PTR_ERR(rt5514->mclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	rt5514->codec = codec;
 
 	return 0;
@@ -991,6 +1022,7 @@ struct snd_soc_dai_driver rt5514_dai[] = {
 static struct snd_soc_codec_driver soc_codec_dev_rt5514 = {
 	.probe = rt5514_probe,
 	.idle_bias_off = true,
+	.set_bias_level = rt5514_set_bias_level,
 	.controls = rt5514_snd_controls,
 	.num_controls = ARRAY_SIZE(rt5514_snd_controls),
 	.dapm_widgets = rt5514_dapm_widgets,
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 6e89e7d..68883c6 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -12,6 +12,8 @@
 #ifndef __RT5514_H__
 #define __RT5514_H__
 
+#include <linux/clk.h>
+
 #define RT5514_DEVICE_ID			0x10ec5514
 
 #define RT5514_RESET				0x2000
@@ -243,6 +245,7 @@ enum {
 struct rt5514_priv {
 	struct snd_soc_codec *codec;
 	struct regmap *i2c_regmap, *regmap;
+	struct clk *mclk;
 	int sysclk;
 	int sysclk_src;
 	int lrck;
-- 
1.8.1.1.439.g50a6b54
