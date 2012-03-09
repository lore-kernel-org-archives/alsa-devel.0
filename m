From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm: Add regulator member to struct
	dapm_widget.
Date: Fri,  9 Mar 2012 17:20:16 +0000
Message-ID: <1331313616-9416-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 28116104661
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 18:20:22 +0100 (CET)
Received: by mail-we0-f180.google.com with SMTP id f3so1274783wer.25
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 09:20:21 -0800 (PST)
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

Currently DAPM widgets use the private data for their regulator.
Add a regulator * for widgets to use instead of private data.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 1beb28d..bde6a52 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -323,6 +323,7 @@ struct snd_soc_dapm_path;
 struct snd_soc_dapm_pin;
 struct snd_soc_dapm_route;
 struct snd_soc_dapm_context;
+struct regulator;
 
 int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
@@ -486,6 +487,7 @@ struct snd_soc_dapm_widget {
 	struct snd_soc_dapm_context *dapm;
 
 	void *priv;				/* widget specific data */
+	struct regulator *regulator;		/* attached regulator */
 
 	/* dapm control */
 	short reg;						/* negative reg = no direct dapm */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e5aa65a..27132db 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -883,9 +883,9 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		return regulator_enable(w->priv);
+		return regulator_enable(w->regulator);
 	else
-		return regulator_disable_deferred(w->priv, w->shift);
+		return regulator_disable_deferred(w->regulator, w->shift);
 }
 EXPORT_SYMBOL_GPL(dapm_regulator_event);
 
@@ -2790,9 +2790,9 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 
 	switch (w->id) {
 	case snd_soc_dapm_regulator_supply:
-		w->priv = devm_regulator_get(dapm->dev, w->name);
-		if (IS_ERR(w->priv)) {
-			ret = PTR_ERR(w->priv);
+		w->regulator = devm_regulator_get(dapm->dev, w->name);
+		if (IS_ERR(w->regulator)) {
+			ret = PTR_ERR(w->regulator);
 			dev_err(dapm->dev, "Failed to request %s: %d\n",
 				w->name, ret);
 			return NULL;
-- 
1.7.5.4
