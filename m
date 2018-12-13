From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3060: Add powersaving widgets for DAC and ADC" to the asoc tree
Date: Thu, 13 Dec 2018 18:11:12 +0000 (GMT)
Message-ID: <20181213181112.3561611254D1@debutante.sirena.org.uk>
References: <20181207190234.12040-1-kmarinushkin@birdec.tech>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207190234.12040-1-kmarinushkin@birdec.tech>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3060: Add powersaving widgets for DAC and ADC

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bb9963b850ea9e1ef39f4368eae83a9462f60166 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Fri, 7 Dec 2018 20:02:34 +0100
Subject: [PATCH] ASoC: pcm3060: Add powersaving widgets for DAC and ADC

Enable DAC/ADC only when playing/capturing

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 14 ++++++++++----
 sound/soc/codecs/pcm3060.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 1dd851a7b43b..6714aa8d9026 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -198,19 +198,25 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", PCM3060_REG64,
+			 PCM3060_REG_SHIFT_DAPSV, 1),
+
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 
 	SND_SOC_DAPM_INPUT("INL"),
 	SND_SOC_DAPM_INPUT("INR"),
+
+	SND_SOC_DAPM_ADC("ADC", "Capture", PCM3060_REG64,
+			 PCM3060_REG_SHIFT_ADPSV, 1),
 };
 
 static const struct snd_soc_dapm_route pcm3060_dapm_map[] = {
-	{ "OUTL", NULL, "Playback" },
-	{ "OUTR", NULL, "Playback" },
+	{ "OUTL", NULL, "DAC" },
+	{ "OUTR", NULL, "DAC" },
 
-	{ "Capture", NULL, "INL" },
-	{ "Capture", NULL, "INR" },
+	{ "ADC", NULL, "INL" },
+	{ "ADC", NULL, "INR" },
 };
 
 /* soc component */
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index c895cf40ee10..6a027b4a845d 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -37,7 +37,9 @@ int pcm3060_remove(struct device *dev);
 #define PCM3060_REG_MRST		0x80
 #define PCM3060_REG_SRST		0x40
 #define PCM3060_REG_ADPSV		0x20
+#define PCM3060_REG_SHIFT_ADPSV	0x05
 #define PCM3060_REG_DAPSV		0x10
+#define PCM3060_REG_SHIFT_DAPSV	0x04
 #define PCM3060_REG_SE			0x01
 
 #define PCM3060_REG65			0x41
-- 
2.19.0.rc2
