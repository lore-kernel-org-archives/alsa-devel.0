From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 001/102] ASoC: Rename soc_enum.max field with
	items
Date: Tue, 18 Feb 2014 12:29:25 +0100
Message-ID: <1392722967-12472-2-git-send-email-tiwai@suse.de>
References: <1392722967-12472-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D21D2651C7
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:29:34 +0100 (CET)
In-Reply-To: <1392722967-12472-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The name "max" in struct soc_enum is rather confusing since it
actually takes the number of items.  With "max", one might try to
assign (nitems - 1) value.

Rename the field to a more appropriate one, "items", which is also
used in struct snd_ctl_elem_info, too.

This patch also rewrites some code like "if (x > e->nitems - 1)" with
"if (x >= e->nitems)".  Not only the latter improves the readability,
it also fixes a potential bug when e->items is zero.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc.h            | 24 ++++++++++++------------
 sound/soc/codecs/max98088.c    |  2 +-
 sound/soc/codecs/max98095.c    |  4 ++--
 sound/soc/codecs/twl4030.c     |  4 ++--
 sound/soc/codecs/wm8904.c      |  4 ++--
 sound/soc/codecs/wm8958-dsp2.c |  8 ++++----
 sound/soc/codecs/wm8994.c      |  4 ++--
 sound/soc/codecs/wm8996.c      |  2 +-
 sound/soc/omap/ams-delta.c     |  2 +-
 sound/soc/soc-core.c           | 18 +++++++++---------
 sound/soc/soc-dapm.c           | 22 +++++++++++-----------
 11 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 21038e07e1a2..a53edc25334d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -176,19 +176,19 @@
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .min = xmin, .max = xmax, \
 		 .platform_max = xmax} }
-#define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmax, xtexts) \
+#define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xitems, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
-	.max = xmax, .texts = xtexts, \
-	.mask = xmax ? roundup_pow_of_two(xmax) - 1 : 0}
-#define SOC_ENUM_SINGLE(xreg, xshift, xmax, xtexts) \
-	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xmax, xtexts)
-#define SOC_ENUM_SINGLE_EXT(xmax, xtexts) \
-{	.max = xmax, .texts = xtexts }
-#define SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xmax, xtexts, xvalues) \
+	.items = xitems, .texts = xtexts, \
+	.mask = xitems ? roundup_pow_of_two(xitems) - 1 : 0}
+#define SOC_ENUM_SINGLE(xreg, xshift, xitems, xtexts) \
+	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xitems, xtexts)
+#define SOC_ENUM_SINGLE_EXT(xitems, xtexts) \
+{	.items = xitems, .texts = xtexts }
+#define SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xitems, xtexts, xvalues) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
-	.mask = xmask, .max = xmax, .texts = xtexts, .values = xvalues}
-#define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xmax, xtexts, xvalues) \
-	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xmax, xtexts, xvalues)
+	.mask = xmask, .items = xitems, .texts = xtexts, .values = xvalues}
+#define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xnitmes, xtexts, xvalues) \
+	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xnitmes, xtexts, xvalues)
 #define SOC_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
 	.info = snd_soc_info_enum_double, \
@@ -1103,7 +1103,7 @@ struct soc_enum {
 	unsigned short reg2;
 	unsigned char shift_l;
 	unsigned char shift_r;
-	unsigned int max;
+	unsigned int items;
 	unsigned int mask;
 	const char * const *texts;
 	const unsigned int *values;
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index ee660e2d3df3..bb1ecfc4459b 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1849,7 +1849,7 @@ static void max98088_handle_eq_pdata(struct snd_soc_codec *codec)
 
        /* Now point the soc_enum to .texts array items */
        max98088->eq_enum.texts = max98088->eq_texts;
-       max98088->eq_enum.max = max98088->eq_textcnt;
+       max98088->eq_enum.items = max98088->eq_textcnt;
 
        ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
        if (ret != 0)
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 3ba1170ebb53..5bce9cde4a6d 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1861,7 +1861,7 @@ static void max98095_handle_eq_pdata(struct snd_soc_codec *codec)
 
 	/* Now point the soc_enum to .texts array items */
 	max98095->eq_enum.texts = max98095->eq_texts;
-	max98095->eq_enum.max = max98095->eq_textcnt;
+	max98095->eq_enum.items = max98095->eq_textcnt;
 
 	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
 	if (ret != 0)
@@ -2016,7 +2016,7 @@ static void max98095_handle_bq_pdata(struct snd_soc_codec *codec)
 
 	/* Now point the soc_enum to .texts array items */
 	max98095->bq_enum.texts = max98095->bq_texts;
-	max98095->bq_enum.max = max98095->bq_textcnt;
+	max98095->bq_enum.items = max98095->bq_textcnt;
 
 	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
 	if (ret != 0)
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 00665ada23e2..1eb13d586309 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -975,13 +975,13 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 		return -EBUSY;
 	}
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 
 	val = ucontrol->value.enumerated.item[0] << e->shift_l;
 	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] >= e->items)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= e->mask << e->shift_r;
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 53bbfac6a83a..b2664ec901b9 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1981,7 +1981,7 @@ static void wm8904_handle_retune_mobile_pdata(struct snd_soc_codec *codec)
 	dev_dbg(codec->dev, "Allocated %d unique ReTune Mobile names\n",
 		wm8904->num_retune_mobile_texts);
 
-	wm8904->retune_mobile_enum.max = wm8904->num_retune_mobile_texts;
+	wm8904->retune_mobile_enum.items = wm8904->num_retune_mobile_texts;
 	wm8904->retune_mobile_enum.texts = wm8904->retune_mobile_texts;
 
 	ret = snd_soc_add_codec_controls(codec, &control, 1);
@@ -2022,7 +2022,7 @@ static void wm8904_handle_pdata(struct snd_soc_codec *codec)
 		for (i = 0; i < pdata->num_drc_cfgs; i++)
 			wm8904->drc_texts[i] = pdata->drc_cfgs[i].name;
 
-		wm8904->drc_enum.max = pdata->num_drc_cfgs;
+		wm8904->drc_enum.items = pdata->num_drc_cfgs;
 		wm8904->drc_enum.texts = wm8904->drc_texts;
 
 		ret = snd_soc_add_codec_controls(codec, &control, 1);
diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index b7488f190d2b..19743779bf4d 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -944,7 +944,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		for (i = 0; i < pdata->num_mbc_cfgs; i++)
 			wm8994->mbc_texts[i] = pdata->mbc_cfgs[i].name;
 
-		wm8994->mbc_enum.max = pdata->num_mbc_cfgs;
+		wm8994->mbc_enum.items = pdata->num_mbc_cfgs;
 		wm8994->mbc_enum.texts = wm8994->mbc_texts;
 
 		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
@@ -973,7 +973,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		for (i = 0; i < pdata->num_vss_cfgs; i++)
 			wm8994->vss_texts[i] = pdata->vss_cfgs[i].name;
 
-		wm8994->vss_enum.max = pdata->num_vss_cfgs;
+		wm8994->vss_enum.items = pdata->num_vss_cfgs;
 		wm8994->vss_enum.texts = wm8994->vss_texts;
 
 		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
@@ -1003,7 +1003,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		for (i = 0; i < pdata->num_vss_hpf_cfgs; i++)
 			wm8994->vss_hpf_texts[i] = pdata->vss_hpf_cfgs[i].name;
 
-		wm8994->vss_hpf_enum.max = pdata->num_vss_hpf_cfgs;
+		wm8994->vss_hpf_enum.items = pdata->num_vss_hpf_cfgs;
 		wm8994->vss_hpf_enum.texts = wm8994->vss_hpf_texts;
 
 		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
@@ -1034,7 +1034,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		for (i = 0; i < pdata->num_enh_eq_cfgs; i++)
 			wm8994->enh_eq_texts[i] = pdata->enh_eq_cfgs[i].name;
 
-		wm8994->enh_eq_enum.max = pdata->num_enh_eq_cfgs;
+		wm8994->enh_eq_enum.items = pdata->num_enh_eq_cfgs;
 		wm8994->enh_eq_enum.texts = wm8994->enh_eq_texts;
 
 		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b9be9cbc4603..8253c3c6db0e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3237,7 +3237,7 @@ static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 	dev_dbg(codec->dev, "Allocated %d unique ReTune Mobile names\n",
 		wm8994->num_retune_mobile_texts);
 
-	wm8994->retune_mobile_enum.max = wm8994->num_retune_mobile_texts;
+	wm8994->retune_mobile_enum.items = wm8994->num_retune_mobile_texts;
 	wm8994->retune_mobile_enum.texts = wm8994->retune_mobile_texts;
 
 	ret = snd_soc_add_codec_controls(wm8994->hubs.codec, controls,
@@ -3293,7 +3293,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		for (i = 0; i < pdata->num_drc_cfgs; i++)
 			wm8994->drc_texts[i] = pdata->drc_cfgs[i].name;
 
-		wm8994->drc_enum.max = pdata->num_drc_cfgs;
+		wm8994->drc_enum.items = pdata->num_drc_cfgs;
 		wm8994->drc_enum.texts = wm8994->drc_texts;
 
 		ret = snd_soc_add_codec_controls(wm8994->hubs.codec, controls,
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 1a7655b0aa22..ea6b587f65c1 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2595,7 +2595,7 @@ static void wm8996_retune_mobile_pdata(struct snd_soc_codec *codec)
 	dev_dbg(codec->dev, "Allocated %d unique ReTune Mobile names\n",
 		wm8996->num_retune_mobile_texts);
 
-	wm8996->retune_mobile_enum.max = wm8996->num_retune_mobile_texts;
+	wm8996->retune_mobile_enum.items = wm8996->num_retune_mobile_texts;
 	wm8996->retune_mobile_enum.texts = wm8996->retune_mobile_texts;
 
 	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 629446482a91..2eca91a51f51 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -103,7 +103,7 @@ static int ams_delta_set_audio_mode(struct snd_kcontrol *kcontrol,
 	if (!codec->hw_write)
 		return -EUNATCH;
 
-	if (ucontrol->value.enumerated.item[0] >= control->max)
+	if (ucontrol->value.enumerated.item[0] >= control->items)
 		return -EINVAL;
 
 	mutex_lock(&codec->mutex);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7054c8f71dd9..9740d55f39ce 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2570,10 +2570,10 @@ int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = e->shift_l == e->shift_r ? 1 : 2;
-	uinfo->value.enumerated.items = e->max;
+	uinfo->value.enumerated.items = e->items;
 
-	if (uinfo->value.enumerated.item > e->max - 1)
-		uinfo->value.enumerated.item = e->max - 1;
+	if (uinfo->value.enumerated.item >= e->items)
+		uinfo->value.enumerated.item = e->items - 1;
 	strlcpy(uinfo->value.enumerated.name,
 		e->texts[uinfo->value.enumerated.item],
 		sizeof(uinfo->value.enumerated.name));
@@ -2625,12 +2625,12 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned int val;
 	unsigned int mask;
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 	val = ucontrol->value.enumerated.item[0] << e->shift_l;
 	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] >= e->items)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= e->mask << e->shift_r;
@@ -2661,14 +2661,14 @@ int snd_soc_get_value_enum_double(struct snd_kcontrol *kcontrol,
 
 	reg_val = snd_soc_read(codec, e->reg);
 	val = (reg_val >> e->shift_l) & e->mask;
-	for (mux = 0; mux < e->max; mux++) {
+	for (mux = 0; mux < e->items; mux++) {
 		if (val == e->values[mux])
 			break;
 	}
 	ucontrol->value.enumerated.item[0] = mux;
 	if (e->shift_l != e->shift_r) {
 		val = (reg_val >> e->shift_r) & e->mask;
-		for (mux = 0; mux < e->max; mux++) {
+		for (mux = 0; mux < e->items; mux++) {
 			if (val == e->values[mux])
 				break;
 		}
@@ -2699,12 +2699,12 @@ int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned int val;
 	unsigned int mask;
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 	val = e->values[ucontrol->value.enumerated.item[0]] << e->shift_l;
 	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] >= e->items)
 			return -EINVAL;
 		val |= e->values[ucontrol->value.enumerated.item[1]] << e->shift_r;
 		mask |= e->mask << e->shift_r;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c2d751c6d54..bf0d1c455ff5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -536,7 +536,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		soc_widget_read(w, e->reg, &val);
 		item = (val >> e->shift_l) & e->mask;
 
-		if (item < e->max && !strcmp(p->name, e->texts[item]))
+		if (item < e->items && !strcmp(p->name, e->texts[item]))
 			p->connect = 1;
 		else
 			p->connect = 0;
@@ -564,12 +564,12 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 
 		soc_widget_read(w, e->reg, &val);
 		val = (val >> e->shift_l) & e->mask;
-		for (item = 0; item < e->max; item++) {
+		for (item = 0; item < e->items; item++) {
 			if (val == e->values[item])
 				break;
 		}
 
-		if (item < e->max && !strcmp(p->name, e->texts[item]))
+		if (item < e->items && !strcmp(p->name, e->texts[item]))
 			p->connect = 1;
 		else
 			p->connect = 0;
@@ -617,7 +617,7 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int i;
 
-	for (i = 0; i < e->max; i++) {
+	for (i = 0; i < e->items; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
 			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
@@ -2968,13 +2968,13 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_update update;
 	int ret = 0;
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 	mux = ucontrol->value.enumerated.item[0];
 	val = mux << e->shift_l;
 	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] >= e->items)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= e->mask << e->shift_r;
@@ -3037,7 +3037,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	int change;
 	int ret = 0;
 
-	if (ucontrol->value.enumerated.item[0] >= e->max)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
@@ -3078,14 +3078,14 @@ int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
 
 	reg_val = snd_soc_read(codec, e->reg);
 	val = (reg_val >> e->shift_l) & e->mask;
-	for (mux = 0; mux < e->max; mux++) {
+	for (mux = 0; mux < e->items; mux++) {
 		if (val == e->values[mux])
 			break;
 	}
 	ucontrol->value.enumerated.item[0] = mux;
 	if (e->shift_l != e->shift_r) {
 		val = (reg_val >> e->shift_r) & e->mask;
-		for (mux = 0; mux < e->max; mux++) {
+		for (mux = 0; mux < e->items; mux++) {
 			if (val == e->values[mux])
 				break;
 		}
@@ -3120,13 +3120,13 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_update update;
 	int ret = 0;
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 	mux = ucontrol->value.enumerated.item[0];
 	val = e->values[ucontrol->value.enumerated.item[0]] << e->shift_l;
 	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] >= e->items)
 			return -EINVAL;
 		val |= e->values[ucontrol->value.enumerated.item[1]] << e->shift_r;
 		mask |= e->mask << e->shift_r;
-- 
1.8.5.2
