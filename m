From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 01/11] ASoC: dpcm: Add helper function for
	initializing runtime pcm
Date: Mon,  6 Jan 2014 14:19:06 +0100
Message-ID: <1389014356-7014-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 975F62608EC
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:18:54 +0100 (CET)
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

We have the same code for initializing the runtime pcm on both the playback and
the capture path. Factor this out into a common helper function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>
---
New in v2
---
 sound/soc/soc-pcm.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 604e7e9..898149e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1235,6 +1235,17 @@ unwind:
 	return err;
 }
 
+static void dpcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
+	struct snd_soc_pcm_stream *stream)
+{
+	runtime->hw.rate_min = stream->rate_min;
+	runtime->hw.rate_max = stream->rate_max;
+	runtime->hw.channels_min = stream->channels_min;
+	runtime->hw.channels_max = stream->channels_max;
+	runtime->hw.formats &= stream->formats;
+	runtime->hw.rates = stream->rates;
+}
+
 static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1242,21 +1253,10 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		runtime->hw.rate_min = cpu_dai_drv->playback.rate_min;
-		runtime->hw.rate_max = cpu_dai_drv->playback.rate_max;
-		runtime->hw.channels_min = cpu_dai_drv->playback.channels_min;
-		runtime->hw.channels_max = cpu_dai_drv->playback.channels_max;
-		runtime->hw.formats &= cpu_dai_drv->playback.formats;
-		runtime->hw.rates = cpu_dai_drv->playback.rates;
-	} else {
-		runtime->hw.rate_min = cpu_dai_drv->capture.rate_min;
-		runtime->hw.rate_max = cpu_dai_drv->capture.rate_max;
-		runtime->hw.channels_min = cpu_dai_drv->capture.channels_min;
-		runtime->hw.channels_max = cpu_dai_drv->capture.channels_max;
-		runtime->hw.formats &= cpu_dai_drv->capture.formats;
-		runtime->hw.rates = cpu_dai_drv->capture.rates;
-	}
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback);
+	else
+		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->capture);
 }
 
 static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
-- 
1.8.0
