From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4 3/4] ASoC: codecs: adau1701: switch to
	direct regmap API usage
Date: Mon, 24 Jun 2013 16:31:31 +0200
Message-ID: <1372084292-4859-4-git-send-email-zonque@gmail.com>
References: <1372084292-4859-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5B02650D1
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:31:07 +0200 (CEST)
In-Reply-To: <1372084292-4859-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@kernel.org, lars@metafoo.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The hardware I/O has to be open-coded due to registers of unequal sizes.
Other than that, the transition is straight forward.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/adau1701.c | 118 +++++++++++++++++++++++++++++++-------------
 1 file changed, 85 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 770d90e..881bab4 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -24,16 +25,16 @@
 #include "sigmadsp.h"
 #include "adau1701.h"
 
-#define ADAU1701_DSPCTRL	0x1c
-#define ADAU1701_SEROCTL	0x1e
-#define ADAU1701_SERICTL	0x1f
+#define ADAU1701_DSPCTRL	0x081c
+#define ADAU1701_SEROCTL	0x081e
+#define ADAU1701_SERICTL	0x081f
 
-#define ADAU1701_AUXNPOW	0x22
+#define ADAU1701_AUXNPOW	0x0822
 
-#define ADAU1701_OSCIPOW	0x26
-#define ADAU1701_DACSET		0x27
+#define ADAU1701_OSCIPOW	0x0826
+#define ADAU1701_DACSET		0x0827
 
-#define ADAU1701_NUM_REGS	0x28
+#define ADAU1701_MAX_REGISTER	0x0828
 
 #define ADAU1701_DSPCTRL_CR		(1 << 2)
 #define ADAU1701_DSPCTRL_DAM		(1 << 3)
@@ -97,6 +98,7 @@ struct adau1701 {
 	unsigned int dai_fmt;
 	unsigned int pll_clkdiv;
 	unsigned int sysclk;
+	struct regmap *regmap;
 };
 
 static const struct snd_kcontrol_new adau1701_controls[] = {
@@ -128,7 +130,7 @@ static const struct snd_soc_dapm_route adau1701_dapm_routes[] = {
 	{ "ADC", NULL, "IN1" },
 };
 
-static unsigned int adau1701_register_size(struct snd_soc_codec *codec,
+static unsigned int adau1701_register_size(struct device *dev,
 		unsigned int reg)
 {
 	switch (reg) {
@@ -142,33 +144,42 @@ static unsigned int adau1701_register_size(struct snd_soc_codec *codec,
 		return 1;
 	}
 
-	dev_err(codec->dev, "Unsupported register address: %d\n", reg);
+	dev_err(dev, "Unsupported register address: %d\n", reg);
 	return 0;
 }
 
-static int adau1701_write(struct snd_soc_codec *codec, unsigned int reg,
-		unsigned int value)
+static bool adau1701_volatile_reg(struct device *dev, unsigned int reg)
 {
+	switch (reg) {
+	case ADAU1701_DACSET:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int adau1701_reg_write(void *context, unsigned int reg,
+			      unsigned int value)
+{
+	struct i2c_client *client = context;
 	unsigned int i;
 	unsigned int size;
 	uint8_t buf[4];
 	int ret;
 
-	size = adau1701_register_size(codec, reg);
+	size = adau1701_register_size(&client->dev, reg);
 	if (size == 0)
 		return -EINVAL;
 
-	snd_soc_cache_write(codec, reg, value);
-
-	buf[0] = 0x08;
-	buf[1] = reg;
+	buf[0] = reg >> 8;
+	buf[1] = reg & 0xff;
 
 	for (i = size + 1; i >= 2; --i) {
 		buf[i] = value;
 		value >>= 8;
 	}
 
-	ret = i2c_master_send(to_i2c_client(codec->dev), buf, size + 2);
+	ret = i2c_master_send(client, buf, size + 2);
 	if (ret == size + 2)
 		return 0;
 	else if (ret < 0)
@@ -177,16 +188,45 @@ static int adau1701_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 }
 
-static unsigned int adau1701_read(struct snd_soc_codec *codec, unsigned int reg)
+static int adau1701_reg_read(void *context, unsigned int reg,
+			     unsigned int *value)
 {
-	unsigned int value;
-	unsigned int ret;
+	int ret;
+	unsigned int i;
+	unsigned int size;
+	uint8_t send_buf[2], recv_buf[3];
+	struct i2c_client *client = context;
+	struct i2c_msg msgs[2];
+
+	size = adau1701_register_size(&client->dev, reg);
+	if (size == 0)
+		return -EINVAL;
 
-	ret = snd_soc_cache_read(codec, reg, &value);
-	if (ret)
+	send_buf[0] = reg >> 8;
+	send_buf[1] = reg & 0xff;
+
+	msgs[0].addr = client->addr;
+	msgs[0].len = sizeof(send_buf);
+	msgs[0].buf = send_buf;
+	msgs[0].flags = 0;
+
+	msgs[1].addr = client->addr;
+	msgs[1].len = size;
+	msgs[1].buf = recv_buf;
+	msgs[1].flags = I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
 		return ret;
+	else if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	*value = 0;
+
+	for (i = 0; i < size; i++)
+		*value |= recv_buf[i] << (i * 8);
 
-	return value;
+	return 0;
 }
 
 static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
@@ -242,8 +282,11 @@ static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
 		}
 	}
 
-	snd_soc_write(codec, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
-	snd_soc_write(codec, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
+	regmap_write(adau1701->regmap, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
+	regmap_write(adau1701->regmap, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
+
+	regcache_mark_dirty(adau1701->regmap);
+	regcache_sync(adau1701->regmap);
 
 	return 0;
 }
@@ -429,8 +472,8 @@ static int adau1701_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	adau1701->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
-	snd_soc_write(codec, ADAU1701_SERICTL, serictl);
-	snd_soc_update_bits(codec, ADAU1701_SEROCTL,
+	regmap_write(adau1701->regmap, ADAU1701_SERICTL, serictl);
+	regmap_update_bits(adau1701->regmap, ADAU1701_SEROCTL,
 		~ADAU1701_SEROCTL_WORD_LEN_MASK, seroctl);
 
 	return 0;
@@ -567,9 +610,6 @@ static struct snd_soc_codec_driver adau1701_codec_drv = {
 	.set_bias_level		= adau1701_set_bias_level,
 	.idle_bias_off		= true,
 
-	.reg_cache_size		= ADAU1701_NUM_REGS,
-	.reg_word_size		= sizeof(u16),
-
 	.controls		= adau1701_controls,
 	.num_controls		= ARRAY_SIZE(adau1701_controls),
 	.dapm_widgets		= adau1701_dapm_widgets,
@@ -577,12 +617,19 @@ static struct snd_soc_codec_driver adau1701_codec_drv = {
 	.dapm_routes		= adau1701_dapm_routes,
 	.num_dapm_routes	= ARRAY_SIZE(adau1701_dapm_routes),
 
-	.write			= adau1701_write,
-	.read			= adau1701_read,
-
 	.set_sysclk		= adau1701_set_sysclk,
 };
 
+static const struct regmap_config adau1701_regmap = {
+	.reg_bits		= 16,
+	.val_bits		= 32,
+	.max_register		= ADAU1701_MAX_REGISTER,
+	.cache_type		= REGCACHE_RBTREE,
+	.volatile_reg		= adau1701_volatile_reg,
+	.reg_write		= adau1701_reg_write,
+	.reg_read		= adau1701_reg_read,
+};
+
 static int adau1701_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -596,6 +643,11 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 	if (!adau1701)
 		return -ENOMEM;
 
+	adau1701->regmap = devm_regmap_init(dev, NULL, client,
+					    &adau1701_regmap);
+	if (IS_ERR(adau1701->regmap))
+		return PTR_ERR(adau1701->regmap);
+
 	if (dev->of_node) {
 		gpio_nreset = of_get_named_gpio(dev->of_node, "reset-gpio", 0);
 		if (gpio_nreset < 0 && gpio_nreset != -ENOENT)
-- 
1.8.1.4
