From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Add DAI DAPM event to control DAI clocks" to the asoc tree
Date: Tue, 10 May 2016 19:49:05 +0100
Message-ID: <E1b0CiP-0006yB-GT@debutante>
References: <83d4df941ac77554f8d84ce5883bb782b5632000.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83d4df941ac77554f8d84ce5883bb782b5632000.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Add DAI DAPM event to control DAI clocks

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

>From a0d5caeaebfd00853efa0080afc850e10be7b39a Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 10 May 2016 16:11:04 +0100
Subject: [PATCH] ASoC: da7213: Add DAI DAPM event to control DAI clocks

Currently, when Codec is I2S master DAI clocks are continuously
generated even if all audio streams have stopped. To improve
efficiency, control of the DAI clocks for master mode have been
moved to a DAPM widget event so they're only enabled as required.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 35 ++++++++++++++++++++++++++++++++---
 sound/soc/codecs/da7213.h |  2 --
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 7278f93460c1..701bd6204747 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -726,6 +726,36 @@ static const struct snd_kcontrol_new da7213_dapm_mixoutr_controls[] = {
 
 
 /*
+ * DAPM Events
+ */
+
+static int da7213_dai_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Enable DAI clks for master mode */
+		if (da7213->master)
+			snd_soc_update_bits(codec, DA7213_DAI_CLK_MODE,
+					    DA7213_DAI_CLK_EN_MASK,
+					    DA7213_DAI_CLK_EN_MASK);
+		return 0;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Disable DAI clks if in master mode */
+		if (da7213->master)
+			snd_soc_update_bits(codec, DA7213_DAI_CLK_MODE,
+					    DA7213_DAI_CLK_EN_MASK, 0);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+
+/*
  * DAPM widgets
  */
 
@@ -736,7 +766,8 @@ static const struct snd_soc_dapm_widget da7213_dapm_widgets[] = {
 
 	/* Use a supply here as this controls both input & output DAIs */
 	SND_SOC_DAPM_SUPPLY("DAI", DA7213_DAI_CTRL, DA7213_DAI_EN_SHIFT,
-			    DA7213_NO_INVERT, NULL, 0),
+			    DA7213_NO_INVERT, da7213_dai_event,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/*
 	 * Input
@@ -1143,11 +1174,9 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* Set master/slave mode */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		dai_clk_mode |= DA7213_DAI_CLK_EN_MASTER_MODE;
 		da7213->master = true;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		dai_clk_mode |= DA7213_DAI_CLK_EN_SLAVE_MODE;
 		da7213->master = false;
 		break;
 	default:
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 030fd691b076..5de5c2997e0c 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -178,8 +178,6 @@
 #define DA7213_DAI_BCLKS_PER_WCLK_MASK				(0x3 << 0)
 #define DA7213_DAI_CLK_POL_INV					(0x1 << 2)
 #define DA7213_DAI_WCLK_POL_INV					(0x1 << 3)
-#define DA7213_DAI_CLK_EN_SLAVE_MODE				(0x0 << 7)
-#define DA7213_DAI_CLK_EN_MASTER_MODE				(0x1 << 7)
 #define DA7213_DAI_CLK_EN_MASK					(0x1 << 7)
 
 /* DA7213_DAI_CTRL = 0x29 */
-- 
2.8.1
