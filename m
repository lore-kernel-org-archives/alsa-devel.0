From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v2] ASoC: Intel: Update bxt_da7219_max98357a to
	add a new
Date: Wed, 15 Mar 2017 16:28:25 -0700
Message-ID: <1489620505-24841-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 546EA2670AF
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 00:28:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, vinod.koul@intel.com, alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, sathyanarayana.nujella@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds a platform clock widget to turn off the clock only when
both headset capture and headset playback are not in use. This removes
turning off the clock in hw_free so that the clock is on when
either capture or playback of headset is in progress.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 97 +++++++++++++++------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 2cda06c..3a8c4d9 100644
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
@@ -69,6 +117,8 @@ enum {
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
 	SND_SOC_DAPM_SPK("HDMI3", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control,	SND_SOC_DAPM_POST_PMD|SND_SOC_DAPM_PRE_PMU),
 };
 
 static const struct snd_soc_dapm_route broxton_map[] = {
@@ -109,6 +159,9 @@ enum {
 	/* DMIC */
 	{"dmic01_hifi", NULL, "DMIC01 Rx"},
 	{"DMIC01 Rx", NULL, "DMIC AIF"},
+
+	{ "Headphone Jack", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
 };
 
 static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -243,49 +296,6 @@ static int bxt_fe_startup(struct snd_pcm_substream *substream)
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
@@ -467,7 +477,6 @@ static int broxton_refcap_startup(struct snd_pcm_substream *substream)
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = broxton_ssp_fixup,
-		.ops = &broxton_da7219_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 	},
-- 
1.9.1
