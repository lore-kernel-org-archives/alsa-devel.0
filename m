From: jeeja.kp@intel.com
Subject: [PATCH 10/11] ASoC: Intel: Skylake: Fix module state
	after unbind and delete
Date: Thu, 23 Mar 2017 19:02:05 +0530
Message-ID: <1490275926-2270-11-git-send-email-jeeja.kp@intel.com>
References: <1490275926-2270-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 7225C267234
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 14:20:16 +0100 (CET)
In-Reply-To: <1490275926-2270-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

When DSP module is unbound, the module state needs to be in INIT_DONE
state instead of UNINT. Also the state needs to be set to UNINIT after
module is deleted from DSP pipeline.

So, set the module state to INIT_DONE after unbind and then UNINIT after
module is deleted.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-topology.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ba1ec97..09730dd 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -862,7 +862,7 @@ static void skl_clear_module_state(struct skl_module_pin *mpin, int max,
 	}
 
 	if (!found)
-		mcfg->m_state = SKL_MODULE_UNINIT;
+		mcfg->m_state = SKL_MODULE_INIT_DONE;
 	return;
 }
 
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a68c808..c541212 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1037,6 +1037,11 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 
 	skl_delete_pipe(ctx, mconfig->pipe);
 
+	list_for_each_entry(w_module, &s_pipe->w_list, node) {
+		src_module = w_module->w->priv;
+		src_module->m_state = SKL_MODULE_UNINIT;
+	}
+
 	return skl_tplg_unload_pipe_modules(ctx, s_pipe);
 }
 
-- 
2.5.0
