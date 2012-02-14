From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] ALSA: usb-audio: avoid integer overflow in
	create_fixed_stream_quirk()
Date: Tue, 14 Feb 2012 05:18:48 -0500
Message-ID: <1329214728-14355-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f44.google.com (mail-qw0-f44.google.com
	[209.85.216.44]) by alsa0.perex.cz (Postfix) with ESMTP id 07C7124340
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 11:21:26 +0100 (CET)
Received: by qafi29 with SMTP id i29so2337815qaf.17
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 02:21:26 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>
List-Id: alsa-devel@alsa-project.org

A malicious USB device could feed in a large nr_rates value.  This would
cause the subsequent call to kmemdup() to allocate a smaller buffer than
expected, leading to out-of-bounds access.

This patch validates the nr_rates value and reuses the limit introduced
in commit 4fa0e81b ("ALSA: usb-audio: fix possible hang and overflow
in parse_uac2_sample_rate_range()").

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 sound/usb/card.h   |    1 +
 sound/usb/format.c |    4 +---
 sound/usb/quirks.c |    6 +++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index a39edcc..da5fa1a 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -1,6 +1,7 @@
 #ifndef __USBAUDIO_CARD_H
 #define __USBAUDIO_CARD_H
 
+#define MAX_NR_RATES	1024
 #define MAX_PACKS	20
 #define MAX_PACKS_HS	(MAX_PACKS * 8)	/* in high speed mode */
 #define MAX_URBS	8
diff --git a/sound/usb/format.c b/sound/usb/format.c
index e09aba1..ddfef57 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -209,8 +209,6 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 	return 0;
 }
 
-#define MAX_UAC2_NR_RATES 1024
-
 /*
  * Helper function to walk the array of sample rate triplets reported by
  * the device. The problem is that we need to parse whole array first to
@@ -255,7 +253,7 @@ static int parse_uac2_sample_rate_range(struct audioformat *fp, int nr_triplets,
 			fp->rates |= snd_pcm_rate_to_rate_bit(rate);
 
 			nr_rates++;
-			if (nr_rates >= MAX_UAC2_NR_RATES) {
+			if (nr_rates >= MAX_NR_RATES) {
 				snd_printk(KERN_ERR "invalid uac2 rates\n");
 				break;
 			}
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a3ddac0..2781726 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -132,10 +132,14 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	unsigned *rate_table = NULL;
 
 	fp = kmemdup(quirk->data, sizeof(*fp), GFP_KERNEL);
-	if (! fp) {
+	if (!fp) {
 		snd_printk(KERN_ERR "cannot memdup\n");
 		return -ENOMEM;
 	}
+	if (fp->nr_rates > MAX_NR_RATES) {
+		kfree(fp);
+		return -EINVAL;
+	}
 	if (fp->nr_rates > 0) {
 		rate_table = kmemdup(fp->rate_table,
 				     sizeof(int) * fp->nr_rates, GFP_KERNEL);
-- 
1.7.5.4
