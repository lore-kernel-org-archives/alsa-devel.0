From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: msm8916-wcd-digital: rename parse_dt to get_clks
Date: Fri,  4 Nov 2016 14:45:40 +0000
Message-ID: <1478270740-3037-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1478270740-3037-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1478270740-3037-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.com, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch renames msm8916_wcd_digital_parse_dt() to
msm8916_wcd_digital_get_clks() as the function is not directly dealing
with dt parsing.

No functional changes done.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index e35501a..f690442 100644
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
