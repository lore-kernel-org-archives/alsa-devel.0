From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stac9766: Remove ac97_read/ac97_write
	wrappers" to the asoc tree
Date: Fri, 04 Nov 2016 12:16:05 -0600
Message-ID: <E1c2j25-000845-KF@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8612674D5
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 19:16:25 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stac9766: Remove ac97_read/ac97_write wrappers

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7aacbc7ff7f6da9ec6deb833154f0883497ab82f Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 4 Nov 2016 18:26:57 +0100
Subject: [PATCH] ASoC: stac9766: Remove ac97_read/ac97_write wrappers

Since the regmap conversion ac97_read/ac97_write are just simple wrappers
around snd_soc_read/snd_soc_write. Use those instead directly and remove
the wrappers.

Also use snd_soc_update_bits() where appropriate.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/stac9766.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 62cbeedf93b9..9de7fe8af255 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -165,38 +165,22 @@ static const struct snd_kcontrol_new stac9766_snd_ac97_controls[] = {
 	SOC_ENUM("Pop Bypass Mux", stac9766_popbypass_enum),
 };
 
-static int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-			       unsigned int val)
-{
-	return snd_soc_write(codec, reg, val);
-}
-
-static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
-				       unsigned int reg)
-{
-	return snd_soc_read(codec, reg);
-}
-
 static int ac97_analog_prepare(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned short reg, vra;
-
-	vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
+	unsigned short reg;
 
-	vra |= 0x1; /* enable variable rate audio */
-	vra &= ~0x4; /* disable SPDIF output */
-
-	stac9766_ac97_write(codec, AC97_EXTENDED_STATUS, vra);
+	/* enable variable rate audio, disable SPDIF output */
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x5, 0x1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return stac9766_ac97_write(codec, reg, runtime->rate);
+	return snd_soc_write(codec, reg, runtime->rate);
 }
 
 static int ac97_digital_prepare(struct snd_pcm_substream *substream,
@@ -204,18 +188,16 @@ static int ac97_digital_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned short reg, vra;
-
-	stac9766_ac97_write(codec, AC97_SPDIF, 0x2002);
+	unsigned short reg;
 
-	vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
-	vra |= 0x5; /* Enable VRA and SPDIF out */
+	snd_soc_write(codec, AC97_SPDIF, 0x2002);
 
-	stac9766_ac97_write(codec, AC97_EXTENDED_STATUS, vra);
+	/* Enable VRA and SPDIF out */
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x5, 0x5);
 
 	reg = AC97_PCM_FRONT_DAC_RATE;
 
-	return stac9766_ac97_write(codec, reg, runtime->rate);
+	return snd_soc_write(codec, reg, runtime->rate);
 }
 
 static int stac9766_set_bias_level(struct snd_soc_codec *codec,
@@ -225,11 +207,11 @@ static int stac9766_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_ON: /* full On */
 	case SND_SOC_BIAS_PREPARE: /* partial On */
 	case SND_SOC_BIAS_STANDBY: /* Off, with power */
-		stac9766_ac97_write(codec, AC97_POWERDOWN, 0x0000);
+		snd_soc_write(codec, AC97_POWERDOWN, 0x0000);
 		break;
 	case SND_SOC_BIAS_OFF: /* Off, without power */
 		/* disable everything including AC link */
-		stac9766_ac97_write(codec, AC97_POWERDOWN, 0xffff);
+		snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
 	return 0;
-- 
2.10.1
