From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 07/13] ASoC: wm_adsp: Factor out creation of
	alg_regions
Date: Mon, 13 Apr 2015 13:27:59 +0100
Message-ID: <1428928085-20250-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0BA726512A
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:08 +0200 (CEST)
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

Tidy up the code a little by factoring out the creation of the algorithm
regions.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  134 +++++++++++++++++++++-----------------------
 1 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 37e01b0..9283d08 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -913,6 +913,25 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	return alg;
 }
 
+static struct wm_adsp_alg_region *wm_adsp_create_region(struct wm_adsp *dsp,
+							int type, __be32 id,
+							__be32 base)
+{
+	struct wm_adsp_alg_region *alg_region;
+
+	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+	if (!alg_region)
+		return ERR_PTR(-ENOMEM);
+
+	alg_region->type = type;
+	alg_region->alg = be32_to_cpu(id);
+	alg_region->base = be32_to_cpu(base);
+
+	list_add_tail(&alg_region->list, &dsp->alg_regions);
+
+	return alg_region;
+}
+
 static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 {
 	struct wmfw_adsp1_id_hdr adsp1_id;
@@ -944,21 +963,15 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 		  be32_to_cpu(adsp1_id.fw.ver) & 0xff,
 		  n_algs);
 
-	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-	if (!alg_region)
-		return -ENOMEM;
-	alg_region->type = WMFW_ADSP1_ZM;
-	alg_region->alg = be32_to_cpu(adsp1_id.fw.id);
-	alg_region->base = be32_to_cpu(adsp1_id.zm);
-	list_add_tail(&alg_region->list, &dsp->alg_regions);
+	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP1_ZM,
+					   adsp1_id.fw.id, adsp1_id.zm);
+	if (IS_ERR(alg_region))
+		return PTR_ERR(alg_region);
 
-	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-	if (!alg_region)
-		return -ENOMEM;
-	alg_region->type = WMFW_ADSP1_DM;
-	alg_region->alg = be32_to_cpu(adsp1_id.fw.id);
-	alg_region->base = be32_to_cpu(adsp1_id.dm);
-	list_add_tail(&alg_region->list, &dsp->alg_regions);
+	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP1_DM,
+					   adsp1_id.fw.id, adsp1_id.dm);
+	if (IS_ERR(alg_region))
+		return PTR_ERR(alg_region);
 
 	pos = sizeof(adsp1_id) / 2;
 	len = (sizeof(*adsp1_alg) * n_algs) / 2;
@@ -976,15 +989,13 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 			  be32_to_cpu(adsp1_alg[i].dm),
 			  be32_to_cpu(adsp1_alg[i].zm));
 
-		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-		if (!alg_region) {
-			ret = -ENOMEM;
+		alg_region = wm_adsp_create_region(dsp, WMFW_ADSP1_DM,
+						   adsp1_alg[i].alg.id,
+						   adsp1_alg[i].dm);
+		if (IS_ERR(alg_region)) {
+			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		alg_region->type = WMFW_ADSP1_DM;
-		alg_region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
-		alg_region->base = be32_to_cpu(adsp1_alg[i].dm);
-		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
 			len = be32_to_cpu(adsp1_alg[i + 1].dm);
 			len -= be32_to_cpu(adsp1_alg[i].dm);
@@ -995,15 +1006,13 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				  be32_to_cpu(adsp1_alg[i].alg.id));
 		}
 
-		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-		if (!alg_region) {
-			ret = -ENOMEM;
+		alg_region = wm_adsp_create_region(dsp, WMFW_ADSP1_ZM,
+						   adsp1_alg[i].alg.id,
+						   adsp1_alg[i].zm);
+		if (IS_ERR(alg_region)) {
+			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		alg_region->type = WMFW_ADSP1_ZM;
-		alg_region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
-		alg_region->base = be32_to_cpu(adsp1_alg[i].zm);
-		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
 			len = be32_to_cpu(adsp1_alg[i + 1].zm);
 			len -= be32_to_cpu(adsp1_alg[i].zm);
@@ -1051,29 +1060,20 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 		  be32_to_cpu(adsp2_id.fw.ver) & 0xff,
 		  n_algs);
 
-	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-	if (!alg_region)
-		return -ENOMEM;
-	alg_region->type = WMFW_ADSP2_XM;
-	alg_region->alg = be32_to_cpu(adsp2_id.fw.id);
-	alg_region->base = be32_to_cpu(adsp2_id.xm);
-	list_add_tail(&alg_region->list, &dsp->alg_regions);
+	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_XM,
+					   adsp2_id.fw.id, adsp2_id.xm);
+	if (IS_ERR(alg_region))
+		return PTR_ERR(alg_region);
 
-	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-	if (!alg_region)
-		return -ENOMEM;
-	alg_region->type = WMFW_ADSP2_YM;
-	alg_region->alg = be32_to_cpu(adsp2_id.fw.id);
-	alg_region->base = be32_to_cpu(adsp2_id.ym);
-	list_add_tail(&alg_region->list, &dsp->alg_regions);
+	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_YM,
+					   adsp2_id.fw.id, adsp2_id.ym);
+	if (IS_ERR(alg_region))
+		return PTR_ERR(alg_region);
 
-	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-	if (!alg_region)
-		return -ENOMEM;
-	alg_region->type = WMFW_ADSP2_ZM;
-	alg_region->alg = be32_to_cpu(adsp2_id.fw.id);
-	alg_region->base = be32_to_cpu(adsp2_id.zm);
-	list_add_tail(&alg_region->list, &dsp->alg_regions);
+	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_ZM,
+					   adsp2_id.fw.id, adsp2_id.zm);
+	if (IS_ERR(alg_region))
+		return PTR_ERR(alg_region);
 
 	pos = sizeof(adsp2_id) / 2;
 	len = (sizeof(*adsp2_alg) * n_algs) / 2;
@@ -1093,15 +1093,13 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 			  be32_to_cpu(adsp2_alg[i].ym),
 			  be32_to_cpu(adsp2_alg[i].zm));
 
-		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-		if (!alg_region) {
-			ret = -ENOMEM;
+		alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_XM,
+						   adsp2_alg[i].alg.id,
+						   adsp2_alg[i].xm);
+		if (IS_ERR(alg_region)) {
+			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		alg_region->type = WMFW_ADSP2_XM;
-		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-		alg_region->base = be32_to_cpu(adsp2_alg[i].xm);
-		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
 			len = be32_to_cpu(adsp2_alg[i + 1].xm);
 			len -= be32_to_cpu(adsp2_alg[i].xm);
@@ -1112,15 +1110,13 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				  be32_to_cpu(adsp2_alg[i].alg.id));
 		}
 
-		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-		if (!alg_region) {
-			ret = -ENOMEM;
+		alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_YM,
+						   adsp2_alg[i].alg.id,
+						   adsp2_alg[i].ym);
+		if (IS_ERR(alg_region)) {
+			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		alg_region->type = WMFW_ADSP2_YM;
-		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-		alg_region->base = be32_to_cpu(adsp2_alg[i].ym);
-		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
 			len = be32_to_cpu(adsp2_alg[i + 1].ym);
 			len -= be32_to_cpu(adsp2_alg[i].ym);
@@ -1131,15 +1127,13 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				  be32_to_cpu(adsp2_alg[i].alg.id));
 		}
 
-		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
-		if (!alg_region) {
-			ret = -ENOMEM;
+		alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_ZM,
+						   adsp2_alg[i].alg.id,
+						   adsp2_alg[i].zm);
+		if (IS_ERR(alg_region)) {
+			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		alg_region->type = WMFW_ADSP2_ZM;
-		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-		alg_region->base = be32_to_cpu(adsp2_alg[i].zm);
-		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
 			len = be32_to_cpu(adsp2_alg[i + 1].zm);
 			len -= be32_to_cpu(adsp2_alg[i].zm);
-- 
1.7.2.5
