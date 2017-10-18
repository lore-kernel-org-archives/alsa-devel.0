From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: use helper to get
	codec_dai" to the asoc tree
Date: Wed, 18 Oct 2017 12:31:11 +0100
Message-ID: <E1e4mZ5-0003v6-W4@debutante>
References: <20171012233805.30055-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 71B3F26744F
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 13:31:21 +0200 (CEST)
In-Reply-To: <20171012233805.30055-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: use helper to get codec_dai

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

>From dfb6ec7ae57d33d2854a1af2dfe1278da8a7dedc Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:38:03 -0500
Subject: [PATCH] ASoC: Intel: boards: use helper to get codec_dai

Remove duplicate code with a common helper in all Intel machine drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c   | 16 +---------------
 sound/soc/intel/boards/bytcr_rt5640.c           | 21 ++++-----------------
 sound/soc/intel/boards/bytcr_rt5651.c           | 14 +-------------
 sound/soc/intel/boards/cht_bsw_max98090_ti.c    | 14 +-------------
 sound/soc/intel/boards/cht_bsw_rt5645.c         | 20 ++++----------------
 sound/soc/intel/boards/cht_bsw_rt5672.c         | 14 +-------------
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 16 +---------------
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 16 +---------------
 8 files changed, 14 insertions(+), 117 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index ce35ec7884d1..f8a91a6f2a17 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -55,20 +55,6 @@ enum {
 	BXT_DPCM_AUDIO_HDMI3_PB,
 };
 
-static inline struct snd_soc_dai *bxt_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-
-		if (!strncmp(rtd->codec_dai->name, BXT_DIALOG_CODEC_DAI,
-			     strlen(BXT_DIALOG_CODEC_DAI)))
-			return rtd->codec_dai;
-	}
-
-	return NULL;
-}
-
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int  event)
 {
@@ -77,7 +63,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dai *codec_dai;
 
-	codec_dai = bxt_get_codec_dai(card);
+	codec_dai = snd_soc_card_get_codec_dai(card, BXT_DIALOG_CODEC_DAI);
 	if (!codec_dai) {
 		dev_err(card->dev, "Codec dai not found; Unable to set/unset codec pll\n");
 		return -EIO;
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index ffb3ca971df4..339842adceed 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -145,22 +145,6 @@ static void log_quirks(struct device *dev)
 #define BYT_CODEC_DAI1	"rt5640-aif1"
 #define BYT_CODEC_DAI2	"rt5640-aif2"
 
-static inline struct snd_soc_dai *byt_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI1,
-			     strlen(BYT_CODEC_DAI1)))
-			return rtd->codec_dai;
-		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI2,
-				strlen(BYT_CODEC_DAI2)))
-			return rtd->codec_dai;
-
-	}
-	return NULL;
-}
-
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *k, int  event)
 {
@@ -170,7 +154,10 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
-	codec_dai = byt_get_codec_dai(card);
+	codec_dai = snd_soc_card_get_codec_dai(card, BYT_CODEC_DAI1);
+	if (!codec_dai)
+		codec_dai = snd_soc_card_get_codec_dai(card, BYT_CODEC_DAI2);
+
 	if (!codec_dai) {
 		dev_err(card->dev,
 			"Codec dai not found; Unable to set platform clock\n");
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e094a58d750d..dc158466bd92 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -68,18 +68,6 @@ static void log_quirks(struct device *dev)
 
 #define BYT_CODEC_DAI1	"rt5651-aif1"
 
-static inline struct snd_soc_dai *byt_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI1,
-			     strlen(BYT_CODEC_DAI1)))
-			return rtd->codec_dai;
-	}
-	return NULL;
-}
-
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *k, int  event)
 {
@@ -89,7 +77,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
-	codec_dai = byt_get_codec_dai(card);
+	codec_dai = snd_soc_card_get_codec_dai(card, BYT_CODEC_DAI1);
 	if (!codec_dai) {
 		dev_err(card->dev,
 			"Codec dai not found; Unable to set platform clock\n");
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index a23eba7bb056..c2e3b00ec89d 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -41,18 +41,6 @@ struct cht_mc_private {
 	bool ts3a227e_present;
 };
 
-static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
-			     strlen(CHT_CODEC_DAI)))
-			return rtd->codec_dai;
-	}
-	return NULL;
-}
-
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
 					  struct snd_kcontrol *k, int  event)
 {
@@ -62,7 +50,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 	int ret;
 
-	codec_dai = cht_get_codec_dai(card);
+	codec_dai = snd_soc_card_get_codec_dai(card, CHT_CODEC_DAI);
 	if (!codec_dai) {
 		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
 		return -EIO;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 6ccb599c1082..546f4abf2562 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -70,21 +70,6 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk SSP0_AIF2 enabled");
 }
 
-static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI1,
-			     strlen(CHT_CODEC_DAI1)))
-			return rtd->codec_dai;
-		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI2,
-			     strlen(CHT_CODEC_DAI2)))
-			return rtd->codec_dai;
-	}
-	return NULL;
-}
-
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *k, int  event)
 {
@@ -94,7 +79,10 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 	int ret;
 
-	codec_dai = cht_get_codec_dai(card);
+	codec_dai = snd_soc_card_get_codec_dai(card, CHT_CODEC_DAI1);
+	if (!codec_dai)
+		codec_dai = snd_soc_card_get_codec_dai(card, CHT_CODEC_DAI2);
+
 	if (!codec_dai) {
 		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
 		return -EIO;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index f799b76fdedf..1dffe76d5a85 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -50,18 +50,6 @@ static struct snd_soc_jack_pin cht_bsw_headset_pins[] = {
 	},
 };
 
-static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
-			     strlen(CHT_CODEC_DAI)))
-			return rtd->codec_dai;
-	}
-	return NULL;
-}
-
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *k, int  event)
 {
@@ -71,7 +59,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 	int ret;
 
-	codec_dai = cht_get_codec_dai(card);
+	codec_dai = snd_soc_card_get_codec_dai(card, CHT_CODEC_DAI);
 	if (!codec_dai) {
 		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
 		return -EIO;
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 5ed0aa27b467..1b5a689dc99b 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -54,20 +54,6 @@ enum {
 	SKL_DPCM_AUDIO_HDMI3_PB,
 };
 
-static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-
-		if (!strncmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI,
-			     strlen(SKL_NUVOTON_CODEC_DAI)))
-			return rtd->codec_dai;
-	}
-
-	return NULL;
-}
-
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int  event)
 {
@@ -76,7 +62,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dai *codec_dai;
 	int ret;
 
-	codec_dai = skl_get_codec_dai(card);
+	codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
 	if (!codec_dai) {
 		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
 		return -EIO;
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 01b8b140bb08..7bea4bc77481 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -57,20 +57,6 @@ enum {
 	SKL_DPCM_AUDIO_HDMI3_PB,
 };
 
-static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-
-		if (!strncmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI,
-			     strlen(SKL_NUVOTON_CODEC_DAI)))
-			return rtd->codec_dai;
-	}
-
-	return NULL;
-}
-
 static const struct snd_kcontrol_new skylake_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -86,7 +72,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dai *codec_dai;
 	int ret;
 
-	codec_dai = skl_get_codec_dai(card);
+	codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
 	if (!codec_dai) {
 		dev_err(card->dev, "Codec dai not found\n");
 		return -EIO;
-- 
2.14.1
