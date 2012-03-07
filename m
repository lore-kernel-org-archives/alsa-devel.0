From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core: Add support for DAI driver DAI
	widgets.
Date: Wed,  7 Mar 2012 11:47:42 +0000
Message-ID: <1331120862-16161-2-git-send-email-lrg@ti.com>
References: <1331120862-16161-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 3191910B90D
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 12:47:51 +0100 (CET)
Received: by mail-we0-f181.google.com with SMTP id m13so4254901wer.12
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 03:47:49 -0800 (PST)
In-Reply-To: <1331120862-16161-1-git-send-email-lrg@ti.com>
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

Automatically create DAI widgets for DAI drivers. This allows us to connect
CPU DAIs into the DAPM graph. The widgets use the DAI driver dev name with
a "Playback" or "Capture" suffix.

i.e. "mcbsp.1 Playback"

Also add a snd_soc_dai member to snd_soc_widget so that we dont have to
use the widget private data.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-dapm.c     |   56 +++++++++++++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 6727384..8cd3c74 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -482,6 +482,7 @@ struct snd_soc_dapm_widget {
 	const char *sname;	/* stream name */
 	struct snd_soc_codec *codec;
 	struct snd_soc_platform *platform;
+	struct snd_soc_dai *dai;
 	struct list_head list;
 	struct snd_soc_dapm_context *dapm;
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5c83b83..d15a703 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -44,6 +44,7 @@
 
 #include <trace/events/asoc.h>
 
+#define NAME_SIZE	32
 #define DAPM_UPDATE_STAT(widget, val) widget->dapm->card->dapm_stats.val++;
 
 /* dapm power sequences - make this per codec in the future */
@@ -2911,6 +2912,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
+	char name[NAME_SIZE];
 
 	WARN_ON(dapm->dev != dai->dev);
 
@@ -2918,41 +2920,49 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 	template.reg = SND_SOC_NOPM;
 
 	if (dai->driver->playback.stream_name) {
-		template.id = snd_soc_dapm_dai;
 		template.name = dai->driver->playback.stream_name;
 		template.sname = dai->driver->playback.stream_name;
+	} else {
+		snprintf(name, NAME_SIZE, "%s %s", dev_name(dai->dev), "Playback");
+		template.name = name;
+		template.sname = name;
+	}
 
-		dev_dbg(dai->dev, "adding %s widget\n",
-			template.name);
+	template.id = snd_soc_dapm_dai;
+	dev_dbg(dai->dev, "adding %s widget\n",
+		template.name);
 
-		w = snd_soc_dapm_new_control(dapm, &template);
-		if (!w) {
-			dev_err(dapm->dev, "Failed to create %s widget\n",
-				dai->driver->playback.stream_name);
-		}
-
-		w->priv = dai;
-		dai->playback_widget = w;
+	w = snd_soc_dapm_new_control(dapm, &template);
+	if (!w) {
+		dev_err(dapm->dev, "Failed to create %s widget\n",
+			dai->driver->playback.stream_name);
 	}
 
+	dai->playback_widget = w;
+	w->dai = dai;
+
 	if (dai->driver->capture.stream_name) {
-		template.id = snd_soc_dapm_dai;
 		template.name = dai->driver->capture.stream_name;
 		template.sname = dai->driver->capture.stream_name;
+	} else {
+		snprintf(name, NAME_SIZE, "%s %s", dev_name(dai->dev), "Capture");
+		template.name = name;
+		template.sname = name;
+	}
+	template.id = snd_soc_dapm_dai;
 
-		dev_dbg(dai->dev, "adding %s widget\n",
-			template.name);
+	dev_dbg(dai->dev, "adding %s widget\n",
+		template.name);
 
-		w = snd_soc_dapm_new_control(dapm, &template);
-		if (!w) {
-			dev_err(dapm->dev, "Failed to create %s widget\n",
-				dai->driver->capture.stream_name);
-		}
-
-		w->priv = dai;
-		dai->capture_widget = w;
+	w = snd_soc_dapm_new_control(dapm, &template);
+	if (!w) {
+		dev_err(dapm->dev, "Failed to create %s widget\n",
+			dai->driver->capture.stream_name);
 	}
 
+	dai->capture_widget = w;
+	w->dai = dai;
+
 	return 0;
 }
 
@@ -2969,7 +2979,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 		if (dai_w->id != snd_soc_dapm_dai)
 			continue;
 
-		dai = dai_w->priv;
+		dai = dai_w->dai;
 
 		/* ...find all widgets with the same stream and link them */
 		list_for_each_entry(w, &card->widgets, list) {
-- 
1.7.5.4
