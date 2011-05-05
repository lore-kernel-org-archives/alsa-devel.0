From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: Get rid of snd_soc_*_*_spi_write
	wrapper functions
Date: Thu,  5 May 2011 19:52:45 +0200
Message-ID: <1304617966-4410-3-git-send-email-lars@metafoo.de>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with ESMTP id B545F2414A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 19:53:12 +0200 (CEST)
In-Reply-To: <1304617966-4410-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mike Frysinger <vapier@gentoo.org>
Cc: device-driver-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

All the different snd_soc_*_*_spi_write functions are nothing but mere wrappers
around do_spi_write().
This patch removes them and uses do_spi_write directly as the codecs hw_write
callback instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-cache.c |  108 ++-----------------------------------------------
 1 files changed, 4 insertions(+), 104 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 080fab2..f1ee207 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -21,7 +21,7 @@
 #include <trace/events/asoc.h>
 
 #if defined(CONFIG_SPI_MASTER)
-static int do_spi_write(void *control_data, const void *msg,
+static int do_spi_write(void *control_data, const char *msg,
 			int len)
 {
 	struct spi_device *spi = control_data;
@@ -42,6 +42,8 @@ static int do_spi_write(void *control_data, const void *msg,
 
 	return len;
 }
+#else
+#define do_spi_write NULL
 #endif
 
 static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
@@ -109,21 +111,6 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 	return do_hw_write(codec, reg, value, data, 2);
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
@@ -141,21 +128,6 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
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
@@ -174,21 +146,6 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
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
@@ -207,22 +164,6 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
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
@@ -324,22 +265,6 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
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
@@ -376,23 +301,6 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
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
@@ -440,43 +348,36 @@ static struct {
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
 
@@ -537,8 +438,7 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_SPI:
-		if (io_types[i].spi_write)
-			codec->hw_write = io_types[i].spi_write;
+		codec->hw_write = do_spi_write;
 
 		codec->control_data = container_of(codec->dev,
 						   struct spi_device,
-- 
1.7.2.5
