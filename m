From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1269/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:33:14 +0800
Message-ID: <20160802123314.2636-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, afd@ti.com, jic23@kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/soc/codecs/tlv320aic26.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 2c904d7..27f9f45 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -286,7 +286,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
+static DEVICE_ATTR(keyclick, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, aic26_keyclick_show, aic26_keyclick_set);
 
 /* ---------------------------------------------------------------------
  * SoC CODEC portion of driver: probe and release routines
-- 
2.9.2
