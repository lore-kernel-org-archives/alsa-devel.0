From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1155/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:21:20 +0800
Message-ID: <20160802122120.27132-1-baolex.ni@intel.com>
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
 sound/core/seq/seq_midi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 5dd0ee2..18c428d 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -43,10 +43,10 @@ MODULE_AUTHOR("Frank van de Pol <fvdpol@coil.demon.nl>, Jaroslav Kysela <perex@p
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture sequencer MIDI synth.");
 MODULE_LICENSE("GPL");
 static int output_buffer_size = PAGE_SIZE;
-module_param(output_buffer_size, int, 0644);
+module_param(output_buffer_size, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(output_buffer_size, "Output buffer size in bytes.");
 static int input_buffer_size = PAGE_SIZE;
-module_param(input_buffer_size, int, 0644);
+module_param(input_buffer_size, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(input_buffer_size, "Input buffer size in bytes.");
 
 /* data for this midi synth driver */
-- 
2.9.2
