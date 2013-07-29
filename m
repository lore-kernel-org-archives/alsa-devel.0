From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/10] ASoC: dapm: Move snd_soc_dapm_update
	from dapm context to card
Date: Mon, 29 Jul 2013 17:13:55 +0200
Message-ID: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 701BA261B21
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 17:13:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The update field of a DAPM context is only assigned while the card's dapm_mutex
is locked, the field is also cleared again while the mutex is stil locked. So
there will only ever be one DAPM context at a time with a non-NULL update field.
So it is safe to move the update field from the DAPM context struct to the card
struct. Doing so will allow further cleanups in this area.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  2 --
 include/sound/soc.h      |  1 +
 sound/soc/soc-dapm.c     | 22 +++++++++++-----------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e77c6f5..3397292 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -575,8 +575,6 @@ struct snd_soc_dapm_context {
 	struct delayed_work delayed_work;
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 
-	struct snd_soc_dapm_update *update;
-
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
 
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6eabee7..b1e1f96 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1042,6 +1042,7 @@ struct snd_soc_card {
 	/* Generic DAPM context for the card */
 	struct snd_soc_dapm_context dapm;
 	struct snd_soc_dapm_stats dapm_stats;
+	struct snd_soc_dapm_update *update;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 366daef..7449e27 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1425,7 +1425,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 
 static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_update *update = dapm->update;
+	struct snd_soc_dapm_update *update = dapm->card->update;
 	struct snd_soc_dapm_widget_list *wlist;
 	struct snd_soc_dapm_widget *w = NULL;
 	unsigned int wi;
@@ -1959,9 +1959,9 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
 	int ret;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	dapm->update = update;
+	card->update = update;
 	ret = soc_dapm_mux_update_power(dapm, kcontrol, mux, e);
-	dapm->update = NULL;
+	card->update = NULL;
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
 		soc_dpcm_runtime_update(card);
@@ -2002,9 +2002,9 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 	int ret;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	dapm->update = update;
+	card->update = update;
 	ret = soc_dapm_mixer_update_power(dapm, kcontrol, connect);
-	dapm->update = NULL;
+	card->update = NULL;
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
 		soc_dpcm_runtime_update(card);
@@ -2693,11 +2693,11 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		update.mask = mask;
 		update.val = val;
 
-		widget->dapm->update = &update;
+		card->update = &update;
 
 		soc_dapm_mixer_update_power(widget->dapm, kcontrol, connect);
 
-		widget->dapm->update = NULL;
+		card->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
@@ -2775,11 +2775,11 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		update.reg = e->reg;
 		update.mask = mask;
 		update.val = val;
-		widget->dapm->update = &update;
+		card->update = &update;
 
 		soc_dapm_mux_update_power(widget->dapm, kcontrol, mux, e);
 
-		widget->dapm->update = NULL;
+		card->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
@@ -2928,11 +2928,11 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		update.reg = e->reg;
 		update.mask = mask;
 		update.val = val;
-		widget->dapm->update = &update;
+		card->update = &update;
 
 		soc_dapm_mux_update_power(widget->dapm, kcontrol, mux, e);
 
-		widget->dapm->update = NULL;
+		card->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
-- 
1.8.0
