From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: dapm: Convert stream events to use
	DAI widgets
Date: Thu, 16 Feb 2012 21:56:09 -0800
Message-ID: <1329458170-22119-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3A29103A4E
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:56:17 +0100 (CET)
In-Reply-To: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This means we don't need to walk through every single widget in the system
for each stream event which is a bit less silly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   43 +++++++++++++++++--------------------------
 1 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ebf1a60..27b56e2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2949,38 +2949,29 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 				  int event)
 {
 	struct snd_soc_dapm_widget *w;
-	const char *stream_name;
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		stream_name = dai->driver->playback.stream_name;
+		w = dai->playback_widget;
 	else
-		stream_name = dai->driver->capture.stream_name;
+		w = dai->capture_widget;
 
-	if (!stream_name)
+	if (!w)
 		return;
 
-	list_for_each_entry(w, &dapm->card->widgets, list)
-	{
-		if (!w->sname || w->dapm != dapm)
-			continue;
-		dev_vdbg(w->dapm->dev, "widget %s\n %s stream %s event %d\n",
-			w->name, w->sname, stream_name, event);
-		if (strstr(w->sname, stream_name)) {
-			dapm_mark_dirty(w, "stream event");
-			switch(event) {
-			case SND_SOC_DAPM_STREAM_START:
-				w->active = 1;
-				break;
-			case SND_SOC_DAPM_STREAM_STOP:
-				w->active = 0;
-				break;
-			case SND_SOC_DAPM_STREAM_SUSPEND:
-			case SND_SOC_DAPM_STREAM_RESUME:
-			case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
-			case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
-				break;
-			}
-		}
+	dapm_mark_dirty(w, "stream event");
+
+	switch (event) {
+	case SND_SOC_DAPM_STREAM_START:
+		w->active = 1;
+		break;
+	case SND_SOC_DAPM_STREAM_STOP:
+		w->active = 0;
+		break;
+	case SND_SOC_DAPM_STREAM_SUSPEND:
+	case SND_SOC_DAPM_STREAM_RESUME:
+	case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
+	case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
+		break;
 	}
 
 	dapm_power_widgets(dapm, event);
-- 
1.7.9.rc1
