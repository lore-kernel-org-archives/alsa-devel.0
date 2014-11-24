From: Krishna Mohan Dani <krishna.md@samsung.com>
Subject: [PATCH] ASoC: rt5631: Fixing compilation warning when DT is disabled
Date: Mon, 24 Nov 2014 16:52:42 +0530
Message-ID: <1416828162-8216-1-git-send-email-krishna.md@samsung.com>
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
 sound/soc/codecs/rt5631.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 3b7d5e4..5c65915 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1691,7 +1691,7 @@ static const struct i2c_device_id rt5631_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5631_i2c_id);
 
-static struct of_device_id rt5631_i2c_dt_ids[] = {
+static struct of_device_id rt5631_i2c_dt_ids[] __maybe_unused = {
 	{ .compatible = "realtek,rt5631"},
 	{ .compatible = "realtek,alc5631"},
 	{ }
-- 
1.7.9.5
