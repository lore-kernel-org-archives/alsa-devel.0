From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2 2/3] ASoC: es8316: Add clock control of MCLK
Date: Sun,  1 Sep 2019 01:26:49 +0900
Message-ID: <20190831162650.19822-2-katsuhiro@katsuster.net>
References: <20190831162650.19822-1-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831162650.19822-1-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>
List-Id: alsa-devel@alsa-project.org

This patch introduce clock property for MCLK master freq control.
Driver will set rate of MCLK master if set_sysclk is called and
changing sysclk by board driver.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

---

Changes from v1:
  - Output logs if clock error is found
  - Disable and unprepare mclk when remove this driver
---
 sound/soc/codecs/es8316.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 229808fa627c..ab41f2c056bd 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -33,6 +34,7 @@ static const unsigned int supported_mclk_lrck_ratios[] = {
 
 struct es8316_priv {
 	struct mutex lock;
+	struct clk *mclk;
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	struct snd_soc_jack *jack;
@@ -363,12 +365,19 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_component *component = codec_dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	es8316->sysclk = freq;
 
 	if (freq == 0)
 		return 0;
 
+	if (es8316->mclk) {
+		ret = clk_set_rate(es8316->mclk, freq);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -693,9 +702,26 @@ static int es8316_set_jack(struct snd_soc_component *component,
 static int es8316_probe(struct snd_soc_component *component)
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	es8316->component = component;
 
+	es8316->mclk = devm_clk_get(component->dev, "mclk");
+	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (IS_ERR(es8316->mclk)) {
+		dev_err(component->dev, "clock is invalid, ignored\n");
+		es8316->mclk = NULL;
+	}
+
+	if (es8316->mclk) {
+		ret = clk_prepare_enable(es8316->mclk);
+		if (ret) {
+			dev_err(component->dev, "unable to enable clock\n");
+			return ret;
+		}
+	}
+
 	/* Reset codec and enable current state machine */
 	snd_soc_component_write(component, ES8316_RESET, 0x3f);
 	usleep_range(5000, 5500);
@@ -718,8 +744,17 @@ static int es8316_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static void es8316_remove(struct snd_soc_component *component)
+{
+	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+
+	if (es8316->mclk)
+		clk_disable_unprepare(es8316->mclk);
+}
+
 static const struct snd_soc_component_driver soc_component_dev_es8316 = {
 	.probe			= es8316_probe,
+	.remove			= es8316_remove,
 	.set_jack		= es8316_set_jack,
 	.controls		= es8316_snd_controls,
 	.num_controls		= ARRAY_SIZE(es8316_snd_controls),
-- 
2.23.0.rc1
