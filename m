From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] sun-cs4231: checkpatch fixes
Date: Thu, 6 Sep 2007 23:51:24 +0200
Message-ID: <20070906235124.c4ef2c92.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 23D94243E1
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 23:45:00 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so329797nfb
	for <alsa-devel@alsa-project.org>; Thu, 06 Sep 2007 14:44:59 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes white spaces and issues pointed by
the checkpatch.pl script.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-2.6.23.ref/sound/sparc/cs4231.c linux-2.6.23/sound/sparc/cs4231.c
--- linux-2.6.23.ref/sound/sparc/cs4231.c	2007-09-04 20:01:03.000000000 +0200
+++ linux-2.6.23/sound/sparc/cs4231.c	2007-09-04 19:58:45.000000000 +0200
@@ -3,7 +3,7 @@
  * Copyright (C) 2002 David S. Miller <davem@redhat.com>
  *
  * Based entirely upon drivers/sbus/audio/cs4231.c which is:
- * Copyright (C) 1996, 1997, 1998, 1998 Derrick J Brashear (shadow@andrew.cmu.edu)
+ * Copyright (C) 1996, 1997, 1998 Derrick J Brashear (shadow@andrew.cmu.edu)
  * and also sound/isa/cs423x/cs4231_lib.c which is:
  * Copyright (c) by Jaroslav Kysela <perex@suse.cz>
  */
@@ -15,6 +15,9 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
 
 #include <sound/driver.h>
 #include <sound/core.h>
@@ -25,9 +28,6 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 
-#include <asm/io.h>
-#include <asm/irq.h>
-
 #ifdef CONFIG_SBUS
 #define SBUS_SUPPORT
 #include <asm/sbus.h>
@@ -41,7 +41,8 @@
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
+/* Enable this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for Sun CS4231 soundcard.");
@@ -56,19 +57,22 @@ MODULE_SUPPORTED_DEVICE("{{Sun,CS4231}}"
 
 #ifdef SBUS_SUPPORT
 struct sbus_dma_info {
-       spinlock_t      lock;
-       int             dir;
-       void __iomem    *regs;
+       spinlock_t	lock;	/* DMA access lock */
+       int		dir;
+       void __iomem	*regs;
 };
 #endif
 
 struct snd_cs4231;
 struct cs4231_dma_control {
-        void		(*prepare)(struct cs4231_dma_control *dma_cont, int dir);
-        void		(*enable)(struct cs4231_dma_control *dma_cont, int on);
-        int		(*request)(struct cs4231_dma_control *dma_cont, dma_addr_t bus_addr, size_t len);
-        unsigned int	(*address)(struct cs4231_dma_control *dma_cont);
-        void		(*preallocate)(struct snd_cs4231 *chip, struct snd_pcm *pcm); 
+	void		(*prepare)(struct cs4231_dma_control *dma_cont,
+				   int dir);
+	void		(*enable)(struct cs4231_dma_control *dma_cont, int on);
+	int		(*request)(struct cs4231_dma_control *dma_cont,
+				   dma_addr_t bus_addr, size_t len);
+	unsigned int	(*address)(struct cs4231_dma_control *dma_cont);
+	void		(*preallocate)(struct snd_cs4231 *chip,
+				       struct snd_pcm *pcm);
 #ifdef EBUS_SUPPORT
 	struct		ebus_dma_info	ebus_info;
 #endif
@@ -78,7 +82,7 @@ struct cs4231_dma_control {
 };
 
 struct snd_cs4231 {
-	spinlock_t		lock;
+	spinlock_t		lock;	/* registers access lock */
 	void __iomem		*port;
 
 	struct cs4231_dma_control	p_dma;
@@ -102,13 +106,14 @@ struct snd_cs4231 {
 #define CS4231_MODE_PLAY	0x0001
 #define CS4231_MODE_RECORD	0x0002
 #define CS4231_MODE_TIMER	0x0004
-#define CS4231_MODE_OPEN	(CS4231_MODE_PLAY|CS4231_MODE_RECORD|CS4231_MODE_TIMER)
+#define CS4231_MODE_OPEN	(CS4231_MODE_PLAY | CS4231_MODE_RECORD | \
+				 CS4231_MODE_TIMER)
 
 	unsigned char		image[32];	/* registers image */
 	int			mce_bit;
 	int			calibrate_mute;
-	struct mutex		mce_mutex;
-	struct mutex		open_mutex;
+	struct mutex		mce_mutex;	/* mutex for mce register */
+	struct mutex		open_mutex;	/* mutex for ALSA open/close */
 
 	union {
 #ifdef SBUS_SUPPORT
@@ -273,7 +278,8 @@ static u8 __cs4231_readb(struct snd_cs42
 #endif
 }
 
-static void __cs4231_writeb(struct snd_cs4231 *cp, u8 val, void __iomem *reg_addr)
+static void __cs4231_writeb(struct snd_cs4231 *cp, u8 val,
+			    void __iomem *reg_addr)
 {
 #ifdef EBUS_SUPPORT
 	if (cp->flags & CS4231_FLAG_EBUS)
@@ -301,7 +307,8 @@ static void snd_cs4231_ready(struct snd_
 	}
 }
 
-static void snd_cs4231_dout(struct snd_cs4231 *chip, unsigned char reg, unsigned char value)
+static void snd_cs4231_dout(struct snd_cs4231 *chip, unsigned char reg,
+			    unsigned char value)
 {
 	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
@@ -355,7 +362,7 @@ static void snd_cs4231_busy_wait(struct 
 {
 	int timeout;
 
-	/* huh.. looks like this sequence is proper for CS4231A chip (GUS MAX) */
+	/* looks like this sequence is proper for CS4231A chip (GUS MAX) */
 	for (timeout = 5; timeout > 0; timeout--)
 		__cs4231_readb(chip, CS4231U(chip, REGSEL));
 
@@ -382,7 +389,9 @@ static void snd_cs4231_mce_up(struct snd
 	chip->mce_bit |= CS4231_MCE;
 	timeout = __cs4231_readb(chip, CS4231U(chip, REGSEL));
 	if (timeout == 0x80)
-		snd_printdd("mce_up [%p]: serious init problem - codec still busy\n", chip->port);
+		snd_printdd("mce_up [%p]: serious init problem - "
+			    "codec still busy\n",
+			    chip->port);
 	if (!(timeout & CS4231_MCE))
 		__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f),
 				CS4231U(chip, REGSEL));
@@ -406,7 +415,9 @@ static void snd_cs4231_mce_down(struct s
 	__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f),
 			CS4231U(chip, REGSEL));
 	if (timeout == 0x80)
-		snd_printdd("mce_down [%p]: serious init problem - codec still busy\n", chip->port);
+		snd_printdd("mce_down [%p]: serious init problem - "
+			    "codec still busy\n",
+			    chip->port);
 	if ((timeout & CS4231_MCE) == 0) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		return;
@@ -417,7 +428,8 @@ static void snd_cs4231_mce_down(struct s
 
 	snd_cs4231_ready(chip);
 	snd_cs4231_ready(chip);
-	if ((snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0) {
+	timeout = snd_cs4231_in(chip, CS4231_TEST_INIT);
+	if ((timeout & CS4231_CALIB_IN_PROGRESS) == 0) {
 		snd_printd("cs4231_mce_down - auto calibration time out (1)\n");
 		spin_unlock_irqrestore(&chip->lock, flags);
 		return;
@@ -425,10 +437,13 @@ static void snd_cs4231_mce_down(struct s
 
 	/* in 10ms increments, check condition, up to 250ms */
 	timeout = 25;
-	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
+	while (snd_cs4231_in(chip, CS4231_TEST_INIT) &
+		CS4231_CALIB_IN_PROGRESS) {
+
 		spin_unlock_irqrestore(&chip->lock, flags);
 		if (--timeout < 0) {
-			snd_printk("mce_down - auto calibration time out (2)\n");
+			snd_printk("mce_down - "
+				   "auto calibration time out (2)\n");
 			return;
 		}
 		msleep(10);
@@ -440,7 +455,8 @@ static void snd_cs4231_mce_down(struct s
 	while (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		if (--timeout < 0) {
-			snd_printk("mce_down - auto calibration time out (3)\n");
+			snd_printk("mce_down - "
+				   "auto calibration time out (3)\n");
 			return;
 		}
 		msleep(10);
@@ -461,7 +477,8 @@ static void snd_cs4231_advance_dma(struc
 
 		BUG_ON(period_size >= (1 << 24));
 
-		if (dma_cont->request(dma_cont, runtime->dma_addr + offset, period_size))
+		if (dma_cont->request(dma_cont,
+				      runtime->dma_addr + offset, period_size))
 			return;
 		(*periods_sent) = ((*periods_sent) + 1) % runtime->periods;
 	}
@@ -554,21 +571,32 @@ static unsigned char snd_cs4231_get_rate
 	for (i = 0; i < 14; i++)
 		if (rate == rates[i])
 			return freq_bits[i];
-	// snd_BUG();
+
 	return freq_bits[13];
 }
 
-static unsigned char snd_cs4231_get_format(struct snd_cs4231 *chip, int format, int channels)
+static unsigned char snd_cs4231_get_format(struct snd_cs4231 *chip, int format,
+					   int channels)
 {
 	unsigned char rformat;
 
 	rformat = CS4231_LINEAR_8;
 	switch (format) {
-	case SNDRV_PCM_FORMAT_MU_LAW:	rformat = CS4231_ULAW_8; break;
-	case SNDRV_PCM_FORMAT_A_LAW:	rformat = CS4231_ALAW_8; break;
-	case SNDRV_PCM_FORMAT_S16_LE:	rformat = CS4231_LINEAR_16; break;
-	case SNDRV_PCM_FORMAT_S16_BE:	rformat = CS4231_LINEAR_16_BIG; break;
-	case SNDRV_PCM_FORMAT_IMA_ADPCM:	rformat = CS4231_ADPCM_16; break;
+	case SNDRV_PCM_FORMAT_MU_LAW:
+		rformat = CS4231_ULAW_8;
+		break;
+	case SNDRV_PCM_FORMAT_A_LAW:
+		rformat = CS4231_ALAW_8;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		rformat = CS4231_LINEAR_16;
+		break;
+	case SNDRV_PCM_FORMAT_S16_BE:
+		rformat = CS4231_LINEAR_16_BIG;
+		break;
+	case SNDRV_PCM_FORMAT_IMA_ADPCM:
+		rformat = CS4231_ADPCM_16;
+		break;
 	}
 	if (channels > 1)
 		rformat |= CS4231_STEREO;
@@ -615,7 +643,8 @@ static void snd_cs4231_calibrate_mute(st
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
-static void snd_cs4231_playback_format(struct snd_cs4231 *chip, struct snd_pcm_hw_params *params,
+static void snd_cs4231_playback_format(struct snd_cs4231 *chip,
+				       struct snd_pcm_hw_params *params,
 				       unsigned char pdfr)
 {
 	unsigned long flags;
@@ -638,8 +667,9 @@ static void snd_cs4231_playback_format(s
 	mutex_unlock(&chip->mce_mutex);
 }
 
-static void snd_cs4231_capture_format(struct snd_cs4231 *chip, struct snd_pcm_hw_params *params,
-                                      unsigned char cdfr)
+static void snd_cs4231_capture_format(struct snd_cs4231 *chip,
+				      struct snd_pcm_hw_params *params,
+				      unsigned char cdfr)
 {
 	unsigned long flags;
 
@@ -696,7 +726,8 @@ static int snd_cs4231_timer_start(struct
 			       chip->image[CS4231_TIMER_LOW] =
 			       (unsigned char) ticks);
 		snd_cs4231_out(chip, CS4231_ALT_FEATURE_1,
-			       chip->image[CS4231_ALT_FEATURE_1] | CS4231_TIMER_ENABLE);
+			       chip->image[CS4231_ALT_FEATURE_1] |
+					CS4231_TIMER_ENABLE);
 	}
 	spin_unlock_irqrestore(&chip->lock, flags);
 
@@ -709,8 +740,9 @@ static int snd_cs4231_timer_stop(struct 
 	struct snd_cs4231 *chip = snd_timer_chip(timer);
 
 	spin_lock_irqsave(&chip->lock, flags);
+	chip->image[CS4231_ALT_FEATURE_1] &= ~CS4231_TIMER_ENABLE;
 	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1,
-		       chip->image[CS4231_ALT_FEATURE_1] &= ~CS4231_TIMER_ENABLE);
+		       chip->image[CS4231_ALT_FEATURE_1]);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
@@ -727,8 +759,10 @@ static void __init snd_cs4231_init(struc
 #endif
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->lock, flags);
-	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
-					    CS4231_RECORD_ENABLE | CS4231_RECORD_PIO |
+	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
+					    CS4231_PLAYBACK_PIO |
+					    CS4231_RECORD_ENABLE |
+					    CS4231_RECORD_PIO |
 					    CS4231_CALIB_MODE);
 	chip->image[CS4231_IFACE_CTRL] |= CS4231_AUTOCALIB;
 	snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
@@ -741,21 +775,25 @@ static void __init snd_cs4231_init(struc
 
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->lock, flags);
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1]);
+	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1,
+			chip->image[CS4231_ALT_FEATURE_1]);
 	spin_unlock_irqrestore(&chip->lock, flags);
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printdd("init: (3) - afei = 0x%x\n", chip->image[CS4231_ALT_FEATURE_1]);
+	snd_printdd("init: (3) - afei = 0x%x\n",
+		    chip->image[CS4231_ALT_FEATURE_1]);
 #endif
 
 	spin_lock_irqsave(&chip->lock, flags);
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_2, chip->image[CS4231_ALT_FEATURE_2]);
+	snd_cs4231_out(chip, CS4231_ALT_FEATURE_2,
+			chip->image[CS4231_ALT_FEATURE_2]);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->lock, flags);
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT]);
+	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
+			chip->image[CS4231_PLAYBK_FORMAT]);
 	spin_unlock_irqrestore(&chip->lock, flags);
 	snd_cs4231_mce_down(chip);
 
@@ -838,7 +876,8 @@ static void snd_cs4231_close(struct snd_
 		chip->image[CS4231_IFACE_CTRL] &=
 			~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
 			  CS4231_RECORD_ENABLE | CS4231_RECORD_PIO);
-		snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
+		snd_cs4231_out(chip, CS4231_IFACE_CTRL,
+				chip->image[CS4231_IFACE_CTRL]);
 		spin_unlock_irqrestore(&chip->lock, flags);
 		snd_cs4231_mce_down(chip);
 		spin_lock_irqsave(&chip->lock, flags);
@@ -867,15 +906,14 @@ static int snd_cs4231_timer_open(struct 
 	return 0;
 }
 
-static int snd_cs4231_timer_close(struct snd_timer * timer)
+static int snd_cs4231_timer_close(struct snd_timer *timer)
 {
 	struct snd_cs4231 *chip = snd_timer_chip(timer);
 	snd_cs4231_close(chip, CS4231_MODE_TIMER);
 	return 0;
 }
 
-static struct snd_timer_hardware snd_cs4231_timer_table =
-{
+static struct snd_timer_hardware snd_cs4231_timer_table = {
 	.flags		=	SNDRV_TIMER_HW_AUTO,
 	.resolution	=	9945,
 	.ticks		=	65535,
@@ -897,8 +935,9 @@ static int snd_cs4231_playback_hw_params
 	unsigned char new_pdfr;
 	int err;
 
-	if ((err = snd_pcm_lib_malloc_pages(substream,
-					    params_buffer_bytes(hw_params))) < 0)
+	err = snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+	if (err < 0)
 		return err;
 	new_pdfr = snd_cs4231_get_format(chip, params_format(hw_params),
 					 params_channels(hw_params)) |
@@ -934,8 +973,9 @@ static int snd_cs4231_capture_hw_params(
 	unsigned char new_cdfr;
 	int err;
 
-	if ((err = snd_pcm_lib_malloc_pages(substream,
-					    params_buffer_bytes(hw_params))) < 0)
+	err = snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+	if (err < 0)
 		return err;
 	new_cdfr = snd_cs4231_get_format(chip, params_format(hw_params),
 					 params_channels(hw_params)) |
@@ -970,7 +1010,8 @@ static void snd_cs4231_overrange(struct 
 	res = snd_cs4231_in(chip, CS4231_TEST_INIT);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
-	if (res & (0x08 | 0x02))	/* detect overrange only above 0dB; may be user selectable? */
+	/* detect overrange only above 0dB; may be user selectable? */
+	if (res & (0x08 | 0x02))
 		chip->capture_substream->runtime->overrange++;
 }
 
@@ -992,47 +1033,50 @@ static void snd_cs4231_capture_callback(
 	}
 }
 
-static snd_pcm_uframes_t snd_cs4231_playback_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t snd_cs4231_playback_pointer
+					(struct snd_pcm_substream *substream)
 {
 	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
 	struct cs4231_dma_control *dma_cont = &chip->p_dma;
 	size_t ptr;
-	
+
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE))
 		return 0;
 	ptr = dma_cont->address(dma_cont);
 	if (ptr != 0)
 		ptr -= substream->runtime->dma_addr;
-	
+
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-static snd_pcm_uframes_t snd_cs4231_capture_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t snd_cs4231_capture_pointer
+					(struct snd_pcm_substream *substream)
 {
 	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
 	struct cs4231_dma_control *dma_cont = &chip->c_dma;
 	size_t ptr;
-	
+
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE))
 		return 0;
 	ptr = dma_cont->address(dma_cont);
 	if (ptr != 0)
 		ptr -= substream->runtime->dma_addr;
-	
+
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
 static int __init snd_cs4231_probe(struct snd_cs4231 *chip)
 {
 	unsigned long flags;
-	int i, id, vers;
+	int i;
+	int id = 0;
+	int vers = 0;
 	unsigned char *ptr;
 
-	id = vers = 0;
 	for (i = 0; i < 50; i++) {
 		mb();
 		if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
-			udelay(2000);
+			msleep(2);
 		else {
 			spin_lock_irqsave(&chip->lock, flags);
 			snd_cs4231_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
@@ -1084,42 +1128,50 @@ static int __init snd_cs4231_probe(struc
 	return 0;		/* all things are ok.. */
 }
 
-static struct snd_pcm_hardware snd_cs4231_playback =
-{
-	.info			= (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
-				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_SYNC_START),
-	.formats		= (SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW |
-				 SNDRV_PCM_FMTBIT_IMA_ADPCM |
-				 SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE |
-				 SNDRV_PCM_FMTBIT_S16_BE),
-	.rates			= SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_48000,
+static struct snd_pcm_hardware snd_cs4231_playback = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_SYNC_START,
+	.formats		= SNDRV_PCM_FMTBIT_MU_LAW |
+				  SNDRV_PCM_FMTBIT_A_LAW |
+				  SNDRV_PCM_FMTBIT_IMA_ADPCM |
+				  SNDRV_PCM_FMTBIT_U8 |
+				  SNDRV_PCM_FMTBIT_S16_LE |
+				  SNDRV_PCM_FMTBIT_S16_BE,
+	.rates			= SNDRV_PCM_RATE_KNOT |
+				  SNDRV_PCM_RATE_8000_48000,
 	.rate_min		= 5510,
 	.rate_max		= 48000,
 	.channels_min		= 1,
 	.channels_max		= 2,
-	.buffer_bytes_max	= (32*1024),
+	.buffer_bytes_max	= 32 * 1024,
 	.period_bytes_min	= 64,
-	.period_bytes_max	= (32*1024),
+	.period_bytes_max	= 32 * 1024,
 	.periods_min		= 1,
 	.periods_max		= 1024,
 };
 
-static struct snd_pcm_hardware snd_cs4231_capture =
-{
-	.info			= (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
-				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_SYNC_START),
-	.formats		= (SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW |
-				 SNDRV_PCM_FMTBIT_IMA_ADPCM |
-				 SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE |
-				 SNDRV_PCM_FMTBIT_S16_BE),
-	.rates			= SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_48000,
+static struct snd_pcm_hardware snd_cs4231_capture = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_SYNC_START,
+	.formats		= SNDRV_PCM_FMTBIT_MU_LAW |
+				  SNDRV_PCM_FMTBIT_A_LAW |
+				  SNDRV_PCM_FMTBIT_IMA_ADPCM |
+				  SNDRV_PCM_FMTBIT_U8 |
+				  SNDRV_PCM_FMTBIT_S16_LE |
+				  SNDRV_PCM_FMTBIT_S16_BE,
+	.rates			= SNDRV_PCM_RATE_KNOT |
+				  SNDRV_PCM_RATE_8000_48000,
 	.rate_min		= 5510,
 	.rate_max		= 48000,
 	.channels_min		= 1,
 	.channels_max		= 2,
-	.buffer_bytes_max	= (32*1024),
+	.buffer_bytes_max	= 32 * 1024,
 	.period_bytes_min	= 64,
-	.period_bytes_max	= (32*1024),
+	.period_bytes_max	= 32 * 1024,
 	.periods_min		= 1,
 	.periods_max		= 1024,
 };
@@ -1132,7 +1184,8 @@ static int snd_cs4231_playback_open(stru
 
 	runtime->hw = snd_cs4231_playback;
 
-	if ((err = snd_cs4231_open(chip, CS4231_MODE_PLAY)) < 0) {
+	err = snd_cs4231_open(chip, CS4231_MODE_PLAY);
+	if (err < 0) {
 		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
 		return err;
 	}
@@ -1152,7 +1205,8 @@ static int snd_cs4231_capture_open(struc
 
 	runtime->hw = snd_cs4231_capture;
 
-	if ((err = snd_cs4231_open(chip, CS4231_MODE_RECORD)) < 0) {
+	err = snd_cs4231_open(chip, CS4231_MODE_RECORD);
+	if (err < 0) {
 		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
 		return err;
 	}
@@ -1220,9 +1274,11 @@ static int __init snd_cs4231_pcm(struct 
 	if (err < 0)
 		return err;
 
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_cs4231_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_cs4231_capture_ops);
-	
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_cs4231_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_cs4231_capture_ops);
+
 	/* global setup */
 	pcm->private_data = chip;
 	pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX;
@@ -1258,7 +1314,7 @@ static int __init snd_cs4231_timer(struc
 
 	return 0;
 }
-	
+
 /*
  *  MIXER part
  */
@@ -1275,7 +1331,8 @@ static int snd_cs4231_info_mux(struct sn
 	uinfo->value.enumerated.items = 4;
 	if (uinfo->value.enumerated.item > 3)
 		uinfo->value.enumerated.item = 3;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
 
 	return 0;
 }
@@ -1285,7 +1342,7 @@ static int snd_cs4231_get_mux(struct snd
 {
 	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&chip->lock, flags);
 	ucontrol->value.enumerated.item[0] =
 		(chip->image[CS4231_LEFT_INPUT] & CS4231_MIXS_ALL) >> 6;
@@ -1303,7 +1360,7 @@ static int snd_cs4231_put_mux(struct snd
 	unsigned long flags;
 	unsigned short left, right;
 	int change;
-	
+
 	if (ucontrol->value.enumerated.item[0] > 3 ||
 	    ucontrol->value.enumerated.item[1] > 3)
 		return -EINVAL;
@@ -1315,7 +1372,7 @@ static int snd_cs4231_put_mux(struct snd
 	left = (chip->image[CS4231_LEFT_INPUT] & ~CS4231_MIXS_ALL) | left;
 	right = (chip->image[CS4231_RIGHT_INPUT] & ~CS4231_MIXS_ALL) | right;
 	change = left != chip->image[CS4231_LEFT_INPUT] ||
-	         right != chip->image[CS4231_RIGHT_INPUT];
+		 right != chip->image[CS4231_RIGHT_INPUT];
 	snd_cs4231_out(chip, CS4231_LEFT_INPUT, left);
 	snd_cs4231_out(chip, CS4231_RIGHT_INPUT, right);
 
@@ -1347,7 +1404,7 @@ static int snd_cs4231_get_single(struct 
 	int shift = (kcontrol->private_value >> 8) & 0xff;
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0xff;
-	
+
 	spin_lock_irqsave(&chip->lock, flags);
 
 	ucontrol->value.integer.value[0] = (chip->image[reg] >> shift) & mask;
@@ -1372,7 +1429,7 @@ static int snd_cs4231_put_single(struct 
 	int invert = (kcontrol->private_value >> 24) & 0xff;
 	int change;
 	unsigned short val;
-	
+
 	val = (ucontrol->value.integer.value[0] & mask);
 	if (invert)
 		val = mask - val;
@@ -1414,11 +1471,13 @@ static int snd_cs4231_get_double(struct 
 	int shift_right = (kcontrol->private_value >> 19) & 0x07;
 	int mask = (kcontrol->private_value >> 24) & 0xff;
 	int invert = (kcontrol->private_value >> 22) & 1;
-	
+
 	spin_lock_irqsave(&chip->lock, flags);
 
-	ucontrol->value.integer.value[0] = (chip->image[left_reg] >> shift_left) & mask;
-	ucontrol->value.integer.value[1] = (chip->image[right_reg] >> shift_right) & mask;
+	ucontrol->value.integer.value[0] =
+		(chip->image[left_reg] >> shift_left) & mask;
+	ucontrol->value.integer.value[1] =
+		(chip->image[right_reg] >> shift_right) & mask;
 
 	spin_unlock_irqrestore(&chip->lock, flags);
 
@@ -1445,7 +1504,7 @@ static int snd_cs4231_put_double(struct 
 	int invert = (kcontrol->private_value >> 22) & 1;
 	int change;
 	unsigned short val1, val2;
-	
+
 	val1 = ucontrol->value.integer.value[0] & mask;
 	val2 = ucontrol->value.integer.value[1] & mask;
 	if (invert) {
@@ -1459,7 +1518,8 @@ static int snd_cs4231_put_double(struct 
 
 	val1 = (chip->image[left_reg] & ~(mask << shift_left)) | val1;
 	val2 = (chip->image[right_reg] & ~(mask << shift_right)) | val2;
-	change = val1 != chip->image[left_reg] || val2 != chip->image[right_reg];
+	change = val1 != chip->image[left_reg];
+	change |= val2 != chip->image[right_reg];
 	snd_cs4231_out(chip, left_reg, val1);
 	snd_cs4231_out(chip, right_reg, val2);
 
@@ -1469,31 +1529,42 @@ static int snd_cs4231_put_double(struct 
 }
 
 #define CS4231_SINGLE(xname, xindex, reg, shift, mask, invert) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_cs4231_info_single, \
-  .get = snd_cs4231_get_single, .put = snd_cs4231_put_single, \
-  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24) }
-
-#define CS4231_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_cs4231_info_double, \
-  .get = snd_cs4231_get_double, .put = snd_cs4231_put_double, \
-  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22) }
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), .index = (xindex), \
+  .info = snd_cs4231_info_single,	\
+  .get = snd_cs4231_get_single, .put = snd_cs4231_put_single,	\
+  .private_value = (reg) | ((shift) << 8) | ((mask) << 16) | ((invert) << 24) }
+
+#define CS4231_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, \
+			shift_right, mask, invert) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), .index = (xindex), \
+  .info = snd_cs4231_info_double,	\
+  .get = snd_cs4231_get_double, .put = snd_cs4231_put_double,	\
+  .private_value = (left_reg) | ((right_reg) << 8) | ((shift_left) << 16) | \
+		   ((shift_right) << 19) | ((mask) << 24) | ((invert) << 22) }
 
 static struct snd_kcontrol_new snd_cs4231_controls[] __initdata = {
-CS4231_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Playback Volume", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
-CS4231_DOUBLE("Line Playback Switch", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-CS4231_DOUBLE("Line Playback Volume", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
-CS4231_DOUBLE("Aux Playback Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("Aux Playback Switch", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT,
+		CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("PCM Playback Volume", 0, CS4231_LEFT_OUTPUT,
+		CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+CS4231_DOUBLE("Line Playback Switch", 0, CS4231_LEFT_LINE_IN,
+		CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
+CS4231_DOUBLE("Line Playback Volume", 0, CS4231_LEFT_LINE_IN,
+		CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
+CS4231_DOUBLE("Aux Playback Switch", 0, CS4231_AUX1_LEFT_INPUT,
+		CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Playback Volume", 0, CS4231_AUX1_LEFT_INPUT,
+		CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("Aux Playback Switch", 1, CS4231_AUX2_LEFT_INPUT,
+		CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Playback Volume", 1, CS4231_AUX2_LEFT_INPUT,
+		CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
 CS4231_SINGLE("Mono Playback Switch", 0, CS4231_MONO_CTRL, 7, 1, 1),
 CS4231_SINGLE("Mono Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
 CS4231_SINGLE("Mono Output Playback Switch", 0, CS4231_MONO_CTRL, 6, 1, 1),
 CS4231_SINGLE("Mono Output Playback Bypass", 0, CS4231_MONO_CTRL, 5, 1, 0),
-CS4231_DOUBLE("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
+CS4231_DOUBLE("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0,
+		15, 0),
 {
 	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name	= "Capture Source",
@@ -1501,14 +1572,15 @@ CS4231_DOUBLE("Capture Volume", 0, CS423
 	.get	= snd_cs4231_get_mux,
 	.put	= snd_cs4231_put_mux,
 },
-CS4231_DOUBLE("Mic Boost", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
+CS4231_DOUBLE("Mic Boost", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5,
+		1, 0),
 CS4231_SINGLE("Loopback Capture Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
 CS4231_SINGLE("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1),
 /* SPARC specific uses of XCTL{0,1} general purpose outputs.  */
 CS4231_SINGLE("Line Out Switch", 0, CS4231_PIN_CTRL, 6, 1, 1),
 CS4231_SINGLE("Headphone Out Switch", 0, CS4231_PIN_CTRL, 7, 1, 1)
 };
-                                        
+
 static int __init snd_cs4231_mixer(struct snd_card *card)
 {
 	struct snd_cs4231 *chip = card->private_data;
@@ -1609,24 +1681,24 @@ static irqreturn_t snd_cs4231_sbus_inter
 
 	sbus_writel(csr, chip->port + APCCSR);
 
-	if ((csr & APC_PDMA_READY) && 
- 	    (csr & APC_PLAY_INT) &&
+	if ((csr & APC_PDMA_READY) &&
+	    (csr & APC_PLAY_INT) &&
 	    (csr & APC_XINT_PNVA) &&
 	    !(csr & APC_XINT_EMPT))
 			snd_cs4231_play_callback(chip);
 
-	if ((csr & APC_CDMA_READY) && 
-  	    (csr & APC_CAPT_INT) &&
+	if ((csr & APC_CDMA_READY) &&
+	    (csr & APC_CAPT_INT) &&
 	    (csr & APC_XINT_CNVA) &&
 	    !(csr & APC_XINT_EMPT))
 			snd_cs4231_capture_callback(chip);
-	
+
 	status = snd_cs4231_in(chip, CS4231_IRQ_STATUS);
 
 	if (status & CS4231_TIMER_IRQ) {
 		if (chip->timer)
 			snd_timer_interrupt(chip->timer, chip->timer->sticks);
-	}		
+	}
 
 	if ((status & CS4231_RECORD_IRQ) && (csr & APC_CDMA_READY))
 		snd_cs4231_overrange(chip);
@@ -1643,26 +1715,27 @@ static irqreturn_t snd_cs4231_sbus_inter
  * SBUS DMA routines
  */
 
-static int sbus_dma_request(struct cs4231_dma_control *dma_cont, dma_addr_t bus_addr, size_t len)
+static int sbus_dma_request(struct cs4231_dma_control *dma_cont,
+			    dma_addr_t bus_addr, size_t len)
 {
 	unsigned long flags;
 	u32 test, csr;
 	int err;
 	struct sbus_dma_info *base = &dma_cont->sbus_info;
-	
+
 	if (len >= (1 << 24))
 		return -EINVAL;
 	spin_lock_irqsave(&base->lock, flags);
 	csr = sbus_readl(base->regs + APCCSR);
 	err = -EINVAL;
 	test = APC_CDMA_READY;
-	if ( base->dir == APC_PLAY )
+	if (base->dir == APC_PLAY)
 		test = APC_PDMA_READY;
 	if (!(csr & test))
 		goto out;
 	err = -EBUSY;
 	test = APC_XINT_CNVA;
-	if ( base->dir == APC_PLAY )
+	if (base->dir == APC_PLAY)
 		test = APC_XINT_PNVA;
 	if (!(csr & test))
 		goto out;
@@ -1685,7 +1758,7 @@ static void sbus_dma_prepare(struct cs42
 	test =  APC_GENL_INT | APC_PLAY_INT | APC_XINT_ENA |
 		APC_XINT_PLAY | APC_XINT_PEMP | APC_XINT_GENL |
 		 APC_XINT_PENA;
-	if ( base->dir == APC_RECORD )
+	if (base->dir == APC_RECORD)
 		test = APC_GENL_INT | APC_CAPT_INT | APC_XINT_ENA |
 			APC_XINT_CAPT | APC_XINT_CEMP | APC_XINT_GENL;
 	csr |= test;
@@ -1703,28 +1776,28 @@ static void sbus_dma_enable(struct cs423
 	if (!on) {
 		sbus_writel(0, base->regs + base->dir + APCNC);
 		sbus_writel(0, base->regs + base->dir + APCNVA);
-		if ( base->dir == APC_PLAY ) {
+		if (base->dir == APC_PLAY) {
 			sbus_writel(0, base->regs + base->dir + APCC);
 			sbus_writel(0, base->regs + base->dir + APCVA);
 		}
 
 		udelay(1200);
-	} 
+	}
 	csr = sbus_readl(base->regs + APCCSR);
 	shift = 0;
-	if ( base->dir == APC_PLAY )
+	if (base->dir == APC_PLAY)
 		shift = 1;
 	if (on)
 		csr &= ~(APC_CPAUSE << shift);
 	else
-		csr |= (APC_CPAUSE << shift); 
+		csr |= (APC_CPAUSE << shift);
 	sbus_writel(csr, base->regs + APCCSR);
 	if (on)
 		csr |= (APC_CDMA_READY << shift);
 	else
 		csr &= ~(APC_CDMA_READY << shift);
 	sbus_writel(csr, base->regs + APCCSR);
-	
+
 	spin_unlock_irqrestore(&base->lock, flags);
 }
 
@@ -1732,14 +1805,14 @@ static unsigned int sbus_dma_addr(struct
 {
 	struct sbus_dma_info *base = &dma_cont->sbus_info;
 
-        return sbus_readl(base->regs + base->dir + APCVA);
+	return sbus_readl(base->regs + base->dir + APCVA);
 }
 
 static void sbus_dma_preallocate(struct snd_cs4231 *chip, struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_SBUS,
-					      snd_dma_sbus_data(chip->dev_u.sdev),
-					      64*1024, 128*1024);
+					snd_dma_sbus_data(chip->dev_u.sdev),
+					64 * 1024, 128 * 1024);
 }
 
 /*
@@ -1861,14 +1934,16 @@ static int __init cs4231_sbus_attach(str
 
 #ifdef EBUS_SUPPORT
 
-static void snd_cs4231_ebus_play_callback(struct ebus_dma_info *p, int event, void *cookie)
+static void snd_cs4231_ebus_play_callback(struct ebus_dma_info *p, int event,
+					  void *cookie)
 {
 	struct snd_cs4231 *chip = cookie;
-	
+
 	snd_cs4231_play_callback(chip);
 }
 
-static void snd_cs4231_ebus_capture_callback(struct ebus_dma_info *p, int event, void *cookie)
+static void snd_cs4231_ebus_capture_callback(struct ebus_dma_info *p,
+					     int event, void *cookie)
 {
 	struct snd_cs4231 *chip = cookie;
 
@@ -1879,7 +1954,8 @@ static void snd_cs4231_ebus_capture_call
  * EBUS DMA wrappers
  */
 
-static int _ebus_dma_request(struct cs4231_dma_control *dma_cont, dma_addr_t bus_addr, size_t len)
+static int _ebus_dma_request(struct cs4231_dma_control *dma_cont,
+			     dma_addr_t bus_addr, size_t len)
 {
 	return ebus_dma_request(&dma_cont->ebus_info, bus_addr, len);
 }
@@ -1980,7 +2056,8 @@ static int __init snd_cs4231_ebus_create
 	chip->port = ioremap(edev->resource[0].start, 0x10);
 	chip->p_dma.ebus_info.regs = ioremap(edev->resource[1].start, 0x10);
 	chip->c_dma.ebus_info.regs = ioremap(edev->resource[2].start, 0x10);
-	if (!chip->port || !chip->p_dma.ebus_info.regs || !chip->c_dma.ebus_info.regs) {
+	if (!chip->port || !chip->p_dma.ebus_info.regs ||
+	    !chip->c_dma.ebus_info.regs) {
 		snd_cs4231_ebus_free(chip);
 		snd_printdd("cs4231-%d: Unable to map chip registers.\n", dev);
 		return -EIO;
@@ -1988,18 +2065,21 @@ static int __init snd_cs4231_ebus_create
 
 	if (ebus_dma_register(&chip->c_dma.ebus_info)) {
 		snd_cs4231_ebus_free(chip);
-		snd_printdd("cs4231-%d: Unable to register EBUS capture DMA\n", dev);
+		snd_printdd("cs4231-%d: Unable to register EBUS capture DMA\n",
+			    dev);
 		return -EBUSY;
 	}
 	if (ebus_dma_irq_enable(&chip->c_dma.ebus_info, 1)) {
 		snd_cs4231_ebus_free(chip);
-		snd_printdd("cs4231-%d: Unable to enable EBUS capture IRQ\n", dev);
+		snd_printdd("cs4231-%d: Unable to enable EBUS capture IRQ\n",
+			    dev);
 		return -EBUSY;
 	}
 
 	if (ebus_dma_register(&chip->p_dma.ebus_info)) {
 		snd_cs4231_ebus_free(chip);
-		snd_printdd("cs4231-%d: Unable to register EBUS play DMA\n", dev);
+		snd_printdd("cs4231-%d: Unable to register EBUS play DMA\n",
+			    dev);
 		return -EBUSY;
 	}
 	if (ebus_dma_irq_enable(&chip->p_dma.ebus_info, 1)) {
