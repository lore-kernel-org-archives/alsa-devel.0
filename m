From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH 2/2] sound: soc: tlv320aic32x4: Add rstn gpio
	to platform data.
Date: Tue, 30 Oct 2012 16:29:34 +0100
Message-ID: <1351610974-18395-2-git-send-email-javier.martin@vista-silicon.com>
References: <1351610974-18395-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 465B02602F7
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 16:29:46 +0100 (CET)
Received: by mail-ea0-f179.google.com with SMTP id f14so163743eaa.38
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 08:29:45 -0700 (PDT)
In-Reply-To: <1351610974-18395-1-git-send-email-javier.martin@vista-silicon.com>
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
Cc: lrg@ti.com, lars@metafoo.de, w.sang@pengutronix.de, Javier Martin <javier.martin@vista-silicon.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add the possibility to specify a gpio through platform data
so that a HW reset can be issued to the codec.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 include/sound/tlv320aic32x4.h    |    1 +
 sound/soc/codecs/tlv320aic32x4.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index aad92f9..be04cd4 100644
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
@@ -627,10 +629,21 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
 	u32 tmp_reg;
+	int ret;
 
 	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->control_data = aic32x4->control_data;
 
+	if (aic32x4->rstn_gpio >= 0) {
+		ret = gpio_request(aic32x4->rstn_gpio, "tlv320aic32x4 rstn");
+		if (ret != 0)
+			return ret;
+		gpio_direction_output(aic32x4->rstn_gpio, 1);
+		gpio_set_value(aic32x4->rstn_gpio, 0);
+		ndelay(10);
+		gpio_set_value(aic32x4->rstn_gpio, 1);
+	}
+
 	snd_soc_write(codec, AIC32X4_RESET, 0x01);
 
 	/* Power platform configuration */
@@ -690,6 +703,10 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 
 static int aic32x4_remove(struct snd_soc_codec *codec)
 {
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+
+	if (aic32x4->rstn_gpio != -1)
+		gpio_free(aic32x4->rstn_gpio);
 	aic32x4_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
@@ -723,10 +740,12 @@ static __devinit int aic32x4_i2c_probe(struct i2c_client *i2c,
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
