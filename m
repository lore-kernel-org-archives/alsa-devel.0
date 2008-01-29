From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: es1938 - patch trying to improve capture hw
	pointer	reads
Date: Tue, 29 Jan 2008 22:29:21 +0100
Message-ID: <20080129212921.GA16040@lemon.iwr.uni-heidelberg.de>
References: <20080123003512.GA6828@lemon.iwr.uni-heidelberg.de>
	<s5hr6g74f8d.wl%tiwai@suse.de>
	<20080124152102.GE8290@lemon.iwr.uni-heidelberg.de>
	<s5hwspz2pwd.wl%tiwai@suse.de>
	<20080129083104.GA15758@lemon.iwr.uni-heidelberg.de>
	<s5h1w8069i6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de
	[129.206.100.212])
	by alsa0.perex.cz (Postfix) with ESMTP id EF7012467E
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 22:29:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1w8069i6.wl%tiwai@suse.de>
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


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2008 at 02:34:25PM +0100, Takashi Iwai wrote:

> That's fine.  checkpatch.pl is no strict rule to apply.
> 
> > Have to check compilation, then I will send a signed version.
> 
> Thanks.
> One missing thing is the initialization of last_capture_dmaaddr.
> This should be set to zero in prepare callback.

Thanks for that hint, fixed in the appended, signed version.
After futher cleanups this compiles without warnings.

Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="es1938-hw_pointer.patchl"

--- linux-2.6.23.12/sound/pci/es1938.c.trydma	2008-01-14 23:46:57.000000000 +0100
+++ linux-2.6.23.12/sound/pci/es1938.c	2008-01-29 21:13:04.000000000 +0100
@@ -227,6 +227,7 @@
 	unsigned int dma2_start;
 	unsigned int dma1_shift;
 	unsigned int dma2_shift;
+	unsigned int last_capture_dmaaddr;
 	unsigned int active;
 
 	spinlock_t reg_lock;
@@ -529,6 +530,7 @@
 	outb(1, SLDM_REG(chip, DMAMASK));
 	outb(0x14, SLDM_REG(chip, DMAMODE));
 	outl(chip->dma1_start, SLDM_REG(chip, DMAADDR));
+	chip->last_capture_dmaaddr = chip->dma1_start;
 	outw(chip->dma1_size - 1, SLDM_REG(chip, DMACOUNT));
 	/* 3. Unmask DMA */
 	outb(0, SLDM_REG(chip, DMAMASK));
@@ -770,19 +772,40 @@
 	return -EINVAL;
 }
 
+/* during the incrementing of dma counters the DMA register reads sometimes
+   returns garbage. To ensure a valid hw pointer, the following checks which
+   should be very unlikely to fail are used:
+   - is the current DMA address in the valid DMA range ?
+   - is the sum of DMA address and DMA counter pointing to the last DMA byte ?
+   One can argue this could differ by one byte depending on which register is
+   updated first, so the implementation below allows for that.
+*/
 static snd_pcm_uframes_t snd_es1938_capture_pointer(struct snd_pcm_substream *substream)
 {
 	struct es1938 *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
+#if 0
 	size_t old, new;
-#if 1
 	/* This stuff is *needed*, don't ask why - AB */
 	old = inw(SLDM_REG(chip, DMACOUNT));
 	while ((new = inw(SLDM_REG(chip, DMACOUNT))) != old)
 		old = new;
 	ptr = chip->dma1_size - 1 - new;
 #else
-	ptr = inl(SLDM_REG(chip, DMAADDR)) - chip->dma1_start;
+	size_t count;
+	unsigned int diff;
+
+	ptr = inl(SLDM_REG(chip, DMAADDR));
+	count = inw(SLDM_REG(chip, DMACOUNT));
+	diff = chip->dma1_start + chip->dma1_size - ptr - count;
+
+	if (diff > 3 || ptr < chip->dma1_start
+	      || ptr >= chip->dma1_start+chip->dma1_size)
+	  ptr = chip->last_capture_dmaaddr;            /* bad, use last saved */
+	else
+	  chip->last_capture_dmaaddr = ptr;            /* good, remember it */
+
+	ptr -= chip->dma1_start;
 #endif
 	return ptr >> chip->dma1_shift;
 }

Signed-off-by: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--uAKRQypu60I7Lcqm--
