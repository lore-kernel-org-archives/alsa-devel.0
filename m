From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9712: Remove ac97_read/ac97_write
	wrappers" to the asoc tree
Date: Tue, 04 Oct 2016 11:26:29 +0200
Message-ID: <E1brLzZ-0003QU-C4@finisterre>
References: <1475256450-30612-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C37842666B0
 for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2016 11:26:58 +0200 (CEST)
In-Reply-To: <1475256450-30612-2-git-send-email-lars@metafoo.de>
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
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9712: Remove ac97_read/ac97_write wrappers

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

>From c2d22cd8f356ce37cce2663542fa7bc16cdae4df Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 30 Sep 2016 19:27:30 +0200
Subject: [PATCH] ASoC: wm9712: Remove ac97_read/ac97_write wrappers

Since the regmap conversion ac97_read/ac97_write are just simple wrappers
around snd_soc_read/snd_soc_write. Use those instead directly and remove
the wrappers. Also use snd_soc_update_bits() were appropriate.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Marek Vasut <marex@denx.de>
Acked-by: Marek Vasut <marex@denx.de>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9712.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index d2d0d2bb4412..20b2e8216336 100644
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
2.9.3
