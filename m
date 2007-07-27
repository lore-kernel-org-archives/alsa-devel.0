From: Paul Vojta <vojta@Math.Berkeley.EDU>
Subject: Re: another device for opl3sa2
Date: Fri, 27 Jul 2007 00:55:14 -0700
Message-ID: <20070727075514.GA2368@math.berkeley.edu>
References: <20070703002739.GA27389@math.berkeley.edu>
	<s5hfy45ajk1.wl%tiwai@suse.de>
	<20070704022423.GA2012@math.berkeley.edu>
	<s5h4pkka6tq.wl%tiwai@suse.de>
	<20070705080302.GA6818@math.berkeley.edu>
	<s5hk5te6hku.wl%tiwai@suse.de>
	<20070706074136.GA4460@math.berkeley.edu>
	<s5hy7ht50ir.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.math.berkeley.edu (mail.math.Berkeley.EDU [169.229.58.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C19824495
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 09:55:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy7ht50ir.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 06, 2007 at 11:45:00AM +0200, Takashi Iwai wrote:
>
> 0x0b = CS4231_TEST_INIT, and 0x20 = CS4231_CALIB_IN_PROGRESS.
> At least, mce_down() should show messages if the calibration gets
> timeout.  Did you see any related messages?  Or didn't you build with
> --with-debug=full?

I have now recompiled the alsa drivers from alsa-driver-hg20070718
and with --debug=full.

I found that the bug would also occur the first time playing a .wav file
after "aplay -t au file.au".

The difference between opl3sa2 and 4232 occurred because of the lines

	if ((timeout & CS4231_MCE) == 0 ||
	    !(chip->hardware & (CS4231_HW_CS4231_MASK | CS4231_HW_CS4232_MASK))) {
		return;
	}

in mce_down() in cs4231_lib.c.  With opl3sa2 it was always returning at this
step, hence it didn't finish recalibrating before trying to play the sound.

If I changed it so that the second test is always false for opl3sa2, then
sound would mostly work, but intermittently I would get messages about
"auto calibration time out" or "serious init problem - codec still busy".
If I put a printk() statement in the beginning of mce_down to help debug
this, then the problem would go away, so I put in udelay(100) and that
also made the problems go away.

Therefore, I submit the following patch.

Synopsis:  Fix bugs in mode change/recalibration for opl3sa2 driver.

Signed-off by:  Paul Vojta <vojta@math.berkeley.edu>


diff -ur /tmp/alsa-driver-hg20070718/alsa-kernel/include/cs4231.h alsa-driver-hg20070718/alsa-kernel/include/cs4231.h
--- /tmp/alsa-driver-hg20070718/alsa-kernel/include/cs4231.h	2006-10-10 17:00:21.000000000 -0700
+++ alsa-driver-hg20070718/alsa-kernel/include/cs4231.h	2007-07-21 00:39:55.000000000 -0700
@@ -210,7 +210,7 @@
 #define CS4231_HW_CS4239	0x0404	/* CS4239 - Crystal Clear (tm) stereo enhancement */
 /* compatible, but clones */
 #define CS4231_HW_INTERWAVE     0x1000	/* InterWave chip */
-#define CS4231_HW_OPL3SA2       0x1001	/* OPL3-SA2 chip */
+#define CS4231_HW_OPL3SA2       0x1101	/* OPL3-SA2 chip, similar to cs4231 */
 
 /* defines for codec.hwshare */
 #define CS4231_HWSHARE_IRQ	(1<<0)
diff -ur /tmp/alsa-driver-hg20070718/alsa-kernel/isa/cs423x/cs4231_lib.c alsa-driver-hg20070718/alsa-kernel/isa/cs423x/cs4231_lib.c
--- /tmp/alsa-driver-hg20070718/alsa-kernel/isa/cs423x/cs4231_lib.c	2007-02-22 17:00:24.000000000 -0800
+++ alsa-driver-hg20070718/alsa-kernel/isa/cs423x/cs4231_lib.c	2007-07-25 22:49:04.000000000 -0700
@@ -555,6 +555,9 @@
 			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
 		}
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
+		if (chip->hardware == CS4231_HW_OPL3SA2) {
+			udelay(100);	/* this seems to help */
+		}
 		snd_cs4231_mce_down(chip);
 	}
 	snd_cs4231_calibrate_mute(chip, 0);
diff -ur /tmp/alsa-driver-hg20070718/alsa-kernel/isa/opl3sa2.c alsa-driver-hg20070718/alsa-kernel/isa/opl3sa2.c
--- /tmp/alsa-driver-hg20070718/alsa-kernel/isa/opl3sa2.c	2007-07-04 17:00:11.000000000 -0700
+++ alsa-driver-hg20070718/alsa-kernel/isa/opl3sa2.c	2007-07-25 21:19:39.000000000 -0700
@@ -253,6 +253,7 @@
 		/* 0x03 - YM715B */
 		/* 0x04 - YM719 - OPL-SA4? */
 		/* 0x05 - OPL3-SA3 - Libretto 100 */
+		/* 0x07 - unknown - Neomagic MagicWave 3D */
 		break;
 	}
 	str[0] = chip->version + '0';
