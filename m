From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH] ASoC: sun4i-i2s: Show detailed error when DAI
 configuration callbacks fail
Date: Thu, 14 Dec 2017 15:29:28 +0800
Message-ID: <20171214072928.6613-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBXOQZDIQKGQEULMOOYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

When any of the DAI hardware configuration callbacks (.hw_param,
.set_fmt, .set_sysclk) fails, there is no explanation about why it
failed. This is particularly confusing for .hw_param, which covers
many parameters of the DAI. Telling the users what parameter isn't
supported, and what the requested value was goes a long way for
developers trying to combine sun4i-i2s with external codecs.

This patch adds dev_err calls explaining what isn't supported or
failed, and what the value was. sun4i_i2s_set_clk_rate()'s first
parameter was changed to a struct snd_soc_dai *dai, so we can
get the underlying device.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 13d7ecabe1b6..dca1143c1150 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -269,10 +269,11 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
 	return false;
 }
 
-static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
+static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				  unsigned int rate,
 				  unsigned int word_size)
 {
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	unsigned int oversample_rate, clk_rate;
 	int bclk_div, mclk_div;
 	int ret;
@@ -300,6 +301,7 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 		break;
 
 	default:
+		dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
 		return -EINVAL;
 	}
 
@@ -308,18 +310,25 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 		return ret;
 
 	oversample_rate = i2s->mclk_freq / rate;
-	if (!sun4i_i2s_oversample_is_valid(oversample_rate))
+	if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
+		dev_err(dai->dev, "Unsupported oversample rate: %d\n",
+			oversample_rate);
 		return -EINVAL;
+	}
 
 	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
 					  word_size);
-	if (bclk_div < 0)
+	if (bclk_div < 0) {
+		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
+	}
 
 	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
 					  clk_rate, rate);
-	if (mclk_div < 0)
+	if (mclk_div < 0) {
+		dev_err(dai->dev, "Unsupported MCLK divider: %d\n", mclk_div);
 		return -EINVAL;
+	}
 
 	/* Adjust the clock division values if needed */
 	bclk_div += i2s->variant->bclk_offset;
@@ -349,8 +358,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	u32 width;
 
 	channels = params_channels(params);
-	if (channels != 2)
+	if (channels != 2) {
+		dev_err(dai->dev, "Unsupported number of channels: %d\n",
+			channels);
 		return -EINVAL;
+	}
 
 	if (i2s->variant->has_chcfg) {
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
@@ -382,6 +394,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	default:
+		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
+			params_physical_width(params));
 		return -EINVAL;
 	}
 	i2s->playback_dma_data.addr_width = width;
@@ -393,6 +407,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 
 	default:
+		dev_err(dai->dev, "Unsupported sample width: %d\n",
+			params_width(params));
 		return -EINVAL;
 	}
 
@@ -401,7 +417,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_fmt_sr,
 			   sr + i2s->variant->fmt_offset);
 
-	return sun4i_i2s_set_clk_rate(i2s, params_rate(params),
+	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
 				      params_width(params));
 }
 
@@ -426,6 +442,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		val = SUN4I_I2S_FMT0_FMT_RIGHT_J;
 		break;
 	default:
+		dev_err(dai->dev, "Unsupported format: %d\n",
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
 		return -EINVAL;
 	}
 
@@ -464,6 +482,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	default:
+		dev_err(dai->dev, "Unsupported clock polarity: %d\n",
+			fmt & SND_SOC_DAIFMT_INV_MASK);
 		return -EINVAL;
 	}
 
@@ -482,6 +502,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			val = SUN4I_I2S_CTRL_MODE_SLAVE;
 			break;
 		default:
+			dev_err(dai->dev, "Unsupported slave setting: %d\n",
+				fmt & SND_SOC_DAIFMT_MASTER_MASK);
 			return -EINVAL;
 		}
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
@@ -504,6 +526,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			val = 0;
 			break;
 		default:
+			dev_err(dai->dev, "Unsupported slave setting: %d\n",
+				fmt & SND_SOC_DAIFMT_MASTER_MASK);
 			return -EINVAL;
 		}
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-- 
2.15.0
