From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 06/21] ASoC: sun4i-i2s: Rework MCLK divider calculation
Date: Mon, 19 Aug 2019 21:25:13 +0200
Message-ID: <dcc5deb2eb650758d268bddd20f60ba58856d024.1566242458.git-series.maxime.ripard@bootlin.com>
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

The MCLK divider calculation is currently computing the ideal divider using
the oversample rate, the sample rate and the parent rate.

However, since we have access to the frequency is supposed to be running at
already, and as it turns out we're using it to compute the oversample rate,
we can just use the ratio between the parent rate and the MCLK rate to
simplify a bit the formula.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index fbbedb660cc6..3d7f4a97e0ba 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -225,11 +225,10 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 }
 
 static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
-				  unsigned int oversample_rate,
-				  unsigned int module_rate,
-				  unsigned int sampling_rate)
+				  unsigned long parent_rate,
+				  unsigned long mclk_rate)
 {
-	int div = module_rate / sampling_rate / oversample_rate;
+	int div = parent_rate / mclk_rate;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_mclk_div); i++) {
@@ -308,8 +307,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-					  clk_rate, rate);
+	mclk_div = sun4i_i2s_get_mclk_div(i2s, clk_rate, i2s->mclk_freq);
 	if (mclk_div < 0) {
 		dev_err(dai->dev, "Unsupported MCLK divider: %d\n", mclk_div);
 		return -EINVAL;
-- 
git-series 0.9.1
