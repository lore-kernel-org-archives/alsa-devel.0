From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: wm_adsp: Expose coefficient blocks as
	ALSA binary controls
Date: Wed, 17 Apr 2013 11:55:32 +0100
Message-ID: <1366196132-4302-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C0FD26160C
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 12:55:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add initial support for runtime tuning for the ADSP cores.  This
is achieved by exposing the coefficient configuration blocks as
ALSA binary controls.
The current code assumes that no controls on the DSP are volatile.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 435 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm_adsp.h |   3 +
 2 files changed, 431 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3470b64..080d05f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -215,6 +215,36 @@ static struct {
 	[WM_ADSP_FW_RX_ANC] =  { .file = "rx-anc" },
 };
 
+struct wm_coeff_ctl_ops {
+	int (*xget)(struct snd_kcontrol *kcontrol,
+		    struct snd_ctl_elem_value *ucontrol);
+	int (*xput)(struct snd_kcontrol *kcontrol,
+		    struct snd_ctl_elem_value *ucontrol);
+	int (*xinfo)(struct snd_kcontrol *kcontrol,
+		     struct snd_ctl_elem_info *uinfo);
+};
+
+struct wm_coeff {
+	struct device *dev;
+	struct list_head ctl_list;
+	struct regmap *regmap;
+};
+
+struct wm_coeff_ctl {
+	const char *name;
+	struct snd_card *card;
+	struct wm_adsp_alg_region region;
+	struct wm_coeff_ctl_ops ops;
+	struct wm_adsp *adsp;
+	void *private;
+	unsigned int enabled:1;
+	struct list_head list;
+	void *cache;
+	size_t len;
+	unsigned int dirty:1;
+	struct snd_kcontrol *kcontrol;
+};
+
 static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
@@ -334,6 +364,175 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *region,
 	}
 }
 
+static int wm_coeff_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = ctl->len;
+	return 0;
+}
+
+static int wm_coeff_write_control(struct snd_kcontrol *kcontrol,
+				  const void *buf, size_t len)
+{
+	struct wm_coeff *wm_coeff= snd_kcontrol_chip(kcontrol);
+	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
+	struct wm_adsp_alg_region *region = &ctl->region;
+	const struct wm_adsp_region *mem;
+	struct wm_adsp *adsp = ctl->adsp;
+	void *scratch;
+	int ret;
+	unsigned int reg;
+
+	mem = wm_adsp_find_region(adsp, region->type);
+	if (!mem) {
+		adsp_err(adsp, "No base for region %x\n",
+			 region->type);
+		return -EINVAL;
+	}
+
+	reg = ctl->region.base;
+	reg = wm_adsp_region_to_reg(mem, reg);
+
+	scratch = kmemdup(buf, ctl->len, GFP_KERNEL | GFP_DMA);
+	if (!scratch)
+		return -ENOMEM;
+
+	ret = regmap_raw_write(wm_coeff->regmap, reg, scratch,
+			       ctl->len);
+	if (ret) {
+		adsp_err(adsp, "Failed to write %zu bytes to %x\n",
+			 ctl->len, reg);
+		kfree(scratch);
+		return ret;
+	}
+
+	kfree(scratch);
+
+	return 0;
+}
+
+static int wm_coeff_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
+	char *p = ucontrol->value.bytes.data;
+
+	memcpy(ctl->cache, p, ctl->len);
+
+	if (!ctl->enabled) {
+		ctl->dirty = 1;
+		return 0;
+	}
+
+	return wm_coeff_write_control(kcontrol, p, ctl->len);
+}
+
+static int wm_coeff_read_control(struct snd_kcontrol *kcontrol,
+				 void *buf, size_t len)
+{
+	struct wm_coeff *wm_coeff= snd_kcontrol_chip(kcontrol);
+	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
+	struct wm_adsp_alg_region *region = &ctl->region;
+	const struct wm_adsp_region *mem;
+	struct wm_adsp *adsp = ctl->adsp;
+	void *scratch;
+	int ret;
+	unsigned int reg;
+
+	mem = wm_adsp_find_region(adsp, region->type);
+	if (!mem) {
+		adsp_err(adsp, "No base for region %x\n",
+			 region->type);
+		return -EINVAL;
+	}
+
+	reg = ctl->region.base;
+	reg = wm_adsp_region_to_reg(mem, reg);
+
+	scratch = kmalloc(ctl->len, GFP_KERNEL | GFP_DMA);
+	if (!scratch)
+		return -ENOMEM;
+
+	ret = regmap_raw_read(wm_coeff->regmap, reg, scratch, ctl->len);
+	if (ret) {
+		adsp_err(adsp, "Failed to read %zu bytes from %x\n",
+			 ctl->len, reg);
+		kfree(scratch);
+		return ret;
+	}
+
+	memcpy(buf, scratch, ctl->len);
+	kfree(scratch);
+
+	return 0;
+}
+
+static int wm_coeff_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
+	char *p = ucontrol->value.bytes.data;
+
+	memcpy(p, ctl->cache, ctl->len);
+	return 0;
+}
+
+static int wm_coeff_add_kcontrol(struct wm_coeff *wm_coeff,
+				 struct wm_coeff_ctl *ctl,
+				 const struct snd_kcontrol_new *kctl)
+{
+	int ret;
+	struct snd_kcontrol *kcontrol;
+
+	kcontrol = snd_ctl_new1(kctl, wm_coeff);
+	ret = snd_ctl_add(ctl->card, kcontrol);
+	if (ret < 0) {
+		dev_err(wm_coeff->dev, "Failed to add %s: %d\n",
+			kctl->name, ret);
+		return ret;
+	}
+	ctl->kcontrol = kcontrol;
+	return 0;
+}
+
+static int wmfw_add_ctl(struct wm_coeff *wm_coeff,
+			struct wm_coeff_ctl *ctl)
+{
+	struct snd_kcontrol_new *kcontrol;
+	int ret;
+
+	if (!wm_coeff || !ctl || !ctl->name || !ctl->card)
+		return -EINVAL;
+
+	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
+	if (!kcontrol)
+		return -ENOMEM;
+	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+
+	kcontrol->name = ctl->name;
+	kcontrol->info = wm_coeff_info;
+	kcontrol->get = wm_coeff_get;
+	kcontrol->put = wm_coeff_put;
+	kcontrol->private_value = (unsigned long)ctl;
+
+	ret = wm_coeff_add_kcontrol(wm_coeff,
+				    ctl, kcontrol);
+	if (ret < 0)
+		goto err_kcontrol;
+
+	kfree(kcontrol);
+
+	list_add(&ctl->list, &wm_coeff->ctl_list);
+	return 0;
+
+err_kcontrol:
+	kfree(kcontrol);
+	return ret;
+}
+
 static int wm_adsp_load(struct wm_adsp *dsp)
 {
 	LIST_HEAD(buf_list);
@@ -547,7 +746,140 @@ out:
 	return ret;
 }
 
-static int wm_adsp_setup_algs(struct wm_adsp *dsp)
+static int wm_coeff_init_control_caches(struct wm_coeff *wm_coeff)
+{
+	struct wm_coeff_ctl *ctl;
+	int ret;
+
+	list_for_each_entry(ctl, &wm_coeff->ctl_list,
+			    list) {
+		if (!ctl->enabled || ctl->dirty)
+			continue;
+		ret = wm_coeff_read_control(ctl->kcontrol,
+					    ctl->cache,
+					    ctl->len);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int wm_coeff_sync_controls(struct wm_coeff *wm_coeff)
+{
+	struct wm_coeff_ctl *ctl;
+	int ret;
+
+	list_for_each_entry(ctl, &wm_coeff->ctl_list,
+			    list) {
+		if (!ctl->enabled)
+			continue;
+		if (ctl->dirty) {
+			ret = wm_coeff_write_control(ctl->kcontrol,
+						     ctl->cache,
+						     ctl->len);
+			if (ret < 0)
+				return ret;
+			ctl->dirty = 0;
+		}
+	}
+
+	return 0;
+}
+
+static int wm_adsp_create_control(struct snd_soc_codec *codec,
+				  const struct wm_adsp_alg_region *region)
+
+{
+	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
+	struct wm_coeff_ctl *ctl;
+	char *name;
+	char *region_name;
+	int ret;
+
+	name = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	switch (region->type) {
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
+	snprintf(name, PAGE_SIZE, "DSP%d %s %x",
+		 dsp->num, region_name, region->alg);
+
+	list_for_each_entry(ctl, &dsp->wm_coeff->ctl_list,
+			    list) {
+		if (!strcmp(ctl->name, name)) {
+			if (!ctl->enabled)
+				ctl->enabled = 1;
+			return 0;
+		}
+	}
+
+	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+	if (!ctl) {
+		ret = -ENOMEM;
+		goto err_name;
+	}
+	ctl->region = *region;
+	ctl->name = kmemdup(name, strlen(name) + 1, GFP_KERNEL);
+	if (!ctl->name) {
+		ret = -ENOMEM;
+		goto err_ctl;
+	}
+	ctl->enabled = 1;
+	ctl->dirty = 0;
+	ctl->ops.xget = wm_coeff_get;
+	ctl->ops.xput = wm_coeff_put;
+	ctl->card = codec->card->snd_card;
+	ctl->adsp = dsp;
+
+	ctl->len = region->len;
+	ctl->cache = kzalloc(ctl->len, GFP_KERNEL);
+	if (!ctl->cache) {
+		ret = -ENOMEM;
+		goto err_ctl_name;
+	}
+
+	ret = wmfw_add_ctl(dsp->wm_coeff, ctl);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto err_ctl_cache;
+	}
+
+	kfree(name);
+
+	return 0;
+
+err_ctl_cache:
+	kfree(ctl->cache);
+err_ctl_name:
+	kfree(ctl->name);
+err_ctl:
+	kfree(ctl);
+err_name:
+	kfree(name);
+	return ret;
+}
+
+static int wm_adsp_setup_algs(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 {
 	struct regmap *regmap = dsp->regmap;
 	struct wmfw_adsp1_id_hdr adsp1_id;
@@ -730,7 +1062,16 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			region->type = WMFW_ADSP1_DM;
 			region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp1_alg[i].dm);
+			region->len = 0;
 			list_add_tail(&region->list, &dsp->alg_regions);
+			if (i + 1 < algs) {
+				region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
+				region->len -= be32_to_cpu(adsp1_alg[i].dm);
+				wm_adsp_create_control(codec, region);
+			} else {
+				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
+					  be32_to_cpu(adsp1_alg[i].alg.id));
+			}
 
 			region = kzalloc(sizeof(*region), GFP_KERNEL);
 			if (!region)
@@ -738,7 +1079,16 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			region->type = WMFW_ADSP1_ZM;
 			region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp1_alg[i].zm);
+			region->len = 0;
 			list_add_tail(&region->list, &dsp->alg_regions);
+			if (i + 1 < algs) {
+				region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
+				region->len -= be32_to_cpu(adsp1_alg[i].zm);
+				wm_adsp_create_control(codec, region);
+			} else {
+				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
+					  be32_to_cpu(adsp1_alg[i].alg.id));
+			}
 			break;
 
 		case WMFW_ADSP2:
@@ -758,7 +1108,16 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			region->type = WMFW_ADSP2_XM;
 			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp2_alg[i].xm);
+			region->len = 0;
 			list_add_tail(&region->list, &dsp->alg_regions);
+			if (i + 1 < algs) {
+				region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
+				region->len -= be32_to_cpu(adsp2_alg[i].xm);
+				wm_adsp_create_control(codec, region);
+			} else {
+				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
+					  be32_to_cpu(adsp2_alg[i].alg.id));
+			}
 
 			region = kzalloc(sizeof(*region), GFP_KERNEL);
 			if (!region)
@@ -766,7 +1125,16 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			region->type = WMFW_ADSP2_YM;
 			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp2_alg[i].ym);
+			region->len = 0;
 			list_add_tail(&region->list, &dsp->alg_regions);
+			if (i + 1 < algs) {
+				region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
+				region->len -= be32_to_cpu(adsp2_alg[i].ym);
+				wm_adsp_create_control(codec, region);
+			} else {
+				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
+					  be32_to_cpu(adsp2_alg[i].alg.id));
+			}
 
 			region = kzalloc(sizeof(*region), GFP_KERNEL);
 			if (!region)
@@ -774,7 +1142,16 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			region->type = WMFW_ADSP2_ZM;
 			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp2_alg[i].zm);
+			region->len = 0;
 			list_add_tail(&region->list, &dsp->alg_regions);
+			if (i + 1 < algs) {
+				region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
+				region->len -= be32_to_cpu(adsp2_alg[i].zm);
+				wm_adsp_create_control(codec, region);
+			} else {
+				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
+					  be32_to_cpu(adsp2_alg[i].alg.id));
+			}
 			break;
 		}
 	}
@@ -986,6 +1363,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = w->codec;
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
+	struct wm_coeff_ctl *ctl;
 	int ret;
 	int val;
 
@@ -1023,7 +1401,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
-		ret = wm_adsp_setup_algs(dsp);
+		ret = wm_adsp_setup_algs(dsp, codec);
 		if (ret != 0)
 			goto err;
 
@@ -1031,6 +1409,16 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
+		/* Initialize caches for enabled and non-dirty controls */
+		ret = wm_coeff_init_control_caches(dsp->wm_coeff);
+		if (ret != 0)
+			goto err;
+
+		/* Sync dirty controls */
+		ret = wm_coeff_sync_controls(dsp->wm_coeff);
+		if (ret != 0)
+			goto err;
+
 		/* Start the core running */
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 				   ADSP1_CORE_ENA | ADSP1_START,
@@ -1047,6 +1435,11 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 				   ADSP1_SYS_ENA, 0);
+
+		list_for_each_entry(ctl, &dsp->wm_coeff->ctl_list,
+				    list) {
+			ctl->enabled = 0;
+		}
 		break;
 
 	default:
@@ -1099,6 +1492,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
 	struct wm_adsp_alg_region *alg_region;
+	struct wm_coeff_ctl *ctl;
 	unsigned int val;
 	int ret;
 
@@ -1164,7 +1558,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
-		ret = wm_adsp_setup_algs(dsp);
+		ret = wm_adsp_setup_algs(dsp, codec);
 		if (ret != 0)
 			goto err;
 
@@ -1172,6 +1566,16 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
+		/* Initialize caches for enabled and non-dirty controls */
+		ret = wm_coeff_init_control_caches(dsp->wm_coeff);
+		if (ret != 0)
+			goto err;
+
+		/* Sync dirty controls */
+		ret = wm_coeff_sync_controls(dsp->wm_coeff);
+		if (ret != 0)
+			goto err;
+
 		ret = regmap_update_bits(dsp->regmap,
 					 dsp->base + ADSP2_CONTROL,
 					 ADSP2_CORE_ENA | ADSP2_START,
@@ -1209,6 +1613,11 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 					ret);
 		}
 
+		list_for_each_entry(ctl, &dsp->wm_coeff->ctl_list,
+				    list) {
+			ctl->enabled = 0;
+		}
+
 		while (!list_empty(&dsp->alg_regions)) {
 			alg_region = list_first_entry(&dsp->alg_regions,
 						      struct wm_adsp_alg_region,
@@ -1247,36 +1656,48 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
 
 	INIT_LIST_HEAD(&adsp->alg_regions);
 
+	adsp->wm_coeff = kzalloc(sizeof(*adsp->wm_coeff),
+				 GFP_KERNEL);
+	if (!adsp->wm_coeff)
+		return -ENOMEM;
+	adsp->wm_coeff->regmap = adsp->regmap;
+	adsp->wm_coeff->dev = adsp->dev;
+	INIT_LIST_HEAD(&adsp->wm_coeff->ctl_list);
+
 	if (dvfs) {
 		adsp->dvfs = devm_regulator_get(adsp->dev, "DCVDD");
 		if (IS_ERR(adsp->dvfs)) {
 			ret = PTR_ERR(adsp->dvfs);
 			dev_err(adsp->dev, "Failed to get DCVDD: %d\n", ret);
-			return ret;
+			goto out_coeff;
 		}
 
 		ret = regulator_enable(adsp->dvfs);
 		if (ret != 0) {
 			dev_err(adsp->dev, "Failed to enable DCVDD: %d\n",
 				ret);
-			return ret;
+			goto out_coeff;
 		}
 
 		ret = regulator_set_voltage(adsp->dvfs, 1200000, 1800000);
 		if (ret != 0) {
 			dev_err(adsp->dev, "Failed to initialise DVFS: %d\n",
 				ret);
-			return ret;
+			goto out_coeff;
 		}
 
 		ret = regulator_disable(adsp->dvfs);
 		if (ret != 0) {
 			dev_err(adsp->dev, "Failed to disable DCVDD: %d\n",
 				ret);
-			return ret;
+			goto out_coeff;
 		}
 	}
 
 	return 0;
+
+out_coeff:
+	kfree(adsp->wm_coeff);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index fea5146..6e890b9 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -30,6 +30,7 @@ struct wm_adsp_alg_region {
 	unsigned int alg;
 	int type;
 	unsigned int base;
+	size_t len;
 };
 
 struct wm_adsp {
@@ -55,6 +56,8 @@ struct wm_adsp {
 	bool running;
 
 	struct regulator *dvfs;
+
+	struct wm_coeff *wm_coeff;
 };
 
 #define WM_ADSP1(wname, num) \
-- 
1.8.2.1
