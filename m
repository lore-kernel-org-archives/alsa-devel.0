From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 06:24:04 +0200
Message-ID: <46EF52E4.90401@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<46EF18FF.7070906@gmail.com> <46EF3097.7060300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010807070106070909060902"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id C8C3124434
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 06:24:58 +0200 (CEST)
In-Reply-To: <46EF3097.7060300@gmail.com>
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
--------------010807070106070909060902
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/18/2007 03:57 AM, Rene Herman wrote:

> Oh. This discrepency is caused by the fact that I work against the 
> kernel and only check ALSA HG every once in a while. Too infrequently it 
> seems as the _interruptible was recently (and yes, wrongly) removed from 
> ALSA:
> 
> http://hg.alsa-project.org/alsa-kernel/rev/1768363a5f1e
> 
> It's still there in 2.6.22.x which I run. The setup has been changed 
> around in the meantime again anyway in this case but I guess I'll make a 
> point of working against HG more directly.

And here's the others in that changeset, against current hg. As far as I'm 
aware, the only purpose of the _interruptible versions is bailing out when 
signal_pending(current) and if we're simply looping around without checking 
anyway, they might as well be schedule_timeout_uninterruptible(), also known 
as msleep().

Given that delaying for a jiffy generally doesn't make a great deal of sense 
given variable frequency, they might actually want to be msleep(1) directly 
but I didn't do that.

This also adds a barrier() to one of the /core/seq/seq_instr.c ones which as 
far as I can see is needed to keep the compiler from optimising the check 
away. For the other instances there, the spin_lock functions serve as a 
barrier already I believe but please check me on that -- I'm inexperienced 
at that level.

The wavefront_synth one was strange. It was originally (when still using 
_interruptible) in the absence of signals basically just doing a single:

	msleep(jiffies_to_msecs(timeout));

with the dev->irq_ok check only happening when woken up by a signal which I 
assume was not so much intended. This now just does a sleeping loop.

Otherwise,

Signed-off-by: Rene Herman <rene.herman@gmail.com>


--------------010807070106070909060902
Content-Type: text/plain;
 name="schedule_timeout-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedule_timeout-fixes.diff"

diff -r 0028e39ead78 core/seq/seq_instr.c
--- a/core/seq/seq_instr.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/core/seq/seq_instr.c	Tue Sep 18 06:20:25 2007 +0200
@@ -109,7 +109,7 @@ void snd_seq_instr_list_free(struct snd_
 			spin_lock_irqsave(&list->lock, flags);
 			while (instr->use) {
 				spin_unlock_irqrestore(&list->lock, flags);
-				schedule_timeout(1);
+				schedule_timeout_uninterruptible(1);
 				spin_lock_irqsave(&list->lock, flags);
 			}				
 			spin_unlock_irqrestore(&list->lock, flags);
@@ -198,8 +198,10 @@ int snd_seq_instr_list_free_cond(struct 
 		while (flist) {
 			instr = flist;
 			flist = instr->next;
-			while (instr->use)
-				schedule_timeout(1);
+			while (instr->use) {
+				schedule_timeout_uninterruptible(1);
+				barrier();
+			}
 			if (snd_seq_instr_free(instr, atomic)<0)
 				snd_printk(KERN_WARNING "instrument free problem\n");
 			instr = next;
@@ -555,7 +557,7 @@ static int instr_free(struct snd_seq_kin
 					   SNDRV_SEQ_INSTR_NOTIFY_REMOVE);
 		while (instr->use) {
 			spin_unlock_irqrestore(&list->lock, flags);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 			spin_lock_irqsave(&list->lock, flags);
 		}				
 		spin_unlock_irqrestore(&list->lock, flags);
diff -r 0028e39ead78 isa/sscape.c
--- a/isa/sscape.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/isa/sscape.c	Tue Sep 18 06:20:25 2007 +0200
@@ -428,7 +428,7 @@ static int host_startup_ack(struct sound
 		unsigned long flags;
 		unsigned char x;
 
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 
 		spin_lock_irqsave(&s->lock, flags);
 		x = inb(HOST_DATA_IO(s->io_base));
diff -r 0028e39ead78 isa/wavefront/wavefront_synth.c
--- a/isa/wavefront/wavefront_synth.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/isa/wavefront/wavefront_synth.c	Tue Sep 18 06:20:25 2007 +0200
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
+++ b/pci/hda/hda_intel.c	Tue Sep 18 06:20:25 2007 +0200
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
+++ b/pci/via82xx.c	Tue Sep 18 06:20:25 2007 +0200
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
+++ b/pci/via82xx_modem.c	Tue Sep 18 06:20:25 2007 +0200
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
 

--------------010807070106070909060902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010807070106070909060902--
