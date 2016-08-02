From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1270/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:33:21 +0800
Message-ID: <20160802123321.2705-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, jiada_wang@mentor.com, fabio.estevam@nxp.com, linus.walleij@linaro.org, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index f3109da..58ac63c 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3231,7 +3231,7 @@ static ssize_t wm8962_beep_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(beep, 0200, NULL, wm8962_beep_set);
+static DEVICE_ATTR(beep, S_IWUSR, NULL, wm8962_beep_set);
 
 static void wm8962_init_beep(struct snd_soc_codec *codec)
 {
-- 
2.9.2
