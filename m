From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1153/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:21:09 +0800
Message-ID: <20160802122109.26996-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/core/seq/seq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/core/seq/seq.c b/sound/core/seq/seq.c
index 639544b..5b1c00e 100644
--- a/sound/core/seq/seq.c
+++ b/sound/core/seq/seq.c
@@ -58,19 +58,19 @@ MODULE_AUTHOR("Frank van de Pol <fvdpol@coil.demon.nl>, Jaroslav Kysela <perex@p
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture sequencer.");
 MODULE_LICENSE("GPL");
 
-module_param_array(seq_client_load, int, NULL, 0444);
+module_param_array(seq_client_load, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_client_load, "The numbers of global (system) clients to load through kmod.");
-module_param(seq_default_timer_class, int, 0644);
+module_param(seq_default_timer_class, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_default_timer_class, "The default timer class.");
-module_param(seq_default_timer_sclass, int, 0644);
+module_param(seq_default_timer_sclass, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_default_timer_sclass, "The default timer slave class.");
-module_param(seq_default_timer_card, int, 0644);
+module_param(seq_default_timer_card, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_default_timer_card, "The default timer card number.");
-module_param(seq_default_timer_device, int, 0644);
+module_param(seq_default_timer_device, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_default_timer_device, "The default timer device number.");
-module_param(seq_default_timer_subdevice, int, 0644);
+module_param(seq_default_timer_subdevice, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_default_timer_subdevice, "The default timer subdevice number.");
-module_param(seq_default_timer_resolution, int, 0644);
+module_param(seq_default_timer_resolution, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_default_timer_resolution, "The default timer resolution in Hz.");
 
 MODULE_ALIAS_CHARDEV(CONFIG_SND_MAJOR, SNDRV_MINOR_SEQUENCER);
-- 
2.9.2
