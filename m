From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] sound/cs4231: replace schedule_timeout() with msleep_interruptible()
Date: Wed, 3 Nov 2004 10:03:15 -0800
Message-ID: <20041103180315.GE2163__29188.8035637841$1099507449$gmane$org@us.ibm.com>
References: <20041102194019.GA2163@us.ibm.com> <Pine.HPX.4.33n.0411031024450.25361-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.106])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EFB0A248
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2004 19:03:48 +0100 (MET)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.12.10/8.12.9) with ESMTP id iA3I3dsZ284084
	for <alsa-devel@alsa-project.org>; Wed, 3 Nov 2004 13:03:41 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iA3I3cfa269670
	for <alsa-devel@alsa-project.org>; Wed, 3 Nov 2004 13:03:39 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id iA3I3c71030286
	for <alsa-devel@alsa-project.org>; Wed, 3 Nov 2004 13:03:38 -0500
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0411031024450.25361-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: perex@suse.cz, kernel-janitors@lists.osdl.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 03, 2004 at 10:31:42AM +0100, Clemens Ladisch wrote:
> Nishanth Aravamudan wrote:
> > +	time = 250;
> >  	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
> >  		spin_unlock_irqrestore(&chip->lock, flags);
> >  		if (time <= 0) {
> >  			snd_printk("mce_down - auto calibration time out (2)\n");
> >  			return;
> >  		}
> > -		set_current_state(TASK_INTERRUPTIBLE);
> > -		time = schedule_timeout(time);
> > +		time = msleep_interruptible(time);
> >  		spin_lock_irqsave(&chip->lock, flags);
> >  	}
> >
> > Description: Uses msleep_interruptible() instead of schedule_timeout()
> > to guarantee the task delays as expected.
> 
> The SPARC driver originated as a copy of the ISA driver and still has
> the problem that was fixed there, i.e., it uses a single 250 ms wait
> (which results in a delay of several seconds if OSS programs try to
> enumerate sample rates).
> 
> Like the ISA driver, this driver should check the hardware status more
> often so that the wait can be aborted as soon as the calibration has
> finished.
> 
> And this driver doesn't expect do receive signals; using msleep()
> would be just fine.

These changes have been made in the following patch. Does it look better
now?

-Nish

Description: Uses msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected. Changes the type of time to
match the return value of msleep_interruptible().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-rc1-vanilla/sound/sparc/cs4231.c	2004-10-30 15:34:20.000000000 -0700
+++ 2.6.10-rc1/sound/sparc/cs4231.c	2004-11-03 10:01:47.000000000 -0800
@@ -560,7 +560,6 @@ static void snd_cs4231_mce_down(cs4231_t
 {
 	unsigned long flags;
 	int timeout;
-	signed long time;
 
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_busy_wait(chip);
@@ -594,29 +593,29 @@ static void snd_cs4231_mce_down(cs4231_t
 #if 0
 	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
 #endif
-	time = HZ / 4;
+	/* in 10ms increments, check condition, up to 250ms */
+	timeout = 25;
 	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
 		spin_unlock_irqrestore(&chip->lock, flags);
-		if (time <= 0) {
+		if (--timeout < 0) {
 			snd_printk("mce_down - auto calibration time out (2)\n");
 			return;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		time = schedule_timeout(time);
+		msleep(10);
 		spin_lock_irqsave(&chip->lock, flags);
 	}
 #if 0
 	printk("(3) jiffies = %li\n", jiffies);
 #endif
-	time = HZ / 10;
+	/* in 10ms increments, check condition, up to 100ms */
+	timeout = 10;
 	while (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT) {
 		spin_unlock_irqrestore(&chip->lock, flags);
-		if (time <= 0) {
+		if (--timeout < 0) {
 			snd_printk("mce_down - auto calibration time out (3)\n");
 			return;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);		
-		time = schedule_timeout(time);
+		msleep(10);
 		spin_lock_irqsave(&chip->lock, flags);
 	}
 	spin_unlock_irqrestore(&chip->lock, flags);


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
