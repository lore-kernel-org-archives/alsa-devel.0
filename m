From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v3 2/3] ASoC: core: Add one dai_get_widget helper
	instead of two rtd based ones
Date: Thu, 24 Apr 2014 14:01:45 +0200
Message-ID: <1398340906-5017-3-git-send-email-bcousson@baylibre.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
 [74.125.82.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C8F5265253
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:02:23 +0200 (CEST)
Received: by mail-we0-f180.google.com with SMTP id k48so2099844wev.25
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 05:02:23 -0700 (PDT)
In-Reply-To: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Replace rtd_get_codec_widget() and rtd_get_cpu_widget() by a simple
dai_get_widget() in preparation for DAI-multicodec support, per Lars
suggestion.

No functional change.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-pcm.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2cedf09..88230ea 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1012,21 +1012,12 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 }
 
 static inline struct snd_soc_dapm_widget *
-	rtd_get_cpu_widget(struct snd_soc_pcm_runtime *rtd, int stream)
+	dai_get_widget(struct snd_soc_dai *dai, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		return rtd->cpu_dai->playback_widget;
+		return dai->playback_widget;
 	else
-		return rtd->cpu_dai->capture_widget;
-}
-
-static inline struct snd_soc_dapm_widget *
-	rtd_get_codec_widget(struct snd_soc_pcm_runtime *rtd, int stream)
-{
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		return rtd->codec_dai->playback_widget;
-	else
-		return rtd->codec_dai->capture_widget;
+		return dai->capture_widget;
 }
 
 static int widget_in_list(struct snd_soc_dapm_widget_list *list,
@@ -1076,14 +1067,14 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
 
 		/* is there a valid CPU DAI widget for this BE */
-		widget = rtd_get_cpu_widget(dpcm->be, stream);
+		widget = dai_get_widget(dpcm->be->cpu_dai, stream);
 
 		/* prune the BE if it's no longer in our active list */
 		if (widget && widget_in_list(list, widget))
 			continue;
 
 		/* is there a valid CODEC DAI widget for this BE */
-		widget = rtd_get_codec_widget(dpcm->be, stream);
+		widget = dai_get_widget(dpcm->be->codec_dai, stream);
 
 		/* prune the BE if it's no longer in our active list */
 		if (widget && widget_in_list(list, widget))
-- 
1.8.3.2
