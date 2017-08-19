From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v5 4/8] ASoC: sun4i-i2s: Add mclk enable regmap field
Date: Sat, 19 Aug 2017 14:48:35 +0200
Message-ID: <20170819124839.4034-5-codekipper@gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBMXH4DGAKGQEJRRIIQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The location of the mclk output enable bit is different on newer
SoCs. Use a regmap field to enable it.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8c7ad5bfe821..761b7c0f6a32 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -101,6 +101,7 @@
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
  * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  * @fmt_offset: Value by which wss and sr needs to be adjusted.
+ * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
  * @field_fmt_bclk: regmap field to set clk polarity.
@@ -119,6 +120,7 @@ struct sun4i_i2s_quirks {
 	unsigned int			fmt_offset;
 
 	/* Register fields for i2s */
+	struct reg_field		field_clkdiv_mclk_en;
 	struct reg_field		field_fmt_wss;
 	struct reg_field		field_fmt_sr;
 	struct reg_field		field_fmt_bclk;
@@ -141,6 +143,7 @@ struct sun4i_i2s {
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 
 	/* Register fields for i2s */
+	struct regmap_field	*field_clkdiv_mclk_en;
 	struct regmap_field	*field_fmt_wss;
 	struct regmap_field	*field_fmt_sr;
 	struct regmap_field	*field_fmt_bclk;
@@ -283,8 +286,9 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
 		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK_EN);
+		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
+
+	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
 
 	return 0;
 }
@@ -713,6 +717,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_reset		= false,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
@@ -727,6 +732,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
@@ -740,6 +746,12 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
 					struct sun4i_i2s *i2s)
 {
+	i2s->field_clkdiv_mclk_en =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->variant->field_clkdiv_mclk_en);
+	if (IS_ERR(i2s->field_clkdiv_mclk_en))
+		return PTR_ERR(i2s->field_clkdiv_mclk_en);
+
 	i2s->field_fmt_wss =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_fmt_wss);
-- 
2.14.1
