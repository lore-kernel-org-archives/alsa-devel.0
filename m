From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Add checking of SRM lock status before enabling DAI" to the asoc tree
Date: Tue, 10 May 2016 19:49:02 +0100
Message-ID: <E1b0CiM-0006tS-8t@debutante>
References: <5e2ccd9429829fc8cacf94ee8595efa6d11834f4.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e2ccd9429829fc8cacf94ee8595efa6d11834f4.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Add checking of SRM lock status before enabling DAI

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

>From d575b0b0f01a805508c5cf48b540f004e9b5de07 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 10 May 2016 16:11:05 +0100
Subject: [PATCH] ASoC: da7213: Add checking of SRM lock status before enabling
 DAI

When the codec is DAI clk slave, and the SRM feature of the PLL
is being used, the enabling of the DAI should occur only after
the PLL has locked to the incoming WCLK. This update adds checking
to the the DAI widget event, so it waits for SRM to lock. There is
also a timeout if that lock doesn't occur within a given time.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/da7213.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 701bd6204747..680d11116ccf 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -734,6 +734,9 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
+	u8 pll_ctrl, pll_status;
+	int i = 0;
+	bool srm_lock = false;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -742,6 +745,26 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 			snd_soc_update_bits(codec, DA7213_DAI_CLK_MODE,
 					    DA7213_DAI_CLK_EN_MASK,
 					    DA7213_DAI_CLK_EN_MASK);
+
+		/* Slave mode, if SRM not enabled no need for status checks */
+		pll_ctrl = snd_soc_read(codec, DA7213_PLL_CTRL);
+		if (!(pll_ctrl & DA7213_PLL_SRM_EN))
+			return 0;
+
+		/* Check SRM has locked */
+		do {
+			pll_status = snd_soc_read(codec, DA7213_PLL_STATUS);
+			if (pll_status & DA7219_PLL_SRM_LOCK) {
+				srm_lock = true;
+			} else {
+				++i;
+				msleep(50);
+			}
+		} while ((i < DA7213_SRM_CHECK_RETRIES) & (!srm_lock));
+
+		if (!srm_lock)
+			dev_warn(codec->dev, "SRM failed to lock\n");
+
 		return 0;
 	case SND_SOC_DAPM_POST_PMD:
 		/* Disable DAI clks if in master mode */
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 5de5c2997e0c..af75340dea63 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -142,6 +142,9 @@
  * Bit fields
  */
 
+/* DA7213_PLL_STATUS = 0x03 */
+#define DA7219_PLL_SRM_LOCK					(0x1 << 1)
+
 /* DA7213_SR = 0x22 */
 #define DA7213_SR_8000						(0x1 << 0)
 #define DA7213_SR_11025						(0x2 << 0)
@@ -502,6 +505,7 @@
 #define DA7213_PLL_INDIV_10_20_MHZ_VAL	4
 #define DA7213_PLL_INDIV_20_40_MHZ_VAL	8
 #define DA7213_PLL_INDIV_40_54_MHZ_VAL	16
+#define DA7213_SRM_CHECK_RETRIES	8
 
 enum da7213_clk_src {
 	DA7213_CLKSRC_MCLK = 0,
-- 
2.8.1
