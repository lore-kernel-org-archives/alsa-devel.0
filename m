From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH] ASoC:topology:bug fix:check return value avoid
	oops.
Date: Fri, 21 Sep 2018 16:57:37 +0200
Message-ID: <20180921145737.GC28693@kadasd710.ka.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id AD8612676A7
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 16:57:44 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Wu Zhigang <zhigang.wu@linux.intel.com>

check the return value to free the kcontrols instance
to avoid oops caused by the pointer dereference.

Signed-off-by: Wu Zhigang <zhigang.wu@linux.intel.com>
[guennadi.liakhovetski@linux.intel.com add handling of .autodisable=1 cases]
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/soc-dapm.c | 99 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7e96793050c9..8dc31a7a42fd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2402,12 +2402,11 @@ static void dapm_free_path(struct snd_soc_dapm_path *path)
 	kfree(path);
 }
 
-void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
+static void snd_soc_dapm_free_widget_data(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_path *p, *next_p;
 	enum snd_soc_dapm_direction dir;
 
-	list_del(&w->list);
 	/*
 	 * remove source and sink paths associated to this widget.
 	 * While removing the path, remove reference to it from both
@@ -2420,6 +2419,12 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 
 	kfree(w->kcontrols);
 	kfree_const(w->name);
+}
+
+void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
+{
+	list_del(&w->list);
+	snd_soc_dapm_free_widget_data(w);
 	kfree(w);
 }
 
@@ -3038,11 +3043,16 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_weak_routes);
  */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 {
-	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget *w, *last;
 	unsigned int val;
+	int ret = 0;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 
+	/*
+	 * widgets with the snd_soc_dapm_kcontrol ID and .num_controls = 0 can
+	 * be appended to the list while scanning it, this is safe.
+	 */
 	list_for_each_entry(w, &card->widgets, list)
 	{
 		if (w->new)
@@ -3053,8 +3063,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 						sizeof(struct snd_kcontrol *),
 						GFP_KERNEL);
 			if (!w->kcontrols) {
-				mutex_unlock(&card->dapm_mutex);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto out_free;
 			}
 		}
 
@@ -3062,23 +3072,29 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 		case snd_soc_dapm_switch:
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
-			dapm_new_mixer(w);
+			ret = dapm_new_mixer(w);
 			break;
 		case snd_soc_dapm_mux:
 		case snd_soc_dapm_demux:
-			dapm_new_mux(w);
+			ret = dapm_new_mux(w);
 			break;
 		case snd_soc_dapm_pga:
 		case snd_soc_dapm_out_drv:
-			dapm_new_pga(w);
+			ret = dapm_new_pga(w);
 			break;
 		case snd_soc_dapm_dai_link:
-			dapm_new_dai_link(w);
+			ret = dapm_new_dai_link(w);
 			break;
 		default:
 			break;
 		}
 
+		if (ret < 0) {
+			kfree(w->kcontrols);
+			w->kcontrols = NULL;
+			goto out_free;
+		}
+
 		/* Read the initial power state from the device */
 		if (w->reg >= 0) {
 			soc_dapm_read(w->dapm, w->reg, &val);
@@ -3087,6 +3103,11 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 			if (val == w->on_val)
 				w->power = 1;
 		}
+	}
+
+	list_for_each_entry(w, &card->widgets, list) {
+		if (w->new)
+			continue;
 
 		w->new = 1;
 
@@ -3097,6 +3118,66 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 	dapm_power_widgets(card, SND_SOC_DAPM_STREAM_NOP);
 	mutex_unlock(&card->dapm_mutex);
 	return 0;
+
+out_free:
+	last = w;
+
+	/*
+	 * If any new widgets have been created above for .autodisable = 1
+	 * controls, they are also on this list, but at its very end. We're
+	 * processing an error case, so the loop above was interrupted before
+	 * reaching dynamically added widgets, since the latter cannot fail -
+	 * their .num_controls = 0, so allocation cannot fail, and their type is
+	 * snd_soc_dapm_kcontrol, those cannot fail either. Therefore "last"
+	 * points to a widget before the first dynamic one.
+	 */
+	list_for_each_entry(w, &card->widgets, list) {
+		unsigned int i;
+
+		if (w->new)
+			continue;
+
+		if (w == last)
+			break;
+
+		switch (w->id) {
+		case snd_soc_dapm_switch:
+		case snd_soc_dapm_mixer:
+		case snd_soc_dapm_mixer_named_ctl:
+			for (i = 0; i < w->num_kcontrols; i++) {
+				struct snd_kcontrol *kcontrol = w->kcontrols[i];
+				struct dapm_kcontrol_data *data =
+					kcontrol->private_data;
+				struct soc_mixer_control *mc =
+					(struct soc_mixer_control *)
+					kcontrol->private_value;
+
+				if (mc->autodisable)
+					snd_soc_dapm_free_widget(data->widget);
+			}
+			break;
+		case snd_soc_dapm_demux:
+		case snd_soc_dapm_mux:
+			for (i = 0; i < w->num_kcontrols; i++) {
+				struct snd_kcontrol *kcontrol = w->kcontrols[i];
+				struct dapm_kcontrol_data *data =
+					kcontrol->private_data;
+				struct soc_enum *e = (struct soc_enum *)
+					kcontrol->private_value;
+
+				if (e->autodisable)
+					snd_soc_dapm_free_widget(data->widget);
+			}
+			break;
+		default:
+			break;
+		}
+
+		snd_soc_dapm_free_widget_data(w);
+	}
+
+	mutex_unlock(&card->dapm_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
 
-- 
2.17.1
