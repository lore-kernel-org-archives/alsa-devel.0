From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ALSA: usb-audio: Return meaningful error
	codes instead of -1 in format.c
Date: Wed, 21 Nov 2012 15:25:56 +0530
Message-ID: <1353491756-27558-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A207A265CCC
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 11:02:09 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so2433155pad.38
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 02:02:08 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Also, silences the following smatch warning:
sound/usb/format.c:170 parse_audio_format_rates_v1() warn:
returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Build tested and based on linux-next 20121115.
---
 sound/usb/format.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index ddfef57..e831ee4 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -155,7 +155,7 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 	if (fmt[0] < offset + 1 + 3 * (nr_rates ? nr_rates : 2)) {
 		snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_FORMAT_TYPE desc\n",
 				   chip->dev->devnum, fp->iface, fp->altsetting);
-		return -1;
+		return -EINVAL;
 	}
 
 	if (nr_rates) {
@@ -167,7 +167,7 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 		fp->rate_table = kmalloc(sizeof(int) * nr_rates, GFP_KERNEL);
 		if (fp->rate_table == NULL) {
 			snd_printk(KERN_ERR "cannot malloc\n");
-			return -1;
+			return -ENOMEM;
 		}
 
 		fp->nr_rates = 0;
@@ -198,7 +198,7 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 		}
 		if (!fp->nr_rates) {
 			hwc_debug("All rates were zero. Skipping format!\n");
-			return -1;
+			return -EINVAL;
 		}
 	} else {
 		/* continuous rates */
@@ -383,7 +383,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 		fp->formats = parse_audio_format_i_type(chip, fp, format,
 							fmt, protocol);
 		if (!fp->formats)
-			return -1;
+			return -EINVAL;
 	}
 
 	/* gather possible sample rates */
@@ -409,7 +409,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 	if (fp->channels < 1) {
 		snd_printk(KERN_ERR "%d:%u:%d : invalid channels %d\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting, fp->channels);
-		return -1;
+		return -EINVAL;
 	}
 
 	return ret;
-- 
1.7.4.1
