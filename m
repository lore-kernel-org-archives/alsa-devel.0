From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: Move snd_soc_set_runtime_hwparams()
	to soc-pcm.c
Date: Tue, 14 May 2013 11:05:30 +0200
Message-ID: <1368522332-15624-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-187.synserver.de (smtp-out-187.synserver.de
 [212.40.185.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C21326036C
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 11:05:57 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

snd_soc_set_runtime_hwparams() is the only PCM related function that lives in
soc-core.c. All other PCM related functions live in soc-pcm.c, so move
snd_soc_set_runtime_hwparams() over as well for a bit more consistency.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 23 -----------------------
 sound/soc/soc-pcm.c  | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 308895a..9d95ef5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2220,29 +2220,6 @@ int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
 EXPORT_SYMBOL_GPL(snd_soc_test_bits);
 
 /**
- * snd_soc_set_runtime_hwparams - set the runtime hardware parameters
- * @substream: the pcm substream
- * @hw: the hardware parameters
- *
- * Sets the substream runtime hardware parameters.
- */
-int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
-	const struct snd_pcm_hardware *hw)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	runtime->hw.info = hw->info;
-	runtime->hw.formats = hw->formats;
-	runtime->hw.period_bytes_min = hw->period_bytes_min;
-	runtime->hw.period_bytes_max = hw->period_bytes_max;
-	runtime->hw.periods_min = hw->periods_min;
-	runtime->hw.periods_max = hw->periods_max;
-	runtime->hw.buffer_bytes_max = hw->buffer_bytes_max;
-	runtime->hw.fifo_size = hw->fifo_size;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_set_runtime_hwparams);
-
-/**
  * snd_soc_cnew - create new control
  * @_template: control template
  * @data: control private data
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 73bb8ee..058b403 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -33,6 +33,29 @@
 
 #define DPCM_MAX_BE_USERS	8
 
+/**
+ * snd_soc_set_runtime_hwparams - set the runtime hardware parameters
+ * @substream: the pcm substream
+ * @hw: the hardware parameters
+ *
+ * Sets the substream runtime hardware parameters.
+ */
+int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
+	const struct snd_pcm_hardware *hw)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	runtime->hw.info = hw->info;
+	runtime->hw.formats = hw->formats;
+	runtime->hw.period_bytes_min = hw->period_bytes_min;
+	runtime->hw.period_bytes_max = hw->period_bytes_max;
+	runtime->hw.periods_min = hw->periods_min;
+	runtime->hw.periods_max = hw->periods_max;
+	runtime->hw.buffer_bytes_max = hw->buffer_bytes_max;
+	runtime->hw.fifo_size = hw->fifo_size;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_set_runtime_hwparams);
+
 /* DPCM stream event, send event to FE and all active BEs. */
 static int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 	int event)
-- 
1.8.0
