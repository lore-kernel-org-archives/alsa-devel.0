From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Factor out duplicated code in
	soc_dapm_stream_event()
Date: Tue, 29 Apr 2014 14:51:22 +0200
Message-ID: <1398775882-2321-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-008.synserver.de (smtp-out-063.synserver.de
 [212.40.185.63])
 by alsa0.perex.cz (Postfix) with ESMTP id A052D26509A
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 14:51:29 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

In soc_dapm_stream_event() we have the same code twice, once for the codec_dai
and once for the cpu_dai.  This patch factors the duplicated code out into a
separate function. This will make it easier to modify the implementation (since
there is only one place that needs to be updated) and also easier to add support
for more than two DAIs per DAI link.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 51 ++++++++++++++++-----------------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a2475e1..1871dfc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3446,32 +3446,25 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 	}
 }
 
-static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
 	int event)
 {
+	struct snd_soc_dapm_widget *w;
 
-	struct snd_soc_dapm_widget *w_cpu, *w_codec;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		w_cpu = cpu_dai->playback_widget;
-		w_codec = codec_dai->playback_widget;
-	} else {
-		w_cpu = cpu_dai->capture_widget;
-		w_codec = codec_dai->capture_widget;
-	}
-
-	if (w_cpu) {
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		w = dai->playback_widget;
+	else
+		w = dai->capture_widget;
 
-		dapm_mark_dirty(w_cpu, "stream event");
+	if (w) {
+		dapm_mark_dirty(w, "stream event");
 
 		switch (event) {
 		case SND_SOC_DAPM_STREAM_START:
-			w_cpu->active = 1;
+			w->active = 1;
 			break;
 		case SND_SOC_DAPM_STREAM_STOP:
-			w_cpu->active = 0;
+			w->active = 0;
 			break;
 		case SND_SOC_DAPM_STREAM_SUSPEND:
 		case SND_SOC_DAPM_STREAM_RESUME:
@@ -3480,25 +3473,13 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 			break;
 		}
 	}
+}
 
-	if (w_codec) {
-
-		dapm_mark_dirty(w_codec, "stream event");
-
-		switch (event) {
-		case SND_SOC_DAPM_STREAM_START:
-			w_codec->active = 1;
-			break;
-		case SND_SOC_DAPM_STREAM_STOP:
-			w_codec->active = 0;
-			break;
-		case SND_SOC_DAPM_STREAM_SUSPEND:
-		case SND_SOC_DAPM_STREAM_RESUME:
-		case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
-		case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
-			break;
-		}
-	}
+static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+	int event)
+{
+	soc_dapm_dai_stream_event(rtd->cpu_dai, stream, event);
+	soc_dapm_dai_stream_event(rtd->codec_dai, stream, event);
 
 	dapm_power_widgets(rtd->card, event);
 }
-- 
1.8.0
