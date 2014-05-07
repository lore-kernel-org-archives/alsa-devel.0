From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: dapm: Simplify
	snd_soc_dapm_link_dai_widgets()
Date: Wed,  7 May 2014 15:05:48 +0200
Message-ID: <1399467948-8770-5-git-send-email-lars@metafoo.de>
References: <1399467948-8770-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 694CB261B01
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 15:06:03 +0200 (CEST)
In-Reply-To: <1399467948-8770-1-git-send-email-lars@metafoo.de>
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
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

If we find a widget who's stream name matches the name of a DAI widget then
that's the the widget it should be connected to. Based on the widget id we can
say in which direction the path should be. No need to go back to the DAI and
check the stream names.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index de48cab..79b3985 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3337,6 +3337,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *dai_w, *w;
+	struct snd_soc_dapm_widget *src, *sink;
 	struct snd_soc_dai *dai;
 
 	/* For each DAI widget... */
@@ -3367,25 +3368,15 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 			if (!w->sname || !strstr(w->sname, dai_w->name))
 				continue;
 
-			if (dai->driver->playback.stream_name &&
-			    strstr(w->sname,
-				   dai->driver->playback.stream_name)) {
-				dev_dbg(dai->dev, "%s -> %s\n",
-					 dai->playback_widget->name, w->name);
-
-				snd_soc_dapm_add_path(w->dapm,
-					dai->playback_widget, w, NULL, NULL);
-			}
-
-			if (dai->driver->capture.stream_name &&
-			    strstr(w->sname,
-				   dai->driver->capture.stream_name)) {
-				dev_dbg(dai->dev, "%s -> %s\n",
-					w->name, dai->capture_widget->name);
-
-				snd_soc_dapm_add_path(w->dapm, w,
-					dai->capture_widget, NULL, NULL);
+			if (dai_w->id == snd_soc_dapm_dai_in) {
+				src = dai_w;
+				sink = w;
+			} else {
+				src = w;
+				sink = dai_w;
 			}
+			dev_dbg(dai->dev, "%s -> %s\n", src->name, sink->name);
+			snd_soc_dapm_add_path(w->dapm, src, sink, NULL, NULL);
 		}
 	}
 
-- 
1.8.0
