From: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Subject: [PATCH v3 2/2] ASoC: dpcm: play nice with
	CODEC<->CODEC links
Date: Fri, 13 May 2016 17:03:56 +0100
Message-ID: <1463155436-12128-2-git-send-email-piotrs@opensource.wolfsonmicro.com>
References: <1463155436-12128-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id F3CEE266A28
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 18:05:06 +0200 (CEST)
In-Reply-To: <1463155436-12128-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
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
Cc: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Currently in situations where a normal CODEC to CODEC link follows a
DPCM DAI, an error in the following form will be logged:

ASoC: can't get [playback|capture] BE for <widget name>
ASoC: no BE found for <widget name>

This happens because all widgets in a path containing a DPCM DAI will
be passed to dpcm_add_paths, which will try to interpret the CODEC<->CODEC
as if it were a DPCM DAI, in turn causing the error.

This patch aims to resolve the described issue by stopping the DPCM graph
walk, initiated from dpcm_path_get, at the first widget associated with
a DPCM BE.

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index c2b0aa8..60d702f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1287,6 +1287,46 @@ static int widget_in_list(struct snd_soc_dapm_widget_list *list,
 	return 0;
 }
 
+static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
+		enum snd_soc_dapm_direction dir)
+{
+	struct snd_soc_card *card = widget->dapm->card;
+	struct snd_soc_pcm_runtime *rtd;
+	int i;
+
+	if (dir == SND_SOC_DAPM_DIR_OUT) {
+		list_for_each_entry(rtd, &card->rtd_list, list) {
+			if (!rtd->dai_link->no_pcm)
+				continue;
+
+			if (rtd->cpu_dai->playback_widget == widget)
+				return true;
+
+			for (i = 0; i < rtd->num_codecs; ++i) {
+				struct snd_soc_dai *dai = rtd->codec_dais[i];
+				if (dai->playback_widget == widget)
+					return true;
+			}
+		}
+	} else { /* SND_SOC_DAPM_DIR_IN */
+		list_for_each_entry(rtd, &card->rtd_list, list) {
+			if (!rtd->dai_link->no_pcm)
+				continue;
+
+			if (rtd->cpu_dai->capture_widget == widget)
+				return true;
+
+			for (i = 0; i < rtd->num_codecs; ++i) {
+				struct snd_soc_dai *dai = rtd->codec_dais[i];
+				if (dai->capture_widget == widget)
+					return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 	int stream, struct snd_soc_dapm_widget_list **list)
 {
@@ -1295,7 +1335,7 @@ int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 
 	/* get number of valid DAI paths and their widgets */
 	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, list,
-			NULL);
+			dpcm_end_walk_at_be);
 
 	dev_dbg(fe->dev, "ASoC: found %d audio %s paths\n", paths,
 			stream ? "capture" : "playback");
-- 
1.7.10.4
