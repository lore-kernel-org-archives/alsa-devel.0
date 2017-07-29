From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v3 09/12] ASoC: sun4i-i2s: Add regmap field to
 set format
Date: Sat, 29 Jul 2017 16:17:50 +0200
Message-ID: <20170729141753.20174-10-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBIFS6LFQKGQE7YAYL7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170729141753.20174-1-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

On the newer SoCs the bits to configure the operational mode are
located in a different register. Add a regmap field so that this
location can be configured.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 6d8d2c4a675b..9e060d1b73d5 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -106,6 +106,7 @@
  * @field_fmt_set_sr: regmap field to set sample resolution.
  * @field_fmt_set_bclk_polarity: regmap field to set clk polarity.
  * @field_fmt_set_lrclk_polarity: regmap field to set frame polarity.
+ * @field_fmt_set_mode: regmap field to set the operational mode.
  * @field_txchanmap: location of the tx channel mapping register.
  * @field_rxchanmap: location of the rx channel mapping register.
  * @field_txchansel: location of the tx channel select bit fields.
@@ -125,6 +126,7 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_fmt_set_sr;
 	struct reg_field		field_fmt_set_bclk_polarity;
 	struct reg_field		field_fmt_set_lrclk_polarity;
+	struct reg_field		field_fmt_set_mode;
 	struct reg_field		field_txchanmap;
 	struct reg_field		field_rxchanmap;
 	struct reg_field		field_txchansel;
@@ -148,6 +150,7 @@ struct sun4i_i2s {
 	struct regmap_field	*field_fmt_set_sr;
 	struct regmap_field	*field_fmt_set_bclk_polarity;
 	struct regmap_field	*field_fmt_set_lrclk_polarity;
+	struct regmap_field	*field_fmt_set_mode;
 	struct regmap_field	*field_txchanmap;
 	struct regmap_field	*field_rxchanmap;
 	struct regmap_field	*field_txchansel;
@@ -362,9 +365,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN4I_I2S_FMT0_FMT_MASK,
-			   val);
+	regmap_field_write(i2s->field_fmt_set_mode, val);
 
 	/* DAI clock polarity */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -721,6 +722,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_fmt_set_sr	= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_set_bclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_set_lrclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.field_fmt_set_mode	= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -738,6 +740,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_fmt_set_sr	= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_set_bclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_set_lrclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.field_fmt_set_mode	= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -770,6 +773,12 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev, struct sun4i_i2s *i2
 	if (IS_ERR(i2s->field_fmt_set_lrclk_polarity))
 		return PTR_ERR(i2s->field_fmt_set_lrclk_polarity);
 
+	i2s->field_fmt_set_mode =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->variant->field_fmt_set_mode);
+	if (IS_ERR(i2s->field_fmt_set_mode))
+		return PTR_ERR(i2s->field_fmt_set_mode);
+
 	i2s->field_clkdiv_mclk_en =
 		devm_regmap_field_alloc(dev, i2s->regmap,
 					i2s->variant->field_clkdiv_mclk_en);
-- 
2.13.3
