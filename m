From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] ASoC: ak4613: Enable cache usage to fix crashes on resume
Date: Thu, 16 Jun 2016 14:34:30 +0200
Message-ID: <1466080472-9817-2-git-send-email-geert+renesas@glider.be>
References: <1466080472-9817-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466080472-9817-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.wolfsonmicro.com, linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

During system resume:

    kernel BUG at drivers/base/regmap/regcache.c:347!
    ...
    PC is at regcache_sync+0x1c/0x128
    LR is at ak4613_resume+0x28/0x34

The ak4613 driver is using a regmap cache sync to restore the
configuration of the chip on resume but does not actually define a
register cache which means that the resume is never going to work and we
trigger asserts in regmap.  Fix this by enabling caching.

Based on commit d3030d11961a8c10 ("ASoC: ak4642: Enable cache usage to
fix crashes on resume") by Mark Brown <broonie@kernel.org>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/codecs/ak4613.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 33d2f2e10e2419d8..5013d2ba0c10a968 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -146,6 +146,7 @@ static const struct regmap_config ak4613_regmap_cfg = {
 	.max_register		= 0x16,
 	.reg_defaults		= ak4613_reg,
 	.num_reg_defaults	= ARRAY_SIZE(ak4613_reg),
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct of_device_id ak4613_of_match[] = {
-- 
1.9.1
