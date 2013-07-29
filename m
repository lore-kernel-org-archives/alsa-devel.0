From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Simplify kcontrol handling
Date: Mon, 29 Jul 2013 13:51:59 +0100
Message-ID: <1375102319-10645-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1375102319-10645-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40CF1261AE2
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 14:52:02 +0200 (CEST)
In-Reply-To: <1375102319-10645-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Get rid off the wm_coeff struct and the wm_coeff_add_kcontrol()
function.  We are now using the snd_soc_card_kcontrol() function to
get the kcontrol pointers.  No need to call into ALSA code to
register the kcontrols.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 103 ++++++++++++++-------------------------------
 sound/soc/codecs/wm_adsp.h |   2 +-
 2 files changed, 32 insertions(+), 73 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 05252ac..3168224 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -225,15 +225,9 @@ struct wm_coeff_ctl_ops {
 		     struct snd_ctl_elem_info *uinfo);
 };
 
-struct wm_coeff {
-	struct device *dev;
-	struct list_head ctl_list;
-	struct regmap *regmap;
-};
-
 struct wm_coeff_ctl {
 	const char *name;
-	struct snd_card *card;
+	struct snd_soc_card *card;
 	struct wm_adsp_alg_region region;
 	struct wm_coeff_ctl_ops ops;
 	struct wm_adsp *adsp;
@@ -378,7 +372,6 @@ static int wm_coeff_info(struct snd_kcontrol *kcontrol,
 static int wm_coeff_write_control(struct snd_kcontrol *kcontrol,
 				  const void *buf, size_t len)
 {
-	struct wm_coeff *wm_coeff= snd_kcontrol_chip(kcontrol);
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
 	struct wm_adsp_alg_region *region = &ctl->region;
 	const struct wm_adsp_region *mem;
@@ -401,7 +394,7 @@ static int wm_coeff_write_control(struct snd_kcontrol *kcontrol,
 	if (!scratch)
 		return -ENOMEM;
 
-	ret = regmap_raw_write(wm_coeff->regmap, reg, scratch,
+	ret = regmap_raw_write(adsp->regmap, reg, scratch,
 			       ctl->len);
 	if (ret) {
 		adsp_err(adsp, "Failed to write %zu bytes to %x\n",
@@ -434,7 +427,6 @@ static int wm_coeff_put(struct snd_kcontrol *kcontrol,
 static int wm_coeff_read_control(struct snd_kcontrol *kcontrol,
 				 void *buf, size_t len)
 {
-	struct wm_coeff *wm_coeff= snd_kcontrol_chip(kcontrol);
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
 	struct wm_adsp_alg_region *region = &ctl->region;
 	const struct wm_adsp_region *mem;
@@ -457,7 +449,7 @@ static int wm_coeff_read_control(struct snd_kcontrol *kcontrol,
 	if (!scratch)
 		return -ENOMEM;
 
-	ret = regmap_raw_read(wm_coeff->regmap, reg, scratch, ctl->len);
+	ret = regmap_raw_read(adsp->regmap, reg, scratch, ctl->len);
 	if (ret) {
 		adsp_err(adsp, "Failed to read %zu bytes from %x\n",
 			 ctl->len, reg);
@@ -481,37 +473,18 @@ static int wm_coeff_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int wm_coeff_add_kcontrol(struct wm_coeff *wm_coeff,
-				 struct wm_coeff_ctl *ctl,
-				 const struct snd_kcontrol_new *kctl)
-{
-	int ret;
-	struct snd_kcontrol *kcontrol;
-
-	kcontrol = snd_ctl_new1(kctl, wm_coeff);
-	ret = snd_ctl_add(ctl->card, kcontrol);
-	if (ret < 0) {
-		dev_err(wm_coeff->dev, "Failed to add %s: %d\n",
-			kctl->name, ret);
-		return ret;
-	}
-	ctl->kcontrol = kcontrol;
-	return 0;
-}
-
 struct wmfw_ctl_work {
-	struct wm_coeff *wm_coeff;
+	struct wm_adsp *adsp;
 	struct wm_coeff_ctl *ctl;
 	struct work_struct work;
 };
 
-static int wmfw_add_ctl(struct wm_coeff *wm_coeff,
-			struct wm_coeff_ctl *ctl)
+static int wmfw_add_ctl(struct wm_adsp *adsp, struct wm_coeff_ctl *ctl)
 {
 	struct snd_kcontrol_new *kcontrol;
 	int ret;
 
-	if (!wm_coeff || !ctl || !ctl->name || !ctl->card)
+	if (!ctl || !ctl->name || !ctl->card)
 		return -EINVAL;
 
 	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
@@ -525,14 +498,17 @@ static int wmfw_add_ctl(struct wm_coeff *wm_coeff,
 	kcontrol->put = wm_coeff_put;
 	kcontrol->private_value = (unsigned long)ctl;
 
-	ret = wm_coeff_add_kcontrol(wm_coeff,
-				    ctl, kcontrol);
+	ret = snd_soc_add_card_controls(ctl->card,
+					kcontrol, 1);
 	if (ret < 0)
 		goto err_kcontrol;
 
 	kfree(kcontrol);
 
-	list_add(&ctl->list, &wm_coeff->ctl_list);
+	ctl->kcontrol = snd_soc_card_get_kcontrol(ctl->card,
+						  ctl->name);
+
+	list_add(&ctl->list, &adsp->ctl_list);
 	return 0;
 
 err_kcontrol:
@@ -753,13 +729,12 @@ out:
 	return ret;
 }
 
-static int wm_coeff_init_control_caches(struct wm_coeff *wm_coeff)
+static int wm_coeff_init_control_caches(struct wm_adsp *adsp)
 {
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
-	list_for_each_entry(ctl, &wm_coeff->ctl_list,
-			    list) {
+	list_for_each_entry(ctl, &adsp->ctl_list, list) {
 		if (!ctl->enabled || ctl->set)
 			continue;
 		ret = wm_coeff_read_control(ctl->kcontrol,
@@ -772,13 +747,12 @@ static int wm_coeff_init_control_caches(struct wm_coeff *wm_coeff)
 	return 0;
 }
 
-static int wm_coeff_sync_controls(struct wm_coeff *wm_coeff)
+static int wm_coeff_sync_controls(struct wm_adsp *adsp)
 {
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
-	list_for_each_entry(ctl, &wm_coeff->ctl_list,
-			    list) {
+	list_for_each_entry(ctl, &adsp->ctl_list, list) {
 		if (!ctl->enabled)
 			continue;
 		if (ctl->set) {
@@ -799,7 +773,7 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 						      struct wmfw_ctl_work,
 						      work);
 
-	wmfw_add_ctl(ctl_work->wm_coeff, ctl_work->ctl);
+	wmfw_add_ctl(ctl_work->adsp, ctl_work->ctl);
 	kfree(ctl_work);
 }
 
@@ -842,7 +816,7 @@ static int wm_adsp_create_control(struct snd_soc_codec *codec,
 	snprintf(name, PAGE_SIZE, "DSP%d %s %x",
 		 dsp->num, region_name, region->alg);
 
-	list_for_each_entry(ctl, &dsp->wm_coeff->ctl_list,
+	list_for_each_entry(ctl, &dsp->ctl_list,
 			    list) {
 		if (!strcmp(ctl->name, name)) {
 			if (!ctl->enabled)
@@ -866,7 +840,7 @@ static int wm_adsp_create_control(struct snd_soc_codec *codec,
 	ctl->set = 0;
 	ctl->ops.xget = wm_coeff_get;
 	ctl->ops.xput = wm_coeff_put;
-	ctl->card = codec->card->snd_card;
+	ctl->card = codec->card;
 	ctl->adsp = dsp;
 
 	ctl->len = region->len;
@@ -882,7 +856,7 @@ static int wm_adsp_create_control(struct snd_soc_codec *codec,
 		goto err_ctl_cache;
 	}
 
-	ctl_work->wm_coeff = dsp->wm_coeff;
+	ctl_work->adsp = dsp;
 	ctl_work->ctl = ctl;
 	INIT_WORK(&ctl_work->work, wm_adsp_ctl_work);
 	schedule_work(&ctl_work->work);
@@ -1434,12 +1408,12 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 			goto err;
 
 		/* Initialize caches for enabled and unset controls */
-		ret = wm_coeff_init_control_caches(dsp->wm_coeff);
+		ret = wm_coeff_init_control_caches(dsp);
 		if (ret != 0)
 			goto err;
 
 		/* Sync set controls */
-		ret = wm_coeff_sync_controls(dsp->wm_coeff);
+		ret = wm_coeff_sync_controls(dsp);
 		if (ret != 0)
 			goto err;
 
@@ -1460,10 +1434,8 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 				   ADSP1_SYS_ENA, 0);
 
-		list_for_each_entry(ctl, &dsp->wm_coeff->ctl_list,
-				    list) {
+		list_for_each_entry(ctl, &dsp->ctl_list, list)
 			ctl->enabled = 0;
-		}
 		break;
 
 	default:
@@ -1591,12 +1563,12 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 			goto err;
 
 		/* Initialize caches for enabled and unset controls */
-		ret = wm_coeff_init_control_caches(dsp->wm_coeff);
+		ret = wm_coeff_init_control_caches(dsp);
 		if (ret != 0)
 			goto err;
 
 		/* Sync set controls */
-		ret = wm_coeff_sync_controls(dsp->wm_coeff);
+		ret = wm_coeff_sync_controls(dsp);
 		if (ret != 0)
 			goto err;
 
@@ -1637,10 +1609,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 					ret);
 		}
 
-		list_for_each_entry(ctl, &dsp->wm_coeff->ctl_list,
-				    list) {
+		list_for_each_entry(ctl, &dsp->ctl_list, list)
 			ctl->enabled = 0;
-		}
 
 		while (!list_empty(&dsp->alg_regions)) {
 			alg_region = list_first_entry(&dsp->alg_regions,
@@ -1679,49 +1649,38 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
 	}
 
 	INIT_LIST_HEAD(&adsp->alg_regions);
-
-	adsp->wm_coeff = kzalloc(sizeof(*adsp->wm_coeff),
-				 GFP_KERNEL);
-	if (!adsp->wm_coeff)
-		return -ENOMEM;
-	adsp->wm_coeff->regmap = adsp->regmap;
-	adsp->wm_coeff->dev = adsp->dev;
-	INIT_LIST_HEAD(&adsp->wm_coeff->ctl_list);
+	INIT_LIST_HEAD(&adsp->ctl_list);
 
 	if (dvfs) {
 		adsp->dvfs = devm_regulator_get(adsp->dev, "DCVDD");
 		if (IS_ERR(adsp->dvfs)) {
 			ret = PTR_ERR(adsp->dvfs);
 			dev_err(adsp->dev, "Failed to get DCVDD: %d\n", ret);
-			goto out_coeff;
+			return ret;
 		}
 
 		ret = regulator_enable(adsp->dvfs);
 		if (ret != 0) {
 			dev_err(adsp->dev, "Failed to enable DCVDD: %d\n",
 				ret);
-			goto out_coeff;
+			return ret;
 		}
 
 		ret = regulator_set_voltage(adsp->dvfs, 1200000, 1800000);
 		if (ret != 0) {
 			dev_err(adsp->dev, "Failed to initialise DVFS: %d\n",
 				ret);
-			goto out_coeff;
+			return ret;
 		}
 
 		ret = regulator_disable(adsp->dvfs);
 		if (ret != 0) {
 			dev_err(adsp->dev, "Failed to disable DCVDD: %d\n",
 				ret);
-			goto out_coeff;
+			return ret;
 		}
 	}
 
 	return 0;
-
-out_coeff:
-	kfree(adsp->wm_coeff);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 9f922c8..64087fb 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -57,7 +57,7 @@ struct wm_adsp {
 
 	struct regulator *dvfs;
 
-	struct wm_coeff *wm_coeff;
+	struct list_head ctl_list;
 };
 
 #define WM_ADSP1(wname, num) \
-- 
1.8.3.4
