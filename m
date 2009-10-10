From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: coding style fixes
Date: Sat, 10 Oct 2009 10:27:58 +0200
Message-ID: <20091010102758.27c6d83b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7819669568038043733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 04B85243A0
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 10:11:54 +0200 (CEST)
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

--===============7819669568038043733==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix coding style errors in the driver.

Also, add missing argument for CMD_XXX_MIDI_VOL command.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The third trial. I hope I got it right this time.

 sound/isa/sscape.c |  169 +++++++++++++++++++++++++--------------------------
 1 files changed, 83 insertions(+), 86 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 279be50..0a706c4 100644
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
@@ -329,9 +332,10 @@ static inline void initialise_mpu401(const struct snd_mpu401 * mpu)
  * The AD1845 detection fails if we *don't* do this, so I
  * think that this is a good idea ...
  */
-static inline void activate_ad1845_unsafe(unsigned io_base)
+static void activate_ad1845_unsafe(unsigned io_base)
 {
-	sscape_write_unsafe(io_base, GA_HMCTL_REG, (sscape_read_unsafe(io_base, GA_HMCTL_REG) & 0xcf) | 0x10);
+	unsigned char val = sscape_read_unsafe(io_base, GA_HMCTL_REG);
+	sscape_write_unsafe(io_base, GA_HMCTL_REG, (val & 0xcf) | 0x10);
 	sscape_write_unsafe(io_base, GA_CDCFG_REG, 0x80);
 }
 
@@ -350,24 +354,27 @@ static void soundscape_free(struct snd_card *c)
  * Tell the SoundScape to begin a DMA tranfer using the given channel.
  * All locking issues are left to the caller.
  */
-static inline void sscape_start_dma_unsafe(unsigned io_base, enum GA_REG reg)
+static void sscape_start_dma_unsafe(unsigned io_base, enum GA_REG reg)
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
@@ -427,13 +434,13 @@ static int host_startup_ack(struct soundscape *s, unsigned timeout)
 /*
  * Upload a byte-stream into the SoundScape using DMA channel A.
  */
-static int upload_dma_data(struct soundscape *s,
-			   const unsigned char *data,
-                           size_t size)
+static int upload_dma_data(struct soundscape *s, const unsigned char *data,
+			   size_t size)
 {
 	unsigned long flags;
 	struct snd_dma_buffer dma;
 	int ret;
+	unsigned char val;
 
 	if (!get_dmabuf(&dma, PAGE_ALIGN(32 * 1024)))
 		return -ENOMEM;
@@ -443,18 +450,21 @@ static int upload_dma_data(struct soundscape *s,
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
@@ -472,7 +482,7 @@ static int upload_dma_data(struct soundscape *s,
 		sscape_start_dma_unsafe(s->io_base, GA_DMAA_REG);
 		if (!sscape_wait_dma_unsafe(s->io_base, GA_DMAA_REG, 5000)) {
 			/*
-			 * Don't forget to release this spinlock we're holding ...
+			 * Don't forget to release this spinlock we're holding
 			 */
 			spin_unlock_irqrestore(&s->lock, flags);
 
@@ -489,7 +499,8 @@ static int upload_dma_data(struct soundscape *s,
 	/*
 	 * Boot the board ... (I think)
 	 */
-	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, sscape_read_unsafe(s->io_base, GA_HMCTL_REG) | 0x40);
+	val = sscape_read_unsafe(s->io_base, GA_HMCTL_REG);
+	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, val | 0x40);
 	spin_unlock_irqrestore(&s->lock, flags);
 
 	/*
@@ -591,7 +602,7 @@ static int sscape_upload_microcode(struct snd_card *card, int version)
  * Mixer control for the SoundScape's MIDI device.
  */
 static int sscape_midi_info(struct snd_kcontrol *ctl,
-                            struct snd_ctl_elem_info *uinfo)
+			    struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
@@ -601,7 +612,7 @@ static int sscape_midi_info(struct snd_kcontrol *ctl,
 }
 
 static int sscape_midi_get(struct snd_kcontrol *kctl,
-                           struct snd_ctl_elem_value *uctl)
+			   struct snd_ctl_elem_value *uctl)
 {
 	struct snd_wss *chip = snd_kcontrol_chip(kctl);
 	struct snd_card *card = chip->card;
@@ -615,16 +626,18 @@ static int sscape_midi_get(struct snd_kcontrol *kctl,
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
@@ -637,15 +650,16 @@ static int sscape_midi_put(struct snd_kcontrol *kctl,
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
@@ -738,7 +752,7 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 	if (s->type == SSCAPE_VIVO)
 		wss_io += 4;
 
-	d  = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
+	d  = sscape_read_unsafe(s->io_base, GA_HMCTL_REG);
 	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
 
 	/* wait for WSS codec */
@@ -762,7 +776,7 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 	if ((inb(wss_io) & 0x80) != 0)
 		s->type = MEDIA_FX;
 
-	d = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
+	d = sscape_read_unsafe(s->io_base, GA_HMCTL_REG);
 	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
 	/* wait for WSS codec */
 	for (d = 0; d < 500; d++) {
@@ -778,7 +792,7 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 	 */
 	retval = 1;
 
-	_done:
+_done:
 	spin_unlock_irqrestore(&s->lock, flags);
 	return retval;
 }
@@ -789,7 +803,7 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
  * to crash the machine. Also check that someone isn't using the hardware
  * IOCTL device.
  */
-static int mpu401_open(struct snd_mpu401 * mpu)
+static int mpu401_open(struct snd_mpu401 *mpu)
 {
 	if (!verify_mpu401(mpu)) {
 		snd_printk(KERN_ERR "sscape: MIDI disabled, "
@@ -803,18 +817,18 @@ static int mpu401_open(struct snd_mpu401 * mpu)
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
@@ -866,19 +880,6 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
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
@@ -928,7 +929,7 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 		sscape->chip = chip;
 	}
 
-	_error:
+_error:
 	return err;
 }
 
@@ -1034,7 +1035,6 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	 */
 	spin_lock_irqsave(&sscape->lock, flags);
 
-	sscape_write_unsafe(sscape->io_base, GA_INTENA_REG, 0x00); /* disable */
 	sscape_write_unsafe(sscape->io_base, GA_SMCFGA_REG, 0x2e);
 	sscape_write_unsafe(sscape->io_base, GA_SMCFGB_REG, 0x00);
 
@@ -1055,6 +1055,10 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	sscape_write_unsafe(sscape->io_base,
 			    GA_CDCFG_REG, 0x09 | DMA_8BIT
 			    | (dma[dev] << 4) | (irq_cfg << 1));
+	/*
+	 * Enable the master IRQ ...
+	 */
+	sscape_write_unsafe(sscape->io_base, GA_INTENA_REG, 0x80);
 
 	spin_unlock_irqrestore(&sscape->lock, flags);
 
@@ -1094,11 +1098,6 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 			}
 
 			/*
-			 * Enable the master IRQ ...
-			 */
-			sscape_write(sscape, GA_INTENA_REG, 0x80);
-
-			/*
 			 * Initialize mixer
 			 */
 			spin_lock_irqsave(&sscape->lock, flags);
@@ -1155,7 +1154,8 @@ static int __devinit snd_sscape_match(struct device *pdev, unsigned int i)
 	    mpu_irq[i] == SNDRV_AUTO_IRQ ||
 	    dma[i] == SNDRV_AUTO_DMA) {
 		printk(KERN_INFO
-		       "sscape: insufficient parameters, need IO, IRQ, MPU-IRQ and DMA\n");
+		       "sscape: insufficient parameters, "
+		       "need IO, IRQ, MPU-IRQ and DMA\n");
 		return 0;
 	}
 
@@ -1183,7 +1183,8 @@ static int __devinit snd_sscape_probe(struct device *pdev, unsigned int dev)
 	if (ret < 0)
 		goto _release_card;
 
-	if ((ret = snd_card_register(card)) < 0) {
+	ret = snd_card_register(card);
+	if (ret < 0) {
 		snd_printk(KERN_ERR "sscape: Failed to register sound card\n");
 		goto _release_card;
 	}
@@ -1236,20 +1237,15 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
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
@@ -1298,7 +1294,8 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
 	if (ret < 0)
 		goto _release_card;
 
-	if ((ret = snd_card_register(card)) < 0) {
+	ret = snd_card_register(card);
+	if (ret < 0) {
 		snd_printk(KERN_ERR "sscape: Failed to register sound card\n");
 		goto _release_card;
 	}
-- 
1.6.0.3


---------------------------------------------------------------
Przygotuj siê na przysz³o¶æ! 
Kliknij >>>  http://link.interia.pl/f238a 


--===============7819669568038043733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7819669568038043733==--
