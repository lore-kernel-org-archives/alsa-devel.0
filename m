From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: adau1701: Implement sigmadsp safeload
Date: Wed, 19 Nov 2014 18:29:07 +0100
Message-ID: <1416418148-14803-6-git-send-email-lars@metafoo.de>
References: <1416418148-14803-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-042.synserver.de (smtp-out-042.synserver.de
 [212.40.185.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 24741260683
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 18:29:14 +0100 (CET)
In-Reply-To: <1416418148-14803-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The safeload feature allows to load up to 5 parameter memory registers
atomically. This is helpful for switching between e.g. filter settings
without causing any glitches.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1701.c | 57 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 05d5eb5..d4e219b 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -22,9 +22,14 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
+#include <asm/unaligned.h>
+
 #include "sigmadsp.h"
 #include "adau1701.h"
 
+#define ADAU1701_SAFELOAD_DATA(i) (0x0810 + (i))
+#define ADAU1701_SAFELOAD_ADDR(i) (0x0815 + (i))
+
 #define ADAU1701_DSPCTRL	0x081c
 #define ADAU1701_SEROCTL	0x081e
 #define ADAU1701_SERICTL	0x081f
@@ -42,6 +47,7 @@
 #define ADAU1701_DSPCTRL_CR		(1 << 2)
 #define ADAU1701_DSPCTRL_DAM		(1 << 3)
 #define ADAU1701_DSPCTRL_ADM		(1 << 4)
+#define ADAU1701_DSPCTRL_IST		(1 << 5)
 #define ADAU1701_DSPCTRL_SR_48		0x00
 #define ADAU1701_DSPCTRL_SR_96		0x01
 #define ADAU1701_DSPCTRL_SR_192		0x02
@@ -102,6 +108,7 @@ struct adau1701 {
 	unsigned int pll_clkdiv;
 	unsigned int sysclk;
 	struct regmap *regmap;
+	struct i2c_client *client;
 	u8 pin_config[12];
 
 	struct sigmadsp *sigmadsp;
@@ -161,6 +168,7 @@ static bool adau1701_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case ADAU1701_DACSET:
+	case ADAU1701_DSPCTRL:
 		return true;
 	default:
 		return false;
@@ -240,6 +248,50 @@ static int adau1701_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
+static int adau1701_safeload(struct sigmadsp *sigmadsp, unsigned int addr,
+	const uint8_t bytes[], size_t len)
+{
+	struct i2c_client *client = to_i2c_client(sigmadsp->dev);
+	struct adau1701 *adau1701 = i2c_get_clientdata(client);
+	unsigned int val;
+	unsigned int i;
+	uint8_t buf[10];
+	int ret;
+
+	ret = regmap_read(adau1701->regmap, ADAU1701_DSPCTRL, &val);
+	if (ret)
+		return ret;
+
+	if (val & ADAU1701_DSPCTRL_IST)
+		msleep(50);
+
+	for (i = 0; i < len / 4; i++) {
+		put_unaligned_le16(ADAU1701_SAFELOAD_DATA(i), buf);
+		buf[2] = 0x00;
+		memcpy(buf + 3, bytes + i * 4, 4);
+		ret = i2c_master_send(client, buf, 7);
+		if (ret < 0)
+			return ret;
+		else if (ret != 7)
+			return -EIO;
+
+		put_unaligned_le16(ADAU1701_SAFELOAD_ADDR(i), buf);
+		put_unaligned_le16(addr + i, buf + 2);
+		ret = i2c_master_send(client, buf, 4);
+		if (ret < 0)
+			return ret;
+		else if (ret != 4)
+			return -EIO;
+	}
+
+	return regmap_update_bits(adau1701->regmap, ADAU1701_DSPCTRL,
+		ADAU1701_DSPCTRL_IST, ADAU1701_DSPCTRL_IST);
+}
+
+static const struct sigmadsp_ops adau1701_sigmadsp_ops = {
+	.safeload = adau1701_safeload,
+};
+
 static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv,
 	unsigned int rate)
 {
@@ -684,6 +736,7 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 	if (!adau1701)
 		return -ENOMEM;
 
+	adau1701->client = client;
 	adau1701->regmap = devm_regmap_init(dev, NULL, client,
 					    &adau1701_regmap);
 	if (IS_ERR(adau1701->regmap))
@@ -740,8 +793,8 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, adau1701);
 
-	adau1701->sigmadsp = devm_sigmadsp_init_i2c(client, NULL,
-		ADAU1701_FIRMWARE);
+	adau1701->sigmadsp = devm_sigmadsp_init_i2c(client,
+		&adau1701_sigmadsp_ops, ADAU1701_FIRMWARE);
 	if (IS_ERR(adau1701->sigmadsp))
 		return PTR_ERR(adau1701->sigmadsp);
 
-- 
1.8.0
