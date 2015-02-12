From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 09/13] ASoC: Intel: Add memcpy32_fromio as well
Date: Thu, 12 Feb 2015 10:00:01 +0530
Message-ID: <1423715405-4562-10-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6104E265146
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:58 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Export 32-bit version of memcpy for use in suspend/resume.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.h        |    3 +++
 sound/soc/intel/sst/sst_loader.c |   10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
index 7f4bbfcbc6f5..9fea01401e65 100644
--- a/sound/soc/intel/sst/sst.h
+++ b/sound/soc/intel/sst/sst.h
@@ -543,4 +543,7 @@ int sst_alloc_drv_context(struct intel_sst_drv **ctx,
 int sst_context_init(struct intel_sst_drv *ctx);
 void sst_context_cleanup(struct intel_sst_drv *ctx);
 void sst_configure_runtime_pm(struct intel_sst_drv *ctx);
+void memcpy32_toio(void __iomem *dst, const void *src, int count);
+void memcpy32_fromio(void *dst, const void __iomem *src, int count);
+
 #endif
diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/sst/sst_loader.c
index 7888cd707853..e88907ae8b15 100644
--- a/sound/soc/intel/sst/sst_loader.c
+++ b/sound/soc/intel/sst/sst_loader.c
@@ -39,7 +39,15 @@
 #include "sst.h"
 #include "../sst-dsp.h"
 
-static inline void memcpy32_toio(void __iomem *dst, const void *src, int count)
+void memcpy32_toio(void __iomem *dst, const void *src, int count)
+{
+	/* __iowrite32_copy uses 32-bit count values so divide by 4 for
+	 * right count in words
+	 */
+	__iowrite32_copy(dst, src, count/4);
+}
+
+void memcpy32_fromio(void *dst, const void __iomem *src, int count)
 {
 	/* __iowrite32_copy uses 32-bit count values so divide by 4 for
 	 * right count in words
-- 
1.7.9.5
