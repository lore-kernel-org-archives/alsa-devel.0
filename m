From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 04/12] ASoC: tlv320aic32x4: Model DAC/ADC
	dividers in CCF
Date: Tue, 19 Mar 2019 21:51:21 -0700
Message-ID: <20190320045129.6859-5-nh6z@nh6z.net>
References: <20190320045129.6859-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.ord1c.emailsrvr.com (smtp113.ord1c.emailsrvr.com
 [108.166.43.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33D0CF8970A
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 05:51:48 +0100 (CET)
In-Reply-To: <20190320045129.6859-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

Model and manage DAC/ADC dividers as components in the Core
Clock Framework.  This should allow us to do some more complex
clock management and power control.  Also, some of the
on-board chip clocks can be exposed to the outside, and this
change will make those clocks easier to consume by other
parts of the kernel.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 90 ++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.c     | 95 ++++++++++++++++------------
 sound/soc/codecs/tlv320aic32x4.h     |  4 ++
 3 files changed, 148 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index cded85009c8c..daf14924e324 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -289,6 +289,68 @@ static const struct clk_ops aic32x4_codec_clkin_ops = {
 	.get_parent = clk_aic32x4_codec_clkin_get_parent,
 };
 
+static int clk_aic32x4_div_prepare(struct clk_hw *hw)
+{
+	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
+
+	return regmap_update_bits(div->regmap, div->reg,
+				AIC32X4_DIVEN, AIC32X4_DIVEN);
+}
+
+static void clk_aic32x4_div_unprepare(struct clk_hw *hw)
+{
+	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
+
+	regmap_update_bits(div->regmap, div->reg,
+			AIC32X4_DIVEN, 0);
+}
+
+static int clk_aic32x4_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
+	u8 divisor;
+
+	divisor = DIV_ROUND_UP(parent_rate, rate);
+	if (divisor > 128)
+		return -EINVAL;
+
+	return regmap_update_bits(div->regmap, div->reg,
+				AIC32X4_DIV_MASK, divisor);
+}
+
+static long clk_aic32x4_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	unsigned long divisor;
+
+	divisor = DIV_ROUND_UP(*parent_rate, rate);
+	if (divisor > 128)
+		return -EINVAL;
+
+	return DIV_ROUND_UP(*parent_rate, divisor);
+}
+
+static unsigned long clk_aic32x4_div_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
+
+	unsigned int val;
+
+	regmap_read(div->regmap, div->reg, &val);
+
+	return DIV_ROUND_UP(parent_rate, val & AIC32X4_DIV_MASK);
+}
+
+static const struct clk_ops aic32x4_div_ops = {
+	.prepare = clk_aic32x4_div_prepare,
+	.unprepare = clk_aic32x4_div_unprepare,
+	.set_rate = clk_aic32x4_div_set_rate,
+	.round_rate = clk_aic32x4_div_round_rate,
+	.recalc_rate = clk_aic32x4_div_recalc_rate,
+};
+
 static struct aic32x4_clkdesc aic32x4_clkdesc_array[] = {
 	{
 		.name = "pll",
@@ -306,6 +368,34 @@ static struct aic32x4_clkdesc aic32x4_clkdesc_array[] = {
 		.ops = &aic32x4_codec_clkin_ops,
 		.reg = 0,
 	},
+	{
+		.name = "ndac",
+		.parent_names = (const char * []) { "codec_clkin" },
+		.num_parents = 1,
+		.ops = &aic32x4_div_ops,
+		.reg = AIC32X4_NDAC,
+	},
+	{
+		.name = "mdac",
+		.parent_names = (const char * []) { "ndac" },
+		.num_parents = 1,
+		.ops = &aic32x4_div_ops,
+		.reg = AIC32X4_MDAC,
+	},
+	{
+		.name = "nadc",
+		.parent_names = (const char * []) { "codec_clkin" },
+		.num_parents = 1,
+		.ops = &aic32x4_div_ops,
+		.reg = AIC32X4_NADC,
+	},
+	{
+		.name = "madc",
+		.parent_names = (const char * []) { "nadc" },
+		.num_parents = 1,
+		.ops = &aic32x4_div_ops,
+		.reg = AIC32X4_MADC,
+	},
 };
 
 static struct clk *aic32x4_register_clk(struct device *dev,
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 6b682743cf9b..aac4c3f335d1 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -52,11 +52,11 @@ struct aic32x4_rate_divs {
 	u32 rate;
 	unsigned long pll_rate;
 	u16 dosr;
-	u8 ndac;
-	u8 mdac;
+	unsigned long ndac_rate;
+	unsigned long mdac_rate;
 	u8 aosr;
-	u8 nadc;
-	u8 madc;
+	unsigned long nadc_rate;
+	unsigned long madc_rate;
 	u8 blck_N;
 };
 
@@ -307,34 +307,54 @@ static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 
 static const struct aic32x4_rate_divs aic32x4_divs[] = {
 	/* 8k rate */
-	{ 12000000, 8000, 57120000, 768, 5, 3, 128, 5, 18, 24 },
-	{ 24000000, 8000, 57120000, 768, 15, 1, 64, 45, 4, 24 },
-	{ 25000000, 8000, 32620000, 768, 15, 1, 64, 45, 4, 24 },
+	{ 12000000, 8000, 57120000, 768, 18432000, 6144000, 128, 18432000,
+		1024000, 24 },
+	{ 24000000, 8000, 57120000, 768, 6144000, 6144000, 64, 2048000,
+		512000, 24 },
+	{ 25000000, 8000, 32620000, 768, 6144000, 6144000, 64, 2048000,
+		512000, 24 },
 	/* 11.025k rate */
-	{ 12000000, 11025, 44217600, 512, 8, 2, 128, 8, 8, 16 },
-	{ 24000000, 11025, 44217600, 512, 16, 1, 64, 32, 4, 16 },
+	{ 12000000, 11025, 44217600, 512, 11289600, 5644800, 128, 11289600,
+		1411200, 16 },
+	{ 24000000, 11025, 44217600, 512, 5644800, 5644800, 64, 2822400,
+		705600, 16 },
 	/* 16k rate */
-	{ 12000000, 16000, 57120000, 384, 5, 3, 128, 5, 9, 12 },
-	{ 24000000, 16000, 57120000, 384, 15, 1, 64, 18, 5, 12 },
-	{ 25000000, 16000, 32620000, 384, 15, 1, 64, 18, 5, 12 },
+	{ 12000000, 16000, 57120000, 384, 18432000, 6144000, 128, 18432000,
+		2048000, 12 },
+	{ 24000000, 16000, 57120000, 384, 6144000, 6144000, 64, 5120000,
+		1024000, 12 },
+	{ 25000000, 16000, 32620000, 384, 6144000, 6144000, 64, 5120000,
+		1024000, 12 },
 	/* 22.05k rate */
-	{ 12000000, 22050, 44217600, 256, 4, 4, 128, 4, 8, 8 },
-	{ 24000000, 22050, 44217600, 256, 16, 1, 64, 16, 4, 8 },
-	{ 25000000, 22050, 19713750, 256, 16, 1, 64, 16, 4, 8 },
+	{ 12000000, 22050, 44217600, 256, 22579200, 5644800, 128, 22579200,
+		2822400, 8 },
+	{ 24000000, 22050, 44217600, 256, 5644800, 5644800, 64, 5644800,
+		1411200, 8 },
+	{ 25000000, 22050, 19713750, 256, 5644800, 5644800, 64, 5644800,
+		1411200, 8 },
 	/* 32k rate */
-	{ 12000000, 32000, 14112000, 192, 2, 7, 64, 2, 21, 6 },
-	{ 24000000, 32000, 14112000, 192, 7, 2, 64, 7, 6, 6 },
+	{ 12000000, 32000, 14112000, 192, 43008000, 6144000, 64, 43008000,
+		2048000, 6 },
+	{ 24000000, 32000, 14112000, 192, 12288000, 6144000, 64, 12288000,
+		2048000, 6 },
 	/* 44.1k rate */
-	{ 12000000, 44100, 44217600, 128, 2, 8, 128, 2, 8, 4 },
-	{ 24000000, 44100, 44217600, 128, 8, 2, 64, 8, 4, 4 },
-	{ 25000000, 44100, 19713750, 128, 8, 2, 64, 8, 4, 4 },
+	{ 12000000, 44100, 44217600, 128, 45158400, 5644800, 128, 45158400,
+		5644800, 4 },
+	{ 24000000, 44100, 44217600, 128, 11289600, 5644800, 64, 11289600,
+		2822400, 4 },
+	{ 25000000, 44100, 19713750, 128, 11289600, 5644800, 64, 11289600,
+		2822400, 4 },
 	/* 48k rate */
-	{ 12000000, 48000, 18432000, 128, 2, 8, 128, 2, 8, 4 },
-	{ 24000000, 48000, 18432000, 128, 8, 2, 64, 8, 4, 4 },
-	{ 25000000, 48000, 75626250, 128, 8, 2, 64, 8, 4, 4 },
+	{ 12000000, 48000, 18432000, 128, 49152000, 6144000, 128, 49152000,
+		6144000, 4 },
+	{ 24000000, 48000, 18432000, 128, 12288000, 6144000, 64, 12288000,
+		3072000, 4 },
+	{ 25000000, 48000, 75626250, 128, 12288000, 6144000, 64, 12288000,
+		3072000, 4 },
 
 	/* 96k rate */
-	{ 25000000, 96000, 75626250, 64, 4, 4, 64, 4, 4, 1 },
+	{ 25000000, 96000, 75626250, 64, 24576000, 6144000, 64, 24576000,
+		6144000, 1 },
 };
 
 static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
@@ -705,6 +725,10 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 
 	struct clk_bulk_data clocks[] = {
 		{ .id = "pll" },
+		{ .id = "nadc" },
+		{ .id = "madc" },
+		{ .id = "ndac" },
+		{ .id = "mdac" },
 	};
 
 	i = aic32x4_get_divs(parent_rate, sample_rate);
@@ -717,33 +741,21 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	clk_set_rate(clocks[0].clk, sample_rate);
+	clk_set_rate(clocks[0].clk, aic32x4_divs[i].pll_rate);
+	clk_set_rate(clocks[1].clk, aic32x4_divs[i].nadc_rate);
+	clk_set_rate(clocks[2].clk, aic32x4_divs[i].madc_rate);
+	clk_set_rate(clocks[3].clk, aic32x4_divs[i].ndac_rate);
+	clk_set_rate(clocks[4].clk, aic32x4_divs[i].mdac_rate);
 
 	/* DAC_MOD_CLK as BDIV_CLKIN */
 	snd_soc_component_update_bits(component, AIC32X4_IFACE3,
 				AIC32X4_BDIVCLK_MASK,
 				AIC32X4_DACMOD2BCLK << AIC32X4_BDIVCLK_SHIFT);
 
-	/* NDAC divider value */
-	snd_soc_component_update_bits(component, AIC32X4_NDAC,
-				AIC32X4_NDAC_MASK, aic32x4_divs[i].ndac);
-
-	/* MDAC divider value */
-	snd_soc_component_update_bits(component, AIC32X4_MDAC,
-				AIC32X4_MDAC_MASK, aic32x4_divs[i].mdac);
-
 	/* DOSR MSB & LSB values */
 	snd_soc_component_write(component, AIC32X4_DOSRMSB, aic32x4_divs[i].dosr >> 8);
 	snd_soc_component_write(component, AIC32X4_DOSRLSB, (aic32x4_divs[i].dosr & 0xff));
 
-	/* NADC divider value */
-	snd_soc_component_update_bits(component, AIC32X4_NADC,
-				AIC32X4_NADC_MASK, aic32x4_divs[i].nadc);
-
-	/* MADC divider value */
-	snd_soc_component_update_bits(component, AIC32X4_MADC,
-				AIC32X4_MADC_MASK, aic32x4_divs[i].madc);
-
 	/* AOSR value */
 	snd_soc_component_write(component, AIC32X4_AOSR, aic32x4_divs[i].aosr);
 
@@ -972,6 +984,7 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 
 	struct clk_bulk_data clocks[] = {
 		{ .id = "codec_clkin" },
+		{ .id = "pll" },
 	};
 
 	ret = devm_clk_bulk_get(component->dev, ARRAY_SIZE(clocks), clocks);
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index e2b65bbba7c2..6ede877b00a0 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -206,6 +206,10 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_RMICPGANIN_IN1L_10K	0x10
 #define AIC32X4_RMICPGANIN_CM1R_10K	0x40
 
+/* Common mask and enable for all of the dividers */
+#define AIC32X4_DIVEN           BIT(7)
+#define AIC32X4_DIV_MASK        GENMASK(6, 0)
+
 /* Clock Limits */
 #define AIC32X4_MAX_PLL_CLKIN		20000000
 
-- 
2.19.1
