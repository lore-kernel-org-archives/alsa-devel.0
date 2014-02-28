From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 03/11] ASoC: dapm: Consolidate MUXs and
	value MUXs
Date: Fri, 28 Feb 2014 08:31:04 +0100
Message-ID: <1393572672-13937-4-git-send-email-lars@metafoo.de>
References: <1393572672-13937-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 39666265703
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 08:30:53 +0100 (CET)
In-Reply-To: <1393572672-13937-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

MUXs and value MUXs are almost identical, the only difference is that a value
MUX uses a look-up table to map from the selected control item to a register
value, while MUXs use a direct mapping. This patch uses
snd_soc_enum_item_to_val() and snd_soc_enum_val_to_item(), which where earlier
introduced during the consolidation of enum and value enum controls, to hide
this difference. This allows us to use the same code path for both MUXs and
value MUXs and a lot of nearly duplicated code can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v1
---
 include/sound/soc-dapm.h |  15 +----
 sound/soc/soc-dapm.c     | 157 ++++++-----------------------------------------
 2 files changed, 21 insertions(+), 151 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3b99176..2ec14cb 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -112,9 +112,7 @@ struct device;
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_VALUE_MUX(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_value_mux, .name = wname, \
-	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
-	.kcontrol_news = wcontrols, .num_kcontrols = 1}
+	SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols)
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_ARRAY(wname, wreg, wshift, winvert,\
@@ -324,11 +322,7 @@ struct device;
 	.put = xput, \
 	.private_value = (unsigned long)&xenum }
 #define SOC_DAPM_VALUE_ENUM(xname, xenum) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_enum_double, \
-	.get = snd_soc_dapm_get_value_enum_double, \
-	.put = snd_soc_dapm_put_value_enum_double, \
-	.private_value = (unsigned long)&xenum }
+	SOC_DAPM_ENUM(xname, xenum)
 #define SOC_DAPM_PIN_SWITCH(xname) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname " Switch", \
 	.info = snd_soc_dapm_info_pin_switch, \
@@ -396,10 +390,6 @@ int snd_soc_dapm_get_enum_virt(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_info_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
@@ -486,7 +476,6 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_output,		/* output pin */
 	snd_soc_dapm_mux,			/* selects 1 analog signal from many inputs */
 	snd_soc_dapm_virt_mux,			/* virtual version of snd_soc_dapm_mux */
-	snd_soc_dapm_value_mux,			/* selects 1 analog signal from many inputs */
 	snd_soc_dapm_mixer,			/* mixes several analog signals together */
 	snd_soc_dapm_mixer_named_ctl,		/* mixer with named controls */
 	snd_soc_dapm_pga,			/* programmable gain/attenuation (volume) */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 96a97a3df..f23eeee 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -71,7 +71,6 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_mic] = 5,
 	[snd_soc_dapm_mux] = 6,
 	[snd_soc_dapm_virt_mux] = 6,
-	[snd_soc_dapm_value_mux] = 6,
 	[snd_soc_dapm_dac] = 7,
 	[snd_soc_dapm_switch] = 8,
 	[snd_soc_dapm_mixer] = 8,
@@ -103,7 +102,6 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_micbias] = 8,
 	[snd_soc_dapm_mux] = 9,
 	[snd_soc_dapm_virt_mux] = 9,
-	[snd_soc_dapm_value_mux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
 	[snd_soc_dapm_dai_in] = 10,
@@ -534,7 +532,8 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		unsigned int val, item;
 
 		soc_widget_read(w, e->reg, &val);
-		item = (val >> e->shift_l) & e->mask;
+		val = (val >> e->shift_l) & e->mask;
+		item = snd_soc_enum_val_to_item(e, val);
 
 		if (item < e->items && !strcmp(p->name, e->texts[item]))
 			p->connect = 1;
@@ -557,24 +556,6 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 			p->connect = 1;
 	}
 	break;
-	case snd_soc_dapm_value_mux: {
-		struct soc_enum *e = (struct soc_enum *)
-			w->kcontrol_news[i].private_value;
-		unsigned int val, item;
-
-		soc_widget_read(w, e->reg, &val);
-		val = (val >> e->shift_l) & e->mask;
-		for (item = 0; item < e->items; item++) {
-			if (val == e->values[item])
-				break;
-		}
-
-		if (item < e->items && !strcmp(p->name, e->texts[item]))
-			p->connect = 1;
-		else
-			p->connect = 0;
-	}
-	break;
 	/* does not affect routing - always connected */
 	case snd_soc_dapm_pga:
 	case snd_soc_dapm_out_drv:
@@ -725,7 +706,6 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 				break;
 			case snd_soc_dapm_mux:
 			case snd_soc_dapm_virt_mux:
-			case snd_soc_dapm_value_mux:
 				wname_in_long_name = true;
 				kcname_in_long_name = false;
 				break;
@@ -2463,7 +2443,6 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 		return 0;
 	case snd_soc_dapm_mux:
 	case snd_soc_dapm_virt_mux:
-	case snd_soc_dapm_value_mux:
 		ret = dapm_connect_mux(dapm, wsource, wsink, path, control,
 			&wsink->kcontrol_news[0]);
 		if (ret != 0)
@@ -2791,7 +2770,6 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 			break;
 		case snd_soc_dapm_mux:
 		case snd_soc_dapm_virt_mux:
-		case snd_soc_dapm_value_mux:
 			dapm_new_mux(w);
 			break;
 		case snd_soc_dapm_pga:
@@ -2953,13 +2931,16 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int val;
+	unsigned int reg_val, val;
 
-	val = snd_soc_read(codec, e->reg);
-	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & e->mask;
-	if (e->shift_l != e->shift_r)
-		ucontrol->value.enumerated.item[1] =
-			(val >> e->shift_r) & e->mask;
+	reg_val = snd_soc_read(codec, e->reg);
+	val = (reg_val >> e->shift_l) & e->mask;
+	ucontrol->value.enumerated.item[0] = snd_soc_enum_val_to_item(e, val);
+	if (e->shift_l != e->shift_r) {
+		val = (reg_val >> e->shift_r) & e->mask;
+		val = snd_soc_enum_val_to_item(e, val);
+		ucontrol->value.enumerated.item[1] = val;
+	}
 
 	return 0;
 }
@@ -2980,20 +2961,21 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int val, mux, change;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	unsigned int val, change;
 	unsigned int mask;
 	struct snd_soc_dapm_update update;
 	int ret = 0;
 
-	if (ucontrol->value.enumerated.item[0] >= e->items)
+	if (item[0] >= e->items)
 		return -EINVAL;
-	mux = ucontrol->value.enumerated.item[0];
-	val = mux << e->shift_l;
+
+	val = snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
 	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] >= e->items)
+		if (item[1] > e->items)
 			return -EINVAL;
-		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
+		val |= snd_soc_enum_item_to_val(e, item[1]) << e->shift_l;
 		mask |= e->mask << e->shift_r;
 	}
 
@@ -3007,7 +2989,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		update.val = val;
 		card->update = &update;
 
-		ret = soc_dapm_mux_update_power(card, kcontrol, mux, e);
+		ret = soc_dapm_mux_update_power(card, kcontrol, item[0], e);
 
 		card->update = NULL;
 	}
@@ -3074,106 +3056,6 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
 
 /**
- * snd_soc_dapm_get_value_enum_double - dapm semi enumerated double mixer get
- *					callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to get the value of a dapm semi enumerated double mixer control.
- *
- * Semi enumerated mixer: the enumerated items are referred as values. Can be
- * used for handling bitfield coded enumeration for example.
- *
- * Returns 0 for success.
- */
-int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int reg_val, val, mux;
-
-	reg_val = snd_soc_read(codec, e->reg);
-	val = (reg_val >> e->shift_l) & e->mask;
-	for (mux = 0; mux < e->items; mux++) {
-		if (val == e->values[mux])
-			break;
-	}
-	ucontrol->value.enumerated.item[0] = mux;
-	if (e->shift_l != e->shift_r) {
-		val = (reg_val >> e->shift_r) & e->mask;
-		for (mux = 0; mux < e->items; mux++) {
-			if (val == e->values[mux])
-				break;
-		}
-		ucontrol->value.enumerated.item[1] = mux;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dapm_get_value_enum_double);
-
-/**
- * snd_soc_dapm_put_value_enum_double - dapm semi enumerated double mixer set
- *					callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to set the value of a dapm semi enumerated double mixer control.
- *
- * Semi enumerated mixer: the enumerated items are referred as values. Can be
- * used for handling bitfield coded enumeration for example.
- *
- * Returns 0 for success.
- */
-int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct snd_soc_card *card = codec->card;
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int val, mux, change;
-	unsigned int mask;
-	struct snd_soc_dapm_update update;
-	int ret = 0;
-
-	if (ucontrol->value.enumerated.item[0] >= e->items)
-		return -EINVAL;
-	mux = ucontrol->value.enumerated.item[0];
-	val = e->values[ucontrol->value.enumerated.item[0]] << e->shift_l;
-	mask = e->mask << e->shift_l;
-	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] >= e->items)
-			return -EINVAL;
-		val |= e->values[ucontrol->value.enumerated.item[1]] << e->shift_r;
-		mask |= e->mask << e->shift_r;
-	}
-
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-
-	change = snd_soc_test_bits(codec, e->reg, mask, val);
-	if (change) {
-		update.kcontrol = kcontrol;
-		update.reg = e->reg;
-		update.mask = mask;
-		update.val = val;
-		card->update = &update;
-
-		ret = soc_dapm_mux_update_power(card, kcontrol, mux, e);
-
-		card->update = NULL;
-	}
-
-	mutex_unlock(&card->dapm_mutex);
-
-	if (ret > 0)
-		soc_dpcm_runtime_update(card);
-
-	return change;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
-
-/**
  * snd_soc_dapm_info_pin_switch - Info for a pin switch
  *
  * @kcontrol: mixer control
@@ -3302,7 +3184,6 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		break;
 	case snd_soc_dapm_mux:
 	case snd_soc_dapm_virt_mux:
-	case snd_soc_dapm_value_mux:
 		w->power_check = dapm_generic_check_power;
 		break;
 	case snd_soc_dapm_dai_out:
-- 
1.8.0
