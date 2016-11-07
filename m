From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/3] ASoC: wm8978: Adjust clock indices so that simple card works
Date: Mon,  7 Nov 2016 14:08:20 +0100
Message-ID: <3d9c794b19e99745f0a98412c4cf8dcf26d728d4.1478524066.git-series.maxime.ripard@free-electrons.com>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Using simple-card with the wm8978 doesn't work because simple card calls
set_sysclk on the clock index 0, which is not the MCLK in the WM8978.

Adjust the clock definition so that the clock 0 is the MCLK.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/codecs/wm8978.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8978.h b/sound/soc/codecs/wm8978.h
index 6ae43495b7cf..0dcf6868dff6 100644
--- a/sound/soc/codecs/wm8978.h
+++ b/sound/soc/codecs/wm8978.h
@@ -78,8 +78,8 @@ enum wm8978_clk_id {
 };
 
 enum wm8978_sysclk_src {
+	WM8978_MCLK = 0,
 	WM8978_PLL,
-	WM8978_MCLK
 };
 
 #endif	/* __WM8978_H__ */
-- 
git-series 0.8.11
