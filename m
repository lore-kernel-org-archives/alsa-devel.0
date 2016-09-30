From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: wm9712: Remove ac97_read/ac97_write
	wrappers
Date: Fri, 30 Sep 2016 19:27:30 +0200
Message-ID: <1475256450-30612-2-git-send-email-lars@metafoo.de>
References: <1475256450-30612-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C29F42668F1
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 19:27:41 +0200 (CEST)
In-Reply-To: <1475256450-30612-1-git-send-email-lars@metafoo.de>
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
Cc: Marek Vasut <marex@denx.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since the regmap conversion ac97_read/ac97_write are just simple wrappers
around snd_soc_read/snd_soc_write. Use those instead directly and remove
the wrappers. Also use snd_soc_update_bits() were appropriate.

Tested-by: Marek Vasut <marex@denx.de>
Acked-by: Marek Vasut <marex@denx.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9712.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index d2d0d2b..20b2e82 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -521,53 +521,36 @@ static const struct snd_soc_dapm_route wm9712_audio_map[] = {
 	{"ROUT2", NULL, "Speaker PGA"},
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	return snd_soc_read(codec, reg);
-}
-
-static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int val)
-{
-	return snd_soc_write(codec, reg, val);
-}
-
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	int reg;
-	u16 vra;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x1, 0x1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return ac97_write(codec, reg, runtime->rate);
+	return snd_soc_write(codec, reg, runtime->rate);
 }
 
 static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 vra, xsle;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
-	xsle = ac97_read(codec, AC97_PCI_SID);
-	ac97_write(codec, AC97_PCI_SID, xsle | 0x8000);
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x1, 0x1);
+	snd_soc_update_bits(codec, AC97_PCI_SID, 0x8000, 0x8000);
 
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 
-	return ac97_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
+	return snd_soc_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
 }
 
 #define WM9712_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
@@ -619,12 +602,12 @@ static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		ac97_write(codec, AC97_POWERDOWN, 0x0000);
+		snd_soc_write(codec, AC97_POWERDOWN, 0x0000);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* disable everything including AC link */
-		ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
-		ac97_write(codec, AC97_POWERDOWN, 0xffff);
+		snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
+		snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
 	return 0;
@@ -671,7 +654,7 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_codec_init_regmap(codec, regmap);
 
 	/* set alc mux to none */
-	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
+	snd_soc_update_bits(codec, AC97_VIDEO, 0x3000, 0x3000);
 
 	return 0;
 err_free_ac97_codec:
-- 
2.1.4
