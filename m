From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/17] Add support for passing kcontrols with
	events.
Date: Thu, 10 Jan 2008 13:17:07 +0000
Message-ID: <1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id C145124581
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:18 +0100 (CET)
In-Reply-To: <1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Signed-off-by: Laim Girdwood <lg@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 +-
 sound/soc/soc-dapm.c     |   40 +++++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 335d73c..0df89bb 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -289,7 +289,7 @@ struct snd_soc_dapm_widget {
 
 	/* external events */
 	unsigned short event_flags;		/* flags to specify event types */
-	int (*event)(struct snd_soc_dapm_widget*, int);
+	int (*event)(struct snd_soc_dapm_widget*, struct snd_kcontrol *, int);
 
 	/* kcontrols that relate to this widget */
 	int num_kcontrols;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4a5bd85..a4ce882 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -524,11 +524,13 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 					continue;
 
 				if (event == SND_SOC_DAPM_STREAM_START) {
-					ret = w->event(w, SND_SOC_DAPM_PRE_PMU);
+					ret = w->event(w,
+						NULL, SND_SOC_DAPM_PRE_PMU);
 					if (ret < 0)
 						return ret;
 				} else if (event == SND_SOC_DAPM_STREAM_STOP) {
-					ret = w->event(w, SND_SOC_DAPM_PRE_PMD);
+					ret = w->event(w,
+						NULL, SND_SOC_DAPM_PRE_PMD);
 					if (ret < 0)
 						return ret;
 				}
@@ -539,11 +541,13 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 					continue;
 
 				if (event == SND_SOC_DAPM_STREAM_START) {
-					ret = w->event(w, SND_SOC_DAPM_POST_PMU);
+					ret = w->event(w,
+						NULL, SND_SOC_DAPM_POST_PMU);
 					if (ret < 0)
 						return ret;
 				} else if (event == SND_SOC_DAPM_STREAM_STOP) {
-					ret = w->event(w, SND_SOC_DAPM_POST_PMD);
+					ret = w->event(w,
+						NULL, SND_SOC_DAPM_POST_PMD);
 					if (ret < 0)
 						return ret;
 				}
@@ -567,26 +571,30 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 					if (power) {
 						/* power up event */
 						if (w->event_flags & SND_SOC_DAPM_PRE_PMU) {
-							ret = w->event(w, SND_SOC_DAPM_PRE_PMU);
+							ret = w->event(w,
+								NULL, SND_SOC_DAPM_PRE_PMU);
 							if (ret < 0)
 								return ret;
 						}
 						dapm_update_bits(w);
 						if (w->event_flags & SND_SOC_DAPM_POST_PMU){
-							ret = w->event(w, SND_SOC_DAPM_POST_PMU);
+							ret = w->event(w,
+								NULL, SND_SOC_DAPM_POST_PMU);
 							if (ret < 0)
 								return ret;
 						}
 					} else {
 						/* power down event */
 						if (w->event_flags & SND_SOC_DAPM_PRE_PMD) {
-							ret = w->event(w, SND_SOC_DAPM_PRE_PMD);
+							ret = w->event(w,
+								NULL, SND_SOC_DAPM_PRE_PMD);
 							if (ret < 0)
 								return ret;
 						}
 						dapm_update_bits(w);
 						if (w->event_flags & SND_SOC_DAPM_POST_PMD) {
-							ret = w->event(w, SND_SOC_DAPM_POST_PMD);
+							ret = w->event(w,
+								NULL, SND_SOC_DAPM_POST_PMD);
 							if (ret < 0)
 								return ret;
 						}
@@ -1096,13 +1104,17 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	dapm_mixer_update_power(widget, kcontrol, reg, val_mask, val, invert);
 	if (widget->event) {
 		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
-			ret = widget->event(widget, SND_SOC_DAPM_PRE_REG);
-			if (ret < 0)
+			ret = widget->event(widget, kcontrol,
+						SND_SOC_DAPM_PRE_REG);
+			if (ret < 0) {
+				ret = 1;
 				goto out;
+			}
 		}
 		ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
 		if (widget->event_flags & SND_SOC_DAPM_POST_REG)
-			ret = widget->event(widget, SND_SOC_DAPM_POST_REG);
+			ret = widget->event(widget, kcontrol,
+						SND_SOC_DAPM_POST_REG);
 	} else
 		ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
 
@@ -1177,13 +1189,15 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	dapm_mux_update_power(widget, kcontrol, mask, mux, e);
 	if (widget->event) {
 		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
-			ret = widget->event(widget, SND_SOC_DAPM_PRE_REG);
+			ret = widget->event(widget,
+				kcontrol, SND_SOC_DAPM_PRE_REG);
 			if (ret < 0)
 				goto out;
 		}
 		ret = snd_soc_update_bits(widget->codec, e->reg, mask, val);
 		if (widget->event_flags & SND_SOC_DAPM_POST_REG)
-			ret = widget->event(widget, SND_SOC_DAPM_POST_REG);
+			ret = widget->event(widget,
+				kcontrol, SND_SOC_DAPM_POST_REG);
 	} else
 		ret = snd_soc_update_bits(widget->codec, e->reg, mask, val);
 
-- 
1.5.3.8
