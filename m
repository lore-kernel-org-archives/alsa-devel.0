From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH] sound/cs4231: replace schedule_timeout() with msleep_interruptible()
Date: Tue, 2 Nov 2004 11:40:19 -0800
Message-ID: <20041102194019.GA2163__32965.0377891541$1099426844$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.130])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 36251216
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2004 20:40:58 +0100 (MET)
Received: from westrelay04.boulder.ibm.com (westrelay04.boulder.ibm.com [9.17.193.32])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id iA2JebAd280622
	for <alsa-devel@alsa-project.org>; Tue, 2 Nov 2004 14:40:47 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iA2JeRF9110816
	for <alsa-devel@alsa-project.org>; Tue, 2 Nov 2004 12:40:27 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id iA2JeQDT018019
	for <alsa-devel@alsa-project.org>; Tue, 2 Nov 2004 12:40:26 -0700
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: kernel-janitors@lists.osdl.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Description: Uses msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected. Changes the type of time to
match the return value of msleep_interruptible().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-rc1-vanilla/sound/sparc/cs4231.c	2004-10-30 15:34:20.000000000 -0700
+++ 2.6.10-rc1/sound/sparc/cs4231.c	2004-11-02 11:35:00.000000000 -0800
@@ -560,7 +560,7 @@ static void snd_cs4231_mce_down(cs4231_t
 {
 	unsigned long flags;
 	int timeout;
-	signed long time;
+	unsigned long time;
 
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_busy_wait(chip);
@@ -594,29 +594,27 @@ static void snd_cs4231_mce_down(cs4231_t
 #if 0
 	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
 #endif
-	time = HZ / 4;
+	time = 250;
 	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		if (time <= 0) {
 			snd_printk("mce_down - auto calibration time out (2)\n");
 			return;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		time = schedule_timeout(time);
+		time = msleep_interruptible(time);
 		spin_lock_irqsave(&chip->lock, flags);
 	}
 #if 0
 	printk("(3) jiffies = %li\n", jiffies);
 #endif
-	time = HZ / 10;
+	time = 100;
 	while (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		if (time <= 0) {
 			snd_printk("mce_down - auto calibration time out (3)\n");
 			return;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);		
-		time = schedule_timeout(time);
+		time = msleep_interruptible(time);
 		spin_lock_irqsave(&chip->lock, flags);
 	}
 	spin_unlock_irqrestore(&chip->lock, flags);


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
