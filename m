From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH v2 2/2] ASoC: tlv320aic32x4: Add rstn gpio to
	platform data.
Date: Wed, 31 Oct 2012 11:53:34 +0100
Message-ID: <1351680814-13714-2-git-send-email-javier.martin@vista-silicon.com>
References: <1351680814-13714-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 36DD1261621
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 11:53:47 +0100 (CET)
Received: by mail-wg0-f51.google.com with SMTP id ed3so648312wgb.20
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 03:53:44 -0700 (PDT)
In-Reply-To: <1351680814-13714-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lrg@ti.com, lars@metafoo.de, broonie@opensource.wolfsonmicro.com, javier.martin@vista-silicon.com, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Add the possibility to specify a gpio through platform data
so that a HW reset can be issued to the codec.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
Changes since v1:
 - Use a subject line according to the ASoC subsystem.
 - Use 'devm_gpio_request_one()'
 - Provide correct default value to the GPIO.
---
 include/sound/tlv320aic32x4.h    |    1 +
 sound/soc/codecs/tlv320aic32x4.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/sound/tlv320aic32x4.h b/include/sound/tlv320aic32x4.h
index c009f70..24e5d99 100644
--- a/include/sound/tlv320aic32x4.h
+++ b/include/sound/tlv320aic32x4.h
@@ -26,6 +26,7 @@ struct aic32x4_pdata {
 	u32 power_cfg;
 	u32 micpga_routing;
 	bool swapdacs;
+	int rstn_gpio;
 };
 
 #endif
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index aad92f9..f188aa4 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
@@ -65,6 +66,7 @@ struct aic32x4_priv {
 	u32 power_cfg;
 	u32 micpga_routing;
 	bool swapdacs;
+	int rstn_gpio;
 };
 
 /* 0dB min, 1dB steps */
@@ -627,10 +629,20 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
 	u32 tmp_reg;
+	int ret;
 
 	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->control_data = aic32x4->control_data;
 
+	if (aic32x4->rstn_gpio >= 0) {
+		ret = devm_gpio_request_one(codec->dev, aic32x4->rstn_gpio,
+				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
+		if (ret != 0)
+			return ret;
+		ndelay(10);
+		gpio_set_value(aic32x4->rstn_gpio, 1);
+	}
+
 	snd_soc_write(codec, AIC32X4_RESET, 0x01);
 
 	/* Power platform configuration */
@@ -723,10 +735,12 @@ static __devinit int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->power_cfg = pdata->power_cfg;
 		aic32x4->swapdacs = pdata->swapdacs;
 		aic32x4->micpga_routing = pdata->micpga_routing;
+		aic32x4->rstn_gpio = pdata->rstn_gpio;
 	} else {
 		aic32x4->power_cfg = 0;
 		aic32x4->swapdacs = false;
 		aic32x4->micpga_routing = 0;
+		aic32x4->rstn_gpio = -1;
 	}
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.9.5
