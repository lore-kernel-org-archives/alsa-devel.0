From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-digital: rename parse_dt to get_clks" to the asoc tree
Date: Fri, 04 Nov 2016 10:47:43 -0600
Message-ID: <E1c2heZ-0005pN-Ur@finisterre>
References: <1478270740-3037-2-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1478270740-3037-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, srinivas.kandagatla@linaro.org, tiwai@suse.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd-digital: rename parse_dt to get_clks

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

>From ba9b8c42cff5aaf78229260c5622d6b699683e28 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 4 Nov 2016 14:45:40 +0000
Subject: [PATCH] ASoC: codecs: msm8916-wcd-digital: rename parse_dt to
 get_clks

This patch renames msm8916_wcd_digital_parse_dt() to
msm8916_wcd_digital_get_clks() as the function is not directly dealing
with dt parsing.

No functional changes done.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index e35501af91ab..f690442af8c9 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -539,7 +539,7 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 
 };
 
-static int msm8916_wcd_digital_parse_dt(struct platform_device *pdev,
+static int msm8916_wcd_digital_get_clks(struct platform_device *pdev,
 					struct msm8916_wcd_digital_priv	*priv)
 {
 	struct device *dev = &pdev->dev;
@@ -866,7 +866,7 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
 	if (IS_ERR(digital_map))
 		return PTR_ERR(digital_map);
 
-	ret = msm8916_wcd_digital_parse_dt(pdev, priv);
+	ret = msm8916_wcd_digital_get_clks(pdev, priv);
 	if (ret < 0)
 		return ret;
 
-- 
2.10.1
