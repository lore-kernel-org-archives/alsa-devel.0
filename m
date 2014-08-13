From: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Subject: [PATCH] mfd: wm8994: declare dc servo register for wm8958 as volatile
Date: Wed, 13 Aug 2014 11:46:25 +0100
Message-ID: <1407926786-8528-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
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
 drivers/mfd/wm8994-regmap.c          |    1 +
 include/linux/mfd/wm8994/registers.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mfd/wm8994-regmap.c b/drivers/mfd/wm8994-regmap.c
index 2fbce9c..e775565 100644
--- a/drivers/mfd/wm8994-regmap.c
+++ b/drivers/mfd/wm8994-regmap.c
@@ -1169,6 +1169,7 @@ static bool wm8958_volatile_register(struct device *dev, unsigned int reg)
 	case WM8958_FW_MINOR_0:
 	case WM8958_FW_PATCH_1:
 	case WM8958_FW_PATCH_0:
+	case WM8958_DC_SERVO:
 		return true;
 	default:
 		return wm8994_volatile_register(dev, reg);
diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index db8cef3..85b4fec 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -71,6 +71,7 @@
 #define WM8994_DC_SERVO_1                       0x54
 #define WM8994_DC_SERVO_2                       0x55
 #define WM8994_DC_SERVO_4                       0x57
+#define WM8958_DC_SERVO			0x57
 #define WM8994_DC_SERVO_READBACK                0x58
 #define WM8994_DC_SERVO_4E			0x59
 #define WM8994_ANALOGUE_HP_1                    0x60
-- 
1.7.9.5
