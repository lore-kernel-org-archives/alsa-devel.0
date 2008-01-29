From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: es1938 - patch trying to improve capture hw
	pointer	reads
Date: Tue, 29 Jan 2008 09:31:04 +0100
Message-ID: <20080129083104.GA15758@lemon.iwr.uni-heidelberg.de>
References: <20080123003512.GA6828@lemon.iwr.uni-heidelberg.de>
	<s5hr6g74f8d.wl%tiwai@suse.de>
	<20080124152102.GE8290@lemon.iwr.uni-heidelberg.de>
	<s5hwspz2pwd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de
	[129.206.210.211])
	by alsa0.perex.cz (Postfix) with ESMTP id DB329103932
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 09:31:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwspz2pwd.wl%tiwai@suse.de>
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


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2008 at 04:40:18PM +0100, Takashi Iwai wrote:

> > > The patch is, however, unable to apply as is because of coding style
> > > problems.  Try $LINUXKERNEL/scripts/checkpatch.pl, fix what are
> > > suggested there, and repost the patch together with your sign-off.
> > 
> > Will do that when I digged trough the details (have to learn about signing).
> 
> See $LINUX/Documentation/SubmittingPatches.

Appended is a cleaned up version of the patch. checkpatch.pl is now
only mucking about the '#if 0' commented out old branch. Should this
be removed or the if-else parts exchanged, which probably will calm down
checkpatch.pl ?

Have to check compilation, then I will send a signed version.

Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="es1938-hw_pointer.patchl"

--- linux-2.6.23.12/sound/pci/es1938.c.trydma	2008-01-10 19:50:14.000000000 +0000
+++ linux-2.6.23.12/sound/pci/es1938.c	2008-01-29 07:33:53.000000000 +0000
@@ -227,6 +227,8 @@
 	unsigned int dma2_start;
 	unsigned int dma1_shift;
 	unsigned int dma2_shift;
+	void *last_capture_dmaaddr;
+
 	unsigned int active;
 
 	spinlock_t reg_lock;
@@ -770,19 +772,42 @@
 	return -EINVAL;
 }
 
+/* during the incrementing of dma counters the DMA register reads sometimes
+   returns garbage. To ensure a valid hw pointer, the following checks which
+   should be very unlikely to fail are used:
+   - is the current DMA address in the valid DMA range ?
+   - is the sum of DMA address and DMA counter pointing to the last DMA byte ?
+   One can argue this could differ by one byte depending on which register is
+   updated first, so the implemention below allows for that.
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
+	size_t stat, count;
+	unsigned int diff;
+	struct snd_pcm_runtime *runtime;
+
+	runtime = substream->runtime;
+	ptr = inl(SLDM_REG(chip, DMAADDR));
+	count = inw(SLDM_REG(chip, DMACOUNT));
+	diff = chip->dma1_start+chip->dma1_size-ptr-count;
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

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--sm4nu43k4a2Rpi4c--
