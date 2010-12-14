From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: A few minor stylistic changes
Date: Tue, 14 Dec 2010 15:15:36 +0000
Message-ID: <1292339736-8567-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03D6C2460A
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 16:15:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Remove redundant parentheses/spaces in the use of the sizeof
operator.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 678fd75..0e17b40 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -85,7 +85,7 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
 	msg[1] = data[0];
 
 	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
+	memset(&t, 0, sizeof t);
 
 	t.tx_buf = &msg[0];
 	t.len = len;
@@ -166,7 +166,7 @@ static int snd_soc_7_9_spi_write(void *control_data, const char *data,
 	msg[1] = data[1];
 
 	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
+	memset(&t, 0, sizeof t);
 
 	t.tx_buf = &msg[0];
 	t.len = len;
@@ -246,7 +246,7 @@ static int snd_soc_8_8_spi_write(void *control_data, const char *data,
 	msg[1] = data[1];
 
 	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
+	memset(&t, 0, sizeof t);
 
 	t.tx_buf = &msg[0];
 	t.len = len;
@@ -326,7 +326,7 @@ static int snd_soc_8_16_spi_write(void *control_data, const char *data,
 	msg[2] = data[2];
 
 	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
+	memset(&t, 0, sizeof t);
 
 	t.tx_buf = &msg[0];
 	t.len = len;
@@ -513,7 +513,7 @@ static int snd_soc_16_8_spi_write(void *control_data, const char *data,
 	msg[2] = data[2];
 
 	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
+	memset(&t, 0, sizeof t);
 
 	t.tx_buf = &msg[0];
 	t.len = len;
@@ -633,7 +633,7 @@ static int snd_soc_16_16_spi_write(void *control_data, const char *data,
 	msg[3] = data[3];
 
 	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
+	memset(&t, 0, sizeof t);
 
 	t.tx_buf = &msg[0];
 	t.len = len;
@@ -1342,7 +1342,7 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 	 * that register.
 	 */
 	bmp_size = codec_drv->reg_cache_size;
-	sync_bmp = kmalloc(BITS_TO_LONGS(bmp_size) * sizeof (long),
+	sync_bmp = kmalloc(BITS_TO_LONGS(bmp_size) * sizeof(long),
 			   GFP_KERNEL);
 	if (!sync_bmp) {
 		ret = -ENOMEM;
-- 
1.7.3.3
