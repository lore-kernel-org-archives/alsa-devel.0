From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: fix P16V breakage for
	non	Audigy2 cards
Date: Thu, 17 Mar 2005 10:53:32 -0500
Message-ID: <1111074813.23171.11.camel@mindpipe>
References: <1110950511.19984.9.camel@mindpipe>
	 <1110950832.19984.13.camel@mindpipe>  <4238A516.7070802@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-o9HSavsg0lujO0nbBTVg"
In-Reply-To: <4238A516.7070802@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-o9HSavsg0lujO0nbBTVg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-16 at 21:28 +0000, James Courtier-Dutton wrote:
> Thank you for fixing the bug.
> The "unhandled interrupt" should be commented out. It is used for 
> reverse engineering certain features.
> 

OK, updated patch attached.

Please apply to CVS ASAP, this is a bad bug!

Lee



--=-o9HSavsg0lujO0nbBTVg
Content-Disposition: attachment; filename=sblive-p16v-fixes-2.patch
Content-Type: text/x-patch; name=sblive-p16v-fixes-2.patch; charset=ANSI_X3.4-1968
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

--=-o9HSavsg0lujO0nbBTVg--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
