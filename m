From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ali5451: fix timeout handling in
	snd_ali_{codecs, timer}_ready()
Date: Sun, 23 Aug 2009 15:27:25 +0200
Message-ID: <200908231527.25987.bzolnier@gmail.com>
References: <200908192209.50994.bzolnier@gmail.com>
	<s5hbpmbvvta.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 29D85243AD
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 15:27:37 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1071998bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2009 06:27:36 -0700 (PDT)
In-Reply-To: <s5hbpmbvvta.wl%tiwai@suse.de>
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

On Thursday 20 August 2009 08:33:21 Takashi Iwai wrote:
> At Wed, 19 Aug 2009 22:09:50 +0200,
> Bartlomiej Zolnierkiewicz wrote:
> > 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ali5451: fix timeout handling in snd_ali_{codecs,timer}_ready()
> > 
> > Modify loops in such way that the register value is checked also after
> > the timeout condition, just in case the heavy interrupt load etc. caused
> > the thread to sleep for the time period exceeding the timeout value.
> > 
> > While at it remove an extra ALI_STIMER read from snd_ali_stimer_ready().
> > 
> > Reported-by: Jack Byer <ojbyer@usa.net>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  sound/pci/ali5451/ali5451.c |   11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > Index: b/sound/pci/ali5451/ali5451.c
> > ===================================================================
> > --- a/sound/pci/ali5451/ali5451.c
> > +++ b/sound/pci/ali5451/ali5451.c
> > @@ -314,8 +314,11 @@ static int snd_ali_codec_ready(struct sn
> >  		res = snd_ali_5451_peek(codec,port);
> >  		if (!(res & 0x8000))
> >  			return 0;
> > +		if (!time_after_eq(end_time, jiffies))
> > +			break;
> >  		schedule_timeout_uninterruptible(1);
> > -	} while (time_after_eq(end_time, jiffies));
> > +	} while (1);
> 
> Using for (;;) is more generic.  I see your patch keeps the changes
> minimal, but I'm afraid that the result, do {} while(1), can be
> misleading.
> 
> Could you replace with for (;;) ?

Sure, though I don't see a much value added from this operation..

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH v2] ali5451: fix timeout handling in snd_ali_{codecs,timer}_ready()

Modify loops in such way that the register value is checked also after
the timeout condition, just in case the heavy interrupt load etc. caused
the thread to sleep for the time period exceeding the timeout value.

While at it remove an extra ALI_STIMER read from snd_ali_stimer_ready().

Reported-by: Jack Byer <ojbyer@usa.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 sound/pci/ali5451/ali5451.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: b/sound/pci/ali5451/ali5451.c
===================================================================
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -310,12 +310,16 @@ static int snd_ali_codec_ready(struct sn
 	unsigned int res;
 	
 	end_time = jiffies + msecs_to_jiffies(250);
-	do {
+
+	for (;;) {
 		res = snd_ali_5451_peek(codec,port);
 		if (!(res & 0x8000))
 			return 0;
+		if (!time_after_eq(end_time, jiffies))
+			break;
 		schedule_timeout_uninterruptible(1);
-	} while (time_after_eq(end_time, jiffies));
+	}
+
 	snd_ali_5451_poke(codec, port, res & ~0x8000);
 	snd_printdd("ali_codec_ready: codec is not ready.\n ");
 	return -EIO;
@@ -327,15 +331,17 @@ static int snd_ali_stimer_ready(struct s
 	unsigned long dwChk1,dwChk2;
 	
 	dwChk1 = snd_ali_5451_peek(codec, ALI_STIMER);
-	dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
-
 	end_time = jiffies + msecs_to_jiffies(250);
-	do {
+
+	for (;;) {
 		dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
 		if (dwChk2 != dwChk1)
 			return 0;
+		if (!time_after_eq(end_time, jiffies))
+			break;
 		schedule_timeout_uninterruptible(1);
-	} while (time_after_eq(end_time, jiffies));
+	}
+
 	snd_printk(KERN_ERR "ali_stimer_read: stimer is not ready.\n");
 	return -EIO;
 }
