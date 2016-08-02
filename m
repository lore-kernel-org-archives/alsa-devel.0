From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1204/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:26:23 +0800
Message-ID: <20160802122623.30463-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/ac97/ac97_codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 82259ca..2dfb6d7 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -44,12 +44,12 @@ MODULE_LICENSE("GPL");
 
 static bool enable_loopback;
 
-module_param(enable_loopback, bool, 0444);
+module_param(enable_loopback, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable_loopback, "Enable AC97 ADC/DAC Loopback Control");
 
 #ifdef CONFIG_SND_AC97_POWER_SAVE
 static int power_save = CONFIG_SND_AC97_POWER_SAVE_DEFAULT;
-module_param(power_save, int, 0644);
+module_param(power_save, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
 #endif
-- 
2.9.2
