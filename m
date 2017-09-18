From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] ASoC: Intel: Atom: Remove unneeded linux/miscdevice.h include
Date: Mon, 18 Sep 2017 19:26:07 +0200
Message-ID: <20170918172607.7001-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
List-Id: alsa-devel@alsa-project.org

No file in sound/soc/intel/ use any miscdevice.
This patch remove this uncessary include.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0e928d54305d..4166925a689b 100644
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
2.13.5
