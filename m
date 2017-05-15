From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: disable asymmetric audio interface format" to the asoc tree
Date: Mon, 15 May 2017 17:03:42 +0900
Message-ID: <E1dAAyl-0002Vo-06@finisterre>
References: <87o9v4ccid.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87o9v4ccid.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: disable asymmetric audio interface format

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

>From ec185f95401e36f398b39706705f10d7fe7ff058 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 May 2017 02:28:13 +0000
Subject: [PATCH] ASoC: ak4613: disable asymmetric audio interface format

Asymmetric audio interface formats exist in ak4613 by same
register settings.

	Capture		Playback
	24bit LEFT_J	16bit RIGHT_J
	24bit LEFT_J	20bit RIGHT_J
	24bit LEFT_J	24bit RIGHT_J
	24bit LEFT_J	24bit LEFT_J
	24bit I2S	24bit I2S

These asymmetric formats makes driver / behavior difficult.
It is not HW limitation, but SW limitation. To makes code reading
easy, this patch removes asymmetric format support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index b2dfddead227..557ac16d43e2 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -139,9 +139,7 @@ static const struct reg_default ak4613_reg[] = {
 #define AUDIO_IFACE(b, fmt) { b, SND_SOC_DAIFMT_##fmt }
 static const struct ak4613_interface ak4613_iface[] = {
 	/* capture */				/* playback */
-	[0] = {	AUDIO_IFACE(24, LEFT_J),	AUDIO_IFACE(16, RIGHT_J) },
-	[1] = {	AUDIO_IFACE(24, LEFT_J),	AUDIO_IFACE(20, RIGHT_J) },
-	[2] = {	AUDIO_IFACE(24, LEFT_J),	AUDIO_IFACE(24, RIGHT_J) },
+	/* [0] - [2] are not supported */
 	[3] = {	AUDIO_IFACE(24, LEFT_J),	AUDIO_IFACE(24, LEFT_J) },
 	[4] = {	AUDIO_IFACE(24, I2S),		AUDIO_IFACE(24, I2S) },
 };
@@ -262,11 +260,9 @@ static int ak4613_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	fmt &= SND_SOC_DAIFMT_FORMAT_MASK;
 
 	switch (fmt) {
-	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_I2S:
 		priv->fmt = fmt;
-
 		break;
 	default:
 		return -EINVAL;
@@ -286,13 +282,8 @@ static bool ak4613_dai_fmt_matching(const struct ak4613_interface *iface,
 	if (fmts->fmt != fmt)
 		return false;
 
-	if (fmt == SND_SOC_DAIFMT_RIGHT_J) {
-		if (fmts->width != width)
-			return false;
-	} else {
-		if (fmts->width < width)
-			return false;
-	}
+	if (fmts->width != width)
+		return false;
 
 	return true;
 }
@@ -420,8 +411,7 @@ static const struct snd_soc_dai_ops ak4613_dai_ops = {
 				 SNDRV_PCM_RATE_96000  |\
 				 SNDRV_PCM_RATE_176400 |\
 				 SNDRV_PCM_RATE_192000)
-#define AK4613_PCM_FMTBIT	(SNDRV_PCM_FMTBIT_S16_LE |\
-				 SNDRV_PCM_FMTBIT_S24_LE)
+#define AK4613_PCM_FMTBIT	(SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_driver ak4613_dai = {
 	.name = "ak4613-hifi",
-- 
2.11.0
