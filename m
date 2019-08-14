From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v5 13/15] ASoC: sun4i-i2s: Add multichannel functionality
Date: Wed, 14 Aug 2019 08:08:52 +0200
Message-ID: <20190814060854.26345-14-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBDWLZ3VAKGQEEODYPCY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The i2s block can be used to pass PCM data over multiple channels
and is sometimes used for the audio side of an HDMI connection.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 93 +++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 30 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a020c3b372a8..a71969167053 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -617,41 +617,74 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	int lines;
 
 	channels = params_channels(params);
-	if (channels != 2) {
-		dev_err(dai->dev, "Unsupported number of channels: %d\n",
-			channels);
-		return -EINVAL;
-	}
-
-	lines = (channels + 1) / 2;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if ((channels > dai->driver->playback.channels_max) ||
+			(channels < dai->driver->playback.channels_min)) {
+			dev_err(dai->dev, "Unsupported number of channels: %d\n",
+				channels);
+			return -EINVAL;
+		}
 
-	/* Enable the required output lines */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_SDO_EN_MASK,
-			   SUN4I_I2S_CTRL_SDO_EN(lines));
-
-	if (i2s->variant->has_chcfg) {
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
-	}
+		lines = (channels + 1) / 2;
 
-	/* Map the channels for playback and capture */
-	i2s->variant->set_txchanmap(i2s, 0, 0x76543210);
-	i2s->variant->set_rxchanmap(i2s, 0x00003210);
+		/* Enable the required output lines */
+		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+				   SUN4I_I2S_CTRL_SDO_EN_MASK,
+				   SUN4I_I2S_CTRL_SDO_EN(lines));
+
+		i2s->variant->set_txchanmap(i2s, 0, 0x10);
+		i2s->variant->set_txchansel(i2s, 0, channels > 1 ? 2:1);
+
+		if (i2s->variant->set_txchanen)
+			i2s->variant->set_txchanen(i2s, 0, 2);
+
+		if (i2s->variant->has_chcfg) {
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+					   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
+					   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
+
+			if (channels > 2) {
+				i2s->variant->set_txchanmap(i2s, 1, 0x32);
+				i2s->variant->set_txchanoffset(i2s, 1);
+				i2s->variant->set_txchansel(i2s, 1,
+							    channels > 3 ? 2:1);
+				i2s->variant->set_txchanen(i2s, 1, 2);
+			}
+			if (channels > 4) {
+				i2s->variant->set_txchanmap(i2s, 2, 0x54);
+				i2s->variant->set_txchanoffset(i2s, 2);
+				i2s->variant->set_txchansel(i2s, 2,
+							    channels > 5 ? 2:1);
+				i2s->variant->set_txchanen(i2s, 2, 2);
+			}
+			if (channels > 6) {
+				i2s->variant->set_txchanmap(i2s, 3, 0x76);
+				i2s->variant->set_txchanoffset(i2s, 3);
+				i2s->variant->set_txchansel(i2s, 3,
+							    channels > 6 ? 2:1);
+				i2s->variant->set_txchanen(i2s, 3, 2);
+			}
+		}
+	} else {
+		if ((channels > dai->driver->capture.channels_max) ||
+			(channels < dai->driver->capture.channels_min)) {
+			dev_err(dai->dev, "Unsupported number of channels: %d\n",
+				channels);
+			return -EINVAL;
+		}
 
-	/* Configure the channels */
-	i2s->variant->set_txchansel(i2s, 0, channels);
-	i2s->variant->set_rxchansel(i2s, channels);
+		/* Map the channels for capture */
+		i2s->variant->set_rxchanmap(i2s, 0x10);
+		i2s->variant->set_rxchansel(i2s, channels);
 
-	if (i2s->variant->set_txchanen)
-		i2s->variant->set_txchanen(i2s, 0, channels);
+		if (i2s->variant->set_rxchanen)
+			i2s->variant->set_rxchanen(i2s, channels);
 
-	if (i2s->variant->set_rxchanen)
-		i2s->variant->set_rxchanen(i2s, channels);
+		if (i2s->variant->has_chcfg)
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+					   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
+					   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
+	}
 
 	switch (params_physical_width(params)) {
 	case 16:
-- 
2.22.0
