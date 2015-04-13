From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 02/13] ASoC: wm_adsp: Improve variable naming
Date: Mon, 13 Apr 2015 13:27:54 +0100
Message-ID: <1428928085-20250-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8491426508D
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:04 +0200 (CEST)
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

We have wm_adsp_region, wm_adsp_alg_region, and wmfw_region, the
variables for which are all frequently called region, this can get quite
confusing when reviewing the code especially given some functions are
quite long. Consistently use mem for wm_adsp_regions, alg_region for
wm_adsp_alg_region and region for wmfw_region.

Additionally, we use a mix of adsp and dsp for pointers to the wm_adsp
structure standardise this on dsp.

Finally, we use algs to refer to the number of algorithms quite
frequently, change this to the more descriptive n_algs.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  356 ++++++++++++++++++++++----------------------
 sound/soc/codecs/wm_adsp.h |    4 +-
 sound/soc/codecs/wmfw.h    |    4 +-
 3 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f421c09..4201e1f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -229,9 +229,9 @@ struct wm_coeff_ctl_ops {
 
 struct wm_coeff_ctl {
 	const char *name;
-	struct wm_adsp_alg_region region;
+	struct wm_adsp_alg_region alg_region;
 	struct wm_coeff_ctl_ops ops;
-	struct wm_adsp *adsp;
+	struct wm_adsp *dsp;
 	void *private;
 	unsigned int enabled:1;
 	struct list_head list;
@@ -246,9 +246,9 @@ static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	struct wm_adsp *adsp = snd_soc_codec_get_drvdata(codec);
+	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.integer.value[0] = adsp[e->shift_l].fw;
+	ucontrol->value.integer.value[0] = dsp[e->shift_l].fw;
 
 	return 0;
 }
@@ -258,18 +258,18 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	struct wm_adsp *adsp = snd_soc_codec_get_drvdata(codec);
+	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
 
-	if (ucontrol->value.integer.value[0] == adsp[e->shift_l].fw)
+	if (ucontrol->value.integer.value[0] == dsp[e->shift_l].fw)
 		return 0;
 
 	if (ucontrol->value.integer.value[0] >= WM_ADSP_NUM_FW)
 		return -EINVAL;
 
-	if (adsp[e->shift_l].running)
+	if (dsp[e->shift_l].running)
 		return -EBUSY;
 
-	adsp[e->shift_l].fw = ucontrol->value.integer.value[0];
+	dsp[e->shift_l].fw = ucontrol->value.integer.value[0];
 
 	return 0;
 }
@@ -340,22 +340,22 @@ static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
 	return NULL;
 }
 
-static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *region,
+static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 					  unsigned int offset)
 {
-	if (WARN_ON(!region))
+	if (WARN_ON(!mem))
 		return offset;
-	switch (region->type) {
+	switch (mem->type) {
 	case WMFW_ADSP1_PM:
-		return region->base + (offset * 3);
+		return mem->base + (offset * 3);
 	case WMFW_ADSP1_DM:
-		return region->base + (offset * 2);
+		return mem->base + (offset * 2);
 	case WMFW_ADSP2_XM:
-		return region->base + (offset * 2);
+		return mem->base + (offset * 2);
 	case WMFW_ADSP2_YM:
-		return region->base + (offset * 2);
+		return mem->base + (offset * 2);
 	case WMFW_ADSP1_ZM:
-		return region->base + (offset * 2);
+		return mem->base + (offset * 2);
 	default:
 		WARN(1, "Unknown memory region type");
 		return offset;
@@ -376,36 +376,36 @@ static int wm_coeff_write_control(struct snd_kcontrol *kcontrol,
 				  const void *buf, size_t len)
 {
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
-	struct wm_adsp_alg_region *region = &ctl->region;
+	struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
 	const struct wm_adsp_region *mem;
-	struct wm_adsp *adsp = ctl->adsp;
+	struct wm_adsp *dsp = ctl->dsp;
 	void *scratch;
 	int ret;
 	unsigned int reg;
 
-	mem = wm_adsp_find_region(adsp, region->type);
+	mem = wm_adsp_find_region(dsp, alg_region->type);
 	if (!mem) {
-		adsp_err(adsp, "No base for region %x\n",
-			 region->type);
+		adsp_err(dsp, "No base for region %x\n",
+			 alg_region->type);
 		return -EINVAL;
 	}
 
-	reg = ctl->region.base;
+	reg = ctl->alg_region.base;
 	reg = wm_adsp_region_to_reg(mem, reg);
 
 	scratch = kmemdup(buf, ctl->len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
 		return -ENOMEM;
 
-	ret = regmap_raw_write(adsp->regmap, reg, scratch,
+	ret = regmap_raw_write(dsp->regmap, reg, scratch,
 			       ctl->len);
 	if (ret) {
-		adsp_err(adsp, "Failed to write %zu bytes to %x: %d\n",
+		adsp_err(dsp, "Failed to write %zu bytes to %x: %d\n",
 			 ctl->len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
-	adsp_dbg(adsp, "Wrote %zu bytes to %x\n", ctl->len, reg);
+	adsp_dbg(dsp, "Wrote %zu bytes to %x\n", ctl->len, reg);
 
 	kfree(scratch);
 
@@ -431,35 +431,35 @@ static int wm_coeff_read_control(struct snd_kcontrol *kcontrol,
 				 void *buf, size_t len)
 {
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
-	struct wm_adsp_alg_region *region = &ctl->region;
+	struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
 	const struct wm_adsp_region *mem;
-	struct wm_adsp *adsp = ctl->adsp;
+	struct wm_adsp *dsp = ctl->dsp;
 	void *scratch;
 	int ret;
 	unsigned int reg;
 
-	mem = wm_adsp_find_region(adsp, region->type);
+	mem = wm_adsp_find_region(dsp, alg_region->type);
 	if (!mem) {
-		adsp_err(adsp, "No base for region %x\n",
-			 region->type);
+		adsp_err(dsp, "No base for region %x\n",
+			 alg_region->type);
 		return -EINVAL;
 	}
 
-	reg = ctl->region.base;
+	reg = ctl->alg_region.base;
 	reg = wm_adsp_region_to_reg(mem, reg);
 
 	scratch = kmalloc(ctl->len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
 		return -ENOMEM;
 
-	ret = regmap_raw_read(adsp->regmap, reg, scratch, ctl->len);
+	ret = regmap_raw_read(dsp->regmap, reg, scratch, ctl->len);
 	if (ret) {
-		adsp_err(adsp, "Failed to read %zu bytes from %x: %d\n",
+		adsp_err(dsp, "Failed to read %zu bytes from %x: %d\n",
 			 ctl->len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
-	adsp_dbg(adsp, "Read %zu bytes from %x\n", ctl->len, reg);
+	adsp_dbg(dsp, "Read %zu bytes from %x\n", ctl->len, reg);
 
 	memcpy(buf, scratch, ctl->len);
 	kfree(scratch);
@@ -478,12 +478,12 @@ static int wm_coeff_get(struct snd_kcontrol *kcontrol,
 }
 
 struct wmfw_ctl_work {
-	struct wm_adsp *adsp;
+	struct wm_adsp *dsp;
 	struct wm_coeff_ctl *ctl;
 	struct work_struct work;
 };
 
-static int wmfw_add_ctl(struct wm_adsp *adsp, struct wm_coeff_ctl *ctl)
+static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 {
 	struct snd_kcontrol_new *kcontrol;
 	int ret;
@@ -502,17 +502,18 @@ static int wmfw_add_ctl(struct wm_adsp *adsp, struct wm_coeff_ctl *ctl)
 	kcontrol->put = wm_coeff_put;
 	kcontrol->private_value = (unsigned long)ctl;
 
-	ret = snd_soc_add_card_controls(adsp->card,
+	ret = snd_soc_add_card_controls(dsp->card,
 					kcontrol, 1);
 	if (ret < 0)
 		goto err_kcontrol;
 
 	kfree(kcontrol);
 
-	ctl->kcontrol = snd_soc_card_get_kcontrol(adsp->card,
+	ctl->kcontrol = snd_soc_card_get_kcontrol(dsp->card,
 						  ctl->name);
 
-	list_add(&ctl->list, &adsp->ctl_list);
+	list_add(&ctl->list, &dsp->ctl_list);
+
 	return 0;
 
 err_kcontrol:
@@ -730,12 +731,12 @@ out:
 	return ret;
 }
 
-static int wm_coeff_init_control_caches(struct wm_adsp *adsp)
+static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 {
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
-	list_for_each_entry(ctl, &adsp->ctl_list, list) {
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
 		if (!ctl->enabled || ctl->set)
 			continue;
 		ret = wm_coeff_read_control(ctl->kcontrol,
@@ -748,12 +749,12 @@ static int wm_coeff_init_control_caches(struct wm_adsp *adsp)
 	return 0;
 }
 
-static int wm_coeff_sync_controls(struct wm_adsp *adsp)
+static int wm_coeff_sync_controls(struct wm_adsp *dsp)
 {
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
-	list_for_each_entry(ctl, &adsp->ctl_list, list) {
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
 		if (!ctl->enabled)
 			continue;
 		if (ctl->set) {
@@ -774,13 +775,12 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 						      struct wmfw_ctl_work,
 						      work);
 
-	wmfw_add_ctl(ctl_work->adsp, ctl_work->ctl);
+	wmfw_add_ctl(ctl_work->dsp, ctl_work->ctl);
 	kfree(ctl_work);
 }
 
 static int wm_adsp_create_control(struct wm_adsp *dsp,
-				  const struct wm_adsp_alg_region *region)
-
+				  const struct wm_adsp_alg_region *alg_region)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -792,7 +792,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	if (!name)
 		return -ENOMEM;
 
-	switch (region->type) {
+	switch (alg_region->type) {
 	case WMFW_ADSP1_PM:
 		region_name = "PM";
 		break;
@@ -814,7 +814,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	}
 
 	snprintf(name, PAGE_SIZE, "DSP%d %s %x",
-		 dsp->num, region_name, region->alg);
+		 dsp->num, region_name, alg_region->alg);
 
 	list_for_each_entry(ctl, &dsp->ctl_list,
 			    list) {
@@ -830,7 +830,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		ret = -ENOMEM;
 		goto err_name;
 	}
-	ctl->region = *region;
+	ctl->alg_region = *alg_region;
 	ctl->name = kmemdup(name, strlen(name) + 1, GFP_KERNEL);
 	if (!ctl->name) {
 		ret = -ENOMEM;
@@ -840,9 +840,9 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	ctl->set = 0;
 	ctl->ops.xget = wm_coeff_get;
 	ctl->ops.xput = wm_coeff_put;
-	ctl->adsp = dsp;
+	ctl->dsp = dsp;
 
-	ctl->len = region->len;
+	ctl->len = alg_region->len;
 	ctl->cache = kzalloc(ctl->len, GFP_KERNEL);
 	if (!ctl->cache) {
 		ret = -ENOMEM;
@@ -855,7 +855,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		goto err_ctl_cache;
 	}
 
-	ctl_work->adsp = dsp;
+	ctl_work->dsp = dsp;
 	ctl_work->ctl = ctl;
 	INIT_WORK(&ctl_work->work, wm_adsp_ctl_work);
 	schedule_work(&ctl_work->work);
@@ -876,20 +876,20 @@ err_name:
 	return ret;
 }
 
-static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t algs,
+static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 			       unsigned int pos, unsigned int len)
 {
 	void *alg;
 	int ret;
 	__be32 val;
 
-	if (algs == 0) {
+	if (n_algs == 0) {
 		adsp_err(dsp, "No algorithms\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (algs > 1024) {
-		adsp_err(dsp, "Algorithm count %zx excessive\n", algs);
+	if (n_algs > 1024) {
+		adsp_err(dsp, "Algorithm count %zx excessive\n", n_algs);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -924,10 +924,10 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 {
 	struct wmfw_adsp1_id_hdr adsp1_id;
 	struct wmfw_adsp1_alg_hdr *adsp1_alg;
-	struct wm_adsp_alg_region *region;
+	struct wm_adsp_alg_region *alg_region;
 	const struct wm_adsp_region *mem;
 	unsigned int pos, len;
-	size_t algs;
+	size_t n_algs;
 	int i, ret;
 
 	mem = wm_adsp_find_region(dsp, WMFW_ADSP1_DM);
@@ -942,39 +942,39 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 		return ret;
 	}
 
-	algs = be32_to_cpu(adsp1_id.algs);
+	n_algs = be32_to_cpu(adsp1_id.n_algs);
 	dsp->fw_id = be32_to_cpu(adsp1_id.fw.id);
 	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
 		  dsp->fw_id,
 		  (be32_to_cpu(adsp1_id.fw.ver) & 0xff0000) >> 16,
 		  (be32_to_cpu(adsp1_id.fw.ver) & 0xff00) >> 8,
 		  be32_to_cpu(adsp1_id.fw.ver) & 0xff,
-		  algs);
+		  n_algs);
 
-	region = kzalloc(sizeof(*region), GFP_KERNEL);
-	if (!region)
+	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+	if (!alg_region)
 		return -ENOMEM;
-	region->type = WMFW_ADSP1_ZM;
-	region->alg = be32_to_cpu(adsp1_id.fw.id);
-	region->base = be32_to_cpu(adsp1_id.zm);
-	list_add_tail(&region->list, &dsp->alg_regions);
+	alg_region->type = WMFW_ADSP1_ZM;
+	alg_region->alg = be32_to_cpu(adsp1_id.fw.id);
+	alg_region->base = be32_to_cpu(adsp1_id.zm);
+	list_add_tail(&alg_region->list, &dsp->alg_regions);
 
-	region = kzalloc(sizeof(*region), GFP_KERNEL);
-	if (!region)
+	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+	if (!alg_region)
 		return -ENOMEM;
-	region->type = WMFW_ADSP1_DM;
-	region->alg = be32_to_cpu(adsp1_id.fw.id);
-	region->base = be32_to_cpu(adsp1_id.dm);
-	list_add_tail(&region->list, &dsp->alg_regions);
+	alg_region->type = WMFW_ADSP1_DM;
+	alg_region->alg = be32_to_cpu(adsp1_id.fw.id);
+	alg_region->base = be32_to_cpu(adsp1_id.dm);
+	list_add_tail(&alg_region->list, &dsp->alg_regions);
 
 	pos = sizeof(adsp1_id) / 2;
-	len = (sizeof(*adsp1_alg) * algs) / 2;
+	len = (sizeof(*adsp1_alg) * n_algs) / 2;
 
-	adsp1_alg = wm_adsp_read_algs(dsp, algs, mem->base + pos, len);
+	adsp1_alg = wm_adsp_read_algs(dsp, n_algs, mem->base + pos, len);
 	if (IS_ERR(adsp1_alg))
 		return PTR_ERR(adsp1_alg);
 
-	for (i = 0; i < algs; i++) {
+	for (i = 0; i < n_algs; i++) {
 		adsp_info(dsp, "%d: ID %x v%d.%d.%d DM@%x ZM@%x\n",
 			  i, be32_to_cpu(adsp1_alg[i].alg.id),
 			  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff0000) >> 16,
@@ -983,41 +983,41 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 			  be32_to_cpu(adsp1_alg[i].dm),
 			  be32_to_cpu(adsp1_alg[i].zm));
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region) {
+		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+		if (!alg_region) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		region->type = WMFW_ADSP1_DM;
-		region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
-		region->base = be32_to_cpu(adsp1_alg[i].dm);
-		region->len = 0;
-		list_add_tail(&region->list, &dsp->alg_regions);
-		if (i + 1 < algs) {
-			region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
-			region->len -= be32_to_cpu(adsp1_alg[i].dm);
-			region->len *= 4;
-			wm_adsp_create_control(dsp, region);
+		alg_region->type = WMFW_ADSP1_DM;
+		alg_region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
+		alg_region->base = be32_to_cpu(adsp1_alg[i].dm);
+		alg_region->len = 0;
+		list_add_tail(&alg_region->list, &dsp->alg_regions);
+		if (i + 1 < n_algs) {
+			alg_region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
+			alg_region->len -= be32_to_cpu(adsp1_alg[i].dm);
+			alg_region->len *= 4;
+			wm_adsp_create_control(dsp, alg_region);
 		} else {
 			adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 				  be32_to_cpu(adsp1_alg[i].alg.id));
 		}
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region) {
+		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+		if (!alg_region) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		region->type = WMFW_ADSP1_ZM;
-		region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
-		region->base = be32_to_cpu(adsp1_alg[i].zm);
-		region->len = 0;
-		list_add_tail(&region->list, &dsp->alg_regions);
-		if (i + 1 < algs) {
-			region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
-			region->len -= be32_to_cpu(adsp1_alg[i].zm);
-			region->len *= 4;
-			wm_adsp_create_control(dsp, region);
+		alg_region->type = WMFW_ADSP1_ZM;
+		alg_region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
+		alg_region->base = be32_to_cpu(adsp1_alg[i].zm);
+		alg_region->len = 0;
+		list_add_tail(&alg_region->list, &dsp->alg_regions);
+		if (i + 1 < n_algs) {
+			alg_region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
+			alg_region->len -= be32_to_cpu(adsp1_alg[i].zm);
+			alg_region->len *= 4;
+			wm_adsp_create_control(dsp, alg_region);
 		} else {
 			adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 				  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1033,10 +1033,10 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 {
 	struct wmfw_adsp2_id_hdr adsp2_id;
 	struct wmfw_adsp2_alg_hdr *adsp2_alg;
-	struct wm_adsp_alg_region *region;
+	struct wm_adsp_alg_region *alg_region;
 	const struct wm_adsp_region *mem;
 	unsigned int pos, len;
-	size_t algs;
+	size_t n_algs;
 	int i, ret;
 
 	mem = wm_adsp_find_region(dsp, WMFW_ADSP2_XM);
@@ -1051,47 +1051,47 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 		return ret;
 	}
 
-	algs = be32_to_cpu(adsp2_id.algs);
+	n_algs = be32_to_cpu(adsp2_id.n_algs);
 	dsp->fw_id = be32_to_cpu(adsp2_id.fw.id);
 	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
 		  dsp->fw_id,
 		  (be32_to_cpu(adsp2_id.fw.ver) & 0xff0000) >> 16,
 		  (be32_to_cpu(adsp2_id.fw.ver) & 0xff00) >> 8,
 		  be32_to_cpu(adsp2_id.fw.ver) & 0xff,
-		  algs);
+		  n_algs);
 
-	region = kzalloc(sizeof(*region), GFP_KERNEL);
-	if (!region)
+	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+	if (!alg_region)
 		return -ENOMEM;
-	region->type = WMFW_ADSP2_XM;
-	region->alg = be32_to_cpu(adsp2_id.fw.id);
-	region->base = be32_to_cpu(adsp2_id.xm);
-	list_add_tail(&region->list, &dsp->alg_regions);
+	alg_region->type = WMFW_ADSP2_XM;
+	alg_region->alg = be32_to_cpu(adsp2_id.fw.id);
+	alg_region->base = be32_to_cpu(adsp2_id.xm);
+	list_add_tail(&alg_region->list, &dsp->alg_regions);
 
-	region = kzalloc(sizeof(*region), GFP_KERNEL);
-	if (!region)
+	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+	if (!alg_region)
 		return -ENOMEM;
-	region->type = WMFW_ADSP2_YM;
-	region->alg = be32_to_cpu(adsp2_id.fw.id);
-	region->base = be32_to_cpu(adsp2_id.ym);
-	list_add_tail(&region->list, &dsp->alg_regions);
+	alg_region->type = WMFW_ADSP2_YM;
+	alg_region->alg = be32_to_cpu(adsp2_id.fw.id);
+	alg_region->base = be32_to_cpu(adsp2_id.ym);
+	list_add_tail(&alg_region->list, &dsp->alg_regions);
 
-	region = kzalloc(sizeof(*region), GFP_KERNEL);
-	if (!region)
+	alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+	if (!alg_region)
 		return -ENOMEM;
-	region->type = WMFW_ADSP2_ZM;
-	region->alg = be32_to_cpu(adsp2_id.fw.id);
-	region->base = be32_to_cpu(adsp2_id.zm);
-	list_add_tail(&region->list, &dsp->alg_regions);
+	alg_region->type = WMFW_ADSP2_ZM;
+	alg_region->alg = be32_to_cpu(adsp2_id.fw.id);
+	alg_region->base = be32_to_cpu(adsp2_id.zm);
+	list_add_tail(&alg_region->list, &dsp->alg_regions);
 
 	pos = sizeof(adsp2_id) / 2;
-	len = (sizeof(*adsp2_alg) * algs) / 2;
+	len = (sizeof(*adsp2_alg) * n_algs) / 2;
 
-	adsp2_alg = wm_adsp_read_algs(dsp, algs, mem->base + pos, len);
+	adsp2_alg = wm_adsp_read_algs(dsp, n_algs, mem->base + pos, len);
 	if (IS_ERR(adsp2_alg))
 		return PTR_ERR(adsp2_alg);
 
-	for (i = 0; i < algs; i++) {
+	for (i = 0; i < n_algs; i++) {
 		adsp_info(dsp,
 			  "%d: ID %x v%d.%d.%d XM@%x YM@%x ZM@%x\n",
 			  i, be32_to_cpu(adsp2_alg[i].alg.id),
@@ -1102,61 +1102,61 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 			  be32_to_cpu(adsp2_alg[i].ym),
 			  be32_to_cpu(adsp2_alg[i].zm));
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region) {
+		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+		if (!alg_region) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		region->type = WMFW_ADSP2_XM;
-		region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-		region->base = be32_to_cpu(adsp2_alg[i].xm);
-		region->len = 0;
-		list_add_tail(&region->list, &dsp->alg_regions);
-		if (i + 1 < algs) {
-			region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
-			region->len -= be32_to_cpu(adsp2_alg[i].xm);
-			region->len *= 4;
-			wm_adsp_create_control(dsp, region);
+		alg_region->type = WMFW_ADSP2_XM;
+		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+		alg_region->base = be32_to_cpu(adsp2_alg[i].xm);
+		alg_region->len = 0;
+		list_add_tail(&alg_region->list, &dsp->alg_regions);
+		if (i + 1 < n_algs) {
+			alg_region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
+			alg_region->len -= be32_to_cpu(adsp2_alg[i].xm);
+			alg_region->len *= 4;
+			wm_adsp_create_control(dsp, alg_region);
 		} else {
 			adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 				  be32_to_cpu(adsp2_alg[i].alg.id));
 		}
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region) {
+		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+		if (!alg_region) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		region->type = WMFW_ADSP2_YM;
-		region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-		region->base = be32_to_cpu(adsp2_alg[i].ym);
-		region->len = 0;
-		list_add_tail(&region->list, &dsp->alg_regions);
-		if (i + 1 < algs) {
-			region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
-			region->len -= be32_to_cpu(adsp2_alg[i].ym);
-			region->len *= 4;
-			wm_adsp_create_control(dsp, region);
+		alg_region->type = WMFW_ADSP2_YM;
+		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+		alg_region->base = be32_to_cpu(adsp2_alg[i].ym);
+		alg_region->len = 0;
+		list_add_tail(&alg_region->list, &dsp->alg_regions);
+		if (i + 1 < n_algs) {
+			alg_region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
+			alg_region->len -= be32_to_cpu(adsp2_alg[i].ym);
+			alg_region->len *= 4;
+			wm_adsp_create_control(dsp, alg_region);
 		} else {
 			adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 				  be32_to_cpu(adsp2_alg[i].alg.id));
 		}
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
-		if (!region) {
+		alg_region = kzalloc(sizeof(*alg_region), GFP_KERNEL);
+		if (!alg_region) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		region->type = WMFW_ADSP2_ZM;
-		region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
-		region->base = be32_to_cpu(adsp2_alg[i].zm);
-		region->len = 0;
-		list_add_tail(&region->list, &dsp->alg_regions);
-		if (i + 1 < algs) {
-			region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
-			region->len -= be32_to_cpu(adsp2_alg[i].zm);
-			region->len *= 4;
-			wm_adsp_create_control(dsp, region);
+		alg_region->type = WMFW_ADSP2_ZM;
+		alg_region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
+		alg_region->base = be32_to_cpu(adsp2_alg[i].zm);
+		alg_region->len = 0;
+		list_add_tail(&alg_region->list, &dsp->alg_regions);
+		if (i + 1 < n_algs) {
+			alg_region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
+			alg_region->len -= be32_to_cpu(adsp2_alg[i].zm);
+			alg_region->len *= 4;
+			wm_adsp_create_control(dsp, alg_region);
 		} else {
 			adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 				  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1351,9 +1351,9 @@ out:
 	return ret;
 }
 
-int wm_adsp1_init(struct wm_adsp *adsp)
+int wm_adsp1_init(struct wm_adsp *dsp)
 {
-	INIT_LIST_HEAD(&adsp->alg_regions);
+	INIT_LIST_HEAD(&dsp->alg_regions);
 
 	return 0;
 }
@@ -1691,7 +1691,7 @@ err:
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_event);
 
-int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
+int wm_adsp2_init(struct wm_adsp *dsp, bool dvfs)
 {
 	int ret;
 
@@ -1699,40 +1699,40 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
 	 * Disable the DSP memory by default when in reset for a small
 	 * power saving.
 	 */
-	ret = regmap_update_bits(adsp->regmap, adsp->base + ADSP2_CONTROL,
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 				 ADSP2_MEM_ENA, 0);
 	if (ret != 0) {
-		adsp_err(adsp, "Failed to clear memory retention: %d\n", ret);
+		adsp_err(dsp, "Failed to clear memory retention: %d\n", ret);
 		return ret;
 	}
 
-	INIT_LIST_HEAD(&adsp->alg_regions);
-	INIT_LIST_HEAD(&adsp->ctl_list);
-	INIT_WORK(&adsp->boot_work, wm_adsp2_boot_work);
+	INIT_LIST_HEAD(&dsp->alg_regions);
+	INIT_LIST_HEAD(&dsp->ctl_list);
+	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
 
 	if (dvfs) {
-		adsp->dvfs = devm_regulator_get(adsp->dev, "DCVDD");
-		if (IS_ERR(adsp->dvfs)) {
-			ret = PTR_ERR(adsp->dvfs);
-			adsp_err(adsp, "Failed to get DCVDD: %d\n", ret);
+		dsp->dvfs = devm_regulator_get(dsp->dev, "DCVDD");
+		if (IS_ERR(dsp->dvfs)) {
+			ret = PTR_ERR(dsp->dvfs);
+			adsp_err(dsp, "Failed to get DCVDD: %d\n", ret);
 			return ret;
 		}
 
-		ret = regulator_enable(adsp->dvfs);
+		ret = regulator_enable(dsp->dvfs);
 		if (ret != 0) {
-			adsp_err(adsp, "Failed to enable DCVDD: %d\n", ret);
+			adsp_err(dsp, "Failed to enable DCVDD: %d\n", ret);
 			return ret;
 		}
 
-		ret = regulator_set_voltage(adsp->dvfs, 1200000, 1800000);
+		ret = regulator_set_voltage(dsp->dvfs, 1200000, 1800000);
 		if (ret != 0) {
-			adsp_err(adsp, "Failed to initialise DVFS: %d\n", ret);
+			adsp_err(dsp, "Failed to initialise DVFS: %d\n", ret);
 			return ret;
 		}
 
-		ret = regulator_disable(adsp->dvfs);
+		ret = regulator_disable(dsp->dvfs);
 		if (ret != 0) {
-			adsp_err(adsp, "Failed to disable DCVDD: %d\n", ret);
+			adsp_err(dsp, "Failed to disable DCVDD: %d\n", ret);
 			return ret;
 		}
 	}
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index a4f6b64..fc75a24 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -78,8 +78,8 @@ struct wm_adsp {
 extern const struct snd_kcontrol_new wm_adsp1_fw_controls[];
 extern const struct snd_kcontrol_new wm_adsp2_fw_controls[];
 
-int wm_adsp1_init(struct wm_adsp *adsp);
-int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs);
+int wm_adsp1_init(struct wm_adsp *dsp);
+int wm_adsp2_init(struct wm_adsp *dsp, bool dvfs);
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index ef16336..34c14b5 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -61,7 +61,7 @@ struct wmfw_adsp1_id_hdr {
 	struct wmfw_id_hdr fw;
 	__be32 zm;
 	__be32 dm;
-	__be32 algs;
+	__be32 n_algs;
 } __packed;
 
 struct wmfw_adsp2_id_hdr {
@@ -69,7 +69,7 @@ struct wmfw_adsp2_id_hdr {
 	__be32 zm;
 	__be32 xm;
 	__be32 ym;
-	__be32 algs;
+	__be32 n_algs;
 } __packed;
 
 struct wmfw_alg_hdr {
-- 
1.7.2.5
