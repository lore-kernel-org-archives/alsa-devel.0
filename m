From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] sound: soc: wm8903: Pull in platform data
Date: Tue, 18 Sep 2018 12:12:26 -0700
Message-ID: <20180918191226.17104-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D5D726789F
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 21:12:31 +0200 (CEST)
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so1453518pfn.13
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 12:12:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

No platform in the kernel is using platform data to
populate the WM8903 so pull it into the source file.
This is done to handle further simplifications.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/sound/wm8903.h    | 24 ------------------------
 sound/soc/codecs/wm8903.c | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/sound/wm8903.h b/include/sound/wm8903.h
index b310c5a3a958..b2ef76d5d00d 100644
--- a/include/sound/wm8903.h
+++ b/include/sound/wm8903.h
@@ -11,12 +11,6 @@
 #ifndef __LINUX_SND_WM8903_H
 #define __LINUX_SND_WM8903_H
 
-/*
- * Used to enable configuration of a GPIO to all zeros; a gpio_cfg value of
- * zero in platform data means "don't touch this pin".
- */
-#define WM8903_GPIO_CONFIG_ZERO 0x8000
-
 /*
  * R6 (0x06) - Mic Bias Control 0
  */
@@ -245,22 +239,4 @@
 #define WM8903_GP5_DB_SHIFT                          0  /* GP5_DB */
 #define WM8903_GP5_DB_WIDTH                          1  /* GP5_DB */
 
-#define WM8903_NUM_GPIO 5
-
-struct wm8903_platform_data {
-	bool irq_active_low;   /* Set if IRQ active low, default high */
-
-        /* Default register value for R6 (Mic bias), used to configure
-	 * microphone detection.  In conjunction with gpio_cfg this
-	 * can be used to route the microphone status signals out onto
-	 * the GPIOs for use with snd_soc_jack_add_gpios().
-	 */
-	u16 micdet_cfg;
-
-	int micdet_delay;      /* Delay after microphone detection (ms) */
-
-	int gpio_base;
-	u32 gpio_cfg[WM8903_NUM_GPIO]; /* Default register values for GPIO pin mux */
-};
-
 #endif
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 6cb3c153ba19..23e43ff40ded 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -124,6 +124,30 @@ static const char *wm8903_supply_names[WM8903_NUM_SUPPLIES] = {
 	"DCVDD",
 };
 
+/*
+ * Used to enable configuration of a GPIO to all zeros; a gpio_cfg value of
+ * zero in platform data means "don't touch this pin".
+ */
+#define WM8903_GPIO_CONFIG_ZERO 0x8000
+
+#define WM8903_NUM_GPIO 5
+
+struct wm8903_platform_data {
+	bool irq_active_low;   /* Set if IRQ active low, default high */
+
+        /* Default register value for R6 (Mic bias), used to configure
+	 * microphone detection.  In conjunction with gpio_cfg this
+	 * can be used to route the microphone status signals out onto
+	 * the GPIOs for use with snd_soc_jack_add_gpios().
+	 */
+	u16 micdet_cfg;
+
+	int micdet_delay;      /* Delay after microphone detection (ms) */
+
+	int gpio_base;
+	u32 gpio_cfg[WM8903_NUM_GPIO]; /* Default register values for GPIO pin mux */
+};
+
 struct wm8903_priv {
 	struct wm8903_platform_data *pdata;
 	struct device *dev;
-- 
2.17.1
