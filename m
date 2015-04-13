From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 03/13] ASoC: wm_adsp: Remove len field from
	wm_adsp_alg_region
Date: Mon, 13 Apr 2015 13:27:55 +0100
Message-ID: <1428928085-20250-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D94B2650BC
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:05 +0200 (CEST)
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

The algorithm region information in the firmware doesn't contain a
length field, explicitly pass this to the create_control function rather
than bundling into wm_adsp_alg_region.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   55 ++++++++++++++++++++++---------------------
 sound/soc/codecs/wm_adsp.h |    1 -
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4201e1f..3f6b49d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -780,7 +780,8 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 }
 
 static int wm_adsp_create_control(struct wm_adsp *dsp,
-				  const struct wm_adsp_alg_region *alg_region)
+				  const struct wm_adsp_alg_region *alg_region,
+				  unsigned int len)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -842,7 +843,12 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	ctl->ops.xput = wm_coeff_put;
 	ctl->dsp = dsp;
 
-	ctl->len = alg_region->len;
+	if (len > 512) {
+		adsp_warn(dsp, "Truncating control %s from %d\n",
+			  ctl->name, len);
+		len = 512;
+	}
+	ctl->len = len;
 	ctl->cache = kzalloc(ctl->len, GFP_KERNEL);
 	if (!ctl->cache) {
 		ret = -ENOMEM;
@@ -991,13 +997,12 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 		alg_region->type = WMFW_ADSP1_DM;
 		alg_region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
 		alg_region->base = be32_to_cpu(adsp1_alg[i].dm);
-		alg_region->len = 0;
 		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
-			alg_region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
-			alg_region->len -= be32_to_cpu(adsp1_alg[i].dm);
-			alg_region->len *= 4;
-			wm_adsp_create_control(dsp, alg_region);
+			len = be32_to_cpu(adsp1_alg[i + 1].dm);
+			len -= be32_to_cpu(adsp1_alg[i].dm);
+			len *= 4;
+			wm_adsp_create_control(dsp, alg_region, len);
 		} else {
 			adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 				  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1011,13 +1016,12 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 		alg_region->type = WMFW_ADSP1_ZM;
 		alg_region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
 		alg_region->base = be32_to_cpu(adsp1_alg[i].zm);
-		alg_region->len = 0;
 		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
-			alg_region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
-			alg_region->len -= be32_to_cpu(adsp1_alg[i].zm);
-			alg_region->len *= 4;
-			wm_adsp_create_control(dsp, alg_region);
+			len = be32_to_cpu(adsp1_alg[i + 1].zm);
+			len -= be32_to_cpu(adsp1_alg[i].zm);
+			len *= 4;
+			wm_adsp_create_control(dsp, alg_region, len);
 		} else {
 			adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 				  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1110,13 +1114,12 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 		alg_region->type = WMFW_ADSP2_XM;
 		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 		alg_region->base = be32_to_cpu(adsp2_alg[i].xm);
-		alg_region->len = 0;
 		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
-			alg_region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
-			alg_region->len -= be32_to_cpu(adsp2_alg[i].xm);
-			alg_region->len *= 4;
-			wm_adsp_create_control(dsp, alg_region);
+			len = be32_to_cpu(adsp2_alg[i + 1].xm);
+			len -= be32_to_cpu(adsp2_alg[i].xm);
+			len *= 4;
+			wm_adsp_create_control(dsp, alg_region, len);
 		} else {
 			adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 				  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1130,13 +1133,12 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 		alg_region->type = WMFW_ADSP2_YM;
 		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 		alg_region->base = be32_to_cpu(adsp2_alg[i].ym);
-		alg_region->len = 0;
 		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
-			alg_region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
-			alg_region->len -= be32_to_cpu(adsp2_alg[i].ym);
-			alg_region->len *= 4;
-			wm_adsp_create_control(dsp, alg_region);
+			len = be32_to_cpu(adsp2_alg[i + 1].ym);
+			len -= be32_to_cpu(adsp2_alg[i].ym);
+			len *= 4;
+			wm_adsp_create_control(dsp, alg_region, len);
 		} else {
 			adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 				  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1150,13 +1152,12 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 		alg_region->type = WMFW_ADSP2_ZM;
 		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 		alg_region->base = be32_to_cpu(adsp2_alg[i].zm);
-		alg_region->len = 0;
 		list_add_tail(&alg_region->list, &dsp->alg_regions);
 		if (i + 1 < n_algs) {
-			alg_region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
-			alg_region->len -= be32_to_cpu(adsp2_alg[i].zm);
-			alg_region->len *= 4;
-			wm_adsp_create_control(dsp, alg_region);
+			len = be32_to_cpu(adsp2_alg[i + 1].zm);
+			len -= be32_to_cpu(adsp2_alg[i].zm);
+			len *= 4;
+			wm_adsp_create_control(dsp, alg_region, len);
 		} else {
 			adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 				  be32_to_cpu(adsp2_alg[i].alg.id));
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index fc75a24..0ad14e0 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -30,7 +30,6 @@ struct wm_adsp_alg_region {
 	unsigned int alg;
 	int type;
 	unsigned int base;
-	size_t len;
 };
 
 struct wm_adsp {
-- 
1.7.2.5
