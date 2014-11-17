From: Krishna Mohan Dani <krishna.md@samsung.com>
Subject: [PATCH] ASoC: rt5631: Fixing compilation warning when DT is disabled
Date: Mon, 17 Nov 2014 19:26:29 +0530
Message-ID: <1416232589-31319-1-git-send-email-krishna.md@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: kgene.kim@samsung.com, broonie@kernel.org, Claude Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fixes the following compilation warning:
Warning: 'rt5631_i2c_dt_ids' defined but not used - when DT is not used.

Signed-off-by: Claude Youn <claude.youn@gmail.com>
Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
---
 sound/soc/codecs/rt5631.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 3b7d5e4..9425545 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1691,12 +1691,14 @@ static const struct i2c_device_id rt5631_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5631_i2c_id);
 
+#ifdef CONFIG_OF
 static struct of_device_id rt5631_i2c_dt_ids[] = {
 	{ .compatible = "realtek,rt5631"},
 	{ .compatible = "realtek,alc5631"},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5631_i2c_dt_ids);
+#endif
 
 static const struct regmap_config rt5631_regmap_config = {
 	.reg_bits = 8,
-- 
1.7.9.5
