From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 4/5] ASoC: dapm: Add support for autodisable
	mux controls
Date: Thu, 30 Apr 2015 17:38:31 +0100
Message-ID: <1430411912-6599-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1430411912-6599-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81037260423
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 18:46:34 +0200 (CEST)
In-Reply-To: <1430411912-6599-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Commit 57295073b6ac ("ASoC: dapm: Implement mixer input auto-disable")
added support for autodisable controls, controls whose values are only
written to the hardware when their respective widgets are powered up.
But it only added support for controls based on the mixer abstraction.

This patch add support for mux controls (DAPM controls based on the
enum abstraction) to be auto-disabled as well. As each mux can only have
a single control, there is no need to tie the autodisable widget to the
inputs (as is done for the mixer controls) it can be tided directly to
the mux widget itself.

Note that it is assumed that the first entry in a autodisable mux
control will always represent the off state for the mux and is what the
mux will be set to whilst it is disabled.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   10 ++++++++
 sound/soc/soc-dapm.c |   62 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 45cfd69..28b8ae6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -192,6 +192,10 @@
 	.mask = xmask, .items = xitems, .texts = xtexts, .values = xvalues}
 #define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xitems, xtexts, xvalues) \
 	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xitems, xtexts, xvalues)
+#define SOC_VALUE_ENUM_SINGLE_AUTODISABLE(xreg, xshift, xmask, xitems, xtexts, xvalues) \
+{	.reg = xreg, .shift_l = xshift, .shift_r = xshift, \
+	.mask = xmask, .items = xitems, .texts = xtexts, \
+	.values = xvalues, .autodisable = 1}
 #define SOC_ENUM_SINGLE_VIRT(xitems, xtexts) \
 	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, xitems, xtexts)
 #define SOC_ENUM(xname, xenum) \
@@ -312,6 +316,11 @@
 							ARRAY_SIZE(xtexts), xtexts, xvalues)
 #define SOC_VALUE_ENUM_SINGLE_DECL(name, xreg, xshift, xmask, xtexts, xvalues) \
 	SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
+
+#define SOC_VALUE_ENUM_SINGLE_AUTODISABLE_DECL(name, xreg, xshift, xmask, xtexts, xvalues) \
+	const struct soc_enum name = SOC_VALUE_ENUM_SINGLE_AUTODISABLE(xreg, \
+		xshift, xmask, ARRAY_SIZE(xtexts), xtexts, xvalues)
+
 #define SOC_ENUM_SINGLE_VIRT_DECL(name, xtexts) \
 	const struct soc_enum name = SOC_ENUM_SINGLE_VIRT(ARRAY_SIZE(xtexts), xtexts)
 
@@ -1200,6 +1209,7 @@ struct soc_enum {
 	unsigned int mask;
 	const char * const *texts;
 	const unsigned int *values;
+	unsigned int autodisable:1;
 };
 
 /**
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e557018..1c53ba3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -308,6 +308,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 {
 	struct dapm_kcontrol_data *data;
 	struct soc_mixer_control *mc;
+	struct soc_enum *e;
 	const char *name;
 	int ret;
 
@@ -354,6 +355,34 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 			}
 		}
 		break;
+	case snd_soc_dapm_mux:
+		e = (struct soc_enum *)kcontrol->private_value;
+
+		if (e->autodisable) {
+			struct snd_soc_dapm_widget template;
+
+			memset(&template, 0, sizeof(template));
+			template.reg = e->reg;
+			template.mask = e->mask << e->shift_l;
+			template.shift = e->shift_l;
+			template.off_val = e->values[0];
+			template.on_val = template.off_val;
+			template.id = snd_soc_dapm_kcontrol;
+			template.name = name;
+
+			data->value = template.on_val;
+
+			data->widget = snd_soc_dapm_new_control(widget->dapm,
+					&template);
+			if (!data->widget) {
+				ret = -ENOMEM;
+				goto err_name;
+			}
+
+			snd_soc_dapm_add_path(widget->dapm, data->widget,
+					      widget, NULL, NULL);
+		}
+		break;
 	default:
 		break;
 	}
@@ -417,11 +446,6 @@ static void dapm_kcontrol_add_path(const struct snd_kcontrol *kcontrol,
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
 
 	list_add_tail(&path->list_kcontrol, &data->paths);
-
-	if (data->widget) {
-		snd_soc_dapm_add_path(data->widget->dapm, data->widget,
-		    path->source, NULL, NULL);
-	}
 }
 
 static bool dapm_kcontrol_is_powered(const struct snd_kcontrol *kcontrol)
@@ -819,6 +843,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 {
 	int i, ret;
 	struct snd_soc_dapm_path *path;
+	struct dapm_kcontrol_data *data;
 
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
@@ -828,16 +853,20 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 			if (path->name != (char *)w->kcontrol_news[i].name)
 				continue;
 
-			if (w->kcontrols[i]) {
-				dapm_kcontrol_add_path(w->kcontrols[i], path);
-				continue;
+			if (!w->kcontrols[i]) {
+				ret = dapm_create_or_share_mixmux_kcontrol(w, i);
+				if (ret < 0)
+					return ret;
 			}
 
-			ret = dapm_create_or_share_mixmux_kcontrol(w, i);
-			if (ret < 0)
-				return ret;
-
 			dapm_kcontrol_add_path(w->kcontrols[i], path);
+
+			data = snd_kcontrol_chip(w->kcontrols[i]);
+			if (data->widget)
+				snd_soc_dapm_add_path(data->widget->dapm,
+						      data->widget,
+						      path->source,
+						      NULL, NULL);
 		}
 	}
 
@@ -2944,16 +2973,19 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_card *card = dapm->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg_val, val;
 
-	if (e->reg != SND_SOC_NOPM) {
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	if (e->reg != SND_SOC_NOPM && dapm_kcontrol_is_powered(kcontrol)) {
 		int ret = soc_dapm_read(dapm, e->reg, &reg_val);
 		if (ret)
 			return ret;
 	} else {
 		reg_val = dapm_kcontrol_get_value(kcontrol);
 	}
+	mutex_unlock(&card->dapm_mutex);
 
 	val = (reg_val >> e->shift_l) & e->mask;
 	ucontrol->value.enumerated.item[0] = snd_soc_enum_val_to_item(e, val);
@@ -3002,10 +3034,10 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
+	change = dapm_kcontrol_set_value(kcontrol, val);
+
 	if (e->reg != SND_SOC_NOPM)
 		change = soc_dapm_test_bits(dapm, e->reg, mask, val);
-	else
-		change = dapm_kcontrol_set_value(kcontrol, val);
 
 	if (change) {
 		if (e->reg != SND_SOC_NOPM) {
-- 
1.7.2.5
