From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/5] ASoC: Intel: Skylake: Fix memory leak
	during init instance
Date: Thu, 28 Apr 2016 18:45:26 +0530
Message-ID: <1461849329-20364-3-git-send-email-vinod.koul@intel.com>
References: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 972702667CD
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:10:48 +0200 (CEST)
In-Reply-To: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Mousumi Jana <mousumix.jana@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mousumi Jana <mousumix.jana@intel.com>

param_data variable is allocated during set module format of init
instance is not getting freed and hence can cause a memory leak.
So free it up.

Signed-off-by: Mousumi Jana <mousumix.jana@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e3d149c68bbf..226db84ba20f 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -864,7 +864,7 @@ int skl_init_module(struct skl_sst *ctx,
 		return ret;
 	}
 	mconfig->m_state = SKL_MODULE_INIT_DONE;
-
+	kfree(param_data);
 	return ret;
 }
 
-- 
1.9.1
