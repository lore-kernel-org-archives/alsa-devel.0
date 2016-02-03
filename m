From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/11] ASoC: Intel: Skylake: Fix not to stop
	sink pipe in pga pmd event
Date: Wed,  3 Feb 2016 17:59:50 +0530
Message-ID: <1454502594-21700-8-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 53355265A82
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:42 +0100 (CET)
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

We should not stop the sink pipe in it's pmd handler for a mixin
module as this module may still be connected to other pipes.

This will be stopped and freed by current implementation on last
connected pipe unbind.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 7dc804c1cdea..244d87c0d106 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -827,9 +827,6 @@ static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 			 * This is a connecter and if path is found that means
 			 * unbind between source and sink has not happened yet
 			 */
-			ret = skl_stop_pipe(ctx, sink_mconfig->pipe);
-			if (ret < 0)
-				return ret;
 			ret = skl_unbind_modules(ctx, src_mconfig,
 							sink_mconfig);
 		}
-- 
1.9.1
