From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1151/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:20:55 +0800
Message-ID: <20160802122055.26860-1-baolex.ni@intel.com>
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
 sound/core/rawmidi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 795437b..850c8a9 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -42,9 +42,9 @@ MODULE_LICENSE("GPL");
 #ifdef CONFIG_SND_OSSEMUL
 static int midi_map[SNDRV_CARDS];
 static int amidi_map[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = 1};
-module_param_array(midi_map, int, NULL, 0444);
+module_param_array(midi_map, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(midi_map, "Raw MIDI device number assigned to 1st OSS device.");
-module_param_array(amidi_map, int, NULL, 0444);
+module_param_array(amidi_map, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(amidi_map, "Raw MIDI device number assigned to 2nd OSS device.");
 #endif /* CONFIG_SND_OSSEMUL */
 
-- 
2.9.2
