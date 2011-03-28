From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: soc-cache: Fix indentation issues
Date: Mon, 28 Mar 2011 11:34:41 +0100
Message-ID: <1301308482-15747-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3F7010382C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 12:34:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 1210a6f..22c0b95 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -93,13 +93,13 @@ static unsigned int do_hw_read(struct snd_soc_codec *codec, unsigned int reg)
 }
 
 static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
-				     unsigned int reg)
+				      unsigned int reg)
 {
 	return do_hw_read(codec, reg);
 }
 
 static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
-			     unsigned int value)
+			      unsigned int value)
 {
 	u8 data[2];
 
@@ -111,7 +111,7 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 
 #if defined(CONFIG_SPI_MASTER)
 static int snd_soc_4_12_spi_write(void *control_data, const char *data,
-				 int len)
+				  int len)
 {
 	u8 msg[2];
 
@@ -209,7 +209,7 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 
 #if defined(CONFIG_SPI_MASTER)
 static int snd_soc_8_16_spi_write(void *control_data, const char *data,
-				 int len)
+				  int len)
 {
 	u8 msg[3];
 
@@ -257,7 +257,7 @@ static unsigned int do_i2c_read(struct snd_soc_codec *codec,
 
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 static unsigned int snd_soc_8_8_read_i2c(struct snd_soc_codec *codec,
-					  unsigned int r)
+					 unsigned int r)
 {
 	u8 reg = r;
 	u8 data;
@@ -307,13 +307,13 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 #endif
 
 static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
-				     unsigned int reg)
+				      unsigned int reg)
 {
 	return do_hw_read(codec, reg);
 }
 
 static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
-			     unsigned int value)
+			      unsigned int value)
 {
 	u8 data[3];
 
@@ -327,7 +327,7 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 
 #if defined(CONFIG_SPI_MASTER)
 static int snd_soc_16_8_spi_write(void *control_data, const char *data,
-				 int len)
+				  int len)
 {
 	u8 msg[3];
 
@@ -379,7 +379,7 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 
 #if defined(CONFIG_SPI_MASTER)
 static int snd_soc_16_16_spi_write(void *control_data, const char *data,
-				 int len)
+				   int len)
 {
 	u8 msg[4];
 
-- 
1.7.4.1
