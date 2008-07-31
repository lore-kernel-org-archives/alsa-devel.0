From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 09/11] wss_lib: use wss pcm code instead of
	ad1848 one
Date: Thu, 31 Jul 2008 21:09:32 +0200
Message-ID: <20080731210932.7fb9db4b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 573A5103849
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 21:04:18 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the wss pcm code and kill the ad1848 pcm code.

The AD1848 chip is much slower than CS4231 chips
so the waiting loop was increased 100x (10x is not 
enough).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

Changes since previous version:

1. Condition in snd_wss_capture_open() fixed.
2. Few very small formatting improvements.

diff -urp linux-ref/include/sound/ad1848.h linux-2.6.26/include/sound/ad1848.h
--- linux-ref/include/sound/ad1848.h	2008-07-31 19:07:26.000000000 +0200
+++ linux-2.6.26/include/sound/ad1848.h	2008-07-31 19:07:33.000000000 +0200
@@ -97,11 +97,6 @@
 #define AD1848_CALIB_IN_PROGRESS 0x20	/* auto calibrate in progress */
 #define AD1848_DMA_REQUEST	0x10	/* DMA request in progress */
 
-/* IBM Thinkpad specific stuff */
-#define AD1848_THINKPAD_CTL_PORT1		0x15e8
-#define AD1848_THINKPAD_CTL_PORT2		0x15e9
-#define AD1848_THINKPAD_CS4248_ENABLE_BIT	0x02
-
 /* exported functions */
 
 void snd_ad1848_out(struct snd_wss *chip, unsigned char reg,
@@ -113,7 +108,4 @@ int snd_ad1848_create(struct snd_card *c
 		      unsigned short hardware,
 		      struct snd_wss **chip);
 
-int snd_ad1848_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
-const struct snd_pcm_ops *snd_ad1848_get_pcm_ops(int direction);
-
 #endif /* __SOUND_AD1848_H */
diff -urp linux-ref/include/sound/wss.h linux-2.6.26/include/sound/wss.h
--- linux-ref/include/sound/wss.h	2008-07-31 19:07:26.000000000 +0200
+++ linux-2.6.26/include/sound/wss.h	2008-07-31 19:07:33.000000000 +0200
@@ -71,6 +71,11 @@
 #define WSS_HWSHARE_DMA1	(1<<1)
 #define WSS_HWSHARE_DMA2	(1<<2)
 
+/* IBM Thinkpad specific stuff */
+#define AD1848_THINKPAD_CTL_PORT1		0x15e8
+#define AD1848_THINKPAD_CTL_PORT2		0x15e9
+#define AD1848_THINKPAD_CS4248_ENABLE_BIT	0x02
+
 struct snd_wss {
 	unsigned long port;		/* base i/o port */
 	struct resource *res_port;
@@ -153,6 +158,8 @@ int snd_wss_pcm(struct snd_wss *chip, in
 int snd_wss_timer(struct snd_wss *chip, int device, struct snd_timer **rtimer);
 int snd_wss_mixer(struct snd_wss *chip);
 
+const struct snd_pcm_ops *snd_wss_get_pcm_ops(int direction);
+
 int snd_cs4236_create(struct snd_card *card,
 		      unsigned long port,
 		      unsigned long cport,
diff -urp linux-ref/sound/isa/Kconfig linux-2.6.26/sound/isa/Kconfig
--- linux-ref/sound/isa/Kconfig	2008-07-31 17:28:06.000000000 +0200
+++ linux-2.6.26/sound/isa/Kconfig	2008-07-31 19:07:33.000000000 +0200
@@ -1,12 +1,13 @@
 # ALSA ISA drivers
 
-config SND_AD1848_LIB
+config SND_WSS_LIB
         tristate
         select SND_PCM
 
-config SND_WSS_LIB
+config SND_AD1848_LIB
         tristate
         select SND_PCM
+        select SND_WSS_LIB
 
 config SND_SB_COMMON
         tristate
diff -urp linux-ref/sound/isa/ad1848/ad1848.c linux-2.6.26/sound/isa/ad1848/ad1848.c
--- linux-ref/sound/isa/ad1848/ad1848.c	2008-07-31 19:07:26.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848.c	2008-07-31 19:07:33.000000000 +0200
@@ -102,7 +102,7 @@ static int __devinit snd_ad1848_probe(st
 
 	card->private_data = chip;
 
-	error = snd_ad1848_pcm(chip, 0, &pcm);
+	error = snd_wss_pcm(chip, 0, &pcm);
 	if (error < 0)
 		goto out;
 
diff -urp linux-ref/sound/isa/ad1848/ad1848_lib.c linux-2.6.26/sound/isa/ad1848/ad1848_lib.c
--- linux-ref/sound/isa/ad1848/ad1848_lib.c	2008-07-31 19:07:26.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848_lib.c	2008-07-31 19:08:10.000000000 +0200
@@ -46,34 +46,6 @@ MODULE_LICENSE("GPL");
  *  Some variables
  */
 
-static unsigned char freq_bits[14] = {
-	/* 5510 */	0x00 | AD1848_XTAL2,
-	/* 6620 */	0x0E | AD1848_XTAL2,
-	/* 8000 */	0x00 | AD1848_XTAL1,
-	/* 9600 */	0x0E | AD1848_XTAL1,
-	/* 11025 */	0x02 | AD1848_XTAL2,
-	/* 16000 */	0x02 | AD1848_XTAL1,
-	/* 18900 */	0x04 | AD1848_XTAL2,
-	/* 22050 */	0x06 | AD1848_XTAL2,
-	/* 27042 */	0x04 | AD1848_XTAL1,
-	/* 32000 */	0x06 | AD1848_XTAL1,
-	/* 33075 */	0x0C | AD1848_XTAL2,
-	/* 37800 */	0x08 | AD1848_XTAL2,
-	/* 44100 */	0x0A | AD1848_XTAL2,
-	/* 48000 */	0x0C | AD1848_XTAL1
-};
-
-static unsigned int rates[14] = {
-	5510, 6620, 8000, 9600, 11025, 16000, 18900, 22050,
-	27042, 32000, 33075, 37800, 44100, 48000
-};
-
-static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
-	.count = ARRAY_SIZE(rates),
-	.list = rates,
-	.mask = 0,
-};
-
 static unsigned char snd_ad1848_original_image[16] =
 {
 	0x00,			/* 00 - lic */
@@ -128,15 +100,6 @@ void snd_ad1848_out(struct snd_wss *chip
 
 EXPORT_SYMBOL(snd_ad1848_out);
 
-static void snd_ad1848_dout(struct snd_wss *chip,
-			    unsigned char reg, unsigned char value)
-{
-	snd_ad1848_wait(chip);
-	outb(chip->mce_bit | reg, chip->port + CS4231P(REGSEL));
-	outb(value, chip->port + CS4231P(REG));
-	mb();
-}
-
 static unsigned char snd_ad1848_in(struct snd_wss *chip, unsigned char reg)
 {
 	snd_ad1848_wait(chip);
@@ -261,315 +224,6 @@ static void snd_ad1848_mce_down(struct s
 		   inb(chip->port + CS4231P(REGSEL)));
 }
 
-static unsigned int snd_ad1848_get_count(unsigned char format,
-				         unsigned int size)
-{
-	switch (format & 0xe0) {
-	case AD1848_LINEAR_16:
-		size >>= 1;
-		break;
-	}
-	if (format & AD1848_STEREO)
-		size >>= 1;
-	return size;
-}
-
-static int snd_ad1848_trigger(struct snd_wss *chip, unsigned char what,
-			      int channel, int cmd)
-{
-	int result = 0;
-
-#if 0
-	printk("codec trigger!!! - what = %i, enable = %i, status = 0x%x\n", what, enable, inb(AD1848P(card, STATUS)));
-#endif
-	spin_lock(&chip->reg_lock);
-	if (cmd == SNDRV_PCM_TRIGGER_START) {
-		if (chip->image[AD1848_IFACE_CTRL] & what) {
-			spin_unlock(&chip->reg_lock);
-			return 0;
-		}
-		snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL] |= what);
-	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
-		if (!(chip->image[AD1848_IFACE_CTRL] & what)) {
-			spin_unlock(&chip->reg_lock);
-			return 0;
-		}
-		snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL] &= ~what);
-	} else {
-		result = -EINVAL;
-	}
-	spin_unlock(&chip->reg_lock);
-	return result;
-}
-
-/*
- *  CODEC I/O
- */
-
-static unsigned char snd_ad1848_get_rate(unsigned int rate)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(rates); i++)
-		if (rate == rates[i])
-			return freq_bits[i];
-	snd_BUG();
-	return freq_bits[ARRAY_SIZE(rates) - 1];
-}
-
-static int snd_ad1848_ioctl(struct snd_pcm_substream *substream,
-			    unsigned int cmd, void *arg)
-{
-	return snd_pcm_lib_ioctl(substream, cmd, arg);
-}
-
-static unsigned char snd_ad1848_get_format(int format, int channels)
-{
-	unsigned char rformat;
-
-	rformat = AD1848_LINEAR_8;
-	switch (format) {
-	case SNDRV_PCM_FORMAT_A_LAW:	rformat = AD1848_ALAW_8; break;
-	case SNDRV_PCM_FORMAT_MU_LAW:	rformat = AD1848_ULAW_8; break;
-	case SNDRV_PCM_FORMAT_S16_LE:	rformat = AD1848_LINEAR_16; break;
-	}
-	if (channels > 1)
-		rformat |= AD1848_STEREO;
-#if 0
-	snd_printk("get_format: 0x%x (mode=0x%x)\n", format, mode);
-#endif
-	return rformat;
-}
-
-static void snd_ad1848_calibrate_mute(struct snd_wss *chip, int mute)
-{
-	unsigned long flags;
-	
-	mute = mute ? 1 : 0;
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	if (chip->calibrate_mute == mute) {
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		return;
-	}
-	if (!mute) {
-		snd_ad1848_dout(chip, AD1848_LEFT_INPUT, chip->image[AD1848_LEFT_INPUT]);
-		snd_ad1848_dout(chip, AD1848_RIGHT_INPUT, chip->image[AD1848_RIGHT_INPUT]);
-	}
-	snd_ad1848_dout(chip, AD1848_AUX1_LEFT_INPUT, mute ? 0x80 : chip->image[AD1848_AUX1_LEFT_INPUT]);
-	snd_ad1848_dout(chip, AD1848_AUX1_RIGHT_INPUT, mute ? 0x80 : chip->image[AD1848_AUX1_RIGHT_INPUT]);
-	snd_ad1848_dout(chip, AD1848_AUX2_LEFT_INPUT, mute ? 0x80 : chip->image[AD1848_AUX2_LEFT_INPUT]);
-	snd_ad1848_dout(chip, AD1848_AUX2_RIGHT_INPUT, mute ? 0x80 : chip->image[AD1848_AUX2_RIGHT_INPUT]);
-	snd_ad1848_dout(chip, AD1848_LEFT_OUTPUT, mute ? 0x80 : chip->image[AD1848_LEFT_OUTPUT]);
-	snd_ad1848_dout(chip, AD1848_RIGHT_OUTPUT, mute ? 0x80 : chip->image[AD1848_RIGHT_OUTPUT]);
-	chip->calibrate_mute = mute;
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-}
-
-static void snd_ad1848_set_data_format(struct snd_wss *chip,
-				       struct snd_pcm_hw_params *hw_params)
-{
-	if (hw_params == NULL) {
-		chip->image[AD1848_DATA_FORMAT] = 0x20;
-	} else {
-		chip->image[AD1848_DATA_FORMAT] =
-		    snd_ad1848_get_format(params_format(hw_params), params_channels(hw_params)) |
-		    snd_ad1848_get_rate(params_rate(hw_params));
-	}
-	// snd_printk(">>> pmode = 0x%x, dfr = 0x%x\n", pstr->mode, chip->image[AD1848_DATA_FORMAT]);
-}
-
-static int snd_ad1848_open(struct snd_wss *chip, unsigned int mode)
-{
-	unsigned long flags;
-
-	if (chip->mode & WSS_MODE_OPEN)
-		return -EAGAIN;
-
-	snd_ad1848_mce_down(chip);
-
-#ifdef SNDRV_DEBUG_MCE
-	snd_printk("open: (1)\n");
-#endif
-	snd_ad1848_mce_up(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO |
-			     AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO |
-			     AD1848_CALIB_MODE);
-	chip->image[AD1848_IFACE_CTRL] |= AD1848_AUTOCALIB;
-	snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_ad1848_mce_down(chip);
-
-#ifdef SNDRV_DEBUG_MCE
-	snd_printk("open: (2)\n");
-#endif
-
-	snd_ad1848_set_data_format(chip, NULL);
-
-	snd_ad1848_mce_up(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_ad1848_out(chip, AD1848_DATA_FORMAT, chip->image[AD1848_DATA_FORMAT]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_ad1848_mce_down(chip);
-
-#ifdef SNDRV_DEBUG_MCE
-	snd_printk("open: (3)\n");
-#endif
-
-	/* ok. now enable and ack CODEC IRQ */
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
-	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
-	chip->image[AD1848_PIN_CTRL] |= AD1848_IRQ_ENABLE;
-	snd_ad1848_out(chip, AD1848_PIN_CTRL, chip->image[AD1848_PIN_CTRL]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-
-	chip->mode = mode;
-
-	return 0;
-}
-
-static void snd_ad1848_close(struct snd_wss *chip)
-{
-	unsigned long flags;
-
-	if (!chip->mode)
-		return;
-	/* disable IRQ */
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
-	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
-	chip->image[AD1848_PIN_CTRL] &= ~AD1848_IRQ_ENABLE;
-	snd_ad1848_out(chip, AD1848_PIN_CTRL, chip->image[AD1848_PIN_CTRL]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-
-	/* now disable capture & playback */
-
-	snd_ad1848_mce_up(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO |
-			     AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO);
-	snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_ad1848_mce_down(chip);
-
-	/* clear IRQ again */
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
-	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-
-	chip->mode = 0;
-}
-
-/*
- *  ok.. exported functions..
- */
-
-static int snd_ad1848_playback_trigger(struct snd_pcm_substream *substream,
-				       int cmd)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	return snd_ad1848_trigger(chip, AD1848_PLAYBACK_ENABLE, SNDRV_PCM_STREAM_PLAYBACK, cmd);
-}
-
-static int snd_ad1848_capture_trigger(struct snd_pcm_substream *substream,
-				      int cmd)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	return snd_ad1848_trigger(chip, AD1848_CAPTURE_ENABLE, SNDRV_PCM_STREAM_CAPTURE, cmd);
-}
-
-static int snd_ad1848_playback_hw_params(struct snd_pcm_substream *substream,
-					 struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	unsigned long flags;
-	int err;
-
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
-	snd_ad1848_calibrate_mute(chip, 1);
-	snd_ad1848_set_data_format(chip, hw_params);
-	snd_ad1848_mce_up(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_ad1848_out(chip, AD1848_DATA_FORMAT, chip->image[AD1848_DATA_FORMAT]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_ad1848_mce_down(chip);
-	snd_ad1848_calibrate_mute(chip, 0);
-	return 0;
-}
-
-static int snd_ad1848_playback_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
-static int snd_ad1848_playback_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned long flags;
-	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
-	unsigned int count = snd_pcm_lib_period_bytes(substream);
-
-	chip->p_dma_size = size;
-	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO);
-	snd_dma_program(chip->dma1, runtime->dma_addr, size,
-			DMA_MODE_WRITE | DMA_AUTOINIT);
-	count = snd_ad1848_get_count(chip->image[AD1848_DATA_FORMAT], count) - 1;
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_ad1848_out(chip, AD1848_DATA_LWR_CNT, (unsigned char) count);
-	snd_ad1848_out(chip, AD1848_DATA_UPR_CNT, (unsigned char) (count >> 8));
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	return 0;
-}
-
-static int snd_ad1848_capture_hw_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	unsigned long flags;
-	int err;
-
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
-	snd_ad1848_calibrate_mute(chip, 1);
-	snd_ad1848_set_data_format(chip, hw_params);
-	snd_ad1848_mce_up(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_ad1848_out(chip, AD1848_DATA_FORMAT, chip->image[AD1848_DATA_FORMAT]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_ad1848_mce_down(chip);
-	snd_ad1848_calibrate_mute(chip, 0);
-	return 0;
-}
-
-static int snd_ad1848_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
-static int snd_ad1848_capture_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned long flags;
-	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
-	unsigned int count = snd_pcm_lib_period_bytes(substream);
-
-	chip->c_dma_size = size;
-	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO);
-	snd_dma_program(chip->dma2, runtime->dma_addr, size,
-			DMA_MODE_READ | DMA_AUTOINIT);
-	count = snd_ad1848_get_count(chip->image[AD1848_DATA_FORMAT], count) - 1;
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_ad1848_out(chip, AD1848_DATA_LWR_CNT, (unsigned char) count);
-	snd_ad1848_out(chip, AD1848_DATA_UPR_CNT, (unsigned char) (count >> 8));
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	return 0;
-}
-
 static irqreturn_t snd_ad1848_interrupt(int irq, void *dev_id)
 {
 	struct snd_wss *chip = dev_id;
@@ -582,28 +236,6 @@ static irqreturn_t snd_ad1848_interrupt(
 	return IRQ_HANDLED;
 }
 
-static snd_pcm_uframes_t snd_ad1848_playback_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	size_t ptr;
-	
-	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_PLAYBACK_ENABLE))
-		return 0;
-	ptr = snd_dma_pointer(chip->dma1, chip->p_dma_size);
-	return bytes_to_frames(substream->runtime, ptr);
-}
-
-static snd_pcm_uframes_t snd_ad1848_capture_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	size_t ptr;
-
-	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_CAPTURE_ENABLE))
-		return 0;
-	ptr = snd_dma_pointer(chip->dma2, chip->c_dma_size);
-	return bytes_to_frames(substream->runtime, ptr);
-}
-
 /*
 
  */
@@ -728,6 +360,16 @@ static int snd_ad1848_probe(struct snd_w
 		snd_ad1848_out(chip, i, *ptr++);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_ad1848_mce_up(chip);
+	/* init needed for WSS pcm */
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE |
+				AD1848_PLAYBACK_PIO |
+				AD1848_CAPTURE_ENABLE |
+				AD1848_CAPTURE_PIO |
+				AD1848_CALIB_MODE);
+	chip->image[AD1848_IFACE_CTRL] |= AD1848_AUTOCALIB;
+	snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_ad1848_mce_down(chip);
 	return 0;		/* all things are ok.. */
 }
@@ -736,102 +378,6 @@ static int snd_ad1848_probe(struct snd_w
 
  */
 
-static struct snd_pcm_hardware snd_ad1848_playback =
-{
-	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
-				 SNDRV_PCM_INFO_MMAP_VALID),
-	.formats =		(SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW |
-				 SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE),
-	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_48000,
-	.rate_min =		5510,
-	.rate_max =		48000,
-	.channels_min =		1,
-	.channels_max =		2,
-	.buffer_bytes_max =	(128*1024),
-	.period_bytes_min =	64,
-	.period_bytes_max =	(128*1024),
-	.periods_min =		1,
-	.periods_max =		1024,
-	.fifo_size =		0,
-};
-
-static struct snd_pcm_hardware snd_ad1848_capture =
-{
-	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
-				 SNDRV_PCM_INFO_MMAP_VALID),
-	.formats =		(SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW |
-				 SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE),
-	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_48000,
-	.rate_min =		5510,
-	.rate_max =		48000,
-	.channels_min =		1,
-	.channels_max =		2,
-	.buffer_bytes_max =	(128*1024),
-	.period_bytes_min =	64,
-	.period_bytes_max =	(128*1024),
-	.periods_min =		1,
-	.periods_max =		1024,
-	.fifo_size =		0,
-};
-
-/*
-
- */
-
-static int snd_ad1848_playback_open(struct snd_pcm_substream *substream)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-
-	err = snd_ad1848_open(chip, WSS_MODE_PLAY);
-	if (err < 0)
-		return err;
-	chip->playback_substream = substream;
-	runtime->hw = snd_ad1848_playback;
-	snd_pcm_limit_isa_dma_size(chip->dma1, &runtime->hw.buffer_bytes_max);
-	snd_pcm_limit_isa_dma_size(chip->dma1, &runtime->hw.period_bytes_max);
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
-	return 0;
-}
-
-static int snd_ad1848_capture_open(struct snd_pcm_substream *substream)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-
-	err = snd_ad1848_open(chip, WSS_MODE_RECORD);
-	if (err < 0)
-		return err;
-	chip->capture_substream = substream;
-	runtime->hw = snd_ad1848_capture;
-	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.buffer_bytes_max);
-	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.period_bytes_max);
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
-	return 0;
-}
-
-static int snd_ad1848_playback_close(struct snd_pcm_substream *substream)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-
-	chip->mode &= ~WSS_MODE_PLAY;
-	chip->playback_substream = NULL;
-	snd_ad1848_close(chip);
-	return 0;
-}
-
-static int snd_ad1848_capture_close(struct snd_pcm_substream *substream)
-{
-	struct snd_wss *chip = snd_pcm_substream_chip(substream);
-
-	chip->mode &= ~WSS_MODE_RECORD;
-	chip->capture_substream = NULL;
-	snd_ad1848_close(chip);
-	return 0;
-}
-
 static int snd_ad1848_free(struct snd_wss *chip)
 {
 	release_and_free_resource(chip->res_port);
@@ -851,17 +397,6 @@ static int snd_ad1848_dev_free(struct sn
 	return snd_ad1848_free(chip);
 }
 
-static const char *snd_ad1848_chip_id(struct snd_wss *chip)
-{
-	switch (chip->hardware) {
-	case AD1848_HW_AD1847:	return "AD1847";
-	case AD1848_HW_AD1848:	return "AD1848";
-	case AD1848_HW_CS4248:	return "CS4248";
-	case AD1848_HW_CMI8330: return "CMI8330/C3D";
-	default:		return "???";
-	}
-}
-
 int snd_ad1848_create(struct snd_card *card,
 		      unsigned long port,
 		      int irq, int dma,
@@ -935,65 +470,6 @@ int snd_ad1848_create(struct snd_card *c
 
 EXPORT_SYMBOL(snd_ad1848_create);
 
-static struct snd_pcm_ops snd_ad1848_playback_ops = {
-	.open =		snd_ad1848_playback_open,
-	.close =	snd_ad1848_playback_close,
-	.ioctl =	snd_ad1848_ioctl,
-	.hw_params =	snd_ad1848_playback_hw_params,
-	.hw_free =	snd_ad1848_playback_hw_free,
-	.prepare =	snd_ad1848_playback_prepare,
-	.trigger =	snd_ad1848_playback_trigger,
-	.pointer =	snd_ad1848_playback_pointer,
-};
-
-static struct snd_pcm_ops snd_ad1848_capture_ops = {
-	.open =		snd_ad1848_capture_open,
-	.close =	snd_ad1848_capture_close,
-	.ioctl =	snd_ad1848_ioctl,
-	.hw_params =	snd_ad1848_capture_hw_params,
-	.hw_free =	snd_ad1848_capture_hw_free,
-	.prepare =	snd_ad1848_capture_prepare,
-	.trigger =	snd_ad1848_capture_trigger,
-	.pointer =	snd_ad1848_capture_pointer,
-};
-
-int snd_ad1848_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm)
-{
-	struct snd_pcm *pcm;
-	int err;
-
-	if ((err = snd_pcm_new(chip->card, "AD1848", device, 1, 1, &pcm)) < 0)
-		return err;
-
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ad1848_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ad1848_capture_ops);
-
-	pcm->private_data = chip;
-	pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
-	strcpy(pcm->name, snd_ad1848_chip_id(chip));
-
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      snd_dma_isa_data(),
-					      64 * 1024,
-					      chip->dma1 > 3 ?
-							128 * 1024 : 64 * 1024);
-
-	chip->pcm = pcm;
-	if (rpcm)
-		*rpcm = pcm;
-	return 0;
-}
-
-EXPORT_SYMBOL(snd_ad1848_pcm);
-
-const struct snd_pcm_ops *snd_ad1848_get_pcm_ops(int direction)
-{
-	return direction == SNDRV_PCM_STREAM_PLAYBACK ?
-		&snd_ad1848_playback_ops : &snd_ad1848_capture_ops;
-}
-
-EXPORT_SYMBOL(snd_ad1848_get_pcm_ops);
-
 /*
  *  INIT part
  */
diff -urp linux-ref/sound/isa/cmi8330.c linux-2.6.26/sound/isa/cmi8330.c
--- linux-ref/sound/isa/cmi8330.c	2008-07-31 18:59:20.000000000 +0200
+++ linux-2.6.26/sound/isa/cmi8330.c	2008-07-31 19:07:33.000000000 +0200
@@ -413,7 +413,7 @@ static int __devinit snd_cmi8330_pcm(str
 	chip->streams[CMI_SB_STREAM].private_data = chip->sb;
 
 	/* AD1848 */
-	ops = snd_ad1848_get_pcm_ops(CMI_AD_STREAM);
+	ops = snd_wss_get_pcm_ops(CMI_AD_STREAM);
 	chip->streams[CMI_AD_STREAM].ops = *ops;
 	chip->streams[CMI_AD_STREAM].open = ops->open;
 	chip->streams[CMI_AD_STREAM].ops.open = cmi_open_callbacks[CMI_AD_STREAM];
diff -urp linux-ref/sound/isa/opti9xx/opti92x-ad1848.c linux-2.6.26/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-ref/sound/isa/opti9xx/opti92x-ad1848.c	2008-07-31 19:07:26.000000000 +0200
+++ linux-2.6.26/sound/isa/opti9xx/opti92x-ad1848.c	2008-07-31 19:07:33.000000000 +0200
@@ -754,18 +754,15 @@ static int __devinit snd_opti9xx_probe(s
 #ifdef OPTi93X
 	chip->codec = codec;
 #endif
-	error = snd_wss_pcm(codec, 0, &pcm);
-	if (error < 0)
-		return error;
 #else
 	error = snd_ad1848_create(card, chip->wss_base + 4, chip->irq,
 				  chip->dma1, WSS_HW_DETECT, &codec);
 	if (error < 0)
 		return error;
-	error = snd_ad1848_pcm(codec, 0, &pcm);
+#endif
+	error = snd_wss_pcm(codec, 0, &pcm);
 	if (error < 0)
 		return error;
-#endif
 	error = snd_wss_mixer(codec);
 	if (error < 0)
 		return error;
diff -urp linux-ref/sound/isa/sc6000.c linux-2.6.26/sound/isa/sc6000.c
--- linux-ref/sound/isa/sc6000.c	2008-07-31 19:07:26.000000000 +0200
+++ linux-2.6.26/sound/isa/sc6000.c	2008-07-31 19:07:33.000000000 +0200
@@ -554,10 +554,10 @@ static int __devinit snd_sc6000_probe(st
 		goto err_unmap2;
 	card->private_data = chip;
 
-	err = snd_ad1848_pcm(chip, 0, NULL);
+	err = snd_wss_pcm(chip, 0, NULL);
 	if (err < 0) {
 		snd_printk(KERN_ERR PFX
-			   "error creating new ad1848 PCM device\n");
+			   "error creating new WSS PCM device\n");
 		goto err_unmap2;
 	}
 	err = snd_wss_mixer(chip);
diff -urp linux-ref/sound/isa/sgalaxy.c linux-2.6.26/sound/isa/sgalaxy.c
--- linux-ref/sound/isa/sgalaxy.c	2008-07-31 19:07:26.000000000 +0200
+++ linux-2.6.26/sound/isa/sgalaxy.c	2008-07-31 19:07:33.000000000 +0200
@@ -273,8 +273,9 @@ static int __devinit snd_sgalaxy_probe(s
 		goto _err;
 	card->private_data = chip;
 
-	if ((err = snd_ad1848_pcm(chip, 0, NULL)) < 0) {
-		snd_printdd(PFX "error creating new ad1848 PCM device\n");
+	err = snd_wss_pcm(chip, 0, NULL);
+	if (err < 0) {
+		snd_printdd(PFX "error creating new WSS PCM device\n");
 		goto _err;
 	}
 	err = snd_wss_mixer(chip);
diff -urp linux-ref/sound/isa/wss/wss_lib.c linux-2.6.26/sound/isa/wss/wss_lib.c
--- linux-ref/sound/isa/wss/wss_lib.c	2008-07-31 19:07:26.000000000 +0200
+++ linux-2.6.26/sound/isa/wss/wss_lib.c	2008-07-31 19:16:22.000000000 +0200
@@ -380,7 +380,7 @@ static void snd_wss_busy_wait(struct snd
 	for (timeout = 5; timeout > 0; timeout--)
 		wss_inb(chip, CS4231P(REGSEL));
 	/* end of cleanup sequence */
-	for (timeout = 250;
+	for (timeout = 25000;
 	     timeout > 0 && (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
 	     timeout--)
 		udelay(10);
@@ -413,6 +413,7 @@ void snd_wss_mce_down(struct snd_wss *ch
 	unsigned long flags;
 	unsigned long end_time;
 	int timeout;
+	int hw_mask = WSS_HW_CS4231_MASK | WSS_HW_CS4232_MASK | WSS_HW_AD1848;
 
 	snd_wss_busy_wait(chip);
 
@@ -427,10 +428,8 @@ void snd_wss_mce_down(struct snd_wss *ch
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	if (timeout == 0x80)
 		snd_printk("mce_down [0x%lx]: serious init problem - codec still busy\n", chip->port);
-	if ((timeout & CS4231_MCE) == 0 ||
-	    !(chip->hardware & (WSS_HW_CS4231_MASK | WSS_HW_CS4232_MASK))) {
+	if ((timeout & CS4231_MCE) == 0 || !(chip->hardware & hw_mask))
 		return;
-	}
 
 	/*
 	 * Wait for (possible -- during init auto-calibration may not be set)
@@ -601,12 +600,14 @@ static void snd_wss_calibrate_mute(struc
 		     mute ? 0x80 : chip->image[CS4231_LEFT_OUTPUT]);
 	snd_wss_dout(chip, CS4231_RIGHT_OUTPUT,
 		     mute ? 0x80 : chip->image[CS4231_RIGHT_OUTPUT]);
-	snd_wss_dout(chip, CS4231_LEFT_LINE_IN,
-		     mute ? 0x80 : chip->image[CS4231_LEFT_LINE_IN]);
-	snd_wss_dout(chip, CS4231_RIGHT_LINE_IN,
-		     mute ? 0x80 : chip->image[CS4231_RIGHT_LINE_IN]);
-	snd_wss_dout(chip, CS4231_MONO_CTRL,
-		     mute ? 0xc0 : chip->image[CS4231_MONO_CTRL]);
+	if (!(chip->hardware & WSS_HW_AD1848_MASK)) {
+		snd_wss_dout(chip, CS4231_LEFT_LINE_IN,
+			     mute ? 0x80 : chip->image[CS4231_LEFT_LINE_IN]);
+		snd_wss_dout(chip, CS4231_RIGHT_LINE_IN,
+			     mute ? 0x80 : chip->image[CS4231_RIGHT_LINE_IN]);
+		snd_wss_dout(chip, CS4231_MONO_CTRL,
+			     mute ? 0xc0 : chip->image[CS4231_MONO_CTRL]);
+	}
 	if (chip->hardware == WSS_HW_INTERWAVE) {
 		snd_wss_dout(chip, CS4231_LEFT_MIC_INPUT,
 			     mute ? 0x80 : chip->image[CS4231_LEFT_MIC_INPUT]);
@@ -706,7 +707,10 @@ static void snd_wss_capture_format(struc
 			snd_wss_mce_up(chip);
 			spin_lock_irqsave(&chip->reg_lock, flags);
 		}
-		snd_wss_out(chip, CS4231_REC_FORMAT, cdfr);
+		if (chip->hardware & WSS_HW_AD1848_MASK)
+			snd_wss_out(chip, CS4231_PLAYBK_FORMAT, cdfr);
+		else
+			snd_wss_out(chip, CS4231_REC_FORMAT, cdfr);
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		snd_wss_mce_down(chip);
 	}
@@ -818,7 +822,9 @@ static void snd_wss_init(struct snd_wss 
 
 	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_wss_out(chip, CS4231_REC_FORMAT, chip->image[CS4231_REC_FORMAT]);
+	if (!(chip->hardware & WSS_HW_AD1848_MASK))
+		snd_wss_out(chip, CS4231_REC_FORMAT,
+			    chip->image[CS4231_REC_FORMAT]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_wss_mce_down(chip);
 
@@ -844,20 +850,24 @@ static int snd_wss_open(struct snd_wss *
 	}
 	/* ok. now enable and ack CODEC IRQ */
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_wss_out(chip, CS4231_IRQ_STATUS,
-		    CS4231_PLAYBACK_IRQ |
-		    CS4231_RECORD_IRQ |
-		    CS4231_TIMER_IRQ);
-	snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	if (!(chip->hardware & WSS_HW_AD1848_MASK)) {
+		snd_wss_out(chip, CS4231_IRQ_STATUS,
+			    CS4231_PLAYBACK_IRQ |
+			    CS4231_RECORD_IRQ |
+			    CS4231_TIMER_IRQ);
+		snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	}
 	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	chip->image[CS4231_PIN_CTRL] |= CS4231_IRQ_ENABLE;
 	snd_wss_out(chip, CS4231_PIN_CTRL, chip->image[CS4231_PIN_CTRL]);
-	snd_wss_out(chip, CS4231_IRQ_STATUS,
-		    CS4231_PLAYBACK_IRQ |
-		    CS4231_RECORD_IRQ |
-		    CS4231_TIMER_IRQ);
-	snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	if (!(chip->hardware & WSS_HW_AD1848_MASK)) {
+		snd_wss_out(chip, CS4231_IRQ_STATUS,
+			    CS4231_PLAYBACK_IRQ |
+			    CS4231_RECORD_IRQ |
+			    CS4231_TIMER_IRQ);
+		snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	chip->mode = mode;
@@ -879,7 +889,8 @@ static void snd_wss_close(struct snd_wss
 
 	/* disable IRQ */
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	if (!(chip->hardware & WSS_HW_AD1848_MASK))
+		snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
 	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	chip->image[CS4231_PIN_CTRL] &= ~CS4231_IRQ_ENABLE;
@@ -902,7 +913,8 @@ static void snd_wss_close(struct snd_wss
 	}
 
 	/* clear IRQ again */
-	snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	if (!(chip->hardware & WSS_HW_AD1848_MASK))
+		snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
 	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -1023,7 +1035,13 @@ static int snd_wss_capture_prepare(struc
 	chip->c_dma_size = size;
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_RECORD_ENABLE | CS4231_RECORD_PIO);
 	snd_dma_program(chip->dma2, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
-	count = snd_wss_get_count(chip->image[CS4231_REC_FORMAT], count) - 1;
+	if (chip->hardware & WSS_HW_AD1848_MASK)
+		count = snd_wss_get_count(chip->image[CS4231_PLAYBK_FORMAT],
+					  count);
+	else
+		count = snd_wss_get_count(chip->image[CS4231_REC_FORMAT],
+					  count);
+	count--;
 	if (chip->single_dma && chip->hardware != WSS_HW_INTERWAVE) {
 		snd_wss_out(chip, CS4231_PLY_LWR_CNT, (unsigned char) count);
 		snd_wss_out(chip, CS4231_PLY_UPR_CNT,
@@ -1341,6 +1359,11 @@ static int snd_wss_playback_open(struct 
 
 	runtime->hw = snd_wss_playback;
 
+	/* hardware limitation of older chipsets */
+	if (chip->hardware & WSS_HW_AD1848_MASK)
+		runtime->hw.formats &= ~(SNDRV_PCM_FMTBIT_IMA_ADPCM |
+					 SNDRV_PCM_FMTBIT_S16_BE);
+
 	/* hardware bug in InterWave chipset */
 	if (chip->hardware == WSS_HW_INTERWAVE && chip->dma1 > 3)
 		runtime->hw.formats &= ~SNDRV_PCM_FMTBIT_MU_LAW;
@@ -1379,6 +1402,11 @@ static int snd_wss_capture_open(struct s
 
 	runtime->hw = snd_wss_capture;
 
+	/* hardware limitation of older chipsets */
+	if (chip->hardware & WSS_HW_AD1848_MASK)
+		runtime->hw.formats &= ~(SNDRV_PCM_FMTBIT_IMA_ADPCM |
+					 SNDRV_PCM_FMTBIT_S16_BE);
+
 	/* hardware limitation of cheap chips */
 	if (chip->hardware == WSS_HW_CS4235 ||
 	    chip->hardware == WSS_HW_CS4239)
@@ -1423,6 +1451,26 @@ static int snd_wss_capture_close(struct 
 	return 0;
 }
 
+static void snd_wss_thinkpad_twiddle(struct snd_wss *chip, int on)
+{
+	int tmp;
+
+	if (!chip->thinkpad_flag)
+		return;
+
+	outb(0x1c, AD1848_THINKPAD_CTL_PORT1);
+	tmp = inb(AD1848_THINKPAD_CTL_PORT2);
+
+	if (on)
+		/* turn it on */
+		tmp |= AD1848_THINKPAD_CS4248_ENABLE_BIT;
+	else
+		/* turn it off */
+		tmp &= ~AD1848_THINKPAD_CS4248_ENABLE_BIT;
+
+	outb(tmp, AD1848_THINKPAD_CTL_PORT2);
+}
+
 #ifdef CONFIG_PM
 
 /* lowlevel suspend callback for CS4231 */
@@ -1436,6 +1484,8 @@ static void snd_wss_suspend(struct snd_w
 	for (reg = 0; reg < 32; reg++)
 		chip->image[reg] = snd_wss_in(chip, reg);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	if (chip->thinkpad_flag)
+		snd_wss_thinkpad_twiddle(chip, 0);
 }
 
 /* lowlevel resume callback for CS4231 */
@@ -1445,6 +1495,8 @@ static void snd_wss_resume(struct snd_ws
 	unsigned long flags;
 	/* int timeout; */
 
+	if (chip->thinkpad_flag)
+		snd_wss_thinkpad_twiddle(chip, 1);
 	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	for (reg = 0; reg < 32; reg++) {
@@ -1542,6 +1594,14 @@ const char *snd_wss_chip_id(struct snd_w
 		return "AD1845";
 	case WSS_HW_OPTI93X:
 		return "OPTi 93x";
+	case WSS_HW_AD1847:
+		return "AD1847";
+	case WSS_HW_AD1848:
+		return "AD1848";
+	case WSS_HW_CS4248:
+		return "CS4248";
+	case WSS_HW_CMI8330:
+		return "CMI8330/C3D";
 	default:
 		return "???";
 	}
@@ -1704,7 +1764,8 @@ int snd_wss_pcm(struct snd_wss *chip, in
 	struct snd_pcm *pcm;
 	int err;
 
-	if ((err = snd_pcm_new(chip->card, "CS4231", device, 1, 1, &pcm)) < 0)
+	err = snd_pcm_new(chip->card, "WSS", device, 1, 1, &pcm);
+	if (err < 0)
 		return err;
 
 	spin_lock_init(&chip->reg_lock);
@@ -1714,6 +1775,12 @@ int snd_wss_pcm(struct snd_wss *chip, in
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_wss_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_wss_capture_ops);
 
+	/* temporary */
+	if (chip->hardware & WSS_HW_AD1848_MASK) {
+		chip->rate_constraint = snd_wss_xrate;
+		chip->set_playback_format = snd_wss_playback_format;
+		chip->set_capture_format = snd_wss_capture_format;
+	}
 	/* global setup */
 	pcm->private_data = chip;
 	pcm->info_flags = 0;
@@ -2134,6 +2201,13 @@ int snd_wss_mixer(struct snd_wss *chip)
 }
 EXPORT_SYMBOL(snd_wss_mixer);
 
+const struct snd_pcm_ops *snd_wss_get_pcm_ops(int direction)
+{
+	return direction == SNDRV_PCM_STREAM_PLAYBACK ?
+		&snd_wss_playback_ops : &snd_wss_capture_ops;
+}
+EXPORT_SYMBOL(snd_wss_get_pcm_ops);
+
 /*
  *  INIT part
  */

----------------------------------------------------------------------
Rowerem po Roztoczu.
Zobacz relacje >>> http://link.interia.pl/f1e65
