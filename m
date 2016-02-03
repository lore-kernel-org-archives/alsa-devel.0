From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/11] ASoC: Intel: Skylake: Fix mcps freeup
	after module unbind failure
Date: Wed,  3 Feb 2016 17:59:46 +0530
Message-ID: <1454502594-21700-4-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 52BA4260701
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:33 +0100 (CET)
In-Reply-To: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

While cleaning resources on module pmd event, we check for return
of skl_unbind_modules(). On failure this causes leak as all modules
attached do not have resources freed.

So ignore return value of module unbind and continue freeing
resources. This makes dapm state and resources correct.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index d1ddfdac22fe..defe7eaba667 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -98,7 +98,7 @@ static bool skl_tplg_alloc_pipe_mcps(struct skl *skl,
 			"%s: module_id %d instance %d\n", __func__,
 			mconfig->id.module_id, mconfig->id.instance_id);
 		dev_err(ctx->dev,
-			"exceeds ppl memory available %d > mem %d\n",
+			"exceeds ppl mcps available %d > mem %d\n",
 			skl->resource.max_mcps, skl->resource.mcps);
 		return false;
 	}
@@ -773,10 +773,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 			continue;
 		}
 
-		ret = skl_unbind_modules(ctx, src_module, dst_module);
-		if (ret < 0)
-			return ret;
-
+		skl_unbind_modules(ctx, src_module, dst_module);
 		src_module = dst_module;
 	}
 
-- 
1.9.1
