From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: apq8016-sbc: add board specific dapm mic widgets" to the asoc tree
Date: Tue, 06 Sep 2016 12:29:25 +0100
Message-ID: <E1bhEZB-0003zQ-Od@finisterre>
References: <1473155865-13361-4-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1473155865-13361-4-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: apq8016-sbc: add board specific dapm mic widgets

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

>From 1190300d03516d00f68abcb01bfab00835bc0ac5 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 6 Sep 2016 10:57:42 +0100
Subject: [PATCH] ASoC: qcom: apq8016-sbc: add board specific dapm mic widgets

This patch adds support to board specific dapm mic widgets so that these
can be used to specify proper connections of various micbias supported by
the board and SOC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 1289543c8fb2..5c3ccf3f8fdf 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -147,6 +147,15 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 	return data;
 }
 
+static const struct snd_soc_dapm_widget apq8016_sbc_dapm_widgets[] = {
+
+	SND_SOC_DAPM_MIC("Handset Mic", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Secondary Mic", NULL),
+	SND_SOC_DAPM_MIC("Digital Mic1", NULL),
+	SND_SOC_DAPM_MIC("Digital Mic2", NULL),
+};
+
 static int apq8016_sbc_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -159,6 +168,8 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = dev;
+	card->dapm_widgets = apq8016_sbc_dapm_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(apq8016_sbc_dapm_widgets);
 	data = apq8016_sbc_parse_of(card);
 	if (IS_ERR(data)) {
 		dev_err(&pdev->dev, "Error resolving dai links: %ld\n",
-- 
2.9.3
