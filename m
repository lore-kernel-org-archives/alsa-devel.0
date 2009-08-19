From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ali5451: fix timeout handling in
	snd_ali_{codecs, timer}_ready()
Date: Wed, 19 Aug 2009 22:09:50 +0200
Message-ID: <200908192209.50994.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id E982A245AB
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 22:11:44 +0200 (CEST)
Received: by fxm3 with SMTP id 3so318665fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2009 13:11:44 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Jack Byer <ojbyer@usa.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ali5451: fix timeout handling in snd_ali_{codecs,timer}_ready()

Modify loops in such way that the register value is checked also after
the timeout condition, just in case the heavy interrupt load etc. caused
the thread to sleep for the time period exceeding the timeout value.

While at it remove an extra ALI_STIMER read from snd_ali_stimer_ready().

Reported-by: Jack Byer <ojbyer@usa.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 sound/pci/ali5451/ali5451.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: b/sound/pci/ali5451/ali5451.c
===================================================================
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -314,8 +314,11 @@ static int snd_ali_codec_ready(struct sn
 		res = snd_ali_5451_peek(codec,port);
 		if (!(res & 0x8000))
 			return 0;
+		if (!time_after_eq(end_time, jiffies))
+			break;
 		schedule_timeout_uninterruptible(1);
-	} while (time_after_eq(end_time, jiffies));
+	} while (1);
+
 	snd_ali_5451_poke(codec, port, res & ~0x8000);
 	snd_printdd("ali_codec_ready: codec is not ready.\n ");
 	return -EIO;
@@ -327,15 +330,17 @@ static int snd_ali_stimer_ready(struct s
 	unsigned long dwChk1,dwChk2;
 	
 	dwChk1 = snd_ali_5451_peek(codec, ALI_STIMER);
-	dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
 
 	end_time = jiffies + msecs_to_jiffies(250);
 	do {
 		dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
 		if (dwChk2 != dwChk1)
 			return 0;
+		if (!time_after_eq(end_time, jiffies))
+			break;
 		schedule_timeout_uninterruptible(1);
-	} while (time_after_eq(end_time, jiffies));
+	} while (1);
+
 	snd_printk(KERN_ERR "ali_stimer_read: stimer is not ready.\n");
 	return -EIO;
 }
