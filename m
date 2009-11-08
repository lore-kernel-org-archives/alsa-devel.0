From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] es18xx: code improvements
Date: Sun, 8 Nov 2009 11:58:08 +0100
Message-ID: <20091108115808.d3b7061f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 1A8FC24158
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 10:55:15 +0100 (CET)
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

1. Set the third argument of the snd_device_new to not NULL, so there is
   no warning about bug during chip detection. The third argument is not
   used in this driver. It was changed in my previous patch.

2. Remove the fm_port and mpu_port fields from the snd_es18xx structure.
   They can be converted to function arguments.

3. Remove the dmaN_size fields from the snd_es18xx structure. These
   values are used only in pointer functions and can be easily calculated.

4. Remove the ctrl_lock spinlock which is used only in one read function
   which is called once during chip initialization. There are many
   writes to the same register and they are not protected on purpose
   (see the comment ina the snd_es18xx_config_write()).

5. Use the first part of the text5Sources string table as the text4Soruces
   table (they are the same).

6. Merge the same cases for the ES1887 and ES1888 when setting chip's caps.

7. Move the snd_es18xx_reset() to __devinit section.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/es18xx.c |   91 +++++++++++++++++++++++----------------------------
 1 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 5cf42b4..06e871e 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -102,8 +102,6 @@
 
 struct snd_es18xx {
 	unsigned long port;		/* port of ESS chip */
-	unsigned long mpu_port;		/* MPU-401 port of ESS chip */
-	unsigned long fm_port;		/* FM port */
 	unsigned long ctrl_port;	/* Control port of ESS chip */
 	struct resource *res_port;
 	struct resource *res_mpu_port;
@@ -116,8 +114,6 @@ struct snd_es18xx {
 	unsigned short audio2_vol;	/* volume level of audio2 */
 
 	unsigned short active;		/* active channel mask */
-	unsigned int dma1_size;
-	unsigned int dma2_size;
 	unsigned int dma1_shift;
 	unsigned int dma2_shift;
 
@@ -135,7 +131,6 @@ struct snd_es18xx {
 
 	spinlock_t reg_lock;
 	spinlock_t mixer_lock;
-	spinlock_t ctrl_lock;
 #ifdef CONFIG_PM
 	unsigned char pm_reg;
 #endif
@@ -354,7 +349,7 @@ static inline int snd_es18xx_mixer_writable(struct snd_es18xx *chip, unsigned ch
 }
 
 
-static int snd_es18xx_reset(struct snd_es18xx *chip)
+static int __devinit snd_es18xx_reset(struct snd_es18xx *chip)
 {
 	int i;
         outb(0x03, chip->port + 0x06);
@@ -490,8 +485,6 @@ static int snd_es18xx_playback1_prepare(struct snd_es18xx *chip,
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
 
-	chip->dma2_size = size;
-
         snd_es18xx_rate_set(chip, substream, DAC2);
 
         /* Transfer Count Reload */
@@ -591,8 +584,6 @@ static int snd_es18xx_capture_prepare(struct snd_pcm_substream *substream)
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
 
-	chip->dma1_size = size;
-
 	snd_es18xx_reset_fifo(chip);
 
         /* Set stereo/mono */
@@ -659,8 +650,6 @@ static int snd_es18xx_playback2_prepare(struct snd_es18xx *chip,
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
 
-	chip->dma1_size = size;
-
 	snd_es18xx_reset_fifo(chip);
 
         /* Set stereo/mono */
@@ -821,17 +810,18 @@ static irqreturn_t snd_es18xx_interrupt(int irq, void *dev_id)
 static snd_pcm_uframes_t snd_es18xx_playback_pointer(struct snd_pcm_substream *substream)
 {
         struct snd_es18xx *chip = snd_pcm_substream_chip(substream);
+	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	int pos;
 
 	if (substream->number == 0 && (chip->caps & ES18XX_PCM2)) {
 		if (!(chip->active & DAC2))
 			return 0;
-		pos = snd_dma_pointer(chip->dma2, chip->dma2_size);
+		pos = snd_dma_pointer(chip->dma2, size);
 		return pos >> chip->dma2_shift;
 	} else {
 		if (!(chip->active & DAC1))
 			return 0;
-		pos = snd_dma_pointer(chip->dma1, chip->dma1_size);
+		pos = snd_dma_pointer(chip->dma1, size);
 		return pos >> chip->dma1_shift;
 	}
 }
@@ -839,11 +829,12 @@ static snd_pcm_uframes_t snd_es18xx_playback_pointer(struct snd_pcm_substream *s
 static snd_pcm_uframes_t snd_es18xx_capture_pointer(struct snd_pcm_substream *substream)
 {
         struct snd_es18xx *chip = snd_pcm_substream_chip(substream);
+	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	int pos;
 
         if (!(chip->active & ADC1))
                 return 0;
-	pos = snd_dma_pointer(chip->dma1, chip->dma1_size);
+	pos = snd_dma_pointer(chip->dma1, size);
 	return pos >> chip->dma1_shift;
 }
 
@@ -974,9 +965,6 @@ static int snd_es18xx_capture_close(struct snd_pcm_substream *substream)
 
 static int snd_es18xx_info_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts4Source[4] = {
-		"Mic", "CD", "Line", "Master"
-	};
 	static char *texts5Source[5] = {
 		"Mic", "CD", "Line", "Master", "Mix"
 	};
@@ -994,7 +982,8 @@ static int snd_es18xx_info_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 		uinfo->value.enumerated.items = 4;
 		if (uinfo->value.enumerated.item > 3)
 			uinfo->value.enumerated.item = 3;
-		strcpy(uinfo->value.enumerated.name, texts4Source[uinfo->value.enumerated.item]);
+		strcpy(uinfo->value.enumerated.name,
+			texts5Source[uinfo->value.enumerated.item]);
 		break;
 	case 0x1887:
 	case 0x1888:
@@ -1378,11 +1367,9 @@ ES18XX_SINGLE("Hardware Master Volume Split", 0, 0x64, 7, 1, 0),
 static int __devinit snd_es18xx_config_read(struct snd_es18xx *chip, unsigned char reg)
 {
 	int data;
-	unsigned long flags;
-        spin_lock_irqsave(&chip->ctrl_lock, flags);
+
 	outb(reg, chip->ctrl_port);
 	data = inb(chip->ctrl_port + 1);
-        spin_unlock_irqrestore(&chip->ctrl_lock, flags);
 	return data;
 }
 
@@ -1398,7 +1385,9 @@ static void __devinit snd_es18xx_config_write(struct snd_es18xx *chip,
 #endif
 }
 
-static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip)
+static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip,
+					   unsigned long mpu_port,
+					   unsigned long fm_port)
 {
 	int mask = 0;
 
@@ -1412,15 +1401,15 @@ static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip)
 	if (chip->caps & ES18XX_CONTROL) {
 		/* Hardware volume IRQ */
 		snd_es18xx_config_write(chip, 0x27, chip->irq);
-		if (chip->fm_port > 0 && chip->fm_port != SNDRV_AUTO_PORT) {
+		if (fm_port > 0 && fm_port != SNDRV_AUTO_PORT) {
 			/* FM I/O */
-			snd_es18xx_config_write(chip, 0x62, chip->fm_port >> 8);
-			snd_es18xx_config_write(chip, 0x63, chip->fm_port & 0xff);
+			snd_es18xx_config_write(chip, 0x62, fm_port >> 8);
+			snd_es18xx_config_write(chip, 0x63, fm_port & 0xff);
 		}
-		if (chip->mpu_port > 0 && chip->mpu_port != SNDRV_AUTO_PORT) {
+		if (mpu_port > 0 && mpu_port != SNDRV_AUTO_PORT) {
 			/* MPU-401 I/O */
-			snd_es18xx_config_write(chip, 0x64, chip->mpu_port >> 8);
-			snd_es18xx_config_write(chip, 0x65, chip->mpu_port & 0xff);
+			snd_es18xx_config_write(chip, 0x64, mpu_port >> 8);
+			snd_es18xx_config_write(chip, 0x65, mpu_port & 0xff);
 			/* MPU-401 IRQ */
 			snd_es18xx_config_write(chip, 0x28, chip->irq);
 		}
@@ -1507,11 +1496,12 @@ static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip)
 		snd_es18xx_mixer_write(chip, 0x7A, 0x68);
 		/* Enable and set hardware volume interrupt */
 		snd_es18xx_mixer_write(chip, 0x64, 0x06);
-		if (chip->mpu_port > 0 && chip->mpu_port != SNDRV_AUTO_PORT) {
+		if (mpu_port > 0 && mpu_port != SNDRV_AUTO_PORT) {
 			/* MPU401 share irq with audio
 			   Joystick enabled
 			   FM enabled */
-			snd_es18xx_mixer_write(chip, 0x40, 0x43 | (chip->mpu_port & 0xf0) >> 1);
+			snd_es18xx_mixer_write(chip, 0x40,
+					       0x43 | (mpu_port & 0xf0) >> 1);
 		}
 		snd_es18xx_mixer_write(chip, 0x7f, ((irqmask + 1) << 1) | 0x01);
 	}
@@ -1629,7 +1619,9 @@ static int __devinit snd_es18xx_identify(struct snd_es18xx *chip)
 	return 0;
 }
 
-static int __devinit snd_es18xx_probe(struct snd_es18xx *chip)
+static int __devinit snd_es18xx_probe(struct snd_es18xx *chip,
+					unsigned long mpu_port,
+					unsigned long fm_port)
 {
 	if (snd_es18xx_identify(chip) < 0) {
 		snd_printk(KERN_ERR PFX "[0x%lx] ESS chip not found\n", chip->port);
@@ -1650,8 +1642,6 @@ static int __devinit snd_es18xx_probe(struct snd_es18xx *chip)
 		chip->caps = ES18XX_PCM2 | ES18XX_SPATIALIZER | ES18XX_RECMIX | ES18XX_NEW_RATE | ES18XX_AUXB | ES18XX_I2S | ES18XX_CONTROL | ES18XX_HWV;
 		break;
 	case 0x1887:
-		chip->caps = ES18XX_PCM2 | ES18XX_RECMIX | ES18XX_AUXB | ES18XX_DUPLEX_SAME;
-		break;
 	case 0x1888:
 		chip->caps = ES18XX_PCM2 | ES18XX_RECMIX | ES18XX_AUXB | ES18XX_DUPLEX_SAME;
 		break;
@@ -1666,7 +1656,7 @@ static int __devinit snd_es18xx_probe(struct snd_es18xx *chip)
 	if (chip->dma1 == chip->dma2)
 		chip->caps &= ~(ES18XX_PCM2 | ES18XX_DUPLEX_SAME);
 
-        return snd_es18xx_initialize(chip);
+	return snd_es18xx_initialize(chip, mpu_port, fm_port);
 }
 
 static struct snd_pcm_ops snd_es18xx_playback_ops = {
@@ -1802,10 +1792,7 @@ static int __devinit snd_es18xx_new_device(struct snd_card *card,
 
 	spin_lock_init(&chip->reg_lock);
  	spin_lock_init(&chip->mixer_lock);
- 	spin_lock_init(&chip->ctrl_lock);
         chip->port = port;
-        chip->mpu_port = mpu_port;
-        chip->fm_port = fm_port;
         chip->irq = -1;
         chip->dma1 = -1;
         chip->dma2 = -1;
@@ -1841,11 +1828,11 @@ static int __devinit snd_es18xx_new_device(struct snd_card *card,
 	}
 	chip->dma2 = dma2;
 
-        if (snd_es18xx_probe(chip) < 0) {
+	if (snd_es18xx_probe(chip, mpu_port, fm_port) < 0) {
 		snd_es18xx_free(card);
-                return -ENODEV;
-        }
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, NULL, &ops);
+		return -ENODEV;
+	}
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
 		snd_es18xx_free(card);
 		return err;
@@ -1980,7 +1967,7 @@ static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP; /* Enable this card */
 #ifdef CONFIG_PNP
-static int isapnp[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
+static int isapnp[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP;
 #endif
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240,0x260,0x280 */
 #ifndef CONFIG_PNP
@@ -2160,19 +2147,23 @@ static int __devinit snd_audiodrive_probe(struct snd_card *card, int dev)
 		return err;
 
 	if (fm_port[dev] > 0 && fm_port[dev] != SNDRV_AUTO_PORT) {
-		if (snd_opl3_create(card, chip->fm_port, chip->fm_port + 2, OPL3_HW_OPL3, 0, &opl3) < 0) {
-			snd_printk(KERN_WARNING PFX "opl3 not detected at 0x%lx\n", chip->fm_port);
+		if (snd_opl3_create(card, fm_port[dev], fm_port[dev] + 2,
+				    OPL3_HW_OPL3, 0, &opl3) < 0) {
+			snd_printk(KERN_WARNING PFX
+				   "opl3 not detected at 0x%lx\n",
+				   fm_port[dev]);
 		} else {
-			if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0)
+			err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+			if (err < 0)
 				return err;
 		}
 	}
 
 	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
-		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ES18XX,
-					       chip->mpu_port, 0,
-					       irq[dev], 0,
-					       &chip->rmidi)) < 0)
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_ES18XX,
+					  mpu_port[dev], 0,
+					  irq[dev], 0, &chip->rmidi);
+		if (err < 0)
 			return err;
 	}
 
-- 
1.6.4


Tanie rozmowy telefoniczne!
Sprawdz >> http://link.interia.pl/f2410
