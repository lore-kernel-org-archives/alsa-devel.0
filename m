From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 4/7] ASoC: dapm: Cosmetic tidy up of
	snd_soc_dapm_new_control
Date: Tue, 28 Aug 2018 14:35:05 +0100
Message-ID: <20180828133508.13012-4-ckeepax@opensource.cirrus.com>
References: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E7252678C3
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 15:35:13 +0200 (CEST)
In-Reply-To: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Move the function snd_soc_dapm_new_control to be next to
snd_soc_dapm_new_controls and add some kernel doc for it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ff4219fa4a01..1e4926b6bcc3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3417,20 +3417,6 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
 struct snd_soc_dapm_widget *
-snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
-	const struct snd_soc_dapm_widget *widget)
-{
-	struct snd_soc_dapm_widget *w;
-
-	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	w = snd_soc_dapm_new_control_unlocked(dapm, widget);
-	mutex_unlock(&dapm->card->dapm_mutex);
-
-	return w;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
-
-struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget)
 {
@@ -3570,6 +3556,29 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 }
 
 /**
+ * snd_soc_dapm_new_control - create new dapm control
+ * @dapm: DAPM context
+ * @widget: widget template
+ *
+ * Creates new DAPM control based upon a template.
+ *
+ * Returns a widget pointer on success or an error pointer on failure
+ */
+struct snd_soc_dapm_widget *
+snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
+			 const struct snd_soc_dapm_widget *widget)
+{
+	struct snd_soc_dapm_widget *w;
+
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	w = snd_soc_dapm_new_control_unlocked(dapm, widget);
+	mutex_unlock(&dapm->card->dapm_mutex);
+
+	return w;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
+
+/**
  * snd_soc_dapm_new_controls - create new dapm controls
  * @dapm: DAPM context
  * @widget: widget array
-- 
2.11.0
