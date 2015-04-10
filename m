From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] ASoC: codecs-ac97: Remove rate constraints
Date: Fri, 10 Apr 2015 21:52:42 +0200
Message-ID: <55282A0A.7010804@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Remove rate constraints from generic ASoC AC'97 CODEC and make
it selectable in config.

Supported rates should be detected and constrained anyway by
AC'97 generic code - was tested with VT1613 CODEC and iMX6 SSI
controller.

This way this driver can be used for platforms which don't need
specialized AC'97 CODEC drivers while at the same avoiding
code duplication from implementing equivalent functionality in
a controller driver.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index d0ac723..5b3224c 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -44,10 +44,6 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 	return snd_ac97_set_rate(ac97, reg, substream->runtime->rate);
 }
 
-#define STD_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
-		SNDRV_PCM_RATE_48000)
-
 static const struct snd_soc_dai_ops ac97_dai_ops = {
 	.prepare	= ac97_prepare,
 };
@@ -58,13 +54,13 @@ static struct snd_soc_dai_driver ac97_dai = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = STD_AC97_RATES,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SND_SOC_STD_AC97_FMTS,},
 	.capture = {
 		.stream_name = "AC97 Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = STD_AC97_RATES,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &ac97_dai_ops,
 };
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..84cad9a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -16,7 +16,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_88PM860X if MFD_88PM860X
 	select SND_SOC_L3
 	select SND_SOC_AB8500_CODEC if ABX500_CORE
-	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
+	select SND_SOC_AC97_CODEC
 	select SND_SOC_AD1836 if SPI_MASTER
 	select SND_SOC_AD193X_SPI if SPI_MASTER
 	select SND_SOC_AD193X_I2C if I2C
@@ -211,8 +211,9 @@ config SND_SOC_AB8500_CODEC
 	tristate
 
 config SND_SOC_AC97_CODEC
-	tristate
+	tristate "Build generic ASoC AC97 CODEC driver"
 	select SND_AC97_CODEC
+	select SND_SOC_AC97_BUS
 
 config SND_SOC_AD1836
 	tristate
