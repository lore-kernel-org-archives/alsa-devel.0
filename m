From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] ASoC: Intel: hifi2: Convert
	write()/write64() to return void
Date: Tue, 31 Jan 2017 16:14:24 +0200
Message-ID: <20170131141425.35482-3-andriy.shevchenko@linux.intel.com>
References: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E01B2267351
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

There is no point to always return 0.
Convert sst_shim_write() and sst_shim_write64() to return void.

No caller is checking for return value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst.h     | 4 ++--
 sound/soc/intel/atom/sst/sst_pvt.c | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index c585b07925f8..f00c13d53d23 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -534,9 +534,9 @@ u32 relocate_imr_addr_mrfld(u32 base_addr);
 void sst_add_to_dispatch_list_and_post(struct intel_sst_drv *sst,
 					struct ipc_post *msg);
 int sst_pm_runtime_put(struct intel_sst_drv *sst_drv);
-int sst_shim_write(void __iomem *addr, int offset, int value);
+void sst_shim_write(void __iomem *addr, int offset, int value);
 u32 sst_shim_read(void __iomem *addr, int offset);
-int sst_shim_write64(void __iomem *addr, int offset, u64 value);
+void sst_shim_write64(void __iomem *addr, int offset, u64 value);
 u64 sst_shim_read64(void __iomem *addr, int offset);
 void sst_set_fw_state_locked(
 		struct intel_sst_drv *sst_drv_ctx, int sst_state);
diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index 2452cbd77033..00d58f41231a 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -39,10 +39,9 @@
 #include "sst.h"
 #include "../../common/sst-dsp.h"
 
-int sst_shim_write(void __iomem *addr, int offset, int value)
+void sst_shim_write(void __iomem *addr, int offset, int value)
 {
 	writel(value, addr + offset);
-	return 0;
 }
 
 u32 sst_shim_read(void __iomem *addr, int offset)
@@ -50,10 +49,9 @@ u32 sst_shim_read(void __iomem *addr, int offset)
 	return readl(addr + offset);
 }
 
-int sst_shim_write64(void __iomem *addr, int offset, u64 value)
+void sst_shim_write64(void __iomem *addr, int offset, u64 value)
 {
 	lo_hi_writeq(value, addr + offset);
-	return 0;
 }
 
 u64 sst_shim_read64(void __iomem *addr, int offset)
-- 
2.11.0
