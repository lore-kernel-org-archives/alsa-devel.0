From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/8] ASoC: Factor out I2C 8 bit address 16 bit
	data I/O
Date: Mon,  3 Aug 2009 17:09:48 +0100
Message-ID: <1249315790-22814-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E40324794
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 18:09:54 +0200 (CEST)
In-Reply-To: <1249315790-22814-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

As part of this refactoring the type of the CODEC hw_read operation
is changed to match the regular read operation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    2 +-
 sound/soc/soc-cache.c |   79 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d0b29a5..4a5846e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -373,7 +373,7 @@ struct snd_soc_codec {
 				size_t, unsigned int);
 	int (*volatile_register)(unsigned int);
 	hw_write_t hw_write;
-	hw_read_t hw_read;
+	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	void *reg_cache;
 	short reg_cache_size;
 	short reg_cache_step;
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 8b12668..ab058b8 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -46,14 +46,82 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 }
 
+static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
+			      unsigned int value)
+{
+	u16 *reg_cache = codec->reg_cache;
+	u8 data[3];
+
+	data[0] = reg;
+	data[1] = (value >> 8) & 0xff;
+	data[2] = value & 0xff;
+
+	if (!snd_soc_codec_volatile_register(codec, reg))
+		reg_cache[reg] = value;
+
+	if (codec->hw_write(codec->control_data, data, 3) == 3)
+		return 0;
+	else
+		return -EIO;
+}
+
+static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
+				      unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+
+	if (reg >= codec->reg_cache_size ||
+	    snd_soc_codec_volatile_register(codec, reg))
+		return codec->hw_read(codec, reg);
+	else
+		return cache[reg];
+}
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static unsigned int snd_soc_8_16_read_i2c(struct snd_soc_codec *codec,
+					  unsigned int r)
+{
+	struct i2c_msg xfer[2];
+	u8 reg = r;
+	u16 data;
+	int ret;
+	struct i2c_client *client = codec->control_data;
+
+	/* Write register */
+	xfer[0].addr = client->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 1;
+	xfer[0].buf = &reg;
+
+	/* Read data */
+	xfer[1].addr = client->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = 2;
+	xfer[1].buf = (u8 *)&data;
+
+	ret = i2c_transfer(client->adapter, xfer, 2);
+	if (ret != 2) {
+		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+		return 0;
+	}
+
+	return (data >> 8) | ((data & 0xff) << 8);
+}
+#else
+#define snd_soc_8_16_read_i2c NULL
+#endif
 
 static struct {
 	int addr_bits;
 	int data_bits;
-	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
+	int (*write)(struct snd_soc_codec *codec, unsigned int, unsigned int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
+	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
 } io_types[] = {
 	{ 7, 9, snd_soc_7_9_write, snd_soc_7_9_read },
+	{ 8, 16,
+	  snd_soc_8_16_write, snd_soc_8_16_read,
+	  snd_soc_8_16_read_i2c },
 };
 
 /**
@@ -82,13 +150,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 {
 	int i;
 
-	/* We don't support volatile registers yet - refactoring of
-	 * the hw_read operation will be required to do so. */
-	if (codec->volatile_register) {
-		printk(KERN_ERR "Volatile registers not yet supported\n");
-		return -EINVAL;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(io_types); i++)
 		if (io_types[i].addr_bits == addr_bits &&
 		    io_types[i].data_bits == data_bits)
@@ -111,6 +172,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 		codec->hw_write = (hw_write_t)i2c_master_send;
 #endif
+		if (io_types[i].i2c_read)
+			codec->hw_read = io_types[i].i2c_read;
 		break;
 
 	case SND_SOC_SPI:
-- 
1.6.3.3
