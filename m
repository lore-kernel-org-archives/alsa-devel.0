From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH v2] ASoC: DAPM - Export
	mixer|mux_update_power() to public API.
Date: Mon,  6 Feb 2012 16:05:14 +0000
Message-ID: <1328544314-10552-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E072103A58
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 17:05:24 +0100 (CET)
Received: by wibhq7 with SMTP id hq7so4579723wib.6
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 08:05:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Allow for the operation of custom mixer and mux DAPM widgets that can call
snd_soc_dapm_mixer_update_power() and snd_soc_dapm_mux_update_power() directly
after updating their status. This is useful with complex DAPM Mixer operations
where we need to do additional work in addition to setting a few mixer register
bits.

Changes since V1:-
 o Remove the unused "change" flag parameter from snd_soc_dapm_mux_update_power().

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    6 ++++++
 sound/soc/soc-dapm.c     |   21 +++++++++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d26a9b7..7794737 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -365,6 +365,12 @@ int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
 	const char *stream, int event);
 void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
+/* external DAPM widget events */
+int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+		struct snd_kcontrol *kcontrol, int connect);
+int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e);
+
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3ad1f59..e2a9797 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1659,9 +1659,8 @@ static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 #endif
 
 /* test and update the power status of a mux widget */
-static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
-				 struct snd_kcontrol *kcontrol, int change,
-				 int mux, struct soc_enum *e)
+int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
@@ -1671,9 +1670,6 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	    widget->id != snd_soc_dapm_value_mux)
 		return -ENODEV;
 
-	if (!change)
-		return 0;
-
 	/* find dapm widget path assoc with kcontrol */
 	list_for_each_entry(path, &widget->dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
@@ -1702,9 +1698,10 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
 
 /* test and update the power status of a mixer or switch widget */
-static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int connect)
 {
 	struct snd_soc_dapm_path *path;
@@ -1733,6 +1730,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
 
 /* show dapm widget status in sys fs */
 static ssize_t dapm_widget_show(struct device *dev,
@@ -2315,7 +2313,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			dapm_mixer_update_power(widget, kcontrol, connect);
+			snd_soc_dapm_mixer_update_power(widget, kcontrol, connect);
 
 			widget->dapm->update = NULL;
 		}
@@ -2406,7 +2404,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			dapm_mux_update_power(widget, kcontrol, change, mux, e);
+			snd_soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 
 			widget->dapm->update = NULL;
 		}
@@ -2467,8 +2465,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 
 			widget->value = ucontrol->value.enumerated.item[0];
 
-			dapm_mux_update_power(widget, kcontrol, change,
-					      widget->value, e);
+			snd_soc_dapm_mux_update_power(widget, kcontrol, widget->value, e);
 		}
 	}
 
@@ -2571,7 +2568,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			dapm_mux_update_power(widget, kcontrol, change, mux, e);
+			snd_soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 
 			widget->dapm->update = NULL;
 		}
-- 
1.7.5.4
