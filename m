From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to override
	register display
Date: Fri, 1 Aug 2008 10:50:37 -0400
Message-ID: <9e4733910808010750x69e71cd2i21eb0b448e11544a@mail.gmail.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
	<s5hk5f1jcl7.wl%tiwai@suse.de>
	<20080801100003.GA16420@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B45B2443C
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 16:50:39 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so866152rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 01 Aug 2008 07:50:37 -0700 (PDT)
In-Reply-To: <20080801100003.GA16420@rakim.wolfsonmicro.main>
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
To: Takashi Iwai <tiwai@suse.de>, Jon Smirl <jonsmirl@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/1/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 01, 2008 at 11:42:28AM +0200, Takashi Iwai wrote:
>  > Jon Smirl wrote:
>
>  > > Mark, I see this patch is already in your tree. I have rewritten it a
>  > > little differently to ensure that too many results can't be returned.
>  > > This is in my system and tested. I had a bug too so I know the
>  > > limiting it to pagesize code works.
>
>  > Mark's patch was already applied.  Could you re-generated your change
>  > based on that?
>
>
> In general it's easiest if ASoC patches are generated against Takashi's
>  master branch - that's where ASoC gets merged and usually the diff
>  between the two trees is very small.
>

This is against Takashi's tree. I handled PAGE_LIMIT differently,
instead of breaking from the loop I just let the loop finished and
told snprintf it had zero bytes.

Allow external display_register()'s to skip sparse registers.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

---

 include/sound/soc.h  |    3 +--
 sound/soc/soc-core.c |   33 ++++++++++-----------------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a1e0357..1f4a9a2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -416,8 +416,7 @@ struct snd_soc_codec {
 	void *control_data; /* codec control (i2c/3wire) data */
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
-	int (*display_register)(struct snd_soc_codec *, char *,
-				size_t, unsigned int);
+	int (*display_register)(struct snd_soc_codec *, char *, unsigned
int, unsigned int);
 	hw_write_t hw_write;
 	hw_read_t hw_read;
 	void *reg_cache;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1563cee..fcc613c 100644
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
@@ -969,31 +969,18 @@ static ssize_t codec_reg_show(struct device *dev,
 	if (codec->reg_cache_step)
 		step = codec->reg_cache_step;

-	count += sprintf(buf, "%s registers\n", codec->name);
+	count = sprintf(buf, "%s registers\n", codec->name);
 	for (i = 0; i < codec->reg_cache_size; i += step) {
-		count += sprintf(buf + count, "%2x: ", i);
-		if (count >= PAGE_SIZE - 1)
-			break;
-
 		if (codec->display_register)
-			count += codec->display_register(codec, buf + count,
-							 PAGE_SIZE - count, i);
-		else
-			count += snprintf(buf + count, PAGE_SIZE - count,
-					  "%4x", codec->read(codec, i));
-
-		if (count >= PAGE_SIZE - 1)
-			break;
-
-		count += snprintf(buf + count, PAGE_SIZE - count, "\n");
-		if (count >= PAGE_SIZE - 1)
-			break;
+			count += codec->display_register(codec,
+							 buf + count, PAGE_SIZE - count, i);
+		else {
+			count += snprintf(buf + count, PAGE_SIZE - count, "%2x: ", i);
+			count += snprintf(buf + count, PAGE_SIZE - count, "%4x",
+					 codec->read(codec, i));
+			count += snprintf(buf + count, PAGE_SIZE - count, "\n");
+		}
 	}
-
-	/* Truncate count; min() would cause a warning */
-	if (count >= PAGE_SIZE)
-		count = PAGE_SIZE - 1;
-
 	return count;
 }
 static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);



-- 
Jon Smirl
jonsmirl@gmail.com
