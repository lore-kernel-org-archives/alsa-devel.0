From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2] ASoC: sun4i-i2s: Change SR and WSS computation
Date: Wed,  5 Jun 2019 12:08:01 +0200
Message-ID: <20190605100801.2488-1-maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The current computation for the SR (sample resolution) and the WSS (word
slot size) register parameters is based on a switch returning the matching
parameters for a given params width.

Later SoCs (A83t, H3, A64) changed that calculation, which was loosely the
same with an offset. Therefore, an offset was added to adjust those
parameters.

However, the calculation is a bit less trivial than initially thought.
Indeed, while we assumed that SR and WSS were always the same, on older
SoCs, SR will max at 24 (since those SoCs do not support 32 bits formats),
but the word size can be 32.

Newer SoCs can also support a much larger range (8 bits to 32 bits, by
increments of 4) of size than the older SoCs could.

Finally, the A64 and A83t were never adjusted to have that offset in the
first place, and were therefore broken from that point of view.

In order to fix all those issues, let's introduce two functions, get_wss
and get_sr, with their respective implementations for all the SoCs
supported so far.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Fixes: 66ecce332538 ("ASoC: sun4i-i2s: Add compatibility with A64 codec I2S")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v1:
  - Declare the structure sun4i_i2s to fix compilation errors
---
 sound/soc/sunxi/sun4i-i2s.c | 71 ++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index c53bfed8d4c2..78d44dbc6373 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -114,6 +114,8 @@
 #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
 #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
 
+struct sun4i_i2s;
+
 /**
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  *
@@ -127,7 +129,6 @@
  * @sun4i_i2s_regmap: regmap config to use.
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
  * @bclk_offset: Value by which bclkdiv needs to be adjusted.
- * @fmt_offset: Value by which wss and sr needs to be adjusted.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
@@ -150,7 +151,6 @@ struct sun4i_i2s_quirks {
 	const struct regmap_config	*sun4i_i2s_regmap;
 	unsigned int			mclk_offset;
 	unsigned int			bclk_offset;
-	unsigned int			fmt_offset;
 
 	/* Register fields for i2s */
 	struct reg_field		field_clkdiv_mclk_en;
@@ -163,6 +163,9 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_rxchanmap;
 	struct reg_field		field_txchansel;
 	struct reg_field		field_rxchansel;
+
+	s8	(*get_sr)(const struct sun4i_i2s *, int);
+	s8	(*get_wss)(const struct sun4i_i2s *, int);
 };
 
 struct sun4i_i2s {
@@ -345,6 +348,39 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static s8 sun4i_i2s_get_sr(const struct sun4i_i2s *i2s, int width)
+{
+	if (width < 16 || width > 24)
+		return -EINVAL;
+
+	if (width % 4)
+		return -EINVAL;
+
+	return (width - 16) / 4;
+}
+
+static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
+{
+	if (width < 16 || width > 32)
+		return -EINVAL;
+
+	if (width % 4)
+		return -EINVAL;
+
+	return (width - 16) / 4;
+}
+
+static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
+{
+	if (width % 4)
+		return -EINVAL;
+
+	if (width < 8 || width > 32)
+		return -EINVAL;
+
+	return (width - 8) / 4 + 1;
+}
+
 static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
@@ -396,22 +432,16 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 	i2s->playback_dma_data.addr_width = width;
 
-	switch (params_width(params)) {
-	case 16:
-		sr = 0;
-		wss = 0;
-		break;
+	sr = i2s->variant->get_sr(i2s, params_width(params));
+	if (sr < 0)
+		return -EINVAL;
 
-	default:
-		dev_err(dai->dev, "Unsupported sample width: %d\n",
-			params_width(params));
+	wss = i2s->variant->get_wss(i2s, params_width(params));
+	if (wss < 0)
 		return -EINVAL;
-	}
 
-	regmap_field_write(i2s->field_fmt_wss,
-			   wss + i2s->variant->fmt_offset);
-	regmap_field_write(i2s->field_fmt_sr,
-			   sr + i2s->variant->fmt_offset);
+	regmap_field_write(i2s->field_fmt_wss, wss);
+	regmap_field_write(i2s->field_fmt_sr, sr);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
 				      params_width(params));
@@ -887,6 +917,8 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
+	.get_sr			= sun4i_i2s_get_sr,
+	.get_wss		= sun4i_i2s_get_wss,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
@@ -904,6 +936,8 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
+	.get_sr			= sun4i_i2s_get_sr,
+	.get_wss		= sun4i_i2s_get_wss,
 };
 
 static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
@@ -921,6 +955,8 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
+	.get_sr			= sun8i_i2s_get_sr_wss,
+	.get_wss		= sun8i_i2s_get_sr_wss,
 };
 
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
@@ -929,7 +965,6 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
 	.mclk_offset		= 1,
 	.bclk_offset		= 2,
-	.fmt_offset		= 3,
 	.has_fmt_set_lrck_period = true,
 	.has_chcfg		= true,
 	.has_chsel_tx_chen	= true,
@@ -944,6 +979,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_rxchanmap	= REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
 	.field_rxchansel	= REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
+	.get_sr			= sun8i_i2s_get_sr_wss,
+	.get_wss		= sun8i_i2s_get_sr_wss,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
@@ -961,6 +998,8 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
+	.get_sr			= sun8i_i2s_get_sr_wss,
+	.get_wss		= sun8i_i2s_get_sr_wss,
 };
 
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
-- 
2.21.0
