From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Use spi_write() for SPI writes
Date: Wed, 11 May 2011 13:53:53 +0200
Message-ID: <1305114833-7553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94F9124791
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 13:53:54 +0200 (CEST)
In-Reply-To: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

do_spi_write() is just an open coded copy of do_spi_write() so we can
delete it and just call spi_write() directly.  Indeed, as a result of
recent refactoring all the SPI write functions are just very long
wrappers around spi_write() which don't add anything except for some
pointless copies so we can just use spi_write() as the hw_write
operation directly. It should be as type safe to do this as it is to do
the same thing with I2C and it saves us a bunch of code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  132 ++-----------------------------------------------
 1 files changed, 4 insertions(+), 128 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 73907e5..01e5b98 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -20,30 +20,6 @@
 
 #include <trace/events/asoc.h>
 
-#if defined(CONFIG_SPI_MASTER)
-static int do_spi_write(void *control_data, const void *msg,
-			int len)
-{
-	struct spi_device *spi = control_data;
-	struct spi_transfer t;
-	struct spi_message m;
-
-	if (len <= 0)
-		return 0;
-
-	spi_message_init(&m);
-	memset(&t, 0, sizeof t);
-
-	t.tx_buf = msg;
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
-}
-#endif
-
 static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		       unsigned int value, const void *data, int len)
 {
@@ -108,21 +84,6 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 	return do_hw_write(codec, reg, value, &data, 2);
 }
 
-#if defined(CONFIG_SPI_MASTER)
-static int snd_soc_4_12_spi_write(void *control_data, const char *data,
-				  int len)
-{
-	u8 msg[2];
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	return do_spi_write(control_data, msg, len);
-}
-#else
-#define snd_soc_4_12_spi_write NULL
-#endif
-
 static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
@@ -140,21 +101,6 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 	return do_hw_write(codec, reg, value, data, 2);
 }
 
-#if defined(CONFIG_SPI_MASTER)
-static int snd_soc_7_9_spi_write(void *control_data, const char *data,
-				 int len)
-{
-	u8 msg[2];
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	return do_spi_write(control_data, msg, len);
-}
-#else
-#define snd_soc_7_9_spi_write NULL
-#endif
-
 static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
@@ -173,21 +119,6 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 	return do_hw_read(codec, reg);
 }
 
-#if defined(CONFIG_SPI_MASTER)
-static int snd_soc_8_8_spi_write(void *control_data, const char *data,
-				 int len)
-{
-	u8 msg[2];
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	return do_spi_write(control_data, msg, len);
-}
-#else
-#define snd_soc_8_8_spi_write NULL
-#endif
-
 static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -206,22 +137,6 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 	return do_hw_read(codec, reg);
 }
 
-#if defined(CONFIG_SPI_MASTER)
-static int snd_soc_8_16_spi_write(void *control_data, const char *data,
-				  int len)
-{
-	u8 msg[3];
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-	msg[2] = data[2];
-
-	return do_spi_write(control_data, msg, len);
-}
-#else
-#define snd_soc_8_16_spi_write NULL
-#endif
-
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 static unsigned int do_i2c_read(struct snd_soc_codec *codec,
 				void *reg, int reglen,
@@ -322,22 +237,6 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	return do_hw_write(codec, reg, value, data, 3);
 }
 
-#if defined(CONFIG_SPI_MASTER)
-static int snd_soc_16_8_spi_write(void *control_data, const char *data,
-				  int len)
-{
-	u8 msg[3];
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-	msg[2] = data[2];
-
-	return do_spi_write(control_data, msg, len);
-}
-#else
-#define snd_soc_16_8_spi_write NULL
-#endif
-
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
 					   unsigned int r)
@@ -374,23 +273,6 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	return do_hw_write(codec, reg, value, data, 4);
 }
 
-#if defined(CONFIG_SPI_MASTER)
-static int snd_soc_16_16_spi_write(void *control_data, const char *data,
-				   int len)
-{
-	u8 msg[4];
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-	msg[2] = data[2];
-	msg[3] = data[3];
-
-	return do_spi_write(control_data, msg, len);
-}
-#else
-#define snd_soc_16_16_spi_write NULL
-#endif
-
 /* Primitive bulk write support for soc-cache.  The data pointed to by
  * `data' needs to already be in the form the hardware expects
  * including any leading register specific data.  Any data written
@@ -420,7 +302,7 @@ static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int r
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	case SND_SOC_SPI:
-		ret = do_spi_write(codec->control_data, data, len);
+		ret = spi_write(codec->control_data, data, len);
 		break;
 #endif
 	default:
@@ -439,43 +321,36 @@ static struct {
 	int addr_bits;
 	int data_bits;
 	int (*write)(struct snd_soc_codec *codec, unsigned int, unsigned int);
-	int (*spi_write)(void *, const char *, int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
 } io_types[] = {
 	{
 		.addr_bits = 4, .data_bits = 12,
 		.write = snd_soc_4_12_write, .read = snd_soc_4_12_read,
-		.spi_write = snd_soc_4_12_spi_write,
 	},
 	{
 		.addr_bits = 7, .data_bits = 9,
 		.write = snd_soc_7_9_write, .read = snd_soc_7_9_read,
-		.spi_write = snd_soc_7_9_spi_write,
 	},
 	{
 		.addr_bits = 8, .data_bits = 8,
 		.write = snd_soc_8_8_write, .read = snd_soc_8_8_read,
 		.i2c_read = snd_soc_8_8_read_i2c,
-		.spi_write = snd_soc_8_8_spi_write,
 	},
 	{
 		.addr_bits = 8, .data_bits = 16,
 		.write = snd_soc_8_16_write, .read = snd_soc_8_16_read,
 		.i2c_read = snd_soc_8_16_read_i2c,
-		.spi_write = snd_soc_8_16_spi_write,
 	},
 	{
 		.addr_bits = 16, .data_bits = 8,
 		.write = snd_soc_16_8_write, .read = snd_soc_16_8_read,
 		.i2c_read = snd_soc_16_8_read_i2c,
-		.spi_write = snd_soc_16_8_spi_write,
 	},
 	{
 		.addr_bits = 16, .data_bits = 16,
 		.write = snd_soc_16_16_write, .read = snd_soc_16_16_read,
 		.i2c_read = snd_soc_16_16_read_i2c,
-		.spi_write = snd_soc_16_16_spi_write,
 	},
 };
 
@@ -536,8 +411,9 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_SPI:
-		if (io_types[i].spi_write)
-			codec->hw_write = io_types[i].spi_write;
+#ifdef CONFIG_SPI_MASTER
+		codec->hw_write = (hw_write_t)spi_write;
+#endif
 
 		codec->control_data = container_of(codec->dev,
 						   struct spi_device,
-- 
1.7.5.1
