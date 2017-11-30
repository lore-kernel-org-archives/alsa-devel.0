From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: File header and
	copyright cleanup" to the asoc tree
Date: Thu, 30 Nov 2017 12:33:01 +0000
Message-ID: <E1eKO1V-0000Vn-EA@debutante>
References: <20171129213300.20021-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F1E82679D8
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 13:33:06 +0100 (CET)
In-Reply-To: <20171129213300.20021-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: File header and copyright cleanup

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b1c52b7e7cc6a57128869008b84d98a4de78fe2d Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 15:32:42 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: File header and copyright cleanup

Fix header copyright tags, while we are here, also switch to SPDX
and fixup MODULE tags to match.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
