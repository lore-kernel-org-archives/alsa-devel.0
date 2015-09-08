From: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: add kcontrol to switch regulator to regulated/bypass state
Date: Tue,  8 Sep 2015 11:14:09 +0100
Message-ID: <1441707249-11259-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Nikesh.Oswal@cirrus.com
List-Id: alsa-devel@alsa-project.org

When regulator is defined with SND_SOC_DAPM_REGULATOR_CONTROL_BYPASS
flag, then a kcontrol will be created which can be used to switch
regulator to regulated/bypass state. This will help to control the
behaviour of the regulator based on a usecase. For example voice call
may need a regulated voltage to acheive higher quality whereas voice
trigger may need bypass voltage so as to save on power.

Signed-off-by: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    7 +-
 sound/soc/soc-dapm.c     |  177 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 15717b4..778b847 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -343,7 +343,12 @@ struct device;
 	(e & (SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD))
 
 /* regulator widget flags */
-#define SND_SOC_DAPM_REGULATOR_BYPASS     0x1     /* bypass when disabled */
+/* bypass when disabled and regulated when enabled */
+#define SND_SOC_DAPM_REGULATOR_BYPASS		0x1
+/* bypass when disabled and regulated when enable by default and a
+   kcontrol is created to explicitly switch between bypass/regulated */
+#define SND_SOC_DAPM_REGULATOR_CONTROL_BYPASS \
+	(SND_SOC_DAPM_REGULATOR_BYPASS | 0x2)
 
 struct snd_soc_dapm_widget;
 enum snd_soc_dapm_type;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 36ab9cb..2d77eb9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -965,6 +965,180 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 	return 0;
 }
 
+static int snd_soc_dapm_regulator_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget_list *wlist =
+		dapm_kcontrol_get_wlist(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_card *card = widget->dapm->card;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	unsigned int new_val, val;
+	int ret;
+	bool bypass;
+
+	if (item[0] >= e->items)
+		return -EINVAL;
+
+	val = dapm_kcontrol_get_value(kcontrol);
+	new_val = item[0] == 0 ? SND_SOC_DAPM_REGULATOR_BYPASS : 0;
+	bypass = new_val == SND_SOC_DAPM_REGULATOR_BYPASS ? false : true;
+
+	if (new_val != val) {
+		mutex_lock_nested(&card->dapm_mutex,
+				  SND_SOC_DAPM_CLASS_RUNTIME);
+		if (regulator_is_enabled(widget->regulator)) {
+			ret = regulator_allow_bypass(widget->regulator, bypass);
+			if (ret != 0)
+				dev_warn(widget->dapm->dev,
+					"ASoC: Failed to change bypass %s: %d\n",
+					widget->name, ret);
+		}
+		dapm_kcontrol_set_value(kcontrol, new_val);
+		widget->on_val = new_val;
+		mutex_unlock(&card->dapm_mutex);
+	}
+
+	return 0;
+}
+
+static int snd_soc_dapm_regulator_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	unsigned int val;
+
+	val = dapm_kcontrol_get_value(kcontrol);
+
+	if (val == SND_SOC_DAPM_REGULATOR_BYPASS)
+		ucontrol->value.enumerated.item[0] = 0;
+	else
+		ucontrol->value.enumerated.item[0] = 1;
+
+	return 0;
+}
+
+static const char * const dapm_regulator_texts[] = {
+	"Regulated",
+	"Bypass",
+};
+
+/* create new dapm regulator control */
+static int dapm_new_regulator(struct snd_soc_dapm_widget *w)
+{
+	int ret = 0;
+	struct snd_soc_card *card = w->dapm->card;
+	unsigned long private_value;
+	struct snd_kcontrol *kcontrol;
+	struct snd_soc_dapm_path *path;
+	struct soc_enum regulator_enum[] = {
+		SOC_ENUM_SINGLE_VIRT(ARRAY_SIZE(dapm_regulator_texts),
+			dapm_regulator_texts),
+	};
+	struct snd_kcontrol_new kcontrol_regulator[] = {
+		SOC_ENUM_EXT(NULL, regulator_enum[0],
+			snd_soc_dapm_regulator_get,
+			snd_soc_dapm_regulator_put),
+	};
+
+
+	/* kcontrol creation is done only if client requests it */
+	if (w->on_val != SND_SOC_DAPM_REGULATOR_CONTROL_BYPASS)
+		return 0;
+
+
+	/* create a kcontrol only if somebody is sourcing
+	   from this regulator widget */
+	if (list_empty(&w->edges[SND_SOC_DAPM_DIR_IN])) {
+		dev_err(w->dapm->dev, "ASoC: %s has no sinks\n", w->name);
+		return -EINVAL;
+	}
+
+	w->num_kcontrols = 1;
+
+	private_value = (unsigned long) devm_kmemdup(card->dev,
+			(void *)(kcontrol_regulator[0].private_value),
+			sizeof(struct soc_enum), GFP_KERNEL);
+	if (!private_value) {
+		dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
+			w->name);
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	kcontrol_regulator[0].private_value = private_value;
+
+	w->kcontrol_news = devm_kmemdup(card->dev, &kcontrol_regulator[0],
+		sizeof(struct snd_kcontrol_new), GFP_KERNEL);
+	if (!(w->kcontrol_news)) {
+		dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
+			w->name);
+		ret = -ENOMEM;
+		goto err_private;
+	}
+
+
+	kcontrol = snd_soc_cnew(&w->kcontrol_news[0], NULL,
+		w->name, NULL);
+
+	if (!kcontrol) {
+		ret = -ENOMEM;
+		goto err_kcontrol_news;
+	}
+
+	kcontrol->private_free = dapm_kcontrol_free;
+
+	ret = dapm_kcontrol_data_alloc(w, kcontrol);
+	if (ret)
+		goto err_kcontrol;
+
+
+	ret = snd_ctl_add(card->snd_card, kcontrol);
+	if (ret < 0) {
+		dev_err(w->dapm->dev,
+			"ASoC: failed to add widget %s dapm kcontrol %s: %d\n",
+			w->name, w->kcontrol_news[0].name, ret);
+		goto err_kcontrol;
+	}
+
+	ret = dapm_kcontrol_add_widget(kcontrol, w);
+	if (ret)
+		goto err_kcontrol;
+
+
+	/* change on_val to remove the kcontrol creation bit
+	   as kcontrol is already created */
+	w->on_val = SND_SOC_DAPM_REGULATOR_BYPASS;
+	/* update the kcontrol value to reflect the initial value */
+	dapm_kcontrol_set_value(kcontrol, w->on_val);
+
+	w->kcontrols = kzalloc(w->num_kcontrols *
+				sizeof(struct snd_kcontrol *),
+				GFP_KERNEL);
+	if (!w->kcontrols) {
+		ret = -ENOMEM;
+		goto err_kcontrol;
+	}
+
+	w->kcontrols[0] = kcontrol;
+
+	snd_soc_dapm_widget_for_each_path(w, SND_SOC_DAPM_DIR_IN, path) {
+		if (path->name)
+			dapm_kcontrol_add_path(w->kcontrols[0], path);
+	}
+
+	return 0;
+
+err_kcontrol:
+	snd_ctl_free_one(kcontrol);
+err_kcontrol_news:
+	devm_kfree(card->dev, (void *)w->kcontrol_news);
+err_private:
+	devm_kfree(card->dev, (void *)private_value);
+err_out:
+	return ret;
+}
+
 /* create new dapm volume control */
 static int dapm_new_pga(struct snd_soc_dapm_widget *w)
 {
@@ -2922,6 +3096,9 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 		case snd_soc_dapm_dai_link:
 			dapm_new_dai_link(w);
 			break;
+		case snd_soc_dapm_regulator_supply:
+			dapm_new_regulator(w);
+			break;
 		default:
 			break;
 		}
-- 
1.7.9.5
