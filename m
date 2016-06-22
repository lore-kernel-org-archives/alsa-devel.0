From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Add the MCLK handling" to the
	asoc tree
Date: Wed, 22 Jun 2016 16:28:38 +0100
Message-ID: <E1bFk50-0002Iu-Pb@debutante>
References: <1466132544-22916-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D7D7266A12
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 17:28:46 +0200 (CEST)
In-Reply-To: <1466132544-22916-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Add the MCLK handling

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

>From c9506bb84b62917ae88087545ccb756d35655397 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Fri, 17 Jun 2016 11:02:24 +0800
Subject: [PATCH] ASoC: rt5514: Add the MCLK handling

The patch adds the control of MCLK that depends on the status of DAPM.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5514.txt |  5 ++++
 sound/soc/codecs/rt5514.c                          | 32 ++++++++++++++++++++++
 sound/soc/codecs/rt5514.h                          |  3 ++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
index e24436fc5ea9..9cabfc18cb57 100644
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
index 879bf60f4965..e6ae2309e5f8 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -799,10 +799,41 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
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
@@ -858,6 +889,7 @@ struct snd_soc_dai_driver rt5514_dai[] = {
 static struct snd_soc_codec_driver soc_codec_dev_rt5514 = {
 	.probe = rt5514_probe,
 	.idle_bias_off = true,
+	.set_bias_level = rt5514_set_bias_level,
 	.controls = rt5514_snd_controls,
 	.num_controls = ARRAY_SIZE(rt5514_snd_controls),
 	.dapm_widgets = rt5514_dapm_widgets,
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 6ad8a612f659..766f5a666ebe 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -12,6 +12,8 @@
 #ifndef __RT5514_H__
 #define __RT5514_H__
 
+#include <linux/clk.h>
+
 #define RT5514_DEVICE_ID			0x10ec5514
 
 #define RT5514_RESET				0x2000
@@ -240,6 +242,7 @@ enum {
 struct rt5514_priv {
 	struct snd_soc_codec *codec;
 	struct regmap *i2c_regmap, *regmap;
+	struct clk *mclk;
 	int sysclk;
 	int sysclk_src;
 	int lrck;
-- 
2.8.1
