From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add library loading
	support" to the asoc tree
Date: Fri, 05 Aug 2016 12:19:04 +0100
Message-ID: <E1bVd9c-0001Ne-R9@debutante>
References: <1469536610-27606-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6177B266A1D
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2016 13:19:11 +0200 (CEST)
In-Reply-To: <1469536610-27606-11-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ramesh Babu <ramesh.babu@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Kranthi G <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add library loading support

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

>From f356a5acfe27b9955306d098a76be6846188cff6 Mon Sep 17 00:00:00 2001
From: Ramesh Babu <ramesh.babu@intel.com>
Date: Tue, 26 Jul 2016 18:06:48 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add library loading support

The library load is added as one of the ops in skl_dsp_fw_ops().

The manifest load gives the files to be loaded which are loaded during
the fw_init()

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Kranthi G <gudishax.kranthikumar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c     | 86 +++++++++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl-sst-dsp.h |  2 +
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 90702cef8b64..48a4ae583dd9 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -23,6 +23,7 @@
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
 #include "skl-sst-ipc.h"
+#include "skl-tplg-interface.h"
 
 #define BXT_BASEFW_TIMEOUT	3000
 #define BXT_INIT_TIMEOUT	500
@@ -40,11 +41,73 @@
 #define BXT_INSTANCE_ID 0
 #define BXT_BASE_FW_MODULE_ID 0
 
+#define BXT_ADSP_FW_BIN_HDR_OFFSET 0x2000
+
 static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 {
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
 }
 
+static int
+bxt_load_library(struct sst_dsp *ctx, struct skl_dfw_manifest *minfo)
+{
+	struct snd_dma_buffer dmab;
+	struct skl_sst *skl = ctx->thread_context;
+	const struct firmware *fw = NULL;
+	struct firmware stripped_fw;
+	int ret = 0, i, dma_id, stream_tag;
+
+	/* library indices start from 1 to N. 0 represents base FW */
+	for (i = 1; i < minfo->lib_count; i++) {
+		ret = request_firmware(&fw, minfo->lib[i].name, ctx->dev);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Request lib %s failed:%d\n",
+					minfo->lib[i].name, ret);
+			return ret;
+		}
+
+		if (skl->is_first_boot) {
+			ret = snd_skl_parse_uuids(ctx, fw,
+					BXT_ADSP_FW_BIN_HDR_OFFSET, i);
+			if (ret < 0)
+				goto load_library_failed;
+		}
+
+		stripped_fw.data = fw->data;
+		stripped_fw.size = fw->size;
+		skl_dsp_strip_extended_manifest(&stripped_fw);
+
+		stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40,
+					stripped_fw.size, &dmab);
+		if (stream_tag <= 0) {
+			dev_err(ctx->dev, "Lib prepare DMA err: %x\n",
+					stream_tag);
+			ret = stream_tag;
+			goto load_library_failed;
+		}
+
+		dma_id = stream_tag - 1;
+		memcpy(dmab.area, stripped_fw.data, stripped_fw.size);
+
+		ctx->dsp_ops.trigger(ctx->dev, true, stream_tag);
+		ret = skl_sst_ipc_load_library(&skl->ipc, dma_id, i);
+		if (ret < 0)
+			dev_err(ctx->dev, "IPC Load Lib for %s fail: %d\n",
+					minfo->lib[i].name, ret);
+
+		ctx->dsp_ops.trigger(ctx->dev, false, stream_tag);
+		ctx->dsp_ops.cleanup(ctx->dev, &dmab, stream_tag);
+		release_firmware(fw);
+		fw = NULL;
+	}
+
+	return ret;
+
+load_library_failed:
+	release_firmware(fw);
+	return ret;
+}
+
 /*
  * First boot sequence has some extra steps. Core 0 waits for power
  * status on core 1, so power up core 1 also momentarily, keep it in
@@ -157,8 +220,6 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 	return ret;
 }
 
-#define BXT_ADSP_FW_BIN_HDR_OFFSET 0x2000
-
 static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
 	struct firmware stripped_fw;
@@ -233,12 +294,23 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 	int ret;
 	struct skl_ipc_dxstate_info dx;
 	unsigned int core_mask = SKL_DSP_CORE_MASK(core_id);
+	struct skl_dfw_manifest *minfo = &skl->manifest;
 
 	if (skl->fw_loaded == false) {
 		skl->boot_complete = false;
 		ret = bxt_load_base_firmware(ctx);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(ctx->dev, "reload fw failed: %d\n", ret);
+			return ret;
+		}
+
+		if (minfo->lib_count > 1) {
+			ret = bxt_load_library(ctx, minfo);
+			if (ret < 0) {
+				dev_err(ctx->dev, "reload libs failed: %d\n", ret);
+				return ret;
+			}
+		}
 		return ret;
 	}
 
@@ -344,6 +416,7 @@ static struct skl_dsp_fw_ops bxt_fw_ops = {
 	.set_state_D3 = bxt_set_dsp_D3,
 	.load_fw = bxt_load_base_firmware,
 	.get_fw_errcode = bxt_get_errorcode,
+	.load_library = bxt_load_library,
 };
 
 static struct sst_ops skl_ops = {
@@ -422,6 +495,13 @@ int bxt_sst_init_fw(struct device *dev, struct skl_sst *ctx)
 
 	skl_dsp_init_core_state(sst);
 
+	if (ctx->manifest.lib_count > 1) {
+		ret = sst->fw_ops.load_library(sst, &ctx->manifest);
+		if (ret < 0) {
+			dev_err(dev, "Load Library failed : %x", ret);
+			return ret;
+		}
+	}
 	ctx->is_first_boot = false;
 
 	return 0;
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 5bc77e1941a5..fa053c039203 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -133,6 +133,8 @@ enum skl_dsp_states {
 struct skl_dsp_fw_ops {
 	int (*load_fw)(struct sst_dsp  *ctx);
 	/* FW module parser/loader */
+	int (*load_library)(struct sst_dsp *ctx,
+		struct skl_dfw_manifest *minfo);
 	int (*parse_fw)(struct sst_dsp *ctx);
 	int (*set_state_D0)(struct sst_dsp *ctx, unsigned int core_id);
 	int (*set_state_D3)(struct sst_dsp *ctx, unsigned int core_id);
-- 
2.8.1
