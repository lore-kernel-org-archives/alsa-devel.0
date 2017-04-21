From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 6/6] ASoC: Intel: Skylake: Add loadable module
	support on KBL platform
Date: Fri, 21 Apr 2017 20:28:13 +0530
Message-ID: <1492786693-24167-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D1754267198
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:11:42 +0200 (CEST)
In-Reply-To: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, G Kranthi <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>

Kabylake platform expects modules in a library manifest. After loading
base firmware library manifest is loaded using load library IPC. This is
followed by module load using load multiple modules IPC.

Signed-off-by: Sodhi, VunnyX <vunnyx.sodhi@intel.com>
Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c |  2 ++
 sound/soc/intel/skylake/skl-sst.c     | 63 +++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index c0226dd59445..3679d6c61cbf 100644
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
index e7ba0f400726..7282298d2bc9 100644
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
@@ -335,12 +347,15 @@ static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
 	if (bytes_left < 0)
 		return bytes_left;
 
-	if (is_module) {/* load module */
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
@@ -373,6 +388,32 @@ static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
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
@@ -475,6 +516,7 @@ static void skl_clear_module_table(struct sst_dsp *ctx)
 	.set_state_D3 = skl_set_dsp_D3,
 	.load_fw = skl_load_base_firmware,
 	.get_fw_errcode = skl_get_errorcode,
+	.load_library = kbl_load_library,
 	.load_mod = skl_load_module,
 	.unload_mod = skl_unload_module,
 };
@@ -554,6 +596,15 @@ int skl_sst_init_fw(struct device *dev, struct skl_sst *ctx)
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
1.9.1
