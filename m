From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 02/12] ASoC: Intel: Skylake: Move modules query
	to runtime
Date: Tue, 26 Jul 2016 18:06:40 +0530
Message-ID: <1469536610-27606-3-git-send-email-vinod.koul@intel.com>
References: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 51D45266992
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 14:29:45 +0200 (CEST)
In-Reply-To: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

Since we are moving DSP init to later, at the topology load the
module info is not available.

So set the module id to -1 at init and query at first module
initialization.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 32 +++++++++++++++++++++++++++-----
 sound/soc/intel/skylake/skl-topology.h |  2 +-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index cc0150fc2601..904103056d62 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -473,6 +473,28 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		w = w_module->w;
 		mconfig = w->priv;
 
+		/* check if module ids are populated */
+		if (mconfig->id.module_id < 0) {
+			struct skl_dfw_module *dfw_config;
+
+			dfw_config = kzalloc(sizeof(dfw_config), GFP_KERNEL);
+			if (!dfw_config)
+				return -ENOMEM;
+
+			ret = snd_skl_get_module_info(skl->skl_sst,
+				mconfig->guid, dfw_config);
+			if (ret < 0) {
+				dev_err(skl->skl_sst->dev,
+					"query module info failed: %d\n", ret);
+				kfree(dfw_config);
+				return ret;
+			}
+			mconfig->id.module_id = dfw_config->module_id;
+			mconfig->is_loadable = dfw_config->is_loadable;
+
+			kfree(dfw_config);
+		}
+
 		/* check resource available */
 		if (!skl_is_pipe_mcps_avail(skl, mconfig))
 			return -ENOMEM;
@@ -1621,11 +1643,11 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	w->priv = mconfig;
 	memcpy(&mconfig->guid, &dfw_config->uuid, 16);
 
-	ret = snd_skl_get_module_info(skl->skl_sst, mconfig->guid, dfw_config);
-	if (ret < 0)
-		return ret;
-
-	mconfig->id.module_id = dfw_config->module_id;
+	/*
+	 * module binary can be loaded later, so set it to query when
+	 * module is load for a use case
+	 */
+	mconfig->id.module_id = -1;
 	mconfig->id.instance_id = dfw_config->instance_id;
 	mconfig->mcps = dfw_config->max_mcps;
 	mconfig->ibs = dfw_config->ibs;
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 22d3ef83817d..96fa86d0f93a 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -216,7 +216,7 @@ struct skl_module_fmt {
 struct skl_module_cfg;
 
 struct skl_module_inst_id {
-	u32 module_id;
+	int module_id;
 	u32 instance_id;
 };
 
-- 
1.9.1
