From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update module id in pin
	connections" to the asoc tree
Date: Sun, 27 Aug 2017 14:38:28 +0100 (BST)
Message-ID: <20170827133828.209474400E7@finisterre.ee.mobilebroadband>
References: <20170821084646.6525-8-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D67526745C
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 15:38:32 +0200 (CEST)
In-Reply-To: <20170821084646.6525-8-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Update module id in pin connections

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

>From 91fe0e70dbfb1142e17cebaa9186794b51a28cf7 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 23 Aug 2017 19:33:54 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update module id in pin connections

Each module's id comes from the topology and gets updated in the
driver. This patch updates the input and output pin connections of
each module by matching the uuid for each module.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      | 41 +++++++++++++++++++++++++++++++---
 sound/soc/intel/skylake/skl-topology.h |  1 +
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index a756882b9029..2b1e513b1680 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1220,8 +1220,11 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
 {
 	struct skl_sst *ctx = skl->skl_sst;
+	struct skl_module_inst_id *pin_id;
+	uuid_le *uuid_mod, *uuid_tplg;
+	struct skl_module *skl_module;
 	struct uuid_module *module;
-	uuid_le *uuid_mod;
+	int i, ret = -EIO;
 
 	uuid_mod = (uuid_le *)mconfig->guid;
 
@@ -1235,11 +1238,43 @@ static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
 			mconfig->id.module_id = module->id;
 			if (mconfig->module)
 				mconfig->module->loadable = module->is_loadable;
-			return 0;
+			ret = 0;
+			break;
 		}
 	}
 
-	return -EIO;
+	if (ret)
+		return ret;
+
+	uuid_mod = &module->uuid;
+	ret = -EIO;
+	for (i = 0; i < skl->nr_modules; i++) {
+		skl_module = skl->modules[i];
+		uuid_tplg = &skl_module->uuid;
+		if (!uuid_le_cmp(*uuid_mod, *uuid_tplg)) {
+			mconfig->module = skl_module;
+			ret = 0;
+			break;
+		}
+	}
+	if (skl->nr_modules && ret)
+		return ret;
+
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		for (i = 0; i < MAX_IN_QUEUE; i++) {
+			pin_id = &mconfig->m_in_pin[i].id;
+			if (!uuid_le_cmp(pin_id->mod_uuid, module->uuid))
+				pin_id->module_id = module->id;
+		}
+
+		for (i = 0; i < MAX_OUT_QUEUE; i++) {
+			pin_id = &mconfig->m_out_pin[i].id;
+			if (!uuid_le_cmp(pin_id->mod_uuid, module->uuid))
+				pin_id->module_id = module->id;
+		}
+	}
+
+	return 0;
 }
 
 static int skl_populate_modules(struct skl *skl)
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 90903a15fa1d..4975904480e9 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -221,6 +221,7 @@ struct skl_kpb_params {
 };
 
 struct skl_module_inst_id {
+	uuid_le mod_uuid;
 	int module_id;
 	u32 instance_id;
 	int pvt_id;
-- 
2.13.2
