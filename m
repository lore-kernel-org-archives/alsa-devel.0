From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1276/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:33:54 +0800
Message-ID: <20160802123354.3197-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/sparc/cs4231.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 30bdc97..3ce2d9b 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -42,11 +42,11 @@ static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 /* Enable this card */
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Sun CS4231 soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Sun CS4231 soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Sun CS4231 soundcard.");
 MODULE_AUTHOR("Jaroslav Kysela, Derrick J. Brashear and David S. Miller");
 MODULE_DESCRIPTION("Sun CS4231");
-- 
2.9.2
