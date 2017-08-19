From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v5 3/8] ASoC: sun4i-i2s: bclk and lrclk polarity tidyup
Date: Sat, 19 Aug 2017 14:48:34 +0200
Message-ID: <20170819124839.4034-4-codekipper@gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBL7H4DGAKGQEXLCYC3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170819124839.4034-1-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On newer SoCs the bit fields for the blck and lrclk polarity are in
a different locations. Use regmap fields to set the polarity bits
as intended.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 563de785d639..8c7ad5bfe821 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -50,6 +50,8 @@
 #define SUN4I_I2S_FMT0_FMT_RIGHT_J			(2 << 0)
 #define SUN4I_I2S_FMT0_FMT_LEFT_J			(1 << 0)
 #define SUN4I_I2S_FMT0_FMT_I2S				(0 << 0)
+#define SUN4I_I2S_FMT0_POLARITY_INVERTED		(1)
+#define SUN4I_I2S_FMT0_POLARITY_NORMAL			(0)
 
 #define SUN4I_I2S_FMT1_REG		0x08
 #define SUN4I_I2S_FIFO_TX_REG		0x0c
@@ -101,6 +103,8 @@
  * @fmt_offset: Value by which wss and sr needs to be adjusted.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
+ * @field_fmt_bclk: regmap field to set clk polarity.
+ * @field_fmt_lrclk: regmap field to set frame polarity.
  * @field_txchanmap: location of the tx channel mapping register.
  * @field_rxchanmap: location of the rx channel mapping register.
  * @field_txchansel: location of the tx channel select bit fields.
@@ -117,6 +121,8 @@ struct sun4i_i2s_quirks {
 	/* Register fields for i2s */
 	struct reg_field		field_fmt_wss;
 	struct reg_field		field_fmt_sr;
+	struct reg_field		field_fmt_bclk;
+	struct reg_field		field_fmt_lrclk;
 	struct reg_field		field_txchanmap;
 	struct reg_field		field_rxchanmap;
 	struct reg_field		field_txchansel;
@@ -137,6 +143,8 @@ struct sun4i_i2s {
 	/* Register fields for i2s */
 	struct regmap_field	*field_fmt_wss;
 	struct regmap_field	*field_fmt_sr;
+	struct regmap_field	*field_fmt_bclk;
+	struct regmap_field	*field_fmt_lrclk;
 	struct regmap_field	*field_txchanmap;
 	struct regmap_field	*field_rxchanmap;
 	struct regmap_field	*field_txchansel;
@@ -335,6 +343,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	u32 val;
+	u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
+	u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -359,32 +369,25 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_IF:
 		/* Invert both clocks */
-		val = SUN4I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-			SUN4I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		bclk_polarity = SUN4I_I2S_FMT0_POLARITY_INVERTED;
+		lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		/* Invert bit clock */
-		val = SUN4I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-			SUN4I_I2S_FMT0_LRCLK_POLARITY_NORMAL;
+		bclk_polarity = SUN4I_I2S_FMT0_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
 		/* Invert frame clock */
-		val = SUN4I_I2S_FMT0_LRCLK_POLARITY_INVERTED |
-			SUN4I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+		lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_NB_NF:
-		/* Nothing to do for both normal cases */
-		val = SUN4I_I2S_FMT0_BCLK_POLARITY_NORMAL |
-			SUN4I_I2S_FMT0_LRCLK_POLARITY_NORMAL;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN4I_I2S_FMT0_BCLK_POLARITY_MASK |
-			   SUN4I_I2S_FMT0_LRCLK_POLARITY_MASK,
-			   val);
+	regmap_field_write(i2s->field_fmt_bclk, bclk_polarity);
+	regmap_field_write(i2s->field_fmt_lrclk, lrclk_polarity);
 
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -712,6 +715,8 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
+	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
+	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -724,6 +729,8 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
+	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
+	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -745,6 +752,18 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	if (IS_ERR(i2s->field_fmt_sr))
 		return PTR_ERR(i2s->field_fmt_sr);
 
+	i2s->field_fmt_bclk =
+			devm_regmap_field_alloc(dev, i2s->regmap,
+						i2s->variant->field_fmt_bclk);
+	if (IS_ERR(i2s->field_fmt_bclk))
+		return PTR_ERR(i2s->field_fmt_bclk);
+
+	i2s->field_fmt_lrclk =
+			devm_regmap_field_alloc(dev, i2s->regmap,
+						i2s->variant->field_fmt_lrclk);
+	if (IS_ERR(i2s->field_fmt_lrclk))
+		return PTR_ERR(i2s->field_fmt_lrclk);
+
 	i2s->field_txchanmap =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_txchanmap);
-- 
2.14.1
