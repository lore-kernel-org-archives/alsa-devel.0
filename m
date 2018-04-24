From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 3/3] ASoC: Add multiple CPU DAI support in
	DAPM
Date: Tue, 24 Apr 2018 11:35:54 +0530
Message-ID: <1524549954-29144-4-git-send-email-vkoul@kernel.org>
References: <1524549954-29144-1-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id B71292675D0
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 08:01:28 +0200 (CEST)
In-Reply-To: <1524549954-29144-1-git-send-email-vkoul@kernel.org>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

DAPM handles DAIs during soc_dapm_stream_event() and during addition
and creation of DAI widgets i.e., dapm_add_valid_dai_widget() and
dapm_connect_dai_link_widgets().

Extend these functions to handle multiple cpu dai.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/soc-dapm.c | 71 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2d9709104ec5..79f5f611f548 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4108,38 +4108,57 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 	return 0;
 }
 
-static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
-					  struct snd_soc_pcm_runtime *rtd)
+static void dapm_add_valid_dai_widget(struct snd_soc_card *card,
+					struct snd_soc_pcm_runtime *rtd,
+					struct snd_soc_dai *codec_dai,
+					struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dapm_widget *sink, *source;
-	int i;
 
-	for (i = 0; i < rtd->num_codecs; i++) {
-		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+	/* connect BE DAI playback if widgets are valid */
+	if (codec_dai->playback_widget && cpu_dai->playback_widget) {
+		source = cpu_dai->playback_widget;
+		sink = codec_dai->playback_widget;
+		dev_err(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
+				cpu_dai->component->name,
+				source->name,
+				codec_dai->component->name,
+				sink->name);
+
+		snd_soc_dapm_add_path(&card->dapm, source, sink,
+				NULL, NULL);
+	}
 
-		/* connect BE DAI playback if widgets are valid */
-		if (codec_dai->playback_widget && cpu_dai->playback_widget) {
-			source = cpu_dai->playback_widget;
-			sink = codec_dai->playback_widget;
-			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				cpu_dai->component->name, source->name,
-				codec_dai->component->name, sink->name);
+	/* connect BE DAI capture if widgets are valid */
+	if (codec_dai->capture_widget && cpu_dai->capture_widget) {
+		source = codec_dai->capture_widget;
+		sink = cpu_dai->capture_widget;
+		dev_err(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
+				codec_dai->component->name,
+				source->name,
+				cpu_dai->component->name,
+				sink->name);
 
-			snd_soc_dapm_add_path(&card->dapm, source, sink,
+		snd_soc_dapm_add_path(&card->dapm, source, sink,
 				NULL, NULL);
-		}
+	}
+
+}
 
-		/* connect BE DAI capture if widgets are valid */
-		if (codec_dai->capture_widget && cpu_dai->capture_widget) {
-			source = codec_dai->capture_widget;
-			sink = cpu_dai->capture_widget;
-			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				codec_dai->component->name, source->name,
-				cpu_dai->component->name, sink->name);
+static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
+					  struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *cpu_dai;
+	int i, j;
 
-			snd_soc_dapm_add_path(&card->dapm, source, sink,
-				NULL, NULL);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+
+		for (j = 0; j < rtd->num_cpu_dai; j++) {
+			cpu_dai = rtd->cpu_dais[j];
+
+			dapm_add_valid_dai_widget(card, rtd,
+						codec_dai, cpu_dai);
 		}
 	}
 }
@@ -4206,7 +4225,9 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 {
 	int i;
 
-	soc_dapm_dai_stream_event(rtd->cpu_dai, stream, event);
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		soc_dapm_dai_stream_event(rtd->cpu_dais[i], stream, event);
+
 	for (i = 0; i < rtd->num_codecs; i++)
 		soc_dapm_dai_stream_event(rtd->codec_dais[i], stream, event);
 
-- 
2.7.4
