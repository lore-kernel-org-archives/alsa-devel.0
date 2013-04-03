From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] ASoC: ux500_pcm: Use the same
	snd_pcm_hardware for playback and capture
Date: Wed,  3 Apr 2013 11:02:55 +0200
Message-ID: <1364979780-15364-1-git-send-email-lars@metafoo.de>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-217.synserver.de (smtp-out-217.synserver.de
 [212.40.185.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C0EF26532E
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 10:03:53 +0200 (CEST)
In-Reply-To: <1364979607-15286-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The snd_pcm_hardware structs for playback and capture in the ux500 PCM are
identical, so remove one of them and use the same snd_pcm_hardware struct for
both playback and capture. Also move the defines used to initialize the
snd_pcm_hardware fields from ux500_pcm.h to ux500_pcm.c since that's the only
place where they are used.

Also drop the assignment of the snd_pcm_hardware struct to runtime->hw since
that is what the call to snd_soc_set_runtime_hwparams() right above it already
does, so the second assignment is redundant.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/ux500/ux500_pcm.c | 51 +++++++++++++--------------------------------
 sound/soc/ux500/ux500_pcm.h | 14 -------------
 2 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 1ab36fa..09b5364 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -28,28 +28,19 @@
 #include "ux500_msp_i2s.h"
 #include "ux500_pcm.h"
 
-static struct snd_pcm_hardware ux500_pcm_hw_playback = {
-	.info = SNDRV_PCM_INFO_INTERLEAVED |
-		SNDRV_PCM_INFO_MMAP |
-		SNDRV_PCM_INFO_RESUME |
-		SNDRV_PCM_INFO_PAUSE,
-	.formats = SNDRV_PCM_FMTBIT_S16_LE |
-		SNDRV_PCM_FMTBIT_U16_LE |
-		SNDRV_PCM_FMTBIT_S16_BE |
-		SNDRV_PCM_FMTBIT_U16_BE,
-	.rates = SNDRV_PCM_RATE_KNOT,
-	.rate_min = UX500_PLATFORM_MIN_RATE_PLAYBACK,
-	.rate_max = UX500_PLATFORM_MAX_RATE_PLAYBACK,
-	.channels_min = UX500_PLATFORM_MIN_CHANNELS,
-	.channels_max = UX500_PLATFORM_MAX_CHANNELS,
-	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
-	.period_bytes_min = UX500_PLATFORM_PERIODS_BYTES_MIN,
-	.period_bytes_max = UX500_PLATFORM_PERIODS_BYTES_MAX,
-	.periods_min = UX500_PLATFORM_PERIODS_MIN,
-	.periods_max = UX500_PLATFORM_PERIODS_MAX,
-};
+#define UX500_PLATFORM_MIN_RATE 8000
+#define UX500_PLATFORM_MAX_RATE 48000
+
+#define UX500_PLATFORM_MIN_CHANNELS 1
+#define UX500_PLATFORM_MAX_CHANNELS 8
+
+#define UX500_PLATFORM_PERIODS_BYTES_MIN	128
+#define UX500_PLATFORM_PERIODS_BYTES_MAX	(64 * PAGE_SIZE)
+#define UX500_PLATFORM_PERIODS_MIN		2
+#define UX500_PLATFORM_PERIODS_MAX		48
+#define UX500_PLATFORM_BUFFER_BYTES_MAX		(2048 * PAGE_SIZE)
 
-static struct snd_pcm_hardware ux500_pcm_hw_capture = {
+static struct snd_pcm_hardware ux500_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_RESUME |
@@ -59,8 +50,8 @@ static struct snd_pcm_hardware ux500_pcm_hw_capture = {
 		SNDRV_PCM_FMTBIT_S16_BE |
 		SNDRV_PCM_FMTBIT_U16_BE,
 	.rates = SNDRV_PCM_RATE_KNOT,
-	.rate_min = UX500_PLATFORM_MIN_RATE_CAPTURE,
-	.rate_max = UX500_PLATFORM_MAX_RATE_CAPTURE,
+	.rate_min = UX500_PLATFORM_MIN_RATE,
+	.rate_max = UX500_PLATFORM_MAX_RATE,
 	.channels_min = UX500_PLATFORM_MIN_CHANNELS,
 	.channels_max = UX500_PLATFORM_MAX_CHANNELS,
 	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
@@ -90,8 +81,6 @@ static void ux500_pcm_dma_hw_free(struct device *dev,
 
 static int ux500_pcm_open(struct snd_pcm_substream *substream)
 {
-	int stream_id = substream->pstr->stream;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct device *dev = dai->dev;
@@ -104,17 +93,7 @@ static int ux500_pcm_open(struct snd_pcm_substream *substream)
 		snd_pcm_stream_str(substream));
 
 	dev_dbg(dev, "%s: Set runtime hwparams.\n", __func__);
-	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_soc_set_runtime_hwparams(substream,
-					&ux500_pcm_hw_playback);
-	else
-		snd_soc_set_runtime_hwparams(substream,
-					&ux500_pcm_hw_capture);
-
-	dev_dbg(dev, "%s: Set hw-struct for %s.\n", __func__,
-		snd_pcm_stream_str(substream));
-	runtime->hw = (stream_id == SNDRV_PCM_STREAM_PLAYBACK) ?
-		ux500_pcm_hw_playback : ux500_pcm_hw_capture;
+	snd_soc_set_runtime_hwparams(substream, &ux500_pcm_hw);
 
 	mem_data_width = STEDMA40_HALFWORD_WIDTH;
 
diff --git a/sound/soc/ux500/ux500_pcm.h b/sound/soc/ux500/ux500_pcm.h
index 76d3444..d76e1af 100644
--- a/sound/soc/ux500/ux500_pcm.h
+++ b/sound/soc/ux500/ux500_pcm.h
@@ -18,20 +18,6 @@
 
 #include <linux/workqueue.h>
 
-#define UX500_PLATFORM_MIN_RATE_PLAYBACK 8000
-#define UX500_PLATFORM_MAX_RATE_PLAYBACK 48000
-#define UX500_PLATFORM_MIN_RATE_CAPTURE	8000
-#define UX500_PLATFORM_MAX_RATE_CAPTURE	48000
-
-#define UX500_PLATFORM_MIN_CHANNELS 1
-#define UX500_PLATFORM_MAX_CHANNELS 8
-
-#define UX500_PLATFORM_PERIODS_BYTES_MIN	128
-#define UX500_PLATFORM_PERIODS_BYTES_MAX	(64 * PAGE_SIZE)
-#define UX500_PLATFORM_PERIODS_MIN		2
-#define UX500_PLATFORM_PERIODS_MAX		48
-#define UX500_PLATFORM_BUFFER_BYTES_MAX		(2048 * PAGE_SIZE)
-
 int ux500_pcm_register_platform(struct platform_device *pdev);
 int ux500_pcm_unregister_platform(struct platform_device *pdev);
 
-- 
1.8.0
