From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add loadable module
	support on KBL platform" to the asoc tree
Date: Wed, 26 Apr 2017 15:48:39 +0100
Message-ID: <E1d3OFD-0000NA-LD@finisterre>
References: <1493102904-12624-7-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A9032670DB
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 16:49:00 +0200 (CEST)
In-Reply-To: <1493102904-12624-7-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sodhi@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, G Kranthi <gudishax.kranthikumar@intel.com>, tiwai@suse.de, broonie@kernel.org, "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add loadable module support on KBL platform

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

>From b6726009af555129c57dfbbf80a1fcf4d5a36ba0 Mon Sep 17 00:00:00 2001
From: "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>
Date: Tue, 25 Apr 2017 12:18:24 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add loadable module support on KBL
 platform

Kabylake platform expects modules in a library manifest. After loading
base firmware library manifest is loaded using load library IPC. This is
followed by module load using load multiple modules IPC.

Signed-off-by: Sodhi, VunnyX <vunnyx.sodhi@intel.com>
Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c |  2 ++
 sound/soc/intel/skylake/skl-sst.c     | 64 +++++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 7147eddc6d3c..58c525096a7c 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -427,6 +427,7 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 		sst_dsp_inbox_read(ipc->dsp, msg->rx_data, msg->rx_size);
 		switch (IPC_GLB_NOTIFY_MSG_TYPE(header.primary)) {
 		case IPC_GLB_LOAD_MULTIPLE_MODS:
+		case IPC_GLB_LOAD_LIBRARY:
 			skl->mod_load_complete = true;
 			skl->mod_load_status = true;
 			wake_up(&skl->mod_load_wait);
@@ -443,6 +444,7 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 			ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
 		switch (IPC_GLB_NOTIFY_MSG_TYPE(header.primary)) {
 		case IPC_GLB_LOAD_MULTIPLE_MODS:
+		case IPC_GLB_LOAD_LIBRARY:
 			skl->mod_load_complete = true;
 			skl->mod_load_status = false;
 			wake_up(&skl->mod_load_wait);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 20968e5ec86d..155e456b7a3a 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -179,6 +179,18 @@ static int skl_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 			dev_err(ctx->dev, "unable to load firmware\n");
 			return ret;
 		}
+
+		/* load libs as they are also lost on D3 */
+		if (skl->lib_count > 1) {
+			ret = ctx->fw_ops.load_library(ctx, skl->lib_info,
+							skl->lib_count);
+			if (ret < 0) {
+				dev_err(ctx->dev, "reload libs failed: %d\n",
+						ret);
+				return ret;
+			}
+
+		}
 	}
 
 	/*
@@ -204,7 +216,7 @@ static int skl_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 
 	skl->cores.state[core_id] = SKL_DSP_RUNNING;
 
-	return ret;
+	return 0;
 }
 
 static int skl_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
@@ -335,12 +347,16 @@ static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
 	if (bytes_left < 0)
 		return bytes_left;
 
-	if (is_module) { /* load module */
+	/* check is_module flag to load module or library */
+	if (is_module)
 		ret = skl_ipc_load_modules(&skl->ipc, SKL_NUM_MODULES, &mod_id);
-		if (ret < 0) {
-			dev_err(ctx->dev, "Failed to Load module: %d\n", ret);
-			goto out;
-		}
+	else
+		ret = skl_sst_ipc_load_library(&skl->ipc, 0, table_id, false);
+
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to Load %s with err %d\n",
+				is_module ? "module" : "lib", ret);
+		goto out;
 	}
 
 	/*
@@ -373,6 +389,32 @@ static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
 	return ret;
 }
 
+static int
+kbl_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
+{
+	struct skl_sst *skl = ctx->thread_context;
+	struct firmware stripped_fw;
+	int ret, i;
+
+	/* library indices start from 1 to N. 0 represents base FW */
+	for (i = 1; i < lib_count; i++) {
+		ret = skl_prepare_lib_load(skl, &skl->lib_info[i], &stripped_fw,
+					SKL_ADSP_FW_BIN_HDR_OFFSET, i);
+		if (ret < 0)
+			goto load_library_failed;
+		ret = skl_transfer_module(ctx, stripped_fw.data,
+				stripped_fw.size, 0, i, false);
+		if (ret < 0)
+			goto load_library_failed;
+	}
+
+	return 0;
+
+load_library_failed:
+	skl_release_library(linfo, lib_count);
+	return ret;
+}
+
 static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, u8 *guid)
 {
 	struct skl_module_table *module_entry = NULL;
@@ -475,6 +517,7 @@ static struct skl_dsp_fw_ops kbl_fw_ops = {
 	.set_state_D3 = skl_set_dsp_D3,
 	.load_fw = skl_load_base_firmware,
 	.get_fw_errcode = skl_get_errorcode,
+	.load_library = kbl_load_library,
 	.load_mod = skl_load_module,
 	.unload_mod = skl_unload_module,
 };
@@ -554,6 +597,15 @@ int skl_sst_init_fw(struct device *dev, struct skl_sst *ctx)
 	}
 
 	skl_dsp_init_core_state(sst);
+
+	if (ctx->lib_count > 1) {
+		ret = sst->fw_ops.load_library(sst, ctx->lib_info,
+						ctx->lib_count);
+		if (ret < 0) {
+			dev_err(dev, "Load Library failed : %x\n", ret);
+			return ret;
+		}
+	}
 	ctx->is_first_boot = false;
 
 	return 0;
-- 
2.11.0
