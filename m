From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: stac9766: Remove
	ac97_read/ac97_write wrappers
Date: Fri,  4 Nov 2016 18:26:57 +0100
Message-ID: <1478280417-24832-5-git-send-email-lars@metafoo.de>
References: <1478280417-24832-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D7E52674E8
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:27:17 +0100 (CET)
In-Reply-To: <1478280417-24832-1-git-send-email-lars@metafoo.de>
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

Since the regmap conversion ac97_read/ac97_write are just simple wrappers
around snd_soc_read/snd_soc_write. Use those instead directly and remove
the wrappers.

Also use snd_soc_update_bits() where appropriate.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/stac9766.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 62cbeed..9de7fe8 100644
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
2.1.4
