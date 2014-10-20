From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 1/5] ASoC: intel: use __iowrite32_copy for
	32 bit copy
Date: Mon, 20 Oct 2014 20:54:30 +0530
Message-ID: <1413818674-14158-2-git-send-email-vinod.koul@intel.com>
References: <1413818674-14158-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BEE12667B0
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 18:02:50 +0200 (CEST)
In-Reply-To: <1413818674-14158-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The driver was using own method to do 32bit copy, turns out we have a kernel
API so use that instead

Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_loader.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/sst/sst_loader.c
index b6d27c1..00f60c1 100644
--- a/sound/soc/intel/sst/sst_loader.c
+++ b/sound/soc/intel/sst/sst_loader.c
@@ -39,14 +39,12 @@
 #include "sst.h"
 #include "../sst-dsp.h"
 
-static void memcpy32_toio(void __iomem *dst, const void *src, int count)
+static inline void memcpy32_toio(void __iomem *dst, const void *src, int count)
 {
-	int i;
-	const u32 *src_32 = src;
-	u32 *dst_32 = dst;
-
-	for (i = 0; i < count/sizeof(u32); i++)
-		writel(*src_32++, dst_32++);
+	/* __iowrite32_copy uses 32-bit count values so divide by 4 for
+	 * right count in words
+	 */
+	__iowrite32_copy(dst, src, count/4);
 }
 
 /**
-- 
1.7.0.4
