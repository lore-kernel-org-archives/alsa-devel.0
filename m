From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Allow codecs to override register display
Date: Fri, 18 Jul 2008 11:57:22 +0100
Message-ID: <1216378642-14987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C40401037F2
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 12:57:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some codecs have unusual features in their register maps such as very
large registers representing arrays of coefficients. Support these
codecs in the register cache sysfs file by allowing them to provide a
function register_display() overriding the default output for register
contents.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1890d87..8b1a3e7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -410,6 +410,7 @@ struct snd_soc_codec {
 	void *control_data; /* codec control (i2c/3wire) data */
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
+	int (*display_register)(struct snd_soc_codec *, char *, unsigned int);
 	hw_write_t hw_write;
 	hw_read_t hw_read;
 	void *reg_cache;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 83f1190..49532d9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -970,10 +970,16 @@ static ssize_t codec_reg_show(struct device *dev,
 		step = codec->reg_cache_step;
 
 	count += sprintf(buf, "%s registers\n", codec->name);
-	for (i = 0; i < codec->reg_cache_size; i += step)
-		count += sprintf(buf + count, "%2x: %4x\n", i,
-			codec->read(codec, i));
-
+	for (i = 0; i < codec->reg_cache_size; i += step) {
+		count += sprintf(buf + count, "%2x: ", i);
+		if (codec->display_register)
+			count += codec->display_register(codec,
+							 buf + count, i);
+		else
+			count += sprintf(buf + count, "%4x",
+					 codec->read(codec, i));
+		count += sprintf(buf + count, "\n");
+	}
 	return count;
 }
 static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
-- 
1.5.6.3
