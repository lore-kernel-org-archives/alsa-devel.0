From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: DAPM: Add APIs to create individual DAPM
	controls.
Date: Mon, 25 May 2015 18:21:17 +0100
Message-ID: <1432574477-7350-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A9A222619BE
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 19:21:29 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The topology core needs to be able to create individual widget controls at
runtime and driver init. Add a regular locked and unlocked API calls to
facilitate this requirement.

The unlocked call is used by the topology core during component driver
probing where the card dapm_mutex is held by the ASoC core and the locked
version at non component driver probe time.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-dapm.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index defe0f0..62406d8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -52,8 +52,8 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	const char *control,
 	int (*connected)(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink));
-static struct snd_soc_dapm_widget *
-snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
+struct snd_soc_dapm_widget *
+snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget);
 
 /* dapm power sequences - make this per codec in the future */
@@ -342,7 +342,8 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 
 			data->value = template.on_val;
 
-			data->widget = snd_soc_dapm_new_control(widget->dapm,
+			data->widget =
+				snd_soc_dapm_new_control_unlocked(widget->dapm,
 				&template);
 			if (!data->widget) {
 				kfree(data);
@@ -3053,8 +3054,25 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
-static struct snd_soc_dapm_widget *
+struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
+	const struct snd_soc_dapm_widget *widget)
+{
+	struct snd_soc_dapm_widget *w;
+
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	w = snd_soc_dapm_new_control_unlocked(dapm, widget);
+	if (!w)
+		dev_err(dapm->dev,
+			"ASoC: Failed to create DAPM control %s\n",
+			widget->name);
+
+	mutex_unlock(&dapm->card->dapm_mutex);
+	return w;
+}
+
+struct snd_soc_dapm_widget *
+snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget)
 {
 	struct snd_soc_dapm_widget *w;
@@ -3199,7 +3217,7 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
-		w = snd_soc_dapm_new_control(dapm, widget);
+		w = snd_soc_dapm_new_control_unlocked(dapm, widget);
 		if (!w) {
 			dev_err(dapm->dev,
 				"ASoC: Failed to create DAPM control %s\n",
@@ -3437,7 +3455,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 
 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
-	w = snd_soc_dapm_new_control(&card->dapm, &template);
+	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
 	if (!w) {
 		dev_err(card->dev, "ASoC: Failed to create %s widget\n",
 			link_name);
@@ -3488,7 +3506,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 		dev_dbg(dai->dev, "ASoC: adding %s widget\n",
 			template.name);
 
-		w = snd_soc_dapm_new_control(dapm, &template);
+		w = snd_soc_dapm_new_control_unlocked(dapm, &template);
 		if (!w) {
 			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
 				dai->driver->playback.stream_name);
@@ -3507,7 +3525,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 		dev_dbg(dai->dev, "ASoC: adding %s widget\n",
 			template.name);
 
-		w = snd_soc_dapm_new_control(dapm, &template);
+		w = snd_soc_dapm_new_control_unlocked(dapm, &template);
 		if (!w) {
 			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
 				dai->driver->capture.stream_name);
-- 
2.1.4
