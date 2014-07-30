From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Check ops before we derefference
	pointers.
Date: Wed, 30 Jul 2014 20:18:32 +0800
Message-ID: <1406722712-8323-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 94D2B2608D3
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:17:49 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Check ops pointer members before we can derefference them.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-dsp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/sst-dsp.c b/sound/soc/intel/sst-dsp.c
index 0b715b2..cd23060 100644
--- a/sound/soc/intel/sst-dsp.c
+++ b/sound/soc/intel/sst-dsp.c
@@ -224,19 +224,23 @@ EXPORT_SYMBOL_GPL(sst_dsp_shim_update_bits64);
 
 void sst_dsp_dump(struct sst_dsp *sst)
 {
-	sst->ops->dump(sst);
+	if (sst->ops->dump)
+		sst->ops->dump(sst);
 }
 EXPORT_SYMBOL_GPL(sst_dsp_dump);
 
 void sst_dsp_reset(struct sst_dsp *sst)
 {
-	sst->ops->reset(sst);
+	if (sst->ops->reset)
+		sst->ops->reset(sst);
 }
 EXPORT_SYMBOL_GPL(sst_dsp_reset);
 
 int sst_dsp_boot(struct sst_dsp *sst)
 {
-	sst->ops->boot(sst);
+	if (sst->ops->boot)
+		sst->ops->boot(sst);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sst_dsp_boot);
-- 
1.8.3.2
