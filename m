From: "Zoltan Devai" <zdevai@gmail.com>
Subject: [PATCH] Fix PIT lockup on some chipsets when using the
	PC-Speaker
Date: Mon, 3 Nov 2008 00:30:28 +0100
Message-ID: <5b7270f40811021530y54d856c4u7389ec0758b4c7c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id E33011037EE
	for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2008 00:30:28 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so1293262nfd.32
	for <alsa-devel@alsa-project.org>; Sun, 02 Nov 2008 15:30:28 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

There've been reports [1] about the sysem bell causing a hard lockup.
My machine was affected as well: Any speaker output hung the machine
completely, nothing in the logs, no magic sysrq, etc., looked like a
hardware problem.
Had a closer look on the issue, and it turned out that the pcspkr module is
responsible. The cause is the bad setup of Timer 2 in the i8253 controller,
which probably hangs the whole PIT controller.

Intel datasheets [2] state that the timer registers are in an undefined
state after reset and they need to be programmed before enabling the
timer. (And enabling without programming the frequency first doesn't
make sense anyway).

I don't know which chipsets are affected (if not all), it also depends on
the BIOS whether it initializes the timer (e.g. to beep when you start the
machine).

The following patch solved the issue on my ICH6 notebook, couldn't
test it with any others, but should be safe to apply.

I've also sent a patch to the linux-input list for the pcspkr module.

[1]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/146151
https://bugs.launchpad.net/ubuntu/+bug/270790
http://ubuntuforums.org/showthread.php?t=227693
http://bugs.gentoo.org/show_bug.cgi?id=222583
https://bugzilla.redhat.com/show_bug.cgi?id=454225

[2]
http://www.intel.com/assets/pdf/datasheet/252516.pdf
http://www.intel.com/assets/pdf/datasheet/301473.pdf
http://www.intel.com/design/chipsets/datashts/29065503.pdf

------------------

Fix PIT lockup on some chipsets when using the PC-Speaker.

Signed-off-by: Zoltan Devai <zdevai@gmail.com>

--- a/sound/drivers/pcsp/pcsp_input.c
+++ b/sound/drivers/pcsp/pcsp_input.c
@@ -24,13 +24,13 @@
 	spin_lock_irqsave(&i8253_lock, flags);

 	if (count) {
-		/* enable counter 2 */
-		outb_p(inb_p(0x61) | 3, 0x61);
 		/* set command for counter 2, 2 byte write */
 		outb_p(0xB6, 0x43);
 		/* select desired HZ */
 		outb_p(count & 0xff, 0x42);
 		outb((count >> 8) & 0xff, 0x42);
+		/* enable counter 2 */
+		outb_p(inb_p(0x61) | 3, 0x61);
 	} else {
 		/* disable counter 2 */
 		outb(inb_p(0x61) & 0xFC, 0x61);
