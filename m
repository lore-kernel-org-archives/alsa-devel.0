From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Model CODEC_CLKIN in
	CCF" to the asoc tree
Date: Mon, 25 Mar 2019 16:11:40 +0000 (GMT)
Message-ID: <20190325161140.A0E0111288F1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7761F89727
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 17:11:41 +0100 (CET)
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

   ASoC: tlv320aic32x4: Model CODEC_CLKIN in CCF

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

>From fd2df3aeafa4b4cc468d58e147e0822967034b71 Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Thu, 21 Mar 2019 17:58:46 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Model CODEC_CLKIN in CCF

Model and manage codec clock input as a component in the Core
Clock Framework.  This should allow us to do some more complex
clock management and power control.  Also, some of the
on-board chip clocks can be exposed to the outside, and this
change will make those clocks easier to consume by other
parts of the kernel.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 34 ++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.c     | 18 +++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 5e495fc8d931..cded85009c8c 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -265,6 +265,30 @@ static const struct clk_ops aic32x4_pll_ops = {
 	.get_parent = clk_aic32x4_pll_get_parent,
 };
 
+static int clk_aic32x4_codec_clkin_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_aic32x4 *mux = to_clk_aic32x4(hw);
+
+	return regmap_update_bits(mux->regmap,
+		AIC32X4_CLKMUX,
+		AIC32X4_CODEC_CLKIN_MASK, index << AIC32X4_CODEC_CLKIN_SHIFT);
+}
+
+static u8 clk_aic32x4_codec_clkin_get_parent(struct clk_hw *hw)
+{
+	struct clk_aic32x4 *mux = to_clk_aic32x4(hw);
+	unsigned int val;
+
+	regmap_read(mux->regmap, AIC32X4_CLKMUX, &val);
+
+	return (val & AIC32X4_CODEC_CLKIN_MASK) >> AIC32X4_CODEC_CLKIN_SHIFT;
+}
+
+static const struct clk_ops aic32x4_codec_clkin_ops = {
+	.set_parent = clk_aic32x4_codec_clkin_set_parent,
+	.get_parent = clk_aic32x4_codec_clkin_get_parent,
+};
+
 static struct aic32x4_clkdesc aic32x4_clkdesc_array[] = {
 	{
 		.name = "pll",
@@ -274,6 +298,14 @@ static struct aic32x4_clkdesc aic32x4_clkdesc_array[] = {
 		.ops = &aic32x4_pll_ops,
 		.reg = 0,
 	},
+	{
+		.name = "codec_clkin",
+		.parent_names =
+			(const char *[]) { "mclk", "bclk", "gpio", "pll" },
+		.num_parents = 4,
+		.ops = &aic32x4_codec_clkin_ops,
+		.reg = 0,
+	},
 };
 
 static struct clk *aic32x4_register_clk(struct device *dev,
@@ -314,6 +346,8 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name)
 	 */
 	aic32x4_clkdesc_array[0].parent_names =
 			(const char* []) { mclk_name, "bclk", "gpio", "din" };
+	aic32x4_clkdesc_array[1].parent_names =
+			(const char *[]) { mclk_name, "bclk", "gpio", "pll" };
 
 	for (i = 0; i < ARRAY_SIZE(aic32x4_clkdesc_array); ++i)
 		aic32x4_register_clk(dev, &aic32x4_clkdesc_array[i]);
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 7cf8c7cedfe1..5496e4e080f4 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -735,12 +735,9 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 
 	aic32x4_set_processing_blocks(component, aic32x4_divs[i].r_block, aic32x4_divs[i].p_block);
 
-	/* PLL as CODEC_CLKIN */
-	snd_soc_component_update_bits(component, AIC32X4_CLKMUX,
-			AIC32X4_CODEC_CLKIN_MASK,
-			AIC32X4_CODEC_CLKIN_PLL << AIC32X4_CODEC_CLKIN_SHIFT);
 	/* DAC_MOD_CLK as BDIV_CLKIN */
-	snd_soc_component_update_bits(component, AIC32X4_IFACE3, AIC32X4_BDIVCLK_MASK,
+	snd_soc_component_update_bits(component, AIC32X4_IFACE3,
+				AIC32X4_BDIVCLK_MASK,
 				AIC32X4_DACMOD2BCLK << AIC32X4_BDIVCLK_SHIFT);
 
 	/* NDAC divider value */
@@ -987,6 +984,15 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
 	u32 tmp_reg;
+	int ret;
+
+	struct clk_bulk_data clocks[] = {
+	    { .id = "codec_clkin" },
+	};
+
+	ret = devm_clk_bulk_get(component->dev, ARRAY_SIZE(clocks), clocks);
+	if (ret)
+		return ret;
 
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ndelay(10);
@@ -999,6 +1005,8 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 	if (aic32x4->setup)
 		aic32x4_setup_gpios(component);
 
+	clk_set_parent(clocks[0].clk, clocks[1].clk);
+
 	/* Power platform configuration */
 	if (aic32x4->power_cfg & AIC32X4_PWR_MICBIAS_2075_LDOIN) {
 		snd_soc_component_write(component, AIC32X4_MICBIAS,
-- 
2.20.1
