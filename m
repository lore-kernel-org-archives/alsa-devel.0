From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Skylake: Fix to cleanup if
	skl_sst_dsp_init fails
Date: Fri, 30 Oct 2015 20:34:19 +0530
Message-ID: <1446217461-2106-3-git-send-email-vinod.koul@intel.com>
References: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 292702617B5
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 16:01:36 +0100 (CET)
In-Reply-To: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This patch fixes the below warning reported by Dan by invoking
skl_sst_dsp_cleanup() in cleanup path on error and not bailing out

	sound/soc/intel/skylake/skl-sst.c:270 skl_sst_dsp_init()
	info: ignoring unreachable code.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 3b83dc99f1d4..5c5a244942ef 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -259,15 +259,16 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	ret = sst->fw_ops.load_fw(sst);
 	if (ret < 0) {
 		dev_err(dev, "Load base fw failed : %d", ret);
-		return ret;
+		goto cleanup;
 	}
 
 	if (dsp)
 		*dsp = skl;
 
-	return 0;
+	return ret;
 
-	skl_ipc_free(&skl->ipc);
+cleanup:
+	skl_sst_dsp_cleanup(dev, skl);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
-- 
1.9.1
