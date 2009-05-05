From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/18] ASoC: Use a shared define for AC97 CODEC
	data formats
Date: Tue,  5 May 2009 11:02:24 +0100
Message-ID: <1241517751-2634-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEBF724525
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:36 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The AC97 wire format is completely fixed so CODECs don't have any choice
about the formats they accept but controllers accept a variety of data
formats and render them down onto the bus.  Have a shared define so all
the CODEC drivers will interoperate with any of our controller drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h   |    3 +++
 sound/soc/codecs/ac97.c   |    4 ++--
 sound/soc/codecs/ad1980.c |    4 ++--
 sound/soc/codecs/wm9705.c |    4 ++--
 sound/soc/codecs/wm9712.c |    6 +++---
 sound/soc/codecs/wm9713.c |    6 +++---
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 22b729f..ea07b4b 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -96,6 +96,9 @@ struct snd_pcm_substream;
 #define SND_SOC_CLOCK_IN		0
 #define SND_SOC_CLOCK_OUT		1
 
+#define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16_LE |\
+                               SNDRV_PCM_FMTBIT_S32_LE)
+
 struct snd_soc_dai_ops;
 struct snd_soc_dai;
 struct snd_ac97_bus_ops;
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index b0d4af1..932299b 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -53,13 +53,13 @@ struct snd_soc_dai ac97_dai = {
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = STD_AC97_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SND_SOC_STD_AC97_FMTS,},
 	.capture = {
 		.stream_name = "AC97 Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = STD_AC97_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &ac97_dai_ops,
 };
 EXPORT_SYMBOL_GPL(ac97_dai);
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index ddb3b08..d7440a9 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -137,13 +137,13 @@ struct snd_soc_dai ad1980_dai = {
 		.channels_min = 2,
 		.channels_max = 6,
 		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+		.formats = SND_SOC_STD_AC97_FMTS, },
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+		.formats = SND_SOC_STD_AC97_FMTS, },
 };
 EXPORT_SYMBOL_GPL(ad1980_dai);
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index c2d1a7a..fa88b46 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -282,14 +282,14 @@ struct snd_soc_dai wm9705_dai[] = {
 			.channels_min = 1,
 			.channels_max = 2,
 			.rates = WM9705_AC97_RATES,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.formats = SND_SOC_STD_AC97_FMTS,
 		},
 		.capture = {
 			.stream_name = "HiFi Capture",
 			.channels_min = 1,
 			.channels_max = 2,
 			.rates = WM9705_AC97_RATES,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.formats = SND_SOC_STD_AC97_FMTS,
 		},
 		.ops = &wm9705_dai_ops,
 	},
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 765cf1e..550c903 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -534,13 +534,13 @@ struct snd_soc_dai wm9712_dai[] = {
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM9712_AC97_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SND_SOC_STD_AC97_FMTS,},
 	.capture = {
 		.stream_name = "HiFi Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM9712_AC97_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &wm9712_dai_ops_hifi,
 },
 {
@@ -550,7 +550,7 @@ struct snd_soc_dai wm9712_dai[] = {
 		.channels_min = 1,
 		.channels_max = 1,
 		.rates = WM9712_AC97_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &wm9712_dai_ops_aux,
 }
 };
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index a6feb78..d1744e9 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1040,13 +1040,13 @@ struct snd_soc_dai wm9713_dai[] = {
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM9713_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SND_SOC_STD_AC97_FMTS,},
 	.capture = {
 		.stream_name = "HiFi Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM9713_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &wm9713_dai_ops_hifi,
 	},
 	{
@@ -1056,7 +1056,7 @@ struct snd_soc_dai wm9713_dai[] = {
 		.channels_min = 1,
 		.channels_max = 1,
 		.rates = WM9713_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &wm9713_dai_ops_aux,
 	},
 	{
-- 
1.6.2.4
