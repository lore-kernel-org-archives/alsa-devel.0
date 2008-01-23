From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: es1938 - patch trying to improve capture hw pointer
	reads
Date: Wed, 23 Jan 2008 01:35:12 +0100
Message-ID: <20080123003512.GA6828@lemon.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de
	[129.206.210.211])
	by alsa0.perex.cz (Postfix) with ESMTP id D899F24C5B
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 01:35:24 +0100 (CET)
Received: from mail.iwr.uni-heidelberg.de (mail.iwr.uni-heidelberg.de
	[129.206.104.30])
	by relay2.uni-heidelberg.de (8.13.8/8.13.8) with ESMTP id
	m0N0W2Zv002276
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 01:32:03 +0100
Received: from lemon.iwr.uni-heidelberg.de (lemon.iwr.uni-heidelberg.de
	[129.206.104.80])
	by mail.iwr.uni-heidelberg.de (8.12.11/8.12.11) with ESMTP id
	m0N0ZNYb010804
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 01:35:23 +0100 (MET)
Received: (from hlauer@localhost)
	by lemon.iwr.uni-heidelberg.de (8.13.6/8.12.11) id m0N0ZCqa006836
	for alsa-devel@alsa-project.org; Wed, 23 Jan 2008 01:35:12 +0100 (MET)
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


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

with the Solo1 (es1938) I got a lot of xrun's during capture on my machine. Tracing
that down it seems to be comming from reading ocassionaly bad hw pointers from the chip. Appended
is a patch against linux-2.6.23.12 which uses more checking to avoid that false pointer reads.

Failed reads are giving back the last good value read instead of spinning in
a tight loop, which seems more appropriate to me in an interrupt. I think I saw
this trick used in another driver.

On my machine xruns seems to be gone with that patch.

If anybody is interested, mmaped capture seems also to be doable with some tricks, still testing this...

Greetings

  Hermann 

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="es1938-c.hw_pointer.patchl"

--- linux-2.6.23.12/sound/pci/es1938.c.trydma	2008-01-14 23:46:57.000000000 +0100
+++ linux-2.6.23.12/sound/pci/es1938.c	2008-01-23 01:03:08.000000000 +0100
@@ -227,6 +227,8 @@
 	unsigned int dma2_start;
 	unsigned int dma1_shift;
 	unsigned int dma2_shift;
+        void*        last_capture_dmaaddr;
+
 	unsigned int active;
 
 	spinlock_t reg_lock;
@@ -775,14 +777,38 @@
 	struct es1938 *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
 	size_t old, new;
-#if 1
+#if 0
 	/* This stuff is *needed*, don't ask why - AB */
 	old = inw(SLDM_REG(chip, DMACOUNT));
 	while ((new = inw(SLDM_REG(chip, DMACOUNT))) != old)
 		old = new;
 	ptr = chip->dma1_size - 1 - new;
 #else
-	ptr = inl(SLDM_REG(chip, DMAADDR)) - chip->dma1_start;
+	/* during the incrementing of dma counters the DMA register reads sometimes returns garbage.
+	   To ensure a valid hw pointer, the following checks which should be
+	   very unlikely to fail are used:
+	   - is the current DMA address in the valid DMA range ?
+	   - is the sum of DMA address and DMA counter pointing to the last DMA byte ?
+	     One can argue this could differ by one byte depending on which register is
+	     updated first, so the implemention below allows for that.
+	*/
+	size_t stat,count;
+	unsigned int diff;
+	struct snd_pcm_runtime *runtime;
+	runtime = substream->runtime;
+	ptr = inl(SLDM_REG(chip, DMAADDR));
+	count= inw(SLDM_REG(chip, DMACOUNT));
+	diff=chip->dma1_start+chip->dma1_size-ptr-count;
+
+	/*	    printk("Es1938debug - capture_pointer %x,diff=%x,fb=%x DMA count: %x, base: %x, status: %x\n",
+		       ptr,diff,((unsigned char*)(runtime->dma_area)-1)[0],count, inl(SLDM_REG(chip, DMAADDR)), inl(SLDM_REG(chip, DMASTATUS)));
+	*/
+	if (diff>3 || ptr < chip->dma1_start
+	      || ptr >= chip->dma1_start+chip->dma1_size)
+	  ptr=chip->last_capture_dmaaddr;                 /* bad, use last saved instead */
+	else chip->last_capture_dmaaddr=ptr;              /* good, remember it */
+
+	ptr -= chip->dma1_start;
 #endif
 	return ptr >> chip->dma1_shift;
 }

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MGYHOYXEY6WxJCY8--
