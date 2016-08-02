From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1273/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:33:36 +0800
Message-ID: <20160802123336.2911-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, fabio.estevam@nxp.com, linus.walleij@linaro.org, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c446485..3d0ebc7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2263,7 +2263,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
+static DEVICE_ATTR(dapm_widget, S_IRUSR | S_IRGRP | S_IROTH, dapm_widget_show, NULL);
 
 struct attribute *soc_dapm_dev_attrs[] = {
 	&dev_attr_dapm_widget.attr,
-- 
2.9.2
