From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Support debugfs entries larger
	than PAGE_SIZE bytes
Date: Wed,  2 Feb 2011 11:29:05 +0000
Message-ID: <1296646145-2356-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3BB37246F8
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 12:29:08 +0100 (CET)
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

For some codecs with large register maps, it was not possible to dump
all registers via the codec_reg file but only up to PAGE_SIZE bytes.
This patch fixes this problem.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |  114 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 77 insertions(+), 37 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 205cbd7..a7710d2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -87,15 +87,55 @@ static int min_bytes_needed(unsigned long val)
 	return c;
 }
 
+/* fill buf which is 'len' bytes with a formatted
+ * string of the form 'reg: value\n' */
+static int format_register_str(struct snd_soc_codec *codec,
+			       unsigned int regidx, char *buf, size_t len)
+{
+	int wordsize = codec->driver->reg_word_size * 2;
+	int regsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
+	int ret;
+	char tmpbuf[len + 1];
+
+	/* since tmpbuf is allocated on the stack, warn the callers if they
+	 * try to abuse this function */
+	WARN_ON(len > 63);
+
+	/* +2 for ': ' and + 1 for '\n' */
+	if (wordsize + regsize + 2 + 1 != len)
+		return -EINVAL;
+
+	/* we don't currently handle failed reads */
+	ret = snd_soc_read(codec , regidx);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to read from %#x\n", regidx);
+		return ret;
+	}
+
+	/* prepare the buffer */
+	snprintf(tmpbuf, len + 1, "%.*x: %.*x\n", wordsize,
+		 regidx, regsize, ret);
+	/* copy it back to the caller without the '\0' */
+	memcpy(buf, tmpbuf, len);
+
+	return 0;
+}
+
 /* codec register dump */
-static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
+static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
+				  size_t count, loff_t pos)
 {
-	int ret, i, step = 1, count = 0;
+	int i, step = 1;
 	int wordsize, regsize;
+	int len;
+	size_t total = 0;
+	loff_t p = 0;
 
 	wordsize = codec->driver->reg_word_size * 2;
 	regsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
 
+	len = wordsize + regsize + 2 + 1;
+
 	if (!codec->driver->reg_cache_size)
 		return 0;
 
@@ -105,51 +145,34 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
 		if (codec->readable_register && !codec->readable_register(codec, i))
 			continue;
-
-		count += sprintf(buf + count, "%.*x: ", regsize, i);
-		if (count >= PAGE_SIZE - 1)
-			break;
-
 		if (codec->driver->display_register) {
 			count += codec->driver->display_register(codec, buf + count,
 							 PAGE_SIZE - count, i);
 		} else {
-			/* If the read fails it's almost certainly due to
-			 * the register being volatile and the device being
-			 * powered off.
-			 */
-			ret = snd_soc_read(codec, i);
-			if (ret >= 0)
-				count += snprintf(buf + count,
-						  PAGE_SIZE - count,
-						  "%.*x", wordsize, ret);
-			else
-				count += snprintf(buf + count,
-						  PAGE_SIZE - count,
-						  "<no data: %d>", ret);
+			/* only support larger than PAGE_SIZE bytes debugfs
+			 * entries for the default case */
+			if (p >= pos) {
+				if (total + len >= count - 1)
+					break;
+				format_register_str(codec, i, buf + total, len);
+				total += len;
+			}
+			p += len;
 		}
-
-		if (count >= PAGE_SIZE - 1)
-			break;
-
-		count += snprintf(buf + count, PAGE_SIZE - count, "\n");
-		if (count >= PAGE_SIZE - 1)
-			break;
 	}
 
-	/* Truncate count; min() would cause a warning */
-	if (count >= PAGE_SIZE)
-		count = PAGE_SIZE - 1;
+	total = min(total, count - 1);
 
-	return count;
+	return total;
 }
+
 static ssize_t codec_reg_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(dev, struct snd_soc_pcm_runtime, dev);
 
-	return soc_codec_reg_show(rtd->codec, buf);
+	return soc_codec_reg_show(rtd->codec, buf, PAGE_SIZE, 0);
 }
 
 static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
@@ -188,16 +211,33 @@ static int codec_reg_open_file(struct inode *inode, struct file *file)
 }
 
 static ssize_t codec_reg_read_file(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+				   size_t count, loff_t *ppos)
 {
 	ssize_t ret;
 	struct snd_soc_codec *codec = file->private_data;
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char *buf;
+
+	if (*ppos < 0 || !count)
+		return -EINVAL;
+
+	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	ret = soc_codec_reg_show(codec, buf);
-	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+
+	ret = soc_codec_reg_show(codec, buf, count, *ppos);
+	if (ret >= 0) {
+		if (!access_ok(VERIFY_WRITE, user_buf, ret)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (copy_to_user(user_buf, buf, ret)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		*ppos += ret;
+	}
+
+out:
 	kfree(buf);
 	return ret;
 }
-- 
1.7.3.5
