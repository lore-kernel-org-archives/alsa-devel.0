From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] ASoC: Intel: Skylake: Parse manifest data
Date: Fri, 12 Aug 2016 12:29:53 +0530
Message-ID: <1470985193-10680-5-git-send-email-vinod.koul@intel.com>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8EC266F5D
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 08:52:20 +0200 (CEST)
In-Reply-To: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

Topology manifest has lib names and lib count info. So,
define tokens to represent module private data and parse
these tokens to fill up the manifest structure in the driver
accordingly.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/snd_sst_tokens.h    |   8 +-
 sound/soc/intel/skylake/skl-topology.c | 194 ++++++++++++++++++++++++++++++++-
 2 files changed, 200 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index f56a932736ca..1ee2e943d66a 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -153,6 +153,10 @@
  *
  * %SKL_TKN_U32_PROC_DOMAIN:    Specify processing domain
  *
+ * %SKL_TKN_U32_LIB_COUNT:      Specifies the number of libraries
+ *
+ * %SKL_TKN_STR_LIB_NAME:       Specifies the library name
+ *
  * module_id and loadable flags dont have tokens as these values will be
  * read from the DSP FW manifest
  */
@@ -202,7 +206,9 @@ enum SKL_TKNS {
 	SKL_TKN_U32_CAPS_PARAMS_ID,
 	SKL_TKN_U32_CAPS_SIZE,
 	SKL_TKN_U32_PROC_DOMAIN,
-	SKL_TKN_MAX = SKL_TKN_U32_PROC_DOMAIN,
+	SKL_TKN_U32_LIB_COUNT,
+	SKL_TKN_STR_LIB_NAME,
+	SKL_TKN_MAX = SKL_TKN_STR_LIB_NAME,
 };
 
 #endif
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index df58691d0b3c..4d3d7e386bb9 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2201,6 +2201,197 @@ static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
 	return 0;
 }
 
+static int skl_tplg_fill_str_mfest_tkn(struct device *dev,
+		struct snd_soc_tplg_vendor_string_elem *str_elem,
+		struct skl_dfw_manifest *minfo)
+{
+	int tkn_count = 0;
+	static int ref_count;
+
+	switch (str_elem->token) {
+	case SKL_TKN_STR_LIB_NAME:
+		if (ref_count > minfo->lib_count - 1) {
+			ref_count = 0;
+			return -EINVAL;
+		}
+
+		strncpy(minfo->lib[ref_count].name, str_elem->string,
+				ARRAY_SIZE(minfo->lib[ref_count].name));
+		ref_count++;
+		tkn_count++;
+		break;
+
+	default:
+		dev_err(dev, "Not a string token %d", str_elem->token);
+		break;
+	}
+
+	return tkn_count;
+}
+
+static int skl_tplg_get_str_tkn(struct device *dev,
+		struct snd_soc_tplg_vendor_array *array,
+		struct skl_dfw_manifest *minfo)
+{
+	int tkn_count = 0, ret;
+	struct snd_soc_tplg_vendor_string_elem *str_elem;
+
+	str_elem = (struct snd_soc_tplg_vendor_string_elem *)array->value;
+	while (tkn_count < array->num_elems) {
+		ret = skl_tplg_fill_str_mfest_tkn(dev, str_elem, minfo);
+		str_elem++;
+
+		if (ret < 0)
+			return ret;
+
+		tkn_count = tkn_count + ret;
+	}
+
+	return tkn_count;
+}
+
+static int skl_tplg_get_int_tkn(struct device *dev,
+		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
+		struct skl_dfw_manifest *minfo)
+{
+	int tkn_count = 0;
+
+	switch (tkn_elem->token) {
+	case SKL_TKN_U32_LIB_COUNT:
+		minfo->lib_count = tkn_elem->value;
+		tkn_count++;
+		break;
+
+	default:
+		dev_err(dev, "Not a manifest token %d", tkn_elem->token);
+		return -EINVAL;
+	}
+
+	return tkn_count;
+}
+
+/*
+ * Fill the manifest structure by parsing the tokens based on the
+ * type.
+ */
+static int skl_tplg_get_manifest_tkn(struct device *dev,
+		char *pvt_data, struct skl_dfw_manifest *minfo,
+		int block_size)
+{
+	int tkn_count = 0, ret;
+	int off = 0, tuple_size = 0;
+	struct snd_soc_tplg_vendor_array *array;
+	struct snd_soc_tplg_vendor_value_elem *tkn_elem;
+
+	if (block_size <= 0)
+		return -EINVAL;
+
+	while (tuple_size < block_size) {
+		array = (struct snd_soc_tplg_vendor_array *)(pvt_data + off);
+		off += array->size;
+		switch (array->type) {
+		case SND_SOC_TPLG_TUPLE_TYPE_STRING:
+			ret = skl_tplg_get_str_tkn(dev, array, minfo);
+
+			if (ret < 0)
+				return ret;
+			tkn_count += ret;
+
+			tuple_size += tkn_count *
+				sizeof(struct snd_soc_tplg_vendor_string_elem);
+			continue;
+
+		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
+			dev_warn(dev, "no uuid tokens for skl tplf manifest");
+			continue;
+
+		default:
+			tkn_elem = array->value;
+			tkn_count = 0;
+			break;
+		}
+
+		while (tkn_count <= array->num_elems - 1) {
+			ret = skl_tplg_get_int_tkn(dev,
+					tkn_elem, minfo);
+			if (ret < 0)
+				return ret;
+
+			tkn_count = tkn_count + ret;
+			tkn_elem++;
+			tuple_size += tkn_count *
+				sizeof(struct snd_soc_tplg_vendor_value_elem);
+			break;
+		}
+		tkn_count = 0;
+	}
+
+	return 0;
+}
+
+/*
+ * Parse manifest private data for tokens. The private data block is
+ * preceded by descriptors for type and size of data block.
+ */
+static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
+			struct device *dev, struct skl_dfw_manifest *minfo)
+{
+	struct snd_soc_tplg_vendor_array *array;
+	int num_blocks, block_size = 0, block_type, off = 0;
+	char *data;
+	int ret;
+
+	/* Read the NUM_DATA_BLOCKS descriptor */
+	array = (struct snd_soc_tplg_vendor_array *)manifest->priv.data;
+	ret = skl_tplg_get_desc_blocks(dev, array);
+	if (ret < 0)
+		return ret;
+	num_blocks = ret;
+
+	off += array->size;
+	array = (struct snd_soc_tplg_vendor_array *)
+			(manifest->priv.data + off);
+
+	/* Read the BLOCK_TYPE and BLOCK_SIZE descriptor */
+	while (num_blocks > 0) {
+		ret = skl_tplg_get_desc_blocks(dev, array);
+
+		if (ret < 0)
+			return ret;
+		block_type = ret;
+		off += array->size;
+
+		array = (struct snd_soc_tplg_vendor_array *)
+			(manifest->priv.data + off);
+
+		ret = skl_tplg_get_desc_blocks(dev, array);
+
+		if (ret < 0)
+			return ret;
+		block_size = ret;
+		off += array->size;
+
+		array = (struct snd_soc_tplg_vendor_array *)
+			(manifest->priv.data + off);
+
+		data = (manifest->priv.data + off);
+
+		if (block_type == SKL_TYPE_TUPLE) {
+			ret = skl_tplg_get_manifest_tkn(dev, data, minfo,
+					block_size);
+
+			if (ret < 0)
+				return ret;
+
+			--num_blocks;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int skl_manifest_load(struct snd_soc_component *cmpnt,
 				struct snd_soc_tplg_manifest *manifest)
 {
@@ -2215,7 +2406,8 @@ static int skl_manifest_load(struct snd_soc_component *cmpnt,
 		return 0;
 
 	minfo = &skl->skl_sst->manifest;
-	memcpy(minfo, manifest->priv.data, sizeof(struct skl_dfw_manifest));
+
+	skl_tplg_get_manifest_data(manifest, bus->dev, minfo);
 
 	if (minfo->lib_count > HDA_MAX_LIB) {
 		dev_err(bus->dev, "Exceeding max Library count. Got:%d\n",
-- 
1.9.1
