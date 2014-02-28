From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 10/11] ASoC: dapm: Consolidate MUXs and
	virtual MUXs
Date: Fri, 28 Feb 2014 08:31:11 +0100
Message-ID: <1393572672-13937-11-git-send-email-lars@metafoo.de>
References: <1393572672-13937-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id A757A265957
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 08:30:58 +0100 (CET)
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

MUXs and virtual MUXs are almost identical, the only difference is that for
virtual MUX there is no hardware backing register in which setting is stored.
This patch adds code, which is similar to what we already do for DAPM mixer
controls to support virtual mixer controls, to DAPM enum controls. The new code
will check if the enum does a hardware backing register and skip over reading
and writing to the register if it has not.  This allows us to use the same code
path for both MUXs and virtual MUXs and a lot of nearly identical code can be
removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v1
---
 include/sound/soc-dapm.h |  23 +++-------
 sound/soc/soc-dapm.c     | 113 +++++++++++++----------------------------------
 2 files changed, 35 insertions(+), 101 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2ec14cb..04d32d8 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -108,9 +108,7 @@ struct device;
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_VIRT_MUX(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_virt_mux, .name = wname, \
-	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
-	.kcontrol_news = wcontrols, .num_kcontrols = 1}
+	SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols)
 #define SND_SOC_DAPM_VALUE_MUX(wname, wreg, wshift, winvert, wcontrols) \
 	SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols)
 
@@ -170,10 +168,8 @@ struct device;
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_VIRT_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_virt_mux, .name = wname, \
-	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
-	.kcontrol_news = wcontrols, .num_kcontrols = 1, \
-	.event = wevent, .event_flags = wflags}
+	SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, wevent, \
+		wflags)
 
 /* additional sequencing control within an event type */
 #define SND_SOC_DAPM_PGA_S(wname, wsubseq, wreg, wshift, winvert, \
@@ -309,12 +305,8 @@ struct device;
  	.get = snd_soc_dapm_get_enum_double, \
  	.put = snd_soc_dapm_put_enum_double, \
   	.private_value = (unsigned long)&xenum }
-#define SOC_DAPM_ENUM_VIRT(xname, xenum)		    \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_enum_double, \
-	.get = snd_soc_dapm_get_enum_virt, \
-	.put = snd_soc_dapm_put_enum_virt, \
-	.private_value = (unsigned long)&xenum }
+#define SOC_DAPM_ENUM_VIRT(xname, xenum) \
+	SOC_DAPM_ENUM(xname, xenum)
 #define SOC_DAPM_ENUM_EXT(xname, xenum, xget, xput) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
@@ -386,10 +378,6 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_dapm_get_enum_virt(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_info_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
@@ -475,7 +463,6 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
 	snd_soc_dapm_output,		/* output pin */
 	snd_soc_dapm_mux,			/* selects 1 analog signal from many inputs */
-	snd_soc_dapm_virt_mux,			/* virtual version of snd_soc_dapm_mux */
 	snd_soc_dapm_mixer,			/* mixes several analog signals together */
 	snd_soc_dapm_mixer_named_ctl,		/* mixer with named controls */
 	snd_soc_dapm_pga,			/* programmable gain/attenuation (volume) */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f23eeee..c07c7fb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -70,7 +70,6 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_aif_out] = 4,
 	[snd_soc_dapm_mic] = 5,
 	[snd_soc_dapm_mux] = 6,
-	[snd_soc_dapm_virt_mux] = 6,
 	[snd_soc_dapm_dac] = 7,
 	[snd_soc_dapm_switch] = 8,
 	[snd_soc_dapm_mixer] = 8,
@@ -101,7 +100,6 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_mic] = 7,
 	[snd_soc_dapm_micbias] = 8,
 	[snd_soc_dapm_mux] = 9,
-	[snd_soc_dapm_virt_mux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
 	[snd_soc_dapm_dai_in] = 10,
@@ -531,9 +529,19 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 			w->kcontrol_news[i].private_value;
 		unsigned int val, item;
 
-		soc_widget_read(w, e->reg, &val);
-		val = (val >> e->shift_l) & e->mask;
-		item = snd_soc_enum_val_to_item(e, val);
+		if (e->reg != SND_SOC_NOPM) {
+			soc_widget_read(w, e->reg, &val);
+			val = (val >> e->shift_l) & e->mask;
+			item = snd_soc_enum_val_to_item(e, val);
+		} else {
+			/* since a virtual mux has no backing registers to
+			 * decide which path to connect, it will try to match
+			 * with the first enumeration.  This is to ensure
+			 * that the default mux choice (the first) will be
+			 * correctly powered up during initialization.
+			 */
+			item = 0;
+		}
 
 		if (item < e->items && !strcmp(p->name, e->texts[item]))
 			p->connect = 1;
@@ -541,21 +549,6 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 			p->connect = 0;
 	}
 	break;
-	case snd_soc_dapm_virt_mux: {
-		struct soc_enum *e = (struct soc_enum *)
-			w->kcontrol_news[i].private_value;
-
-		p->connect = 0;
-		/* since a virtual mux has no backing registers to
-		 * decide which path to connect, it will try to match
-		 * with the first enumeration.  This is to ensure
-		 * that the default mux choice (the first) will be
-		 * correctly powered up during initialization.
-		 */
-		if (!strcmp(p->name, e->texts[0]))
-			p->connect = 1;
-	}
-	break;
 	/* does not affect routing - always connected */
 	case snd_soc_dapm_pga:
 	case snd_soc_dapm_out_drv:
@@ -705,7 +698,6 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 				kcname_in_long_name = true;
 				break;
 			case snd_soc_dapm_mux:
-			case snd_soc_dapm_virt_mux:
 				wname_in_long_name = true;
 				kcname_in_long_name = false;
 				break;
@@ -2442,7 +2434,6 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 		path->connect = 1;
 		return 0;
 	case snd_soc_dapm_mux:
-	case snd_soc_dapm_virt_mux:
 		ret = dapm_connect_mux(dapm, wsource, wsink, path, control,
 			&wsink->kcontrol_news[0]);
 		if (ret != 0)
@@ -2769,7 +2760,6 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 			dapm_new_mixer(w);
 			break;
 		case snd_soc_dapm_mux:
-		case snd_soc_dapm_virt_mux:
 			dapm_new_mux(w);
 			break;
 		case snd_soc_dapm_pga:
@@ -2933,7 +2923,11 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg_val, val;
 
-	reg_val = snd_soc_read(codec, e->reg);
+	if (e->reg != SND_SOC_NOPM)
+		reg_val = snd_soc_read(codec, e->reg);
+	else
+		reg_val = dapm_kcontrol_get_value(kcontrol);
+
 	val = (reg_val >> e->shift_l) & e->mask;
 	ucontrol->value.enumerated.item[0] = snd_soc_enum_val_to_item(e, val);
 	if (e->shift_l != e->shift_r) {
@@ -2981,13 +2975,19 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	change = snd_soc_test_bits(codec, e->reg, mask, val);
+	if (e->reg != SND_SOC_NOPM)
+		change = snd_soc_test_bits(codec, e->reg, mask, val);
+	else
+		change = dapm_kcontrol_set_value(kcontrol, val);
+
 	if (change) {
-		update.kcontrol = kcontrol;
-		update.reg = e->reg;
-		update.mask = mask;
-		update.val = val;
-		card->update = &update;
+		if (e->reg != SND_SOC_NOPM) {
+			update.kcontrol = kcontrol;
+			update.reg = e->reg;
+			update.mask = mask;
+			update.val = val;
+			card->update = &update;
+		}
 
 		ret = soc_dapm_mux_update_power(card, kcontrol, item[0], e);
 
@@ -3004,58 +3004,6 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
 
 /**
- * snd_soc_dapm_get_enum_virt - Get virtual DAPM mux
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Returns 0 for success.
- */
-int snd_soc_dapm_get_enum_virt(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_value *ucontrol)
-{
-	ucontrol->value.enumerated.item[0] = dapm_kcontrol_get_value(kcontrol);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_virt);
-
-/**
- * snd_soc_dapm_put_enum_virt - Set virtual DAPM mux
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Returns 0 for success.
- */
-int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct snd_soc_card *card = codec->card;
-	unsigned int value;
-	struct soc_enum *e =
-		(struct soc_enum *)kcontrol->private_value;
-	int change;
-	int ret = 0;
-
-	if (ucontrol->value.enumerated.item[0] >= e->items)
-		return -EINVAL;
-
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-
-	value = ucontrol->value.enumerated.item[0];
-	change = dapm_kcontrol_set_value(kcontrol, value);
-	if (change)
-		ret = soc_dapm_mux_update_power(card, kcontrol, value, e);
-
-	mutex_unlock(&card->dapm_mutex);
-
-	if (ret > 0)
-		soc_dpcm_runtime_update(card);
-
-	return change;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
-
-/**
  * snd_soc_dapm_info_pin_switch - Info for a pin switch
  *
  * @kcontrol: mixer control
@@ -3183,7 +3131,6 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		w->power_check = dapm_generic_check_power;
 		break;
 	case snd_soc_dapm_mux:
-	case snd_soc_dapm_virt_mux:
 		w->power_check = dapm_generic_check_power;
 		break;
 	case snd_soc_dapm_dai_out:
-- 
1.8.0
