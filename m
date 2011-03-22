From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: soc-cache: Factor-out the I2C read
	code
Date: Tue, 22 Mar 2011 10:37:01 +0000
Message-ID: <1300790223-13308-5-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04A94103865
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:37:11 +0100 (CET)
In-Reply-To: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The handling of all snd_soc_x_y_read_i2c() functions is similar.
Make a generic I2C read function and update all callers to use it.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  100 ++++++++++++++++---------------------------------
 1 files changed, 32 insertions(+), 68 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index e242ff7..4043a98 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -224,33 +224,48 @@ static int snd_soc_8_16_spi_write(void *control_data, const char *data,
 #endif
 
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-static unsigned int snd_soc_8_8_read_i2c(struct snd_soc_codec *codec,
-					  unsigned int r)
+static unsigned int do_i2c_read(struct snd_soc_codec *codec,
+				void *reg, int reglen,
+				void *data, int datalen)
 {
 	struct i2c_msg xfer[2];
-	u8 reg = r;
-	u8 data;
 	int ret;
 	struct i2c_client *client = codec->control_data;
 
 	/* Write register */
 	xfer[0].addr = client->addr;
 	xfer[0].flags = 0;
-	xfer[0].len = 1;
-	xfer[0].buf = &reg;
+	xfer[0].len = reglen;
+	xfer[0].buf = reg;
 
 	/* Read data */
 	xfer[1].addr = client->addr;
 	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 1;
-	xfer[1].buf = &data;
+	xfer[1].len = datalen;
+	xfer[1].buf = data;
 
 	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret != 2) {
-		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+	dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+	if (ret == 2)
 		return 0;
-	}
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+#endif
 
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+static unsigned int snd_soc_8_8_read_i2c(struct snd_soc_codec *codec,
+					  unsigned int r)
+{
+	u8 reg = r;
+	u8 data;
+	int ret;
+
+	ret = do_i2c_read(codec, &reg, 1, &data, 1);
+	if (ret < 0)
+		return 0;
 	return data;
 }
 #else
@@ -261,30 +276,13 @@ static unsigned int snd_soc_8_8_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_8_16_read_i2c(struct snd_soc_codec *codec,
 					  unsigned int r)
 {
-	struct i2c_msg xfer[2];
 	u8 reg = r;
 	u16 data;
 	int ret;
-	struct i2c_client *client = codec->control_data;
 
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 1;
-	xfer[0].buf = &reg;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 2;
-	xfer[1].buf = (u8 *)&data;
-
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret != 2) {
-		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+	ret = do_i2c_read(codec, &reg, 1, &data, 2);
+	if (ret < 0)
 		return 0;
-	}
-
 	return (data >> 8) | ((data & 0xff) << 8);
 }
 #else
@@ -295,30 +293,13 @@ static unsigned int snd_soc_8_16_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 					  unsigned int r)
 {
-	struct i2c_msg xfer[2];
 	u16 reg = r;
 	u8 data;
 	int ret;
-	struct i2c_client *client = codec->control_data;
-
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 2;
-	xfer[0].buf = (u8 *)&reg;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 1;
-	xfer[1].buf = &data;
 
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret != 2) {
-		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+	ret = do_i2c_read(codec, &reg, 2, &data, 1);
+	if (ret < 0)
 		return 0;
-	}
-
 	return data;
 }
 #else
@@ -364,30 +345,13 @@ static int snd_soc_16_8_spi_write(void *control_data, const char *data,
 static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
 					   unsigned int r)
 {
-	struct i2c_msg xfer[2];
 	u16 reg = cpu_to_be16(r);
 	u16 data;
 	int ret;
-	struct i2c_client *client = codec->control_data;
-
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 2;
-	xfer[0].buf = (u8 *)&reg;
 
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 2;
-	xfer[1].buf = (u8 *)&data;
-
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret != 2) {
-		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+	ret = do_i2c_read(codec, &reg, 2, &data, 2);
+	if (ret < 0)
 		return 0;
-	}
-
 	return be16_to_cpu(data);
 }
 #else
-- 
1.7.4.1
