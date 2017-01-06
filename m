From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Clean up manifest info"
	to the asoc tree
Date: Fri, 06 Jan 2017 18:16:42 +0000
Message-ID: <E1cPZ4E-0003Ah-7F@debutante>
References: <1483330807-9518-4-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C15F02677FD
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:16:48 +0100 (CET)
In-Reply-To: <1483330807-9518-4-git-send-email-jeeja.kp@intel.com>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Clean up manifest info

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

>From eee0e16f8c3cf31fbbae4a88e51d25abebbaf147 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 2 Jan 2017 09:50:04 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Clean up manifest info

Instead of passing the topology manifest info directly to IPC library,
define the manifest info in topology and use this in IPC Library.
This will remove the dependency on topology interface definition with
IPC library.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c            | 25 ++++++++---------
 sound/soc/intel/skylake/skl-sst-dsp.h        |  4 +--
 sound/soc/intel/skylake/skl-sst-ipc.h        |  5 ++--
 sound/soc/intel/skylake/skl-topology.c       | 41 +++++++++++++---------------
 sound/soc/intel/skylake/skl-topology.h       | 13 +++++++++
 sound/soc/intel/skylake/skl-tplg-interface.h | 12 --------
 6 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 1f9f33d34000..e4a382870132 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -23,7 +23,6 @@
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
 #include "skl-sst-ipc.h"
-#include "skl-tplg-interface.h"
 
 #define BXT_BASEFW_TIMEOUT	3000
 #define BXT_INIT_TIMEOUT	500
@@ -52,7 +51,7 @@ static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 }
 
 static int
-bxt_load_library(struct sst_dsp *ctx, struct skl_dfw_manifest *minfo)
+bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 {
 	struct snd_dma_buffer dmab;
 	struct skl_sst *skl = ctx->thread_context;
@@ -61,11 +60,11 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_dfw_manifest *minfo)
 	int ret = 0, i, dma_id, stream_tag;
 
 	/* library indices start from 1 to N. 0 represents base FW */
-	for (i = 1; i < minfo->lib_count; i++) {
-		ret = request_firmware(&fw, minfo->lib[i].name, ctx->dev);
+	for (i = 1; i < lib_count; i++) {
+		ret = request_firmware(&fw, linfo[i].name, ctx->dev);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Request lib %s failed:%d\n",
-					minfo->lib[i].name, ret);
+					linfo[i].name, ret);
 			return ret;
 		}
 
@@ -96,7 +95,7 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_dfw_manifest *minfo)
 		ret = skl_sst_ipc_load_library(&skl->ipc, dma_id, i);
 		if (ret < 0)
 			dev_err(ctx->dev, "IPC Load Lib for %s fail: %d\n",
-					minfo->lib[i].name, ret);
+					linfo[i].name, ret);
 
 		ctx->dsp_ops.trigger(ctx->dev, false, stream_tag);
 		ctx->dsp_ops.cleanup(ctx->dev, &dmab, stream_tag);
@@ -119,8 +118,7 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_dfw_manifest *minfo)
 static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 			const void *fwdata, u32 fwsize)
 {
-	int stream_tag, ret, i;
-	u32 reg;
+	int stream_tag, ret;
 
 	stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
 	if (stream_tag <= 0) {
@@ -432,7 +430,6 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 	int ret;
 	struct skl_ipc_dxstate_info dx;
 	unsigned int core_mask = SKL_DSP_CORE_MASK(core_id);
-	struct skl_dfw_manifest *minfo = &skl->manifest;
 
 	if (skl->fw_loaded == false) {
 		skl->boot_complete = false;
@@ -442,8 +439,9 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 			return ret;
 		}
 
-		if (minfo->lib_count > 1) {
-			ret = bxt_load_library(ctx, minfo);
+		if (skl->lib_count > 1) {
+			ret = bxt_load_library(ctx, skl->lib_info,
+						skl->lib_count);
 			if (ret < 0) {
 				dev_err(ctx->dev, "reload libs failed: %d\n", ret);
 				return ret;
@@ -640,8 +638,9 @@ int bxt_sst_init_fw(struct device *dev, struct skl_sst *ctx)
 
 	skl_dsp_init_core_state(sst);
 
-	if (ctx->manifest.lib_count > 1) {
-		ret = sst->fw_ops.load_library(sst, &ctx->manifest);
+	if (ctx->lib_count > 1) {
+		ret = sst->fw_ops.load_library(sst, ctx->lib_info,
+						ctx->lib_count);
 		if (ret < 0) {
 			dev_err(dev, "Load Library failed : %x\n", ret);
 			return ret;
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 7c272ba0f4b5..849410d0823e 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -19,7 +19,6 @@
 #include <linux/interrupt.h>
 #include <sound/memalloc.h>
 #include "skl-sst-cldma.h"
-#include "skl-tplg-interface.h"
 #include "skl-topology.h"
 
 struct sst_dsp;
@@ -145,7 +144,7 @@ struct skl_dsp_fw_ops {
 	int (*load_fw)(struct sst_dsp  *ctx);
 	/* FW module parser/loader */
 	int (*load_library)(struct sst_dsp *ctx,
-		struct skl_dfw_manifest *minfo);
+		struct skl_lib_info *linfo, int count);
 	int (*parse_fw)(struct sst_dsp *ctx);
 	int (*set_state_D0)(struct sst_dsp *ctx, unsigned int core_id);
 	int (*set_state_D3)(struct sst_dsp *ctx, unsigned int core_id);
@@ -236,5 +235,4 @@ int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
-
 #endif /*__SKL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index cc40341233fa..9660ace379ab 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -97,8 +97,9 @@ struct skl_sst {
 	/* multi-core */
 	struct skl_dsp_cores cores;
 
-	/* tplg manifest */
-	struct skl_dfw_manifest manifest;
+	/* library info */
+	struct skl_lib_info  lib_info[SKL_MAX_LIB];
+	int lib_count;
 
 	/* Callback to update D0i3C register */
 	void (*update_d0i3c)(struct device *dev, bool enable);
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 422a9dee9270..e6e76237f46b 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2300,20 +2300,21 @@ static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
 
 static int skl_tplg_fill_str_mfest_tkn(struct device *dev,
 		struct snd_soc_tplg_vendor_string_elem *str_elem,
-		struct skl_dfw_manifest *minfo)
+		struct skl *skl)
 {
 	int tkn_count = 0;
 	static int ref_count;
 
 	switch (str_elem->token) {
 	case SKL_TKN_STR_LIB_NAME:
-		if (ref_count > minfo->lib_count - 1) {
+		if (ref_count > skl->skl_sst->lib_count - 1) {
 			ref_count = 0;
 			return -EINVAL;
 		}
 
-		strncpy(minfo->lib[ref_count].name, str_elem->string,
-				ARRAY_SIZE(minfo->lib[ref_count].name));
+		strncpy(skl->skl_sst->lib_info[ref_count].name,
+			str_elem->string,
+			ARRAY_SIZE(skl->skl_sst->lib_info[ref_count].name));
 		ref_count++;
 		tkn_count++;
 		break;
@@ -2328,14 +2329,14 @@ static int skl_tplg_fill_str_mfest_tkn(struct device *dev,
 
 static int skl_tplg_get_str_tkn(struct device *dev,
 		struct snd_soc_tplg_vendor_array *array,
-		struct skl_dfw_manifest *minfo)
+		struct skl *skl)
 {
 	int tkn_count = 0, ret;
 	struct snd_soc_tplg_vendor_string_elem *str_elem;
 
 	str_elem = (struct snd_soc_tplg_vendor_string_elem *)array->value;
 	while (tkn_count < array->num_elems) {
-		ret = skl_tplg_fill_str_mfest_tkn(dev, str_elem, minfo);
+		ret = skl_tplg_fill_str_mfest_tkn(dev, str_elem, skl);
 		str_elem++;
 
 		if (ret < 0)
@@ -2349,13 +2350,13 @@ static int skl_tplg_get_str_tkn(struct device *dev,
 
 static int skl_tplg_get_int_tkn(struct device *dev,
 		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
-		struct skl_dfw_manifest *minfo)
+		struct skl *skl)
 {
 	int tkn_count = 0;
 
 	switch (tkn_elem->token) {
 	case SKL_TKN_U32_LIB_COUNT:
-		minfo->lib_count = tkn_elem->value;
+		skl->skl_sst->lib_count = tkn_elem->value;
 		tkn_count++;
 		break;
 
@@ -2372,7 +2373,7 @@ static int skl_tplg_get_int_tkn(struct device *dev,
  * type.
  */
 static int skl_tplg_get_manifest_tkn(struct device *dev,
-		char *pvt_data, struct skl_dfw_manifest *minfo,
+		char *pvt_data, struct skl *skl,
 		int block_size)
 {
 	int tkn_count = 0, ret;
@@ -2388,7 +2389,7 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 		off += array->size;
 		switch (array->type) {
 		case SND_SOC_TPLG_TUPLE_TYPE_STRING:
-			ret = skl_tplg_get_str_tkn(dev, array, minfo);
+			ret = skl_tplg_get_str_tkn(dev, array, skl);
 
 			if (ret < 0)
 				return ret;
@@ -2410,7 +2411,7 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 
 		while (tkn_count <= array->num_elems - 1) {
 			ret = skl_tplg_get_int_tkn(dev,
-					tkn_elem, minfo);
+					tkn_elem, skl);
 			if (ret < 0)
 				return ret;
 
@@ -2431,7 +2432,7 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
  * preceded by descriptors for type and size of data block.
  */
 static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
-			struct device *dev, struct skl_dfw_manifest *minfo)
+			struct device *dev, struct skl *skl)
 {
 	struct snd_soc_tplg_vendor_array *array;
 	int num_blocks, block_size = 0, block_type, off = 0;
@@ -2474,7 +2475,7 @@ static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
 		data = (manifest->priv.data + off);
 
 		if (block_type == SKL_TYPE_TUPLE) {
-			ret = skl_tplg_get_manifest_tkn(dev, data, minfo,
+			ret = skl_tplg_get_manifest_tkn(dev, data, skl,
 					block_size);
 
 			if (ret < 0)
@@ -2492,27 +2493,23 @@ static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
 static int skl_manifest_load(struct snd_soc_component *cmpnt,
 				struct snd_soc_tplg_manifest *manifest)
 {
-	struct skl_dfw_manifest *minfo;
 	struct hdac_ext_bus *ebus = snd_soc_component_get_drvdata(cmpnt);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct skl *skl = ebus_to_skl(ebus);
-	int ret = 0;
 
 	/* proceed only if we have private data defined */
 	if (manifest->priv.size == 0)
 		return 0;
 
-	minfo = &skl->skl_sst->manifest;
-
-	skl_tplg_get_manifest_data(manifest, bus->dev, minfo);
+	skl_tplg_get_manifest_data(manifest, bus->dev, skl);
 
-	if (minfo->lib_count > HDA_MAX_LIB) {
+	if (skl->skl_sst->lib_count > SKL_MAX_LIB) {
 		dev_err(bus->dev, "Exceeding max Library count. Got:%d\n",
-					minfo->lib_count);
-		ret = -EINVAL;
+					skl->skl_sst->lib_count);
+		return  -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 
 static struct snd_soc_tplg_ops skl_tplg_ops  = {
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index a0d3158196f0..fefab0e99a3b 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -334,6 +334,19 @@ struct skl_pipeline {
 	struct list_head node;
 };
 
+#define SKL_LIB_NAME_LENGTH 128
+#define SKL_MAX_LIB 16
+
+struct skl_lib_info {
+	char name[SKL_LIB_NAME_LENGTH];
+	const struct firmware *fw;
+};
+
+struct skl_manifest {
+	u32 lib_count;
+	struct skl_lib_info lib[SKL_MAX_LIB];
+};
+
 static inline struct skl *get_skl_ctx(struct device *dev)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 2f6281e056d6..7a2febf99019 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -157,18 +157,6 @@ struct skl_dfw_algo_data {
 	char params[0];
 } __packed;
 
-#define LIB_NAME_LENGTH	128
-#define HDA_MAX_LIB	16
-
-struct lib_info {
-	char name[LIB_NAME_LENGTH];
-} __packed;
-
-struct skl_dfw_manifest {
-	u32 lib_count;
-	struct lib_info lib[HDA_MAX_LIB];
-} __packed;
-
 enum skl_tkn_dir {
 	SKL_DIR_IN,
 	SKL_DIR_OUT
-- 
2.11.0
