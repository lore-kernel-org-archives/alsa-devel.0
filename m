From: Rene Herman <rene.herman@gmail.com>
Subject: [ PATCH 1/4] alsa-kernel: schedule_timeout() fixes
Date: Tue, 18 Sep 2007 15:38:45 +0200
Message-ID: <46EFD4E5.2080206@gmail.com>
References: <46E58D01.9080809@gmail.com>	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>	<46EF18FF.7070906@gmail.com>	<46EF3097.7060300@gmail.com>	<46EF52E4.90401@gmail.com>
	<s5habrkchpa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070904080008080103000903"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DB4E24363
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 15:39:45 +0200 (CEST)
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
--------------070904080008080103000903
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/18/2007 01:54 PM, Takashi Iwai wrote:

> The other changes look good to me.  But, honestly, I couldn't follow all
> the pathes you sent in the right order.  So, could you guys make a series
> of patches to be applied to HG tree?  That'll be really helpful for
> review, too.

Ofcourse. These schedule_timeout() fixes are not dependent on anything else. 
  I audited alsa-kernel for this schedule_timeout() issue, and this and next 
two messages do all I found.

===

alsa-kernel: schedule_timeout() fixes

Fix schedule_timeout() use in alsa-kernel. Mostly just

	schedule_timeout(1) --> schedule_timeout_uninterruptible(1)

The wavefront_synth one fixes the surrounding loop as well. In ymfpci_main, 
delete a superfluous set_current_state() and in soc/soc-dapm.c replace an 
_interruptible with _uninterruptible in some debug code; it's not waiting 
for signals.

Signed-off-by: Rene Herman <rene.herman>

--------------070904080008080103000903
Content-Type: text/plain;
 name="schedule_timeout-alsa_kernel.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedule_timeout-alsa_kernel.diff"

diff -r 0028e39ead78 isa/sscape.c
--- a/isa/sscape.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/isa/sscape.c	Tue Sep 18 14:53:57 2007 +0200
@@ -401,7 +401,7 @@ static int obp_startup_ack(struct sounds
 		unsigned long flags;
 		unsigned char x;
 
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 
 		spin_lock_irqsave(&s->lock, flags);
 		x = inb(HOST_DATA_IO(s->io_base));
@@ -428,7 +428,7 @@ static int host_startup_ack(struct sound
 		unsigned long flags;
 		unsigned char x;
 
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 
 		spin_lock_irqsave(&s->lock, flags);
 		x = inb(HOST_DATA_IO(s->io_base));
diff -r 0028e39ead78 isa/wavefront/wavefront_synth.c
--- a/isa/wavefront/wavefront_synth.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/isa/wavefront/wavefront_synth.c	Tue Sep 18 14:53:57 2007 +0200
@@ -1768,7 +1768,7 @@ snd_wavefront_interrupt_bits (int irq)
 
 static void __devinit
 wavefront_should_cause_interrupt (snd_wavefront_t *dev, 
-				  int val, int port, int timeout)
+				  int val, int port, unsigned long timeout)
 
 {
 	wait_queue_t wait;
@@ -1779,11 +1779,9 @@ wavefront_should_cause_interrupt (snd_wa
 	dev->irq_ok = 0;
 	outb (val,port);
 	spin_unlock_irq(&dev->irq_lock);
-	while (1) {
-		if ((timeout = schedule_timeout(timeout)) == 0)
-			return;
-		if (dev->irq_ok)
-			return;
+	while (!dev->irq_ok && time_before(jiffies, timeout)) {
+		schedule_timeout_uninterruptible(1);
+		barrier();
 	}
 }
 
diff -r 0028e39ead78 pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/pci/hda/hda_intel.c	Tue Sep 18 14:53:57 2007 +0200
@@ -555,7 +555,7 @@ static unsigned int azx_rirb_get_respons
 		}
 		if (!chip->rirb.cmds)
 			return chip->rirb.res; /* the last value */
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_after_eq(timeout, jiffies));
 
 	if (chip->msi) {
diff -r 0028e39ead78 pci/via82xx.c
--- a/pci/via82xx.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/pci/via82xx.c	Tue Sep 18 14:53:57 2007 +0200
@@ -2090,7 +2090,7 @@ static int snd_via82xx_chip_init(struct 
 		pci_read_config_byte(chip->pci, VIA_ACLINK_STAT, &pval);
 		if (pval & VIA_ACLINK_C00_READY) /* primary codec ready */
 			break;
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 
 	if ((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY)
@@ -2109,7 +2109,7 @@ static int snd_via82xx_chip_init(struct 
 			chip->ac97_secondary = 1;
 			goto __ac97_ok2;
 		}
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 	/* This is ok, the most of motherboards have only one codec */
 
diff -r 0028e39ead78 pci/via82xx_modem.c
--- a/pci/via82xx_modem.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/pci/via82xx_modem.c	Tue Sep 18 14:53:57 2007 +0200
@@ -983,7 +983,7 @@ static int snd_via82xx_chip_init(struct 
 		pci_read_config_byte(chip->pci, VIA_ACLINK_STAT, &pval);
 		if (pval & VIA_ACLINK_C00_READY) /* primary codec ready */
 			break;
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 
 	if ((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY)
@@ -1001,7 +1001,7 @@ static int snd_via82xx_chip_init(struct 
 			chip->ac97_secondary = 1;
 			goto __ac97_ok2;
 		}
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 	/* This is ok, the most of motherboards have only one codec */
 
diff -r 0028e39ead78 pci/ymfpci/ymfpci_main.c
--- a/pci/ymfpci/ymfpci_main.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/pci/ymfpci/ymfpci_main.c	Tue Sep 18 14:53:57 2007 +0200
@@ -84,7 +84,6 @@ static int snd_ymfpci_codec_ready(struct
 	do {
 		if ((snd_ymfpci_readw(chip, reg) & 0x8000) == 0)
 			return 0;
-		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 	snd_printk(KERN_ERR "codec_ready: codec %i is not ready [0x%x]\n", secondary, snd_ymfpci_readw(chip, reg));
diff -r 0028e39ead78 soc/soc-dapm.c
--- a/soc/soc-dapm.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/soc/soc-dapm.c	Tue Sep 18 14:53:57 2007 +0200
@@ -63,7 +63,7 @@
 #define POP_DEBUG 0
 #if POP_DEBUG
 #define POP_TIME 500 /* 500 msecs - change if pop debug is too fast */
-#define pop_wait(time) schedule_timeout_interruptible(msecs_to_jiffies(time))
+#define pop_wait(time) schedule_timeout_uninterruptible(msecs_to_jiffies(time))
 #define pop_dbg(format, arg...) printk(format, ## arg); pop_wait(POP_TIME)
 #else
 #define pop_dbg(format, arg...)

--------------070904080008080103000903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070904080008080103000903--
