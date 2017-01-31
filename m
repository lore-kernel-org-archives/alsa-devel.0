From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] ASoC: Intel: hifi2: Replace custom
	implementation of readq / writeq
Date: Tue, 31 Jan 2017 16:14:23 +0200
Message-ID: <20170131141425.35482-2-andriy.shevchenko@linux.intel.com>
References: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EE6F267352
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 15:14:29 +0100 (CET)
In-Reply-To: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The readq() and writeq() helpers are available in the
linux/io-64-nonatomic-hi-lo.h and linux/io-64-nonatomic-lo-hi.h headers.

Replace custom implementation by the generic helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst.h     |  1 -
 sound/soc/intel/atom/sst/sst_pvt.c | 19 +++++--------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 5c9a51cc77aa..c585b07925f8 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -536,7 +536,6 @@ void sst_add_to_dispatch_list_and_post(struct intel_sst_drv *sst,
 int sst_pm_runtime_put(struct intel_sst_drv *sst_drv);
 int sst_shim_write(void __iomem *addr, int offset, int value);
 u32 sst_shim_read(void __iomem *addr, int offset);
-u64 sst_reg_read64(void __iomem *addr, int offset);
 int sst_shim_write64(void __iomem *addr, int offset, u64 value);
 u64 sst_shim_read64(void __iomem *addr, int offset);
 void sst_set_fw_state_locked(
diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index b1e6b8f34a6a..2452cbd77033 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -26,12 +26,15 @@
 #include <linux/pm_runtime.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <sound/asound.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/compress_driver.h>
+
 #include <asm/platform_sst_audio.h>
+
 #include "../sst-mfld-platform.h"
 #include "sst.h"
 #include "../../common/sst-dsp.h"
@@ -47,27 +50,15 @@ u32 sst_shim_read(void __iomem *addr, int offset)
 	return readl(addr + offset);
 }
 
-u64 sst_reg_read64(void __iomem *addr, int offset)
-{
-	u64 val = 0;
-
-	memcpy_fromio(&val, addr + offset, sizeof(val));
-
-	return val;
-}
-
 int sst_shim_write64(void __iomem *addr, int offset, u64 value)
 {
-	memcpy_toio(addr + offset, &value, sizeof(value));
+	lo_hi_writeq(value, addr + offset);
 	return 0;
 }
 
 u64 sst_shim_read64(void __iomem *addr, int offset)
 {
-	u64 val = 0;
-
-	memcpy_fromio(&val, addr + offset, sizeof(val));
-	return val;
+	return lo_hi_readq(addr + offset);
 }
 
 void sst_set_fw_state_locked(
-- 
2.11.0
