From: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Subject: [PATCH v2] mfd: wm8994: declare dc servo register for wm8958 as volatile
Date: Wed, 13 Aug 2014 16:27:29 +0100
Message-ID: <1407943649-9535-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

DC Servo register 57h holds the DC offset value after the hardware has
completed the DC Servo Correction, so declare this register as volatile
because it is changed by the hardware.

Signed-off-by: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm8994-regmap.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/wm8994-regmap.c b/drivers/mfd/wm8994-regmap.c
index 2fbce9c..fa1630d 100644
--- a/drivers/mfd/wm8994-regmap.c
+++ b/drivers/mfd/wm8994-regmap.c
@@ -1169,6 +1169,7 @@ static bool wm8958_volatile_register(struct device *dev, unsigned int reg)
 	case WM8958_FW_MINOR_0:
 	case WM8958_FW_PATCH_1:
 	case WM8958_FW_PATCH_0:
+	case WM8994_DC_SERVO_4:
 		return true;
 	default:
 		return wm8994_volatile_register(dev, reg);
-- 
1.7.9.5
