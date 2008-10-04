From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] [ALSA] Allow setting codec register with sys
	filesystem
Date: Sat,  4 Oct 2008 16:54:09 -0700
Message-ID: <1223164449-4133-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

i.e. echo 6 59 >/sys/devices/platform/soc-audio.0/codec_reg
will set register 0x06 to a value of 0x59

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad38113..df23b23 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1002,7 +1002,33 @@ static ssize_t codec_reg_show(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
+
+static ssize_t codec_reg_write(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	char *start = (char *)buf;
+	unsigned long reg, value;
+	int step = 1;
+	struct snd_soc_device *devdata = dev_get_drvdata(dev);
+	struct snd_soc_codec *codec = devdata->codec;
+
+	if (codec->reg_cache_step)
+		step = codec->reg_cache_step;
+
+	while (*start == ' ')
+		start++;
+	reg = simple_strtoul(start, &start, 16);
+	if ((reg >= codec->reg_cache_size) || (reg % step))
+		return -EINVAL;
+	while (*start == ' ')
+		start++;
+	if (strict_strtoul(start, 16, &value))
+		return -EINVAL;
+	codec->write(codec, reg, value);
+	return start - buf;
+}
+
+static DEVICE_ATTR(codec_reg, 0644, codec_reg_show, codec_reg_write);
 
 /**
  * snd_soc_new_ac97_codec - initailise AC97 device
-- 
1.5.4.3
