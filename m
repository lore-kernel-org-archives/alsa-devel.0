From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1198/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:25:48 +0800
Message-ID: <20160802122548.30054-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/isa/wavefront/wavefront_synth.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 718d5e3..2c77d75 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -85,25 +85,25 @@ static int ramcheck_time = 20;    /* time in seconds to wait while ROM code
 static int osrun_time = 10;       /* time in seconds we wait for the OS to
 				     start running.
 				  */
-module_param(wf_raw, int, 0444);
+module_param(wf_raw, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wf_raw, "if non-zero, assume that we need to boot the OS");
-module_param(fx_raw, int, 0444);
+module_param(fx_raw, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fx_raw, "if non-zero, assume that the FX process needs help");
-module_param(debug_default, int, 0444);
+module_param(debug_default, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug_default, "debug parameters for card initialization");
-module_param(wait_usecs, int, 0444);
+module_param(wait_usecs, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wait_usecs, "how long to wait without sleeping, usecs");
-module_param(sleep_interval, int, 0444);
+module_param(sleep_interval, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(sleep_interval, "how long to sleep when waiting for reply");
-module_param(sleep_tries, int, 0444);
+module_param(sleep_tries, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(sleep_tries, "how many times to try sleeping during a wait");
-module_param(ospath, charp, 0444);
+module_param(ospath, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ospath, "pathname to processed ICS2115 OS firmware");
-module_param(reset_time, int, 0444);
+module_param(reset_time, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(reset_time, "how long to wait for a reset to take effect");
-module_param(ramcheck_time, int, 0444);
+module_param(ramcheck_time, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ramcheck_time, "how many seconds to wait for the RAM test");
-module_param(osrun_time, int, 0444);
+module_param(osrun_time, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(osrun_time, "how many seconds to wait for the ICS2115 OS");
 
 /* if WF_DEBUG not defined, no run-time debugging messages will
-- 
2.9.2
