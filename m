From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Ensure bypass paths are suspended
	and resumed
Date: Fri, 31 Aug 2012 17:41:09 -0700
Message-ID: <1346460069-27418-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E36D265E1C
 for <alsa-devel@alsa-project.org>; Sat,  1 Sep 2012 02:41:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since bypass paths aren't part of DAPM streams and we may not have any
DAPM streams there may not be anything that triggers a DAPM sync for
them. Mark all input and output widgets as dirty and then sync to do so
at the end of suspend and resume.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-core.c     |    8 ++++++++
 sound/soc/soc-dapm.c     |   22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index abe373d..5b584cb 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -412,6 +412,7 @@ void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec);
 
 /* Mostly internal - should not normally be used */
 void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason);
+void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm);
 
 /* dapm path query */
 int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 01ec2d6..3be2e40 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -609,6 +609,10 @@ int snd_soc_suspend(struct device *dev)
 					  SND_SOC_DAPM_STREAM_SUSPEND);
 	}
 
+	/* Recheck all analogue paths too */
+	dapm_mark_io_dirty(&card->dapm);
+	snd_soc_dapm_sync(&card->dapm);
+
 	/* suspend all CODECs */
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
 		/* If there are paths active then the CODEC will be held with
@@ -756,6 +760,10 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	/* userspace can access us now we are back as we were before */
 	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D0);
+
+	/* Recheck all analogue paths too */
+	dapm_mark_io_dirty(&card->dapm);
+	snd_soc_dapm_sync(&card->dapm);
 }
 
 /* powers up audio subsystem after a suspend */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 53f69b5..fd97dd7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -141,6 +141,28 @@ void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 }
 EXPORT_SYMBOL_GPL(dapm_mark_dirty);
 
+void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm)
+{
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dapm_widget *w;
+
+	mutex_lock(&card->dapm_mutex);
+
+	list_for_each_entry(w, &card->widgets, list) {
+		switch (w->id) {
+		case snd_soc_dapm_input:
+		case snd_soc_dapm_output:
+			dapm_mark_dirty(w, "Rechecking inputs and outputs");
+			break;
+		default:
+			break;
+		}
+	}
+
+	mutex_unlock(&card->dapm_mutex);
+}
+EXPORT_SYMBOL_GPL(dapm_mark_io_dirty);
+
 /* create a new dapm widget */
 static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	const struct snd_soc_dapm_widget *_widget)
-- 
1.7.10.4
