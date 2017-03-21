From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Update bxt_da7219_max98357a to
	add a new" to the asoc tree
Date: Tue, 21 Mar 2017 18:45:21 +0000
Message-ID: <E1cqOmX-00014I-LE@debutante>
References: <1489620505-24841-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3754B267186
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 19:45:35 +0100 (CET)
In-Reply-To: <1489620505-24841-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, sathyanarayana.nujella@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Update bxt_da7219_max98357a to add a new

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

>From d7fba9dcf6cd74cb8a8ab1c4c2629a3f7df00bc9 Mon Sep 17 00:00:00 2001
From: Harsha Priya <harshapriya.n@intel.com>
Date: Wed, 15 Mar 2017 16:28:25 -0700
Subject: [PATCH] ASoC: Intel: Update bxt_da7219_max98357a to add a new

This patch adds a platform clock widget to turn off the clock only when
both headset capture and headset playback are not in use. This removes
turning off the clock in hw_free so that the clock is on when
either capture or playback of headset is in progress.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 97 +++++++++++++++------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 2cda06cde4d1..3a8c4d954a91 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -55,6 +55,54 @@ enum {
 	BXT_DPCM_AUDIO_HDMI3_PB,
 };
 
+static inline struct snd_soc_dai *bxt_get_codec_dai(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+
+		if (!strncmp(rtd->codec_dai->name, BXT_DIALOG_CODEC_DAI,
+			     strlen(BXT_DIALOG_CODEC_DAI)))
+			return rtd->codec_dai;
+	}
+
+	return NULL;
+}
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int  event)
+{
+	int ret = 0;
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *codec_dai;
+
+	codec_dai = bxt_get_codec_dai(card);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found; Unable to set/unset codec pll\n");
+		return -EIO;
+	}
+
+	if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		ret = snd_soc_dai_set_pll(codec_dai, 0,
+			DA7219_SYSCLK_MCLK, 0, 0);
+		if (ret)
+			dev_err(card->dev, "failed to stop PLL: %d\n", ret);
+	} else if(SND_SOC_DAPM_EVENT_ON(event)) {
+		ret = snd_soc_dai_set_sysclk(codec_dai,
+                        DA7219_CLKSRC_MCLK, 19200000, SND_SOC_CLOCK_IN);
+		if (ret)
+			dev_err(card->dev, "can't set codec sysclk configuration\n");
+
+		ret = snd_soc_dai_set_pll(codec_dai, 0,
+			DA7219_SYSCLK_PLL_SRM, 0, DA7219_PLL_FREQ_OUT_98304);
+		if (ret)
+			dev_err(card->dev, "failed to start PLL: %d\n", ret);
+	}
+
+	return ret;
+}
+
 static const struct snd_kcontrol_new broxton_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -69,6 +117,8 @@ static const struct snd_soc_dapm_widget broxton_widgets[] = {
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
 	SND_SOC_DAPM_SPK("HDMI3", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control,	SND_SOC_DAPM_POST_PMD|SND_SOC_DAPM_PRE_PMU),
 };
 
 static const struct snd_soc_dapm_route broxton_map[] = {
@@ -109,6 +159,9 @@ static const struct snd_soc_dapm_route broxton_map[] = {
 	/* DMIC */
 	{"dmic01_hifi", NULL, "DMIC01 Rx"},
 	{"DMIC01 Rx", NULL, "DMIC AIF"},
+
+	{ "Headphone Jack", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
 };
 
 static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -243,49 +296,6 @@ static const struct snd_soc_ops broxton_da7219_fe_ops = {
 	.startup = bxt_fe_startup,
 };
 
-static int broxton_da7219_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	ret = snd_soc_dai_set_sysclk(codec_dai,
-			DA7219_CLKSRC_MCLK, 19200000, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		dev_err(codec_dai->dev, "can't set codec sysclk configuration\n");
-
-	ret = snd_soc_dai_set_pll(codec_dai, 0,
-			DA7219_SYSCLK_PLL_SRM, 0, DA7219_PLL_FREQ_OUT_98304);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "failed to start PLL: %d\n", ret);
-		return -EIO;
-	}
-
-	return ret;
-}
-
-static int broxton_da7219_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	ret = snd_soc_dai_set_pll(codec_dai, 0,
-			DA7219_SYSCLK_MCLK, 0, 0);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "failed to stop PLL: %d\n", ret);
-		return -EIO;
-	}
-
-	return ret;
-}
-
-static const struct snd_soc_ops broxton_da7219_ops = {
-	.hw_params = broxton_da7219_hw_params,
-	.hw_free = broxton_da7219_hw_free,
-};
-
 static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
@@ -467,7 +477,6 @@ static struct snd_soc_dai_link broxton_dais[] = {
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = broxton_ssp_fixup,
-		.ops = &broxton_da7219_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 	},
-- 
2.11.0
