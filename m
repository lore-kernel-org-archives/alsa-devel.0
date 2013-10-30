From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm_adsp: Add support for grouped
	ALSA binary controls
Date: Wed, 30 Oct 2013 16:54:29 +0000
Message-ID: <1383152069-8646-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1383152069-8646-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5ABA265468
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 17:54:31 +0100 (CET)
In-Reply-To: <1383152069-8646-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Currently the ALSA ABI imposes a hard limit of 512 bytes per binary
control.  To support coefficient data blocks of larger sizes we carve up
this space into multiple alsa controls.  All of these controls are
identified by a common prefix and suffix of the form ":<blk id>".

Control groupings can also consist of a single block in which case the
suffix ":0" is used.

Change-Id: Ib8560bbd98425b1732b2ccf372a53102bdeb7d7f
Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 59 +++++++++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index cd007cc..b3fbe4a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -714,7 +714,6 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 
 static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *region)
-
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -746,8 +745,8 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		return -EINVAL;
 	}
 
-	snprintf(name, PAGE_SIZE, "DSP%d %s %x",
-		 dsp->num, region_name, region->alg);
+	snprintf(name, PAGE_SIZE, "DSP%d %s %x:%d",
+		 dsp->num, region_name, region->alg, region->block);
 
 	list_for_each_entry(ctl, &dsp->ctl_list,
 			    list) {
@@ -808,6 +807,50 @@ err_name:
 	return ret;
 }
 
+static int wm_adsp_create_grouped_control(struct wm_adsp *dsp,
+					  struct wm_adsp_alg_region *region)
+{
+	size_t len = region->len, offset = 0;
+	struct wm_adsp_alg_region *r;
+	int ret;
+
+	region->block = 0;
+	/* This is the quick case for control groups of a single block */
+	if (region->len <= 512)
+		return wm_adsp_create_control(dsp, region);
+
+	/* The passed `region' is already in the list
+	 * of algorithm regions so just create the control for it and don't
+	 * add it to the list */
+	region->len = 512;
+	ret = wm_adsp_create_control(dsp, region);
+	if (ret < 0)
+		return ret;
+	offset += 512;
+
+	/* Carve up the entire region into 512-byte chunks */
+	do {
+		r = kzalloc(sizeof(*r), GFP_KERNEL);
+		if (!r)
+			return -ENOMEM;
+		r->block = offset / 512;
+		r->type = region->type;
+		r->alg = region->alg;
+		r->base = region->base + offset;
+		if (len - offset > 512)
+			r->len = 512;
+		else
+			r->len = len - offset;
+		offset += r->len;
+		list_add_tail(&r->list, &dsp->alg_regions);
+		ret = wm_adsp_create_control(dsp, r);
+		if (ret < 0)
+			return ret;
+	} while (offset < len);
+
+	return 0;
+}
+
 static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 {
 	struct regmap *regmap = dsp->regmap;
@@ -983,7 +1026,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
 				region->len -= be32_to_cpu(adsp1_alg[i].dm);
-				wm_adsp_create_control(dsp, region);
+				wm_adsp_create_grouped_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1000,7 +1043,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
 				region->len -= be32_to_cpu(adsp1_alg[i].zm);
-				wm_adsp_create_control(dsp, region);
+				wm_adsp_create_grouped_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1029,7 +1072,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
 				region->len -= be32_to_cpu(adsp2_alg[i].xm);
-				wm_adsp_create_control(dsp, region);
+				wm_adsp_create_grouped_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1046,7 +1089,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
 				region->len -= be32_to_cpu(adsp2_alg[i].ym);
-				wm_adsp_create_control(dsp, region);
+				wm_adsp_create_grouped_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1063,7 +1106,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
 				region->len -= be32_to_cpu(adsp2_alg[i].zm);
-				wm_adsp_create_control(dsp, region);
+				wm_adsp_create_grouped_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 7603167..60a7482 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -27,6 +27,7 @@ struct wm_adsp_region {
 
 struct wm_adsp_alg_region {
 	struct list_head list;
+	unsigned int block;
 	unsigned int alg;
 	int type;
 	unsigned int base;
-- 
1.8.4.2
