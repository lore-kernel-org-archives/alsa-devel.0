From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to override
	register display
Date: Fri, 1 Aug 2008 12:13:52 -0400
Message-ID: <9e4733910808010913x46a4f57fm316b013984ac6b1c@mail.gmail.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
	<s5hk5f1jcl7.wl%tiwai@suse.de>
	<20080801100003.GA16420@rakim.wolfsonmicro.main>
	<9e4733910808010750x69e71cd2i21eb0b448e11544a@mail.gmail.com>
	<s5hiquk4v4g.wl%tiwai@suse.de> <20080801153538.GA11735@sirena.org.uk>
	<s5hfxpo4twd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id ADAD6244A8
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 18:13:55 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so691482ywk.2
	for <alsa-devel@alsa-project.org>; Fri, 01 Aug 2008 09:13:52 -0700 (PDT)
In-Reply-To: <s5hfxpo4twd.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow external register display to suppress sparse registers

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>


---

 sound/soc/soc-core.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1563cee..74e626f 100644
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
@@ -969,23 +969,23 @@ static ssize_t codec_reg_show(struct device *dev,
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
 			count += codec->display_register(codec, buf + count,
 							 PAGE_SIZE - count, i);
-		else
+		else {
+			count += sprintf(buf + count, "%2x: ", i);
+			if (count >= PAGE_SIZE - 1)
+				break;
+
 			count += snprintf(buf + count, PAGE_SIZE - count,
 					  "%4x", codec->read(codec, i));
+			if (count >= PAGE_SIZE - 1)
+				break;

-		if (count >= PAGE_SIZE - 1)
-			break;
-
-		count += snprintf(buf + count, PAGE_SIZE - count, "\n");
+			count += snprintf(buf + count, PAGE_SIZE - count, "\n");
+		}
 		if (count >= PAGE_SIZE - 1)
 			break;
 	}



-- 
Jon Smirl
jonsmirl@gmail.com
