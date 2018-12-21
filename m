From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v3 8/9] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Date: Fri, 21 Dec 2018 16:21:09 +0100
Message-ID: <20181221152110.17982-9-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBB44J6TQAKGQETVVL6DY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Some codecs require a different amount of a bit clocks per frame than
what is calculated by the sample width. Use the tdm slot bindings to
provide this mechanism.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8cec2f42c94e..cfcf427270fd 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -196,6 +196,9 @@ struct sun4i_i2s {
 	const struct sun4i_i2s_quirks	*variant;
 
 	bool bit_clk_master;
+
+	unsigned int	tdm_slots;
+	unsigned int	slot_width;
 };
 
 struct sun4i_i2s_clk_div {
@@ -385,7 +388,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	if (i2s->variant->has_fmt_set_lrck_period)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
+				   SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
 
 	/* Set sign extension to pad out LSB with 0 */
 	regmap_field_write(i2s->field_fmt_sext, 0);
@@ -498,7 +501,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			   sr + i2s->variant->fmt_offset);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      i2s->tdm_slots ?
+				      i2s->slot_width : params_width(params));
 }
 
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -749,11 +753,25 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int tx_mask, unsigned int rx_mask,
+	int slots, int width)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	i2s->tdm_slots = slots;
+
+	i2s->slot_width = width;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
 	.set_sysclk	= sun4i_i2s_set_sysclk,
 	.trigger	= sun4i_i2s_trigger,
+	.set_tdm_slot	= sun4i_i2s_set_dai_tdm_slot,
 };
 
 static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
-- 
2.20.1
