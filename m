From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 11/21] ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
Date: Mon, 19 Aug 2019 21:25:18 +0200
Message-ID: <fcf77b3bee47b54d81d1a3f4f107312f44388f5a.1566242458.git-series.maxime.ripard@bootlin.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, codekipper@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The LRCK period field in the FMT0 register holds the number of LRCK period
for one channel in I2S mode.

This has been hardcoded to 32, while it really should be the physical width
of the format, which creates an improper clock when using a 16bit format,
with the i2s controller as LRCK master.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 08fc04ad3585..2996beb4f092 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -357,7 +357,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	if (i2s->variant->has_fmt_set_lrck_period)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
+				   SUN8I_I2S_FMT0_LRCK_PERIOD(params_physical_width(params)));
 
 	return 0;
 }
-- 
git-series 0.9.1
