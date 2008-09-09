From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 12/24] sound/pci: coding style fixes: intel8x0
Date: Tue, 9 Sep 2008 05:54:35 +0400
Message-ID: <20080909015435.GO6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CA6110380C
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:54:41 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1536051fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:54:40 -0700 (PDT)
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
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/intel8x0.c  |   96 ++++++++++++++++++++++++------------------------
 sound/pci/intel8x0m.c |   62 ++++++++++++++++----------------
 2 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index f7b4d0c..df504de 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -24,9 +24,9 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -268,7 +268,7 @@ enum {
 #define ALI_CSPSR_WRITE_OK	0x01
 
 /* interrupts for the whole chip by interrupt status register finish */
- 
+
 #define ALI_INT_MICIN2		(1<<26)
 #define ALI_INT_PCMIN2		(1<<25)
 #define ALI_INT_I2SIN		(1<<24)
@@ -312,7 +312,7 @@ enum {
 #define ICH_ALI_IF_PO		(1<<1)
 
 /*
- *  
+ *
  */
 
 enum {
@@ -412,7 +412,7 @@ struct intel8x0 {
 	unsigned int codec_ready_bits;
 
 	spinlock_t reg_lock;
-	
+
 	u32 bdbars_count;
 	struct snd_dma_buffer bdbars;
 	u32 int_sta_reg;		/* interrupt status register */
@@ -507,7 +507,7 @@ static inline void iaputword(struct intel8x0 *chip, u32 offset, u16 val)
 static int snd_intel8x0_codec_semaphore(struct intel8x0 *chip, unsigned int codec)
 {
 	int time;
-	
+
 	if (codec > 2)
 		return -EIO;
 	if (chip->in_sdin_init) {
@@ -542,15 +542,15 @@ static int snd_intel8x0_codec_semaphore(struct intel8x0 *chip, unsigned int code
 	/* I don't care about the semaphore */
 	return -EBUSY;
 }
- 
+
 static void snd_intel8x0_codec_write(struct snd_ac97 *ac97,
 				     unsigned short reg,
 				     unsigned short val)
 {
 	struct intel8x0 *chip = ac97->private_data;
-	
+
 	if (snd_intel8x0_codec_semaphore(chip, ac97->num) < 0) {
-		if (! chip->in_ac97_init)
+		if (!chip->in_ac97_init)
 			snd_printk(KERN_ERR "codec_write %d: semaphore is not ready for register 0x%x\n", ac97->num, reg);
 	}
 	iaputword(chip, reg + ac97->num * 0x80, val);
@@ -564,7 +564,7 @@ static unsigned short snd_intel8x0_codec_read(struct snd_ac97 *ac97,
 	unsigned int tmp;
 
 	if (snd_intel8x0_codec_semaphore(chip, ac97->num) < 0) {
-		if (! chip->in_ac97_init)
+		if (!chip->in_ac97_init)
 			snd_printk(KERN_ERR "codec_read %d: semaphore is not ready for register 0x%x\n", ac97->num, reg);
 		res = 0xffff;
 	} else {
@@ -573,7 +573,7 @@ static unsigned short snd_intel8x0_codec_read(struct snd_ac97 *ac97,
 			/* reset RCS and preserve other R/WC bits */
 			iputdword(chip, ICHREG(GLOB_STA), tmp &
 				  ~(chip->codec_ready_bits | ICH_GSCI));
-			if (! chip->in_ac97_init)
+			if (!chip->in_ac97_init)
 				snd_printk(KERN_ERR "codec_read %d: read timeout for register 0x%x\n", ac97->num, reg);
 			res = 0xffff;
 		}
@@ -607,7 +607,7 @@ static int snd_intel8x0_ali_codec_ready(struct intel8x0 *chip, int mask)
 		if (val & mask)
 			return 0;
 	}
-	if (! chip->in_ac97_init)
+	if (!chip->in_ac97_init)
 		snd_printd(KERN_WARNING "intel8x0: AC97 codec ready timeout.\n");
 	return -EBUSY;
 }
@@ -619,7 +619,7 @@ static int snd_intel8x0_ali_codec_semaphore(struct intel8x0 *chip)
 		return 0; /* just ignore ... */
 	while (time-- && (igetdword(chip, ICHREG(ALI_CAS)) & ALI_CAS_SEM_BUSY))
 		udelay(1);
-	if (! time && ! chip->in_ac97_init)
+	if (!time && !chip->in_ac97_init)
 		snd_printk(KERN_WARNING "ali_codec_semaphore timeout\n");
 	return snd_intel8x0_ali_codec_ready(chip, ALI_CSPSR_CODEC_READY);
 }
@@ -638,7 +638,7 @@ static unsigned short snd_intel8x0_ali_codec_read(struct snd_ac97 *ac97, unsigne
 	if (snd_intel8x0_ali_codec_ready(chip, ALI_CSPSR_READ_OK))
 		goto __err;
 	data = igetword(chip, ICHREG(ALI_SPR));
- __err:
+__err:
 	return data;
 }
 
@@ -660,7 +660,7 @@ static void snd_intel8x0_ali_codec_write(struct snd_ac97 *ac97, unsigned short r
 /*
  * DMA I/O
  */
-static void snd_intel8x0_setup_periods(struct intel8x0 *chip, struct ichdev *ichdev) 
+static void snd_intel8x0_setup_periods(struct intel8x0 *chip, struct ichdev *ichdev)
 {
 	int idx;
 	u32 *bdbar = ichdev->bdbar;
@@ -744,7 +744,7 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
 	if (!(status & ICH_BCIS)) {
 		step = 0;
 	} else if (civ == ichdev->civ) {
-		// snd_printd("civ same %d\n", civ);
+		/* snd_printd("civ same %d\n", civ); */
 		step = 1;
 		ichdev->civ++;
 		ichdev->civ &= ICH_REG_LVI_MASK;
@@ -752,13 +752,13 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
 		step = civ - ichdev->civ;
 		if (step < 0)
 			step += ICH_REG_LVI_MASK + 1;
-		// if (step != 1)
-		//	snd_printd("step = %d, %d -> %d\n", step, ichdev->civ, civ);
+		/* if (step != 1) */
+		/*	snd_printd("step = %d, %d -> %d\n", step, ichdev->civ, civ); */
 		ichdev->civ = civ;
 	}
 
 	ichdev->position += step * ichdev->fragsize1;
-	if (! chip->in_measurement)
+	if (!chip->in_measurement)
 		ichdev->position %= ichdev->size;
 	ichdev->lvi += step;
 	ichdev->lvi &= ICH_REG_LVI_MASK;
@@ -801,7 +801,7 @@ static irqreturn_t snd_intel8x0_interrupt(int irq, void *dev_id)
 		if (status) {
 			/* ack */
 			iputdword(chip, chip->int_sta_reg, status);
-			if (! chip->buggy_irq)
+			if (!chip->buggy_irq)
 				status = 0;
 		}
 		return IRQ_RETVAL(status);
@@ -815,7 +815,7 @@ static irqreturn_t snd_intel8x0_interrupt(int irq, void *dev_id)
 
 	/* ack them */
 	iputdword(chip, chip->int_sta_reg, status & chip->int_sta_mask);
-	
+
 	return IRQ_HANDLED;
 }
 
@@ -855,7 +855,7 @@ static int snd_intel8x0_pcm_trigger(struct snd_pcm_substream *substream, int cmd
 	iputbyte(chip, port + ICH_REG_OFF_CR, val);
 	if (cmd == SNDRV_PCM_TRIGGER_STOP) {
 		/* wait until DMA stopped */
-		while (!(igetbyte(chip, port + ichdev->roff_sr) & ICH_DCH)) ;
+		while (!(igetbyte(chip, port + ichdev->roff_sr) & ICH_DCH));
 		/* reset whole DMA things */
 		iputbyte(chip, port + ICH_REG_OFF_CR, ICH_RESETREGS);
 	}
@@ -882,8 +882,8 @@ static int snd_intel8x0_ali_trigger(struct snd_pcm_substream *substream, int cmd
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			/* clear FIFO for synchronization of channels */
 			fifo = igetdword(chip, fiforeg[ichdev->ali_slot / 4]);
-			fifo &= ~(0xff << (ichdev->ali_slot % 4));  
-			fifo |= 0x83 << (ichdev->ali_slot % 4); 
+			fifo &= ~(0xff << (ichdev->ali_slot % 4));
+			fifo |= 0x83 << (ichdev->ali_slot % 4);
 			iputdword(chip, fiforeg[ichdev->ali_slot / 4], fifo);
 		}
 		iputbyte(chip, port + ICH_REG_OFF_CR, ICH_IOCE);
@@ -934,7 +934,7 @@ static int snd_intel8x0_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 	if (chip->fix_nocache) {
-		if (runtime->dma_area && ! ichdev->page_attr_changed) {
+		if (runtime->dma_area && !ichdev->page_attr_changed) {
 			fill_nocache(runtime->dma_area, runtime->dma_bytes, 1);
 			ichdev->page_attr_changed = 1;
 		}
@@ -1295,7 +1295,7 @@ static int snd_intel8x0_ali_ac97spdifout_close(struct snd_pcm_substream *substre
 	return 0;
 }
 
-#if 0 // NYI
+#if 0 /* NYI */
 static int snd_intel8x0_ali_spdifin_open(struct snd_pcm_substream *substream)
 {
 	struct intel8x0 *chip = snd_pcm_substream_chip(substream);
@@ -1437,7 +1437,7 @@ static struct snd_pcm_ops snd_intel8x0_ali_ac97spdifout_ops = {
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-#if 0 // NYI
+#if 0 /* NYI */
 static struct snd_pcm_ops snd_intel8x0_ali_spdifin_ops = {
 	.open =		snd_intel8x0_ali_spdifin_open,
 	.close =	snd_intel8x0_ali_spdifin_close,
@@ -1459,7 +1459,7 @@ static struct snd_pcm_ops snd_intel8x0_ali_spdifout_ops = {
 	.trigger =	snd_intel8x0_pcm_trigger,
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
-#endif // NYI
+#endif /* NYI */
 
 struct ich_pcm_table {
 	char *suffix;
@@ -1589,7 +1589,7 @@ static struct ich_pcm_table ali_pcms[] __devinitdata = {
 		.prealloc_max_size = 128 * 1024,
 		.ac97_idx = ALID_AC97SPDIFOUT,
 	},
-#if 0 // NYI
+#if 0 /* NYI */
 	{
 		.suffix = "HW IEC958",
 		.playback_ops = &snd_intel8x0_ali_spdifout_ops,
@@ -1632,7 +1632,7 @@ static int __devinit snd_intel8x0_pcm(struct intel8x0 *chip)
 		rec = tbl + i;
 		if (i > 0 && rec->ac97_idx) {
 			/* activate PCM only when associated AC'97 codec */
-			if (! chip->ichd[rec->ac97_idx].pcm)
+			if (!chip->ichd[rec->ac97_idx].pcm)
 				continue;
 		}
 		err = snd_intel8x0_pcm1(chip, device, rec);
@@ -1644,7 +1644,7 @@ static int __devinit snd_intel8x0_pcm(struct intel8x0 *chip)
 	chip->pcm_devs = device;
 	return 0;
 }
-	
+
 
 /*
  *  Mixer part
@@ -2119,7 +2119,7 @@ static int __devinit snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 	}
 
 	chip->in_ac97_init = 1;
-	
+
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
 	ac97.private_free = snd_intel8x0_mixer_free_ac97;
@@ -2132,7 +2132,7 @@ static int __devinit snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 		chip->in_sdin_init = 1;
 		codecs = 0;
 		for (i = 0; i < chip->max_codecs; i++) {
-			if (! (glob_sta & chip->codec_bit[i]))
+			if (!(glob_sta & chip->codec_bit[i]))
 				continue;
 			if (chip->device_type == DEVICE_INTEL_ICH4) {
 				snd_intel8x0_codec_read_test(chip, codecs);
@@ -2145,7 +2145,7 @@ static int __devinit snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 			codecs++;
 		}
 		chip->in_sdin_init = 0;
-		if (! codecs)
+		if (!codecs)
 			codecs = 1;
 	} else {
 		ops = &ali_bus_ops;
@@ -2256,7 +2256,7 @@ static int __devinit snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 	chip->in_ac97_init = 0;
 	return 0;
 
- __err:
+__err:
 	/* clear the cold-reset bit for the next chance */
 	if (chip->device_type != DEVICE_ALI)
 		iputdword(chip, ICHREG(GLOB_CNT),
@@ -2285,7 +2285,7 @@ static int snd_intel8x0_ich_chip_init(struct intel8x0 *chip, int probing)
 {
 	unsigned long end_time;
 	unsigned int cnt, status, nstatus;
-	
+
 	/* put logic to right state */
 	/* first clear status bits */
 	status = ICH_RCS | ICH_MCINT | ICH_POINT | ICH_PIINT;
@@ -2320,7 +2320,7 @@ static int snd_intel8x0_ich_chip_init(struct intel8x0 *chip, int probing)
 		   igetdword(chip, ICHREG(GLOB_CNT)));
 	return -EIO;
 
-      __ok:
+__ok:
 #endif
 	if (probing) {
 		/* wait for any codec ready status.
@@ -2335,7 +2335,7 @@ static int snd_intel8x0_ich_chip_init(struct intel8x0 *chip, int probing)
 				break;
 			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
-		if (! status) {
+		if (!status) {
 			/* no codec is found */
 			snd_printk(KERN_ERR "codec_ready: codec is not ready [0x%x]\n",
 				   igetdword(chip, ICHREG(GLOB_STA)));
@@ -2397,7 +2397,7 @@ static int snd_intel8x0_ali_chip_init(struct intel8x0 *chip, int probing)
 	iputdword(chip, ICHREG(ALI_SCR), reg);
 
 	for (i = 0; i < HZ / 2; i++) {
-		if (! (igetdword(chip, ICHREG(ALI_INTERRUPTSR)) & ALI_INT_GPIO))
+		if (!(igetdword(chip, ICHREG(ALI_INTERRUPTSR)) & ALI_INT_GPIO))
 			goto __ok;
 		schedule_timeout_uninterruptible(1);
 	}
@@ -2405,7 +2405,7 @@ static int snd_intel8x0_ali_chip_init(struct intel8x0 *chip, int probing)
 	if (probing)
 		return -EIO;
 
- __ok:
+__ok:
 	for (i = 0; i < HZ / 2; i++) {
 		reg = igetdword(chip, ICHREG(ALI_RTSR));
 		if (reg & 0x80) /* primary codec */
@@ -2422,7 +2422,7 @@ static int snd_intel8x0_chip_init(struct intel8x0 *chip, int probing)
 {
 	unsigned int i, timeout;
 	int err;
-	
+
 	if (chip->device_type != DEVICE_ALI) {
 		if ((err = snd_intel8x0_ich_chip_init(chip, probing)) < 0)
 			return err;
@@ -2475,7 +2475,7 @@ static int snd_intel8x0_free(struct intel8x0 *chip)
 	}
 	/* --- */
 
-      __hw_end:
+__hw_end:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
 	if (chip->bdbars.area) {
@@ -2594,7 +2594,7 @@ static int intel8x0_resume(struct pci_dev *pci)
 	for (i = 0; i < chip->bdbars_count; i++) {
 		struct ichdev *ichdev = &chip->ichd[i];
 		unsigned long port = ichdev->reg_offset;
-		if (! ichdev->substream || ! ichdev->suspended)
+		if (!ichdev->substream || !ichdev->suspended)
 			continue;
 		if (ichdev->ichd == ICHD_PCMOUT)
 			snd_intel8x0_setup_pcm_out(chip, ichdev->substream->runtime);
@@ -2623,7 +2623,7 @@ static void __devinit intel8x0_measure_ac97_clock(struct intel8x0 *chip)
 		return; /* specified in module option */
 
 	subs = chip->pcm[0]->streams[0].substream;
-	if (! subs || subs->dma_buffer.bytes < INTEL8X0_TESTBUF_SIZE) {
+	if (!subs || subs->dma_buffer.bytes < INTEL8X0_TESTBUF_SIZE) {
 		snd_printk(KERN_WARNING "no playback buffer allocated - aborting measure ac97 clock\n");
 		return;
 	}
@@ -2682,7 +2682,7 @@ static void __devinit intel8x0_measure_ac97_clock(struct intel8x0 *chip)
 	}
 	pos = (pos / 4) * 1000;
 	pos = (pos / t) * 1000 + ((pos % t) * 1000) / t;
-	if (pos < 40000 || pos >= 60000) 
+	if (pos < 40000 || pos >= 60000)
 		/* abnormal value. hw problem? */
 		printk(KERN_INFO "intel8x0: measured clock %ld rejected\n", pos);
 	else if (pos < 47500 || pos > 48500)
@@ -2749,11 +2749,11 @@ static void snd_intel8x0_proc_read(struct snd_info_entry * entry,
 			chip->ac97_sdin[2]);
 }
 
-static void __devinit snd_intel8x0_proc_init(struct intel8x0 * chip)
+static void __devinit snd_intel8x0_proc_init(struct intel8x0 *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "intel8x0", &entry))
+	if (!snd_card_proc_new(chip->card, "intel8x0", &entry))
 		snd_info_set_text_ops(entry, chip, snd_intel8x0_proc_read);
 }
 #else
@@ -3102,7 +3102,7 @@ static int __devinit snd_intel8x0_probe(struct pci_dev *pci,
 		snd_card_free(card);
 		return err;
 	}
-	
+
 	snd_intel8x0_proc_init(chip);
 
 	snprintf(card->longname, sizeof(card->longname),
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 93449e4..d3ee592 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -21,9 +21,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -157,7 +157,7 @@ DEFINE_REGSET(OFF, 0);		/* offset */
 
 
 /*
- *  
+ *
  */
 
 enum { ICHD_MDMIN, ICHD_MDMOUT, ICHD_MDMLAST = ICHD_MDMOUT };
@@ -211,7 +211,7 @@ struct intel8x0m {
 	struct snd_ac97 *ac97;
 
 	spinlock_t reg_lock;
-	
+
 	struct snd_dma_buffer bdbars;
 	u32 bdbars_count;
 	u32 int_sta_reg;		/* interrupt status register */
@@ -314,7 +314,7 @@ static unsigned int get_ich_codec_bit(struct intel8x0m *chip, unsigned int codec
 static int snd_intel8x0m_codec_semaphore(struct intel8x0m *chip, unsigned int codec)
 {
 	int time;
-	
+
 	if (codec > 1)
 		return -EIO;
 	codec = get_ich_codec_bit(chip, codec);
@@ -340,15 +340,15 @@ static int snd_intel8x0m_codec_semaphore(struct intel8x0m *chip, unsigned int co
 	/* I don't care about the semaphore */
 	return -EBUSY;
 }
- 
+
 static void snd_intel8x0_codec_write(struct snd_ac97 *ac97,
 				     unsigned short reg,
 				     unsigned short val)
 {
 	struct intel8x0m *chip = ac97->private_data;
-	
+
 	if (snd_intel8x0m_codec_semaphore(chip, ac97->num) < 0) {
-		if (! chip->in_ac97_init)
+		if (!chip->in_ac97_init)
 			snd_printk(KERN_ERR "codec_write %d: semaphore is not ready for register 0x%x\n", ac97->num, reg);
 	}
 	iaputword(chip, reg + ac97->num * 0x80, val);
@@ -362,7 +362,7 @@ static unsigned short snd_intel8x0_codec_read(struct snd_ac97 *ac97,
 	unsigned int tmp;
 
 	if (snd_intel8x0m_codec_semaphore(chip, ac97->num) < 0) {
-		if (! chip->in_ac97_init)
+		if (!chip->in_ac97_init)
 			snd_printk(KERN_ERR "codec_read %d: semaphore is not ready for register 0x%x\n", ac97->num, reg);
 		res = 0xffff;
 	} else {
@@ -371,7 +371,7 @@ static unsigned short snd_intel8x0_codec_read(struct snd_ac97 *ac97,
 			/* reset RCS and preserve other R/WC bits */
 			iputdword(chip, ICHREG(GLOB_STA),
 				  tmp & ~(ICH_SRI|ICH_PRI|ICH_TRI|ICH_GSCI));
-			if (! chip->in_ac97_init)
+			if (!chip->in_ac97_init)
 				snd_printk(KERN_ERR "codec_read %d: read timeout for register 0x%x\n", ac97->num, reg);
 			res = 0xffff;
 		}
@@ -385,7 +385,7 @@ static unsigned short snd_intel8x0_codec_read(struct snd_ac97 *ac97,
 /*
  * DMA I/O
  */
-static void snd_intel8x0_setup_periods(struct intel8x0m *chip, struct ichdev *ichdev) 
+static void snd_intel8x0_setup_periods(struct intel8x0m *chip, struct ichdev *ichdev)
 {
 	int idx;
 	u32 *bdbar = ichdev->bdbar;
@@ -411,7 +411,7 @@ static void snd_intel8x0_setup_periods(struct intel8x0m *chip, struct ichdev *ic
 			bdbar[idx + 0] = cpu_to_le32(ichdev->physbuf + (((idx >> 1) * ichdev->fragsize) % ichdev->size));
 			bdbar[idx + 1] = cpu_to_le32(0x80000000 | /* interrupt on completion */
 						     ichdev->fragsize >> chip->pcm_pos_shift);
-			// printk("bdbar[%i] = 0x%x [0x%x]\n", idx + 0, bdbar[idx + 0], bdbar[idx + 1]);
+			/* printk("bdbar[%i] = 0x%x [0x%x]\n", idx + 0, bdbar[idx + 0], bdbar[idx + 1]); */
 		}
 		ichdev->frags = ichdev->size / ichdev->fragsize;
 	}
@@ -440,7 +440,7 @@ static inline void snd_intel8x0_update(struct intel8x0m *chip, struct ichdev *ic
 
 	civ = igetbyte(chip, port + ICH_REG_OFF_CIV);
 	if (civ == ichdev->civ) {
-		// snd_printd("civ same %d\n", civ);
+		/* snd_printd("civ same %d\n", civ); */
 		step = 1;
 		ichdev->civ++;
 		ichdev->civ &= ICH_REG_LVI_MASK;
@@ -448,8 +448,8 @@ static inline void snd_intel8x0_update(struct intel8x0m *chip, struct ichdev *ic
 		step = civ - ichdev->civ;
 		if (step < 0)
 			step += ICH_REG_LVI_MASK + 1;
-		// if (step != 1)
-		//	snd_printd("step = %d, %d -> %d\n", step, ichdev->civ, civ);
+		/* if (step != 1) */
+		/*	snd_printd("step = %d, %d -> %d\n", step, ichdev->civ, civ); */
 		ichdev->civ = civ;
 	}
 
@@ -512,7 +512,7 @@ static irqreturn_t snd_intel8x0_interrupt(int irq, void *dev_id)
 	/* ack them */
 	iputdword(chip, chip->int_sta_reg, status & chip->int_sta_mask);
 	spin_unlock(&chip->reg_lock);
-	
+
 	return IRQ_HANDLED;
 }
 
@@ -548,7 +548,7 @@ static int snd_intel8x0_pcm_trigger(struct snd_pcm_substream *substream, int cmd
 	iputbyte(chip, port + ICH_REG_OFF_CR, val);
 	if (cmd == SNDRV_PCM_TRIGGER_STOP) {
 		/* wait until DMA stopped */
-		while (!(igetbyte(chip, port + ichdev->roff_sr) & ICH_DCH)) ;
+		while (!(igetbyte(chip, port + ichdev->roff_sr) & ICH_DCH));
 		/* reset whole DMA things */
 		iputbyte(chip, port + ICH_REG_OFF_CR, ICH_RESETREGS);
 	}
@@ -635,7 +635,7 @@ static int snd_intel8x0m_pcm_open(struct snd_pcm_substream *substream, struct ic
 	runtime->hw = snd_intel8x0m_stream;
 	err = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 					 &hw_constraints_rates);
-	if ( err < 0 )
+	if (err < 0)
 		return err;
 	runtime->private_data = ichdev;
 	return 0;
@@ -782,7 +782,7 @@ static int __devinit snd_intel8x0_pcm(struct intel8x0m *chip)
 		rec = tbl + i;
 		if (i > 0 && rec->ac97_idx) {
 			/* activate PCM only when associated AC'97 codec */
-			if (! chip->ichd[rec->ac97_idx].ac97)
+			if (!chip->ichd[rec->ac97_idx].ac97)
 				continue;
 		}
 		err = snd_intel8x0_pcm1(chip, device, rec);
@@ -794,7 +794,7 @@ static int __devinit snd_intel8x0_pcm(struct intel8x0m *chip)
 	chip->pcm_devs = device;
 	return 0;
 }
-	
+
 
 /*
  *  Mixer part
@@ -826,7 +826,7 @@ static int __devinit snd_intel8x0_mixer(struct intel8x0m *chip, int ac97_clock)
 	};
 
 	chip->in_ac97_init = 1;
-	
+
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
 	ac97.private_free = snd_intel8x0_mixer_free_ac97;
@@ -850,7 +850,7 @@ static int __devinit snd_intel8x0_mixer(struct intel8x0m *chip, int ac97_clock)
 		return err;
 	}
 	chip->ac97 = x97;
-	if(ac97_is_modem(x97) && !chip->ichd[ICHD_MDMIN].ac97) {
+	if (ac97_is_modem(x97) && !chip->ichd[ICHD_MDMIN].ac97) {
 		chip->ichd[ICHD_MDMIN].ac97 = x97;
 		chip->ichd[ICHD_MDMOUT].ac97 = x97;
 	}
@@ -858,7 +858,7 @@ static int __devinit snd_intel8x0_mixer(struct intel8x0m *chip, int ac97_clock)
 	chip->in_ac97_init = 0;
 	return 0;
 
- __err:
+__err:
 	/* clear the cold-reset bit for the next chance */
 	if (chip->device_type != DEVICE_ALI)
 		iputdword(chip, ICHREG(GLOB_CNT),
@@ -875,7 +875,7 @@ static int snd_intel8x0m_ich_chip_init(struct intel8x0m *chip, int probing)
 {
 	unsigned long end_time;
 	unsigned int cnt, status, nstatus;
-	
+
 	/* put logic to right state */
 	/* first clear status bits */
 	status = ICH_RCS | ICH_MIINT | ICH_MOINT;
@@ -898,7 +898,7 @@ static int snd_intel8x0m_ich_chip_init(struct intel8x0m *chip, int probing)
 		   igetdword(chip, ICHREG(GLOB_CNT)));
 	return -EIO;
 
-      __ok:
+__ok:
 	if (probing) {
 		/* wait for any codec ready status.
 		 * Once it becomes ready it should remain ready
@@ -912,7 +912,7 @@ static int snd_intel8x0m_ich_chip_init(struct intel8x0m *chip, int probing)
 				break;
 			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
-		if (! status) {
+		if (!status) {
 			/* no codec is found */
 			snd_printk(KERN_ERR "codec_ready: codec is not ready [0x%x]\n",
 				   igetdword(chip, ICHREG(GLOB_STA)));
@@ -957,7 +957,7 @@ static int snd_intel8x0_chip_init(struct intel8x0m *chip, int probing)
 {
 	unsigned int i;
 	int err;
-	
+
 	if ((err = snd_intel8x0m_ich_chip_init(chip, probing)) < 0)
 		return err;
 	iagetword(chip, 0);	/* clear semaphore flag */
@@ -986,7 +986,7 @@ static int snd_intel8x0_free(struct intel8x0m *chip)
 	/* reset channels */
 	for (i = 0; i < chip->bdbars_count; i++)
 		iputbyte(chip, ICH_REG_OFF_CR + chip->ichd[i].reg_offset, ICH_RESETREGS);
- __hw_end:
+__hw_end:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
 	if (chip->bdbars.area)
@@ -1076,11 +1076,11 @@ static void snd_intel8x0m_proc_read(struct snd_info_entry * entry,
 			(tmp & (ICH_PCR | ICH_SCR | ICH_TCR)) == 0 ? " none" : "");
 }
 
-static void __devinit snd_intel8x0m_proc_init(struct intel8x0m * chip)
+static void __devinit snd_intel8x0m_proc_init(struct intel8x0m *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "intel8x0m", &entry))
+	if (!snd_card_proc_new(chip->card, "intel8x0m", &entry))
 		snd_info_set_text_ops(entry, chip, snd_intel8x0m_proc_read);
 }
 #else /* !CONFIG_PROC_FS */
@@ -1297,7 +1297,7 @@ static int __devinit snd_intel8x0m_probe(struct pci_dev *pci,
 		snd_card_free(card);
 		return err;
 	}
-	
+
 	snd_intel8x0m_proc_init(chip);
 
 	sprintf(card->longname, "%s at irq %i",
