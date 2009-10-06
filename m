From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: sscape: general code improvements
Date: Tue, 6 Oct 2009 19:34:38 +0200
Message-ID: <20091006193438.ff19c9ae.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id D35E9103805
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 19:18:11 +0200 (CEST)
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

General code and coding style improvements.

Add a missing argument for SET_XXX_MIDI_VOL command.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

What is a standard name for switch to select internal or external midi? It is very easy to 
add such a functionality to the driver.


diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 279be50..4380e85 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -109,14 +109,14 @@ MODULE_DEVICE_TABLE(pnp_card, sscape_pnpids);
 #define RX_READY 0x01
 #define TX_READY 0x02
 
-#define CMD_ACK           0x80
-#define CMD_SET_MIDI_VOL  0x84
-#define CMD_GET_MIDI_VOL  0x85
-#define CMD_XXX_MIDI_VOL  0x86
-#define CMD_SET_EXTMIDI   0x8a
-#define CMD_GET_EXTMIDI   0x8b
-#define CMD_SET_MT32      0x8c
-#define CMD_GET_MT32      0x8d
+#define CMD_ACK			0x80
+#define CMD_SET_MIDI_VOL	0x84
+#define CMD_GET_MIDI_VOL	0x85
+#define CMD_XXX_MIDI_VOL	0x86
+#define CMD_SET_EXTMIDI		0x8a
+#define CMD_GET_EXTMIDI		0x8b
+#define CMD_SET_MT32		0x8c
+#define CMD_GET_MT32		0x8d
 
 enum GA_REG {
 	GA_INTSTAT_REG = 0,
@@ -166,10 +166,12 @@ static inline struct soundscape *get_card_soundscape(struct snd_card *c)
  * I think this means that the memory has to map to
  * contiguous pages of physical memory.
  */
-static struct snd_dma_buffer *get_dmabuf(struct snd_dma_buffer *buf, unsigned long size)
+static struct snd_dma_buffer *get_dmabuf(struct snd_dma_buffer *buf,
+					 unsigned long size)
 {
 	if (buf) {
-		if (snd_dma_alloc_pages_fallback(SNDRV_DMA_TYPE_DEV, snd_dma_isa_data(),
+		if (snd_dma_alloc_pages_fallback(SNDRV_DMA_TYPE_DEV,
+						 snd_dma_isa_data(),
 						 size, buf) < 0) {
 			snd_printk(KERN_ERR "sscape: Failed to allocate "
 					    "%lu bytes for DMA\n",
@@ -190,13 +192,13 @@ static void free_dmabuf(struct snd_dma_buffer *buf)
 		snd_dma_free_pages(buf);
 }
 
-
 /*
  * This function writes to the SoundScape's control registers,
  * but doesn't do any locking. It's up to the caller to do that.
  * This is why this function is "unsafe" ...
  */
-static inline void sscape_write_unsafe(unsigned io_base, enum GA_REG reg, unsigned char val)
+static inline void sscape_write_unsafe(unsigned io_base, enum GA_REG reg,
+				       unsigned char val)
 {
 	outb(reg, ODIE_ADDR_IO(io_base));
 	outb(val, ODIE_DATA_IO(io_base));
@@ -206,7 +208,8 @@ static inline void sscape_write_unsafe(unsigned io_base, enum GA_REG reg, unsign
  * Write to the SoundScape's control registers, and do the
  * necessary locking ...
  */
-static void sscape_write(struct soundscape *s, enum GA_REG reg, unsigned char val)
+static void sscape_write(struct soundscape *s, enum GA_REG reg,
+			 unsigned char val)
 {
 	unsigned long flags;
 
@@ -219,7 +222,8 @@ static void sscape_write(struct soundscape *s, enum GA_REG reg, unsigned char va
  * Read from the SoundScape's control registers, but leave any
  * locking to the caller. This is why the function is "unsafe" ...
  */
-static inline unsigned char sscape_read_unsafe(unsigned io_base, enum GA_REG reg)
+static inline unsigned char sscape_read_unsafe(unsigned io_base,
+					       enum GA_REG reg)
 {
 	outb(reg, ODIE_ADDR_IO(io_base));
 	return inb(ODIE_DATA_IO(io_base));
@@ -248,9 +252,8 @@ static inline void set_midi_mode_unsafe(unsigned io_base)
 static inline int host_read_unsafe(unsigned io_base)
 {
 	int data = -1;
-	if ((inb(HOST_CTRL_IO(io_base)) & RX_READY) != 0) {
+	if ((inb(HOST_CTRL_IO(io_base)) & RX_READY) != 0)
 		data = inb(HOST_DATA_IO(io_base));
-	}
 
 	return data;
 }
@@ -292,7 +295,7 @@ static inline int host_write_unsafe(unsigned io_base, unsigned char data)
  * Also leaves all locking-issues to the caller ...
  */
 static int host_write_ctrl_unsafe(unsigned io_base, unsigned char data,
-                                  unsigned timeout)
+				  unsigned timeout)
 {
 	int err;
 
@@ -311,7 +314,7 @@ static int host_write_ctrl_unsafe(unsigned io_base, unsigned char data,
  *
  * NOTE: This check is based upon observation, not documentation.
  */
-static inline int verify_mpu401(const struct snd_mpu401 * mpu)
+static inline int verify_mpu401(const struct snd_mpu401 *mpu)
 {
 	return ((inb(MPU401C(mpu)) & 0xc0) == 0x80);
 }
@@ -319,7 +322,7 @@ static inline int verify_mpu401(const struct snd_mpu401 * mpu)
 /*
  * This is apparently the standard way to initailise an MPU-401
  */
-static inline void initialise_mpu401(const struct snd_mpu401 * mpu)
+static inline void initialise_mpu401(const struct snd_mpu401 *mpu)
 {
 	outb(0, MPU401D(mpu));
 }
@@ -331,7 +334,8 @@ static inline void initialise_mpu401(const struct snd_mpu401 * mpu)
  */
 static inline void activate_ad1845_unsafe(unsigned io_base)
 {
-	sscape_write_unsafe(io_base, GA_HMCTL_REG, (sscape_read_unsafe(io_base, GA_HMCTL_REG) & 0xcf) | 0x10);
+	unsigned char val = sscape_read_unsafe(io_base, GA_HMCTL_REG);
+	sscape_write_unsafe(io_base, GA_HMCTL_REG, (val & 0xcf) | 0x10);
 	sscape_write_unsafe(io_base, GA_CDCFG_REG, 0x80);
 }
 
@@ -352,22 +356,25 @@ static void soundscape_free(struct snd_card *c)
  */
 static inline void sscape_start_dma_unsafe(unsigned io_base, enum GA_REG reg)
 {
-	sscape_write_unsafe(io_base, reg, sscape_read_unsafe(io_base, reg) | 0x01);
-	sscape_write_unsafe(io_base, reg, sscape_read_unsafe(io_base, reg) & 0xfe);
+	sscape_write_unsafe(io_base, reg,
+			    sscape_read_unsafe(io_base, reg) | 0x01);
+	sscape_write_unsafe(io_base, reg,
+			    sscape_read_unsafe(io_base, reg) & 0xfe);
 }
 
 /*
  * Wait for a DMA transfer to complete. This is a "limited busy-wait",
  * and all locking issues are left to the caller.
  */
-static int sscape_wait_dma_unsafe(unsigned io_base, enum GA_REG reg, unsigned timeout)
+static int sscape_wait_dma_unsafe(unsigned io_base, enum GA_REG reg,
+				  unsigned timeout)
 {
 	while (!(sscape_read_unsafe(io_base, reg) & 0x01) && (timeout != 0)) {
 		udelay(100);
 		--timeout;
 	} /* while */
 
-	return (sscape_read_unsafe(io_base, reg) & 0x01);
+	return sscape_read_unsafe(io_base, reg) & 0x01;
 }
 
 /*
@@ -429,11 +436,12 @@ static int host_startup_ack(struct soundscape *s, unsigned timeout)
  */
 static int upload_dma_data(struct soundscape *s,
 			   const unsigned char *data,
-                           size_t size)
+			   size_t size)
 {
 	unsigned long flags;
 	struct snd_dma_buffer dma;
 	int ret;
+	unsigned char val;
 
 	if (!get_dmabuf(&dma, PAGE_ALIGN(32 * 1024)))
 		return -ENOMEM;
@@ -443,18 +451,21 @@ static int upload_dma_data(struct soundscape *s,
 	/*
 	 * Reset the board ...
 	 */
-	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f);
+	val = sscape_read_unsafe(s->io_base, GA_HMCTL_REG);
+	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, val & 0x3f);
 
 	/*
 	 * Enable the DMA channels and configure them ...
 	 */
-	sscape_write_unsafe(s->io_base, GA_DMAA_REG, (s->chip->dma1 << 4) | DMA_8BIT);
+	val = (s->chip->dma1 << 4) | DMA_8BIT;
+	sscape_write_unsafe(s->io_base, GA_DMAA_REG, val);
 	sscape_write_unsafe(s->io_base, GA_DMAB_REG, 0x20);
 
 	/*
 	 * Take the board out of reset ...
 	 */
-	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, sscape_read_unsafe(s->io_base, GA_HMCTL_REG) | 0x80);
+	val = sscape_read_unsafe(s->io_base, GA_HMCTL_REG);
+	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, val | 0x80);
 
 	/*
 	 * Upload the firmware to the SoundScape
@@ -472,7 +483,7 @@ static int upload_dma_data(struct soundscape *s,
 		sscape_start_dma_unsafe(s->io_base, GA_DMAA_REG);
 		if (!sscape_wait_dma_unsafe(s->io_base, GA_DMAA_REG, 5000)) {
 			/*
-			 * Don't forget to release this spinlock we're holding ...
+			 * Don't forget to release this spinlock we're holding
 			 */
 			spin_unlock_irqrestore(&s->lock, flags);
 
@@ -489,7 +500,8 @@ static int upload_dma_data(struct soundscape *s,
 	/*
 	 * Boot the board ... (I think)
 	 */
-	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, sscape_read_unsafe(s->io_base, GA_HMCTL_REG) | 0x40);
+	val = sscape_read_unsafe(s->io_base, GA_HMCTL_REG);
+	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, val | 0x40);
 	spin_unlock_irqrestore(&s->lock, flags);
 
 	/*
@@ -591,7 +603,7 @@ static int sscape_upload_microcode(struct snd_card *card, int version)
  * Mixer control for the SoundScape's MIDI device.
  */
 static int sscape_midi_info(struct snd_kcontrol *ctl,
-                            struct snd_ctl_elem_info *uinfo)
+			    struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
@@ -601,7 +613,7 @@ static int sscape_midi_info(struct snd_kcontrol *ctl,
 }
 
 static int sscape_midi_get(struct snd_kcontrol *kctl,
-                           struct snd_ctl_elem_value *uctl)
+			   struct snd_ctl_elem_value *uctl)
 {
 	struct snd_wss *chip = snd_kcontrol_chip(kctl);
 	struct snd_card *card = chip->card;
@@ -615,16 +627,18 @@ static int sscape_midi_get(struct snd_kcontrol *kctl,
 }
 
 static int sscape_midi_put(struct snd_kcontrol *kctl,
-                           struct snd_ctl_elem_value *uctl)
+			   struct snd_ctl_elem_value *uctl)
 {
 	struct snd_wss *chip = snd_kcontrol_chip(kctl);
 	struct snd_card *card = chip->card;
-	register struct soundscape *s = get_card_soundscape(card);
+	struct soundscape *s = get_card_soundscape(card);
 	unsigned long flags;
 	int change;
+	unsigned char new_val;
 
 	spin_lock_irqsave(&s->lock, flags);
 
+	new_val = uctl->value.integer.value[0] & 127;
 	/*
 	 * We need to put the board into HOST mode before we
 	 * can send any volume-changing HOST commands ...
@@ -637,15 +651,16 @@ static int sscape_midi_put(struct snd_kcontrol *kctl,
 	 * and then perform another volume-related command. Perhaps the
 	 * first command is an "open" and the second command is a "close"?
 	 */
-	if (s->midi_vol == ((unsigned char) uctl->value.integer. value[0] & 127)) {
+	if (s->midi_vol == new_val) {
 		change = 0;
 		goto __skip_change;
 	}
-	change = (host_write_ctrl_unsafe(s->io_base, CMD_SET_MIDI_VOL, 100)
-	          && host_write_ctrl_unsafe(s->io_base, ((unsigned char) uctl->value.integer. value[0]) & 127, 100)
-	          && host_write_ctrl_unsafe(s->io_base, CMD_XXX_MIDI_VOL, 100));
-	s->midi_vol = (unsigned char) uctl->value.integer.value[0] & 127;
-      __skip_change:
+	change = host_write_ctrl_unsafe(s->io_base, CMD_SET_MIDI_VOL, 100)
+		 && host_write_ctrl_unsafe(s->io_base, new_val, 100)
+		 && host_write_ctrl_unsafe(s->io_base, CMD_XXX_MIDI_VOL, 100)
+		 && host_write_ctrl_unsafe(s->io_base, new_val, 100);
+	s->midi_vol = new_val;
+__skip_change:
 
 	/*
 	 * Take the board out of HOST mode and back into MIDI mode ...
@@ -738,7 +753,7 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 	if (s->type == SSCAPE_VIVO)
 		wss_io += 4;
 
-	d  = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
+	d  = sscape_read_unsafe(s->io_base, GA_HMCTL_REG);
 	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
 
 	/* wait for WSS codec */
@@ -762,7 +777,7 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 	if ((inb(wss_io) & 0x80) != 0)
 		s->type = MEDIA_FX;
 
-	d = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
+	d = sscape_read_unsafe(s->io_base, GA_HMCTL_REG);
 	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
 	/* wait for WSS codec */
 	for (d = 0; d < 500; d++) {
@@ -778,7 +793,7 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 	 */
 	retval = 1;
 
-	_done:
+_done:
 	spin_unlock_irqrestore(&s->lock, flags);
 	return retval;
 }
@@ -789,7 +804,7 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
  * to crash the machine. Also check that someone isn't using the hardware
  * IOCTL device.
  */
-static int mpu401_open(struct snd_mpu401 * mpu)
+static int mpu401_open(struct snd_mpu401 *mpu)
 {
 	if (!verify_mpu401(mpu)) {
 		snd_printk(KERN_ERR "sscape: MIDI disabled, "
@@ -803,18 +818,18 @@ static int mpu401_open(struct snd_mpu401 * mpu)
 /*
  * Initialse an MPU-401 subdevice for MIDI support on the SoundScape.
  */
-static int __devinit create_mpu401(struct snd_card *card, int devnum, unsigned long port, int irq)
+static int __devinit create_mpu401(struct snd_card *card, int devnum,
+				   unsigned long port, int irq)
 {
 	struct soundscape *sscape = get_card_soundscape(card);
 	struct snd_rawmidi *rawmidi;
 	int err;
 
-	if ((err = snd_mpu401_uart_new(card, devnum,
-	                               MPU401_HW_MPU401,
-	                               port, MPU401_INFO_INTEGRATED,
-	                               irq, IRQF_DISABLED,
-	                               &rawmidi)) == 0) {
-		struct snd_mpu401 *mpu = (struct snd_mpu401 *) rawmidi->private_data;
+	err = snd_mpu401_uart_new(card, devnum, MPU401_HW_MPU401, port,
+				  MPU401_INFO_INTEGRATED, irq, IRQF_DISABLED,
+				  &rawmidi);
+	if (err == 0) {
+		struct snd_mpu401 *mpu = rawmidi->private_data;
 		mpu->open_input = mpu401_open;
 		mpu->open_output = mpu401_open;
 		mpu->private_data = sscape;
@@ -866,19 +881,6 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 		unsigned long flags;
 		struct snd_pcm *pcm;
 
-/*
- * It turns out that the PLAYBACK_ENABLE bit is set
- * by the lowlevel driver ...
- *
-#define AD1845_IFACE_CONFIG  \
-           (CS4231_AUTOCALIB | CS4231_RECORD_ENABLE | CS4231_PLAYBACK_ENABLE)
-    snd_wss_mce_up(chip);
-    spin_lock_irqsave(&chip->reg_lock, flags);
-    snd_wss_out(chip, CS4231_IFACE_CTRL, AD1845_IFACE_CONFIG);
-    spin_unlock_irqrestore(&chip->reg_lock, flags);
-    snd_wss_mce_down(chip);
- */
-
 		if (sscape->type != SSCAPE_VIVO) {
 			/*
 			 * The input clock frequency on the SoundScape must
@@ -928,7 +930,7 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 		sscape->chip = chip;
 	}
 
-	_error:
+_error:
 	return err;
 }
 
@@ -1155,7 +1157,8 @@ static int __devinit snd_sscape_match(struct device *pdev, unsigned int i)
 	    mpu_irq[i] == SNDRV_AUTO_IRQ ||
 	    dma[i] == SNDRV_AUTO_DMA) {
 		printk(KERN_INFO
-		       "sscape: insufficient parameters, need IO, IRQ, MPU-IRQ and DMA\n");
+		       "sscape: insufficient parameters, "
+		       "need IO, IRQ, MPU-IRQ and DMA\n");
 		return 0;
 	}
 
@@ -1183,7 +1186,8 @@ static int __devinit snd_sscape_probe(struct device *pdev, unsigned int dev)
 	if (ret < 0)
 		goto _release_card;
 
-	if ((ret = snd_card_register(card)) < 0) {
+	ret = snd_card_register(card);
+	if (ret < 0) {
 		snd_printk(KERN_ERR "sscape: Failed to register sound card\n");
 		goto _release_card;
 	}
@@ -1236,20 +1240,15 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
 	 * Allow this function to fail *quietly* if all the ISA PnP
 	 * devices were configured using module parameters instead.
 	 */
-	if ((idx = get_next_autoindex(idx)) >= SNDRV_CARDS)
+	idx = get_next_autoindex(idx);
+	if (idx >= SNDRV_CARDS)
 		return -ENOSPC;
 
 	/*
-	 * We have found a candidate ISA PnP card. Now we
-	 * have to check that it has the devices that we
-	 * expect it to have.
-	 */
-
-	/*
 	 * Check that we still have room for another sound card ...
 	 */
 	dev = pnp_request_card_device(pcard, pid->devs[0].id, NULL);
-	if (! dev)
+	if (!dev)
 		return -ENODEV;
 
 	if (!pnp_is_active(dev)) {
@@ -1298,7 +1297,8 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
 	if (ret < 0)
 		goto _release_card;
 
-	if ((ret = snd_card_register(card)) < 0) {
+	ret = snd_card_register(card);
+	if (ret < 0) {
 		snd_printk(KERN_ERR "sscape: Failed to register sound card\n");
 		goto _release_card;
 	}
diff --git a/sound/oss/sscape.c b/sound/oss/sscape.c
index 30c36d1..7e06424 100644
--- a/sound/oss/sscape.c
+++ b/sound/oss/sscape.c
@@ -160,19 +160,27 @@ static void sleep(unsigned howlong)
 	schedule_timeout(howlong);
 }
 
+static unsigned char __sscape_read(struct sscape_info *devc, int reg)
+{
+	unsigned char val;
+
+	outb(reg, PORT(ODIE_ADDR));
+	val = inb(PORT(ODIE_DATA));
+	return val;
+}
+
 static unsigned char sscape_read(struct sscape_info *devc, int reg)
 {
 	unsigned long flags;
 	unsigned char val;
 
 	spin_lock_irqsave(&devc->lock,flags);
-	outb(reg, PORT(ODIE_ADDR));
-	val = inb(PORT(ODIE_DATA));
+	val = __sscape_read(devc, reg);
 	spin_unlock_irqrestore(&devc->lock,flags);
 	return val;
 }
 
-static void __sscape_write(int reg, int data)
+static void __sscape_write(struct sscape_info *devc, int reg, int data)
 {
 	outb(reg, PORT(ODIE_ADDR));
 	outb(data, PORT(ODIE_DATA));
@@ -183,7 +191,7 @@ static void sscape_write(struct sscape_info *devc, int reg, int data)
 	unsigned long flags;
 
 	spin_lock_irqsave(&devc->lock,flags);
-	__sscape_write(reg, data);
+	__sscape_write(devc, reg, data);
 	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
@@ -342,9 +350,9 @@ static void do_dma(struct sscape_info *devc, int dma_chan, unsigned long buf, in
 		temp |= 0x80;	/* 8 bit DMA channel */
 
 	temp |= 1;		/* Trigger DMA */
-	sscape_write(devc, GA_DMAA_REG, temp);
+	__sscape_write(devc, GA_DMAA_REG, temp);
 	temp &= 0xfe;		/* Clear DMA trigger */
-	sscape_write(devc, GA_DMAA_REG, temp);
+	__sscape_write(devc, GA_DMAA_REG, temp);
 }
 
 static int verify_mpu(struct sscape_info *devc)
@@ -392,7 +400,7 @@ static void sscape_coproc_close(void *dev_info, int sub_device)
 	spin_lock_irqsave(&devc->lock,flags);
 	if (devc->dma_allocated)
 	{
-		__sscape_write(GA_DMAA_REG, 0x20);	/* DMA channel disabled */
+		__sscape_write(devc, GA_DMAA_REG, 0x20);	/* DMA channel disabled */
 		devc->dma_allocated = 0;
 	}
 	spin_unlock_irqrestore(&devc->lock,flags);
@@ -418,7 +426,7 @@ static int sscape_download_boot(struct sscape_info *devc, unsigned char *block,
 		 */
 
 		spin_lock_irqsave(&devc->lock,flags);
-		codec_dma_bits = sscape_read(devc, GA_CDCFG_REG);
+		codec_dma_bits = __sscape_read(devc, GA_CDCFG_REG);
 
 		if (devc->dma_allocated == 0)
 			devc->dma_allocated = 1;
@@ -500,11 +508,11 @@ static int sscape_download_boot(struct sscape_info *devc, unsigned char *block,
 			x = inb(PORT(HOST_DATA));
 			if (x == 0xff || x == 0xfe)		/* OBP startup acknowledge */
 			{
-				DDB(printk("Soundscape: Acknowledge = %x\n", x));
+				(printk("Soundscape: Acknowledge = %x\n", x));
 				done = 1;
 			}
 		}
-		sscape_write(devc, GA_CDCFG_REG, codec_dma_bits);
+		__sscape_write(devc, GA_CDCFG_REG, codec_dma_bits);
 
 		spin_unlock_irqrestore(&devc->lock,flags);
 		if (!done)
@@ -604,6 +612,16 @@ static coproc_operations sscape_coproc_operations =
 static struct resource *sscape_ports;
 static int sscape_is_pnp;
 
+static	int sscape_read_host_ctrl(sscape_info* devc)
+{
+	return host_read(devc);
+}
+
+static	void sscape_write_host_ctrl2(sscape_info *devc, int a, int b)
+{
+	host_command2(devc, a, b);
+}
+
 static void __init attach_sscape(struct address_info *hw_config)
 {
 #ifndef SSCAPE_REGS
@@ -669,22 +687,25 @@ static void __init attach_sscape(struct address_info *hw_config)
 	
 		spin_lock_irqsave(&devc->lock,flags);
 		/* Host interrupt enable */
-		sscape_write(devc, 1, 0xf0);	/* All interrupts enabled */
+		__sscape_write(devc, 1, 0xf0);	/* All interrupts enabled */
 		/* DMA A status/trigger register */
-		sscape_write(devc, 2, 0x20);	/* DMA channel disabled */
+		__sscape_write(devc, 2, 0x20);	/* DMA channel disabled */
 		/* DMA B status/trigger register */
-		sscape_write(devc, 3, 0x20);	/* DMA channel disabled */
+		__sscape_write(devc, 3, 0x20);	/* DMA channel disabled */
 		/* Host interrupt config reg */
-		sscape_write(devc, 4, 0xf0 | (irq_bits << 2) | irq_bits);
+		__sscape_write(devc, 4, 0xf0 | (irq_bits << 2) | irq_bits);
 		/* Don't destroy CD-ROM DMA config bits (0xc0) */
-		sscape_write(devc, 5, (regs[5] & 0x3f) | (sscape_read(devc, 5) & 0xc0));
+		__sscape_write(devc, 5, (regs[5] & 0x3f) | (__sscape_read(devc, 5) & 0xc0));
 		/* CD-ROM config (WSS codec actually) */
-		sscape_write(devc, 6, regs[6]);
-		sscape_write(devc, 7, regs[7]);
-		sscape_write(devc, 8, regs[8]);
+		__sscape_write(devc, 6, regs[6]);
+		__sscape_write(devc, 7, regs[7]);
+		__sscape_write(devc, 8, regs[8]);
 		/* Master control reg. Don't modify CR-ROM bits. Disable SB emul */
-		sscape_write(devc, 9, (sscape_read(devc, 9) & 0xf0) | 0x08);
+		__sscape_write(devc, 9, (__sscape_read(devc, 9) & 0xf0) | 0x08);
 		spin_unlock_irqrestore(&devc->lock,flags);
+		sscape_write_host_ctrl2( devc, 0x84, 0x64 );  /* MIDI volume */
+		sscape_write_host_ctrl2( devc, 0x86, 0x64 );  /* MIDI volume?? */
+		sscape_write_host_ctrl2( devc, 0x8A, 0);
 	}
 #ifdef SSCAPE_DEBUG2
 	/*
@@ -721,7 +742,7 @@ static int detect_ga(sscape_info * devc)
 {
 	unsigned char save;
 
-	DDB(printk("Entered Soundscape detect_ga(%x)\n", devc->base));
+	printk(KERN_DEBUG "Entered Soundscape detect_ga(%x)\n", devc->base);
 
 	/*
 	 * First check that the address register of "ODIE" is
@@ -771,16 +792,6 @@ static int detect_ga(sscape_info * devc)
 	return 1;
 }
 
-static	int sscape_read_host_ctrl(sscape_info* devc)
-{
-	return host_read(devc);
-}
-
-static	void sscape_write_host_ctrl2(sscape_info *devc, int a, int b)
-{
-	host_command2(devc, a, b);
-}
-
 static int sscape_alloc_dma(sscape_info *devc)
 {
 	char *start_addr, *end_addr;
@@ -869,8 +880,8 @@ static void sscape_pnp_start_dma(sscape_info* devc, int arg )
 	if (arg == 0) reg = 2;
 	else reg = 3;
 
-	sscape_write(devc, reg, sscape_read( devc, reg) | 0x01);
-	sscape_write(devc, reg, sscape_read( devc, reg) & 0xFE);
+	__sscape_write(devc, reg, sscape_read( devc, reg) | 0x01);
+	__sscape_write(devc, reg, sscape_read( devc, reg) & 0xFE);
 }
 
 static int sscape_pnp_wait_dma (sscape_info* devc, int arg )
@@ -885,11 +896,11 @@ static int sscape_pnp_wait_dma (sscape_info* devc, int arg )
 	sleep ( 1 );
 	i = 0;
 	do {
-		d = sscape_read(devc, reg) & 1;
+		d = __sscape_read(devc, reg) & 1;
 		if ( d == 1)  break;
 		i++;
 	} while (i < 500000);
-	d = sscape_read(devc, reg) & 1; 
+	d = __sscape_read(devc, reg) & 1; 
 	return d;
 }
 
@@ -1242,8 +1253,11 @@ static int __init probe_sscape(struct address_info *hw_config)
 	}
 
 	if (!detect_ga(devc)) {
-		if (detect_sscape_pnp(devc))
+		printk(KERN_DEBUG "GA detected!\n");
+		if (detect_sscape_pnp(devc)) {
+			printk(KERN_DEBUG "PnP detected!\n");
 			return 1;
+		}
 		release_region(devc->base, 2);
 		release_region(devc->base + 2, 6);
 		return 0;


----------------------------------------------------------------------
Zobacz najwiekszy samolot na swiecie!  
Kliknij >>> http://link.interia.pl/f238f
