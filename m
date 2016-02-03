From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/11] ASoC: Intel: Skylake: Fix the module
	state check condition
Date: Wed,  3 Feb 2016 17:59:49 +0530
Message-ID: <1454502594-21700-7-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 21CE6265A36
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:39 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

For binding modules we should check if source or destination
module is in UNINT state. We canot bind even if one of them is
in this state.

So update the check from logical AND to logical OR and do not
bind modules for this case

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index bb5f1d7d0cad..4629372d7c8e 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -747,7 +747,7 @@ int skl_bind_modules(struct skl_sst *ctx,
 
 	skl_dump_bind_info(ctx, src_mcfg, dst_mcfg);
 
-	if (src_mcfg->m_state < SKL_MODULE_INIT_DONE &&
+	if (src_mcfg->m_state < SKL_MODULE_INIT_DONE ||
 		dst_mcfg->m_state < SKL_MODULE_INIT_DONE)
 		return 0;
 
-- 
1.9.1
