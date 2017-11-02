From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: include linux/module.h as needed" to the asoc tree
Date: Thu, 02 Nov 2017 11:21:30 +0000
Message-ID: <E1eADYw-000384-PV@debutante>
References: <20171102110815.2851021-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102110815.2851021-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Colin Ian King <colin.king@canonical.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: include linux/module.h as needed

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From adebc5321852da0b6ed13888e3aa291dfb011072 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 2 Nov 2017 12:08:00 +0100
Subject: [PATCH] ASoC: intel: include linux/module.h as needed

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.15.0
