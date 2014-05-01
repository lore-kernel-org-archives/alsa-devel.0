From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] mfd: mc13xxx: Do not use platform data with devicetree
Date: Thu,  1 May 2014 10:48:03 +0400
Message-ID: <1398926883-21778-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

This patch removes platform data usage for codec and touchscreen
when driver is used with devicetree.
This fixes possible "null pointer dereference" error if DTS uses
"fsl,mc13xxx-uses-codec" or "fsl,mc13xxx-uses-touch" options.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/mfd/mc13xxx-core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 06e64b6..2ed22d7 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -673,17 +673,9 @@ int mc13xxx_common_init(struct device *dev)
 	if (mc13xxx->flags & MC13XXX_USE_ADC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
 
-	if (mc13xxx->flags & MC13XXX_USE_CODEC)
-		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
-					pdata->codec, sizeof(*pdata->codec));
-
 	if (mc13xxx->flags & MC13XXX_USE_RTC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
 
-	if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
-		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-ts",
-				&pdata->touch, sizeof(pdata->touch));
-
 	if (pdata) {
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
 			&pdata->regulators, sizeof(pdata->regulators));
@@ -691,10 +683,20 @@ int mc13xxx_common_init(struct device *dev)
 				pdata->leds, sizeof(*pdata->leds));
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
 				pdata->buttons, sizeof(*pdata->buttons));
+		if (mc13xxx->flags & MC13XXX_USE_CODEC)
+			mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
+				pdata->codec, sizeof(*pdata->codec));
+		if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
+			mc13xxx_add_subdevice_pdata(mc13xxx, "%s-ts",
+				&pdata->touch, sizeof(pdata->touch));
 	} else {
 		mc13xxx_add_subdevice(mc13xxx, "%s-regulator");
 		mc13xxx_add_subdevice(mc13xxx, "%s-led");
 		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
+		if (mc13xxx->flags & MC13XXX_USE_CODEC)
+			mc13xxx_add_subdevice(mc13xxx, "%s-codec");
+		if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
+			mc13xxx_add_subdevice(mc13xxx, "%s-ts");
 	}
 
 	return 0;
-- 
1.8.3.2
