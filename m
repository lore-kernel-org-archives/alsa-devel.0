From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: Remove unneeded linux/miscdevice.h include" to the asoc tree
Date: Tue, 19 Sep 2017 17:11:35 +0100
Message-ID: <E1duL7X-0004o2-BV@debutante>
References: <20161215151501.3959-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161215151501.3959-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.orgCorentin Labbe <clabbe.montjoie@gmail.com>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: Remove unneeded linux/miscdevice.h include

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 870fcae998dd16f3985627b4151ab8491d94b8c7 Mon Sep 17 00:00:00 2001
From: Corentin LABBE <clabbe.montjoie@gmail.com>
Date: Mon, 18 Sep 2017 19:26:07 +0200
Subject: [PATCH] ASoC: Intel: Atom: Remove unneeded linux/miscdevice.h include

No file in sound/soc/intel/ use any miscdevice.
This patch remove this uncessary include.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index ff4a5175a6cd..4d85ead243f1 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -23,7 +23,6 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-#include <linux/miscdevice.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
-- 
2.14.1
