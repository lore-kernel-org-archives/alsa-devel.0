From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Default PC counter to free-running when DAI disabled" to the asoc tree
Date: Tue, 10 May 2016 19:48:59 +0100
Message-ID: <E1b0CiJ-0006ol-4V@debutante>
References: <167258fc9e46971ab2da1fc934e17976cc47678f.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <167258fc9e46971ab2da1fc934e17976cc47678f.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Default PC counter to free-running when DAI disabled

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

>From 7e28fd469624fc41ec326a31abbc63a7afdd10f5 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 10 May 2016 16:11:06 +0100
Subject: [PATCH] ASoC: da7213: Default PC counter to free-running when DAI
 disabled

Currently PC counter is always synchronised to DAI which means that
when the DAI is disabled, features such as ALC calibration cannot
be executed successfully. This patch makes sure that when the DAI
is disabled, PC counter is set to free-running.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 13 +++++++++++++
 sound/soc/codecs/da7213.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 680d11116ccf..657b7eba9954 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -746,6 +746,10 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 					    DA7213_DAI_CLK_EN_MASK,
 					    DA7213_DAI_CLK_EN_MASK);
 
+		/* PC synchronised to DAI */
+		snd_soc_update_bits(codec, DA7213_PC_COUNT,
+				    DA7213_PC_FREERUN_MASK, 0);
+
 		/* Slave mode, if SRM not enabled no need for status checks */
 		pll_ctrl = snd_soc_read(codec, DA7213_PLL_CTRL);
 		if (!(pll_ctrl & DA7213_PLL_SRM_EN))
@@ -767,6 +771,11 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 
 		return 0;
 	case SND_SOC_DAPM_POST_PMD:
+		/* PC free-running */
+		snd_soc_update_bits(codec, DA7213_PC_COUNT,
+				    DA7213_PC_FREERUN_MASK,
+				    DA7213_PC_FREERUN_MASK);
+
 		/* Disable DAI clks if in master mode */
 		if (da7213->master)
 			snd_soc_update_bits(codec, DA7213_DAI_CLK_MODE,
@@ -1599,6 +1608,10 @@ static int da7213_probe(struct snd_soc_codec *codec)
 	/* Default to using SRM for slave mode */
 	da7213->srm_en = true;
 
+	/* Default PC counter to free-running */
+	snd_soc_update_bits(codec, DA7213_PC_COUNT, DA7213_PC_FREERUN_MASK,
+			    DA7213_PC_FREERUN_MASK);
+
 	/* Enable all Gain Ramps */
 	snd_soc_update_bits(codec, DA7213_AUX_L_CTRL,
 			    DA7213_GAIN_RAMP_EN, DA7213_GAIN_RAMP_EN);
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index af75340dea63..26b87e3c3088 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -413,6 +413,9 @@
 #define DA7213_DMIC_CLK_RATE_SHIFT				2
 #define DA7213_DMIC_CLK_RATE_MASK				(0x1 << 2)
 
+/* DA7213_PC_COUNT = 0x94 */
+#define DA7213_PC_FREERUN_MASK					(0x1 << 0)
+
 /* DA7213_DIG_CTRL = 0x99 */
 #define DA7213_DAC_L_INV_SHIFT					3
 #define DA7213_DAC_R_INV_SHIFT					7
-- 
2.8.1
