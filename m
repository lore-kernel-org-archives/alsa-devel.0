From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/6] ASoC: Intel: Skylake: Fix resource
	cleanup on teardown
Date: Thu,  5 Nov 2015 21:34:10 +0530
Message-ID: <1446739455-22332-2-git-send-email-vinod.koul@intel.com>
References: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 34ACB266176
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:01:00 +0100 (CET)
In-Reply-To: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Mohan Krishna Velaga <mohan.krishnax.velaga@intel.com>
List-Id: alsa-devel@alsa-project.org

MCPS free was being done from PGA context which will free up MCPS
for only last modules in a pipe and not the rest causing MCPS
leak and eventual audio loss due to no "free" MCPS.

This needs to be freed for every module while cleaning up the
modules, so move the check to
skl_tplg_mixer_dapm_post_pmd_event()

Signed-off-by: Mohan Krishna Velaga <mohan.krishnax.velaga@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 3c5f06235889..2b6ee22b5ea2 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -640,6 +640,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	list_for_each_entry(w_module, &s_pipe->w_list, node) {
 		dst_module = w_module->w->priv;
 
+		skl_tplg_free_pipe_mcps(skl, dst_module);
 		if (src_module == NULL) {
 			src_module = dst_module;
 			continue;
@@ -673,7 +674,6 @@ static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 
 	src_mconfig = w->priv;
 
-	skl_tplg_free_pipe_mcps(skl, src_mconfig);
 	/* Stop the pipe since this is a mixin module */
 	ret = skl_stop_pipe(ctx, src_mconfig->pipe);
 	if (ret)
-- 
1.9.1
