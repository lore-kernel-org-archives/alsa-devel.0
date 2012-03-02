From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 3/3] ASoC: dapm - lock mixer & mux update power
	with card mutex.
Date: Fri,  2 Mar 2012 18:11:12 +0000
Message-ID: <1330711872-27436-3-git-send-email-lrg@ti.com>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 537FF104102
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 19:11:28 +0100 (CET)
Received: by wiax18 with SMTP id x18so288646wia.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2012 10:11:25 -0800 (PST)
In-Reply-To: <1330711872-27436-1-git-send-email-lrg@ti.com>
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
be called internally within DAPM core (with card mutex held) and externally.

Provide some wrappers so that external users of both functions do not have to
remeber and hold the card mutex.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index faeb28d..07790b5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1718,7 +1718,7 @@ static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 #endif
 
 /* test and update the power status of a mux widget */
-int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+static int soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
 {
 	struct snd_soc_dapm_path *path;
@@ -1757,10 +1757,22 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 }
+
+int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
+{
+	struct snd_soc_card *card = widget->dapm->card;
+	int ret;
+
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
+	ret = soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+	mutex_unlock(&card->mutex);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
 
 /* test and update the power status of a mixer or switch widget */
-int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+static int soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int connect)
 {
 	struct snd_soc_dapm_path *path;
@@ -1789,6 +1801,18 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 }
+
+int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+				   struct snd_kcontrol *kcontrol, int connect)
+{
+	struct snd_soc_card *card = widget->dapm->card;
+	int ret;
+
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
+	ret = soc_dapm_mixer_update_power(widget, kcontrol, connect);
+	mutex_unlock(&card->mutex);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
 
 /* show dapm widget status in sys fs */
@@ -2378,7 +2402,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			snd_soc_dapm_mixer_update_power(widget, kcontrol, connect);
+			soc_dapm_mixer_update_power(widget, kcontrol, connect);
 
 			widget->dapm->update = NULL;
 		}
@@ -2470,7 +2494,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			snd_soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+			soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 
 			widget->dapm->update = NULL;
 		}
@@ -2532,7 +2556,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 
 			widget->value = ucontrol->value.enumerated.item[0];
 
-			snd_soc_dapm_mux_update_power(widget, kcontrol, widget->value, e);
+			soc_dapm_mux_update_power(widget, kcontrol, widget->value, e);
 		}
 	}
 
@@ -2636,7 +2660,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			widget->dapm->update = &update;
 
-			snd_soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+			soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 
 			widget->dapm->update = NULL;
 		}
-- 
1.7.5.4
