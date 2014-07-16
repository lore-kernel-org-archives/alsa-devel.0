From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 7/7] ACPI: Cleanup useless ACPI inclusion.
Date: Wed, 16 Jul 2014 16:59:02 +0800
Message-ID: <7ac00c9c5a32f7a3ec98f061080ba1573ae57d0d.1405500886.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com> <cover.1405500886.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1405500886.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The sst-haswell-dsp.c is an ACPI independent file, this patch removes
ACPI header files for it.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/intel/sst-haswell-dsp.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 535f517..ecc5057 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -28,9 +28,6 @@
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
 
-#include <linux/acpi.h>
-#include <acpi/acpi_bus.h>
-
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
 #include "sst-haswell-ipc.h"
-- 
1.7.10

