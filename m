From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v1 2/3] ASoC: codecs: msm8916-analog: support
	jack detection
Date: Tue, 25 Jul 2017 13:51:25 -0400
Message-ID: <20170725175126.26578-3-damien.riegel@savoirfairelinux.com>
References: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C7AE32672B1
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 19:53:11 +0200 (CEST)
In-Reply-To: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
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
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Damien Riegel <damien.riegel@savoirfairelinux.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.com
List-Id: alsa-devel@alsa-project.org

The audio codec in the PM8916 has a feature called Multi-Button Headset
Control (MBHC). It can support of up to five buttons on a headset, and
jack insertion/removal detection.

This patch only supports the jack detection. A complete implementation
is available in the Android kernel [1] for reference.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/sound/soc/codecs/wcd-mbhc-v2.c?h=LA.BR.1.2.4-00310-8x16.0

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 103 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/msm8916-wcd-analog.h |  18 ++++++
 2 files changed, 121 insertions(+)
 create mode 100644 sound/soc/codecs/msm8916-wcd-analog.h

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 0c351700044a..b9e11012f763 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <sound/jack.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -37,6 +38,8 @@
 #define DIG_CLK_CTL_RXD1_CLK_EN		BIT(0)
 #define DIG_CLK_CTL_RXD2_CLK_EN		BIT(1)
 #define DIG_CLK_CTL_RXD3_CLK_EN		BIT(2)
+#define DIG_CLK_CTL_MBHC_EN_MASK	BIT(3)
+#define DIG_CLK_CTL_MBHC_EN		BIT(3)
 #define DIG_CLK_CTL_TXD_CLK_EN		BIT(4)
 #define DIG_CLK_CTL_NCP_CLK_EN_MASK	BIT(6)
 #define DIG_CLK_CTL_NCP_CLK_EN		BIT(6)
@@ -130,6 +133,10 @@
 #define CDC_A_MICB_2_EN			(0xf144)
 #define CDC_A_TX_1_2_ATEST_CTL_2	(0xf145)
 #define CDC_A_MASTER_BIAS_CTL		(0xf146)
+#define CDC_A_MBHC_DET_CTL_1		(0xf147)
+#define MHBC_DET_CTL_1_DET_TYPE			BIT(5)
+#define CDC_A_MBHC_DET_CTL_2		(0xf150)
+#define CDC_A_MBHC_DBNC_TIMER		(0xf152)
 #define CDC_A_TX_1_EN			(0xf160)
 #define CDC_A_TX_2_EN			(0xf161)
 #define CDC_A_TX_1_2_TEST_CTL_1		(0xf162)
@@ -221,8 +228,10 @@ static const char * const supply_names[] = {
 struct pm8916_wcd_analog_priv {
 	u16 pmic_rev;
 	u16 codec_version;
+	struct snd_soc_codec *codec;
 	struct clk *mclk;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
+	struct snd_soc_jack *jack;
 	unsigned int micbias1_cap_mode;
 	unsigned int micbias2_cap_mode;
 };
@@ -522,6 +531,7 @@ static int pm8916_wcd_analog_probe(struct snd_soc_codec *codec)
 		return err;
 	}
 
+	priv->codec = codec;
 	snd_soc_codec_set_drvdata(codec, priv);
 	priv->pmic_rev = snd_soc_read(codec, CDC_D_REVISION1);
 	priv->codec_version = snd_soc_read(codec, CDC_D_PERPH_SUBTYPE);
@@ -547,6 +557,70 @@ static int pm8916_wcd_analog_remove(struct snd_soc_codec *codec)
 				      priv->supplies);
 }
 
+static irqreturn_t pm8916_wcd_analog_mbhc_switch_handler(int irq, void *data)
+{
+	struct pm8916_wcd_analog_priv *priv = data;
+	struct snd_soc_codec *codec = priv->codec;
+	unsigned int reg;
+	int mask, status;
+	bool insert;
+
+	if (!codec || !priv->jack)
+		return IRQ_HANDLED;
+
+	reg = snd_soc_read(codec, CDC_A_MBHC_DET_CTL_1);
+	insert = reg & MHBC_DET_CTL_1_DET_TYPE;
+	mask = SND_JACK_MECHANICAL;
+
+	dev_dbg(codec->dev, "detected jack %s\n",
+		insert ? "insertion" : "removal");
+
+	/* switch between insertion and removal detection */
+	snd_soc_update_bits(codec, CDC_A_MBHC_DET_CTL_1,
+			    MHBC_DET_CTL_1_DET_TYPE,
+			    reg ^ MHBC_DET_CTL_1_DET_TYPE);
+
+	if (insert)
+		status = SND_JACK_MECHANICAL;
+	else
+		status = 0;
+
+	snd_soc_jack_report(priv->jack, status, mask);
+
+	return IRQ_HANDLED;
+}
+
+
+/**
+ * pm8916_wcd_analog_jack_detect - Enable jack detection.
+ *
+ * @codec:         msm8916 codec
+ * @jack:          jack to report detection events on
+ *
+ * Enables jack detection of the pm8916-analog. It is capable of reporting
+ * mechanical insertion.
+ */
+int pm8916_wcd_analog_jack_detect(struct snd_soc_codec *codec,
+				  struct snd_soc_jack *jack)
+{
+	struct pm8916_wcd_analog_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->jack = jack;
+
+	snd_soc_update_bits(codec, CDC_D_CDC_RST_CTL,
+			    RST_CTL_DIG_SW_RST_N_MASK,
+			    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
+	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1, 0xB5);
+	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_2, 0xE1);
+	snd_soc_write(codec, CDC_A_MBHC_DBNC_TIMER, 0x98);
+	snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+			    DIG_CLK_CTL_MBHC_EN_MASK,
+			    DIG_CLK_CTL_MBHC_EN);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm8916_wcd_analog_jack_detect);
+
 static const struct snd_soc_dapm_route pm8916_wcd_analog_audio_map[] = {
 
 	{"PDM_RX1", NULL, "PDM Playback"},
@@ -799,6 +873,14 @@ static struct snd_soc_codec_driver pm8916_wcd_analog = {
 	},
 };
 
+static struct jack_detect_irq {
+	const char *name;
+	irqreturn_t (*handler)(int, void *);
+} jack_detect_irqs[] = {
+	{ "mbhc_switch_int", pm8916_wcd_analog_mbhc_switch_handler },
+	/* other MBHC related interrupts are not handled yet */
+};
+
 static int pm8916_wcd_analog_parse_dt(struct device *dev,
 				       struct pm8916_wcd_analog_priv *priv)
 {
@@ -846,6 +928,27 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(jack_detect_irqs); i++) {
+		int irq;
+
+		irq = platform_get_irq_byname(pdev, jack_detect_irqs[i].name);
+		if (irq < 0) {
+			dev_warn(dev, "failed to get irq '%s', jack insertion detection disabled\n",
+				 jack_detect_irqs[i].name);
+			break;
+		}
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						jack_detect_irqs[i].handler,
+						IRQF_ONESHOT,
+						jack_detect_irqs[i].name, priv);
+		if (ret) {
+			dev_err(dev, "failed to request irq '%s': %d\n",
+				jack_detect_irqs[i].name, ret);
+			return ret;
+		}
+	}
+
 	ret = clk_prepare_enable(priv->mclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable mclk %d\n", ret);
diff --git a/sound/soc/codecs/msm8916-wcd-analog.h b/sound/soc/codecs/msm8916-wcd-analog.h
new file mode 100644
index 000000000000..5cd00bb5f34a
--- /dev/null
+++ b/sound/soc/codecs/msm8916-wcd-analog.h
@@ -0,0 +1,18 @@
+/*
+ * msm8916-wcd-analog.h - MSM8916 analog audio codec interface
+ *
+ * Copyright 2017 - Savoir-faire Linux, Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _MSM8916_WCD_ANALOG_H
+#define _MSM8916_WCD_ANALOG_H
+
+int pm8916_wcd_analog_jack_detect(struct snd_soc_codec *codec,
+                                  struct snd_soc_jack *jack);
+
+#endif
-- 
2.13.3
