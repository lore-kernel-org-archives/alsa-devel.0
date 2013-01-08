From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Implement support for
	algorithm-specific coefficient blocks
Date: Tue,  8 Jan 2013 16:59:23 +0000
Message-ID: <1357664363-16094-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1357664363-16094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5813261619
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 17:59:25 +0100 (CET)
In-Reply-To: <1357664363-16094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

WMDR coefficient files can specify coefficients in terms of algorithm
specific data regions. Record the start addresses of these regions while
parsing the algorithms and then use them to handle coefficients with
these formats.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  114 ++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wm_adsp.h |    9 ++++
 2 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ed9a6c4..4acb9c5 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -389,6 +389,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 	struct wmfw_adsp1_alg_hdr *adsp1_alg;
 	struct wmfw_adsp2_alg_hdr *adsp2_alg;
 	void *alg, *buf;
+	struct wm_adsp_alg_region *region;
 	const struct wm_adsp_region *mem;
 	unsigned int pos, term;
 	size_t algs, buf_size;
@@ -507,19 +508,80 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 	for (i = 0; i < algs; i++) {
 		switch (dsp->type) {
 		case WMFW_ADSP1:
-			adsp_info(dsp, "%d: ID %x v%d.%d.%d\n",
+			adsp_info(dsp, "%d: ID %x v%d.%d.%d DM@%x ZM@%x\n",
 				  i, be32_to_cpu(adsp1_alg[i].alg.id),
 				  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff0000) >> 16,
 				  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff00) >> 8,
-				  be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff);
+				  be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff,
+				  be32_to_cpu(adsp1_alg[i].dm),
+				  be32_to_cpu(adsp1_alg[i].zm));
+
+			if (adsp1_alg[i].dm) {
+				region = kzalloc(sizeof(*region), GFP_KERNEL);
+				if (!region)
+					return -ENOMEM;
+				region->type = WMFW_ADSP1_DM;
+				region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
+				region->base = be32_to_cpu(adsp1_alg[i].dm);
+				list_add_tail(&region->list,
+					      &dsp->alg_regions);
+			}
+
+			if (adsp1_alg[i].zm) {
+				region = kzalloc(sizeof(*region), GFP_KERNEL);
+				if (!region)
+					return -ENOMEM;
+				region->type = WMFW_ADSP1_ZM;
+				region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
+				region->base = be32_to_cpu(adsp1_alg[i].zm);
+				list_add_tail(&region->list,
+					      &dsp->alg_regions);
+			}
 			break;
 
 		case WMFW_ADSP2:
-			adsp_info(dsp, "%d: ID %x v%d.%d.%d\n",
+			adsp_info(dsp,
+				  "%d: ID %x v%d.%d.%d XM@%x YM@%x ZM@%x\n",
 				  i, be32_to_cpu(adsp2_alg[i].alg.id),
 				  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff0000) >> 16,
 				  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff00) >> 8,
-				  be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff);
+				  be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff,
+				  be32_to_cpu(adsp2_alg[i].xm),
+				  be32_to_cpu(adsp2_alg[i].ym),
+				  be32_to_cpu(adsp2_alg[i].zm));
+
+			if (adsp2_alg[i].xm) {
+				region = kzalloc(sizeof(*region), GFP_KERNEL);
+				if (!region)
+					return -ENOMEM;
+				region->type = WMFW_ADSP2_XM;
+				region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+				region->base = be32_to_cpu(adsp2_alg[i].xm);
+				list_add_tail(&region->list,
+					      &dsp->alg_regions);
+			}
+
+			if (adsp2_alg[i].ym) {
+				region = kzalloc(sizeof(*region), GFP_KERNEL);
+				if (!region)
+					return -ENOMEM;
+				region->type = WMFW_ADSP2_YM;
+				region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+				region->base = be32_to_cpu(adsp2_alg[i].ym);
+				list_add_tail(&region->list,
+					      &dsp->alg_regions);
+			}
+
+			if (adsp2_alg[i].zm) {
+				region = kzalloc(sizeof(*region), GFP_KERNEL);
+				if (!region)
+					return -ENOMEM;
+				region->type = WMFW_ADSP2_ZM;
+				region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+				region->base = be32_to_cpu(adsp2_alg[i].zm);
+				list_add_tail(&region->list,
+					      &dsp->alg_regions);
+			}
 			break;
 		}
 	}
@@ -535,6 +597,8 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 	struct wmfw_coeff_hdr *hdr;
 	struct wmfw_coeff_item *blk;
 	const struct firmware *firmware;
+	struct wm_adsp_region *mem;
+	struct wm_adsp_alg_region *alg_region;
 	const char *region_name;
 	int ret, pos, blocks, type, offset, reg;
 	char *file;
@@ -600,6 +664,37 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 			region_name = "register";
 			reg = offset;
 			break;
+
+		case WMFW_ADSP1_DM:
+		case WMFW_ADSP1_ZM:
+		case WMFW_ADSP2_XM:
+		case WMFW_ADSP2_YM:
+			adsp_dbg(dsp, "%s.%d: %d bytes in %x for %x\n",
+				 file, blocks, le32_to_cpu(blk->len),
+				 type, le32_to_cpu(blk->id));
+
+			mem = wm_adsp_find_region(dsp, type);
+			if (!mem) {
+				adsp_err(dsp, "No base for region %x\n", type);
+				break;
+			}
+
+			reg = 0;
+			list_for_each_entry(alg_region,
+					    &dsp->alg_regions, list) {
+				if (le32_to_cpu(blk->id) == alg_region->alg &&
+				    type == alg_region->type) {
+					reg = alg_region->base + offset;
+					reg = wm_adsp_region_to_reg(mem,
+								    reg);
+				}
+			}
+
+			if (reg == 0)
+				adsp_err(dsp, "No %x for algorithm %x\n",
+					 type, le32_to_cpu(blk->id));
+			break;
+
 		default:
 			adsp_err(dsp, "Unknown region type %x\n", type);
 			break;
@@ -732,6 +827,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = w->codec;
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
+	struct wm_adsp_alg_region *alg_region;
 	unsigned int val;
 	int ret;
 
@@ -832,6 +928,14 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 					"Failed to enable supply: %d\n",
 					ret);
 		}
+
+		while (!list_empty(&dsp->alg_regions)) {
+			alg_region = list_first_entry(&dsp->alg_regions,
+						      struct wm_adsp_alg_region,
+						      list);
+			list_del(&alg_region->list);
+			kfree(alg_region);
+		}
 		break;
 
 	default:
@@ -861,6 +965,8 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
 		return ret;
 	}
 
+	INIT_LIST_HEAD(&adsp->alg_regions);
+
 	if (dvfs) {
 		adsp->dvfs = devm_regulator_get(adsp->dev, "DCVDD");
 		if (IS_ERR(adsp->dvfs)) {
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index ffd29a4..4881419 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -25,6 +25,13 @@ struct wm_adsp_region {
 	unsigned int base;
 };
 
+struct wm_adsp_alg_region {
+	struct list_head list;
+	unsigned int alg;
+	int type;
+	unsigned int base;
+};
+
 struct wm_adsp {
 	const char *part;
 	int num;
@@ -34,6 +41,8 @@ struct wm_adsp {
 
 	int base;
 
+	struct list_head alg_regions;
+
 	const struct wm_adsp_region *mem;
 	int num_mems;
 
-- 
1.7.10.4
