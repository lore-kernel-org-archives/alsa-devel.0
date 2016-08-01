From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Move modules query to
	runtime" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:28 +0100
Message-ID: <E1bUGga-0006Rf-2s@debutante>
References: <1469536610-27606-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9953266109
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 19:07:34 +0200 (CEST)
In-Reply-To: <1469536610-27606-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Move modules query to runtime

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7c617ec3e8f6b614e63ea9c82ce2ea39e7daf579 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 26 Jul 2016 18:06:40 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Move modules query to runtime

Since we are moving DSP init to later, at the topology load the
module info is not available.

So set the module id to -1 at init and query at first module
initialization.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
