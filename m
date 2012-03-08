From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] mfd: wm8994: Remove unused LDO supply
	field from WM8994 pdata
Date: Thu,  8 Mar 2012 11:55:06 +0000
Message-ID: <1331207707-6026-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F5DF1039D7
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 12:55:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kukjin Kim <kgene.kim@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's causing confusion with the regulator level field of the same name
and serves no useful function.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |    6 ++++--
 include/linux/mfd/wm8994/pdata.h             |    1 -
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index e248581..77c8342 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -17,6 +17,8 @@
 #include <linux/mfd/wm831x/gpio.h>
 #include <linux/mfd/wm8994/pdata.h>
 
+#include <linux/regulator/machine.h>
+
 #include <sound/wm0010.h>
 #include <sound/wm5100.h>
 #include <sound/wm8996.h>
@@ -168,8 +170,8 @@ static struct wm8994_pdata wm8994_pdata = {
 	},
 	.irq_base = CODEC_IRQ_BASE,
 	.ldo = {
-		{ .supply = "WALLVDD" },
-		{ .supply = "WALLVDD" },
+		 { },
+		 { },
 	},
 };
 
diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index dc3e050..893267b 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -22,7 +22,6 @@ struct wm8994_ldo_pdata {
 	/** GPIOs to enable regulator, 0 or less if not available */
 	int enable;
 
-	const char *supply;
 	const struct regulator_init_data *init_data;
 };
 
-- 
1.7.9.1
