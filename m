From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: fix P16V breakage for non Audigy2 cards
Date: Wed, 16 Mar 2005 00:21:51 -0500
Message-ID: <1110950511.19984.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3v2hs6NPHwgm+M6CyNbX"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-3v2hs6NPHwgm+M6CyNbX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The P16V patch unconditionally checks the IPR2 register in the interrupt
handler resulting in infinite loop and system lockup on any non Audigy2
cards.  I really hate checking emu->is_audigy and emu->revision in a
fast path like the IRQ handler but I don't see another way.

Also, don't bother allocating/freeing the DMA buffer for P16V unless
it's really present.

This is a critical fix and should trigger an immediate rc2 release IMO.
Currently any emu10k1 users other than Audigy 2 will lock up hard as
soon as they play any sound.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-3v2hs6NPHwgm+M6CyNbX
Content-Disposition: attachment; filename=sblive-p16v-fixes.patch
Content-Type: text/x-patch; name=sblive-p16v-fixes.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.32
diff -u -r1.32 emu10k1.c
--- alsa/alsa-kernel/pci/emu10k1/emu10k1.c	13 Mar 2005 12:17:08 -0000	1.32
+++ alsa/alsa-kernel/pci/emu10k1/emu10k1.c	16 Mar 2005 05:15:06 -0000
@@ -140,9 +140,11 @@
 		return err;
 	}
 	/* This stores the periods table. */
-	if(snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci), 1024, &emu->p16v_buffer) < 0) {
-		snd_p16v_free(emu);
-		return -ENOMEM;
+	if (emu->audigy && emu->revision == 4) { /* P16V */	
+		if(snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci), 1024, &emu->p16v_buffer) < 0) {
+			snd_p16v_free(emu);
+			return -ENOMEM;
+		}
 	}
 
 	if ((err = snd_emu10k1_mixer(emu)) < 0) {
Index: alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.44
diff -u -r1.44 emu10k1_main.c
--- alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	13 Mar 2005 12:17:08 -0000	1.44
+++ alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	16 Mar 2005 05:15:07 -0000
@@ -600,7 +600,8 @@
 	if (emu->port)
 		pci_release_regions(emu->pci);
 	pci_disable_device(emu->pci);
-	snd_p16v_free(emu);
+	if (emu->audigy && emu->revision == 4) /* P16V */	
+		snd_p16v_free(emu);
 	kfree(emu);
 	return 0;
 }
Index: alsa/alsa-kernel/pci/emu10k1/irq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/irq.c,v
retrieving revision 1.13
diff -u -r1.13 irq.c
--- alsa/alsa-kernel/pci/emu10k1/irq.c	13 Mar 2005 12:17:10 -0000	1.13
+++ alsa/alsa-kernel/pci/emu10k1/irq.c	16 Mar 2005 05:15:07 -0000
@@ -149,7 +149,7 @@
 		}
 		if (status) {
 			unsigned int bits;
-			//snd_printk(KERN_ERR "emu10k1: unhandled interrupt: 0x%08x\n", status);
+			snd_printk(KERN_ERR "emu10k1: unhandled interrupt: 0x%08x\n", status);
 			//make sure any interrupts we don't handle are disabled:
 			bits = INTE_FXDSPENABLE |
 				INTE_PCIERRORENABLE |
@@ -170,19 +170,20 @@
 		}
 		outl(orig_status, emu->port + IPR); /* ack all */
 	}
-	while ((status2 = inl(emu->port + IPR2)) != 0) {
-		u32 mask = INTE2_PLAYBACK_CH_0_LOOP;  /* Full Loop */
-		emu10k1_voice_t *pvoice = &(emu->p16v_voices[0]);
-		orig_status2 = status2;
-		if(status2 & mask) {
-			if(pvoice->use) {
-				snd_pcm_period_elapsed(pvoice->epcm->substream);
-			} else { 
-				snd_printk(KERN_ERR "p16v: status: 0x%08x, mask=0x%08x, pvoice=%p, use=%d\n", status2, mask, pvoice, pvoice->use);
+	if (emu->audigy && emu->revision == 4) { /* P16V */	
+		while ((status2 = inl(emu->port + IPR2)) != 0) {
+			u32 mask = INTE2_PLAYBACK_CH_0_LOOP;  /* Full Loop */
+			emu10k1_voice_t *pvoice = &(emu->p16v_voices[0]);
+			orig_status2 = status2;
+			if(status2 & mask) {
+				if(pvoice->use) {
+					snd_pcm_period_elapsed(pvoice->epcm->substream);
+				} else { 
+					snd_printk(KERN_ERR "p16v: status: 0x%08x, mask=0x%08x, pvoice=%p, use=%d\n", status2, mask, pvoice, pvoice->use);
+				}
 			}
+			outl(orig_status2, emu->port + IPR2); /* ack all */
 		}
-		outl(orig_status2, emu->port + IPR2); /* ack all */
 	}
-
 	return IRQ_RETVAL(handled);
 }

--=-3v2hs6NPHwgm+M6CyNbX--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
