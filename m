From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: DAPM - Export mixer|mux_update_power()
	to public API.
Date: Mon,  6 Feb 2012 13:32:15 +0000
Message-ID: <1328535135-8765-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id D77F3103ACF
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 14:32:28 +0100 (CET)
Received: by mail-wi0-f177.google.com with SMTP id o1so5833580wic.8
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 05:32:25 -0800 (PST)
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

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    7 +++++++
 sound/soc/soc-dapm.c     |   16 +++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d26a9b7..4f12faa 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -365,6 +365,13 @@ int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
 	const char *stream, int event);
 void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
+/* external DAPM widget events */
+int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+		struct snd_kcontrol *kcontrol, int connect);
+int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+				 struct snd_kcontrol *kcontrol, int change,
+				 int mux, struct soc_enum *e);
+
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3ad1f59..49b944a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1659,7 +1659,7 @@ static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 #endif
 
 /* test and update the power status of a mux widget */
-static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 				 struct snd_kcontrol *kcontrol, int change,
 				 int mux, struct soc_enum *e)
 {
@@ -1702,9 +1702,10 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
 
 /* test and update the power status of a mixer or switch widget */
-static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int connect)
 {
 	struct snd_soc_dapm_path *path;
@@ -1733,6 +1734,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
 
 /* show dapm widget status in sys fs */
 static ssize_t dapm_widget_show(struct device *dev,
@@ -2315,7 +2317,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			dapm_mixer_update_power(widget, kcontrol, connect);
+			snd_soc_dapm_mixer_update_power(widget, kcontrol, connect);
 
 			widget->dapm->update = NULL;
 		}
@@ -2406,7 +2408,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			dapm_mux_update_power(widget, kcontrol, change, mux, e);
+			snd_soc_dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
 			widget->dapm->update = NULL;
 		}
@@ -2467,8 +2469,8 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 
 			widget->value = ucontrol->value.enumerated.item[0];
 
-			dapm_mux_update_power(widget, kcontrol, change,
-					      widget->value, e);
+			snd_soc_dapm_mux_update_power(widget, kcontrol, change,
+					widget->value, e);
 		}
 	}
 
@@ -2571,7 +2573,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			dapm_mux_update_power(widget, kcontrol, change, mux, e);
+			snd_soc_dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
 			widget->dapm->update = NULL;
 		}
-- 
1.7.5.4
