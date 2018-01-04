From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [alsa-devel] [PATCH v7 3/6] ASoC: Intel: kbl: Enable mclk and ssp sclk early
Date: Thu,  4 Jan 2018 16:55:16 +0530
Message-ID: <1515065119-1683-4-git-send-email-sriramx.periyasamy@intel.com>
References: <1515065119-1683-1-git-send-email-sriramx.periyasamy@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1515065119-1683-1-git-send-email-sriramx.periyasamy@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, Harsha Priya <harshapriya.n@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Harsha Priya <harshapriya.n@intel.com>

rt5663 needs mclk/sclk early to synchronize its internal clocks. Enable
these clocks early.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/Kconfig               |  1 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 95 +++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 449bc8baaa60..f62f2ab1481e 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -262,6 +262,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	select SND_SOC_MAX98927
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_INTEL_SKYLAKE_SSP_CLK
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for RT5663 + MAX98927.
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 94a34db4f8c0..bb3e8a97df4b 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -28,6 +28,9 @@
 #include "../../codecs/rt5663.h"
 #include "../../codecs/hdac_hdmi.h"
 #include "../skylake/skl.h"
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 
 #define KBL_REALTEK_CODEC_DAI "rt5663-aif"
 #define KBL_MAXIM_CODEC_DAI "max98927-aif1"
@@ -48,6 +51,8 @@ struct kbl_hdmi_pcm {
 struct kbl_rt5663_private {
 	struct snd_soc_jack kabylake_headset;
 	struct list_head hdmi_pcm_list;
+	struct clk *mclk;
+	struct clk *sclk;
 };
 
 enum {
@@ -69,6 +74,61 @@ static const struct snd_kcontrol_new kabylake_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Right Spk"),
 };
 
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct kbl_rt5663_private *priv = snd_soc_card_get_drvdata(card);
+	int ret = 0;
+
+	/*
+	 * MCLK/SCLK need to be ON early for a successful synchronization of
+	 * codec internal clock. And the clocks are turned off during
+	 * POST_PMD after the stream is stopped.
+	 */
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Enable MCLK */
+		ret = clk_set_rate(priv->mclk, 24000000);
+		if (ret < 0) {
+			dev_err(card->dev, "Can't set rate for mclk, err: %d\n",
+				ret);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(priv->mclk);
+		if (ret < 0) {
+			dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);
+			return ret;
+		}
+
+		/* Enable SCLK */
+		ret = clk_set_rate(priv->sclk, 3072000);
+		if (ret < 0) {
+			dev_err(card->dev, "Can't set rate for sclk, err: %d\n",
+				ret);
+			clk_disable_unprepare(priv->mclk);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(priv->sclk);
+		if (ret < 0) {
+			dev_err(card->dev, "Can't enable sclk, err: %d\n", ret);
+			clk_disable_unprepare(priv->mclk);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		clk_disable_unprepare(priv->mclk);
+		clk_disable_unprepare(priv->sclk);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -78,11 +138,14 @@ static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
 	SND_SOC_DAPM_SPK("HDMI3", NULL),
-
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route kabylake_map[] = {
 	/* HP jack connectors - unknown if we have jack detection */
+	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
 
@@ -91,6 +154,7 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "Right Spk", NULL, "Right BE_OUT" },
 
 	/* other jacks */
+	{ "Headset Mic", NULL, "Platform Clock" },
 	{ "IN1P", NULL, "Headset Mic" },
 	{ "IN1N", NULL, "Headset Mic" },
 	{ "DMic", NULL, "SoC DMIC" },
@@ -901,6 +965,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_rt5663_private *ctx;
 	struct skl_machine_pdata *pdata;
+	int ret;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx)
@@ -919,6 +984,34 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 		dmic_constraints = pdata->dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
+	ctx->mclk = devm_clk_get(&pdev->dev, "ssp1_mclk");
+	if (IS_ERR(ctx->mclk)) {
+		ret = PTR_ERR(ctx->mclk);
+		if (ret == -ENOENT) {
+			dev_info(&pdev->dev,
+				"Failed to get ssp1_sclk, defer probe\n");
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
 	return devm_snd_soc_register_card(&pdev->dev, kabylake_audio_card);
 }
 
-- 
2.7.4

