From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 3/4] ASoC: sun4i-i2s: Replace call to params_width by local variable
Date: Wed, 21 Aug 2019 15:06:55 +0200
Message-ID: <f85a1c1e014080a4bbc3abd19bc8fdcb86f0981a.1566392800.git-series.maxime.ripard@bootlin.com>
References: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, codekipper@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The sun4i_i2s_hw_params function already has a variable holding the value
returned by params_width, so let's just use that variable instead of
calling params_width multiple times.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9ef784b8867c..69162af9fd65 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -487,7 +487,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 	i2s->playback_dma_data.addr_width = width;
 
-	sr = i2s->variant->get_sr(i2s, params_width(params));
+	sr = i2s->variant->get_sr(i2s, word_size);
 	if (sr < 0)
 		return -EINVAL;
 
-- 
git-series 0.9.1
