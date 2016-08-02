From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1159/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:21:45 +0800
Message-ID: <20160802122145.27404-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Julia.Lawall@lip6.fr, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/drivers/dummy.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index c0f8f61..2318140 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -70,24 +70,24 @@ static bool hrtimer = 1;
 #endif
 static bool fake_buffer = 1;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for dummy soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for dummy soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable this dummy soundcard.");
-module_param_array(model, charp, NULL, 0444);
+module_param_array(model, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(model, "Soundcard model.");
-module_param_array(pcm_devs, int, NULL, 0444);
+module_param_array(pcm_devs, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pcm_devs, "PCM devices # (0-4) for dummy driver.");
-module_param_array(pcm_substreams, int, NULL, 0444);
+module_param_array(pcm_substreams, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-128) for dummy driver.");
 //module_param_array(midi_devs, int, NULL, 0444);
 //MODULE_PARM_DESC(midi_devs, "MIDI devices # (0-2) for dummy driver.");
-module_param(fake_buffer, bool, 0444);
+module_param(fake_buffer, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fake_buffer, "Fake buffer allocations.");
 #ifdef CONFIG_HIGH_RES_TIMERS
-module_param(hrtimer, bool, 0644);
+module_param(hrtimer, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(hrtimer, "Use hrtimer as the timer source.");
 #endif
 
-- 
2.9.2
