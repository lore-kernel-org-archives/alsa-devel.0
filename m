From: Matthias Koenig <mkoenig@suse.de>
Subject: Re: [PATCH] alsa-driver: portman2x4 code cleanup
Date: Thu, 25 Jan 2007 10:56:41 +0100
Message-ID: <n7xirevsa3q.fsf@sor.suse.de>
References: <n7xr6tksauu.fsf@sor.suse.de> <s5hzm88bbqt.wl%tiwai@suse.de>
	<87ejpkjjm5.fsf@zebra.localdomain> <s5hhcugb41m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 36B92321
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 10:57:50 +0100 (MET)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id DF7AF12228
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 10:57:49 +0100 (CET)
In-Reply-To: <s5hhcugb41m.wl%tiwai@suse.de> (Takashi Iwai's message of "Wed,
	24 Jan 2007 20:47:17 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

Takashi Iwai <tiwai@suse.de> writes:
>> > Also, added cpu_relax() in busy loops, and fixed unneeded
>> > initialization of variables.
>> 
>> Ok, thanks
>> 
>> > The code is now committed to ALSA HG tree.  Please give it a try.
>> 
>> Ah, I just tested and found that the rawmidi open/close callbacks
>> have to be defined and cannot be NULL. So the driver as it is
>> will oops if device will be opened.
>> Fixed this, now tested with amidi input/output on all ports works
>> fine. Patch is below.
>
> Thanks, applied now.
>
>> > BTW, if the driver works for you, we can move this to alsa-kernel tree
>> > so that it's merged to the upstream kernel...
>> 
>> Great, yes I think it can then be moved to alsa-kernel tree.
>
> OK, I'll work on this tomorrow.

Ok, I still found another minor issue. Probably we do not need 
irqsave/irqrestore for the spinlock calls in the interrupt handler.

Matthias

Signed-off-by: Matthias Koenig <mkoenig@suse.de>
=====================================================================
Summary: portman2x4 - do not use irqsave/irqrestore in IRQ handler

Replace spin_lock_irqsave/spin_unlock_irqrestore with
spin_lock/spin_unlock in IRQ handler.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=portman2x4-irq.patch

diff -r e2ef37984418 drivers/portman2x4-kernel.c
--- a/drivers/portman2x4-kernel.c	Wed Jan 24 20:46:25 2007 +0100
+++ b/drivers/portman2x4-kernel.c	Thu Jan 25 10:44:44 2007 +0100
@@ -617,11 +617,10 @@ static void snd_portman_interrupt(int ir
 static void snd_portman_interrupt(int irq, void *userdata, struct pt_regs *regs)
 #endif
 {
-	unsigned long flags;
 	unsigned char midivalue = 0;
 	struct portman *pm = ((struct snd_card*)userdata)->private_data;
 
-	spin_lock_irqsave(&pm->reg_lock, flags);
+	spin_lock(&pm->reg_lock);
 
 	/* While any input data is waiting */
 	while ((portman_read_status(pm) & INT_REQ) == INT_REQ) {
@@ -649,7 +648,7 @@ static void snd_portman_interrupt(int ir
 
 	}
 
-	spin_unlock_irqrestore(&pm->reg_lock, flags);
+	spin_unlock(&pm->reg_lock);
 }
 
 static int __devinit snd_portman_probe_port(struct parport *p)

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-=-=--
