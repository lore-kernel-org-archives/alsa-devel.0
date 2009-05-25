From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 1/2] pxa2xx-ac97-lib: move set_resetgpio to
	pxa27x.c
Date: Mon, 25 May 2009 13:20:18 +0400
Message-ID: <1243243219-23786-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 683BA103836
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 11:20:30 +0200 (CEST)
Received: by ewy23 with SMTP id 23so3105818ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 02:20:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

The code related to set_resetgpio is pxa27x specific and should
not be present in sound driver lib. Move it to appropriate place.

The code is moved to arch/arm as it will be converted from (exported)
pxa_gpio_mode() calls to use MFP which are unexported to modules.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-pxa/include/mach/audio.h |   24 ++++++++++++++++
 arch/arm/mach-pxa/pxa27x.c             |   37 +++++++++++++++++++++++++
 sound/arm/pxa2xx-ac97-lib.c            |   47 +++-----------------------------
 3 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/audio.h b/arch/arm/mach-pxa/include/mach/audio.h
index 16eb025..517c868 100644
--- a/arch/arm/mach-pxa/include/mach/audio.h
+++ b/arch/arm/mach-pxa/include/mach/audio.h
@@ -24,4 +24,28 @@ typedef struct {
 
 extern void pxa_set_ac97_info(pxa2xx_audio_ops_t *ops);
 
+/*
+ * Beware PXA27x bugs:
+ *
+ *   o Slot 12 read from modem space will hang controller.
+ *   o CDONE, SDONE interrupt fails after any slot 12 IO.
+ *
+ * We therefore have an hybrid approach for waiting on SDONE (interrupt or
+ * 1 jiffy timeout if interrupt never comes).
+ */
+
+enum {
+	RESETGPIO_FORCE_HIGH,
+	RESETGPIO_FORCE_LOW,
+	RESETGPIO_NORMAL_ALTFUNC
+};
+
+#if defined(CONFIG_PXA27x)
+extern void pxa27x_ac97_reset(int reset_gpio, int resetgpio_action);
+#else
+static inline void pxa27x_ac97_reset(int reset_gpio, int resetgpio_action)
+{
+}
+#endif
+
 #endif
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index a425ec7..a0e787e 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -28,6 +28,7 @@
 #include <mach/pm.h>
 #include <mach/dma.h>
 #include <mach/i2c.h>
+#include <mach/audio.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -345,6 +346,42 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 	pxa_register_device(&pxa27x_device_i2c_power, info);
 }
 
+/**
+ * pxa27x_ac97_reset - computes and sets the AC97_RESET gpio mode on PXA
+ * @mode: chosen action
+ *
+ * As the PXA27x CPUs suffer from a AC97 bug, a manual control of the reset line
+ * must be done to insure proper work of AC97 reset line.  This function
+ * computes the correct gpio_mode for further use by reset functions, and
+ * applied the change through pxa_gpio_mode.
+ */
+/* temporary include */
+#include <mach/pxa2xx-gpio.h>
+void pxa27x_ac97_reset(int reset_gpio, int resetgpio_action)
+{
+	int mode = 0;
+
+	if (reset_gpio)
+		switch (resetgpio_action) {
+		case RESETGPIO_NORMAL_ALTFUNC:
+			if (reset_gpio == 113)
+				mode = 113 | GPIO_ALT_FN_2_OUT;
+			if (reset_gpio == 95)
+				mode = 95 | GPIO_ALT_FN_1_OUT;
+			break;
+		case RESETGPIO_FORCE_LOW:
+			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_LOW;
+			break;
+		case RESETGPIO_FORCE_HIGH:
+			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_HIGH;
+			break;
+		};
+
+	if (mode)
+		pxa_gpio_mode(mode);
+}
+EXPORT_SYMBOL(pxa27x_ac97_reset);
+
 static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_udc,
 	&pxa_device_ffuart,
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 6fdca97..2227314 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -42,45 +42,6 @@ static int reset_gpio;
  * 1 jiffy timeout if interrupt never comes).
  */
 
-enum {
-	RESETGPIO_FORCE_HIGH,
-	RESETGPIO_FORCE_LOW,
-	RESETGPIO_NORMAL_ALTFUNC
-};
-
-/**
- * set_resetgpio_mode - computes and sets the AC97_RESET gpio mode on PXA
- * @mode: chosen action
- *
- * As the PXA27x CPUs suffer from a AC97 bug, a manual control of the reset line
- * must be done to insure proper work of AC97 reset line.  This function
- * computes the correct gpio_mode for further use by reset functions, and
- * applied the change through pxa_gpio_mode.
- */
-static void set_resetgpio_mode(int resetgpio_action)
-{
-	int mode = 0;
-
-	if (reset_gpio)
-		switch (resetgpio_action) {
-		case RESETGPIO_NORMAL_ALTFUNC:
-			if (reset_gpio == 113)
-				mode = 113 | GPIO_ALT_FN_2_OUT;
-			if (reset_gpio == 95)
-				mode = 95 | GPIO_ALT_FN_1_OUT;
-			break;
-		case RESETGPIO_FORCE_LOW:
-			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_LOW;
-			break;
-		case RESETGPIO_FORCE_HIGH:
-			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_HIGH;
-			break;
-		};
-
-	if (mode)
-		pxa_gpio_mode(mode);
-}
-
 unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	unsigned short val = -1;
@@ -176,10 +137,10 @@ static inline void pxa_ac97_warm_pxa27x(void)
 
 	/* warm reset broken on Bulverde,
 	   so manually keep AC97 reset high */
-	set_resetgpio_mode(RESETGPIO_FORCE_HIGH);
+	pxa27x_ac97_reset(reset_gpio, RESETGPIO_FORCE_HIGH);
 	udelay(10);
 	GCR |= GCR_WARM_RST;
-	set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
+	pxa27x_ac97_reset(reset_gpio, RESETGPIO_NORMAL_ALTFUNC);
 	udelay(500);
 }
 
@@ -353,7 +314,7 @@ int pxa2xx_ac97_hw_resume(void)
 	}
 	if (cpu_is_pxa27x()) {
 		/* Use GPIO 113 or 95 as AC97 Reset on Bulverde */
-		set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
+		pxa27x_ac97_reset(reset_gpio, RESETGPIO_NORMAL_ALTFUNC);
 	}
 	clk_enable(ac97_clk);
 	return 0;
@@ -395,7 +356,7 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 
 	if (cpu_is_pxa27x()) {
 		/* Use GPIO 113 as AC97 Reset on Bulverde */
-		set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
+		pxa27x_ac97_reset(reset_gpio, RESETGPIO_NORMAL_ALTFUNC);
 		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
 		if (IS_ERR(ac97conf_clk)) {
 			ret = PTR_ERR(ac97conf_clk);
-- 
1.6.2.4
