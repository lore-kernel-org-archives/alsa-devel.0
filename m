From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Move register I/O code into a separate
	file
Date: Mon, 13 Jun 2011 17:51:07 +0100
Message-ID: <1307983867-5084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59F102453B
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 18:51:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

For clarity and to help ongoing refactoring in this area create a new file
to contain the physical I/O functions, separating them out from the cache
operations.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/Makefile    |    3 +-
 sound/soc/soc-cache.c |  380 ----------------------------------------------
 sound/soc/soc-io.c    |  399 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 401 insertions(+), 381 deletions(-)
 create mode 100644 sound/soc/soc-io.c

diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index adb5719..4f91387 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,4 +1,5 @@
-snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o soc-pcm.o
+snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
+snd-soc-core-objs += soc-pcm.o soc-io.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index b88a61f..d9f8ade 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -20,386 +20,6 @@
 
 #include <trace/events/asoc.h>
 
-#ifdef CONFIG_SPI_MASTER
-static int do_spi_write(void *control, const char *data, int len)
-{
-	struct spi_device *spi = control;
-	int ret;
-
-	ret = spi_write(spi, data, len);
-	if (ret < 0)
-		return ret;
-
-	return len;
-}
-#endif
-
-static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
-		       unsigned int value, const void *data, int len)
-{
-	int ret;
-
-	if (!snd_soc_codec_volatile_register(codec, reg) &&
-	    reg < codec->driver->reg_cache_size &&
-	    !codec->cache_bypass) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret < 0)
-			return -1;
-	}
-
-	if (codec->cache_only) {
-		codec->cache_sync = 1;
-		return 0;
-	}
-
-	ret = codec->hw_write(codec->control_data, data, len);
-	if (ret == len)
-		return 0;
-	if (ret < 0)
-		return ret;
-	else
-		return -EIO;
-}
-
-static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	int ret;
-	unsigned int val;
-
-	if (reg >= codec->driver->reg_cache_size ||
-	    snd_soc_codec_volatile_register(codec, reg) ||
-	    codec->cache_bypass) {
-		if (codec->cache_only)
-			return -1;
-
-		BUG_ON(!codec->hw_read);
-		return codec->hw_read(codec, reg);
-	}
-
-	ret = snd_soc_cache_read(codec, reg, &val);
-	if (ret < 0)
-		return -1;
-	return val;
-}
-
-static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
-			      unsigned int value)
-{
-	u16 data;
-
-	data = cpu_to_be16((reg << 12) | (value & 0xffffff));
-
-	return do_hw_write(codec, reg, value, &data, 2);
-}
-
-static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
-			     unsigned int value)
-{
-	u16 data;
-
-	data = cpu_to_be16((reg << 9) | (value & 0x1ff));
-
-	return do_hw_write(codec, reg, value, &data, 2);
-}
-
-static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
-			     unsigned int value)
-{
-	u8 data[2];
-
-	reg &= 0xff;
-	data[0] = reg;
-	data[1] = value & 0xff;
-
-	return do_hw_write(codec, reg, value, data, 2);
-}
-
-static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
-			      unsigned int value)
-{
-	u8 data[3];
-	u16 val = cpu_to_be16(value);
-
-	data[0] = reg;
-	memcpy(&data[1], &val, sizeof(val));
-
-	return do_hw_write(codec, reg, value, data, 3);
-}
-
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-static unsigned int do_i2c_read(struct snd_soc_codec *codec,
-				void *reg, int reglen,
-				void *data, int datalen)
-{
-	struct i2c_msg xfer[2];
-	int ret;
-	struct i2c_client *client = codec->control_data;
-
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = reglen;
-	xfer[0].buf = reg;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = datalen;
-	xfer[1].buf = data;
-
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret == 2)
-		return 0;
-	else if (ret < 0)
-		return ret;
-	else
-		return -EIO;
-}
-#endif
-
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-static unsigned int snd_soc_8_8_read_i2c(struct snd_soc_codec *codec,
-					 unsigned int r)
-{
-	u8 reg = r;
-	u8 data;
-	int ret;
-
-	ret = do_i2c_read(codec, &reg, 1, &data, 1);
-	if (ret < 0)
-		return 0;
-	return data;
-}
-#else
-#define snd_soc_8_8_read_i2c NULL
-#endif
-
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-static unsigned int snd_soc_8_16_read_i2c(struct snd_soc_codec *codec,
-					  unsigned int r)
-{
-	u8 reg = r;
-	u16 data;
-	int ret;
-
-	ret = do_i2c_read(codec, &reg, 1, &data, 2);
-	if (ret < 0)
-		return 0;
-	return (data >> 8) | ((data & 0xff) << 8);
-}
-#else
-#define snd_soc_8_16_read_i2c NULL
-#endif
-
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
-					  unsigned int r)
-{
-	u16 reg = r;
-	u8 data;
-	int ret;
-
-	ret = do_i2c_read(codec, &reg, 2, &data, 1);
-	if (ret < 0)
-		return 0;
-	return data;
-}
-#else
-#define snd_soc_16_8_read_i2c NULL
-#endif
-
-static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
-			      unsigned int value)
-{
-	u8 data[3];
-	u16 rval = cpu_to_be16(reg);
-
-	memcpy(data, &rval, sizeof(rval));
-	data[2] = value;
-
-	return do_hw_write(codec, reg, value, data, 3);
-}
-
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
-					   unsigned int r)
-{
-	u16 reg = cpu_to_be16(r);
-	u16 data;
-	int ret;
-
-	ret = do_i2c_read(codec, &reg, 2, &data, 2);
-	if (ret < 0)
-		return 0;
-	return be16_to_cpu(data);
-}
-#else
-#define snd_soc_16_16_read_i2c NULL
-#endif
-
-static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
-			       unsigned int value)
-{
-	u16 data[2];
-
-	data[0] = cpu_to_be16(reg);
-	data[1] = cpu_to_be16(value);
-
-	return do_hw_write(codec, reg, value, data, sizeof(data));
-}
-
-/* Primitive bulk write support for soc-cache.  The data pointed to by
- * `data' needs to already be in the form the hardware expects
- * including any leading register specific data.  Any data written
- * through this function will not go through the cache as it only
- * handles writing to volatile or out of bounds registers.
- */
-static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int reg,
-				     const void *data, size_t len)
-{
-	int ret;
-
-	/* To ensure that we don't get out of sync with the cache, check
-	 * whether the base register is volatile or if we've directly asked
-	 * to bypass the cache.  Out of bounds registers are considered
-	 * volatile.
-	 */
-	if (!codec->cache_bypass
-	    && !snd_soc_codec_volatile_register(codec, reg)
-	    && reg < codec->driver->reg_cache_size)
-		return -EINVAL;
-
-	switch (codec->control_type) {
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-	case SND_SOC_I2C:
-		ret = i2c_master_send(codec->control_data, data, len);
-		break;
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	case SND_SOC_SPI:
-		ret = spi_write(codec->control_data, data, len);
-		break;
-#endif
-	default:
-		BUG();
-	}
-
-	if (ret == len)
-		return 0;
-	if (ret < 0)
-		return ret;
-	else
-		return -EIO;
-}
-
-static struct {
-	int addr_bits;
-	int data_bits;
-	int (*write)(struct snd_soc_codec *codec, unsigned int, unsigned int);
-	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
-	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
-} io_types[] = {
-	{
-		.addr_bits = 4, .data_bits = 12,
-		.write = snd_soc_4_12_write,
-	},
-	{
-		.addr_bits = 7, .data_bits = 9,
-		.write = snd_soc_7_9_write,
-	},
-	{
-		.addr_bits = 8, .data_bits = 8,
-		.write = snd_soc_8_8_write,
-		.i2c_read = snd_soc_8_8_read_i2c,
-	},
-	{
-		.addr_bits = 8, .data_bits = 16,
-		.write = snd_soc_8_16_write,
-		.i2c_read = snd_soc_8_16_read_i2c,
-	},
-	{
-		.addr_bits = 16, .data_bits = 8,
-		.write = snd_soc_16_8_write,
-		.i2c_read = snd_soc_16_8_read_i2c,
-	},
-	{
-		.addr_bits = 16, .data_bits = 16,
-		.write = snd_soc_16_16_write,
-		.i2c_read = snd_soc_16_16_read_i2c,
-	},
-};
-
-/**
- * snd_soc_codec_set_cache_io: Set up standard I/O functions.
- *
- * @codec: CODEC to configure.
- * @addr_bits: Number of bits of register address data.
- * @data_bits: Number of bits of data per register.
- * @control: Control bus used.
- *
- * Register formats are frequently shared between many I2C and SPI
- * devices.  In order to promote code reuse the ASoC core provides
- * some standard implementations of CODEC read and write operations
- * which can be set up using this function.
- *
- * The caller is responsible for allocating and initialising the
- * actual cache.
- *
- * Note that at present this code cannot be used by CODECs with
- * volatile registers.
- */
-int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       int addr_bits, int data_bits,
-			       enum snd_soc_control_type control)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(io_types); i++)
-		if (io_types[i].addr_bits == addr_bits &&
-		    io_types[i].data_bits == data_bits)
-			break;
-	if (i == ARRAY_SIZE(io_types)) {
-		printk(KERN_ERR
-		       "No I/O functions for %d bit address %d bit data\n",
-		       addr_bits, data_bits);
-		return -EINVAL;
-	}
-
-	codec->write = io_types[i].write;
-	codec->read = hw_read;
-	codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
-
-	switch (control) {
-	case SND_SOC_CUSTOM:
-		break;
-
-	case SND_SOC_I2C:
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-		codec->hw_write = (hw_write_t)i2c_master_send;
-#endif
-		if (io_types[i].i2c_read)
-			codec->hw_read = io_types[i].i2c_read;
-
-		codec->control_data = container_of(codec->dev,
-						   struct i2c_client,
-						   dev);
-		break;
-
-	case SND_SOC_SPI:
-#ifdef CONFIG_SPI_MASTER
-		codec->hw_write = do_spi_write;
-#endif
-
-		codec->control_data = container_of(codec->dev,
-						   struct spi_device,
-						   dev);
-		break;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
-
 static bool snd_soc_set_cache_val(void *base, unsigned int idx,
 				  unsigned int val, unsigned int word_size)
 {
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
new file mode 100644
index 0000000..855e5cd
--- /dev/null
+++ b/sound/soc/soc-io.c
@@ -0,0 +1,399 @@
+/*
+ * soc-io.c  --  ASoC register I/O helpers
+ *
+ * Copyright 2009-2011 Wolfson Microelectronics PLC.
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <sound/soc.h>
+
+#include <trace/events/asoc.h>
+
+#ifdef CONFIG_SPI_MASTER
+static int do_spi_write(void *control, const char *data, int len)
+{
+	struct spi_device *spi = control;
+	int ret;
+
+	ret = spi_write(spi, data, len);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+#endif
+
+static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value, const void *data, int len)
+{
+	int ret;
+
+	if (!snd_soc_codec_volatile_register(codec, reg) &&
+	    reg < codec->driver->reg_cache_size &&
+	    !codec->cache_bypass) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
+
+	if (codec->cache_only) {
+		codec->cache_sync = 1;
+		return 0;
+	}
+
+	ret = codec->hw_write(codec->control_data, data, len);
+	if (ret == len)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	int ret;
+	unsigned int val;
+
+	if (reg >= codec->driver->reg_cache_size ||
+	    snd_soc_codec_volatile_register(codec, reg) ||
+	    codec->cache_bypass) {
+		if (codec->cache_only)
+			return -1;
+
+		BUG_ON(!codec->hw_read);
+		return codec->hw_read(codec, reg);
+	}
+
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
+}
+
+static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
+			      unsigned int value)
+{
+	u16 data;
+
+	data = cpu_to_be16((reg << 12) | (value & 0xffffff));
+
+	return do_hw_write(codec, reg, value, &data, 2);
+}
+
+static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int value)
+{
+	u16 data;
+
+	data = cpu_to_be16((reg << 9) | (value & 0x1ff));
+
+	return do_hw_write(codec, reg, value, &data, 2);
+}
+
+static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int value)
+{
+	u8 data[2];
+
+	reg &= 0xff;
+	data[0] = reg;
+	data[1] = value & 0xff;
+
+	return do_hw_write(codec, reg, value, data, 2);
+}
+
+static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
+			      unsigned int value)
+{
+	u8 data[3];
+	u16 val = cpu_to_be16(value);
+
+	data[0] = reg;
+	memcpy(&data[1], &val, sizeof(val));
+
+	return do_hw_write(codec, reg, value, data, 3);
+}
+
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+static unsigned int do_i2c_read(struct snd_soc_codec *codec,
+				void *reg, int reglen,
+				void *data, int datalen)
+{
+	struct i2c_msg xfer[2];
+	int ret;
+	struct i2c_client *client = codec->control_data;
+
+	/* Write register */
+	xfer[0].addr = client->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = reglen;
+	xfer[0].buf = reg;
+
+	/* Read data */
+	xfer[1].addr = client->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = datalen;
+	xfer[1].buf = data;
+
+	ret = i2c_transfer(client->adapter, xfer, 2);
+	if (ret == 2)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+#endif
+
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+static unsigned int snd_soc_8_8_read_i2c(struct snd_soc_codec *codec,
+					 unsigned int r)
+{
+	u8 reg = r;
+	u8 data;
+	int ret;
+
+	ret = do_i2c_read(codec, &reg, 1, &data, 1);
+	if (ret < 0)
+		return 0;
+	return data;
+}
+#else
+#define snd_soc_8_8_read_i2c NULL
+#endif
+
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+static unsigned int snd_soc_8_16_read_i2c(struct snd_soc_codec *codec,
+					  unsigned int r)
+{
+	u8 reg = r;
+	u16 data;
+	int ret;
+
+	ret = do_i2c_read(codec, &reg, 1, &data, 2);
+	if (ret < 0)
+		return 0;
+	return (data >> 8) | ((data & 0xff) << 8);
+}
+#else
+#define snd_soc_8_16_read_i2c NULL
+#endif
+
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
+					  unsigned int r)
+{
+	u16 reg = r;
+	u8 data;
+	int ret;
+
+	ret = do_i2c_read(codec, &reg, 2, &data, 1);
+	if (ret < 0)
+		return 0;
+	return data;
+}
+#else
+#define snd_soc_16_8_read_i2c NULL
+#endif
+
+static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
+			      unsigned int value)
+{
+	u8 data[3];
+	u16 rval = cpu_to_be16(reg);
+
+	memcpy(data, &rval, sizeof(rval));
+	data[2] = value;
+
+	return do_hw_write(codec, reg, value, data, 3);
+}
+
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
+					   unsigned int r)
+{
+	u16 reg = cpu_to_be16(r);
+	u16 data;
+	int ret;
+
+	ret = do_i2c_read(codec, &reg, 2, &data, 2);
+	if (ret < 0)
+		return 0;
+	return be16_to_cpu(data);
+}
+#else
+#define snd_soc_16_16_read_i2c NULL
+#endif
+
+static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
+			       unsigned int value)
+{
+	u16 data[2];
+
+	data[0] = cpu_to_be16(reg);
+	data[1] = cpu_to_be16(value);
+
+	return do_hw_write(codec, reg, value, data, sizeof(data));
+}
+
+/* Primitive bulk write support for soc-cache.  The data pointed to by
+ * `data' needs to already be in the form the hardware expects
+ * including any leading register specific data.  Any data written
+ * through this function will not go through the cache as it only
+ * handles writing to volatile or out of bounds registers.
+ */
+static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int reg,
+				     const void *data, size_t len)
+{
+	int ret;
+
+	/* To ensure that we don't get out of sync with the cache, check
+	 * whether the base register is volatile or if we've directly asked
+	 * to bypass the cache.  Out of bounds registers are considered
+	 * volatile.
+	 */
+	if (!codec->cache_bypass
+	    && !snd_soc_codec_volatile_register(codec, reg)
+	    && reg < codec->driver->reg_cache_size)
+		return -EINVAL;
+
+	switch (codec->control_type) {
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+	case SND_SOC_I2C:
+		ret = i2c_master_send(codec->control_data, data, len);
+		break;
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	case SND_SOC_SPI:
+		ret = spi_write(codec->control_data, data, len);
+		break;
+#endif
+	default:
+		BUG();
+	}
+
+	if (ret == len)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static struct {
+	int addr_bits;
+	int data_bits;
+	int (*write)(struct snd_soc_codec *codec, unsigned int, unsigned int);
+	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
+	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
+} io_types[] = {
+	{
+		.addr_bits = 4, .data_bits = 12,
+		.write = snd_soc_4_12_write,
+	},
+	{
+		.addr_bits = 7, .data_bits = 9,
+		.write = snd_soc_7_9_write,
+	},
+	{
+		.addr_bits = 8, .data_bits = 8,
+		.write = snd_soc_8_8_write,
+		.i2c_read = snd_soc_8_8_read_i2c,
+	},
+	{
+		.addr_bits = 8, .data_bits = 16,
+		.write = snd_soc_8_16_write,
+		.i2c_read = snd_soc_8_16_read_i2c,
+	},
+	{
+		.addr_bits = 16, .data_bits = 8,
+		.write = snd_soc_16_8_write,
+		.i2c_read = snd_soc_16_8_read_i2c,
+	},
+	{
+		.addr_bits = 16, .data_bits = 16,
+		.write = snd_soc_16_16_write,
+		.i2c_read = snd_soc_16_16_read_i2c,
+	},
+};
+
+/**
+ * snd_soc_codec_set_cache_io: Set up standard I/O functions.
+ *
+ * @codec: CODEC to configure.
+ * @addr_bits: Number of bits of register address data.
+ * @data_bits: Number of bits of data per register.
+ * @control: Control bus used.
+ *
+ * Register formats are frequently shared between many I2C and SPI
+ * devices.  In order to promote code reuse the ASoC core provides
+ * some standard implementations of CODEC read and write operations
+ * which can be set up using this function.
+ *
+ * The caller is responsible for allocating and initialising the
+ * actual cache.
+ *
+ * Note that at present this code cannot be used by CODECs with
+ * volatile registers.
+ */
+int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
+			       int addr_bits, int data_bits,
+			       enum snd_soc_control_type control)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(io_types); i++)
+		if (io_types[i].addr_bits == addr_bits &&
+		    io_types[i].data_bits == data_bits)
+			break;
+	if (i == ARRAY_SIZE(io_types)) {
+		printk(KERN_ERR
+		       "No I/O functions for %d bit address %d bit data\n",
+		       addr_bits, data_bits);
+		return -EINVAL;
+	}
+
+	codec->write = io_types[i].write;
+	codec->read = hw_read;
+	codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
+
+	switch (control) {
+	case SND_SOC_CUSTOM:
+		break;
+
+	case SND_SOC_I2C:
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+		codec->hw_write = (hw_write_t)i2c_master_send;
+#endif
+		if (io_types[i].i2c_read)
+			codec->hw_read = io_types[i].i2c_read;
+
+		codec->control_data = container_of(codec->dev,
+						   struct i2c_client,
+						   dev);
+		break;
+
+	case SND_SOC_SPI:
+#ifdef CONFIG_SPI_MASTER
+		codec->hw_write = do_spi_write;
+#endif
+
+		codec->control_data = container_of(codec->dev,
+						   struct spi_device,
+						   dev);
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
+
-- 
1.7.5.4
