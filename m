From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: add master clock handling for
	rt5640" to the asoc tree
Date: Mon, 22 Feb 2016 20:13:03 +0900
Message-ID: <E1aXoQJ-0006OS-Vh@finisterre>
References: <1456127815-68575-3-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA8E92659CE
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 12:13:12 +0100 (CET)
In-Reply-To: <1456127815-68575-3-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: add master clock handling for rt5640

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6049af00fc2fac8d27f8bd064ff68b16991a80f7 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Mon, 22 Feb 2016 15:56:55 +0800
Subject: [PATCH] ASoC: rt5640: add master clock handling for rt5640

enable/disable master clock when codec is active or not.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5640.txt |  3 +++
 sound/soc/codecs/rt5640.c                          | 31 ++++++++++++++++++++++
 sound/soc/codecs/rt5640.h                          |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
index 9e62f6eb348f..57fe64643050 100644
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
index 11d032cdc658..6cd84fb2196a 100644
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
index 83a7150ddc24..1761c3a98b76 100644
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
2.7.0
