From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 1/3] ASoC: samsung: Remove unused "samsung-i2sv4"
 platform_device_id entry
Date: Fri, 08 Apr 2016 18:52:43 +0200
Message-ID: <1460134365-31500-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

"samsung-i2sv4" identifier was previously used for the I2S device
of the S5PV210 SoCs, it can be removed now when s5pv210 is a dt-only
platform.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 70a2559..ededac9 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1492,9 +1492,6 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
 	}, {
 		.name           = "samsung-i2s-sec",
 		.driver_data    = (kernel_ulong_t)&samsung_dai_type_sec,
-	}, {
-		.name		= "samsung-i2sv4",
-		.driver_data	= (kernel_ulong_t)&i2sv5_dai_type,
 	},
 	{},
 };
-- 
1.9.1
