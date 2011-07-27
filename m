From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 1/1] oss: rename local change_bits to avoid powerpc bitsops.h definition
Date: Wed, 27 Jul 2011 17:48:41 +0100
Message-ID: <1311785321-23431-1-git-send-email-apw@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This collides with powerpc exported functions from bitops.h.  Rename the
local copy in the oss soundblaster mixer and ad1848 driver.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 sound/oss/ad1848.c   |    6 +++---
 sound/oss/sb_mixer.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 4d2a6ae..8415158 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -458,7 +458,7 @@ static int ad1848_set_recmask(ad1848_info * devc, int mask)
 	return mask;
 }
 
-static void change_bits(ad1848_info * devc, unsigned char *regval,
+static void oss_change_bits(ad1848_info * devc, unsigned char *regval,
 			unsigned char *muteval, int dev, int chn, int newval)
 {
 	unsigned char mask;
@@ -516,10 +516,10 @@ static void ad1848_mixer_set_channel(ad1848_info *devc, int dev, int value, int
 
 	if (muteregoffs != regoffs) {
 		muteval = ad_read(devc, muteregoffs);
-		change_bits(devc, &val, &muteval, dev, channel, value);
+		oss_change_bits(devc, &val, &muteval, dev, channel, value);
 	}
 	else
-		change_bits(devc, &val, &val, dev, channel, value);
+		oss_change_bits(devc, &val, &val, dev, channel, value);
 
 	spin_lock_irqsave(&devc->lock,flags);
 	ad_write(devc, regoffs, val);
diff --git a/sound/oss/sb_mixer.c b/sound/oss/sb_mixer.c
index 2039d31..0266088 100644
--- a/sound/oss/sb_mixer.c
+++ b/sound/oss/sb_mixer.c
@@ -232,7 +232,7 @@ static int detect_mixer(sb_devc * devc)
 	return 1;
 }
 
-static void change_bits(sb_devc * devc, unsigned char *regval, int dev, int chn, int newval)
+static void oss_change_bits(sb_devc * devc, unsigned char *regval, int dev, int chn, int newval)
 {
 	unsigned char mask;
 	int shift;
@@ -284,7 +284,7 @@ int sb_common_mixer_set(sb_devc * devc, int dev, int left, int right)
 		return -EINVAL;
 
 	val = sb_getmixer(devc, regoffs);
-	change_bits(devc, &val, dev, LEFT_CHN, left);
+	oss_change_bits(devc, &val, dev, LEFT_CHN, left);
 
 	if ((*devc->iomap)[dev][RIGHT_CHN].regno != regoffs)	/*
 								 * Change register
@@ -304,7 +304,7 @@ int sb_common_mixer_set(sb_devc * devc, int dev, int left, int right)
 							 * Read the new one
 							 */
 	}
-	change_bits(devc, &val, dev, RIGHT_CHN, right);
+	oss_change_bits(devc, &val, dev, RIGHT_CHN, right);
 
 	sb_setmixer(devc, regoffs, val);
 
-- 
1.7.4.1
