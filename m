From: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dpcm: prevent error for paths including
	static links
Date: Tue, 15 Mar 2016 15:34:49 +0000
Message-ID: <1458056089-885-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E199265344
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 16:37:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

According to the DPCM documentation using static codec <-> codec links
along dynamic ones is a valid use case, however this causes errors of
the following form to be printed to the kernel log:

ASoC: can't get [playback|caputure] BE for <widget name>
ASoC: no BE found for <widget name>

This happens when setting up, e.g. a route starting with a dynamic
DAI, which passes through a static DAI (say, "Some FE" -> "Some BE"
-> "Codec to Modem link"). All DAPM widgets involved in that path will
be passed to dpcm_add_paths in order to establish FE <-> BE connections,
which will result in dpcm_get_be trying to locate back-ends for dynamic,
as well as static links, causing a spurious error to be logged for the
latter.

This patch changes dpcm_get_be to look up a non front-end runtime
for a stream widget, and renames it accordingly. Like this both dynamic
and static links can be handled properly in dpcm_add_paths, i.e. an actual
missing BE can be distinguished from a normal link.

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1af4f23..ff5ea7e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1220,47 +1220,47 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 	}
 }
 
-/* get BE for DAI widget and stream */
-static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
+/* get runtime for DAI widget and stream */
+static struct snd_soc_pcm_runtime *dpcm_get_rtd(struct snd_soc_card *card,
 		struct snd_soc_dapm_widget *widget, int stream)
 {
-	struct snd_soc_pcm_runtime *be;
+	struct snd_soc_pcm_runtime *rtd;
 	int i;
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		list_for_each_entry(be, &card->rtd_list, list) {
+		list_for_each_entry(rtd, &card->rtd_list, list) {
 
-			if (!be->dai_link->no_pcm)
+			if (rtd->dai_link->dynamic)
 				continue;
 
-			if (be->cpu_dai->playback_widget == widget)
-				return be;
+			if (rtd->cpu_dai->playback_widget == widget)
+				return rtd;
 
-			for (i = 0; i < be->num_codecs; i++) {
-				struct snd_soc_dai *dai = be->codec_dais[i];
+			for (i = 0; i < rtd->num_codecs; i++) {
+				struct snd_soc_dai *dai = rtd->codec_dais[i];
 				if (dai->playback_widget == widget)
-					return be;
+					return rtd;
 			}
 		}
 	} else {
 
-		list_for_each_entry(be, &card->rtd_list, list) {
+		list_for_each_entry(rtd, &card->rtd_list, list) {
 
-			if (!be->dai_link->no_pcm)
+			if (rtd->dai_link->dynamic)
 				continue;
 
-			if (be->cpu_dai->capture_widget == widget)
-				return be;
+			if (rtd->cpu_dai->capture_widget == widget)
+				return rtd;
 
-			for (i = 0; i < be->num_codecs; i++) {
-				struct snd_soc_dai *dai = be->codec_dais[i];
+			for (i = 0; i < rtd->num_codecs; i++) {
+				struct snd_soc_dai *dai = rtd->codec_dais[i];
 				if (dai->capture_widget == widget)
-					return be;
+					return rtd;
 			}
 		}
 	}
 
-	dev_err(card->dev, "ASoC: can't get %s BE for %s\n",
+	dev_err(card->dev, "ASoC: can't get %s runtime for %s\n",
 		stream ? "capture" : "playback", widget->name);
 	return NULL;
 }
@@ -1367,15 +1367,15 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 			continue;
 		}
 
-		/* is there a valid BE rtd for this widget */
-		be = dpcm_get_be(card, list->widgets[i], stream);
+		/* is there a valid rtd for this widget */
+		be = dpcm_get_rtd(card, list->widgets[i], stream);
 		if (!be) {
-			dev_err(fe->dev, "ASoC: no BE found for %s\n",
+			dev_err(fe->dev, "ASoC: no runtime found for %s\n",
 					list->widgets[i]->name);
 			continue;
 		}
 
-		/* make sure BE is a real BE */
+		/* check if the runtime is a BE */
 		if (!be->dai_link->no_pcm)
 			continue;
 
-- 
1.7.10.4
