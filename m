From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v5 06/15] ASoC: sun4i-i2s: Add functions for RX
 and TX channel enables
Date: Wed, 14 Aug 2019 08:08:45 +0200
Message-ID: <20190814060854.26345-7-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBBOLZ3VAKGQEHNREJUA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190814060854.26345-1-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Newer SoCs like the H6 have the channel enable bits in a different
position to what is on the H3. As we will eventually add multi-
channel support then create function calls as opposed to regmap
fields to add support for different devices.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 4a748747ccd7..ad2ff83deeb7 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -172,6 +172,8 @@ struct sun4i_i2s_quirks {
 	int	(*set_format)(struct sun4i_i2s *, unsigned int);
 	void	(*set_txchanoffset)(const struct sun4i_i2s *, int);
 	void	(*set_rxchanoffset)(const struct sun4i_i2s *);
+	void	(*set_txchanen)(const struct sun4i_i2s *, int, int);
+	void	(*set_rxchanen)(const struct sun4i_i2s *, int);
 };
 
 struct sun4i_i2s {
@@ -444,6 +446,25 @@ static void sun8i_i2s_set_rxchanoffset(const struct sun4i_i2s *i2s)
 			   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
 }
 
+static void sun8i_i2s_set_txchanen(const struct sun4i_i2s *i2s, int output,
+				   int channel)
+{
+	if (output >= 0 && output < 4) {
+		regmap_update_bits(i2s->regmap,
+				   SUN8I_I2S_TX_CHAN_SEL_REG + (output * 4),
+				   SUN8I_I2S_TX_CHAN_EN_MASK,
+				   SUN8I_I2S_TX_CHAN_EN(channel));
+	}
+}
+
+static void sun8i_i2s_set_rxchanen(const struct sun4i_i2s *i2s, int channel)
+{
+	regmap_update_bits(i2s->regmap,
+			   SUN8I_I2S_RX_CHAN_SEL_REG,
+			   SUN8I_I2S_TX_CHAN_EN_MASK,
+			   SUN8I_I2S_TX_CHAN_EN(channel));
+}
+
 static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
@@ -479,10 +500,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_rxchansel,
 			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
 
-	if (i2s->variant->has_chsel_tx_chen)
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_EN_MASK,
-				   SUN8I_I2S_TX_CHAN_EN(channels));
+	if (i2s->variant->set_txchanen)
+		i2s->variant->set_txchanen(i2s, 0, channels);
+
+	if (i2s->variant->set_rxchanen)
+		i2s->variant->set_rxchanen(i2s, channels);
 
 	switch (params_physical_width(params)) {
 	case 16:
@@ -1098,6 +1120,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.set_format		= sun8i_i2s_set_format,
 	.set_txchanoffset	= sun8i_i2s_set_txchanoffset,
 	.set_rxchanoffset	= sun8i_i2s_set_rxchanoffset,
+	.set_txchanen		= sun8i_i2s_set_txchanen,
+	.set_rxchanen		= sun8i_i2s_set_rxchanen,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
-- 
2.22.0
