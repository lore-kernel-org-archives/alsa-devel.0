From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: add supoort for SPEA Media FX/Reveal
	SC-600
Date: Sun, 27 Sep 2009 23:08:40 +0200
Message-ID: <20090927230840.ef987477.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id ECE1E245EC
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Sep 2009 22:52:31 +0200 (CEST)
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

Move code from the OSS sscape driver in order to support old Soundscape OEM models.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Only PCM works.

 sound/isa/Kconfig  |    6 ++-
 sound/isa/sscape.c |  116 ++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 86 insertions(+), 36 deletions(-)

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 51a7e37..b90fc16 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -377,10 +377,12 @@ config SND_SSCAPE
 	select SND_WSS_LIB
 	help
 	  Say Y here to include support for Ensoniq SoundScape 
-	  soundcards.
+	  and Ensoniq OEM soundcards.
 
 	  The PCM audio is supported on SoundScape Classic, Elite, PnP
-	  and VIVO cards. The MIDI support is very experimental.
+	  and VIVO cards. The supported OEM cards are SPEA Media FX and
+	  Reveal SC-600.
+	  The MIDI support is very experimental.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sscape.
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 6618712..b11c35f 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -127,7 +127,8 @@ enum GA_REG {
 
 
 enum card_type {
-	SSCAPE,
+	MEDIA_FX,	/* Sequoia S-1000 */
+	SSCAPE,		/* Sequoia S-2000 */
 	SSCAPE_PNP,
 	SSCAPE_VIVO,
 };
@@ -784,20 +785,25 @@ static struct snd_kcontrol_new midi_mixer_ctl = {
  * These IRQs are encoded as bit patterns so that they can be
  * written to the control registers.
  */
-static unsigned __devinit get_irq_config(int irq)
+static unsigned __devinit get_irq_config(int sscape_type, int irq)
 {
 	static const int valid_irq[] = { 9, 5, 7, 10 };
+	static const int old_irq[] = { 9, 7, 5, 15 };
 	unsigned cfg;
 
-	for (cfg = 0; cfg < ARRAY_SIZE(valid_irq); ++cfg) {
-		if (irq == valid_irq[cfg])
-			return cfg;
-	} /* for */
+	if (sscape_type == MEDIA_FX) {
+		for (cfg = 0; cfg < ARRAY_SIZE(old_irq); ++cfg)
+			if (irq == old_irq[cfg])
+				return cfg;
+	} else {
+		for (cfg = 0; cfg < ARRAY_SIZE(valid_irq); ++cfg)
+			if (irq == valid_irq[cfg])
+				return cfg;
+	}
 
 	return INVALID_IRQ;
 }
 
-
 /*
  * Perform certain arcane port-checks to see whether there
  * is a SoundScape board lurking behind the given ports.
@@ -842,11 +848,39 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 	if (s->type != SSCAPE_VIVO && (d & 0x9f) != 0x0e)
 		goto _done;
 
-	d  = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
-	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
+	if (s->ic_type == IC_OPUS)
+		activate_ad1845_unsafe(s->io_base);
 
 	if (s->type == SSCAPE_VIVO)
 		wss_io += 4;
+
+	d  = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
+	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
+
+	/* wait for WSS codec */
+	for (d = 0; d < 500; d++) {
+		if ((inb(wss_io) & 0x80) == 0)
+			break;
+		spin_unlock_irqrestore(&s->lock, flags);
+		msleep(1);
+		spin_lock_irqsave(&s->lock, flags);
+	}
+	snd_printd(KERN_INFO "init delay = %d ms\n", d);
+
+	if ((inb(wss_io) & 0x80) != 0)
+		goto _done;
+
+	if (inb(wss_io + 2) == 0xff)
+		goto _done;
+
+	d  = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
+	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d);
+
+	if ((inb(wss_io) & 0x80) != 0)
+		s->type = MEDIA_FX;
+
+	d = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
+	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
 	/* wait for WSS codec */
 	for (d = 0; d < 500; d++) {
 		if ((inb(wss_io) & 0x80) == 0)
@@ -954,9 +988,6 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 	if (sscape->type == SSCAPE_VIVO)
 		port += 4;
 
-	if (dma1 == dma2)
-		dma2 = -1;
-
 	err = snd_wss_create(card, port, -1, irq, dma1, dma2,
 			     WSS_HW_DETECT, WSS_HWSHARE_DMA1, &chip);
 	if (!err) {
@@ -1051,21 +1082,7 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	struct resource *wss_res;
 	unsigned long flags;
 	int err;
-
-	/*
-	 * Check that the user didn't pass us garbage data ...
-	 */
-	irq_cfg = get_irq_config(irq[dev]);
-	if (irq_cfg == INVALID_IRQ) {
-		snd_printk(KERN_ERR "sscape: Invalid IRQ %d\n", irq[dev]);
-		return -ENXIO;
-	}
-
-	mpu_irq_cfg = get_irq_config(mpu_irq[dev]);
-	if (mpu_irq_cfg == INVALID_IRQ) {
-		printk(KERN_ERR "sscape: Invalid IRQ %d\n", mpu_irq[dev]);
-		return -ENXIO;
-	}
+	const char *name;
 
 	/*
 	 * Grab IO ports that we will need to probe so that we
@@ -1109,8 +1126,41 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 		goto _release_dma;
 	}
 
-	printk(KERN_INFO "sscape: hardware detected at 0x%x, using IRQ %d, DMA %d\n",
-			 sscape->io_base, irq[dev], dma[dev]);
+	switch (sscape->type) {
+	case MEDIA_FX:
+		name = "MediaFX/SoundFX";
+		break;
+	case SSCAPE:
+		name = "Soundscape";
+		break;
+	case SSCAPE_PNP:
+		name = "Soundscape PnP";
+		break;
+	case SSCAPE_VIVO:
+		name = "Soundscape VIVO";
+		break;
+	default:
+		name = "unknown Soundscape";
+		break;
+	}
+
+	printk(KERN_INFO "sscape: %s card detected at 0x%x, using IRQ %d, DMA %d\n",
+			 name, sscape->io_base, irq[dev], dma[dev]);
+
+	/*
+	 * Check that the user didn't pass us garbage data ...
+	 */
+	irq_cfg = get_irq_config(sscape->type, irq[dev]);
+	if (irq_cfg == INVALID_IRQ) {
+		snd_printk(KERN_ERR "sscape: Invalid IRQ %d\n", irq[dev]);
+		return -ENXIO;
+	}
+
+	mpu_irq_cfg = get_irq_config(sscape->type, mpu_irq[dev]);
+	if (mpu_irq_cfg == INVALID_IRQ) {
+		printk(KERN_ERR "sscape: Invalid IRQ %d\n", mpu_irq[dev]);
+		return -ENXIO;
+	}
 
 	if (sscape->type != SSCAPE_VIVO) {
 		/*
@@ -1141,8 +1191,6 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	 */
 	spin_lock_irqsave(&sscape->lock, flags);
 
-	activate_ad1845_unsafe(sscape->io_base);
-
 	sscape_write_unsafe(sscape->io_base, GA_INTENA_REG, 0x00); /* disable */
 	sscape_write_unsafe(sscape->io_base, GA_SMCFGA_REG, 0x2e);
 	sscape_write_unsafe(sscape->io_base, GA_SMCFGB_REG, 0x00);
@@ -1151,12 +1199,12 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	 * Enable and configure the DMA channels ...
 	 */
 	sscape_write_unsafe(sscape->io_base, GA_DMACFG_REG, 0x50);
-	dma_cfg = (sscape->ic_type == IC_ODIE ? 0x70 : 0x40);
+	dma_cfg = (sscape->ic_type == IC_OPUS ? 0x40 : 0x70);
 	sscape_write_unsafe(sscape->io_base, GA_DMAA_REG, dma_cfg);
 	sscape_write_unsafe(sscape->io_base, GA_DMAB_REG, 0x20);
 
-	sscape_write_unsafe(sscape->io_base,
-	                    GA_INTCFG_REG, 0xf0 | (mpu_irq_cfg << 2) | mpu_irq_cfg);
+	mpu_irq_cfg |= mpu_irq_cfg << 2;
+	sscape_write_unsafe(sscape->io_base, GA_INTCFG_REG, 0xf0 | mpu_irq_cfg);
 	sscape_write_unsafe(sscape->io_base,
 			    GA_CDCFG_REG, 0x09 | DMA_8BIT
 			    | (dma[dev] << 4) | (irq_cfg << 1));
-- 
1.6.0.3


----------------------------------------------------------------------
Kawalerka za 79 000 zl!
Sprawdz >>> http://link.interia.pl/f2348
