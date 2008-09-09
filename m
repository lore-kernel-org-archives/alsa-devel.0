From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 14/24] sound/pci: coding style fixes: maestro3
Date: Tue, 9 Sep 2008 05:56:07 +0400
Message-ID: <20080909015607.GQ6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A45210380D
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:56:12 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1536408fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:56:12 -0700 (PDT)
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

 sound/pci/maestro3.c |  130 +++++++++++++++++++++++++-------------------------
 1 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 9ff3f9e..0aae83b 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -27,11 +27,11 @@
  *     - Added Canyon3D-2 support by Rob Riggs <rob@pangalactic.org>
  *
  */
- 
+
 #define CARD_NAME "ESS Maestro3/Allegro/Canyon3D-2"
 #define DRIVER_NAME "Maestro3"
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -569,7 +569,7 @@ MODULE_PARM_DESC(amp_gpio, "GPIO pin number for external amp. (default = -1)");
 #define KDATA_ADC2_LEFT_SUR_VOL			(KDATA_BASE_ADDR + 0x0045)
 #define KDATA_ADC2_RIGHT_SUR_VOL		(KDATA_BASE_ADDR + 0x0046)
 
-#define KDATA_CD_XFER0					(KDATA_BASE_ADDR + 0x0047)					
+#define KDATA_CD_XFER0					(KDATA_BASE_ADDR + 0x0047)
 #define KDATA_CD_XFER_ENDMARK			(KDATA_BASE_ADDR + 0x0048)
 #define KDATA_CD_LEFT_VOLUME			(KDATA_BASE_ADDR + 0x0049)
 #define KDATA_CD_RIGHT_VOLUME			(KDATA_BASE_ADDR + 0x004A)
@@ -727,9 +727,9 @@ MODULE_PARM_DESC(amp_gpio, "GPIO pin number for external amp. (default = -1)");
 #define SRC3_TEMP_INBUF_ADDR_OFFSET     (CDATA_HEADER_LEN + 16)
 #define SRC3_TEMP_OUTBUF_ADDR_OFFSET    (CDATA_HEADER_LEN + 17)
 
-#define MINISRC_IN_BUFFER_SIZE   ( 0x50 * 2 )
+#define MINISRC_IN_BUFFER_SIZE   ( 0x50 * 2)
 #define MINISRC_OUT_BUFFER_SIZE  ( 0x50 * 2 * 2)
-#define MINISRC_TMP_BUFFER_SIZE  ( 112 + ( MINISRC_BIQUAD_STAGE * 3 + 4 ) * 2 * 2 )
+#define MINISRC_TMP_BUFFER_SIZE  ( 112 + ( MINISRC_BIQUAD_STAGE * 3 + 4 ) * 2 * 2)
 #define MINISRC_BIQUAD_STAGE    2
 #define MINISRC_COEF_LOC          0x175
 
@@ -762,10 +762,10 @@ MODULE_PARM_DESC(amp_gpio, "GPIO pin number for external amp. (default = -1)");
 /*
  * an arbitrary volume we set the internal
  * volume settings to so that the ac97 volume
- * range is a little less insane.  0x7fff is 
+ * range is a little less insane.  0x7fff is
  * max.
  */
-#define ARB_VOLUME ( 0x6800 )
+#define ARB_VOLUME ( 0x6800)
 
 /*
  */
@@ -798,13 +798,13 @@ struct m3_dma {
 	struct m3_list *index_list[3];
 
         int in_lists;
-	
+
 	struct list_head list;
 
 };
-    
+
 struct snd_m3 {
-	
+
 	struct snd_card *card;
 
 	unsigned long iobase;
@@ -1077,7 +1077,7 @@ static void snd_m3_remove_list(struct snd_m3 *chip, struct m3_list *list, int in
 static void snd_m3_inc_timer_users(struct snd_m3 *chip)
 {
 	chip->timer_users++;
-	if (chip->timer_users != 1) 
+	if (chip->timer_users != 1)
 		return;
 
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
@@ -1096,7 +1096,7 @@ static void snd_m3_inc_timer_users(struct snd_m3 *chip)
 static void snd_m3_dec_timer_users(struct snd_m3 *chip)
 {
 	chip->timer_users--;
-	if (chip->timer_users > 0)  
+	if (chip->timer_users > 0)
 		return;
 
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
@@ -1120,7 +1120,7 @@ static void snd_m3_dec_timer_users(struct snd_m3 *chip)
 static int snd_m3_pcm_start(struct snd_m3 *chip, struct m3_dma *s,
 			    struct snd_pcm_substream *subs)
 {
-	if (! s || ! subs)
+	if (!s || !subs)
 		return -EINVAL;
 
 	snd_m3_inc_timer_users(chip);
@@ -1147,7 +1147,7 @@ static int snd_m3_pcm_start(struct snd_m3 *chip, struct m3_dma *s,
 static int snd_m3_pcm_stop(struct snd_m3 *chip, struct m3_dma *s,
 			   struct snd_pcm_substream *subs)
 {
-	if (! s || ! subs)
+	if (!s || !subs)
 		return -EINVAL;
 
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
@@ -1157,7 +1157,7 @@ static int snd_m3_pcm_stop(struct snd_m3 *chip, struct m3_dma *s,
 	case SNDRV_PCM_STREAM_PLAYBACK:
 		chip->dacs_active--;
 		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
-				  KDATA_MIXER_TASK_NUMBER, 
+				  KDATA_MIXER_TASK_NUMBER,
 				  chip->dacs_active);
 		break;
 	case SNDRV_PCM_STREAM_CAPTURE:
@@ -1191,7 +1191,7 @@ snd_m3_pcm_trigger(struct snd_pcm_substream *subs, int cmd)
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		if (! s->running)
+		if (!s->running)
 			err = 0; /* should return error? */
 		else {
 			s->running = 0;
@@ -1206,7 +1206,7 @@ snd_m3_pcm_trigger(struct snd_pcm_substream *subs, int cmd)
 /*
  * setup
  */
-static void 
+static void
 snd_m3_pcm_setup1(struct snd_m3 *chip, struct m3_dma *s, struct snd_pcm_substream *subs)
 {
 	int dsp_in_size, dsp_out_size, dsp_in_buffer, dsp_out_buffer;
@@ -1270,7 +1270,7 @@ snd_m3_pcm_setup1(struct snd_m3 *chip, struct m3_dma *s, struct snd_pcm_substrea
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 			  s->inst.data + CDATA_IN_BUF_HEAD,
 			  dsp_in_buffer);
-    
+
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 			  s->inst.data + CDATA_IN_BUF_TAIL,
 			  dsp_in_buffer);
@@ -1297,10 +1297,10 @@ static void snd_m3_pcm_setup2(struct snd_m3 *chip, struct m3_dma *s,
 {
 	u32 freq;
 
-	/* 
+	/*
 	 * put us in the lists if we're not already there
 	 */
-	if (! s->in_lists) {
+	if (!s->in_lists) {
 		s->index[0] = snd_m3_add_list(chip, s->index_list[0],
 					      s->inst.data >> DP_SHIFT_COUNT);
 		s->index[1] = snd_m3_add_list(chip, s->index_list[1],
@@ -1312,16 +1312,16 @@ static void snd_m3_pcm_setup2(struct snd_m3 *chip, struct m3_dma *s,
 
 	/* write to 'mono' word */
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
-			  s->inst.data + SRC3_DIRECTION_OFFSET + 1, 
+			  s->inst.data + SRC3_DIRECTION_OFFSET + 1,
 			  runtime->channels == 2 ? 0 : 1);
 	/* write to '8bit' word */
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
-			  s->inst.data + SRC3_DIRECTION_OFFSET + 2, 
+			  s->inst.data + SRC3_DIRECTION_OFFSET + 2,
 			  snd_pcm_format_width(runtime->format) == 16 ? 0 : 1);
 
 	/* set up dac/adc rate */
 	freq = ((runtime->rate << 15) + 24000 ) / 48000;
-	if (freq) 
+	if (freq)
 		freq--;
 
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
@@ -1380,7 +1380,7 @@ snd_m3_playback_setup(struct snd_m3 *chip, struct m3_dma *s,
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 			  s->inst.data + SRC3_DIRECTION_OFFSET + 22,
 			  subs->runtime->rate > 45000 ? 0xff : 0);
-    
+
 	/* tell it which way dma is going? */
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 			  s->inst.data + CDATA_DMA_CONTROL,
@@ -1389,13 +1389,13 @@ snd_m3_playback_setup(struct snd_m3 *chip, struct m3_dma *s,
 	/*
 	 * set an armload of static initializers
 	 */
-	for (i = 0; i < ARRAY_SIZE(pv); i++) 
+	for (i = 0; i < ARRAY_SIZE(pv); i++)
 		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 				  s->inst.data + pv[i].addr, pv[i].val);
 }
 
 /*
- *    Native record driver 
+ *    Native record driver
  */
 static const struct rec_vals {
 	u16 addr, val;
@@ -1441,13 +1441,13 @@ snd_m3_capture_setup(struct snd_m3 *chip, struct m3_dma *s, struct snd_pcm_subst
 	/* tell it which way dma is going? */
 	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 			  s->inst.data + CDATA_DMA_CONTROL,
-			  DMACONTROL_DIRECTION + DMACONTROL_AUTOREPEAT + 
+			  DMACONTROL_DIRECTION + DMACONTROL_AUTOREPEAT +
 			  DMAC_PAGE3_SELECTOR + DMAC_BLOCKF_SELECTOR);
 
 	/*
 	 * set an armload of static initializers
 	 */
-	for (i = 0; i < ARRAY_SIZE(rv); i++) 
+	for (i = 0; i < ARRAY_SIZE(rv); i++)
 		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 				  s->inst.data + rv[i].addr, rv[i].val);
 }
@@ -1472,7 +1472,7 @@ static int snd_m3_pcm_hw_params(struct snd_pcm_substream *substream,
 static int snd_m3_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct m3_dma *s;
-	
+
 	if (substream->runtime->private_data == NULL)
 		return 0;
 	s = substream->runtime->private_data;
@@ -1567,7 +1567,7 @@ static void snd_m3_update_ptr(struct snd_m3 *chip, struct m3_dma *s)
 	unsigned int hwptr;
 	int diff;
 
-	if (! s->running)
+	if (!s->running)
 		return;
 
 	hwptr = snd_m3_get_pointer(chip, s, subs);
@@ -1764,7 +1764,7 @@ snd_m3_substream_open(struct snd_m3 *chip, struct snd_pcm_substream *subs)
 	spin_lock_irq(&chip->reg_lock);
 	for (i = 0; i < chip->num_substreams; i++) {
 		s = &chip->substreams[i];
-		if (! s->opened)
+		if (!s->opened)
 			goto __found;
 	}
 	spin_unlock_irq(&chip->reg_lock);
@@ -1885,7 +1885,7 @@ static struct snd_pcm_ops snd_m3_capture_ops = {
 };
 
 static int __devinit
-snd_m3_pcm(struct snd_m3 * chip, int device)
+snd_m3_pcm(struct snd_m3 *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1902,7 +1902,7 @@ snd_m3_pcm(struct snd_m3 * chip, int device)
 	pcm->info_flags = 0;
 	strcpy(pcm->name, chip->card->driver);
 	chip->pcm = pcm;
-	
+
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 64*1024);
 
@@ -1923,7 +1923,7 @@ static int snd_m3_ac97_wait(struct snd_m3 *chip)
 	int i = 10000;
 
 	do {
-		if (! (snd_m3_inb(chip, 0x30) & 1))
+		if (!(snd_m3_inb(chip, 0x30) & 1))
 			return 0;
 		cpu_relax();
 	} while (i-- > 0);
@@ -1979,8 +1979,8 @@ static void snd_m3_remote_codec_config(int io, int isremote)
 	     io + SDO_IN_DEST_CTRL);
 }
 
-/* 
- * hack, returns non zero on err 
+/*
+ * hack, returns non zero on err
  */
 static int snd_m3_try_read_vendor(struct snd_m3 *chip)
 {
@@ -2007,9 +2007,9 @@ static void snd_m3_ac97_reset(struct snd_m3 *chip)
 
 	if (chip->allegro_flag) {
 		/*
-		 * the onboard codec on the allegro seems 
+		 * the onboard codec on the allegro seems
 		 * to want to wait a very long time before
-		 * coming back to life 
+		 * coming back to life
 		 */
 		delay1 = 50;
 		delay2 = 800;
@@ -2044,7 +2044,7 @@ static void snd_m3_ac97_reset(struct snd_m3 *chip)
 
 		schedule_timeout_uninterruptible(msecs_to_jiffies(delay2));
 
-		if (! snd_m3_try_read_vendor(chip))
+		if (!snd_m3_try_read_vendor(chip))
 			break;
 
 		delay1 += 10;
@@ -2079,7 +2079,7 @@ static int __devinit snd_m3_mixer(struct snd_m3 *chip)
 
 	if ((err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus)) < 0)
 		return err;
-	
+
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
 	if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97)) < 0)
@@ -2120,7 +2120,7 @@ static void snd_m3_assp_init(struct snd_m3 *chip)
 
 	/* zero kernel data */
 	for (i = 0; i < (REV_B_DATA_MEMORY_UNIT_LENGTH * NUM_UNITS_KERNEL_DATA) / 2; i++)
-		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA, 
+		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 				  KDATA_BASE_ADDR + i, 0);
 
 	/* zero mixer data? */
@@ -2135,8 +2135,8 @@ static void snd_m3_assp_init(struct snd_m3 *chip)
 
 	/* write kernel into code memory.. */
 	data = (const u16 *)chip->assp_kernel_image->data;
-	for (i = 0 ; i * 2 < chip->assp_kernel_image->size; i++) {
-		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE, 
+	for (i = 0; i * 2 < chip->assp_kernel_image->size; i++) {
+		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE,
 				  REV_B_CODE_MEMORY_BEGIN + i,
 				  le16_to_cpu(data[i]));
 	}
@@ -2149,14 +2149,14 @@ static void snd_m3_assp_init(struct snd_m3 *chip)
 	 */
 	data = (const u16 *)chip->assp_minisrc_image->data;
 	for (i = 0; i * 2 < chip->assp_minisrc_image->size; i++) {
-		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE, 
+		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE,
 				  0x400 + i, le16_to_cpu(data[i]));
 	}
 
 	/*
 	 * write the coefficients for the low pass filter?
 	 */
-	for (i = 0; i < MINISRC_LPF_LEN ; i++) {
+	for (i = 0; i < MINISRC_LPF_LEN; i++) {
 		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE,
 				  0x400 + MINISRC_COEF_LOC + i,
 				  minisrc_lpf[i]);
@@ -2170,7 +2170,7 @@ static void snd_m3_assp_init(struct snd_m3 *chip)
 	 * the minisrc is the only thing on
 	 * our task list..
 	 */
-	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA, 
+	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 			  KDATA_TASK0,
 			  0x400);
 
@@ -2206,14 +2206,14 @@ static void snd_m3_assp_init(struct snd_m3 *chip)
 
 static int __devinit snd_m3_assp_client_init(struct snd_m3 *chip, struct m3_dma *s, int index)
 {
-	int data_bytes = 2 * ( MINISRC_TMP_BUFFER_SIZE / 2 + 
+	int data_bytes = 2 * ( MINISRC_TMP_BUFFER_SIZE / 2 +
 			       MINISRC_IN_BUFFER_SIZE / 2 +
-			       1 + MINISRC_OUT_BUFFER_SIZE / 2 + 1 );
+			       1 + MINISRC_OUT_BUFFER_SIZE / 2 + 1);
 	int address, i;
 
 	/*
 	 * the revb memory map has 0x1100 through 0x1c00
-	 * free.  
+	 * free.
 	 */
 
 	/*
@@ -2243,7 +2243,7 @@ static int __devinit snd_m3_assp_client_init(struct snd_m3 *chip, struct m3_dma
 }
 
 
-/* 
+/*
  * this works for the reference board, have to find
  * out about others
  *
@@ -2255,7 +2255,7 @@ snd_m3_amp_enable(struct snd_m3 *chip, int enable)
 	int io = chip->iobase;
 	u16 gpo, polarity;
 
-	if (! chip->external_amp)
+	if (!chip->external_amp)
 		return;
 
 	polarity = enable ? 0 : 1;
@@ -2323,10 +2323,10 @@ snd_m3_chip_init(struct snd_m3 *chip)
 	pci_read_config_dword(pcidev, PCI_ALLEGRO_CONFIG, &n);
 	n &= ~INT_CLK_SELECT;
 	if (!chip->allegro_flag) {
-		n &= ~INT_CLK_MULT_ENABLE; 
+		n &= ~INT_CLK_MULT_ENABLE;
 		n |= INT_CLK_SRC_NOT_PCI;
 	}
-	n &=  ~( CLK_MULT_MODE_SELECT | CLK_MULT_MODE_SELECT_2 );
+	n &=  ~( CLK_MULT_MODE_SELECT | CLK_MULT_MODE_SELECT_2);
 	pci_write_config_dword(pcidev, PCI_ALLEGRO_CONFIG, n);
 
 	if (chip->allegro_flag) {
@@ -2338,11 +2338,11 @@ snd_m3_chip_init(struct snd_m3 *chip)
 	t = inb(chip->iobase + ASSP_CONTROL_A);
 	t &= ~( DSP_CLK_36MHZ_SELECT  | ASSP_CLK_49MHZ_SELECT);
 	t |= ASSP_CLK_49MHZ_SELECT;
-	t |= ASSP_0_WS_ENABLE; 
+	t |= ASSP_0_WS_ENABLE;
 	outb(t, chip->iobase + ASSP_CONTROL_A);
 
 	snd_m3_assp_init(chip); /* download DSP code before starting ASSP below */
-	outb(RUN_ASSP, chip->iobase + ASSP_CONTROL_B); 
+	outb(RUN_ASSP, chip->iobase + ASSP_CONTROL_B);
 
 	outb(0x00, io + HARDWARE_VOL_CTRL);
 	outb(0x88, io + SHADOW_MIX_REG_VOICE);
@@ -2351,7 +2351,7 @@ snd_m3_chip_init(struct snd_m3 *chip)
 	outb(0x88, io + HW_VOL_COUNTER_MASTER);
 
 	return 0;
-} 
+}
 
 static void
 snd_m3_enable_ints(struct snd_m3 *chip)
@@ -2437,7 +2437,7 @@ static int m3_suspend(struct pci_dev *pci, pm_message_t state)
 	for (i = REV_B_CODE_MEMORY_BEGIN; i <= REV_B_CODE_MEMORY_END; i++)
 		chip->suspend_mem[dsp_index++] =
 			snd_m3_assp_read(chip, MEMTYPE_INTERNAL_CODE, i);
-	for (i = REV_B_DATA_MEMORY_BEGIN ; i <= REV_B_DATA_MEMORY_END; i++)
+	for (i = REV_B_DATA_MEMORY_BEGIN; i <= REV_B_DATA_MEMORY_END; i++)
 		chip->suspend_mem[dsp_index++] =
 			snd_m3_assp_read(chip, MEMTYPE_INTERNAL_DATA, i);
 
@@ -2477,14 +2477,14 @@ static int m3_resume(struct pci_dev *pci)
 	/* restore dsp image */
 	dsp_index = 0;
 	for (i = REV_B_CODE_MEMORY_BEGIN; i <= REV_B_CODE_MEMORY_END; i++)
-		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE, i, 
+		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE, i,
 				  chip->suspend_mem[dsp_index++]);
-	for (i = REV_B_DATA_MEMORY_BEGIN ; i <= REV_B_DATA_MEMORY_END; i++)
-		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA, i, 
+	for (i = REV_B_DATA_MEMORY_BEGIN; i <= REV_B_DATA_MEMORY_END; i++)
+		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA, i,
 				  chip->suspend_mem[dsp_index++]);
 
 	/* tell the dma engine to restart itself */
-	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA, 
+	snd_m3_assp_write(chip, MEMTYPE_INTERNAL_DATA,
 			  KDATA_DMA_ACTIVE, 0);
 
         /* restore ac97 registers */
@@ -2614,7 +2614,7 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 		return err;
 	}
 	chip->iobase = pci_resource_start(pci, 0);
-	
+
 	/* just to be sure */
 	pci_set_master(pci);
 
@@ -2659,7 +2659,7 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	if ((err = snd_m3_pcm(chip, 0)) < 0)
 		return err;
-    
+
 	snd_m3_enable_ints(chip);
 	snd_m3_assp_continue(chip);
 
@@ -2667,7 +2667,7 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	*chip_ret = chip;
 
-	return 0; 
+	return 0;
 }
 
 /*
@@ -2758,7 +2758,7 @@ static struct pci_driver driver = {
 	.resume = m3_resume,
 #endif
 };
-	
+
 static int __init alsa_card_m3_init(void)
 {
 	return pci_register_driver(&driver);
