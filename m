From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 2/2] ASoC: DAPM: Automatically connect DAI link
	widgets in DAPM graph.
Date: Wed,  8 Jan 2014 10:40:19 +0000
Message-ID: <1389177619-2760-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1389177619-2760-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 48B6226510B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 11:40:33 +0100 (CET)
In-Reply-To: <1389177619-2760-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Connect the DAPM graph through each BE DAI link to the componnent(s) on the
other side of the BE DAI link. This allows the graph to be walked on
both sides of the link when graph changes are made.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-dapm.h |  1 +
 sound/soc/soc-core.c     |  1 +
 sound/soc/soc-dapm.c     | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2037c45..a5de124 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -411,6 +411,7 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
+void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 			 const struct snd_soc_pcm_stream *params,
 			 struct snd_soc_dapm_widget *source,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 03c779e..a391665 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1728,6 +1728,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	snd_soc_dapm_link_dai_widgets(card);
+	snd_soc_dapm_connect_dai_link_widgets(card);
 
 	if (card->controls)
 		snd_soc_add_card_controls(card, card->controls, card->num_controls);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcade13..9176e6d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3614,6 +3614,55 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 	return 0;
 }
 
+void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd = card->rtd;
+	struct snd_soc_dai *cpu_dai, *codec_dai;
+	struct snd_soc_dapm_route r;
+	int i;
+
+	memset(&r, 0, sizeof(r));
+
+	/* for each BE DAI link... */
+	for (i = 0; i < card->num_rtd; i++) {
+		rtd = &card->rtd[i];
+		cpu_dai = rtd->cpu_dai;
+		codec_dai = rtd->codec_dai;
+
+		/* dynamic FE links have no fixed DAI mapping */
+		if (rtd->dai_link->dynamic)
+			continue;
+
+		/* there is no point in connecting BE DAI links with dummies */
+		if (snd_soc_dai_is_dummy(codec_dai) ||
+			snd_soc_dai_is_dummy(cpu_dai))
+			continue;
+
+		/* connect BE DAI playback if widgets are valid */
+		if (codec_dai->playback_widget && cpu_dai->playback_widget) {
+			r.source = cpu_dai->playback_widget->name;
+			r.sink = codec_dai->playback_widget->name;
+			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
+				cpu_dai->codec->name, r.source,
+				codec_dai->platform->name, r.sink);
+
+			snd_soc_dapm_add_route(&card->dapm, &r);
+		}
+
+		/* connect BE DAI capture if widgets are valid */
+		if (codec_dai->capture_widget && cpu_dai->capture_widget) {
+			r.source = codec_dai->capture_widget->name;
+			r.sink = cpu_dai->capture_widget->name;
+			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
+				codec_dai->codec->name, r.source,
+				cpu_dai->platform->name, r.sink);
+
+			snd_soc_dapm_add_route(&card->dapm, &r);
+		}
+
+	}
+}
+
 static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	int event)
 {
-- 
1.8.3.2
