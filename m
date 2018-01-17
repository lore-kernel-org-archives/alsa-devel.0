From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: remove second duplicated
	assignment to pointer 'res'
Date: Wed, 17 Jan 2018 10:17:08 +0000
Message-ID: <20180117101708.11698-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BCFEF266B67
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 11:17:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The second assignment to res is identical to the previous assignment
so it is redundant and can be removed.

Cleans up clang warning:
sound/soc/intel/skylake/skl-topology.c:191:25: warning: Value stored to
'res' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/skylake/skl-topology.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 28bc16a8e09a..73af6e19ebbd 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -190,7 +190,6 @@ skl_tplg_free_pipe_mcps(struct skl *skl, struct skl_module_cfg *mconfig)
 	u8 res_idx = mconfig->res_idx;
 	struct skl_module_res *res = &mconfig->module->resources[res_idx];
 
-	res = &mconfig->module->resources[res_idx];
 	skl->resource.mcps -= res->cps;
 }
 
-- 
2.15.1
