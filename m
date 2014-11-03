From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 2/2] ASoC: max98090: Different comp tables for
	different pclks
Date: Mon,  3 Nov 2014 10:28:57 -0800
Message-ID: <1415039337-28026-2-git-send-email-dgreid@chromium.org>
References: <1415039337-28026-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f201.google.com (mail-ie0-f201.google.com
 [209.85.223.201])
 by alsa0.perex.cz (Postfix) with ESMTP id A65592604D3
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 19:29:21 +0100 (CET)
Received: by mail-ie0-f201.google.com with SMTP id rd18so811193iec.4
 for <alsa-devel@alsa-project.org>; Mon, 03 Nov 2014 10:29:20 -0800 (PST)
In-Reply-To: <1415039337-28026-1-git-send-email-dgreid@chromium.org>
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
Cc: Dylan Reid <dgreid@chromium.org>, broonie@kernel.org, ralph.birt@maximintegrated.com, jerry.wong@maximintegrated.com
List-Id: alsa-devel@alsa-project.org

In addtion expand the table to handle other values of sysclk.  Instead
of making the table 3D, expand it to a more descriptive struct.  The
divisors are specified in Table 19 of the 98090 data sheet version
0p94.

The dmic frequency was previously assumed.  Instead make it explicit
and configurable through device tree.  This now handles independently
set pclk and dmic frequency.

Based on downstream work by Ralph Birt.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 .../devicetree/bindings/sound/max98090.txt         |   2 +
 sound/soc/codecs/max98090.c                        | 189 +++++++++++++++++----
 sound/soc/codecs/max98090.h                        |   8 +
 3 files changed, 163 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max98090.txt b/Documentation/devicetree/bindings/sound/max98090.txt
index c454e67..aa802a2 100644
--- a/Documentation/devicetree/bindings/sound/max98090.txt
+++ b/Documentation/devicetree/bindings/sound/max98090.txt
@@ -16,6 +16,8 @@ Optional properties:
 
 - clock-names: Should be "mclk"
 
+- maxim,dmic-freq: Frequency at which to clock DMIC
+
 Pins on the device (for linking into audio routes):
 
   * MIC1
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 1229554..a65861c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1826,27 +1826,155 @@ static int max98090_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static const int comp_pclk_rates[] = {
-	11289600, 12288000, 12000000, 13000000, 19200000
-};
-
-static const int dmic_micclk[] = {
-	2, 2, 2, 2, 4, 2
-};
+static const int dmic_divisors[] = { 2, 3, 4, 5, 6, 8 };
 
 static const int comp_lrclk_rates[] = {
 	8000, 16000, 32000, 44100, 48000, 96000
 };
 
-static const int dmic_comp[6][6] = {
-	{7, 8, 3, 3, 3, 3},
-	{7, 8, 3, 3, 3, 3},
-	{7, 8, 3, 3, 3, 3},
-	{7, 8, 3, 1, 1, 1},
-	{7, 8, 3, 1, 2, 2},
-	{7, 8, 3, 3, 3, 3}
+struct dmic_table {
+	int pclk;
+	struct {
+		int freq;
+		int comp[6]; /* One each for 8, 16, 32, 44.1, 48, and 96 kHz */
+	} settings[6]; /* One for each dmic divisor. */
 };
 
+static const struct dmic_table dmic_table[] = { /* One for each pclk freq. */
+	{
+		.pclk = 11289600,
+		.settings = {
+			{ .freq = 2, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 1, .comp = { 7, 8, 2, 2, 2, 2 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 0, .comp = { 7, 8, 6, 6, 6, 6 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+		},
+	},
+	{
+		.pclk = 12000000,
+		.settings = {
+			{ .freq = 2, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 1, .comp = { 7, 8, 2, 2, 2, 2 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 0, .comp = { 7, 8, 5, 5, 6, 6 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+		}
+	},
+	{
+		.pclk = 12288000,
+		.settings = {
+			{ .freq = 2, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 1, .comp = { 7, 8, 2, 2, 2, 2 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 0, .comp = { 7, 8, 6, 6, 6, 6 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+			{ .freq = 0, .comp = { 7, 8, 3, 3, 3, 3 } },
+		}
+	},
+	{
+		.pclk = 13000000,
+		.settings = {
+			{ .freq = 2, .comp = { 7, 8, 1, 1, 1, 1 } },
+			{ .freq = 1, .comp = { 7, 8, 0, 0, 0, 0 } },
+			{ .freq = 0, .comp = { 7, 8, 1, 1, 1, 1 } },
+			{ .freq = 0, .comp = { 7, 8, 4, 4, 5, 5 } },
+			{ .freq = 0, .comp = { 7, 8, 1, 1, 1, 1 } },
+			{ .freq = 0, .comp = { 7, 8, 1, 1, 1, 1 } },
+		}
+	},
+	{
+		.pclk = 19200000,
+		.settings = {
+			{ .freq = 2, .comp = { 0, 0, 0, 0, 0, 0 } },
+			{ .freq = 1, .comp = { 7, 8, 1, 1, 1, 1 } },
+			{ .freq = 0, .comp = { 7, 8, 5, 5, 6, 6 } },
+			{ .freq = 0, .comp = { 7, 8, 2, 2, 3, 3 } },
+			{ .freq = 0, .comp = { 7, 8, 1, 1, 2, 2 } },
+			{ .freq = 0, .comp = { 7, 8, 5, 5, 6, 6 } },
+		}
+	},
+};
+
+static int max98090_find_divisor(int target_freq, int pclk)
+{
+	int current_diff = INT_MAX;
+	int test_diff = INT_MAX;
+	int divisor_index = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dmic_divisors); i++) {
+		test_diff = abs(target_freq - (pclk / dmic_divisors[i]));
+		if (test_diff < current_diff) {
+			current_diff = test_diff;
+			divisor_index = i;
+		}
+	}
+
+	return divisor_index;
+}
+
+static int max98090_find_closest_pclk(int pclk)
+{
+	int m1;
+	int m2;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dmic_table); i++) {
+		if (pclk == dmic_table[i].pclk)
+			return i;
+		if (pclk < dmic_table[i].pclk) {
+			if (i == 0)
+				return i;
+			m1 = pclk - dmic_table[i-1].pclk;
+			m2 = dmic_table[i].pclk - pclk;
+			if (m1 < m2)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int max98090_configure_dmic(struct max98090_priv *max98090,
+				   int target_dmic_clk, int pclk, int fs)
+{
+	int micclk_index;
+	int pclk_index;
+	int dmic_freq;
+	int dmic_comp;
+	int i;
+
+	pclk_index = max98090_find_closest_pclk(pclk);
+	if (pclk_index < 0)
+		return pclk_index;
+
+	micclk_index = max98090_find_divisor(target_dmic_clk, pclk);
+
+	for (i = 0; i < ARRAY_SIZE(comp_lrclk_rates) - 1; i++) {
+		if (fs <= (comp_lrclk_rates[i] + comp_lrclk_rates[i+1]) / 2)
+			break;
+	}
+
+	dmic_freq = dmic_table[pclk_index].settings[micclk_index].freq;
+	dmic_comp = dmic_table[pclk_index].settings[micclk_index].comp[i];
+
+	regmap_update_bits(max98090->regmap, M98090_REG_DIGITAL_MIC_ENABLE,
+			   M98090_MICCLK_MASK,
+			   micclk_index << M98090_MICCLK_SHIFT);
+
+	regmap_update_bits(max98090->regmap, M98090_REG_DIGITAL_MIC_CONFIG,
+			   M98090_DMIC_COMP_MASK | M98090_DMIC_FREQ_MASK,
+			   dmic_comp << M98090_DMIC_COMP_SHIFT |
+			   dmic_freq << M98090_DMIC_FREQ_SHIFT);
+
+	return 0;
+}
+
 static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -1854,7 +1982,6 @@ static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
 	struct max98090_cdata *cdata;
-	int i, j;
 
 	cdata = &max98090->dai[0];
 	max98090->bclk = snd_soc_params_to_bclk(params);
@@ -1893,27 +2020,8 @@ static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 		snd_soc_update_bits(codec, M98090_REG_FILTER_CONFIG,
 			M98090_DHF_MASK, M98090_DHF_MASK);
 
-	/* Check for supported PCLK to LRCLK ratios */
-	for (j = 0; j < ARRAY_SIZE(comp_pclk_rates); j++) {
-		if (comp_pclk_rates[j] == max98090->sysclk) {
-			break;
-		}
-	}
-
-	for (i = 0; i < ARRAY_SIZE(comp_lrclk_rates) - 1; i++) {
-		if (max98090->lrclk <= (comp_lrclk_rates[i] +
-			comp_lrclk_rates[i + 1]) / 2) {
-			break;
-		}
-	}
-
-	snd_soc_update_bits(codec, M98090_REG_DIGITAL_MIC_ENABLE,
-			M98090_MICCLK_MASK,
-			dmic_micclk[j] << M98090_MICCLK_SHIFT);
-
-	snd_soc_update_bits(codec, M98090_REG_DIGITAL_MIC_CONFIG,
-			M98090_DMIC_COMP_MASK,
-			dmic_comp[j][i] << M98090_DMIC_COMP_SHIFT);
+	max98090_configure_dmic(max98090, max98090->dmic_freq, max98090->pclk,
+				max98090->lrclk);
 
 	return 0;
 }
@@ -1944,12 +2052,15 @@ static int max98090_dai_set_sysclk(struct snd_soc_dai *dai,
 	if ((freq >= 10000000) && (freq <= 20000000)) {
 		snd_soc_write(codec, M98090_REG_SYSTEM_CLOCK,
 			M98090_PSCLK_DIV1);
+		max98090->pclk = freq;
 	} else if ((freq > 20000000) && (freq <= 40000000)) {
 		snd_soc_write(codec, M98090_REG_SYSTEM_CLOCK,
 			M98090_PSCLK_DIV2);
+		max98090->pclk = freq >> 1;
 	} else if ((freq > 40000000) && (freq <= 60000000)) {
 		snd_soc_write(codec, M98090_REG_SYSTEM_CLOCK,
 			M98090_PSCLK_DIV4);
+		max98090->pclk = freq >> 2;
 	} else {
 		dev_err(codec->dev, "Invalid master clock frequency\n");
 		return -EINVAL;
@@ -2324,6 +2435,7 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	/* Initialize private data */
 
 	max98090->sysclk = (unsigned)-1;
+	max98090->pclk = (unsigned)-1;
 	max98090->master = false;
 
 	cdata = &max98090->dai[0];
@@ -2463,6 +2575,11 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, max98090);
 	max98090->pdata = i2c->dev.platform_data;
 
+	ret = of_property_read_u32(i2c->dev.of_node, "maxim,dmic-freq",
+				   &max98090->dmic_freq);
+	if (ret < 0)
+		max98090->dmic_freq = MAX98090_DEFAULT_DMIC_FREQ;
+
 	max98090->regmap = devm_regmap_init_i2c(i2c, &max98090_regmap);
 	if (IS_ERR(max98090->regmap)) {
 		ret = PTR_ERR(max98090->regmap);
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index a5f6bad..21ff743 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -12,6 +12,12 @@
 #define _MAX98090_H
 
 /*
+ * The default operating frequency for a DMIC attached to the codec.
+ * This can be overridden by a device tree property.
+ */
+#define MAX98090_DEFAULT_DMIC_FREQ		2500000
+
+/*
  * MAX98090 Register Definitions
  */
 
@@ -1518,8 +1524,10 @@ struct max98090_priv {
 	struct max98090_pdata *pdata;
 	struct clk *mclk;
 	unsigned int sysclk;
+	unsigned int pclk;
 	unsigned int bclk;
 	unsigned int lrclk;
+	u32 dmic_freq;
 	struct max98090_cdata dai[1];
 	int jack_state;
 	struct delayed_work jack_work;
-- 
2.1.2.330.g565301e
