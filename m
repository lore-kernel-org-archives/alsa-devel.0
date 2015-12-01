From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/2] ASoC: sun4i-codec: pass through clk_set_rate error
Date: Tue,  1 Dec 2015 12:06:47 +0100
Message-ID: <1448968007-10128-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1448968007-10128-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448968007-10128-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Commit 1fb34b48361e ('ASoC: sun4i: Implement MIC1 capture') added back some
code that disregards the clk_set_rate error code and always returns
-EINVAL. Fix that and return the code in order to have more clue about
what's going on.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun4i-codec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 516c7c2b479a..0dc11f547937 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -411,14 +411,15 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
 	unsigned long clk_freq;
-	int hwrate;
+	int ret, hwrate;
 
 	clk_freq = sun4i_codec_get_mod_freq(params);
 	if (!clk_freq)
 		return -EINVAL;
 
-	if (clk_set_rate(scodec->clk_module, clk_freq))
-		return -EINVAL;
+	ret = clk_set_rate(scodec->clk_module, clk_freq);
+	if (ret)
+		return ret;
 
 	hwrate = sun4i_codec_get_hw_rate(params);
 	if (hwrate < 0)
-- 
2.6.3
