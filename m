From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/5] ASoC: dapm: Use snd_soc_dapm_add_path()
	in connect_dai_link_widgets()
Date: Wed,  7 May 2014 16:20:26 +0200
Message-ID: <1399472428-11034-3-git-send-email-lars@metafoo.de>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id F2BF626526F
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 16:20:35 +0200 (CEST)
In-Reply-To: <1399472428-11034-1-git-send-email-lars@metafoo.de>
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

We already know which two widgets should be connected, so use
snd_soc_dapm_add_path() instead of snd_soc_dapm_add_route() in
snd_soc_dapm_connect_dai_link_widgets().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 08d869c..e28ce91 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3397,12 +3397,10 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd = card->rtd;
+	struct snd_soc_dapm_widget *sink, *source;
 	struct snd_soc_dai *cpu_dai, *codec_dai;
-	struct snd_soc_dapm_route r;
 	int i;
 
-	memset(&r, 0, sizeof(r));
-
 	/* for each BE DAI link... */
 	for (i = 0; i < card->num_rtd; i++) {
 		rtd = &card->rtd[i];
@@ -3423,26 +3421,27 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 
 		/* connect BE DAI playback if widgets are valid */
 		if (codec_dai->playback_widget && cpu_dai->playback_widget) {
-			r.source = cpu_dai->playback_widget->name;
-			r.sink = codec_dai->playback_widget->name;
+			source = cpu_dai->playback_widget;
+			sink = codec_dai->playback_widget;
 			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				cpu_dai->codec->name, r.source,
-				codec_dai->platform->name, r.sink);
+				cpu_dai->codec->name, source->name,
+				codec_dai->platform->name, sink->name);
 
-			snd_soc_dapm_add_route(&card->dapm, &r);
+			snd_soc_dapm_add_path(&card->dapm, source, sink,
+				NULL, NULL);
 		}
 
 		/* connect BE DAI capture if widgets are valid */
 		if (codec_dai->capture_widget && cpu_dai->capture_widget) {
-			r.source = codec_dai->capture_widget->name;
-			r.sink = cpu_dai->capture_widget->name;
+			source = codec_dai->capture_widget;
+			sink = cpu_dai->capture_widget;
 			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				codec_dai->codec->name, r.source,
-				cpu_dai->platform->name, r.sink);
+				codec_dai->codec->name, source->name,
+				cpu_dai->platform->name, sink->name);
 
-			snd_soc_dapm_add_route(&card->dapm, &r);
+			snd_soc_dapm_add_path(&card->dapm, source, sink,
+				NULL, NULL);
 		}
-
 	}
 }
 
-- 
1.8.0
