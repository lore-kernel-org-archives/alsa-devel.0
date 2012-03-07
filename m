From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 3/3] ASoC: dapm: lock mixer & mux update power
	with DAPM mutex.
Date: Wed,  7 Mar 2012 10:38:27 +0000
Message-ID: <1331116707-10016-3-git-send-email-lrg@ti.com>
References: <1331116707-10016-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F1C81045B8
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 11:38:37 +0100 (CET)
Received: by wibhm9 with SMTP id hm9so4213647wib.11
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 02:38:35 -0800 (PST)
In-Reply-To: <1331116707-10016-1-git-send-email-lrg@ti.com>
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

Both snd_soc_dapm_mux_update_power() and snd_soc_dapm_mixer_update_power() can
be called internally within DAPM core (with DAPM mutex held) and externally.

Provide some wrappers so that external users of both functions do not have to
remeber and hold the DAPM mutex.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5beaa3e..5c83b83 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1741,7 +1741,7 @@ static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 #endif
 
 /* test and update the power status of a mux widget */
-int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+static int soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
 {
 	struct snd_soc_dapm_path *path;
@@ -1780,10 +1780,22 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 }
+
+int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+		struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
+{
+	struct snd_soc_card *card = widget->dapm->card;
+	int ret;
+
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	ret = soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+	mutex_unlock(&card->dapm_mutex);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
 
 /* test and update the power status of a mixer or switch widget */
-int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+static int soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int connect)
 {
 	struct snd_soc_dapm_path *path;
@@ -1812,6 +1824,18 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 }
+
+int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+				struct snd_kcontrol *kcontrol, int connect)
+{
+	struct snd_soc_card *card = widget->dapm->card;
+	int ret;
+
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	ret = soc_dapm_mixer_update_power(widget, kcontrol, connect);
+	mutex_unlock(&card->dapm_mutex);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
 
 /* show dapm widget status in sys fs */
@@ -2415,7 +2439,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			snd_soc_dapm_mixer_update_power(widget, kcontrol, connect);
+			soc_dapm_mixer_update_power(widget, kcontrol, connect);
 
 			widget->dapm->update = NULL;
 		}
@@ -2507,7 +2531,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			snd_soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+			soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 
 			widget->dapm->update = NULL;
 		}
@@ -2569,7 +2593,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 
 			widget->value = ucontrol->value.enumerated.item[0];
 
-			snd_soc_dapm_mux_update_power(widget, kcontrol, widget->value, e);
+			soc_dapm_mux_update_power(widget, kcontrol, widget->value, e);
 		}
 	}
 
@@ -2673,7 +2697,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			snd_soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+			soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 
 			widget->dapm->update = NULL;
 		}
-- 
1.7.5.4
