From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Skylake: Fix uninitialized
	pointer usage
Date: Thu, 27 Apr 2017 12:21:20 +0530
Message-ID: <1493275882-27708-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BE7A2671A3
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 08:49:43 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Due to recent code move, one instance dev_err() was passed a wrong
uninitialized pointer for the device, so fix it.

sound/soc/intel/skylake/bxt-sst.c: In function 'bxt_sst_dsp_init':
sound/soc/intel/skylake/bxt-sst.c:567:14: warning: 'skl' may be used uninitialized in this function [-Wmaybe-uninitialized]
   dev_err(skl->dev, "%s: no device\n", __func__);
              ^

Fixes: 9fe9c7119283 ("ASoC: Intel: Skylake: Move sst common initialization to a helper function")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index fde4bc0f35b0..f5e7dbb1ba39 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -564,7 +564,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
 	if (ret < 0) {
-		dev_err(skl->dev, "%s: no device\n", __func__);
+		dev_err(dev, "%s: no device\n", __func__);
 		return ret;
 	}
 
-- 
1.9.1
