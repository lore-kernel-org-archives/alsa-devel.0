From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH RFC 1/3] ASoC: uda1380: use callbacks instead
	of gpiolib
Date: Sat, 26 Jun 2010 18:14:43 +0300
Message-ID: <1277565285-11563-2-git-send-email-anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F97710383A
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 17:15:21 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 11so1046443bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 08:15:21 -0700 (PDT)
In-Reply-To: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Some machines require some tricks to enable/disable
codec, i.e. disable or enable i2s clock before enabling/disabling
codec, and just configuring gpio is not enough; some machines
have no reset pin (reset is performed on codec power on automatically).
Fix that issue by using machine-specific callback to enable codec power.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 include/sound/uda1380.h    |    3 +--
 sound/soc/codecs/uda1380.c |   25 +++----------------------
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/include/sound/uda1380.h b/include/sound/uda1380.h
index 381319c..d2171dc 100644
--- a/include/sound/uda1380.h
+++ b/include/sound/uda1380.h
@@ -12,8 +12,7 @@
 #define __UDA1380_H
 
 struct uda1380_platform_data {
-	int gpio_power;
-	int gpio_reset;
+	void (*set_power)(int);
 	int dac_clk;
 #define UDA1380_DAC_CLK_SYSCLK 0
 #define UDA1380_DAC_CLK_WSPLL  1
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 2f925a2..2b7f200 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -19,7 +19,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
@@ -752,22 +751,11 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 		return -EINVAL;
 	}
 
-	if (!pdata || !pdata->gpio_power || !pdata->gpio_reset)
+	if (!pdata || !pdata->set_power)
 		return -EINVAL;
 
-	ret = gpio_request(pdata->gpio_power, "uda1380 power");
-	if (ret)
-		goto err_out;
-	ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
-	if (ret)
-		goto err_gpio;
-
-	gpio_direction_output(pdata->gpio_power, 1);
-
 	/* we may need to have the clock running here - pH5 */
-	gpio_direction_output(pdata->gpio_reset, 1);
-	udelay(5);
-	gpio_set_value(pdata->gpio_reset, 0);
+	pdata->set_power(1);
 
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -818,11 +806,6 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 err_dai:
 	snd_soc_unregister_codec(codec);
 err_reset:
-	gpio_set_value(pdata->gpio_power, 0);
-	gpio_free(pdata->gpio_reset);
-err_gpio:
-	gpio_free(pdata->gpio_power);
-err_out:
 	return ret;
 }
 
@@ -834,9 +817,7 @@ static void uda1380_unregister(struct uda1380_priv *uda1380)
 	snd_soc_unregister_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
 	snd_soc_unregister_codec(&uda1380->codec);
 
-	gpio_set_value(pdata->gpio_power, 0);
-	gpio_free(pdata->gpio_reset);
-	gpio_free(pdata->gpio_power);
+	pdata->set_power(0);
 
 	kfree(uda1380);
 	uda1380_codec = NULL;
-- 
1.7.1
