From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Model BDIV divider in
	CCF" to the asoc tree
Date: Mon, 25 Mar 2019 16:11:36 +0000 (GMT)
Message-ID: <20190325161136.530D111288F3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A14DF89723
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 17:11:37 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Model BDIV divider in CCF

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9b484124ebd906c4d6bc826cc0d417e80cc1105c Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Thu, 21 Mar 2019 17:58:48 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Model BDIV divider in CCF

Model and manage BDIV divider as components in the Core
Clock Framework.  This should allow us to do some more complex
clock management and power control.  Also, some of the
on-board chip clocks can be exposed to the outside, and this
change will make those clocks easier to consume by other
parts of the kernel.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 0cf942938372..bf9ccda6616d 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -57,7 +57,7 @@ struct aic32x4_rate_divs {
 	u8 aosr;
 	unsigned long nadc_rate;
 	unsigned long madc_rate;
-	u8 blck_N;
+	unsigned long bdiv_rate;
 	u8 r_block;
 	u8 p_block;
 };
@@ -310,53 +310,53 @@ static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 static const struct aic32x4_rate_divs aic32x4_divs[] = {
 	/* 8k rate */
 	{ 12000000, 8000, 57120000, 768, 18432000, 6144000, 128, 18432000,
-		1024000, 24, 1, 1 },
+		1024000, 256000, 1, 1 },
 	{ 24000000, 8000, 57120000, 768, 6144000, 6144000, 64, 2048000,
-		512000, 24, 1, 1 },
+		512000, 256000, 1, 1 },
 	{ 25000000, 8000, 32620000, 768, 6144000, 6144000, 64, 2048000,
-		512000, 24, 1, 1 },
+		512000, 256000, 1, 1 },
 	/* 11.025k rate */
 	{ 12000000, 11025, 44217600, 512, 11289600, 5644800, 128, 11289600,
-		1411200, 16, 1, 1 },
+		1411200, 352800, 1, 1 },
 	{ 24000000, 11025, 44217600, 512, 5644800, 5644800, 64, 2822400,
-		705600, 16, 1, 1 },
+		705600, 352800, 1, 1 },
 	/* 16k rate */
 	{ 12000000, 16000, 57120000, 384, 18432000, 6144000, 128, 18432000,
-		2048000, 12, 1, 1 },
+		2048000, 512000, 1, 1 },
 	{ 24000000, 16000, 57120000, 384, 6144000, 6144000, 64, 5120000,
-		1024000, 12, 1, 1 },
+		1024000, 512000, 1, 1 },
 	{ 25000000, 16000, 32620000, 384, 6144000, 6144000, 64, 5120000,
-		1024000, 12, 1, 1 },
+		1024000, 512000, 1, 1 },
 	/* 22.05k rate */
 	{ 12000000, 22050, 44217600, 256, 22579200, 5644800, 128, 22579200,
-		2822400, 8, 1, 1 },
+		2822400, 705600, 1, 1 },
 	{ 24000000, 22050, 44217600, 256, 5644800, 5644800, 64, 5644800,
-		1411200, 8, 1, 1 },
+		1411200, 705600, 1, 1 },
 	{ 25000000, 22050, 19713750, 256, 5644800, 5644800, 64, 5644800,
-		1411200, 8, 1, 1 },
+		1411200, 705600, 1, 1 },
 	/* 32k rate */
 	{ 12000000, 32000, 14112000, 192, 43008000, 6144000, 64, 43008000,
-		2048000, 6, 1, 1 },
+		2048000, 1024000, 1, 1 },
 	{ 24000000, 32000, 14112000, 192, 12288000, 6144000, 64, 12288000,
-		2048000, 6, 1, 1 },
+		2048000, 1024000, 1, 1 },
 	/* 44.1k rate */
 	{ 12000000, 44100, 44217600, 128, 45158400, 5644800, 128, 45158400,
-		5644800, 4, 1, 1 },
+		5644800, 1411200, 1, 1 },
 	{ 24000000, 44100, 44217600, 128, 11289600, 5644800, 64, 11289600,
-		2822400, 4, 1, 1 },
+		2822400, 1411200, 1, 1 },
 	{ 25000000, 44100, 19713750, 128, 11289600, 5644800, 64, 11289600,
-		2822400, 4, 1, 1 },
+		2822400, 1411200, 1, 1 },
 	/* 48k rate */
 	{ 12000000, 48000, 18432000, 128, 49152000, 6144000, 128, 49152000,
-		6144000, 4, 1, 1 },
+		6144000, 1536000, 1, 1 },
 	{ 24000000, 48000, 18432000, 128, 12288000, 6144000, 64, 12288000,
-		3072000, 4, 1, 1 },
+		3072000, 1536000, 1, 1 },
 	{ 25000000, 48000, 75626250, 128, 12288000, 6144000, 64, 12288000,
-		3072000, 4, 1, 1 },
+		3072000, 1536000, 1, 1 },
 
 	/* 96k rate */
 	{ 25000000, 96000, 75626250, 64, 24576000, 6144000, 64, 24576000,
-		6144000, 1, 1, 9 },
+		6144000, 3072000, 1, 9 },
 };
 
 static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
@@ -743,6 +743,7 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 		{ .id = "madc" },
 		{ .id = "ndac" },
 		{ .id = "mdac" },
+		{ .id = "bdiv" },
 	};
 
 	i = aic32x4_get_divs(parent_rate, sample_rate);
@@ -760,14 +761,10 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	clk_set_rate(clocks[2].clk, aic32x4_divs[i].madc_rate);
 	clk_set_rate(clocks[3].clk, aic32x4_divs[i].ndac_rate);
 	clk_set_rate(clocks[4].clk, aic32x4_divs[i].mdac_rate);
+	clk_set_rate(clocks[5].clk, aic32x4_divs[i].bdiv_rate);
 
 	aic32x4_set_processing_blocks(component, aic32x4_divs[i].r_block, aic32x4_divs[i].p_block);
 
-	/* DAC_MOD_CLK as BDIV_CLKIN */
-	snd_soc_component_update_bits(component, AIC32X4_IFACE3,
-				AIC32X4_BDIVCLK_MASK,
-				AIC32X4_DACMOD2BCLK << AIC32X4_BDIVCLK_SHIFT);
-
 	/* DOSR MSB & LSB values */
 	snd_soc_component_write(component, AIC32X4_DOSRMSB, aic32x4_divs[i].dosr >> 8);
 	snd_soc_component_write(component, AIC32X4_DOSRLSB, (aic32x4_divs[i].dosr & 0xff));
@@ -775,10 +772,6 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	/* AOSR value */
 	snd_soc_component_write(component, AIC32X4_AOSR, aic32x4_divs[i].aosr);
 
-	/* BCLK N divider */
-	snd_soc_component_update_bits(component, AIC32X4_BCLKN,
-				AIC32X4_BCLK_MASK, aic32x4_divs[i].blck_N);
-
 	return 0;
 }
 
@@ -1001,6 +994,8 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 	struct clk_bulk_data clocks[] = {
 		{ .id = "codec_clkin" },
 		{ .id = "pll" },
+		{ .id = "bdiv" },
+		{ .id = "mdac" },
 	};
 
 	ret = devm_clk_bulk_get(component->dev, ARRAY_SIZE(clocks), clocks);
@@ -1019,6 +1014,7 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 		aic32x4_setup_gpios(component);
 
 	clk_set_parent(clocks[0].clk, clocks[1].clk);
+	clk_set_parent(clocks[2].clk, clocks[3].clk);
 
 	/* Power platform configuration */
 	if (aic32x4->power_cfg & AIC32X4_PWR_MICBIAS_2075_LDOIN) {
-- 
2.20.1
