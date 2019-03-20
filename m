From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 05/12] ASoC: tlv320aic32x4: Model BDIV
	divider in CCF
Date: Tue, 19 Mar 2019 21:51:22 -0700
Message-ID: <20190320045129.6859-6-nh6z@nh6z.net>
References: <20190320045129.6859-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.ord1c.emailsrvr.com (smtp113.ord1c.emailsrvr.com
 [108.166.43.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 666AEF896FF
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

Model and manage BDIV divider as components in the Core
Clock Framework.  This should allow us to do some more complex
clock management and power control.  Also, some of the
on-board chip clocks can be exposed to the outside, and this
change will make those clocks easier to consume by other
parts of the kernel.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 36 ++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.c     | 56 +++++++++++++---------------
 2 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index daf14924e324..667ec2c03508 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -351,6 +351,34 @@ static const struct clk_ops aic32x4_div_ops = {
 	.recalc_rate = clk_aic32x4_div_recalc_rate,
 };
 
+static int clk_aic32x4_bdiv_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_aic32x4 *mux = to_clk_aic32x4(hw);
+
+	return regmap_update_bits(mux->regmap, AIC32X4_IFACE3,
+				AIC32X4_BDIVCLK_MASK, index);
+}
+
+static u8 clk_aic32x4_bdiv_get_parent(struct clk_hw *hw)
+{
+	struct clk_aic32x4 *mux = to_clk_aic32x4(hw);
+	unsigned int val;
+
+	regmap_read(mux->regmap, AIC32X4_IFACE3, &val);
+
+	return val & AIC32X4_BDIVCLK_MASK;
+}
+
+static const struct clk_ops aic32x4_bdiv_ops = {
+	.prepare = clk_aic32x4_div_prepare,
+	.unprepare = clk_aic32x4_div_unprepare,
+	.set_parent = clk_aic32x4_bdiv_set_parent,
+	.get_parent = clk_aic32x4_bdiv_get_parent,
+	.set_rate = clk_aic32x4_div_set_rate,
+	.round_rate = clk_aic32x4_div_round_rate,
+	.recalc_rate = clk_aic32x4_div_recalc_rate,
+};
+
 static struct aic32x4_clkdesc aic32x4_clkdesc_array[] = {
 	{
 		.name = "pll",
@@ -396,6 +424,14 @@ static struct aic32x4_clkdesc aic32x4_clkdesc_array[] = {
 		.ops = &aic32x4_div_ops,
 		.reg = AIC32X4_MADC,
 	},
+	{
+		.name = "bdiv",
+		.parent_names =
+			(const char *[]) { "ndac", "mdac", "nadc", "madc" },
+		.num_parents = 4,
+		.ops = &aic32x4_bdiv_ops,
+		.reg = AIC32X4_BCLKN,
+	},
 };
 
 static struct clk *aic32x4_register_clk(struct device *dev,
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index aac4c3f335d1..4e170cdc05ce 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -57,7 +57,7 @@ struct aic32x4_rate_divs {
 	u8 aosr;
 	unsigned long nadc_rate;
 	unsigned long madc_rate;
-	u8 blck_N;
+	unsigned long bdiv_rate;
 };
 
 struct aic32x4_priv {
@@ -308,53 +308,53 @@ static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 static const struct aic32x4_rate_divs aic32x4_divs[] = {
 	/* 8k rate */
 	{ 12000000, 8000, 57120000, 768, 18432000, 6144000, 128, 18432000,
-		1024000, 24 },
+		1024000, 256000 },
 	{ 24000000, 8000, 57120000, 768, 6144000, 6144000, 64, 2048000,
-		512000, 24 },
+		512000, 256000 },
 	{ 25000000, 8000, 32620000, 768, 6144000, 6144000, 64, 2048000,
-		512000, 24 },
+		512000, 256000 },
 	/* 11.025k rate */
 	{ 12000000, 11025, 44217600, 512, 11289600, 5644800, 128, 11289600,
-		1411200, 16 },
+		1411200, 352800 },
 	{ 24000000, 11025, 44217600, 512, 5644800, 5644800, 64, 2822400,
-		705600, 16 },
+		705600, 352800 },
 	/* 16k rate */
 	{ 12000000, 16000, 57120000, 384, 18432000, 6144000, 128, 18432000,
-		2048000, 12 },
+		2048000, 512000 },
 	{ 24000000, 16000, 57120000, 384, 6144000, 6144000, 64, 5120000,
-		1024000, 12 },
+		1024000, 512000 },
 	{ 25000000, 16000, 32620000, 384, 6144000, 6144000, 64, 5120000,
-		1024000, 12 },
+		1024000, 512000 },
 	/* 22.05k rate */
 	{ 12000000, 22050, 44217600, 256, 22579200, 5644800, 128, 22579200,
-		2822400, 8 },
+		2822400, 705600 },
 	{ 24000000, 22050, 44217600, 256, 5644800, 5644800, 64, 5644800,
-		1411200, 8 },
+		1411200, 705600 },
 	{ 25000000, 22050, 19713750, 256, 5644800, 5644800, 64, 5644800,
-		1411200, 8 },
+		1411200, 705600 },
 	/* 32k rate */
 	{ 12000000, 32000, 14112000, 192, 43008000, 6144000, 64, 43008000,
-		2048000, 6 },
+		2048000, 1024000 },
 	{ 24000000, 32000, 14112000, 192, 12288000, 6144000, 64, 12288000,
-		2048000, 6 },
+		2048000, 1024000 },
 	/* 44.1k rate */
 	{ 12000000, 44100, 44217600, 128, 45158400, 5644800, 128, 45158400,
-		5644800, 4 },
+		5644800, 1411200 },
 	{ 24000000, 44100, 44217600, 128, 11289600, 5644800, 64, 11289600,
-		2822400, 4 },
+		2822400, 1411200 },
 	{ 25000000, 44100, 19713750, 128, 11289600, 5644800, 64, 11289600,
-		2822400, 4 },
+		2822400, 1411200 },
 	/* 48k rate */
 	{ 12000000, 48000, 18432000, 128, 49152000, 6144000, 128, 49152000,
-		6144000, 4 },
+		6144000, 1536000 },
 	{ 24000000, 48000, 18432000, 128, 12288000, 6144000, 64, 12288000,
-		3072000, 4 },
+		3072000, 1536000 },
 	{ 25000000, 48000, 75626250, 128, 12288000, 6144000, 64, 12288000,
-		3072000, 4 },
+		3072000, 1536000 },
 
 	/* 96k rate */
 	{ 25000000, 96000, 75626250, 64, 24576000, 6144000, 64, 24576000,
-		6144000, 1 },
+		6144000, 3072000 },
 };
 
 static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
@@ -729,6 +729,7 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 		{ .id = "madc" },
 		{ .id = "ndac" },
 		{ .id = "mdac" },
+		{ .id = "bdiv" },
 	};
 
 	i = aic32x4_get_divs(parent_rate, sample_rate);
@@ -746,11 +747,7 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	clk_set_rate(clocks[2].clk, aic32x4_divs[i].madc_rate);
 	clk_set_rate(clocks[3].clk, aic32x4_divs[i].ndac_rate);
 	clk_set_rate(clocks[4].clk, aic32x4_divs[i].mdac_rate);
-
-	/* DAC_MOD_CLK as BDIV_CLKIN */
-	snd_soc_component_update_bits(component, AIC32X4_IFACE3,
-				AIC32X4_BDIVCLK_MASK,
-				AIC32X4_DACMOD2BCLK << AIC32X4_BDIVCLK_SHIFT);
+	clk_set_rate(clocks[5].clk, aic32x4_divs[i].bdiv_rate);
 
 	/* DOSR MSB & LSB values */
 	snd_soc_component_write(component, AIC32X4_DOSRMSB, aic32x4_divs[i].dosr >> 8);
@@ -759,10 +756,6 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	/* AOSR value */
 	snd_soc_component_write(component, AIC32X4_AOSR, aic32x4_divs[i].aosr);
 
-	/* BCLK N divider */
-	snd_soc_component_update_bits(component, AIC32X4_BCLKN,
-				AIC32X4_BCLK_MASK, aic32x4_divs[i].blck_N);
-
 	return 0;
 }
 
@@ -985,6 +978,8 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 	struct clk_bulk_data clocks[] = {
 		{ .id = "codec_clkin" },
 		{ .id = "pll" },
+		{ .id = "bdiv" },
+		{ .id = "mdac" },
 	};
 
 	ret = devm_clk_bulk_get(component->dev, ARRAY_SIZE(clocks), clocks);
@@ -1003,6 +998,7 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 		aic32x4_setup_gpios(component);
 
 	clk_set_parent(clocks[0].clk, clocks[1].clk);
+	clk_set_parent(clocks[2].clk, clocks[3].clk);
 
 	/* Power platform configuration */
 	if (aic32x4->power_cfg & AIC32X4_PWR_MICBIAS_2075_LDOIN) {
-- 
2.19.1
