From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Skylake: Move up pipe mem free
Date: Mon, 23 Nov 2015 22:26:29 +0530
Message-ID: <1448297789-6524-8-git-send-email-vinod.koul@intel.com>
References: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F1B426588E
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 17:53:05 +0100 (CET)
In-Reply-To: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
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

The MCPS is freed first thing in pmd events but non memory. So if
we face error during teardown we leak this mem, so move the code
up

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 698c4aa03933..f221c758d601 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -652,6 +652,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	int ret = 0;
 
 	skl_tplg_free_pipe_mcps(skl, mconfig);
+	skl_tplg_free_pipe_mem(skl, mconfig);
 
 	list_for_each_entry(w_module, &s_pipe->w_list, node) {
 		dst_module = w_module->w->priv;
@@ -670,7 +671,6 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	}
 
 	ret = skl_delete_pipe(ctx, mconfig->pipe);
-	skl_tplg_free_pipe_mem(skl, mconfig);
 
 	return ret;
 }
-- 
1.9.1
