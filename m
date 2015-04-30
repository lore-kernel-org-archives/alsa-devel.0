From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 01/14] ASoC: qcom: Remove redundant error check.
Date: Thu, 30 Apr 2015 18:16:35 +0100
Message-ID: <1430414195-10913-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch remove redundant check after request_resource as ioremap would
do the check anyway.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 6698d05..1e284c6 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -380,10 +380,6 @@ static int lpass_cpu_platform_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, drvdata);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
-	if (!res) {
-		dev_err(&pdev->dev, "%s() error getting resource\n", __func__);
-		return -ENODEV;
-	}
 
 	drvdata->lpaif = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR((void const __force *)drvdata->lpaif)) {
-- 
1.9.1
