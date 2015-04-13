From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 01/13] ASoC: wm_adsp: Split out adsp1 & 2 setup
	algorithms
Date: Mon, 13 Apr 2015 13:27:53 +0100
Message-ID: <1428928085-20250-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BBF6F26508C
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:03 +0200 (CEST)
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

The vast majority of the wm_adsp_setup_algs function is case statements
for ADSP1 or ADSP2, this patch splits this out into two separate
functions wm_adsp1_setup_algs and wm_adsp2_setup_algs. The small amount
of shared code between them is factored out into an extra helper
function. This makes the code a lot cleaner.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  499 ++++++++++++++++++++++----------------------
 1 files changed, 248 insertions(+), 251 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d01c209..f421c09 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -876,298 +876,295 @@ err_name:
 	return ret;
 }
 
-static int wm_adsp_setup_algs(struct wm_adsp *dsp)
+static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t algs,
+			       unsigned int pos, unsigned int len)
 {
-	struct regmap *regmap = dsp->regmap;
-	struct wmfw_adsp1_id_hdr adsp1_id;
-	struct wmfw_adsp2_id_hdr adsp2_id;
-	struct wmfw_adsp1_alg_hdr *adsp1_alg;
-	struct wmfw_adsp2_alg_hdr *adsp2_alg;
-	void *alg, *buf;
-	struct wm_adsp_alg_region *region;
-	const struct wm_adsp_region *mem;
-	unsigned int pos, term;
-	size_t algs, buf_size;
+	void *alg;
+	int ret;
 	__be32 val;
-	int i, ret;
 
-	switch (dsp->type) {
-	case WMFW_ADSP1:
-		mem = wm_adsp_find_region(dsp, WMFW_ADSP1_DM);
-		break;
-	case WMFW_ADSP2:
-		mem = wm_adsp_find_region(dsp, WMFW_ADSP2_XM);
-		break;
-	default:
-		mem = NULL;
-		break;
+	if (algs == 0) {
+		adsp_err(dsp, "No algorithms\n");
+		return ERR_PTR(-EINVAL);
 	}
 
-	if (WARN_ON(!mem))
-		return -EINVAL;
+	if (algs > 1024) {
+		adsp_err(dsp, "Algorithm count %zx excessive\n", algs);
+		return ERR_PTR(-EINVAL);
+	}
 
-	switch (dsp->type) {
-	case WMFW_ADSP1:
-		ret = regmap_raw_read(regmap, mem->base, &adsp1_id,
-				      sizeof(adsp1_id));
-		if (ret != 0) {
-			adsp_err(dsp, "Failed to read algorithm info: %d\n",
-				 ret);
-			return ret;
-		}
+	/* Read the terminator first to validate the length */
+	ret = regmap_raw_read(dsp->regmap, pos + len, &val, sizeof(val));
+	if (ret != 0) {
+		adsp_err(dsp, "Failed to read algorithm list end: %d\n",
+			ret);
+		return ERR_PTR(ret);
+	}
 
-		buf = &adsp1_id;
-		buf_size = sizeof(adsp1_id);
+	if (be32_to_cpu(val) != 0xbedead)
+		adsp_warn(dsp, "Algorithm list end %x 0x%x != 0xbeadead\n",
+			  pos + len, be32_to_cpu(val));
 
-		algs = be32_to_cpu(adsp1_id.algs);
-		dsp->fw_id = be32_to_cpu(adsp1_id.fw.id);
-		adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
-			  dsp->fw_id,
-			  (be32_to_cpu(adsp1_id.fw.ver) & 0xff0000) >> 16,
-			  (be32_to_cpu(adsp1_id.fw.ver) & 0xff00) >> 8,
-			  be32_to_cpu(adsp1_id.fw.ver) & 0xff,
-			  algs);
+	alg = kzalloc(len * 2, GFP_KERNEL | GFP_DMA);
+	if (!alg)
+		return ERR_PTR(-ENOMEM);
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region)
-			return -ENOMEM;
-		region->type = WMFW_ADSP1_ZM;
-		region->alg = be32_to_cpu(adsp1_id.fw.id);
-		region->base = be32_to_cpu(adsp1_id.zm);
-		list_add_tail(&region->list, &dsp->alg_regions);
+	ret = regmap_raw_read(dsp->regmap, pos, alg, len * 2);
+	if (ret != 0) {
+		adsp_err(dsp, "Failed to read algorithm list: %d\n",
+			ret);
+		kfree(alg);
+		return ERR_PTR(ret);
+	}
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region)
-			return -ENOMEM;
-		region->type = WMFW_ADSP1_DM;
-		region->alg = be32_to_cpu(adsp1_id.fw.id);
-		region->base = be32_to_cpu(adsp1_id.dm);
-		list_add_tail(&region->list, &dsp->alg_regions);
+	return alg;
+}
 
-		pos = sizeof(adsp1_id) / 2;
-		term = pos + ((sizeof(*adsp1_alg) * algs) / 2);
-		break;
+static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
+{
+	struct wmfw_adsp1_id_hdr adsp1_id;
+	struct wmfw_adsp1_alg_hdr *adsp1_alg;
+	struct wm_adsp_alg_region *region;
+	const struct wm_adsp_region *mem;
+	unsigned int pos, len;
+	size_t algs;
+	int i, ret;
 
-	case WMFW_ADSP2:
-		ret = regmap_raw_read(regmap, mem->base, &adsp2_id,
-				      sizeof(adsp2_id));
-		if (ret != 0) {
-			adsp_err(dsp, "Failed to read algorithm info: %d\n",
-				 ret);
-			return ret;
-		}
+	mem = wm_adsp_find_region(dsp, WMFW_ADSP1_DM);
+	if (WARN_ON(!mem))
+		return -EINVAL;
+
+	ret = regmap_raw_read(dsp->regmap, mem->base, &adsp1_id,
+			      sizeof(adsp1_id));
+	if (ret != 0) {
+		adsp_err(dsp, "Failed to read algorithm info: %d\n",
+			 ret);
+		return ret;
+	}
 
-		buf = &adsp2_id;
-		buf_size = sizeof(adsp2_id);
+	algs = be32_to_cpu(adsp1_id.algs);
+	dsp->fw_id = be32_to_cpu(adsp1_id.fw.id);
+	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
+		  dsp->fw_id,
+		  (be32_to_cpu(adsp1_id.fw.ver) & 0xff0000) >> 16,
+		  (be32_to_cpu(adsp1_id.fw.ver) & 0xff00) >> 8,
+		  be32_to_cpu(adsp1_id.fw.ver) & 0xff,
+		  algs);
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+	region->type = WMFW_ADSP1_ZM;
+	region->alg = be32_to_cpu(adsp1_id.fw.id);
+	region->base = be32_to_cpu(adsp1_id.zm);
+	list_add_tail(&region->list, &dsp->alg_regions);
 
-		algs = be32_to_cpu(adsp2_id.algs);
-		dsp->fw_id = be32_to_cpu(adsp2_id.fw.id);
-		adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
-			  dsp->fw_id,
-			  (be32_to_cpu(adsp2_id.fw.ver) & 0xff0000) >> 16,
-			  (be32_to_cpu(adsp2_id.fw.ver) & 0xff00) >> 8,
-			  be32_to_cpu(adsp2_id.fw.ver) & 0xff,
-			  algs);
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+	region->type = WMFW_ADSP1_DM;
+	region->alg = be32_to_cpu(adsp1_id.fw.id);
+	region->base = be32_to_cpu(adsp1_id.dm);
+	list_add_tail(&region->list, &dsp->alg_regions);
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region)
-			return -ENOMEM;
-		region->type = WMFW_ADSP2_XM;
-		region->alg = be32_to_cpu(adsp2_id.fw.id);
-		region->base = be32_to_cpu(adsp2_id.xm);
-		list_add_tail(&region->list, &dsp->alg_regions);
+	pos = sizeof(adsp1_id) / 2;
+	len = (sizeof(*adsp1_alg) * algs) / 2;
+
+	adsp1_alg = wm_adsp_read_algs(dsp, algs, mem->base + pos, len);
+	if (IS_ERR(adsp1_alg))
+		return PTR_ERR(adsp1_alg);
+
+	for (i = 0; i < algs; i++) {
+		adsp_info(dsp, "%d: ID %x v%d.%d.%d DM@%x ZM@%x\n",
+			  i, be32_to_cpu(adsp1_alg[i].alg.id),
+			  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff0000) >> 16,
+			  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff00) >> 8,
+			  be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff,
+			  be32_to_cpu(adsp1_alg[i].dm),
+			  be32_to_cpu(adsp1_alg[i].zm));
 
 		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region)
-			return -ENOMEM;
-		region->type = WMFW_ADSP2_YM;
-		region->alg = be32_to_cpu(adsp2_id.fw.id);
-		region->base = be32_to_cpu(adsp2_id.ym);
+		if (!region) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		region->type = WMFW_ADSP1_DM;
+		region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
+		region->base = be32_to_cpu(adsp1_alg[i].dm);
+		region->len = 0;
 		list_add_tail(&region->list, &dsp->alg_regions);
+		if (i + 1 < algs) {
+			region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
+			region->len -= be32_to_cpu(adsp1_alg[i].dm);
+			region->len *= 4;
+			wm_adsp_create_control(dsp, region);
+		} else {
+			adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
+				  be32_to_cpu(adsp1_alg[i].alg.id));
+		}
 
 		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region)
-			return -ENOMEM;
-		region->type = WMFW_ADSP2_ZM;
-		region->alg = be32_to_cpu(adsp2_id.fw.id);
-		region->base = be32_to_cpu(adsp2_id.zm);
+		if (!region) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		region->type = WMFW_ADSP1_ZM;
+		region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
+		region->base = be32_to_cpu(adsp1_alg[i].zm);
+		region->len = 0;
 		list_add_tail(&region->list, &dsp->alg_regions);
-
-		pos = sizeof(adsp2_id) / 2;
-		term = pos + ((sizeof(*adsp2_alg) * algs) / 2);
-		break;
-
-	default:
-		WARN(1, "Unknown DSP type");
-		return -EINVAL;
+		if (i + 1 < algs) {
+			region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
+			region->len -= be32_to_cpu(adsp1_alg[i].zm);
+			region->len *= 4;
+			wm_adsp_create_control(dsp, region);
+		} else {
+			adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
+				  be32_to_cpu(adsp1_alg[i].alg.id));
+		}
 	}
 
-	if (algs == 0) {
-		adsp_err(dsp, "No algorithms\n");
-		return -EINVAL;
-	}
+out:
+	kfree(adsp1_alg);
+	return ret;
+}
 
-	if (algs > 1024) {
-		adsp_err(dsp, "Algorithm count %zx excessive\n", algs);
-		print_hex_dump_bytes(dev_name(dsp->dev), DUMP_PREFIX_OFFSET,
-				     buf, buf_size);
+static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
+{
+	struct wmfw_adsp2_id_hdr adsp2_id;
+	struct wmfw_adsp2_alg_hdr *adsp2_alg;
+	struct wm_adsp_alg_region *region;
+	const struct wm_adsp_region *mem;
+	unsigned int pos, len;
+	size_t algs;
+	int i, ret;
+
+	mem = wm_adsp_find_region(dsp, WMFW_ADSP2_XM);
+	if (WARN_ON(!mem))
 		return -EINVAL;
-	}
 
-	/* Read the terminator first to validate the length */
-	ret = regmap_raw_read(regmap, mem->base + term, &val, sizeof(val));
+	ret = regmap_raw_read(dsp->regmap, mem->base, &adsp2_id,
+			      sizeof(adsp2_id));
 	if (ret != 0) {
-		adsp_err(dsp, "Failed to read algorithm list end: %d\n",
-			ret);
+		adsp_err(dsp, "Failed to read algorithm info: %d\n",
+			 ret);
 		return ret;
 	}
 
-	if (be32_to_cpu(val) != 0xbedead)
-		adsp_warn(dsp, "Algorithm list end %x 0x%x != 0xbeadead\n",
-			  term, be32_to_cpu(val));
+	algs = be32_to_cpu(adsp2_id.algs);
+	dsp->fw_id = be32_to_cpu(adsp2_id.fw.id);
+	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
+		  dsp->fw_id,
+		  (be32_to_cpu(adsp2_id.fw.ver) & 0xff0000) >> 16,
+		  (be32_to_cpu(adsp2_id.fw.ver) & 0xff00) >> 8,
+		  be32_to_cpu(adsp2_id.fw.ver) & 0xff,
+		  algs);
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+	region->type = WMFW_ADSP2_XM;
+	region->alg = be32_to_cpu(adsp2_id.fw.id);
+	region->base = be32_to_cpu(adsp2_id.xm);
+	list_add_tail(&region->list, &dsp->alg_regions);
 
-	alg = kzalloc((term - pos) * 2, GFP_KERNEL | GFP_DMA);
-	if (!alg)
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
 		return -ENOMEM;
+	region->type = WMFW_ADSP2_YM;
+	region->alg = be32_to_cpu(adsp2_id.fw.id);
+	region->base = be32_to_cpu(adsp2_id.ym);
+	list_add_tail(&region->list, &dsp->alg_regions);
 
-	ret = regmap_raw_read(regmap, mem->base + pos, alg, (term - pos) * 2);
-	if (ret != 0) {
-		adsp_err(dsp, "Failed to read algorithm list: %d\n",
-			ret);
-		goto out;
-	}
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+	region->type = WMFW_ADSP2_ZM;
+	region->alg = be32_to_cpu(adsp2_id.fw.id);
+	region->base = be32_to_cpu(adsp2_id.zm);
+	list_add_tail(&region->list, &dsp->alg_regions);
 
-	adsp1_alg = alg;
-	adsp2_alg = alg;
+	pos = sizeof(adsp2_id) / 2;
+	len = (sizeof(*adsp2_alg) * algs) / 2;
 
-	for (i = 0; i < algs; i++) {
-		switch (dsp->type) {
-		case WMFW_ADSP1:
-			adsp_info(dsp, "%d: ID %x v%d.%d.%d DM@%x ZM@%x\n",
-				  i, be32_to_cpu(adsp1_alg[i].alg.id),
-				  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff0000) >> 16,
-				  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff00) >> 8,
-				  be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff,
-				  be32_to_cpu(adsp1_alg[i].dm),
-				  be32_to_cpu(adsp1_alg[i].zm));
-
-			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			region->type = WMFW_ADSP1_DM;
-			region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
-			region->base = be32_to_cpu(adsp1_alg[i].dm);
-			region->len = 0;
-			list_add_tail(&region->list, &dsp->alg_regions);
-			if (i + 1 < algs) {
-				region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
-				region->len -= be32_to_cpu(adsp1_alg[i].dm);
-				region->len *= 4;
-				wm_adsp_create_control(dsp, region);
-			} else {
-				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
-					  be32_to_cpu(adsp1_alg[i].alg.id));
-			}
+	adsp2_alg = wm_adsp_read_algs(dsp, algs, mem->base + pos, len);
+	if (IS_ERR(adsp2_alg))
+		return PTR_ERR(adsp2_alg);
 
-			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			region->type = WMFW_ADSP1_ZM;
-			region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
-			region->base = be32_to_cpu(adsp1_alg[i].zm);
-			region->len = 0;
-			list_add_tail(&region->list, &dsp->alg_regions);
-			if (i + 1 < algs) {
-				region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
-				region->len -= be32_to_cpu(adsp1_alg[i].zm);
-				region->len *= 4;
-				wm_adsp_create_control(dsp, region);
-			} else {
-				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
-					  be32_to_cpu(adsp1_alg[i].alg.id));
-			}
-			break;
+	for (i = 0; i < algs; i++) {
+		adsp_info(dsp,
+			  "%d: ID %x v%d.%d.%d XM@%x YM@%x ZM@%x\n",
+			  i, be32_to_cpu(adsp2_alg[i].alg.id),
+			  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff0000) >> 16,
+			  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff00) >> 8,
+			  be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff,
+			  be32_to_cpu(adsp2_alg[i].xm),
+			  be32_to_cpu(adsp2_alg[i].ym),
+			  be32_to_cpu(adsp2_alg[i].zm));
 
-		case WMFW_ADSP2:
-			adsp_info(dsp,
-				  "%d: ID %x v%d.%d.%d XM@%x YM@%x ZM@%x\n",
-				  i, be32_to_cpu(adsp2_alg[i].alg.id),
-				  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff0000) >> 16,
-				  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff00) >> 8,
-				  be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff,
-				  be32_to_cpu(adsp2_alg[i].xm),
-				  be32_to_cpu(adsp2_alg[i].ym),
-				  be32_to_cpu(adsp2_alg[i].zm));
-
-			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			region->type = WMFW_ADSP2_XM;
-			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-			region->base = be32_to_cpu(adsp2_alg[i].xm);
-			region->len = 0;
-			list_add_tail(&region->list, &dsp->alg_regions);
-			if (i + 1 < algs) {
-				region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
-				region->len -= be32_to_cpu(adsp2_alg[i].xm);
-				region->len *= 4;
-				wm_adsp_create_control(dsp, region);
-			} else {
-				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
-					  be32_to_cpu(adsp2_alg[i].alg.id));
-			}
+		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		if (!region) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		region->type = WMFW_ADSP2_XM;
+		region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+		region->base = be32_to_cpu(adsp2_alg[i].xm);
+		region->len = 0;
+		list_add_tail(&region->list, &dsp->alg_regions);
+		if (i + 1 < algs) {
+			region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
+			region->len -= be32_to_cpu(adsp2_alg[i].xm);
+			region->len *= 4;
+			wm_adsp_create_control(dsp, region);
+		} else {
+			adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
+				  be32_to_cpu(adsp2_alg[i].alg.id));
+		}
 
-			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			region->type = WMFW_ADSP2_YM;
-			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-			region->base = be32_to_cpu(adsp2_alg[i].ym);
-			region->len = 0;
-			list_add_tail(&region->list, &dsp->alg_regions);
-			if (i + 1 < algs) {
-				region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
-				region->len -= be32_to_cpu(adsp2_alg[i].ym);
-				region->len *= 4;
-				wm_adsp_create_control(dsp, region);
-			} else {
-				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
-					  be32_to_cpu(adsp2_alg[i].alg.id));
-			}
+		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		if (!region) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		region->type = WMFW_ADSP2_YM;
+		region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+		region->base = be32_to_cpu(adsp2_alg[i].ym);
+		region->len = 0;
+		list_add_tail(&region->list, &dsp->alg_regions);
+		if (i + 1 < algs) {
+			region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
+			region->len -= be32_to_cpu(adsp2_alg[i].ym);
+			region->len *= 4;
+			wm_adsp_create_control(dsp, region);
+		} else {
+			adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
+				  be32_to_cpu(adsp2_alg[i].alg.id));
+		}
 
-			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			region->type = WMFW_ADSP2_ZM;
-			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-			region->base = be32_to_cpu(adsp2_alg[i].zm);
-			region->len = 0;
-			list_add_tail(&region->list, &dsp->alg_regions);
-			if (i + 1 < algs) {
-				region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
-				region->len -= be32_to_cpu(adsp2_alg[i].zm);
-				region->len *= 4;
-				wm_adsp_create_control(dsp, region);
-			} else {
-				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
-					  be32_to_cpu(adsp2_alg[i].alg.id));
-			}
-			break;
+		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		if (!region) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		region->type = WMFW_ADSP2_ZM;
+		region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+		region->base = be32_to_cpu(adsp2_alg[i].zm);
+		region->len = 0;
+		list_add_tail(&region->list, &dsp->alg_regions);
+		if (i + 1 < algs) {
+			region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
+			region->len -= be32_to_cpu(adsp2_alg[i].zm);
+			region->len *= 4;
+			wm_adsp_create_control(dsp, region);
+		} else {
+			adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
+				  be32_to_cpu(adsp2_alg[i].alg.id));
 		}
 	}
 
 out:
-	kfree(alg);
+	kfree(adsp2_alg);
 	return ret;
 }
 
@@ -1410,7 +1407,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
-		ret = wm_adsp_setup_algs(dsp);
+		ret = wm_adsp1_setup_algs(dsp);
 		if (ret != 0)
 			goto err;
 
@@ -1568,7 +1565,7 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	if (ret != 0)
 		goto err;
 
-	ret = wm_adsp_setup_algs(dsp);
+	ret = wm_adsp2_setup_algs(dsp);
 	if (ret != 0)
 		goto err;
 
-- 
1.7.2.5
