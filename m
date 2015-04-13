From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 10/13] ASoC: wm_adsp: Add basic support for rev
	1 firmware file format
Date: Mon, 13 Apr 2015 13:28:02 +0100
Message-ID: <1428928085-20250-11-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42FBA26514A
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:12 +0200 (CEST)
In-Reply-To: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Revision one of the file format includes new algorithm and coefficient
blocks which provide additional information about the controls exported
by the firmware. This patch updates the processing to handle this
version of the file format. Note that whilst this version of the format
adds support for specifying a name for the control through the firmware
file this has not been used and to keep compatibility with existing
deployments no changes to the firmware control naming are made by this
patch.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  239 +++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/wm_adsp.h |    1 +
 sound/soc/codecs/wmfw.h    |   35 ++++++-
 3 files changed, 226 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f42b453..16b308a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -229,12 +229,14 @@ struct wm_coeff_ctl_ops {
 
 struct wm_coeff_ctl {
 	const char *name;
+	const char *fw_name;
 	struct wm_adsp_alg_region alg_region;
 	struct wm_coeff_ctl_ops ops;
 	struct wm_adsp *dsp;
 	unsigned int enabled:1;
 	struct list_head list;
 	void *cache;
+	unsigned int offset;
 	size_t len;
 	unsigned int set:1;
 	struct snd_kcontrol *kcontrol;
@@ -388,7 +390,7 @@ static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 		return -EINVAL;
 	}
 
-	reg = ctl->alg_region.base;
+	reg = ctl->alg_region.base + ctl->offset;
 	reg = wm_adsp_region_to_reg(mem, reg);
 
 	scratch = kmemdup(buf, ctl->len, GFP_KERNEL | GFP_DMA);
@@ -442,7 +444,7 @@ static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 		return -EINVAL;
 	}
 
-	reg = ctl->alg_region.base;
+	reg = ctl->alg_region.base + ctl->offset;
 	reg = wm_adsp_region_to_reg(mem, reg);
 
 	scratch = kmalloc(ctl->len, GFP_KERNEL | GFP_DMA);
@@ -509,8 +511,6 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 	ctl->kcontrol = snd_soc_card_get_kcontrol(dsp->card,
 						  ctl->name);
 
-	list_add(&ctl->list, &dsp->ctl_list);
-
 	return 0;
 
 err_kcontrol:
@@ -568,7 +568,8 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 
 static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *alg_region,
-				  unsigned int len)
+				  unsigned int offset, unsigned int len,
+				  const char *subname, unsigned int subname_len)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -593,6 +594,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		region_name = "ZM";
 		break;
 	default:
+		adsp_err(dsp, "Unknown region type: %d\n", alg_region->type);
 		return -EINVAL;
 	}
 
@@ -611,6 +613,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
 	if (!ctl)
 		return -ENOMEM;
+	ctl->fw_name = wm_adsp_fw_text[dsp->fw];
 	ctl->alg_region = *alg_region;
 	ctl->name = kmemdup(name, strlen(name) + 1, GFP_KERNEL);
 	if (!ctl->name) {
@@ -623,6 +626,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	ctl->ops.xput = wm_coeff_put;
 	ctl->dsp = dsp;
 
+	ctl->offset = offset;
 	if (len > 512) {
 		adsp_warn(dsp, "Truncating control %s from %d\n",
 			  ctl->name, len);
@@ -635,6 +639,8 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		goto err_ctl_name;
 	}
 
+	list_add(&ctl->list, &dsp->ctl_list);
+
 	ctl_work = kzalloc(sizeof(*ctl_work), GFP_KERNEL);
 	if (!ctl_work) {
 		ret = -ENOMEM;
@@ -658,6 +664,103 @@ err_ctl:
 	return ret;
 }
 
+struct wm_coeff_parsed_alg {
+	int id;
+	const u8 *name;
+	int name_len;
+	int ncoeff;
+};
+
+struct wm_coeff_parsed_coeff {
+	int offset;
+	int mem_type;
+	const u8 *name;
+	int name_len;
+	int ctl_type;
+	int flags;
+	int len;
+};
+
+static inline void wm_coeff_parse_alg(struct wm_adsp *dsp, const u8 **data,
+				      struct wm_coeff_parsed_alg *blk)
+{
+	const struct wmfw_adsp_alg_data *raw;
+
+	raw = (const struct wmfw_adsp_alg_data *)*data;
+	*data = raw->data;
+
+	blk->id = le32_to_cpu(raw->id);
+	blk->name = raw->name;
+	blk->name_len = strlen(raw->name);
+	blk->ncoeff = le32_to_cpu(raw->ncoeff);
+
+	adsp_dbg(dsp, "Algorithm ID: %#x\n", blk->id);
+	adsp_dbg(dsp, "Algorithm name: %.*s\n", blk->name_len, blk->name);
+	adsp_dbg(dsp, "# of coefficient descriptors: %#x\n", blk->ncoeff);
+}
+
+static inline void wm_coeff_parse_coeff(struct wm_adsp *dsp, const u8 **data,
+					struct wm_coeff_parsed_coeff *blk)
+{
+	const struct wmfw_adsp_coeff_data *raw;
+
+	raw = (const struct wmfw_adsp_coeff_data *)*data;
+	*data = *data + sizeof(raw->hdr) + le32_to_cpu(raw->hdr.size);
+
+	blk->offset = le16_to_cpu(raw->hdr.offset);
+	blk->mem_type = le16_to_cpu(raw->hdr.type);
+	blk->name = raw->name;
+	blk->name_len = strlen(raw->name);
+	blk->ctl_type = le16_to_cpu(raw->ctl_type);
+	blk->flags = le16_to_cpu(raw->flags);
+	blk->len = le32_to_cpu(raw->len);
+
+	adsp_dbg(dsp, "\tCoefficient type: %#x\n", blk->mem_type);
+	adsp_dbg(dsp, "\tCoefficient offset: %#x\n", blk->offset);
+	adsp_dbg(dsp, "\tCoefficient name: %.*s\n", blk->name_len, blk->name);
+	adsp_dbg(dsp, "\tCoefficient flags: %#x\n", blk->flags);
+	adsp_dbg(dsp, "\tALSA control type: %#x\n", blk->ctl_type);
+	adsp_dbg(dsp, "\tALSA control len: %#x\n", blk->len);
+}
+
+static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
+			       const struct wmfw_region *region)
+{
+	struct wm_adsp_alg_region alg_region = {};
+	struct wm_coeff_parsed_alg alg_blk;
+	struct wm_coeff_parsed_coeff coeff_blk;
+	const u8 *data = region->data;
+	int i, ret;
+
+	wm_coeff_parse_alg(dsp, &data, &alg_blk);
+	for (i = 0; i < alg_blk.ncoeff; i++) {
+		wm_coeff_parse_coeff(dsp, &data, &coeff_blk);
+
+		switch (coeff_blk.ctl_type) {
+		case SNDRV_CTL_ELEM_TYPE_BYTES:
+			break;
+		default:
+			adsp_err(dsp, "Unknown control type: %d\n",
+				 coeff_blk.ctl_type);
+			return -EINVAL;
+		}
+
+		alg_region.type = coeff_blk.mem_type;
+		alg_region.alg = alg_blk.id;
+
+		ret = wm_adsp_create_control(dsp, &alg_region,
+					     coeff_blk.offset,
+					     coeff_blk.len,
+					     coeff_blk.name,
+					     coeff_blk.name_len);
+		if (ret < 0)
+			adsp_err(dsp, "Failed to create control: %.*s, %d\n",
+				 coeff_blk.name_len, coeff_blk.name, ret);
+	}
+
+	return 0;
+}
+
 static int wm_adsp_load(struct wm_adsp *dsp)
 {
 	LIST_HEAD(buf_list);
@@ -706,12 +809,18 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		goto out_fw;
 	}
 
-	if (header->ver != 0) {
+	switch (header->ver) {
+	case 0:
+	case 1:
+		break;
+	default:
 		adsp_err(dsp, "%s: unknown file format %d\n",
 			 file, header->ver);
 		goto out_fw;
 	}
+
 	adsp_info(dsp, "Firmware version: %d\n", header->ver);
+	dsp->fw_ver = header->ver;
 
 	if (header->core != dsp->type) {
 		adsp_err(dsp, "%s: invalid core %d != %d\n",
@@ -776,6 +885,12 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 			text = kzalloc(le32_to_cpu(region->len) + 1,
 				       GFP_KERNEL);
 			break;
+		case WMFW_ALGORITHM_DATA:
+			region_name = "Algorithm";
+			ret = wm_adsp_parse_coeff(dsp, region);
+			if (ret != 0)
+				goto out_fw;
+			break;
 		case WMFW_INFO_TEXT:
 			region_name = "Information";
 			text = kzalloc(le32_to_cpu(region->len) + 1,
@@ -868,6 +983,20 @@ out:
 	return ret;
 }
 
+static void wm_adsp_ctl_fixup_base(struct wm_adsp *dsp,
+				  const struct wm_adsp_alg_region *alg_region)
+{
+	struct wm_coeff_ctl *ctl;
+
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		if (ctl->fw_name == wm_adsp_fw_text[dsp->fw] &&
+		    alg_region->alg == ctl->alg_region.alg &&
+		    alg_region->type == ctl->alg_region.type) {
+			ctl->alg_region.base = alg_region->base;
+		}
+	}
+}
+
 static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 			       unsigned int pos, unsigned int len)
 {
@@ -928,6 +1057,9 @@ static struct wm_adsp_alg_region *wm_adsp_create_region(struct wm_adsp *dsp,
 
 	list_add_tail(&alg_region->list, &dsp->alg_regions);
 
+	if (dsp->fw_ver > 0)
+		wm_adsp_ctl_fixup_base(dsp, alg_region);
+
 	return alg_region;
 }
 
@@ -995,14 +1127,17 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (i + 1 < n_algs) {
-			len = be32_to_cpu(adsp1_alg[i + 1].dm);
-			len -= be32_to_cpu(adsp1_alg[i].dm);
-			len *= 4;
-			wm_adsp_create_control(dsp, alg_region, len);
-		} else {
-			adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
-				  be32_to_cpu(adsp1_alg[i].alg.id));
+		if (dsp->fw_ver == 0) {
+			if (i + 1 < n_algs) {
+				len = be32_to_cpu(adsp1_alg[i + 1].dm);
+				len -= be32_to_cpu(adsp1_alg[i].dm);
+				len *= 4;
+				wm_adsp_create_control(dsp, alg_region, 0,
+						       len, NULL, 0);
+			} else {
+				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
+					  be32_to_cpu(adsp1_alg[i].alg.id));
+			}
 		}
 
 		alg_region = wm_adsp_create_region(dsp, WMFW_ADSP1_ZM,
@@ -1012,14 +1147,17 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (i + 1 < n_algs) {
-			len = be32_to_cpu(adsp1_alg[i + 1].zm);
-			len -= be32_to_cpu(adsp1_alg[i].zm);
-			len *= 4;
-			wm_adsp_create_control(dsp, alg_region, len);
-		} else {
-			adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
-				  be32_to_cpu(adsp1_alg[i].alg.id));
+		if (dsp->fw_ver == 0) {
+			if (i + 1 < n_algs) {
+				len = be32_to_cpu(adsp1_alg[i + 1].zm);
+				len -= be32_to_cpu(adsp1_alg[i].zm);
+				len *= 4;
+				wm_adsp_create_control(dsp, alg_region, 0,
+						       len, NULL, 0);
+			} else {
+				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
+					  be32_to_cpu(adsp1_alg[i].alg.id));
+			}
 		}
 	}
 
@@ -1099,14 +1237,17 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (i + 1 < n_algs) {
-			len = be32_to_cpu(adsp2_alg[i + 1].xm);
-			len -= be32_to_cpu(adsp2_alg[i].xm);
-			len *= 4;
-			wm_adsp_create_control(dsp, alg_region, len);
-		} else {
-			adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
-				  be32_to_cpu(adsp2_alg[i].alg.id));
+		if (dsp->fw_ver == 0) {
+			if (i + 1 < n_algs) {
+				len = be32_to_cpu(adsp2_alg[i + 1].xm);
+				len -= be32_to_cpu(adsp2_alg[i].xm);
+				len *= 4;
+				wm_adsp_create_control(dsp, alg_region, 0,
+						       len, NULL, 0);
+			} else {
+				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
+					  be32_to_cpu(adsp2_alg[i].alg.id));
+			}
 		}
 
 		alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_YM,
@@ -1116,14 +1257,17 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (i + 1 < n_algs) {
-			len = be32_to_cpu(adsp2_alg[i + 1].ym);
-			len -= be32_to_cpu(adsp2_alg[i].ym);
-			len *= 4;
-			wm_adsp_create_control(dsp, alg_region, len);
-		} else {
-			adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
-				  be32_to_cpu(adsp2_alg[i].alg.id));
+		if (dsp->fw_ver == 0) {
+			if (i + 1 < n_algs) {
+				len = be32_to_cpu(adsp2_alg[i + 1].ym);
+				len -= be32_to_cpu(adsp2_alg[i].ym);
+				len *= 4;
+				wm_adsp_create_control(dsp, alg_region, 0,
+						       len, NULL, 0);
+			} else {
+				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
+					  be32_to_cpu(adsp2_alg[i].alg.id));
+			}
 		}
 
 		alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_ZM,
@@ -1133,14 +1277,17 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (i + 1 < n_algs) {
-			len = be32_to_cpu(adsp2_alg[i + 1].zm);
-			len -= be32_to_cpu(adsp2_alg[i].zm);
-			len *= 4;
-			wm_adsp_create_control(dsp, alg_region, len);
-		} else {
-			adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
-				  be32_to_cpu(adsp2_alg[i].alg.id));
+		if (dsp->fw_ver == 0) {
+			if (i + 1 < n_algs) {
+				len = be32_to_cpu(adsp2_alg[i + 1].zm);
+				len -= be32_to_cpu(adsp2_alg[i].zm);
+				len *= 4;
+				wm_adsp_create_control(dsp, alg_region, 0,
+						       len, NULL, 0);
+			} else {
+				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
+					  be32_to_cpu(adsp2_alg[i].alg.id));
+			}
 		}
 	}
 
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 0ad14e0..4fe0667 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -53,6 +53,7 @@ struct wm_adsp {
 	int num_mems;
 
 	int fw;
+	int fw_ver;
 	bool running;
 
 	struct regulator *dvfs;
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index 34c14b5..04690b2 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -15,6 +15,12 @@
 
 #include <linux/types.h>
 
+#define WMFW_MAX_ALG_NAME         256
+#define WMFW_MAX_ALG_DESCR_NAME   256
+
+#define WMFW_MAX_COEFF_NAME       256
+#define WMFW_MAX_COEFF_DESCR_NAME 256
+
 struct wmfw_header {
 	char magic[4];
 	__le32 len;
@@ -90,6 +96,28 @@ struct wmfw_adsp2_alg_hdr {
 	__be32 ym;
 } __packed;
 
+struct wmfw_adsp_alg_data {
+	__le32 id;
+	u8 name[WMFW_MAX_ALG_NAME];
+	u8 descr[WMFW_MAX_ALG_DESCR_NAME];
+	__le32 ncoeff;
+	u8 data[];
+} __packed;
+
+struct wmfw_adsp_coeff_data {
+	struct {
+		__le16 offset;
+		__le16 type;
+		__le32 size;
+	} hdr;
+	u8 name[WMFW_MAX_COEFF_NAME];
+	u8 descr[WMFW_MAX_COEFF_DESCR_NAME];
+	__le16 ctl_type;
+	__le16 flags;
+	__le32 len;
+	u8 data[];
+} __packed;
+
 struct wmfw_coeff_hdr {
 	u8 magic[4];
 	__le32 len;
@@ -117,9 +145,10 @@ struct wmfw_coeff_item {
 #define WMFW_ADSP1 1
 #define WMFW_ADSP2 2
 
-#define WMFW_ABSOLUTE  0xf0
-#define WMFW_NAME_TEXT 0xfe
-#define WMFW_INFO_TEXT 0xff
+#define WMFW_ABSOLUTE         0xf0
+#define WMFW_ALGORITHM_DATA   0xf2
+#define WMFW_NAME_TEXT        0xfe
+#define WMFW_INFO_TEXT        0xff
 
 #define WMFW_ADSP1_PM 2
 #define WMFW_ADSP1_DM 3
-- 
1.7.2.5
