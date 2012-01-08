From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH v2] ALSA: usb-audio: fix possible hang and
	overflow in parse_uac2_sample_rate_range()
Date: Sun, 08 Jan 2012 09:02:52 -0500
Message-ID: <4F09A20C.7090705@gmail.com>
References: <1325698749-5353-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FCFB1038FA
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2012 15:02:58 +0100 (CET)
Received: by iaae16 with SMTP id e16so5329687iaa.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2012 06:02:57 -0800 (PST)
In-Reply-To: <1325698749-5353-1-git-send-email-xi.wang@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Wolfgang Breyha <wbreyha@gmx.net>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>
List-Id: alsa-devel@alsa-project.org

A malicious USB device may feed in carefully crafted min/max/res values,
so that the inner loop in parse_uac2_sample_rate_range() could run for
a long time or even never terminate, e.g., given max = INT_MAX.

Also nr_rates could be a large integer, which causes an integer overflow
in the subsequent call to kmalloc() in parse_audio_format_rates_v2().
Thus, kmalloc() would allocate a smaller buffer than expected, leading
to a memory corruption.

To exploit the two vulnerabilities, an attacker needs physical access
to the machine to plug in a malicious USB device.

This patch makes two changes.

1) The type of "rate" is changed to unsigned int, so that the loop could
   stop once "rate" is larger than INT_MAX.

2) Limit nr_rates to 1024.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 sound/usb/format.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 89421d1..e09aba1 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -209,6 +209,8 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 	return 0;
 }
 
+#define MAX_UAC2_NR_RATES 1024
+
 /*
  * Helper function to walk the array of sample rate triplets reported by
  * the device. The problem is that we need to parse whole array first to
@@ -226,7 +228,7 @@ static int parse_uac2_sample_rate_range(struct audioformat *fp, int nr_triplets,
 		int min = combine_quad(&data[2 + 12 * i]);
 		int max = combine_quad(&data[6 + 12 * i]);
 		int res = combine_quad(&data[10 + 12 * i]);
-		int rate;
+		unsigned int rate;
 
 		if ((max < 0) || (min < 0) || (res < 0) || (max < min))
 			continue;
@@ -253,6 +255,10 @@ static int parse_uac2_sample_rate_range(struct audioformat *fp, int nr_triplets,
 			fp->rates |= snd_pcm_rate_to_rate_bit(rate);
 
 			nr_rates++;
+			if (nr_rates >= MAX_UAC2_NR_RATES) {
+				snd_printk(KERN_ERR "invalid uac2 rates\n");
+				break;
+			}
 
 			/* avoid endless loop */
 			if (res == 0)
-- 
1.7.5.4
