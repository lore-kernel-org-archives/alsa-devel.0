From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 7/7] ASoC: Intel: eve: Enable mclk and ssp sclk early
Date: Mon, 18 Sep 2017 10:26:50 +0530
Message-ID: <1505710610-17952-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, patches.audio@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, harshapriya.n@intel.com, Naveen M <naveen.m@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Naveen M <naveen.m@intel.com>

rt5663 needs mclk/sclk early to synchronize its internal clocks. Clocks
are enabled in hw_params and disabled in platform_clk_control as the codec
requires mclk/bclk need to turned ON before set_sysclk call for a
successful clock synchronization.

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/Kconfig                            |  1 +
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 97 ++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 6f05119e9df2..8a29c10d4f6b 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -259,6 +259,7 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         depends on X86_INTEL_LPSS && I2C && SPI
         select SND_SOC_INTEL_SST
         select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_INTEL_SKYLAKE_SSP_CLK
         select SND_SOC_RT5663
         select SND_SOC_RT5514
         select SND_SOC_RT5514_SPI
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 88ff54220007..ab7ae12da960 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -30,6 +30,9 @@
 #include "../../codecs/rt5663.h"
 #include "../../codecs/hdac_hdmi.h"
 #include "../skylake/skl.h"
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 
 #define KBL_REALTEK_CODEC_DAI "rt5663-aif"
 #define KBL_REALTEK_DMIC_CODEC_DAI "rt5514-aif1"
@@ -58,6 +61,8 @@ struct kbl_codec_private {
 	struct snd_soc_jack kabylake_headset;
 	struct list_head hdmi_pcm_list;
 	struct snd_soc_jack kabylake_hdmi[2];
+	struct clk *mclk;
+	struct clk *sclk;
 };
 
 enum {
@@ -79,6 +84,19 @@ enum {
 	SOC_DAPM_PIN_SWITCH("DMIC"),
 };
 
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct kbl_codec_private *priv = snd_soc_card_get_drvdata(card);
+
+	clk_disable_unprepare(priv->mclk);
+	clk_disable_unprepare(priv->sclk);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -87,11 +105,14 @@ enum {
 	SND_SOC_DAPM_MIC("DMIC", NULL),
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_POST_PMD),
 
 };
 
 static const struct snd_soc_dapm_route kabylake_map[] = {
 	/* Headphones */
+	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
 
@@ -100,6 +121,7 @@ enum {
 	{ "Right Spk", NULL, "Right BE_OUT" },
 
 	/* other jacks */
+	{ "Headset Mic", NULL, "Platform Clock" },
 	{ "IN1P", NULL, "Headset Mic" },
 	{ "IN1N", NULL, "Headset Mic" },
 
@@ -324,13 +346,59 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static int kabylake_enable_ssp_clks(struct snd_soc_card *card)
+{
+
+	struct kbl_codec_private *priv = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	/* Enable MCLK */
+	ret = clk_set_rate(priv->mclk, 24000000);
+	if (ret < 0) {
+		dev_err(card->dev, "Can't set rate for mclk, err: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->mclk);
+	if (ret < 0) {
+		dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable SCLK */
+	ret = clk_set_rate(priv->sclk, 3072000);
+	if (ret < 0) {
+		dev_err(card->dev, "Can't set rate for sclk, err: %d\n", ret);
+		clk_disable_unprepare(priv->mclk);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->sclk);
+	if (ret < 0) {
+		dev_err(card->dev, "Can't enable sclk, err: %d\n", ret);
+		clk_disable_unprepare(priv->mclk);
+	}
+
+	return 0;
+}
+
 static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_card *card = rtd->card;
 	int ret;
 
+	/*
+	 * MCLK/SCLK need to be ON early for a successful synchronization of
+	 * codec internal clock. And the clocks are turned off during
+	 * POST_PMD after the stream is stopped.
+	 */
+	ret = kabylake_enable_ssp_clks(card);
+	if (ret < 0)
+		return ret;
+
 	/* use ASRC for internal clocks, as PLL rate isn't multiple of BCLK */
 	rt5663_sel_asrc_clk_src(codec_dai->codec,
 			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
@@ -647,6 +715,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_codec_private *ctx;
 	struct skl_machine_pdata *pdata;
+	int ret = 0;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx)
@@ -662,6 +731,34 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 		dmic_constraints = pdata->dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
+	ctx->mclk = devm_clk_get(&pdev->dev, "ssp1_mclk");
+	if (IS_ERR(ctx->mclk)) {
+		ret = PTR_ERR(ctx->mclk);
+		if (ret == -ENOENT) {
+			dev_info(&pdev->dev,
+				"Failed to get ssp1_mclk, defer probe\n");
+			return -EPROBE_DEFER;
+		}
+
+		dev_err(&pdev->dev, "Failed to get ssp1_mclk with err:%d\n",
+								ret);
+		return ret;
+	}
+
+	ctx->sclk = devm_clk_get(&pdev->dev, "ssp1_sclk");
+	if (IS_ERR(ctx->sclk)) {
+		ret = PTR_ERR(ctx->sclk);
+		if (ret == -ENOENT) {
+			dev_info(&pdev->dev,
+				"Failed to get ssp1_sclk, defer probe\n");
+			return -EPROBE_DEFER;
+		}
+
+		dev_err(&pdev->dev, "Failed to get ssp1_sclk with err:%d\n",
+								ret);
+		return ret;
+	}
+
 	return devm_snd_soc_register_card(&pdev->dev, &kabylake_audio_card);
 }
 
-- 
1.9.1

