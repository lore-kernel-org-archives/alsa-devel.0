From: Paul Davis <pbd@op.net>
Subject: patches for rme9652
Date: Wed, 8 May 2002 23:04:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205090304.g4934QP23771@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA18989
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 05:03:36 +0200
Received: from op.net (maxtnt04-110.phlpa.fast.net [209.92.96.110])
	by post2.fast.net (8.11.2/8.9.3) with ESMTP id g4933Vv22164
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 23:03:31 -0400 (EDT)
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

this patch fixes a bug in the hammerfall driver, and improves the code
logic in a couple of places. the bug was that when we trigger the
capture substream and there is no playback substream, we failed to
silence the playback buffer. this leads to some potentially horrible
noises during capture-only software execution (such as arecord). the
code is also slightly rearranged to check h/w versions before doing
resource allocation.

there is still a hard-to-solve bug in the driver: if you try to change
between a "single-speed" sample rate and a "double-speed" sample rate
by using the params API, it will fail because there is a substream
already open. this was 100% by design - the speed change alters the
number of channels and their memory locations. but its a silly
restriction that needs to be fixed at some point.

please let me know when this is applied to CVS.

thanks
--p



Index: rme9652.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/rme9652.c,v
retrieving revision 1.15
diff -u -u -r1.15 rme9652.c
--- rme9652.c	26 Apr 2002 09:39:18 -0000	1.15
+++ rme9652.c	9 May 2002 02:57:21 -0000
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
+	if (reject_if_open && (rme9652->capture_pid >= 0 || rme9652->playback_pid >= 0))
 		spin_unlock_irq(&rme9652->lock);
 		return -EBUSY;
 	}
@@ -2231,6 +2233,9 @@
 			    substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 				rme9652_silence_playback(rme9652);
 		}
+	} else {
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) 
+			rme9652_silence_playback(rme9652);
 	}
  _ok:
 	snd_pcm_trigger_done(substream, substream);
@@ -2543,6 +2548,20 @@
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
 
@@ -2554,18 +2573,28 @@
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
@@ -2587,9 +2616,7 @@
 	   relevant.  
 	*/
 
-	pci_read_config_word(rme9652->pci, PCI_CLASS_REVISION, &rev);
-	strcpy(card->driver, "RME9652");
-	switch (rev & 0xff) {
+	switch (rev) {
 	case 8: /* original eprom */
 		strcpy(card->driver, "RME9636");
 		if (rme9652->hw_rev == 15) {
@@ -2605,11 +2632,12 @@
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
