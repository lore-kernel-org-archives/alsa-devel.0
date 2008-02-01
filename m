From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: es1938 - experimental patch allowing mmaped capture on
	Solo1
Date: Fri, 1 Feb 2008 10:29:00 +0100
Message-ID: <20080201092900.GA19521@lemon.iwr.uni-heidelberg.de>
References: <20080123003512.GA6828@lemon.iwr.uni-heidelberg.de>
	<s5hr6g74f8d.wl%tiwai@suse.de>
	<20080124152102.GE8290@lemon.iwr.uni-heidelberg.de>
	<s5hwspz2pwd.wl%tiwai@suse.de>
	<20080125002514.GA9015@lemon.iwr.uni-heidelberg.de>
	<s5h3asm2nib.wl%tiwai@suse.de>
	<20080125160727.GF9123@lemon.iwr.uni-heidelberg.de>
	<s5hy7adj2s7.wl%tiwai@suse.de>
	<20080125162928.GH9123@lemon.iwr.uni-heidelberg.de>
	<s5hr6g5j210.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de
	[129.206.210.211])
	by alsa0.perex.cz (Postfix) with ESMTP id AD9A0103848
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 10:29:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr6g5j210.wl%tiwai@suse.de>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

appended is an experimental patch agains linux-2.6.23.12 which enables mmaped
access during capture on the es1938 (Solo1).

Main obstacle is (as documented in the current driver) that the dma engine
put bytes from the adc with an offset +1 to ram. 
So the patch did the following:

- allocate on additional page in front of the capture dma buffer, with mmaping
  pointing to the original buffer (i.e. with one page offset into the dma area)
- let the dma engine start from the last byte of that extra page, so that all
  bytes are put aligned to the real dma area (besides the last byte)
- the last byte the dma engine of the chip put at the first location, i.e.
  in the last byte of the extra front dma page.
- This byte has to be copied at the right time to the end of the mmaped area,
  which is done in the hw_pointer callback.

In a discussion with Takashi some of the pointer callback issues are already
discussed (that patch is included btw.), and from the log send there (lock
at the fb values, which is the fist byte of dma area) you can see that 
indeed the last byte is transferred after
the interrupt indicating reaching the end of the dma buffer came in.

On Fri, Jan 25, 2008 at 05:36:11PM +0100, Takashi Iwai wrote:
> The hwptr is the position of the current DMA.  The data below that
> point must have been already processed.  That's why hwptr returned in
> snd_pcm_period_elapsed() must be on the period boundary or above.

The patched driver did not fullfill this, OTOH I have made first recordings
which seems to be ok (even with the debug printk in the hw_pointer callback).

Have fun,
  Hermann 
-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="es1938-hw_pointer_dma1.patchl"

--- sound/pci/es1938.c.trydma	2008-01-10 19:50:14.000000000 +0000
+++ sound/pci/es1938.c	2008-02-01 07:14:35.000000000 +0000
@@ -227,6 +227,7 @@ struct es1938 {
 	unsigned int dma2_start;
 	unsigned int dma1_shift;
 	unsigned int dma2_shift;
+	unsigned int last_capture_dmaaddr;
 	unsigned int active;
 
 	spinlock_t reg_lock;
@@ -529,6 +530,7 @@ static void snd_es1938_capture_setdma(st
 	outb(1, SLDM_REG(chip, DMAMASK));
 	outb(0x14, SLDM_REG(chip, DMAMODE));
 	outl(chip->dma1_start, SLDM_REG(chip, DMAADDR));
+	chip->last_capture_dmaaddr = chip->dma1_start;
 	outw(chip->dma1_size - 1, SLDM_REG(chip, DMACOUNT));
 	/* 3. Unmask DMA */
 	outb(0, SLDM_REG(chip, DMAMASK));
@@ -640,7 +642,7 @@ static int snd_es1938_capture_prepare(st
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
 
 	chip->dma1_size = size;
-	chip->dma1_start = runtime->dma_addr;
+	chip->dma1_start = runtime->dma_addr + PAGE_SIZE - 1;
 
 	mono = (runtime->channels > 1) ? 0 : 1;
 	is8 = snd_pcm_format_width(runtime->format) == 16 ? 0 : 1;
@@ -770,19 +772,56 @@ static int snd_es1938_playback_prepare(s
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
+	struct snd_pcm_runtime *runtime;
+	runtime = substream->runtime;
+
+	ptr = inl(SLDM_REG(chip, DMAADDR));
+	count = inw(SLDM_REG(chip, DMACOUNT));
+	diff = chip->dma1_start + chip->dma1_size - ptr - count;
+
+	printk("Es1938debug - capture_pointer last=%x,diff=%x,fb=%x,lb=%x DMA count: %x, base: %x\n",
+	  chip->last_capture_dmaaddr,diff,((unsigned char*)(runtime->dma_area)-1)[0],
+	  ((unsigned char*)(runtime->dma_area))[chip->dma1_size-1], count,ptr);
+
+	if (diff > 3 || ptr < chip->dma1_start
+	      || ptr >= chip->dma1_start+chip->dma1_size)
+	  ptr = chip->last_capture_dmaaddr;            /* bad, use last saved */
+	else
+	  chip->last_capture_dmaaddr = ptr;            /* good, remember it */
+
+	ptr -= chip->dma1_start;
+
+	if (ptr) ptr-=1;
+	else ptr=chip->dma1_size-1;
+
+	if (ptr && ptr<=0x2000) {
+	  struct snd_pcm_runtime *runtime;
+	  runtime = substream->runtime;
+	  ((unsigned char*)(runtime->dma_area))[chip->dma1_size-1]=
+			((unsigned char*)(runtime->dma_area)-1)[0];
+	}
 #endif
 	return ptr >> chip->dma1_shift;
 }
@@ -865,6 +904,21 @@ static int snd_es1938_pcm_hw_params(stru
 	return 0;
 }
 
+static int snd_es1938_pcm_hw_params_capture(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *hw_params)
+
+{
+	int err;
+
+	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params)+PAGE_SIZE)) < 0)
+		return err;
+
+	struct snd_pcm_runtime *runtime = substream->runtime;
+       	runtime->dma_area = runtime->dma_buffer_p->area+PAGE_SIZE;
+	
+	return 0;
+}
+
 static int snd_es1938_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	return snd_pcm_lib_free_pages(substream);
@@ -875,8 +929,8 @@ static int snd_es1938_pcm_hw_free(struct
  * ----------------------------------------------------------------------*/
 static struct snd_pcm_hardware snd_es1938_capture =
 {
-	.info =			(SNDRV_PCM_INFO_INTERLEAVED |
-				SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+				SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE |
 				 SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U16_LE),
 	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
@@ -996,12 +1050,12 @@ static struct snd_pcm_ops snd_es1938_cap
 	.open =		snd_es1938_capture_open,
 	.close =	snd_es1938_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_es1938_pcm_hw_params,
+	.hw_params =	snd_es1938_pcm_hw_params_capture,
 	.hw_free =	snd_es1938_pcm_hw_free,
 	.prepare =	snd_es1938_capture_prepare,
 	.trigger =	snd_es1938_capture_trigger,
 	.pointer =	snd_es1938_capture_pointer,
-	.copy =		snd_es1938_capture_copy,
+	/*	.copy =		snd_es1938_capture_copy,*/
 };
 
 static int __devinit snd_es1938_new_pcm(struct es1938 *chip, int device)
@@ -1019,7 +1073,7 @@ static int __devinit snd_es1938_new_pcm(
 	strcpy(pcm->name, "ESS Solo-1");
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      snd_dma_pci_data(chip->pci), 64*1024, 64*1024);
+					      snd_dma_pci_data(chip->pci), 64*1024+PAGE_SIZE, 64*1024+PAGE_SIZE);
 
 	chip->pcm = pcm;
 	return 0;

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--pf9I7BMVVzbSWLtt--
