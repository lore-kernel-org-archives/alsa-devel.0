From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] ASoC: wm8940: Enable cache usage to fix crashes on resume
Date: Thu, 16 Jun 2016 14:34:32 +0200
Message-ID: <1466080472-9817-4-git-send-email-geert+renesas@glider.be>
References: <1466080472-9817-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466080472-9817-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.wolfsonmicro.com, linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

The wm8940 driver is using a regmap cache sync to restore the
configuration of the chip when switching from OFF to STANDBY, but does
not actually define a register cache which means that the restore is
never going to work and we trigger asserts in regmap.  Fix this by
enabling caching.

Based on commit d3030d11961a8c10 ("ASoC: ak4642: Enable cache usage to
fix crashes on resume") by Mark Brown <broonie@kernel.org>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested.
---
 sound/soc/codecs/wm8940.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index f6f9395ea38ef88b..1c600819f7689b45 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -743,6 +743,7 @@ static const struct regmap_config wm8940_regmap = {
 	.max_register = WM8940_MONOMIX,
 	.reg_defaults = wm8940_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8940_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
 
 	.readable_reg = wm8940_readable_register,
 	.volatile_reg = wm8940_volatile_register,
-- 
1.9.1
