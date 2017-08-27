From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Populate module data
	from topology manifest" to the asoc tree
Date: Sun, 27 Aug 2017 14:38:48 +0100 (BST)
Message-ID: <20170827133848.4BBA74400E7@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 317FA26747B
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 15:38:50 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Guneshwor Singh <guneshwor.o.singh@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Populate module data from topology manifest

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

>From db6ed55de6da1125ff349bfe4ef12d18c366e893 Mon Sep 17 00:00:00 2001
From: Shreyas NC <shreyas.nc@intel.com>
Date: Wed, 23 Aug 2017 19:33:52 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Populate module data from topology
 manifest

All the module common data will now be populated in the topology
manifest. This includes the resource and interface list supported by
the module. With this, driver need not compute the resources required
by each dsp module for a particular pcm parameter since it comes as a
part of the topology manifest.

So, add functions to parse the manifest tokens to populate the module
config data structure.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 320 ++++++++++++++++++++++++++++++++-
 1 file changed, 316 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index df808fbf14b5..f39883067f63 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2038,6 +2038,104 @@ static void skl_tplg_fill_pin_dynamic_val(
 }
 
 /*
+ * Resource table in the manifest has pin specific resources
+ * like pin and pin buffer size
+ */
+static int skl_tplg_manifest_pin_res_tkn(struct device *dev,
+		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
+		struct skl_module_res *res, int pin_idx, int dir)
+{
+	struct skl_module_pin_resources *m_pin;
+
+	switch (dir) {
+	case SKL_DIR_IN:
+		m_pin = &res->input[pin_idx];
+		break;
+
+	case SKL_DIR_OUT:
+		m_pin = &res->output[pin_idx];
+		break;
+
+	default:
+		dev_err(dev, "Invalid pin direction: %d\n", dir);
+		return -EINVAL;
+	}
+
+	switch (tkn_elem->token) {
+	case SKL_TKN_MM_U32_RES_PIN_ID:
+		m_pin->pin_index = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U32_PIN_BUF:
+		m_pin->buf_size = tkn_elem->value;
+		break;
+
+	default:
+		dev_err(dev, "Invalid token: %d\n", tkn_elem->token);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Fill module specific resources from the manifest's resource
+ * table like CPS, DMA size, mem_pages.
+ */
+static int skl_tplg_fill_res_tkn(struct device *dev,
+		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
+		struct skl_module_res *res,
+		int pin_idx, int dir)
+{
+	int ret, tkn_count = 0;
+
+	if (!res)
+		return -EINVAL;
+
+	switch (tkn_elem->token) {
+	case SKL_TKN_MM_U32_CPS:
+		res->cps = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U32_DMA_SIZE:
+		res->dma_buffer_size = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U32_CPC:
+		res->cpc = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U32_MEM_PAGES:
+		res->is_pages = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U32_OBS:
+		res->obs = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U32_IBS:
+		res->ibs = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U32_RES_PIN_ID:
+	case SKL_TKN_MM_U32_PIN_BUF:
+		ret = skl_tplg_manifest_pin_res_tkn(dev, tkn_elem, res,
+						    pin_idx, dir);
+		if (ret < 0)
+			return ret;
+		break;
+
+	default:
+		dev_err(dev, "Not a res type token: %d", tkn_elem->token);
+		return -EINVAL;
+
+	}
+	tkn_count++;
+
+	return tkn_count;
+}
+
+/*
  * Parse tokens to fill up the module private data
  */
 static int skl_tplg_get_token(struct device *dev,
@@ -2625,13 +2723,13 @@ static int skl_tplg_fill_str_mfest_tkn(struct device *dev,
 			str_elem->string,
 			ARRAY_SIZE(skl->skl_sst->lib_info[ref_count].name));
 		ref_count++;
-		tkn_count++;
 		break;
 
 	default:
 		dev_err(dev, "Not a string token %d\n", str_elem->token);
 		break;
 	}
+	tkn_count++;
 
 	return tkn_count;
 }
@@ -2657,26 +2755,236 @@ static int skl_tplg_get_str_tkn(struct device *dev,
 	return tkn_count;
 }
 
+static int skl_tplg_manifest_fill_fmt(struct device *dev,
+		struct skl_module_iface *fmt,
+		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
+		u32 dir, int fmt_idx)
+{
+	struct skl_module_pin_fmt *dst_fmt;
+	struct skl_module_fmt *mod_fmt;
+	int ret;
+
+	if (!fmt)
+		return -EINVAL;
+
+	switch (dir) {
+	case SKL_DIR_IN:
+		dst_fmt = &fmt->inputs[fmt_idx];
+		break;
+
+	case SKL_DIR_OUT:
+		dst_fmt = &fmt->outputs[fmt_idx];
+		break;
+
+	default:
+		dev_err(dev, "Invalid direction: %d\n", dir);
+		return -EINVAL;
+	}
+
+	mod_fmt = &dst_fmt->fmt;
+
+	switch (tkn_elem->token) {
+	case SKL_TKN_MM_U32_INTF_PIN_ID:
+		dst_fmt->id = tkn_elem->value;
+		break;
+
+	default:
+		ret = skl_tplg_fill_fmt(dev, mod_fmt, tkn_elem->token,
+					tkn_elem->value);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+
+	return 0;
+}
+
+static int skl_tplg_fill_mod_info(struct device *dev,
+		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
+		struct skl_module *mod)
+{
+
+	if (!mod)
+		return -EINVAL;
+
+	switch (tkn_elem->token) {
+	case SKL_TKN_U8_IN_PIN_TYPE:
+		mod->input_pin_type = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U8_OUT_PIN_TYPE:
+		mod->output_pin_type = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U8_IN_QUEUE_COUNT:
+		mod->max_input_pins = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U8_OUT_QUEUE_COUNT:
+		mod->max_output_pins = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U8_NUM_RES:
+		mod->nr_resources = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U8_NUM_INTF:
+		mod->nr_interfaces = tkn_elem->value;
+		break;
+
+	default:
+		dev_err(dev, "Invalid mod info token %d", tkn_elem->token);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
 static int skl_tplg_get_int_tkn(struct device *dev,
 		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
 		struct skl *skl)
 {
-	int tkn_count = 0;
+	int tkn_count = 0, ret;
+	static int mod_idx, res_val_idx, intf_val_idx, dir, pin_idx;
+	struct skl_module_res *res = NULL;
+	struct skl_module_iface *fmt = NULL;
+	struct skl_module *mod = NULL;
+	int i;
+
+	if (skl->modules) {
+		mod = skl->modules[mod_idx];
+		res = &mod->resources[res_val_idx];
+		fmt = &mod->formats[intf_val_idx];
+	}
 
 	switch (tkn_elem->token) {
 	case SKL_TKN_U32_LIB_COUNT:
 		skl->skl_sst->lib_count = tkn_elem->value;
-		tkn_count++;
+		break;
+
+	case SKL_TKN_U8_NUM_MOD:
+		skl->nr_modules = tkn_elem->value;
+		skl->modules = devm_kcalloc(dev, skl->nr_modules,
+				sizeof(*skl->modules), GFP_KERNEL);
+		if (!skl->modules)
+			return -ENOMEM;
+
+		for (i = 0; i < skl->nr_modules; i++) {
+			skl->modules[i] = devm_kzalloc(dev,
+					sizeof(struct skl_module), GFP_KERNEL);
+			if (!skl->modules[i])
+				return -ENOMEM;
+		}
+		break;
+
+	case SKL_TKN_MM_U8_MOD_IDX:
+		mod_idx = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U8_IN_PIN_TYPE:
+	case SKL_TKN_U8_OUT_PIN_TYPE:
+	case SKL_TKN_U8_IN_QUEUE_COUNT:
+	case SKL_TKN_U8_OUT_QUEUE_COUNT:
+	case SKL_TKN_MM_U8_NUM_RES:
+	case SKL_TKN_MM_U8_NUM_INTF:
+		ret = skl_tplg_fill_mod_info(dev, tkn_elem, mod);
+		if (ret < 0)
+			return ret;
+		break;
+
+	case SKL_TKN_U32_DIR_PIN_COUNT:
+		dir = tkn_elem->value & SKL_IN_DIR_BIT_MASK;
+		pin_idx = (tkn_elem->value & SKL_PIN_COUNT_MASK) >> 4;
+		break;
+
+	case SKL_TKN_MM_U32_RES_ID:
+		if (!res)
+			return -EINVAL;
+
+		res->id = tkn_elem->value;
+		res_val_idx = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U32_FMT_ID:
+		if (!fmt)
+			return -EINVAL;
+
+		fmt->fmt_idx = tkn_elem->value;
+		intf_val_idx = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U32_CPS:
+	case SKL_TKN_MM_U32_DMA_SIZE:
+	case SKL_TKN_MM_U32_CPC:
+	case SKL_TKN_U32_MEM_PAGES:
+	case SKL_TKN_U32_OBS:
+	case SKL_TKN_U32_IBS:
+	case SKL_TKN_MM_U32_RES_PIN_ID:
+	case SKL_TKN_MM_U32_PIN_BUF:
+		ret = skl_tplg_fill_res_tkn(dev, tkn_elem, res, pin_idx, dir);
+		if (ret < 0)
+			return ret;
+
+		break;
+
+	case SKL_TKN_MM_U32_NUM_IN_FMT:
+		if (!fmt)
+			return -EINVAL;
+
+		res->nr_input_pins = tkn_elem->value;
+		break;
+
+	case SKL_TKN_MM_U32_NUM_OUT_FMT:
+		if (!fmt)
+			return -EINVAL;
+
+		res->nr_output_pins = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U32_FMT_CH:
+	case SKL_TKN_U32_FMT_FREQ:
+	case SKL_TKN_U32_FMT_BIT_DEPTH:
+	case SKL_TKN_U32_FMT_SAMPLE_SIZE:
+	case SKL_TKN_U32_FMT_CH_CONFIG:
+	case SKL_TKN_U32_FMT_INTERLEAVE:
+	case SKL_TKN_U32_FMT_SAMPLE_TYPE:
+	case SKL_TKN_U32_FMT_CH_MAP:
+	case SKL_TKN_MM_U32_INTF_PIN_ID:
+		ret = skl_tplg_manifest_fill_fmt(dev, fmt, tkn_elem,
+						 dir, pin_idx);
+		if (ret < 0)
+			return ret;
 		break;
 
 	default:
 		dev_err(dev, "Not a manifest token %d\n", tkn_elem->token);
 		return -EINVAL;
 	}
+	tkn_count++;
 
 	return tkn_count;
 }
 
+static int skl_tplg_get_manifest_uuid(struct device *dev,
+				struct skl *skl,
+				struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
+{
+	static int ref_count;
+	struct skl_module *mod;
+
+	if (uuid_tkn->token == SKL_TKN_UUID) {
+		mod = skl->modules[ref_count];
+		memcpy(&mod->uuid, &uuid_tkn->uuid, sizeof(uuid_tkn->uuid));
+		ref_count++;
+	} else {
+		dev_err(dev, "Not an UUID token tkn %d\n", uuid_tkn->token);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Fill the manifest structure by parsing the tokens based on the
  * type.
@@ -2709,7 +3017,11 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 			continue;
 
 		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
-			dev_warn(dev, "no uuid tokens for skl tplf manifest\n");
+			ret = skl_tplg_get_manifest_uuid(dev, skl, array->uuid);
+			if (ret < 0)
+				return ret;
+
+			tuple_size += sizeof(*array->uuid);
 			continue;
 
 		default:
-- 
2.13.2
