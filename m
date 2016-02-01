From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: [PATCH] ASoC: dwc: Ensure i2s_reg_comp{1,2} is always initialised
Date: Mon, 01 Feb 2016 15:54:37 +0000
Message-ID: <1454342077.16701.4.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In the case that the driver is configured from device-tree
i2s_reg_comp1 and i2s_reg_comp2 aren't initialised, breaking the driver.
Fix this by unconditionally setting these values before checking for quirks.

Fixes: a242cac1d3aa ("ASoC: dwc: add quirk to override COMP_PARAM_1 register")

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 sound/soc/dwc/designware_i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index d8afd8e..5f4e6aa 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -636,6 +636,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 
+	dev->i2s_reg_comp1 = I2S_COMP_PARAM_1;
+	dev->i2s_reg_comp2 = I2S_COMP_PARAM_2;
 	if (pdata) {
 		dev->capability = pdata->cap;
 		clk_id = NULL;
@@ -643,9 +645,6 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		if (dev->quirks & DW_I2S_QUIRK_COMP_REG_OFFSET) {
 			dev->i2s_reg_comp1 = pdata->i2s_reg_comp1;
 			dev->i2s_reg_comp2 = pdata->i2s_reg_comp2;
-		} else {
-			dev->i2s_reg_comp1 = I2S_COMP_PARAM_1;
-			dev->i2s_reg_comp2 = I2S_COMP_PARAM_2;
 		}
 		ret = dw_configure_dai_by_pd(dev, dw_i2s_dai, res, pdata);
 	} else {
-- 
2.1.4
