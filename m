From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/4] ASoC: core: refactor soc_link_dai_widgets()
Date: Mon,  9 Nov 2015 23:19:58 +0530
Message-ID: <1447091401-24298-2-git-send-email-vinod.koul@intel.com>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D08E126154F
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 18:46:38 +0100 (CET)
In-Reply-To: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

In soc_link_dai_widgets() we refer to local widget variables as
playback/capture_widget, but they are really sink/source widgets,
so change the names accordingly

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 24b096066a07..d5e0bcbafb70 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1283,35 +1283,35 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dapm_widget *play_w, *capture_w;
+	struct snd_soc_dapm_widget *sink, *source;
 	int ret;
 
 	if (rtd->num_codecs > 1)
 		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
 
 	/* link the DAI widgets */
-	play_w = codec_dai->playback_widget;
-	capture_w = cpu_dai->capture_widget;
-	if (play_w && capture_w) {
+	sink = codec_dai->playback_widget;
+	source = cpu_dai->capture_widget;
+	if (sink && source) {
 		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
-					   dai_link->num_params, capture_w,
-					   play_w);
+					   dai_link->num_params,
+					   source, sink);
 		if (ret != 0) {
 			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-				play_w->name, capture_w->name, ret);
+				sink->name, source->name, ret);
 			return ret;
 		}
 	}
 
-	play_w = cpu_dai->playback_widget;
-	capture_w = codec_dai->capture_widget;
-	if (play_w && capture_w) {
+	sink = cpu_dai->playback_widget;
+	source = codec_dai->capture_widget;
+	if (sink && source) {
 		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
-					   dai_link->num_params, capture_w,
-					   play_w);
+					   dai_link->num_params,
+					   source, sink);
 		if (ret != 0) {
 			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-				play_w->name, capture_w->name, ret);
+				sink->name, source->name, ret);
 			return ret;
 		}
 	}
-- 
1.9.1
