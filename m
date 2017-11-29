From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 01/19] ASoC: tlv320aic31xx: File header and copyright cleanup
Date: Wed, 29 Nov 2017 15:32:42 -0600
Message-ID: <20171129213300.20021-2-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Fix header copyright tags, while we are here, also switch to SPDX
and fixup MODULE tags to match.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 26 +++++++++-----------------
 sound/soc/codecs/tlv320aic31xx.h | 15 ++++-----------
 2 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 4837f25b0760..b98d9b1f216f 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1,22 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * ALSA SoC TLV320AIC31XX codec driver
+ * ALSA SoC TLV320AIC31xx CODEC Driver
  *
- * Copyright (C) 2014 Texas Instruments, Inc.
- *
- * Author: Jyri Sarha <jsarha@ti.com>
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ *	Jyri Sarha <jsarha@ti.com>
  *
  * Based on ground work by: Ajit Kulkarni <x0175765@ti.com>
  *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED AS IS AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- *
- * The TLV320AIC31xx series of audio codec is a low-power, highly integrated
- * high performance codec which provides a stereo DAC, a mono ADC,
+ * The TLV320AIC31xx series of audio codecs are low-power, highly integrated
+ * high performance codecs which provides a stereo DAC, a mono ADC,
  * and mono/stereo Class-D speaker driver.
  */
 
@@ -1414,6 +1406,6 @@ static struct i2c_driver aic31xx_i2c_driver = {
 
 module_i2c_driver(aic31xx_i2c_driver);
 
-MODULE_DESCRIPTION("ASoC TLV320AIC3111 codec driver");
-MODULE_AUTHOR("Jyri Sarha");
-MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jyri Sarha <jsarha@ti.com>");
+MODULE_DESCRIPTION("ASoC TLV320AIC31xx CODEC Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 730fb2058869..a9ea2f99eba0 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -1,17 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * ALSA SoC TLV320AIC31XX codec driver
- *
- * Copyright (C) 2013 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ * ALSA SoC TLV320AIC31xx CODEC Driver Definitions
  *
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
+
 #ifndef _TLV320AIC31XX_H
 #define _TLV320AIC31XX_H
 
-- 
2.15.0
