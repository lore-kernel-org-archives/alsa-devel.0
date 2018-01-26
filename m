From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Enable mclk and ssp sclk
	early" to the asoc tree
Date: Fri, 26 Jan 2018 12:53:53 +0000
Message-ID: <E1ef3Vx-0002EU-7D@debutante>
References: <1512978390-8848-4-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D2BF1266C0E
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 13:56:21 +0100 (CET)
In-Reply-To: <1512978390-8848-4-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Enable mclk and ssp sclk early

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From f7f61e08fe5840ca43baa49355b40d3aede1ac97 Mon Sep 17 00:00:00 2001
From: Harsha Priya <harshapriya.n@intel.com>
Date: Thu, 4 Jan 2018 16:55:16 +0530
Subject: [PATCH] ASoC: Intel: kbl: Enable mclk and ssp sclk early

rt5663 needs mclk/sclk early to synchronize its internal clocks. Enable
these clocks early.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig               |  1 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 95 +++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index d4e103615f51..fefb1ee9fec6 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -235,6 +235,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	select SND_SOC_MAX98927
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_INTEL_SKYLAKE_SSP_CLK
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for RT5663 + MAX98927.
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index bf7014ca486f..f5df6bca3156 100644
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
2.15.1
