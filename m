From: Andreas Mohr <andi@lisas.de>
Subject: [PATCH] ALS4000 driver work, step 2
Date: Thu, 21 Aug 2008 21:55:57 +0200
Message-ID: <20080821195557.GA8015@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DCF524466
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 21:55:58 +0200 (CEST)
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
To: tiwai@suse.de
Cc: Bart Hartgers <bart@etpmod.phys.tue.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

- more register naming work
- finally figured out that weird CR register stuff
  (and did I mention that I hate _really_ undecipherable open-coded values?)
- fix handling of IRQ sharing in interrupt handler
  (hopefully properly, otherwise I'd be grateful to hear your
  pedantic comments ;)
- add handy SPECS_PAGE references wherever useful
- comments, cleanup
- add me as module author

Patch created on 2.6.27-rc1-git4 (diffed against my earlier submission),
pushed through checkpatch.pl, verified on my ALS4000 card (listening to
it right now of course).

Thanks!
(especially for your very fast handling)

Next patch _will_ contain more useful things, I promise ;)
Oh, and apologies to several people for my previous asbestos-requiring
comments!

Seems Bart's mail address is still valid, hopefully
(and found that he's also a Winchip freak, heh).

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- sound/pci/als4000.c.sent	2008-08-18 22:12:27.000000000 +0200
+++ sound/pci/als4000.c	2008-08-21 21:30:10.000000000 +0200
@@ -2,7 +2,7 @@
  *  card-als4000.c - driver for Avance Logic ALS4000 based soundcards.
  *  Copyright (C) 2000 by Bart Hartgers <bart@etpmod.phys.tue.nl>,
  *			  Jaroslav Kysela <perex@perex.cz>
- *  Copyright (C) 2002 by Andreas Mohr <hw7oshyuv3001@sneakemail.com>
+ *  Copyright (C) 2002, 2008 by Andreas Mohr <hw7oshyuv3001@sneakemail.com>
  *
  *  Framework borrowed from Massimo Piccioni's card-als100.c.
  *
@@ -27,8 +27,10 @@
  *  bought an ALS4000 based soundcard, I was forced to base this driver
  *  on reverse engineering.
  *
- *  Note: this is no longer true. Pretty verbose chip docu (ALS4000a.PDF)
- *  can be found on the ALSA web site.
+ *  Note: this is no longer true (thank you!):
+ *  pretty verbose chip docu (ALS4000a.PDF) can be found on the ALSA web site.
+ *  Page numbers stated anywhere below with the "SPECS_PAGE:" tag
+ *  refer to: ALS4000a.PDF specs Ver 1.0, May 28th, 1998.
  *
  *  The ALS4000 seems to be the PCI-cousin of the ALS100. It contains an
  *  ALS100-like SB DSP/mixer, an OPL3 synth, a MPU401 and a gameport 
@@ -59,7 +61,6 @@
  * - value -> some port 0x0c0d
  *
  * ToDo:
- * - Proper shared IRQ handling?
  * - by default, don't enable legacy game and use PCI game I/O
  * - power management? (card can do voice wakeup according to datasheet!!)
  */
@@ -79,7 +80,7 @@
 #include <sound/sb.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Bart Hartgers <bart@etpmod.phys.tue.nl>");
+MODULE_AUTHOR("Bart Hartgers <bart@etpmod.phys.tue.nl>, Andreas Mohr");
 MODULE_DESCRIPTION("Avance Logic ALS4000");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS4000}}");
@@ -124,22 +125,22 @@
 MODULE_DEVICE_TABLE(pci, snd_als4000_ids);
 
 enum als4k_iobase_t {
-	/* IOx: B == Byte, W = Word, D = DWord */
+	/* IOx: B == Byte, W = Word, D = DWord; SPECS_PAGE: 37 */
 	ALS4K_IOD_00_AC97_ACCESS = 0x00,
 	ALS4K_IOW_04_AC97_READ = 0x04,
 	ALS4K_IOB_06_AC97_STATUS = 0x06,
 	ALS4K_IOB_07_IRQSTATUS = 0x07,
 	ALS4K_IOD_08_GCR_DATA = 0x08,
 	ALS4K_IOB_0C_GCR_INDEX = 0x0c,
-	ALS4K_IOB_0E_SB_MPU_IRQ = 0x0e,
+	ALS4K_IOB_0E_IRQTYPE_SB_CR1E_MPU = 0x0e,
 	ALS4K_IOB_10_ADLIB_ADDR0 = 0x10,
 	ALS4K_IOB_11_ADLIB_ADDR1 = 0x11,
 	ALS4K_IOB_12_ADLIB_ADDR2 = 0x12,
 	ALS4K_IOB_13_ADLIB_ADDR3 = 0x13,
 	ALS4K_IOB_14_MIXER_INDEX = 0x14,
 	ALS4K_IOB_15_MIXER_DATA = 0x15,
-	ALS4K_IOB_16_ESP_RST_PORT = 0x16,
-	ALS4K_IOB_16_CR1E_ACK_PORT = 0x16, /* 2nd function */
+	ALS4K_IOB_16_ESP_RESET = 0x16,
+	ALS4K_IOB_16_ACK_FOR_CR1E = 0x16, /* 2nd function */
 	ALS4K_IOB_18_OPL_ADDR0 = 0x18,
 	ALS4K_IOB_19_OPL_ADDR1 = 0x19,
 	ALS4K_IOB_1A_ESP_RD_DATA = 0x1a,
@@ -154,62 +155,137 @@
 	ALS4K_IOB_31_MIDI_COMMAND = 0x31, /* 2nd function */
 };
 
-enum als4k_gcr_t {
-	/* all registers 32bit wide */
-	ALS4K_GCR_8C_MISC_CTRL = 0x8c,
-	ALS4K_GCR_90_TEST_MODE_REG = 0x90,
-	ALS4K_GCR_91_DMA0_ADDR = 0x91,
-	ALS4K_GCR_92_DMA0_MODE_COUNT = 0x92,
-	ALS4K_GCR_93_DMA1_ADDR = 0x93,
-	ALS4K_GCR_94_DMA1_MODE_COUNT = 0x94,
-	ALS4K_GCR_95_DMA3_ADDR = 0x95,
-	ALS4K_GCR_96_DMA3_MODE_COUNT = 0x96,
-	ALS4K_GCR_99_DMA_EMULATION_CTRL = 0x99,
-	ALS4K_GCR_A0_FIFO1_CURRENT_ADDR = 0xa0,
-	ALS4K_GCR_A1_FIFO1_STATUS_BYTECOUNT = 0xa1,
-	ALS4K_GCR_A2_FIFO2_PCIADDR = 0xa2,
-	ALS4K_GCR_A3_FIFO2_COUNT = 0xa3,
-	ALS4K_GCR_A4_FIFO2_CURRENT_ADDR = 0xa4,
-	ALS4K_GCR_A5_FIFO1_STATUS_BYTECOUNT = 0xa5,
-	ALS4K_GCR_A6_PM_CTRL = 0xa6,
-	ALS4K_GCR_A7_PCI_ACCESS_STORAGE = 0xa7,
-	ALS4K_GCR_A8_LEGACY_CFG1 = 0xa8,
-	ALS4K_GCR_A9_LEGACY_CFG2 = 0xa9,
-	ALS4K_GCR_FF_DUMMY_SCRATCH = 0xff,
-};
-
-enum als4k_gcr_8c_t {
-	ALS4K_GCR_8C_IRQ_MASK_CTRL_ENABLE = 0x8000,
-	ALS4K_GCR_8C_CHIP_REV_MASK = 0xf0000
+enum als4k_iobase_0e_t {
+	ALS4K_IOB_0E_MPU_IRQ = 0x10,
+	ALS4K_IOB_0E_CR1E_IRQ = 0x40,
+	ALS4K_IOB_0E_SB_DMA_IRQ = 0x80,
 };
 
-static inline void snd_als4000_gcr_write_addr(unsigned long iobase,
-						 enum als4k_gcr_t reg,
-						 u32 val)
+enum als4k_gcr_t { /* all registers 32bit wide; SPECS_PAGE: 38 to 42 */
+	ALS4K_GCR8C_MISC_CTRL = 0x8c,
+	ALS4K_GCR90_TEST_MODE_REG = 0x90,
+	ALS4K_GCR91_DMA0_ADDR = 0x91,
+	ALS4K_GCR92_DMA0_MODE_COUNT = 0x92,
+	ALS4K_GCR93_DMA1_ADDR = 0x93,
+	ALS4K_GCR94_DMA1_MODE_COUNT = 0x94,
+	ALS4K_GCR95_DMA3_ADDR = 0x95,
+	ALS4K_GCR96_DMA3_MODE_COUNT = 0x96,
+	ALS4K_GCR99_DMA_EMULATION_CTRL = 0x99,
+	ALS4K_GCRA0_FIFO1_CURRENT_ADDR = 0xa0,
+	ALS4K_GCRA1_FIFO1_STATUS_BYTECOUNT = 0xa1,
+	ALS4K_GCRA2_FIFO2_PCIADDR = 0xa2,
+	ALS4K_GCRA3_FIFO2_COUNT = 0xa3,
+	ALS4K_GCRA4_FIFO2_CURRENT_ADDR = 0xa4,
+	ALS4K_GCRA5_FIFO1_STATUS_BYTECOUNT = 0xa5,
+	ALS4K_GCRA6_PM_CTRL = 0xa6,
+	ALS4K_GCRA7_PCI_ACCESS_STORAGE = 0xa7,
+	ALS4K_GCRA8_LEGACY_CFG1 = 0xa8,
+	ALS4K_GCRA9_LEGACY_CFG2 = 0xa9,
+	ALS4K_GCRFF_DUMMY_SCRATCH = 0xff,
+};
+
+enum als4k_gcr8c_t {
+	ALS4K_GCR8C_IRQ_MASK_CTRL_ENABLE = 0x8000,
+	ALS4K_GCR8C_CHIP_REV_MASK = 0xf0000
+};
+
+static inline void snd_als4k_iobase_writeb(unsigned long iobase,
+						enum als4k_iobase_t reg,
+						u8 val)
+{
+	outb(val, iobase + reg);
+}
+
+static inline void snd_als4k_iobase_writel(unsigned long iobase,
+						enum als4k_iobase_t reg,
+						u32 val)
+{
+	outl(val, iobase + reg);
+}
+
+static inline u8 snd_als4k_iobase_readb(unsigned long iobase,
+						enum als4k_iobase_t reg)
+{
+	return inb(iobase + reg);
+}
+
+static inline u32 snd_als4k_iobase_readl(unsigned long iobase,
+						enum als4k_iobase_t reg)
 {
-	outb(reg, iobase + ALS4K_IOB_0C_GCR_INDEX);
-	outl(val, iobase + ALS4K_IOD_08_GCR_DATA);
+	return inl(iobase + reg);
 }
 
-static inline void snd_als4000_gcr_write(struct snd_sb *sb,
+static inline void snd_als4k_gcr_write_addr(unsigned long iobase,
 						 enum als4k_gcr_t reg,
 						 u32 val)
 {
-	snd_als4000_gcr_write_addr(sb->alt_port, reg, val);
+	snd_als4k_iobase_writeb(iobase, ALS4K_IOB_0C_GCR_INDEX, reg);
+	snd_als4k_iobase_writel(iobase, ALS4K_IOD_08_GCR_DATA, val);
+}
+
+static inline void snd_als4k_gcr_write(struct snd_sb *sb,
+					 enum als4k_gcr_t reg,
+					 u32 val)
+{
+	snd_als4k_gcr_write_addr(sb->alt_port, reg, val);
 }	
 
-static inline u32 snd_als4000_gcr_read_addr(unsigned long iobase,
+static inline u32 snd_als4k_gcr_read_addr(unsigned long iobase,
 						 enum als4k_gcr_t reg)
 {
-	outb(reg, iobase + ALS4K_IOB_0C_GCR_INDEX);
-	return inl(iobase + ALS4K_IOD_08_GCR_DATA);
+	/* SPECS_PAGE: 37/38 */
+	snd_als4k_iobase_writeb(iobase, ALS4K_IOB_0C_GCR_INDEX, reg);
+	return snd_als4k_iobase_readl(iobase, ALS4K_IOD_08_GCR_DATA);
+}
+
+static inline u32 snd_als4k_gcr_read(struct snd_sb *sb, enum als4k_gcr_t reg)
+{
+	return snd_als4k_gcr_read_addr(sb->alt_port, reg);
+}
+
+enum als4k_cr_t { /* all registers 8bit wide; SPECS_PAGE: 20 to 23 */
+	ALS4K_CR0_SB_CONFIG = 0x00,
+	ALS4K_CR2_MISC_CONTROL = 0x02,
+	ALS4K_CR3_CONFIGURATION = 0x03,
+	ALS4K_CR17_FIFO_STATUS = 0x17,
+	ALS4K_CR18_ESP_MAJOR_VERSION = 0x18,
+	ALS4K_CR19_ESP_MINOR_VERSION = 0x19,
+	ALS4K_CR1A_MPU401_UART_MODE_CONTROL = 0x1a,
+	ALS4K_CR1C_FIFO2_BLOCK_LENGTH_LO = 0x1c,
+	ALS4K_CR1D_FIFO2_BLOCK_LENGTH_HI = 0x1d,
+	ALS4K_CR1E_FIFO2_CONTROL = 0x1e, /* secondary PCM FIFO (recording) */
+	ALS4K_CR3A_MISC_CONTROL = 0x3a,
+	ALS4K_CR3B_CRC32_BYTE0 = 0x3b, /* for testing, activate via CR3A */
+	ALS4K_CR3C_CRC32_BYTE1 = 0x3c,
+	ALS4K_CR3D_CRC32_BYTE2 = 0x3d,
+	ALS4K_CR3E_CRC32_BYTE3 = 0x3e,
+};
+
+enum als4k_cr0_t {
+	ALS4K_CR0_DMA_CONTIN_MODE_CTRL = 0x02, /* IRQ/FIFO controlled for 0/1 */
+	ALS4K_CR0_DMA_90H_MODE_CTRL = 0x04, /* IRQ/FIFO controlled for 0/1 */
+	ALS4K_CR0_MX80_81_REG_WRITE_ENABLE = 0x80,
+};
+
+static inline void snd_als4_cr_write(struct snd_sb *chip,
+					enum als4k_cr_t reg,
+					u8 data)
+{
+	/* Control Register is reg | 0xc0 (bit 7, 6 set) on sbmixer_index
+	 * NOTE: assumes chip->mixer_lock to be locked externally already!
+	 * SPECS_PAGE: 6 */
+	snd_sbmixer_write(chip, reg | 0xc0, data);
 }
 
-static inline u32 snd_als4000_gcr_read(struct snd_sb *sb, enum als4k_gcr_t reg)
+static inline u8 snd_als4_cr_read(struct snd_sb *chip,
+					enum als4k_cr_t reg)
 {
-	return snd_als4000_gcr_read_addr(sb->alt_port, reg);
+	/* NOTE: assumes chip->mixer_lock to be locked externally already! */
+	return snd_sbmixer_read(chip, reg | 0xc0);
 }
 
+
+
 static void snd_als4000_set_rate(struct snd_sb *chip, unsigned int rate)
 {
 	if (!(chip->mode & SB_RATE_LOCK)) {
@@ -222,16 +298,18 @@
 static inline void snd_als4000_set_capture_dma(struct snd_sb *chip,
 					       dma_addr_t addr, unsigned size)
 {
-	snd_als4000_gcr_write(chip, ALS4K_GCR_A2_FIFO2_PCIADDR, addr);
-	snd_als4000_gcr_write(chip, ALS4K_GCR_A3_FIFO2_COUNT, (size-1));
+	/* SPECS_PAGE: 40 */
+	snd_als4k_gcr_write(chip, ALS4K_GCRA2_FIFO2_PCIADDR, addr);
+	snd_als4k_gcr_write(chip, ALS4K_GCRA3_FIFO2_COUNT, (size-1));
 }
 
 static inline void snd_als4000_set_playback_dma(struct snd_sb *chip,
 						dma_addr_t addr,
 						unsigned size)
 {
-	snd_als4000_gcr_write(chip, ALS4K_GCR_91_DMA0_ADDR, addr);
-	snd_als4000_gcr_write(chip, ALS4K_GCR_92_DMA0_MODE_COUNT,
+	/* SPECS_PAGE: 38 */
+	snd_als4k_gcr_write(chip, ALS4K_GCR91_DMA0_ADDR, addr);
+	snd_als4k_gcr_write(chip, ALS4K_GCR92_DMA0_MODE_COUNT,
 							(size-1)|0x180000);
 }
 
@@ -316,7 +394,7 @@
 	count = snd_pcm_lib_period_bytes(substream);
 	
 	if (chip->capture_format & ALS4000_FORMAT_16BIT)
-		count >>=1;
+		count >>= 1;
 	count--;
 
 	spin_lock_irq(&chip->reg_lock);
@@ -324,8 +402,8 @@
 	snd_als4000_set_capture_dma(chip, runtime->dma_addr, size);
 	spin_unlock_irq(&chip->reg_lock);
 	spin_lock_irq(&chip->mixer_lock);
-	snd_sbmixer_write(chip, 0xdc, count);
-	snd_sbmixer_write(chip, 0xdd, count>>8);
+	snd_als4_cr_write(chip, ALS4K_CR1C_FIFO2_BLOCK_LENGTH_LO, count & 0xff);
+	snd_als4_cr_write(chip, ALS4K_CR1D_FIFO2_BLOCK_LENGTH_HI, count >> 8);
 	spin_unlock_irq(&chip->mixer_lock);
 	return 0;
 }
@@ -343,7 +421,7 @@
 	count = snd_pcm_lib_period_bytes(substream);
 	
 	if (chip->playback_format & ALS4000_FORMAT_16BIT)
-		count >>=1;
+		count >>= 1;
 	count--;
 	
 	/* FIXME: from second playback on, there's a lot more clicks and pops
@@ -360,8 +438,8 @@
 	/* snd_sbdsp_command(chip, SB_DSP_SPEAKER_ON); */
 	snd_sbdsp_command(chip, playback_cmd(chip).dsp_cmd);
 	snd_sbdsp_command(chip, playback_cmd(chip).format);
-	snd_sbdsp_command(chip, count);
-	snd_sbdsp_command(chip, count>>8);
+	snd_sbdsp_command(chip, count & 0xff);
+	snd_sbdsp_command(chip, count >> 8);
 	snd_sbdsp_command(chip, playback_cmd(chip).dma_off);	
 	spin_unlock_irq(&chip->reg_lock);
 	
@@ -384,12 +462,14 @@
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		chip->mode |= SB_RATE_LOCK_CAPTURE;
-		snd_sbmixer_write(chip, 0xde, capture_cmd(chip));
+		snd_als4_cr_write(chip, ALS4K_CR1E_FIFO2_CONTROL,
+							 capture_cmd(chip));
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		chip->mode &= ~SB_RATE_LOCK_CAPTURE;
-		snd_sbmixer_write(chip, 0xde, 0);
+		snd_als4_cr_write(chip, ALS4K_CR1E_FIFO2_CONTROL,
+							 capture_cmd(chip));
 		break;
 	default:
 		result = -EINVAL;
@@ -430,9 +510,9 @@
 	unsigned int result;
 
 	spin_lock(&chip->reg_lock);	
-	result = snd_als4000_gcr_read(chip, ALS4K_GCR_A4_FIFO2_CURRENT_ADDR);
-	result &= 0xffff;
+	result = snd_als4k_gcr_read(chip, ALS4K_GCRA4_FIFO2_CURRENT_ADDR);
 	spin_unlock(&chip->reg_lock);
+	result &= 0xffff;
 	return bytes_to_frames( substream->runtime, result );
 }
 
@@ -442,9 +522,9 @@
 	unsigned result;
 
 	spin_lock(&chip->reg_lock);	
-	result = snd_als4000_gcr_read(chip, ALS4K_GCR_A0_FIFO1_CURRENT_ADDR);
-	result &= 0xffff;
+	result = snd_als4k_gcr_read(chip, ALS4K_GCRA0_FIFO1_CURRENT_ADDR);
 	spin_unlock(&chip->reg_lock);
+	result &= 0xffff;
 	return bytes_to_frames( substream->runtime, result );
 }
 
@@ -452,46 +532,63 @@
  * return IRQ_HANDLED no matter whether we actually had an IRQ flag or not).
  * ALS4000a.PDF writes that while ACKing IRQ in PCI block will *not* ACK
  * the IRQ in the SB core, ACKing IRQ in SB block *will* ACK the PCI IRQ
- * register (alt_port + ALS4K_IOB_0E_SB_MPU_IRQ). Probably something
+ * register (alt_port + ALS4K_IOB_0E_IRQTYPE_SB_CR1E_MPU). Probably something
  * could be optimized here to query/write one register only...
  * And even if both registers need to be queried, then there's still the
  * question of whether it's actually correct to ACK PCI IRQ before reading
  * SB IRQ like we do now, since ALS4000a.PDF mentions that PCI IRQ will *clear*
  * SB IRQ status.
- * (hmm, page 38 mentions it the other way around!)
+ * (hmm, SPECS_PAGE: 38 mentions it the other way around!)
  * And do we *really* need the lock here for *reading* SB_DSP4_IRQSTATUS??
  * */
 static irqreturn_t snd_als4000_interrupt(int irq, void *dev_id)
 {
 	struct snd_sb *chip = dev_id;
-	unsigned gcr_status;
-	unsigned sb_status;
-
-	/* find out which bit of the ALS4000 produced the interrupt */
-	gcr_status = inb(chip->alt_port + ALS4K_IOB_0E_SB_MPU_IRQ);
+	unsigned pci_irqstatus;
+	unsigned sb_irqstatus;
 
-	if ((gcr_status & 0x80) && (chip->playback_substream)) /* playback */
+	/* find out which bit of the ALS4000 PCI block produced the interrupt,
+	   SPECS_PAGE: 38, 5 */
+	pci_irqstatus = snd_als4k_iobase_readb(chip->alt_port,
+				 ALS4K_IOB_0E_IRQTYPE_SB_CR1E_MPU);
+	if ((pci_irqstatus & ALS4K_IOB_0E_SB_DMA_IRQ)
+	 && (chip->playback_substream)) /* playback */
 		snd_pcm_period_elapsed(chip->playback_substream);
-	if ((gcr_status & 0x40) && (chip->capture_substream)) /* capturing */
+	if ((pci_irqstatus & ALS4K_IOB_0E_CR1E_IRQ)
+	 && (chip->capture_substream)) /* capturing */
 		snd_pcm_period_elapsed(chip->capture_substream);
-	if ((gcr_status & 0x10) && (chip->rmidi)) /* MPU401 interrupt */
+	if ((pci_irqstatus & ALS4K_IOB_0E_MPU_IRQ)
+	 && (chip->rmidi)) /* MPU401 interrupt */
 		snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data);
-	/* release the gcr */
-	outb(gcr_status, chip->alt_port + ALS4K_IOB_0E_SB_MPU_IRQ);
+	/* ACK the PCI block IRQ */
+	snd_als4k_iobase_writeb(chip->alt_port,
+			 ALS4K_IOB_0E_IRQTYPE_SB_CR1E_MPU, pci_irqstatus);
 	
 	spin_lock(&chip->mixer_lock);
-	sb_status = snd_sbmixer_read(chip, SB_DSP4_IRQSTATUS);
+	/* SPECS_PAGE: 20 */
+	sb_irqstatus = snd_sbmixer_read(chip, SB_DSP4_IRQSTATUS);
 	spin_unlock(&chip->mixer_lock);
 	
-	if (sb_status & SB_IRQTYPE_8BIT) 
+	if (sb_irqstatus & SB_IRQTYPE_8BIT)
 		snd_sb_ack_8bit(chip);
-	if (sb_status & SB_IRQTYPE_16BIT) 
+	if (sb_irqstatus & SB_IRQTYPE_16BIT)
 		snd_sb_ack_16bit(chip);
-	if (sb_status & SB_IRQTYPE_MPUIN)
+	if (sb_irqstatus & SB_IRQTYPE_MPUIN)
 		inb(chip->mpu_port);
-	if (sb_status & 0x20)
-		inb(SBP(chip, RESET));
-	return IRQ_HANDLED;
+	if (sb_irqstatus & ALS4K_IRQTYPE_CR1E_DMA)
+		snd_als4k_iobase_readb(chip->alt_port,
+					ALS4K_IOB_16_ACK_FOR_CR1E);
+
+	/* printk(KERN_INFO "als4000: irq 0x%04x 0x%04x\n",
+					 pci_irqstatus, sb_irqstatus); */
+
+	/* only ack the things we actually handled above */
+	return IRQ_RETVAL(
+	     (pci_irqstatus & (ALS4K_IOB_0E_SB_DMA_IRQ|ALS4K_IOB_0E_CR1E_IRQ|
+				ALS4K_IOB_0E_MPU_IRQ))
+	  || (sb_irqstatus & (SB_IRQTYPE_8BIT|SB_IRQTYPE_16BIT|
+				SB_IRQTYPE_MPUIN|ALS4K_IRQTYPE_CR1E_DMA))
+	);
 }
 
 /*****************************************************************/
@@ -603,7 +700,8 @@
 	struct snd_pcm *pcm;
 	int err;
 
-	if ((err = snd_pcm_new(chip->card, "ALS4000 DSP", device, 1, 1, &pcm)) < 0)
+	err = snd_pcm_new(chip->card, "ALS4000 DSP", device, 1, 1, &pcm);
+	if (err < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX;
@@ -637,34 +735,38 @@
 		cfg1 |= (game_io | 1) << 16;
 	if (opl_io > 0)
 		cfg1 |= (opl_io | 1);
-	snd_als4000_gcr_write_addr(iobase, ALS4K_GCR_A8_LEGACY_CFG1, cfg1);
-	snd_als4000_gcr_write_addr(iobase, ALS4K_GCR_A9_LEGACY_CFG2, cfg2);
+	snd_als4k_gcr_write_addr(iobase, ALS4K_GCRA8_LEGACY_CFG1, cfg1);
+	snd_als4k_gcr_write_addr(iobase, ALS4K_GCRA9_LEGACY_CFG2, cfg2);
 }
 
 static void snd_als4000_configure(struct snd_sb *chip)
 {
-	unsigned tmp;
+	u8 tmp;
 	int i;
 
 	/* do some more configuration */
 	spin_lock_irq(&chip->mixer_lock);
-	tmp = snd_sbmixer_read(chip, 0xc0);
-	snd_sbmixer_write(chip, 0xc0, tmp|0x80);
-	/* always select DMA channel 0, since we do not actually use DMA */
+	tmp = snd_als4_cr_read(chip, ALS4K_CR0_SB_CONFIG);
+	snd_als4_cr_write(chip, ALS4K_CR0_SB_CONFIG,
+				tmp|ALS4K_CR0_MX80_81_REG_WRITE_ENABLE);
+	/* always select DMA channel 0, since we do not actually use DMA
+	 * SPECS_PAGE: 19/20 */
 	snd_sbmixer_write(chip, SB_DSP4_DMASETUP, SB_DMASETUP_DMA0);
-	snd_sbmixer_write(chip, 0xc0, tmp&0x7f);
+	snd_als4_cr_write(chip, ALS4K_CR0_SB_CONFIG,
+				 tmp & ~ALS4K_CR0_MX80_81_REG_WRITE_ENABLE);
 	spin_unlock_irq(&chip->mixer_lock);
 	
 	spin_lock_irq(&chip->reg_lock);
 	/* enable interrupts */
-	snd_als4000_gcr_write(chip, ALS4K_GCR_8C_MISC_CTRL,
-					 ALS4K_GCR_8C_IRQ_MASK_CTRL_ENABLE);
+	snd_als4k_gcr_write(chip, ALS4K_GCR8C_MISC_CTRL,
+					ALS4K_GCR8C_IRQ_MASK_CTRL_ENABLE);
 
-	for (i = ALS4K_GCR_91_DMA0_ADDR; i <= ALS4K_GCR_96_DMA3_MODE_COUNT; ++i)
-		snd_als4000_gcr_write(chip, i, 0);
+	/* SPECS_PAGE: 39 */
+	for (i = ALS4K_GCR91_DMA0_ADDR; i <= ALS4K_GCR96_DMA3_MODE_COUNT; ++i)
+		snd_als4k_gcr_write(chip, i, 0);
 	
-	snd_als4000_gcr_write(chip, ALS4K_GCR_99_DMA_EMULATION_CTRL,
-		snd_als4000_gcr_read(chip, ALS4K_GCR_99_DMA_EMULATION_CTRL));
+	snd_als4k_gcr_write(chip, ALS4K_GCR99_DMA_EMULATION_CTRL,
+		snd_als4k_gcr_read(chip, ALS4K_GCR99_DMA_EMULATION_CTRL));
 	spin_unlock_irq(&chip->reg_lock);
 }
 
@@ -739,7 +841,7 @@
 	struct snd_card_als4000 *acard = card->private_data;
 
 	/* make sure that interrupts are disabled */
-	snd_als4000_gcr_write_addr(acard->iobase, ALS4K_GCR_8C_MISC_CTRL, 0);
+	snd_als4k_gcr_write_addr(acard->iobase, ALS4K_GCR8C_MISC_CTRL, 0);
 	/* free resources */
 	snd_als4000_free_gameport(acard);
 	pci_release_regions(acard->pci);
@@ -788,7 +890,7 @@
 	pci_set_master(pci);
 	
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 
-			    sizeof( struct snd_card_als4000 ) );
+			    sizeof(*acard) /* private_data: acard */);
 	if (card == NULL) {
 		pci_release_regions(pci);
 		pci_disable_device(pci);
@@ -806,6 +908,7 @@
 	if ((err = snd_sbdsp_create(card,
 				    iobase + ALS4K_IOB_10_ADLIB_ADDR0,
 				    pci->irq,
+		/* internally registered as IRQF_SHARED in case of ALS4000 SB */
 				    snd_als4000_interrupt,
 				    -1,
 				    -1,
@@ -835,8 +938,10 @@
 		goto out_err;
 	}
 	/* FIXME: ALS4000 has interesting MPU401 configuration features
-	 * at CR 0x1A (pass-thru / UART switching, fast MIDI clock, etc.),
-	 * however there doesn't seem to be an ALSA API for this... */
+	 * at ALS4K_CR1A_MPU401_UART_MODE_CONTROL
+	 * (pass-thru / UART switching, fast MIDI clock, etc.),
+	 * however there doesn't seem to be an ALSA API for this...
+	 * SPECS_PAGE: 21 */
 
 	if ((err = snd_als4000_pcm(chip, 0)) < 0) {
 		goto out_err;



--- include/sound/sb.h.orig	2008-08-21 21:33:01.000000000 +0200
+++ include/sound/sb.h	2008-08-20 20:22:45.000000000 +0200
@@ -240,11 +240,15 @@
 #define SB_DT019X_CAP_MAIN	0x07
 
 #define SB_ALS4000_MONO_IO_CTRL	0x4b
+#define SB_ALS4000_OUT_MIXER_CTRL_2	0x4c
 #define SB_ALS4000_MIC_IN_GAIN	0x4d
+#define SB_ALS4000_ANALOG_REFRNC_VOLT_CTRL 0x4e
 #define SB_ALS4000_FMDAC	0x4f
 #define SB_ALS4000_3D_SND_FX	0x50
 #define SB_ALS4000_3D_TIME_DELAY	0x51
 #define SB_ALS4000_3D_AUTO_MUTE	0x52
+#define SB_ALS4000_ANALOG_BLOCK_CTRL 0x53
+#define SB_ALS4000_3D_DELAYLINE_PATTERN 0x54
 #define SB_ALS4000_QSOUND	0xdb
 
 /* IRQ setting bitmap */
@@ -257,6 +261,7 @@
 #define SB_IRQTYPE_8BIT		0x01
 #define SB_IRQTYPE_16BIT	0x02
 #define SB_IRQTYPE_MPUIN	0x04
+#define ALS4K_IRQTYPE_CR1E_DMA	0x20
 
 /* DMA setting bitmap */
 #define SB_DMASETUP_DMA0	0x01
