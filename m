From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] ASoC: Intel: common: Replace custom
	implementation of readq / writeq
Date: Tue, 31 Jan 2017 16:14:22 +0200
Message-ID: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 72AA426734C
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 15:14:29 +0100 (CET)
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
 sound/soc/intel/common/sst-dsp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index 11c0805393ff..748f1f5c02df 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -22,6 +22,8 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 
+#include <linux/io-64-nonatomic-lo-hi.h>
+
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
 
@@ -43,16 +45,13 @@ EXPORT_SYMBOL_GPL(sst_shim32_read);
 
 void sst_shim32_write64(void __iomem *addr, u32 offset, u64 value)
 {
-	memcpy_toio(addr + offset, &value, sizeof(value));
+	lo_hi_writeq(value, addr + offset);
 }
 EXPORT_SYMBOL_GPL(sst_shim32_write64);
 
 u64 sst_shim32_read64(void __iomem *addr, u32 offset)
 {
-	u64 val;
-
-	memcpy_fromio(&val, addr + offset, sizeof(val));
-	return val;
+	return lo_hi_readq(addr + offset);
 }
 EXPORT_SYMBOL_GPL(sst_shim32_read64);
 
-- 
2.11.0
