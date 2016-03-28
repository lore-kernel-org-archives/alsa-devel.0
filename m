From: jeeja.kp@intel.com
Subject: [PATCH 2/2] ASoC: Intel: Skylake: Fix DSP resource
	de-allocation
Date: Mon, 28 Mar 2016 22:11:31 +0530
Message-ID: <1459183291-16395-2-git-send-email-jeeja.kp@intel.com>
References: <1459183291-16395-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id ED1B02619E3
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 05:13:09 +0200 (CEST)
In-Reply-To: <1459183291-16395-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, vinod.koul@intel.com, patches.audio@intel.com
Cc: Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

In PRE PMD of widget handler DSP resources are allocated after
the creation of DSP pipe and modules and in POST PMD DSP
resources are destroyed.

If there is any failure in pipe or module creation in PRE PMD,
pcm trigger fails and finally POST PMD gets called and DSP
resources are freed, without getting allocated.

Fixes the DSP resource de-allocation by allocating the resource
before creation of pipe and module in PRE PMD and in POST PMD,
free the resources.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 3f393cb..5a85f3a 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -485,6 +485,8 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		if (!skl_is_pipe_mcps_avail(skl, mconfig))
 			return -ENOMEM;
 
+		skl_tplg_alloc_pipe_mcps(skl, mconfig);
+
 		if (mconfig->is_loadable && ctx->dsp->fw_ops.load_mod) {
 			ret = ctx->dsp->fw_ops.load_mod(ctx->dsp,
 				mconfig->id.module_id, mconfig->guid);
@@ -511,7 +513,6 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		ret = skl_tplg_set_module_params(w, ctx);
 		if (ret < 0)
 			return ret;
-		skl_tplg_alloc_pipe_mcps(skl, mconfig);
 	}
 
 	return 0;
@@ -561,6 +562,9 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	if (!skl_is_pipe_mem_avail(skl, mconfig))
 		return -ENOMEM;
 
+	skl_tplg_alloc_pipe_mem(skl, mconfig);
+	skl_tplg_alloc_pipe_mcps(skl, mconfig);
+
 	/*
 	 * Create a list of modules for pipe.
 	 * This list contains modules from source to sink
@@ -604,9 +608,6 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 		src_module = dst_module;
 	}
 
-	skl_tplg_alloc_pipe_mem(skl, mconfig);
-	skl_tplg_alloc_pipe_mcps(skl, mconfig);
-
 	return 0;
 }
 
-- 
2.5.0
