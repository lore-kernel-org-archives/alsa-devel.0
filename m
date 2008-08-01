From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to override
	register display
Date: Thu, 31 Jul 2008 21:41:48 -0400
Message-ID: <9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C8EF244F3
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 03:41:49 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so542372ywk.2
	for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2008 18:41:48 -0700 (PDT)
In-Reply-To: <1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark, I see this patch is already in your tree. I have rewritten it a
little differently to ensure that too many results can't be returned.
This is in my system and tested. I had a bug too so I know the
limiting it to pagesize code works.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1890d87..b95c0c2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -410,6 +410,7 @@ struct snd_soc_codec {
 	void *control_data; /* codec control (i2c/3wire) data */
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
+	int (*display_register)(struct snd_soc_codec *, char *, unsigned
int, unsigned int);
 	hw_write_t hw_write;
 	hw_read_t hw_read;
 	void *reg_cache;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 83f1190..55f7559 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -961,7 +961,7 @@ static ssize_t codec_reg_show(struct device *dev,
 {
 	struct snd_soc_device *devdata = dev_get_drvdata(dev);
 	struct snd_soc_codec *codec = devdata->codec;
-	int i, step = 1, count = 0;
+	int i, step = 1, count;

 	if (!codec->reg_cache_size)
 		return 0;
@@ -969,11 +969,18 @@ static ssize_t codec_reg_show(struct device *dev,
 	if (codec->reg_cache_step)
 		step = codec->reg_cache_step;

-	count += sprintf(buf, "%s registers\n", codec->name);
-	for (i = 0; i < codec->reg_cache_size; i += step)
-		count += sprintf(buf + count, "%2x: %4x\n", i,
-			codec->read(codec, i));
-
+	count = sprintf(buf, "%s registers\n", codec->name);
+	for (i = 0; i < codec->reg_cache_size; i += step) {
+		if (codec->display_register)
+			count += codec->display_register(codec,
+							 buf + count, PAGE_SIZE - count, i);
+		else {
+			count += snprintf(buf + count, PAGE_SIZE - count, "%2x: ", i);
+			count += snprintf(buf + count, PAGE_SIZE - count, "%4x",
+					 codec->read(codec, i));
+			count += snprintf(buf + count, PAGE_SIZE - count, "\n");
+		}
+	}
 	return count;
 }
 static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);


-- 
Jon Smirl
jonsmirl@gmail.com
