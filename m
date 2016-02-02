From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v5 7/8] ASoC: rt5616: add the mclk for the codec driver
Date: Tue,  2 Feb 2016 11:44:40 +0800
Message-ID: <1454384680-7197-3-git-send-email-wxt@rock-chips.com>
References: <1454384032-6794-1-git-send-email-wxt@rock-chips.com>
 <1454384680-7197-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454384680-7197-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, bardliao@realtek.com
Cc: alsa-devel@alsa-project.org, oder_chiou@realtek.com, robh+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, keescook@google.com, linux-kernel@vger.kernel.org, jeffy.chen@rock-chips.com, leozwang@google.com, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the code to enable the clock to the CODEC driver
if it needs the clock enabled.

In some case, We need to claim the clock which is driving the codec
so that when we enable clock gating, we continue to clock the codec
when needed.

We can enable and disable the clock source if mclk provided.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc:  alsa-devel@alsa-project.org
Cc:  Mark Brown <broonie@kernel.org>
Cc:  Bard Liao <bardliao@realtek.com>

---

Changes in v5:
- Cc related alsa experts.

Changes in v4:
- AS the previous discussed by them, add the mclk for codec.
  (https://patchwork.kernel.org/patch/8041001/)

 sound/soc/codecs/rt5616.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index d4bdf9f..fdca636 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
@@ -144,6 +145,7 @@ struct rt5616_priv {
 	struct snd_soc_codec *codec;
 	struct delayed_work patch_work;
 	struct regmap *regmap;
+	struct clk *mclk;
 
 	int sysclk;
 	int sysclk_src;
@@ -1159,7 +1161,34 @@ static int rt5616_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 static int rt5616_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct rt5616_priv *rt5616 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
 	switch (level) {
+
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
+		if (IS_ERR(rt5616->mclk))
+			break;
+
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
+			clk_disable_unprepare(rt5616->mclk);
+		} else {
+			ret = clk_prepare_enable(rt5616->mclk);
+			if (ret)
+				return ret;
+		}
+		break;
+
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			snd_soc_update_bits(codec, RT5616_PWR_ANLG1,
@@ -1198,6 +1227,11 @@ static int rt5616_probe(struct snd_soc_codec *codec)
 {
 	struct rt5616_priv *rt5616 = snd_soc_codec_get_drvdata(codec);
 
+	/* Check if MCLK provided */
+	rt5616->mclk = devm_clk_get(codec->dev, "mclk");
+	if (PTR_ERR(rt5616->mclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	rt5616->codec = codec;
 
 	return 0;
-- 
1.9.1
