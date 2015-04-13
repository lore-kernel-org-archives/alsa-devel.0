From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 09/13] ASoC: wm_adsp: Group all the ALSA
	control functions together
Date: Mon, 13 Apr 2015 13:28:01 +0100
Message-ID: <1428928085-20250-10-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B01426501D
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:11 +0200 (CEST)
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

This is slightly logically better and avoids some unnecessary forward
declarations in the following refactoring.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  280 ++++++++++++++++++++++----------------------
 1 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d6e8913..f42b453 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -518,6 +518,146 @@ err_kcontrol:
 	return ret;
 }
 
+static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
+{
+	struct wm_coeff_ctl *ctl;
+	int ret;
+
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		if (!ctl->enabled || ctl->set)
+			continue;
+		ret = wm_coeff_read_control(ctl,
+					    ctl->cache,
+					    ctl->len);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int wm_coeff_sync_controls(struct wm_adsp *dsp)
+{
+	struct wm_coeff_ctl *ctl;
+	int ret;
+
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		if (!ctl->enabled)
+			continue;
+		if (ctl->set) {
+			ret = wm_coeff_write_control(ctl,
+						     ctl->cache,
+						     ctl->len);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void wm_adsp_ctl_work(struct work_struct *work)
+{
+	struct wmfw_ctl_work *ctl_work = container_of(work,
+						      struct wmfw_ctl_work,
+						      work);
+
+	wmfw_add_ctl(ctl_work->dsp, ctl_work->ctl);
+	kfree(ctl_work);
+}
+
+static int wm_adsp_create_control(struct wm_adsp *dsp,
+				  const struct wm_adsp_alg_region *alg_region,
+				  unsigned int len)
+{
+	struct wm_coeff_ctl *ctl;
+	struct wmfw_ctl_work *ctl_work;
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	char *region_name;
+	int ret;
+
+	switch (alg_region->type) {
+	case WMFW_ADSP1_PM:
+		region_name = "PM";
+		break;
+	case WMFW_ADSP1_DM:
+		region_name = "DM";
+		break;
+	case WMFW_ADSP2_XM:
+		region_name = "XM";
+		break;
+	case WMFW_ADSP2_YM:
+		region_name = "YM";
+		break;
+	case WMFW_ADSP1_ZM:
+		region_name = "ZM";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "DSP%d %s %x",
+		 dsp->num, region_name, alg_region->alg);
+
+	list_for_each_entry(ctl, &dsp->ctl_list,
+			    list) {
+		if (!strcmp(ctl->name, name)) {
+			if (!ctl->enabled)
+				ctl->enabled = 1;
+			return 0;
+		}
+	}
+
+	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return -ENOMEM;
+	ctl->alg_region = *alg_region;
+	ctl->name = kmemdup(name, strlen(name) + 1, GFP_KERNEL);
+	if (!ctl->name) {
+		ret = -ENOMEM;
+		goto err_ctl;
+	}
+	ctl->enabled = 1;
+	ctl->set = 0;
+	ctl->ops.xget = wm_coeff_get;
+	ctl->ops.xput = wm_coeff_put;
+	ctl->dsp = dsp;
+
+	if (len > 512) {
+		adsp_warn(dsp, "Truncating control %s from %d\n",
+			  ctl->name, len);
+		len = 512;
+	}
+	ctl->len = len;
+	ctl->cache = kzalloc(ctl->len, GFP_KERNEL);
+	if (!ctl->cache) {
+		ret = -ENOMEM;
+		goto err_ctl_name;
+	}
+
+	ctl_work = kzalloc(sizeof(*ctl_work), GFP_KERNEL);
+	if (!ctl_work) {
+		ret = -ENOMEM;
+		goto err_ctl_cache;
+	}
+
+	ctl_work->dsp = dsp;
+	ctl_work->ctl = ctl;
+	INIT_WORK(&ctl_work->work, wm_adsp_ctl_work);
+	schedule_work(&ctl_work->work);
+
+	return 0;
+
+err_ctl_cache:
+	kfree(ctl->cache);
+err_ctl_name:
+	kfree(ctl->name);
+err_ctl:
+	kfree(ctl);
+
+	return ret;
+}
+
 static int wm_adsp_load(struct wm_adsp *dsp)
 {
 	LIST_HEAD(buf_list);
@@ -728,146 +868,6 @@ out:
 	return ret;
 }
 
-static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
-{
-	struct wm_coeff_ctl *ctl;
-	int ret;
-
-	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (!ctl->enabled || ctl->set)
-			continue;
-		ret = wm_coeff_read_control(ctl,
-					    ctl->cache,
-					    ctl->len);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int wm_coeff_sync_controls(struct wm_adsp *dsp)
-{
-	struct wm_coeff_ctl *ctl;
-	int ret;
-
-	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (!ctl->enabled)
-			continue;
-		if (ctl->set) {
-			ret = wm_coeff_write_control(ctl,
-						     ctl->cache,
-						     ctl->len);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
-static void wm_adsp_ctl_work(struct work_struct *work)
-{
-	struct wmfw_ctl_work *ctl_work = container_of(work,
-						      struct wmfw_ctl_work,
-						      work);
-
-	wmfw_add_ctl(ctl_work->dsp, ctl_work->ctl);
-	kfree(ctl_work);
-}
-
-static int wm_adsp_create_control(struct wm_adsp *dsp,
-				  const struct wm_adsp_alg_region *alg_region,
-				  unsigned int len)
-{
-	struct wm_coeff_ctl *ctl;
-	struct wmfw_ctl_work *ctl_work;
-	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	char *region_name;
-	int ret;
-
-	switch (alg_region->type) {
-	case WMFW_ADSP1_PM:
-		region_name = "PM";
-		break;
-	case WMFW_ADSP1_DM:
-		region_name = "DM";
-		break;
-	case WMFW_ADSP2_XM:
-		region_name = "XM";
-		break;
-	case WMFW_ADSP2_YM:
-		region_name = "YM";
-		break;
-	case WMFW_ADSP1_ZM:
-		region_name = "ZM";
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "DSP%d %s %x",
-		 dsp->num, region_name, alg_region->alg);
-
-	list_for_each_entry(ctl, &dsp->ctl_list,
-			    list) {
-		if (!strcmp(ctl->name, name)) {
-			if (!ctl->enabled)
-				ctl->enabled = 1;
-			return 0;
-		}
-	}
-
-	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
-	if (!ctl)
-		return -ENOMEM;
-	ctl->alg_region = *alg_region;
-	ctl->name = kmemdup(name, strlen(name) + 1, GFP_KERNEL);
-	if (!ctl->name) {
-		ret = -ENOMEM;
-		goto err_ctl;
-	}
-	ctl->enabled = 1;
-	ctl->set = 0;
-	ctl->ops.xget = wm_coeff_get;
-	ctl->ops.xput = wm_coeff_put;
-	ctl->dsp = dsp;
-
-	if (len > 512) {
-		adsp_warn(dsp, "Truncating control %s from %d\n",
-			  ctl->name, len);
-		len = 512;
-	}
-	ctl->len = len;
-	ctl->cache = kzalloc(ctl->len, GFP_KERNEL);
-	if (!ctl->cache) {
-		ret = -ENOMEM;
-		goto err_ctl_name;
-	}
-
-	ctl_work = kzalloc(sizeof(*ctl_work), GFP_KERNEL);
-	if (!ctl_work) {
-		ret = -ENOMEM;
-		goto err_ctl_cache;
-	}
-
-	ctl_work->dsp = dsp;
-	ctl_work->ctl = ctl;
-	INIT_WORK(&ctl_work->work, wm_adsp_ctl_work);
-	schedule_work(&ctl_work->work);
-
-	return 0;
-
-err_ctl_cache:
-	kfree(ctl->cache);
-err_ctl_name:
-	kfree(ctl->name);
-err_ctl:
-	kfree(ctl);
-
-	return ret;
-}
-
 static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 			       unsigned int pos, unsigned int len)
 {
-- 
1.7.2.5
