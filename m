From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH 4/4] alsa-driver: schedule_timeout() fixes.
Date: Tue, 18 Sep 2007 16:34:46 +0200
Message-ID: <46EFE206.3090900@gmail.com>
References: <46E58D01.9080809@gmail.com>	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>	<46EF18FF.7070906@gmail.com>	<46EF3097.7060300@gmail.com>	<46EF52E4.90401@gmail.com>
	<s5habrkchpa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060907030407070501010102"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl
	[213.51.146.202])
	by alsa0.perex.cz (Postfix) with ESMTP id EB7BC244ED
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 16:35:46 +0200 (CEST)
In-Reply-To: <s5habrkchpa.wl%tiwai@suse.de>
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060907030407070501010102
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/18/2007 01:54 PM, Takashi Iwai wrote:

> The other changes look good to me.  But, honestly, I couldn't follow all
> the pathes you sent in the right order.  So, could you guys make a series
> of patches to be applied to HG tree?  That'll be really helpful for
> review, too.

Two more for alsa-drivers. Just for completeness, but feel free to drop on 
the floor as well. I'm not hugely sure about that "if (!signal_pending)" in 
the msnd_pinnacle one (so just keep it interruptible) and the other two are 
just replacinging HZ calculations.

Speaking about that msnd one -- I believe I've seen that driver sitting in 
isa/ in alsa-drivers ages ago already. Is someone still working on that? 
(no, I don't have the hardware).

Signed-off-by: Rene Herman <rene.herman@gmail.com>

--------------060907030407070501010102
Content-Type: text/plain;
 name="schedule_timeout-alsa_driver.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedule_timeout-alsa_driver.diff"

diff -r 3fefacd5d76c isa/msnd/msnd_pinnacle.c
--- a/isa/msnd/msnd_pinnacle.c	Mon Sep 17 19:04:40 2007 +0200
+++ b/isa/msnd/msnd_pinnacle.c	Tue Sep 18 16:21:50 2007 +0200
@@ -239,10 +239,8 @@ static void dsp_write_flush(void)
 		&dev.writeflush,
 		get_play_delay_jiffies(dev.DAPF.len));*/
 	clear_bit(F_WRITEFLUSH, &dev.flags);
-	if (!signal_pending(current)) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(get_play_delay_jiffies( dev.play_period_bytes));
-	}
+	if (!signal_pending(current)) 
+		schedule_timeout_interruptible(get_play_delay_jiffies(dev.play_period_bytes));
 	clear_bit(F_WRITING, &dev.flags);
 }
 
@@ -691,8 +689,7 @@ static int __init snd_msnd_calibrate_adc
 		       & ~0x0001, dev.SMA + SMA_wCurrHostStatusFlags);
 	if (snd_msnd_send_word(&dev, 0, 0, HDEXAR_CAL_A_TO_D) == 0 &&
 	    snd_msnd_send_dsp_cmd_chk(&dev, HDEX_AUX_REQ) == 0) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ / 3);
+		schedule_timeout_interruptible(msecs_to_jiffiies(333));
 		return 0;
 	}
 	printk(KERN_WARNING LOGNAME ": ADC calibration failed\n");
diff -r 3fefacd5d76c pci/asihpi/hpios_linux_kernel.c
--- a/pci/asihpi/hpios_linux_kernel.c	Mon Sep 17 19:04:40 2007 +0200
+++ b/pci/asihpi/hpios_linux_kernel.c	Tue Sep 18 16:21:50 2007 +0200
@@ -38,8 +38,7 @@ and the task receives a signal.
 and the task receives a signal.
 Setting the state to UNINTERRUPTIBLE stops it from returning early.
 */
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((HZ * dwNumMicroSec + (HZ - 1)) / 1000000);
+		schedule_timeout_uninterruptible(usecs_to_jiffies(dwNumMicroSec));
 	} else if (dwNumMicroSec <= 2000)
 		udelay(dwNumMicroSec);
 	else

--------------060907030407070501010102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060907030407070501010102--
