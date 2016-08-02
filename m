From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1272/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:33:31 +0800
Message-ID: <20160802123331.2842-1-baolex.ni@intel.com>
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
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16369ca..9da79cd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -157,7 +157,7 @@ static ssize_t codec_reg_show(struct device *dev,
 	return soc_codec_reg_show(rtd->codec, buf, PAGE_SIZE, 0);
 }
 
-static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
+static DEVICE_ATTR(codec_reg, S_IRUSR | S_IRGRP | S_IROTH, codec_reg_show, NULL);
 
 static ssize_t pmdown_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -181,7 +181,7 @@ static ssize_t pmdown_time_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(pmdown_time, 0644, pmdown_time_show, pmdown_time_set);
+static DEVICE_ATTR(pmdown_time, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, pmdown_time_show, pmdown_time_set);
 
 static struct attribute *soc_dev_attrs[] = {
 	&dev_attr_codec_reg.attr,
-- 
2.9.2
