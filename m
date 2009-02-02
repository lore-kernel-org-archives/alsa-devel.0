From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: drop redundant fields from soundscape
 struct (2nd rev)
Date: Mon, 2 Feb 2009 19:52:57 +0100
Message-ID: <20090202195257.6a58627f.krzysztof.h1@poczta.fm>
References: <20090202082011.5349745B990@f49.poczta.interia.pl>
	<s5hhc3d8cd4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A10810383B
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 19:49:18 +0100 (CET)
In-Reply-To: <s5hhc3d8cd4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The wss_base is disguised parameter for one function.
It is converted to a function parameter.

The code_type is only set but never read.
It is removed.

The midi_vol is set only to 0 so it does not work
as detection of change in midi volume. It is fixed.

The xport variable is alias to the port[dev]. Use
the port[dev] directly to increase readability.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 681e223..dca0830 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -135,8 +135,6 @@ enum card_type {
 struct soundscape {
 	spinlock_t lock;
 	unsigned io_base;
-	unsigned wss_base;
-	int codec_type;
 	int ic_type;
 	enum card_type type;
 	struct resource *io_res;
@@ -767,6 +765,7 @@ static int sscape_midi_put(struct snd_kcontrol *kctl,
 	change = (host_write_ctrl_unsafe(s->io_base, CMD_SET_MIDI_VOL, 100)
 	          && host_write_ctrl_unsafe(s->io_base, ((unsigned char) uctl->value.integer. value[0]) & 127, 100)
 	          && host_write_ctrl_unsafe(s->io_base, CMD_XXX_MIDI_VOL, 100));
+	s->midi_vol = (unsigned char) uctl->value.integer.value[0] & 127;
       __skip_change:
 
 	/*
@@ -809,12 +808,11 @@ static unsigned __devinit get_irq_config(int irq)
  * Perform certain arcane port-checks to see whether there
  * is a SoundScape board lurking behind the given ports.
  */
-static int __devinit detect_sscape(struct soundscape *s)
+static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 {
 	unsigned long flags;
 	unsigned d;
 	int retval = 0;
-	int codec = s->wss_base;
 
 	spin_lock_irqsave(&s->lock, flags);
 
@@ -830,13 +828,11 @@ static int __devinit detect_sscape(struct soundscape *s)
 	if ((d & 0x80) != 0)
 		goto _done;
 
-	if (d == 0) {
-		s->codec_type = 1;
+	if (d == 0)
 		s->ic_type = IC_ODIE;
-	} else if ((d & 0x60) != 0) {
-		s->codec_type = 2;
+	else if ((d & 0x60) != 0)
 		s->ic_type = IC_OPUS;
-	} else
+	else
 		goto _done;
 
 	outb(0xfa, ODIE_ADDR_IO(s->io_base));
@@ -856,10 +852,10 @@ static int __devinit detect_sscape(struct soundscape *s)
 	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
 
 	if (s->type == SSCAPE_VIVO)
-		codec += 4;
+		wss_io += 4;
 	/* wait for WSS codec */
 	for (d = 0; d < 500; d++) {
-		if ((inb(codec) & 0x80) == 0)
+		if ((inb(wss_io) & 0x80) == 0)
 			break;
 		spin_unlock_irqrestore(&s->lock, flags);
 		msleep(1);
@@ -1057,7 +1053,6 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	unsigned dma_cfg;
 	unsigned irq_cfg;
 	unsigned mpu_irq_cfg;
-	unsigned xport;
 	struct resource *io_res;
 	struct resource *wss_res;
 	unsigned long flags;
@@ -1077,15 +1072,15 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 		printk(KERN_ERR "sscape: Invalid IRQ %d\n", mpu_irq[dev]);
 		return -ENXIO;
 	}
-	xport = port[dev];
 
 	/*
 	 * Grab IO ports that we will need to probe so that we
 	 * can detect and control this hardware ...
 	 */
-	io_res = request_region(xport, 8, "SoundScape");
+	io_res = request_region(port[dev], 8, "SoundScape");
 	if (!io_res) {
-		snd_printk(KERN_ERR "sscape: can't grab port 0x%x\n", xport);
+		snd_printk(KERN_ERR
+			   "sscape: can't grab port 0x%lx\n", port[dev]);
 		return -EBUSY;
 	}
 	wss_res = NULL;
@@ -1112,10 +1107,9 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	spin_lock_init(&sscape->fwlock);
 	sscape->io_res = io_res;
 	sscape->wss_res = wss_res;
-	sscape->io_base = xport;
-	sscape->wss_base = wss_port[dev];
+	sscape->io_base = port[dev];
 
-	if (!detect_sscape(sscape)) {
+	if (!detect_sscape(sscape, wss_port[dev])) {
 		printk(KERN_ERR "sscape: hardware not detected at 0x%x\n", sscape->io_base);
 		err = -ENODEV;
 		goto _release_dma;
@@ -1188,11 +1182,11 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	}
 #define MIDI_DEVNUM  0
 	if (sscape->type != SSCAPE_VIVO) {
-		err = create_mpu401(card, MIDI_DEVNUM, xport, mpu_irq[dev]);
+		err = create_mpu401(card, MIDI_DEVNUM, port[dev], mpu_irq[dev]);
 		if (err < 0) {
 			printk(KERN_ERR "sscape: Failed to create "
-					"MPU-401 device at 0x%x\n",
-					xport);
+					"MPU-401 device at 0x%lx\n",
+					port[dev]);
 			goto _release_dma;
 		}
 

----------------------------------------------------------------------
Nie boj sie przyszlosci!
Zapytaj wrozke >>  http://link.interia.pl/f2049 
