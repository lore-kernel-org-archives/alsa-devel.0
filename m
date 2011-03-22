From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: soc-cache: Factor-out the SPI write
	code
Date: Tue, 22 Mar 2011 10:37:00 +0000
Message-ID: <1300790223-13308-4-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48B7E103865
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:37:09 +0100 (CET)
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

The handling of all snd_soc_x_y_spi_write() functions is similar.
Create a separate function and update all callers to use it.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  126 ++++++++++++-------------------------------------
 1 files changed, 30 insertions(+), 96 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 874e435..e242ff7 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -20,6 +20,30 @@
 
 #include <trace/events/asoc.h>
 
+#if defined(CONFIG_SPI_MASTER)
+static int do_spi_write(void *control_data, const void *msg,
+			int len)
+{
+	struct spi_device *spi = control_data;
+	struct spi_transfer t;
+	struct spi_message m;
+
+	if (len <= 0)
+		return 0;
+
+	spi_message_init(&m);
+	memset(&t, 0, sizeof t);
+
+	t.tx_buf = msg;
+	t.len = len;
+
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	return len;
+}
+#endif
+
 static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		       unsigned int value, const void *data, int len)
 {
@@ -89,27 +113,12 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 static int snd_soc_4_12_spi_write(void *control_data, const char *data,
 				 int len)
 {
-	struct spi_device *spi = control_data;
-	struct spi_transfer t;
-	struct spi_message m;
 	u8 msg[2];
 
-	if (len <= 0)
-		return 0;
-
 	msg[0] = data[1];
 	msg[1] = data[0];
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof t);
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
+	return do_spi_write(control_data, msg, len);
 }
 #else
 #define snd_soc_4_12_spi_write NULL
@@ -136,27 +145,12 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 static int snd_soc_7_9_spi_write(void *control_data, const char *data,
 				 int len)
 {
-	struct spi_device *spi = control_data;
-	struct spi_transfer t;
-	struct spi_message m;
 	u8 msg[2];
 
-	if (len <= 0)
-		return 0;
-
 	msg[0] = data[0];
 	msg[1] = data[1];
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof t);
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
+	return do_spi_write(control_data, msg, len);
 }
 #else
 #define snd_soc_7_9_spi_write NULL
@@ -184,27 +178,12 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 static int snd_soc_8_8_spi_write(void *control_data, const char *data,
 				 int len)
 {
-	struct spi_device *spi = control_data;
-	struct spi_transfer t;
-	struct spi_message m;
 	u8 msg[2];
 
-	if (len <= 0)
-		return 0;
-
 	msg[0] = data[0];
 	msg[1] = data[1];
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof t);
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
+	return do_spi_write(control_data, msg, len);
 }
 #else
 #define snd_soc_8_8_spi_write NULL
@@ -232,28 +211,13 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 static int snd_soc_8_16_spi_write(void *control_data, const char *data,
 				 int len)
 {
-	struct spi_device *spi = control_data;
-	struct spi_transfer t;
-	struct spi_message m;
 	u8 msg[3];
 
-	if (len <= 0)
-		return 0;
-
 	msg[0] = data[0];
 	msg[1] = data[1];
 	msg[2] = data[2];
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof t);
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
+	return do_spi_write(control_data, msg, len);
 }
 #else
 #define snd_soc_8_16_spi_write NULL
@@ -384,28 +348,13 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 static int snd_soc_16_8_spi_write(void *control_data, const char *data,
 				 int len)
 {
-	struct spi_device *spi = control_data;
-	struct spi_transfer t;
-	struct spi_message m;
 	u8 msg[3];
 
-	if (len <= 0)
-		return 0;
-
 	msg[0] = data[0];
 	msg[1] = data[1];
 	msg[2] = data[2];
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof t);
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
+	return do_spi_write(control_data, msg, len);
 }
 #else
 #define snd_soc_16_8_spi_write NULL
@@ -468,29 +417,14 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 static int snd_soc_16_16_spi_write(void *control_data, const char *data,
 				 int len)
 {
-	struct spi_device *spi = control_data;
-	struct spi_transfer t;
-	struct spi_message m;
 	u8 msg[4];
 
-	if (len <= 0)
-		return 0;
-
 	msg[0] = data[0];
 	msg[1] = data[1];
 	msg[2] = data[2];
 	msg[3] = data[3];
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof t);
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
+	return do_spi_write(control_data, msg, len);
 }
 #else
 #define snd_soc_16_16_spi_write NULL
-- 
1.7.4.1
