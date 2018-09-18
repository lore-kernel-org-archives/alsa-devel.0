From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] sound: soc: wm8903: Cut gpio_base data
Date: Tue, 18 Sep 2018 12:12:33 -0700
Message-ID: <20180918191233.17178-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 374602678AD
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 21:12:39 +0200 (CEST)
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so1455959pff.11
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 12:12:39 -0700 (PDT)
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

This variable is only used inside the file, and we should
never hard-code the GPIO base, so delete this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/wm8903.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 23e43ff40ded..545512dc4c45 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -144,7 +144,6 @@ struct wm8903_platform_data {
 
 	int micdet_delay;      /* Delay after microphone detection (ms) */
 
-	int gpio_base;
 	u32 gpio_cfg[WM8903_NUM_GPIO]; /* Default register values for GPIO pin mux */
 };
 
@@ -1876,17 +1875,12 @@ static const struct gpio_chip wm8903_template_chip = {
 
 static void wm8903_init_gpio(struct wm8903_priv *wm8903)
 {
-	struct wm8903_platform_data *pdata = wm8903->pdata;
 	int ret;
 
 	wm8903->gpio_chip = wm8903_template_chip;
 	wm8903->gpio_chip.ngpio = WM8903_NUM_GPIO;
 	wm8903->gpio_chip.parent = wm8903->dev;
-
-	if (pdata->gpio_base)
-		wm8903->gpio_chip.base = pdata->gpio_base;
-	else
-		wm8903->gpio_chip.base = -1;
+	wm8903->gpio_chip.base = -1;
 
 	ret = gpiochip_add_data(&wm8903->gpio_chip, wm8903);
 	if (ret != 0)
-- 
2.17.1
