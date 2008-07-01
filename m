From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] wss: use stuct snd_wss instead of
	snd_ad1848
Date: Tue, 1 Jul 2008 20:14:11 +0200
Message-ID: <20080701201411.e7715d83.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 81DBA24436
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 20:10:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org


From: Krzysztof Helt <krzysztof.h1@wp.pl>

The snd_wss is superset of the snd_ad1848 so kill
the latter and replace it with the snd_wss.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
Another step toward unification of all WSS compatible
chips handling.

diff -urp linux-alsa/include/sound/ad1848.h linux-mm/include/sound/ad1848.h
--- linux-alsa/include/sound/ad1848.h	2008-06-15 13:57:46.000000000 +0200
+++ linux-mm/include/sound/ad1848.h	2008-06-30 20:51:00.072617979 +0200
@@ -127,48 +127,22 @@
 #define AD1848_THINKPAD_CTL_PORT2		0x15e9
 #define AD1848_THINKPAD_CS4248_ENABLE_BIT	0x02
 
-struct snd_ad1848 {
-	unsigned long port;		/* i/o port */
-	struct resource *res_port;
-	int irq;			/* IRQ line */
-	int dma;			/* data DMA */
-	unsigned short version;		/* version of CODEC chip */
-	unsigned short mode;		/* see to AD1848_MODE_XXXX */
-	unsigned short hardware;	/* see to AD1848_HW_XXXX */
-	unsigned short single_dma:1;	/* forced single DMA mode (GUS 16-bit daughter board) or dma1 == dma2 */
-
-	struct snd_pcm *pcm;
-	struct snd_pcm_substream *playback_substream;
-	struct snd_pcm_substream *capture_substream;
-	struct snd_card *card;
-
-	unsigned char image[32];	/* SGalaxy needs an access to extended registers */
-	int mce_bit;
-	int calibrate_mute;
-	int dma_size;
-	int thinkpad_flag;		/* Thinkpad CS4248 needs some extra help */
-
-#ifdef CONFIG_PM
-	void (*suspend)(struct snd_ad1848 *chip);
-	void (*resume)(struct snd_ad1848 *chip);
-#endif
-
-	spinlock_t reg_lock;
-};
+#include "wss.h"
 
 /* exported functions */
 
-void snd_ad1848_out(struct snd_ad1848 *chip, unsigned char reg, unsigned char value);
+void snd_ad1848_out(struct snd_wss *chip, unsigned char reg,
+		    unsigned char value);
 
 int snd_ad1848_create(struct snd_card *card,
 		      unsigned long port,
 		      int irq, int dma,
 		      unsigned short hardware,
-		      struct snd_ad1848 ** chip);
+		      struct snd_wss **chip);
 
-int snd_ad1848_pcm(struct snd_ad1848 * chip, int device, struct snd_pcm **rpcm);
+int snd_ad1848_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
 const struct snd_pcm_ops *snd_ad1848_get_pcm_ops(int direction);
-int snd_ad1848_mixer(struct snd_ad1848 * chip);
+int snd_ad1848_mixer(struct snd_wss *chip);
 
 /* exported mixer stuffs */
 enum { AD1848_MIX_SINGLE, AD1848_MIX_DOUBLE, AD1848_MIX_CAPTURE };
@@ -213,6 +187,7 @@ struct ad1848_mix_elem {
   .private_value = AD1848_MIXVAL_DOUBLE(left_reg, right_reg, shift_left, shift_right, mask, invert), \
   .tlv = xtlv }
 
-int snd_ad1848_add_ctl_elem(struct snd_ad1848 *chip, const struct ad1848_mix_elem *c);
+int snd_ad1848_add_ctl_elem(struct snd_wss *chip,
+			    const struct ad1848_mix_elem *c);
 
 #endif /* __SOUND_AD1848_H */
diff -urp linux-alsa/include/sound/wss.h linux-mm/include/sound/wss.h
--- linux-alsa/include/sound/wss.h	2008-06-30 20:44:04.150659912 +0200
+++ linux-mm/include/sound/wss.h	2008-06-30 20:23:37.161281486 +0200
@@ -78,7 +78,8 @@ struct snd_wss {
 	unsigned short hardware;	/* see to WSS_HW_XXXX */
 	unsigned short hwshare;		/* shared resources */
 	unsigned short single_dma:1,	/* forced single DMA mode (GUS 16-bit daughter board) or dma1 == dma2 */
-		       ebus_flag:1;	/* SPARC: EBUS present */
+		       ebus_flag:1,	/* SPARC: EBUS present */
+		       thinkpad_flag:1;	/* Thinkpad CS4248 needs extra help */
 
 	struct snd_card *card;
 	struct snd_pcm *pcm;
diff -urp linux-alsa/sound/isa/ad1848/ad1848.c linux-mm/sound/isa/ad1848/ad1848.c
--- linux-alsa/sound/isa/ad1848/ad1848.c	2008-06-30 20:44:04.202659855 +0200
+++ linux-mm/sound/isa/ad1848/ad1848.c	2008-06-30 21:02:19.840898902 +0200
@@ -87,7 +87,7 @@ static int __devinit snd_ad1848_match(st
 static int __devinit snd_ad1848_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
-	struct snd_ad1848 *chip;
+	struct snd_wss *chip;
 	struct snd_pcm *pcm;
 	int error;
 
@@ -142,7 +142,7 @@ static int __devexit snd_ad1848_remove(s
 static int snd_ad1848_suspend(struct device *dev, unsigned int n, pm_message_t state)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct snd_ad1848 *chip = card->private_data;
+	struct snd_wss *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	chip->suspend(chip);
@@ -152,7 +152,7 @@ static int snd_ad1848_suspend(struct dev
 static int snd_ad1848_resume(struct device *dev, unsigned int n)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct snd_ad1848 *chip = card->private_data;
+	struct snd_wss *chip = card->private_data;
 
 	chip->resume(chip);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
diff -urp linux-alsa/sound/isa/ad1848/ad1848_lib.c linux-mm/sound/isa/ad1848/ad1848_lib.c
--- linux-alsa/sound/isa/ad1848/ad1848_lib.c	2008-06-15 12:11:37.000000000 +0200
+++ linux-mm/sound/isa/ad1848/ad1848_lib.c	2008-06-30 21:06:39.307115291 +0200
@@ -98,7 +98,7 @@ static unsigned char snd_ad1848_original
  *  Basic I/O functions
  */
 
-static void snd_ad1848_wait(struct snd_ad1848 *chip)
+static void snd_ad1848_wait(struct snd_wss *chip)
 {
 	int timeout;
 
@@ -109,7 +109,7 @@ static void snd_ad1848_wait(struct snd_a
 	}
 }
 
-void snd_ad1848_out(struct snd_ad1848 *chip,
+void snd_ad1848_out(struct snd_wss *chip,
 			   unsigned char reg,
 			   unsigned char value)
 {
@@ -128,7 +128,7 @@ void snd_ad1848_out(struct snd_ad1848 *c
 
 EXPORT_SYMBOL(snd_ad1848_out);
 
-static void snd_ad1848_dout(struct snd_ad1848 *chip,
+static void snd_ad1848_dout(struct snd_wss *chip,
 			    unsigned char reg, unsigned char value)
 {
 	snd_ad1848_wait(chip);
@@ -137,7 +137,7 @@ static void snd_ad1848_dout(struct snd_a
 	mb();
 }
 
-static unsigned char snd_ad1848_in(struct snd_ad1848 *chip, unsigned char reg)
+static unsigned char snd_ad1848_in(struct snd_wss *chip, unsigned char reg)
 {
 	snd_ad1848_wait(chip);
 #ifdef CONFIG_SND_DEBUG
@@ -152,7 +152,7 @@ static unsigned char snd_ad1848_in(struc
 
 #if 0
 
-static void snd_ad1848_debug(struct snd_ad1848 *chip)
+static void snd_ad1848_debug(struct snd_wss *chip)
 {
 	printk("AD1848 REGS:      INDEX = 0x%02x  ", inb(AD1848P(chip, REGSEL)));
 	printk("                 STATUS = 0x%02x\n", inb(AD1848P(chip, STATUS)));
@@ -180,7 +180,7 @@ static void snd_ad1848_debug(struct snd_
  *  AD1848 detection / MCE routines
  */
 
-static void snd_ad1848_mce_up(struct snd_ad1848 *chip)
+static void snd_ad1848_mce_up(struct snd_wss *chip)
 {
 	unsigned long flags;
 	int timeout;
@@ -200,7 +200,7 @@ static void snd_ad1848_mce_up(struct snd
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
+static void snd_ad1848_mce_down(struct snd_wss *chip)
 {
 	unsigned long flags, timeout;
 	int reg;
@@ -268,7 +268,7 @@ static unsigned int snd_ad1848_get_count
 	return size;
 }
 
-static int snd_ad1848_trigger(struct snd_ad1848 *chip, unsigned char what,
+static int snd_ad1848_trigger(struct snd_wss *chip, unsigned char what,
 			      int channel, int cmd)
 {
 	int result = 0;
@@ -337,7 +337,7 @@ static unsigned char snd_ad1848_get_form
 	return rformat;
 }
 
-static void snd_ad1848_calibrate_mute(struct snd_ad1848 *chip, int mute)
+static void snd_ad1848_calibrate_mute(struct snd_wss *chip, int mute)
 {
 	unsigned long flags;
 	
@@ -361,7 +361,8 @@ static void snd_ad1848_calibrate_mute(st
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static void snd_ad1848_set_data_format(struct snd_ad1848 *chip, struct snd_pcm_hw_params *hw_params)
+static void snd_ad1848_set_data_format(struct snd_wss *chip,
+				       struct snd_pcm_hw_params *hw_params)
 {
 	if (hw_params == NULL) {
 		chip->image[AD1848_DATA_FORMAT] = 0x20;
@@ -373,7 +374,7 @@ static void snd_ad1848_set_data_format(s
 	// snd_printk(">>> pmode = 0x%x, dfr = 0x%x\n", pstr->mode, chip->image[AD1848_DATA_FORMAT]);
 }
 
-static int snd_ad1848_open(struct snd_ad1848 *chip, unsigned int mode)
+static int snd_ad1848_open(struct snd_wss *chip, unsigned int mode)
 {
 	unsigned long flags;
 
@@ -424,7 +425,7 @@ static int snd_ad1848_open(struct snd_ad
 	return 0;
 }
 
-static void snd_ad1848_close(struct snd_ad1848 *chip)
+static void snd_ad1848_close(struct snd_wss *chip)
 {
 	unsigned long flags;
 
@@ -464,21 +465,21 @@ static void snd_ad1848_close(struct snd_
 static int snd_ad1848_playback_trigger(struct snd_pcm_substream *substream,
 				       int cmd)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	return snd_ad1848_trigger(chip, AD1848_PLAYBACK_ENABLE, SNDRV_PCM_STREAM_PLAYBACK, cmd);
 }
 
 static int snd_ad1848_capture_trigger(struct snd_pcm_substream *substream,
 				      int cmd)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	return snd_ad1848_trigger(chip, AD1848_CAPTURE_ENABLE, SNDRV_PCM_STREAM_CAPTURE, cmd);
 }
 
 static int snd_ad1848_playback_hw_params(struct snd_pcm_substream *substream,
 					 struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	unsigned long flags;
 	int err;
 
@@ -502,15 +503,16 @@ static int snd_ad1848_playback_hw_free(s
 
 static int snd_ad1848_playback_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned long flags;
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
 
-	chip->dma_size = size;
+	chip->p_dma_size = size;
 	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO);
-	snd_dma_program(chip->dma, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
+	snd_dma_program(chip->dma1, runtime->dma_addr, size,
+			DMA_MODE_WRITE | DMA_AUTOINIT);
 	count = snd_ad1848_get_count(chip->image[AD1848_DATA_FORMAT], count) - 1;
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_ad1848_out(chip, AD1848_DATA_LWR_CNT, (unsigned char) count);
@@ -522,7 +524,7 @@ static int snd_ad1848_playback_prepare(s
 static int snd_ad1848_capture_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	unsigned long flags;
 	int err;
 
@@ -546,15 +548,16 @@ static int snd_ad1848_capture_hw_free(st
 
 static int snd_ad1848_capture_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned long flags;
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
 
-	chip->dma_size = size;
+	chip->c_dma_size = size;
 	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO);
-	snd_dma_program(chip->dma, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
+	snd_dma_program(chip->dma2, runtime->dma_addr, size,
+			DMA_MODE_READ | DMA_AUTOINIT);
 	count = snd_ad1848_get_count(chip->image[AD1848_DATA_FORMAT], count) - 1;
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_ad1848_out(chip, AD1848_DATA_LWR_CNT, (unsigned char) count);
@@ -565,7 +568,7 @@ static int snd_ad1848_capture_prepare(st
 
 static irqreturn_t snd_ad1848_interrupt(int irq, void *dev_id)
 {
-	struct snd_ad1848 *chip = dev_id;
+	struct snd_wss *chip = dev_id;
 
 	if ((chip->mode & AD1848_MODE_PLAY) && chip->playback_substream &&
 	    (chip->mode & AD1848_MODE_RUNNING))
@@ -579,23 +582,23 @@ static irqreturn_t snd_ad1848_interrupt(
 
 static snd_pcm_uframes_t snd_ad1848_playback_pointer(struct snd_pcm_substream *substream)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
 	
 	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_PLAYBACK_ENABLE))
 		return 0;
-	ptr = snd_dma_pointer(chip->dma, chip->dma_size);
+	ptr = snd_dma_pointer(chip->dma1, chip->p_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
 static snd_pcm_uframes_t snd_ad1848_capture_pointer(struct snd_pcm_substream *substream)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
 
 	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_CAPTURE_ENABLE))
 		return 0;
-	ptr = snd_dma_pointer(chip->dma, chip->dma_size);
+	ptr = snd_dma_pointer(chip->dma2, chip->c_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -603,8 +606,8 @@ static snd_pcm_uframes_t snd_ad1848_capt
 
  */
 
-static void snd_ad1848_thinkpad_twiddle(struct snd_ad1848 *chip, int on) {
-
+static void snd_ad1848_thinkpad_twiddle(struct snd_wss *chip, int on)
+{
 	int tmp;
 
 	if (!chip->thinkpad_flag) return;
@@ -624,14 +627,14 @@ static void snd_ad1848_thinkpad_twiddle(
 }
 
 #ifdef CONFIG_PM
-static void snd_ad1848_suspend(struct snd_ad1848 *chip)
+static void snd_ad1848_suspend(struct snd_wss *chip)
 {
 	snd_pcm_suspend_all(chip->pcm);
 	if (chip->thinkpad_flag)
 		snd_ad1848_thinkpad_twiddle(chip, 0);
 }
 
-static void snd_ad1848_resume(struct snd_ad1848 *chip)
+static void snd_ad1848_resume(struct snd_wss *chip)
 {
 	int i;
 
@@ -651,7 +654,7 @@ static void snd_ad1848_resume(struct snd
 }
 #endif /* CONFIG_PM */
 
-static int snd_ad1848_probe(struct snd_ad1848 * chip)
+static int snd_ad1848_probe(struct snd_wss *chip)
 {
 	unsigned long flags;
 	int i, id, rev, ad1847;
@@ -775,7 +778,7 @@ static struct snd_pcm_hardware snd_ad184
 
 static int snd_ad1848_playback_open(struct snd_pcm_substream *substream)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
@@ -783,15 +786,15 @@ static int snd_ad1848_playback_open(stru
 		return err;
 	chip->playback_substream = substream;
 	runtime->hw = snd_ad1848_playback;
-	snd_pcm_limit_isa_dma_size(chip->dma, &runtime->hw.buffer_bytes_max);
-	snd_pcm_limit_isa_dma_size(chip->dma, &runtime->hw.period_bytes_max);
+	snd_pcm_limit_isa_dma_size(chip->dma1, &runtime->hw.buffer_bytes_max);
+	snd_pcm_limit_isa_dma_size(chip->dma1, &runtime->hw.period_bytes_max);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
 	return 0;
 }
 
 static int snd_ad1848_capture_open(struct snd_pcm_substream *substream)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
@@ -799,15 +802,15 @@ static int snd_ad1848_capture_open(struc
 		return err;
 	chip->capture_substream = substream;
 	runtime->hw = snd_ad1848_capture;
-	snd_pcm_limit_isa_dma_size(chip->dma, &runtime->hw.buffer_bytes_max);
-	snd_pcm_limit_isa_dma_size(chip->dma, &runtime->hw.period_bytes_max);
+	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.buffer_bytes_max);
+	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.period_bytes_max);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
 	return 0;
 }
 
 static int snd_ad1848_playback_close(struct snd_pcm_substream *substream)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 
 	chip->mode &= ~AD1848_MODE_PLAY;
 	chip->playback_substream = NULL;
@@ -817,7 +820,7 @@ static int snd_ad1848_playback_close(str
 
 static int snd_ad1848_capture_close(struct snd_pcm_substream *substream)
 {
-	struct snd_ad1848 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 
 	chip->mode &= ~AD1848_MODE_CAPTURE;
 	chip->capture_substream = NULL;
@@ -825,14 +828,14 @@ static int snd_ad1848_capture_close(stru
 	return 0;
 }
 
-static int snd_ad1848_free(struct snd_ad1848 *chip)
+static int snd_ad1848_free(struct snd_wss *chip)
 {
 	release_and_free_resource(chip->res_port);
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *) chip);
-	if (chip->dma >= 0) {
-		snd_dma_disable(chip->dma);
-		free_dma(chip->dma);
+	if (chip->dma1 >= 0) {
+		snd_dma_disable(chip->dma1);
+		free_dma(chip->dma1);
 	}
 	kfree(chip);
 	return 0;
@@ -840,11 +843,11 @@ static int snd_ad1848_free(struct snd_ad
 
 static int snd_ad1848_dev_free(struct snd_device *device)
 {
-	struct snd_ad1848 *chip = device->device_data;
+	struct snd_wss *chip = device->device_data;
 	return snd_ad1848_free(chip);
 }
 
-static const char *snd_ad1848_chip_id(struct snd_ad1848 *chip)
+static const char *snd_ad1848_chip_id(struct snd_wss *chip)
 {
 	switch (chip->hardware) {
 	case AD1848_HW_AD1847:	return "AD1847";
@@ -859,12 +862,12 @@ int snd_ad1848_create(struct snd_card *c
 		      unsigned long port,
 		      int irq, int dma,
 		      unsigned short hardware,
-		      struct snd_ad1848 ** rchip)
+		      struct snd_wss **rchip)
 {
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_ad1848_dev_free,
 	};
-	struct snd_ad1848 *chip;
+	struct snd_wss *chip;
 	int err;
 
 	*rchip = NULL;
@@ -875,7 +878,9 @@ int snd_ad1848_create(struct snd_card *c
 	chip->card = card;
 	chip->port = port;
 	chip->irq = -1;
-	chip->dma = -1;
+	chip->dma1 = -1;
+	chip->dma2 = -1;
+	chip->single_dma = 1;
 	chip->hardware = hardware;
 	memcpy(&chip->image, &snd_ad1848_original_image, sizeof(snd_ad1848_original_image));
 	
@@ -895,7 +900,8 @@ int snd_ad1848_create(struct snd_card *c
 		snd_ad1848_free(chip);
 		return -EBUSY;
 	}
-	chip->dma = dma;
+	chip->dma1 = dma;
+	chip->dma2 = dma;
 
 	if (hardware == AD1848_HW_THINKPAD) {
 		chip->thinkpad_flag = 1;
@@ -947,7 +953,7 @@ static struct snd_pcm_ops snd_ad1848_cap
 	.pointer =	snd_ad1848_capture_pointer,
 };
 
-int snd_ad1848_pcm(struct snd_ad1848 *chip, int device, struct snd_pcm **rpcm)
+int snd_ad1848_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -964,7 +970,9 @@ int snd_ad1848_pcm(struct snd_ad1848 *ch
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_isa_data(),
-					      64*1024, chip->dma > 3 ? 128*1024 : 64*1024);
+					      64 * 1024,
+					      chip->dma1 > 3 ?
+							128 * 1024 : 64 * 1024);
 
 	chip->pcm = pcm;
 	if (rpcm)
@@ -1003,7 +1011,7 @@ static int snd_ad1848_info_mux(struct sn
 
 static int snd_ad1848_get_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_ad1848 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
@@ -1015,7 +1023,7 @@ static int snd_ad1848_get_mux(struct snd
 
 static int snd_ad1848_put_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_ad1848 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	unsigned short left, right;
 	int change;
@@ -1049,7 +1057,7 @@ static int snd_ad1848_info_single(struct
 
 static int snd_ad1848_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_ad1848 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
@@ -1066,7 +1074,7 @@ static int snd_ad1848_get_single(struct 
 
 static int snd_ad1848_put_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_ad1848 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
@@ -1100,7 +1108,7 @@ static int snd_ad1848_info_double(struct
 
 static int snd_ad1848_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_ad1848 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int left_reg = kcontrol->private_value & 0xff;
 	int right_reg = (kcontrol->private_value >> 8) & 0xff;
@@ -1122,7 +1130,7 @@ static int snd_ad1848_get_double(struct 
 
 static int snd_ad1848_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_ad1848 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int left_reg = kcontrol->private_value & 0xff;
 	int right_reg = (kcontrol->private_value >> 8) & 0xff;
@@ -1159,7 +1167,7 @@ static int snd_ad1848_put_double(struct 
 
 /*
  */
-int snd_ad1848_add_ctl_elem(struct snd_ad1848 *chip,
+int snd_ad1848_add_ctl_elem(struct snd_wss *chip,
 			    const struct ad1848_mix_elem *c)
 {
 	static struct snd_kcontrol_new newctls[] = {
@@ -1227,7 +1235,7 @@ AD1848_SINGLE_TLV("Loopback Capture Volu
 		  db_scale_6bit),
 };
                                         
-int snd_ad1848_mixer(struct snd_ad1848 *chip)
+int snd_ad1848_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card;
 	struct snd_pcm *pcm;
diff -urp linux-alsa/sound/isa/cmi8330.c linux-mm/sound/isa/cmi8330.c
--- linux-alsa/sound/isa/cmi8330.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-mm/sound/isa/cmi8330.c	2008-06-30 20:30:25.363059784 +0200
@@ -151,7 +151,7 @@ struct snd_cmi8330 {
 	struct pnp_dev *play;
 #endif
 	struct snd_card *card;
-	struct snd_ad1848 *wss;
+	struct snd_wss *wss;
 	struct snd_sb *sb;
 
 	struct snd_pcm *pcm;
diff -urp linux-alsa/sound/isa/opti9xx/opti92x-ad1848.c linux-mm/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-alsa/sound/isa/opti9xx/opti92x-ad1848.c	2008-06-30 20:44:04.386667569 +0200
+++ linux-mm/sound/isa/opti9xx/opti92x-ad1848.c	2008-06-30 21:12:15.015144288 +0200
@@ -702,14 +702,10 @@ static int __devinit snd_opti9xx_probe(s
 	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
 	int error;
 	struct snd_opti9xx *chip = card->private_data;
-#if defined(CS4231) || defined(OPTi93X)
 	struct snd_wss *codec;
 #ifdef CS4231
 	struct snd_timer *timer;
 #endif
-#else
-	struct snd_ad1848 *codec;
-#endif
 	struct snd_pcm *pcm;
 	struct snd_rawmidi *rmidi;
 	struct snd_hwdep *synth;
diff -urp linux-alsa/sound/isa/sc6000.c linux-mm/sound/isa/sc6000.c
--- linux-alsa/sound/isa/sc6000.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-mm/sound/isa/sc6000.c	2008-06-30 20:36:53.332343377 +0200
@@ -397,7 +397,7 @@ static int __devinit sc6000_init_board(c
 	return 0;
 }
 
-static int __devinit snd_sc6000_mixer(struct snd_ad1848 *chip)
+static int __devinit snd_sc6000_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
@@ -483,7 +483,7 @@ static int __devinit snd_sc6000_probe(st
 	int xirq = irq[dev];
 	int xdma = dma[dev];
 	struct snd_card *card;
-	struct snd_ad1848 *chip;
+	struct snd_wss *chip;
 	struct snd_opl3 *opl3;
 	char __iomem *vport;
 	char __iomem *vmss_port;
diff -urp linux-alsa/sound/isa/sgalaxy.c linux-mm/sound/isa/sgalaxy.c
--- linux-alsa/sound/isa/sgalaxy.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-mm/sound/isa/sgalaxy.c	2008-06-30 20:38:56.415298307 +0200
@@ -180,7 +180,7 @@ AD1848_DOUBLE("Aux Playback Switch", 0, 
 AD1848_DOUBLE("Aux Playback Volume", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 0, 0, 31, 0)
 };
 
-static int __devinit snd_sgalaxy_mixer(struct snd_ad1848 *chip)
+static int __devinit snd_sgalaxy_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
@@ -237,7 +237,7 @@ static int __devinit snd_sgalaxy_probe(s
 	static int possible_dmas[] = {1, 3, 0, -1};
 	int err, xirq, xdma1;
 	struct snd_card *card;
-	struct snd_ad1848 *chip;
+	struct snd_wss *chip;
 
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card == NULL)
@@ -312,7 +312,7 @@ static int snd_sgalaxy_suspend(struct de
 			       pm_message_t state)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
-	struct snd_ad1848 *chip = card->private_data;
+	struct snd_wss *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	chip->suspend(chip);
@@ -322,7 +322,7 @@ static int snd_sgalaxy_suspend(struct de
 static int snd_sgalaxy_resume(struct device *pdev, unsigned int n)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
-	struct snd_ad1848 *chip = card->private_data;
+	struct snd_wss *chip = card->private_data;
 
 	chip->resume(chip);
 	snd_ad1848_out(chip, SGALAXY_AUXC_LEFT, chip->image[SGALAXY_AUXC_LEFT]);

----------------------------------------------------------------------
Masz czas tylko do 10 lipca.
Przystap on-line do ING OFE!
Sprawdz >> http://link.interia.pl/f1e54
