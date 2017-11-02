From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: intel: include linux/module.h as needed
Date: Thu,  2 Nov 2017 12:08:00 +0100
Message-ID: <20171102110815.2851021-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Colin Ian King <colin.king@canonical.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The MODULE_DESCRIPTION() macro is only available when including
the linux/module.h header. Apparently this is included indirectly
from sst-firmware.c in some configurations, but not in others:

sound/soc/intel/common/sst-firmware.c:1278:20: error: expected declaration specifiers or '...' before string constant
 MODULE_DESCRIPTION("Intel SST Firmware Loader");
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/intel/common/sst-firmware.c:1279:16: error: expected declaration specifiers or '...' before string constant

This adds the missing include line.

Fixes: a395bdd6b24b ("ASoC: intel: Fix sst-dsp dependency on dw stuff")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/common/sst-firmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 79a9fdf94d38..657afc02f1c4 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/firmware.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-- 
2.9.0
