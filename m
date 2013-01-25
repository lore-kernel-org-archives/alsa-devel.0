From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Accept 0 as a parameter block
	address
Date: Sat, 26 Jan 2013 00:30:53 +0800
Message-ID: <1359131453-5163-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D3A4265139
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 19:02:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   85 ++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bc5e383..3ba4237 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -589,27 +589,21 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 				  be32_to_cpu(adsp1_alg[i].dm),
 				  be32_to_cpu(adsp1_alg[i].zm));
 
-			if (adsp1_alg[i].dm) {
-				region = kzalloc(sizeof(*region), GFP_KERNEL);
-				if (!region)
-					return -ENOMEM;
-				region->type = WMFW_ADSP1_DM;
-				region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
-				region->base = be32_to_cpu(adsp1_alg[i].dm);
-				list_add_tail(&region->list,
-					      &dsp->alg_regions);
-			}
+			region = kzalloc(sizeof(*region), GFP_KERNEL);
+			if (!region)
+				return -ENOMEM;
+			region->type = WMFW_ADSP1_DM;
+			region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
+			region->base = be32_to_cpu(adsp1_alg[i].dm);
+			list_add_tail(&region->list, &dsp->alg_regions);
 
-			if (adsp1_alg[i].zm) {
-				region = kzalloc(sizeof(*region), GFP_KERNEL);
-				if (!region)
-					return -ENOMEM;
-				region->type = WMFW_ADSP1_ZM;
-				region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
-				region->base = be32_to_cpu(adsp1_alg[i].zm);
-				list_add_tail(&region->list,
-					      &dsp->alg_regions);
-			}
+			region = kzalloc(sizeof(*region), GFP_KERNEL);
+			if (!region)
+				return -ENOMEM;
+			region->type = WMFW_ADSP1_ZM;
+			region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
+			region->base = be32_to_cpu(adsp1_alg[i].zm);
+			list_add_tail(&region->list, &dsp->alg_regions);
 			break;
 
 		case WMFW_ADSP2:
@@ -623,38 +617,29 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 				  be32_to_cpu(adsp2_alg[i].ym),
 				  be32_to_cpu(adsp2_alg[i].zm));
 
-			if (adsp2_alg[i].xm) {
-				region = kzalloc(sizeof(*region), GFP_KERNEL);
-				if (!region)
-					return -ENOMEM;
-				region->type = WMFW_ADSP2_XM;
-				region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-				region->base = be32_to_cpu(adsp2_alg[i].xm);
-				list_add_tail(&region->list,
-					      &dsp->alg_regions);
-			}
+			region = kzalloc(sizeof(*region), GFP_KERNEL);
+			if (!region)
+				return -ENOMEM;
+			region->type = WMFW_ADSP2_XM;
+			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+			region->base = be32_to_cpu(adsp2_alg[i].xm);
+			list_add_tail(&region->list, &dsp->alg_regions);
 
-			if (adsp2_alg[i].ym) {
-				region = kzalloc(sizeof(*region), GFP_KERNEL);
-				if (!region)
-					return -ENOMEM;
-				region->type = WMFW_ADSP2_YM;
-				region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-				region->base = be32_to_cpu(adsp2_alg[i].ym);
-				list_add_tail(&region->list,
-					      &dsp->alg_regions);
-			}
+			region = kzalloc(sizeof(*region), GFP_KERNEL);
+			if (!region)
+				return -ENOMEM;
+			region->type = WMFW_ADSP2_YM;
+			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+			region->base = be32_to_cpu(adsp2_alg[i].ym);
+			list_add_tail(&region->list, &dsp->alg_regions);
 
-			if (adsp2_alg[i].zm) {
-				region = kzalloc(sizeof(*region), GFP_KERNEL);
-				if (!region)
-					return -ENOMEM;
-				region->type = WMFW_ADSP2_ZM;
-				region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-				region->base = be32_to_cpu(adsp2_alg[i].zm);
-				list_add_tail(&region->list,
-					      &dsp->alg_regions);
-			}
+			region = kzalloc(sizeof(*region), GFP_KERNEL);
+			if (!region)
+				return -ENOMEM;
+			region->type = WMFW_ADSP2_ZM;
+			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+			region->base = be32_to_cpu(adsp2_alg[i].zm);
+			list_add_tail(&region->list, &dsp->alg_regions);
 			break;
 		}
 	}
-- 
1.7.10.4
