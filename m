From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v3 7/9] ASoC: sun4i-i2s: Do not divide clocks
 when slave
Date: Fri, 21 Dec 2018 16:21:08 +0100
Message-ID: <20181221152110.17982-8-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBB4UJ6TQAKGQEO6BL5JA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20181221152110.17982-1-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

There is no need to set the clock and calculate the division of
the audio pll for the bclk and sync signals when they are not
required.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 144 +++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 67 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index e85789d84c0c..8cec2f42c94e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -194,6 +194,8 @@ struct sun4i_i2s {
 	struct regmap_field	*field_rxchansel;
 
 	const struct sun4i_i2s_quirks	*variant;
+
+	bool bit_clk_master;
 };
 
 struct sun4i_i2s_clk_div {
@@ -298,82 +300,86 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	int bclk_div, mclk_div;
 	int ret;
 
-	switch (rate) {
-	case 176400:
-	case 88200:
-	case 44100:
-	case 22050:
-	case 11025:
-		clk_rate = 22579200;
-		break;
+	if (i2s->bit_clk_master) {
+		switch (rate) {
+		case 176400:
+		case 88200:
+		case 44100:
+		case 22050:
+		case 11025:
+			clk_rate = 22579200;
+			break;
 
-	case 192000:
-	case 128000:
-	case 96000:
-	case 64000:
-	case 48000:
-	case 32000:
-	case 24000:
-	case 16000:
-	case 12000:
-	case 8000:
-		clk_rate = 24576000;
-		break;
+		case 192000:
+		case 128000:
+		case 96000:
+		case 64000:
+		case 48000:
+		case 32000:
+		case 24000:
+		case 16000:
+		case 12000:
+		case 8000:
+			clk_rate = 24576000;
+			break;
 
-	default:
-		dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
-		return -EINVAL;
-	}
+		default:
+			dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
+			return -EINVAL;
+		}
 
-	ret = clk_set_rate(i2s->mod_clk, clk_rate);
-	if (ret)
-		return ret;
+		ret = clk_set_rate(i2s->mod_clk, clk_rate);
+		if (ret) {
+			dev_err(dai->dev, "Unable to set clock\n");
+			return ret;
+		}
 
-	oversample_rate = i2s->mclk_freq / rate;
-	if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
-		dev_err(dai->dev, "Unsupported oversample rate: %d\n",
-			oversample_rate);
-		return -EINVAL;
-	}
+		oversample_rate = i2s->mclk_freq / rate;
+		if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
+			dev_err(dai->dev, "Unsupported oversample rate: %d\n",
+				oversample_rate);
+			return -EINVAL;
+		}
 
-	if (i2s->variant->has_fmt_set_lrck_period)
-		bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
-						  word_size,
-						  sun8i_i2s_clk_div,
-						  ARRAY_SIZE(sun8i_i2s_clk_div));
-	else
-		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-						  word_size,
-						  sun4i_i2s_bclk_div,
-						  ARRAY_SIZE(sun4i_i2s_bclk_div));
-	if (bclk_div < 0) {
-		dev_err(dai->dev, "Unsupported BCLK divider: %d\n",
-			bclk_div);
-		return -EINVAL;
-	}
+		if (i2s->variant->has_fmt_set_lrck_period)
+			bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
+							  word_size,
+							  sun8i_i2s_clk_div,
+							  ARRAY_SIZE(sun8i_i2s_clk_div));
+		else
+			bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
+							  word_size,
+							  sun4i_i2s_bclk_div,
+							  ARRAY_SIZE(sun4i_i2s_bclk_div));
+		if (bclk_div < 0) {
+			dev_err(dai->dev, "Unsupported BCLK divider: %d\n",
+				bclk_div);
+			return -EINVAL;
+		}
 
 
-	if (i2s->variant->has_fmt_set_lrck_period)
-		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-						  clk_rate, rate,
-						  sun8i_i2s_clk_div,
-						  ARRAY_SIZE(sun8i_i2s_clk_div));
-	else
-		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-						  clk_rate, rate,
-						  sun4i_i2s_mclk_div,
-						  ARRAY_SIZE(sun4i_i2s_mclk_div));
-	if (mclk_div < 0) {
-		dev_err(dai->dev, "Unsupported MCLK divider: %d\n",
-			mclk_div);
-		return -EINVAL;
-	}
+		if (i2s->variant->has_fmt_set_lrck_period)
+			mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+							  clk_rate, rate,
+							  sun8i_i2s_clk_div,
+							  ARRAY_SIZE(sun8i_i2s_clk_div));
+		else
+			mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+							  clk_rate, rate,
+							  sun4i_i2s_mclk_div,
+							  ARRAY_SIZE(sun4i_i2s_mclk_div));
+		if (mclk_div < 0) {
+			dev_err(dai->dev, "Unsupported MCLK divider: %d\n",
+				mclk_div);
+			return -EINVAL;
+		}
 
-	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
-		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
+		regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
+			     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
+			     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
 
-	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
+		regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
+	}
 
 	/* Set sync period */
 	if (i2s->variant->has_fmt_set_lrck_period)
@@ -574,10 +580,12 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		case SND_SOC_DAIFMT_CBS_CFS:
 			/* BCLK and LRCLK master */
 			val = SUN4I_I2S_CTRL_MODE_MASTER;
+			i2s->bit_clk_master = true;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* BCLK and LRCLK slave */
 			val = SUN4I_I2S_CTRL_MODE_SLAVE;
+			i2s->bit_clk_master = false;
 			break;
 		default:
 			dev_err(dai->dev, "Unsupported slave setting: %d\n",
@@ -598,10 +606,12 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			/* BCLK and LRCLK master */
 			val = SUN8I_I2S_CTRL_BCLK_OUT |
 				SUN8I_I2S_CTRL_LRCK_OUT;
+			i2s->bit_clk_master = true;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* BCLK and LRCLK slave */
 			val = 0;
+			i2s->bit_clk_master = false;
 			break;
 		default:
 			dev_err(dai->dev, "Unsupported slave setting: %d\n",
-- 
2.20.1
