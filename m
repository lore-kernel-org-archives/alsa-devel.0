From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Ensure codec_reg has fixed
	length fields
Date: Tue,  1 Feb 2011 12:24:08 +0000
Message-ID: <1296563048-8137-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9DB0244B1
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 13:24:15 +0100 (CET)
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

Make the format of the codec_reg file more easily parsable.  Remove
the header field which gives the codec name.  These changes are important
when it comes to extend the debugfs codec_reg file to dump more than
PAGE_SIZE bytes to make it easier to calculate offsets within the
file.

We still need to handle the case when the snd_soc_read() call fails
and <no data: %d> is outputted.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3feddd9..205cbd7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -69,10 +69,32 @@ static int pmdown_time = 5000;
 module_param(pmdown_time, int, 0);
 MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
 
+/* returns the minimum number of bytes needed to represent
+ * a particular given value */
+static int min_bytes_needed(unsigned long val)
+{
+	int c = 0;
+	int i;
+
+	for (i = (sizeof val * 8) - 1; i >= 0; --i, ++c)
+		if (val & (1UL << i))
+			break;
+	c = (sizeof val * 8) - c;
+	if (!c || (c % 8))
+		c = (c + 8) / 8;
+	else
+		c /= 8;
+	return c;
+}
+
 /* codec register dump */
 static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 {
 	int ret, i, step = 1, count = 0;
+	int wordsize, regsize;
+
+	wordsize = codec->driver->reg_word_size * 2;
+	regsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
 
 	if (!codec->driver->reg_cache_size)
 		return 0;
@@ -80,12 +102,11 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 	if (codec->driver->reg_cache_step)
 		step = codec->driver->reg_cache_step;
 
-	count += sprintf(buf, "%s registers\n", codec->name);
 	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
 		if (codec->readable_register && !codec->readable_register(codec, i))
 			continue;
 
-		count += sprintf(buf + count, "%2x: ", i);
+		count += sprintf(buf + count, "%.*x: ", regsize, i);
 		if (count >= PAGE_SIZE - 1)
 			break;
 
@@ -101,7 +122,7 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 			if (ret >= 0)
 				count += snprintf(buf + count,
 						  PAGE_SIZE - count,
-						  "%4x", ret);
+						  "%.*x", wordsize, ret);
 			else
 				count += snprintf(buf + count,
 						  PAGE_SIZE - count,
-- 
1.7.3.5
