From: Paul Davis <pbd@op.net>
Subject: correct version of rme9652patch
Date: Wed, 8 May 2002 23:31:47 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205090331.g493VlE24858@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA19260
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 05:31:02 +0200
Received: from op.net (maxtnt04-110.phlpa.fast.net [209.92.96.110])
	by post2.fast.net (8.11.2/8.9.3) with ESMTP id g493Uqv25015
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 23:30:53 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

here's the correct version. teach me to compile before running cvs
diff. sorry about that.

--p

Index: rme9652.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/rme9652.c,v
retrieving revision 1.15
diff -u -u -r1.15 rme9652.c
--- rme9652.c	26 Apr 2002 09:39:18 -0000	1.15
+++ rme9652.c	9 May 2002 03:10:55 -0000
@@ -24,7 +24,6 @@
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/pci.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -480,6 +479,10 @@
 	int reject_if_open = 0;
 	int xrate;
 
+	if (!snd_rme9652_use_is_exclusive (rme9652)) {
+		return -EBUSY;
+	}
+
 	/* Changing from a "single speed" to a "double speed" rate is
 	   not allowed if any substreams are open. This is because
 	   such a change causes a shift in the location of 
@@ -523,8 +526,7 @@
 		return -EINVAL;
 	}
 
-	if (reject_if_open &&
-	    (rme9652->capture_pid >= 0 || rme9652->playback_pid >= 0)) {
+	if (reject_if_open && (rme9652->capture_pid >= 0 || rme9652->playback_pid >= 0)) {
 		spin_unlock_irq(&rme9652->lock);
 		return -EBUSY;
 	}
@@ -532,7 +534,6 @@
 	if ((restart = rme9652->running)) {
 		rme9652_stop(rme9652);
 	}
-
 	rme9652->control_register &= ~(RME9652_freq | RME9652_DS);
 	rme9652->control_register |= rate;
 	rme9652_write(rme9652, RME9652_control_register, rme9652->control_register);
@@ -2231,6 +2232,9 @@
 			    substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 				rme9652_silence_playback(rme9652);
 		}
+	} else {
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) 
+			rme9652_silence_playback(rme9652);
 	}
  _ok:
 	snd_pcm_trigger_done(substream, substream);
@@ -2543,6 +2547,20 @@
 	rme9652->irq = -1;
 	rme9652->card = card;
 
+	pci_read_config_word(rme9652->pci, PCI_CLASS_REVISION, &rev);
+
+	switch (rev & 0xff) {
+	case 3:
+	case 4:
+	case 8:
+	case 9:
+		break;
+
+	default:
+		/* who knows? */
+		return -ENODEV;
+	}
+
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
@@ -2554,18 +2572,28 @@
 		return -EBUSY;
 	}
 
-	if (request_irq(pci->irq, snd_rme9652_interrupt, SA_INTERRUPT|SA_SHIRQ, "rme9652", (void *)rme9652)) {
-		snd_printk("unable to grab IRQ %d\n", pci->irq);
+	rme9652->iobase = (unsigned long) ioremap_nocache(rme9652->port, RME9652_IO_EXTENT);
+	if (rme9652->iobase == 0) {
+		snd_printk("unable to remap region 0x%lx-0x%lx\n", rme9652->port, rme9652->port + RME9652_IO_EXTENT - 1);
 		return -EBUSY;
 	}
-	rme9652->irq = pci->irq;
-
+	
 	rme9652->iobase = (unsigned long) ioremap_nocache(rme9652->port, RME9652_IO_EXTENT);
 	if (rme9652->iobase == 0) {
 		snd_printk("unable to remap region 0x%lx-0x%lx\n", rme9652->port, rme9652->port + RME9652_IO_EXTENT - 1);
 		return -EBUSY;
 	}
 	
+
+
+
+
+	if (request_irq(pci->irq, snd_rme9652_interrupt, SA_INTERRUPT|SA_SHIRQ, "rme9652", (void *)rme9652)) {
+		snd_printk("unable to grab IRQ %d\n", pci->irq);
+		return -EBUSY;
+	}
+	rme9652->irq = pci->irq;
+
 	rme9652->precise_ptr = precise_ptr;
 
 	/* Determine the h/w rev level of the card. This seems like
@@ -2587,9 +2615,7 @@
 	   relevant.  
 	*/
 
-	pci_read_config_word(rme9652->pci, PCI_CLASS_REVISION, &rev);
-	strcpy(card->driver, "RME9652");
-	switch (rev & 0xff) {
+	switch (rev) {
 	case 8: /* original eprom */
 		strcpy(card->driver, "RME9636");
 		if (rme9652->hw_rev == 15) {
@@ -2605,11 +2631,12 @@
 		rme9652->ss_channels = RME9636_NCHANNELS;
 		break;
 	case 4: /* W52_G EPROM */
+		strcpy(card->driver, "RME9652");
 		rme9652->card_name = "RME Digi9652 (Rev G)";
 		rme9652->ss_channels = RME9652_NCHANNELS;
 		break;
-	default:
 	case 3: /* original eprom */
+		strcpy(card->driver, "RME9652");
 		if (rme9652->hw_rev == 15) {
 			rme9652->card_name = "RME Digi9652 (Rev 1.5)";
 		} else {

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
