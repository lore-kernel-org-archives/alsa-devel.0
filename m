From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI
 Soundchip
Date: Thu, 11 Aug 2005 17:18:31 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508111716090.21860-100000@studcom.urz.uni-halle.de>
References: <Pine.HPX.4.33n.0508041503020.11474-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0508041503020.11474-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thibaut VARENE <T-Bone@parisc-linux.org>
Cc: alsa-devel@lists.sourceforge.net, kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org
List-Id: alsa-devel@alsa-project.org

I wrote:
> Thibaut VARENE wrote:
> > Attached is a patch against 2.6.13-rc4 providing support for Analog
> > Devices AD1889 PCI Sound chip, which is especially found on some HP
> > PA-RISC machines.
>
> I don't actually have this hardware :-), but the docs don't mention
> any dependency between the count registers (BC, CC) and the interrupt
> count registers (IC, IB).
>
> So wouldn't it be possible to put the ALSA buffer size into the count
> registers and the ALSA period size into the interrupt count registers?
>
> This would make the interrupt handler much simpler, as it wouldn't
> have to reprogram any registers.  And it would solve the problem that
> the DMA accesses for one period go beyond the buffer when the number
> of periods per buffer is not an integer.

... something like this (please test):


Index: alsa/alsa-driver/pci/ad1889.h
===================================================================
--- alsa.orig/alsa-driver/pci/ad1889.h	2005-08-04 17:56:50.000000000 +0200
+++ alsa/alsa-driver/pci/ad1889.h	2005-08-11 11:54:38.000000000 +0200
@@ -172,13 +172,6 @@
 #define AD_ADC_STATE	1
 #define AD_MAX_STATES	2

-/* "<ggg> T-Bone: parisc IOMMU can start DMA at any address.
-   But the IOMMU can only map at page size granularity."
-   This affects in particular .period_bytes_min */
-#define BUF_SIZE        PAGE_SIZE
-#define MAX_BUFS        32
-#define DMA_SIZE	(MAX_BUFS*BUF_SIZE)
-
 #define AD_CHAN_WAV	0x0001
 #define AD_CHAN_ADC	0x0002
 #define AD_CHAN_RES	0x0004
Index: alsa/alsa-driver/pci/ad1889.c
===================================================================
--- alsa.orig/alsa-driver/pci/ad1889.c	2005-08-11 10:46:42.000000000 +0200
+++ alsa/alsa-driver/pci/ad1889.c	2005-08-11 12:21:21.000000000 +0200
@@ -87,15 +87,11 @@ MODULE_PARM_DESC(ac97_quirk, "AC'97 work
 /* let's use the global sound debug interfaces */
 #define ad1889_debug(fmt, arg...) snd_printd(KERN_DEBUG fmt, ## arg)

-/* keep track of each hw register */
+/* keep track of some hw registers */
 struct ad1889_register_state {
 	u16 reg;	/* reg setup */
 	u32 addr;	/* dma base address */
-	u16 rate;	/* sample rate */
-	unsigned long pos;	/* last recorded DMA buffer position */
-	unsigned long buf;	/* period # */
 	unsigned long size;	/* DMA buffer size */
-	unsigned long count;	/* period size, aka nb bytes sent in the current DMA transfer */
 };

 struct snd_ad1889 {
@@ -118,13 +114,6 @@ struct snd_ad1889 {
 	struct ad1889_register_state wave;
 	struct ad1889_register_state ramc;

-	struct {
-		unsigned long wav_intr;
-		unsigned long adc_intr;
-		unsigned long syn_intr;
-		unsigned long res_intr;
-	} stats;
-
 	spinlock_t lock;
 };

@@ -172,22 +161,46 @@ ad1889_mute(struct snd_ad1889 *chip)
 }

 static inline void
-ad1889_load_adc_count(struct snd_ad1889 *chip, u32 count)
+ad1889_load_adc_buffer_address(struct snd_ad1889 *chip, u32 address)
+{
+	ad1889_writel(chip, AD_DMA_ADCBA, address);
+	ad1889_writel(chip, AD_DMA_ADCCA, address);
+}
+
+static inline void
+ad1889_load_adc_buffer_count(struct snd_ad1889 *chip, u32 count)
 {
 	ad1889_writel(chip, AD_DMA_ADCBC, count);
 	ad1889_writel(chip, AD_DMA_ADCCC, count);
+}
+
+static inline void
+ad1889_load_adc_interrupt_count(struct snd_ad1889 *chip, u32 count)
+{
 	ad1889_writel(chip, AD_DMA_ADCIB, count);
 	ad1889_writel(chip, AD_DMA_ADCIC, count);
-}
+}
+
+static inline void
+ad1889_load_wave_buffer_address(struct snd_ad1889 *chip, u32 address)
+{
+	ad1889_writel(chip, AD_DMA_WAVBA, address);
+	ad1889_writel(chip, AD_DMA_WAVCA, address);
+}

 static inline void
-ad1889_load_wave_count(struct snd_ad1889 *chip, u32 count)
+ad1889_load_wave_buffer_count(struct snd_ad1889 *chip, u32 count)
 {
 	ad1889_writel(chip, AD_DMA_WAVBC, count);
 	ad1889_writel(chip, AD_DMA_WAVCC, count);
+}
+
+static inline void
+ad1889_load_wave_interrupt_count(struct snd_ad1889 *chip, u32 count)
+{
 	ad1889_writel(chip, AD_DMA_WAVIB, count);
 	ad1889_writel(chip, AD_DMA_WAVIC, count);
-}
+}

 static void
 ad1889_channel_reset(struct snd_ad1889 *chip, unsigned int channel)
@@ -207,9 +220,9 @@ ad1889_channel_reset(struct snd_ad1889 *
 		ad1889_writew(chip, AD_DMA_WAV, reg);

 		/* clear IRQ and address counters and pointers */
-		ad1889_load_wave_count(chip, 0x0);
-		ad1889_writel(chip, AD_DMA_WAVBA, 0x0);
-		ad1889_writel(chip, AD_DMA_WAVCA, 0x0);
+		ad1889_load_wave_buffer_address(chip, 0x0);
+		ad1889_load_wave_buffer_count(chip, 0x0);
+		ad1889_load_wave_interrupt_count(chip, 0x0);

 		/* flush */
 		ad1889_readw(chip, AD_DMA_WAV);
@@ -226,9 +239,9 @@ ad1889_channel_reset(struct snd_ad1889 *
 		reg &= ~AD_DMA_LOOP;
 		ad1889_writew(chip, AD_DMA_ADC, reg);

-		ad1889_load_adc_count(chip, 0x0);
-		ad1889_writel(chip, AD_DMA_ADCBA, 0x0);
-		ad1889_writel(chip, AD_DMA_ADCCA, 0x0);
+		ad1889_load_adc_buffer_address(chip, 0x0);
+		ad1889_load_adc_buffer_count(chip, 0x0);
+		ad1889_load_adc_interrupt_count(chip, 0x0);

 		/* flush */
 		ad1889_readw(chip, AD_DMA_ADC);
@@ -290,11 +303,11 @@ static snd_pcm_hardware_t snd_ad1889_pla
 	.rate_max = 48000,
 	.channels_min = 1,
 	.channels_max = 2,
-	.buffer_bytes_max = DMA_SIZE,	/* max DMA buffer size in bytes */
-	.period_bytes_min = BUF_SIZE,	/* min size of period in bytes */
-	.period_bytes_max = DMA_SIZE,	/* max size of period in bytes */
-	.periods_min = 1,		/* min nb of periods in buffer */
-	.periods_max = MAX_BUFS,
+	.buffer_bytes_max = 256 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 128 * 1024,
+	.periods_min = 2,
+	.periods_max = 256,
 	/*.fifo_size = 0,*/
 };

@@ -307,11 +320,11 @@ static snd_pcm_hardware_t snd_ad1889_cap
 	.rate_max = 48000,
 	.channels_min = 1,
 	.channels_max = 2,
-	.buffer_bytes_max = DMA_SIZE,	/* max DMA buffer size in bytes */
-	.period_bytes_min = BUF_SIZE,	/* min size of period in bytes */
-	.period_bytes_max = DMA_SIZE,	/* max size of period in bytes */
-	.periods_min = 1,		/* min nb of periods in buffer */
-	.periods_max = MAX_BUFS,
+	.buffer_bytes_max = 256 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 128 * 1024,
+	.periods_min = 2,
+	.periods_max = 256,
 	/*.fifo_size = 0,*/
 };

@@ -381,24 +394,18 @@ snd_ad1889_playback_prepare(snd_pcm_subs
 	spin_lock_irq(&chip->lock);

 	chip->wave.size = size;
-	chip->wave.count = count;
 	chip->wave.reg = reg;
-	chip->wave.buf = 0;
-	chip->wave.pos = 0;
-	chip->wave.rate = rt->rate;
 	chip->wave.addr = rt->dma_addr;

 	ad1889_writew(chip, AD_DS_WSMC, chip->wave.reg);

 	/* Set sample rates on the codec */
-	ad1889_writew(chip, AD_DS_WAS, chip->wave.rate);
+	ad1889_writew(chip, AD_DS_WAS, rt->rate);

-	/* Set up DMA: first chunk address in curr addr, next one in base addr.
-	   Base will be loaded into curr by the hardware upon interrupt
-	   (as we use LOOP). Count holds the size of the chunk. */
-	ad1889_writel(chip, AD_DMA_WAVCA, chip->wave.addr);
-	ad1889_writel(chip, AD_DMA_WAVBA, chip->wave.addr + (count % size));
-	ad1889_load_wave_count(chip, chip->wave.count);
+	/* Set up DMA */
+	ad1889_load_wave_buffer_address(chip, chip->wave.addr);
+	ad1889_load_wave_buffer_count(chip, size);
+	ad1889_load_wave_interrupt_count(chip, count);

 	/* writes flush */
 	ad1889_readw(chip, AD_DS_WSMC);
@@ -407,7 +414,7 @@ snd_ad1889_playback_prepare(snd_pcm_subs

 	ad1889_debug("prepare playback: addr = 0x%x, count = %u, "
 			"size = %u, reg = 0x%x, rate = %u\n", chip->wave.addr,
-			count, size, reg, chip->wave.rate);
+			count, size, reg, rt->rate);
 	return 0;
 }

@@ -437,21 +444,15 @@ snd_ad1889_capture_prepare(snd_pcm_subst
 	spin_lock_irq(&chip->lock);

 	chip->ramc.size = size;
-	chip->ramc.count = count;
 	chip->ramc.reg = reg;
-	chip->ramc.buf = 0;
-	chip->ramc.pos = 0;
-	chip->ramc.rate = rt->rate;
 	chip->ramc.addr = rt->dma_addr;

 	ad1889_writew(chip, AD_DS_RAMC, chip->ramc.reg);

-	/* Set up DMA: first chunk address in curr addr, next one in base addr.
-	   Base will be loaded into curr by the hardware upon interrupt
-	   (as we use LOOP). Count holds the size of the chunk. */
-	ad1889_writel(chip, AD_DMA_ADCCA, chip->ramc.addr);
-	ad1889_writel(chip, AD_DMA_ADCBA, chip->ramc.addr + (count % size));
-	ad1889_load_adc_count(chip, chip->ramc.count);
+	/* Set up DMA */
+	ad1889_load_adc_buffer_address(chip, chip->ramc.addr);
+	ad1889_load_adc_buffer_count(chip, size);
+	ad1889_load_adc_interrupt_count(chip, count);

 	/* writes flush */
 	ad1889_readw(chip, AD_DS_RAMC);
@@ -460,7 +461,7 @@ snd_ad1889_capture_prepare(snd_pcm_subst

 	ad1889_debug("prepare capture: addr = 0x%x, count = %u, "
 			"size = %u, reg = 0x%x, rate = %u\n", chip->ramc.addr,
-			count, size, reg, chip->ramc.rate);
+			count, size, reg, rt->rate);
 	return 0;
 }

@@ -607,7 +608,6 @@ snd_ad1889_interrupt(int irq,
 		     struct pt_regs *regs)
 {
 	unsigned long st;
-	unsigned long next;
 	struct snd_ad1889 *chip = dev_id;

 	st = ad1889_readl(chip, AD_DMA_DISR);
@@ -623,82 +623,12 @@ snd_ad1889_interrupt(int irq,
 	if (st & (AD_DMA_DISR_PMAI|AD_DMA_DISR_PTAI))
 		ad1889_debug("Unexpected master or target abort interrupt!\n");

-	if (chip->pcm && (st & AD_DMA_DISR_WAVI) && chip->psubs) {
-		spin_lock(&chip->lock);
-
-		chip->stats.wav_intr++;
-
-		chip->wave.buf++;
-
-		/* calculate the current position: we get interrupts everytime
-		   the buffer empties, thus every wave.count bytes transfered */
-		chip->wave.pos += chip->wave.count;
-		chip->wave.pos %= chip->wave.size;
-
-		/* the next buffer will thus be current position + wave.count
-		   bytes away */
-		next = chip->wave.pos + chip->wave.count;
-		next %= chip->wave.size;
-
-		/* Load new DMA parameters (aka "the next chunk" in Base
-		   registers: upon next interrupt, they'll be automatically
-		   loaded in the Current registers, and we'll end up here
-		   preparing the new ones. Since "count" never gets modified
-		   elsewhere than in _prepare, we don't need to rewrite it. */
-		ad1889_writel(chip, AD_DMA_WAVBA, chip->wave.addr + next);
-
-		ad1889_readl(chip, AD_DMA_WAVBA); /* flush all those writes */
-
-		spin_unlock(&chip->lock);
-
+	if ((st & AD_DMA_DISR_WAVI) && chip->psubs)
 		snd_pcm_period_elapsed(chip->psubs);
-#if 0
-		ad1889_debug("chip->wave.pos = %d, chip->wave.count = %d, "
-				"chip->wave.size = %d\n", chip->wave.pos,
-				chip->wave.count, chip->wave.size);
-		ad1889_debug("chip->wave.addr (0x%lx) + next (0x%lx) = 0x%lx\n",
-				chip->wave.addr, next, chip->wave.addr + next);
-#endif
-	}
-
-	if (chip->pcm && (st & AD_DMA_DISR_ADCI) && chip->csubs) {
-		spin_lock(&chip->lock);
-
-		chip->stats.adc_intr++;
-
-		chip->ramc.buf++;
-
-		/* calculate the current position: we get interrupts everytime
-		   the buffer empties, thus every wave.count bytes transfered */
-		chip->ramc.pos += chip->ramc.count;
-		chip->ramc.pos %= chip->ramc.size;
-
-		/* the next buffer will thus be current position + wave.count
-		   bytes away */
-		next = chip->ramc.pos + chip->ramc.count;
-		next %= chip->ramc.size;
-
-		/* Load new DMA parameters (aka "the next chunk" in Base
-		   registers: upon next interrupt, they'll be automatically
-		   loaded in the Current registers, and we'll end up here
-		   preparing the new ones. Since "count" never gets modified
-		   elsewhere than in _prepare, we don't need to rewrite it. */
-		ad1889_writel(chip, AD_DMA_ADCBA, chip->ramc.addr + next);
-
-		ad1889_readl(chip, AD_DMA_ADCBA); /* flush all those writes */
-
-		spin_unlock(&chip->lock);
-
+	if ((st & AD_DMA_DISR_ADCI) && chip->csubs)
 		snd_pcm_period_elapsed(chip->csubs);
-#if 0
-		ad1889_debug("chip->ramc.pos = %d, chip->ramc.count = %d, "
-				"chip->ramc.size = %d\n", chip->ramc.pos,
-				chip->ramc.count, chip->ramc.size);
-		ad1889_debug("chip->ramc.addr (0x%lx) + next (0x%lx) = 0x%lx\n",
-				chip->ramc.addr, next, chip->ramc.addr + next);
-#endif
-	}

+	ad1889_readl(chip, AD_DMA_DISR); /* flush */
 	/* XXX under some circumstances the DISR write flush may not happen */

 	return IRQ_HANDLED;
@@ -741,7 +671,7 @@ snd_ad1889_pcm_init(struct snd_ad1889 *c

 	err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 						snd_dma_pci_data(chip->pci),
-						DMA_SIZE, DMA_SIZE);
+						128 * 1024, 256 * 1024);

 	if (err < 0) {
 		snd_printk(KERN_ERR PFX "buffer allocation error: %d\n", err);



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
