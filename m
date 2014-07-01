From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v4 2/8] ASoC: pcm: Refactor soc_pcm_apply_msb
	for multicodecs
Date: Tue,  1 Jul 2014 09:47:55 +0200
Message-ID: <1404200881-32253-3-git-send-email-bcousson@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id AC07A2656BC
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:48:46 +0200 (CEST)
Received: by mail-we0-f170.google.com with SMTP id w61so9186703wes.29
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 00:48:46 -0700 (PDT)
In-Reply-To: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
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

Refactor the function to facilitate the migration to
multiple codecs.

Fix a trailing space in the header as well.

No functional change.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 sound/soc/soc-pcm.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 094676a..ab0712e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2010 Texas Instruments Inc.
  *
  * Authors: Liam Girdwood <lrg@ti.com>
- *          Mark Brown <broonie@opensource.wolfsonmicro.com>       
+ *          Mark Brown <broonie@opensource.wolfsonmicro.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -284,15 +284,10 @@ static int sample_sizes[] = {
 	24, 32,
 };
 
-static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
-			      struct snd_soc_dai *dai)
+static void soc_pcm_set_msb(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai, int bits)
 {
-	int ret, i, bits;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		bits = dai->driver->playback.sig_bits;
-	else
-		bits = dai->driver->capture.sig_bits;
+	int ret, i;
 
 	if (!bits)
 		return;
@@ -310,6 +305,25 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 	}
 }
 
+static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	unsigned int bits = 0, cpu_bits;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		bits = codec_dai->driver->playback.sig_bits;
+		cpu_bits = cpu_dai->driver->playback.sig_bits;
+	} else {
+		bits = codec_dai->driver->capture.sig_bits;
+		cpu_bits = cpu_dai->driver->capture.sig_bits;
+	}
+
+	soc_pcm_set_msb(substream, codec_dai, bits);
+	soc_pcm_set_msb(substream, cpu_dai, cpu_bits);
+}
+
 static void soc_pcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 	struct snd_soc_pcm_stream *codec_stream,
 	struct snd_soc_pcm_stream *cpu_stream)
@@ -433,8 +447,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		goto config_err;
 	}
 
-	soc_pcm_apply_msb(substream, codec_dai);
-	soc_pcm_apply_msb(substream, cpu_dai);
+	soc_pcm_apply_msb(substream);
 
 	/* Symmetry only applies if we've already got an active stream. */
 	if (cpu_dai->active) {
-- 
1.9.1
