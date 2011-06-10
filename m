From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Factor out redundant read() functions
Date: Fri, 10 Jun 2011 19:48:37 +0100
Message-ID: <1307731717-16506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BC0A103C10
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 20:48:41 +0200 (CEST)
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

We've got a whole bunch of functions which just call straight through to
do_hw_read(). Simplify this situation by removing them and using hw_read()
directly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   52 +++++++-----------------------------------------
 1 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 9a88a27..b88a61f 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -61,7 +61,7 @@ static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 }
 
-static unsigned int do_hw_read(struct snd_soc_codec *codec, unsigned int reg)
+static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
 {
 	int ret;
 	unsigned int val;
@@ -82,12 +82,6 @@ static unsigned int do_hw_read(struct snd_soc_codec *codec, unsigned int reg)
 	return val;
 }
 
-static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
-				      unsigned int reg)
-{
-	return do_hw_read(codec, reg);
-}
-
 static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -98,12 +92,6 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 	return do_hw_write(codec, reg, value, &data, 2);
 }
 
-static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
-				     unsigned int reg)
-{
-	return do_hw_read(codec, reg);
-}
-
 static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
@@ -126,12 +114,6 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	return do_hw_write(codec, reg, value, data, 2);
 }
 
-static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
-				     unsigned int reg)
-{
-	return do_hw_read(codec, reg);
-}
-
 static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -144,12 +126,6 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	return do_hw_write(codec, reg, value, data, 3);
 }
 
-static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
-				      unsigned int reg)
-{
-	return do_hw_read(codec, reg);
-}
-
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 static unsigned int do_i2c_read(struct snd_soc_codec *codec,
 				void *reg, int reglen,
@@ -232,12 +208,6 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 #define snd_soc_16_8_read_i2c NULL
 #endif
 
-static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
-				      unsigned int reg)
-{
-	return do_hw_read(codec, reg);
-}
-
 static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -267,12 +237,6 @@ static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
 #define snd_soc_16_16_read_i2c NULL
 #endif
 
-static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
-				       unsigned int reg)
-{
-	return do_hw_read(codec, reg);
-}
-
 static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			       unsigned int value)
 {
@@ -337,30 +301,30 @@ static struct {
 } io_types[] = {
 	{
 		.addr_bits = 4, .data_bits = 12,
-		.write = snd_soc_4_12_write, .read = snd_soc_4_12_read,
+		.write = snd_soc_4_12_write,
 	},
 	{
 		.addr_bits = 7, .data_bits = 9,
-		.write = snd_soc_7_9_write, .read = snd_soc_7_9_read,
+		.write = snd_soc_7_9_write,
 	},
 	{
 		.addr_bits = 8, .data_bits = 8,
-		.write = snd_soc_8_8_write, .read = snd_soc_8_8_read,
+		.write = snd_soc_8_8_write,
 		.i2c_read = snd_soc_8_8_read_i2c,
 	},
 	{
 		.addr_bits = 8, .data_bits = 16,
-		.write = snd_soc_8_16_write, .read = snd_soc_8_16_read,
+		.write = snd_soc_8_16_write,
 		.i2c_read = snd_soc_8_16_read_i2c,
 	},
 	{
 		.addr_bits = 16, .data_bits = 8,
-		.write = snd_soc_16_8_write, .read = snd_soc_16_8_read,
+		.write = snd_soc_16_8_write,
 		.i2c_read = snd_soc_16_8_read_i2c,
 	},
 	{
 		.addr_bits = 16, .data_bits = 16,
-		.write = snd_soc_16_16_write, .read = snd_soc_16_16_read,
+		.write = snd_soc_16_16_write,
 		.i2c_read = snd_soc_16_16_read_i2c,
 	},
 };
@@ -402,7 +366,7 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	}
 
 	codec->write = io_types[i].write;
-	codec->read = io_types[i].read;
+	codec->read = hw_read;
 	codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
 
 	switch (control) {
-- 
1.7.5.3
