From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 6/8] extcon: arizona: Add support for WM8998 and WM1814
Date: Wed, 29 Apr 2015 15:37:07 +0100
Message-ID: <1430318229-28518-7-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1430318229-28518-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430318229-28518-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com
Cc: myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-arizona.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 830c5f9..586ec53 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1,7 +1,7 @@
 /*
  * extcon-arizona.c - Extcon driver Wolfson Arizona devices
  *
- *  Copyright (C) 2012 Wolfson Microelectronics plc
+ *  Copyright (C) 2012-2014 Wolfson Microelectronics plc
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -140,10 +140,14 @@ static void arizona_extcon_hp_clamp(struct arizona_extcon_info *info,
 				    bool clamp)
 {
 	struct arizona *arizona = info->arizona;
-	unsigned int mask = 0, val = 0;
+	unsigned int mask, val = 0;
 	int ret;
 
 	switch (arizona->type) {
+	case WM8998:
+	case WM1814:
+		mask = 0;
+		break;
 	case WM5110:
 		mask = ARIZONA_HP1L_SHRTO | ARIZONA_HP1L_FLWR |
 		       ARIZONA_HP1L_SHRTI;
@@ -175,17 +179,19 @@ static void arizona_extcon_hp_clamp(struct arizona_extcon_info *info,
 				 ret);
 	}
 
-	ret = regmap_update_bits(arizona->regmap, ARIZONA_HP_CTRL_1L,
-				 mask, val);
-	if (ret != 0)
-		dev_warn(arizona->dev, "Failed to do clamp: %d\n",
+	if (mask) {
+		ret = regmap_update_bits(arizona->regmap, ARIZONA_HP_CTRL_1L,
+					 mask, val);
+		if (ret != 0)
+			dev_warn(arizona->dev, "Failed to do clamp: %d\n",
 				 ret);
 
-	ret = regmap_update_bits(arizona->regmap, ARIZONA_HP_CTRL_1R,
-				 mask, val);
-	if (ret != 0)
-		dev_warn(arizona->dev, "Failed to do clamp: %d\n",
-			 ret);
+		ret = regmap_update_bits(arizona->regmap, ARIZONA_HP_CTRL_1R,
+					 mask, val);
+		if (ret != 0)
+			dev_warn(arizona->dev, "Failed to do clamp: %d\n",
+				 ret);
+	}
 
 	/* Restore the desired state while not doing the clamp */
 	if (!clamp) {
@@ -1176,6 +1182,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 			break;
 		}
 		break;
+	case WM8998:
+	case WM1814:
+		info->micd_clamp = true;
+		info->hpdet_ip_version = 2;
+		break;
 	default:
 		break;
 	}
-- 
1.7.2.5
