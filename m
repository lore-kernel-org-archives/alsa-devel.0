From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 05/11] wss_lib: use wss constants instead of
	ad1848 ones
Date: Thu, 31 Jul 2008 21:05:44 +0200
Message-ID: <20080731210544.4e5ac1de.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 0EDB524465
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 21:00:29 +0200 (CEST)
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

Use wss constants for mode.
Move ad1848 hardware constants to the wss.h.
Move mixer tlv macros into the ad1848_lib.c from the ad1848.h.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

Changes since previous version:

1. No reformatting of switch in the ad1848_lib.c
   in the snd_ad1848_chip_id() as the file is going
   to be killed anyway.

diff -urp linux-ref/include/sound/ad1848.h linux-2.6.26/include/sound/ad1848.h
--- linux-ref/include/sound/ad1848.h	2008-07-31 18:46:34.000000000 +0200
+++ linux-2.6.26/include/sound/ad1848.h	2008-07-31 18:46:41.000000000 +0200
@@ -106,24 +106,6 @@
 #define AD1848_CALIB_IN_PROGRESS 0x20	/* auto calibrate in progress */
 #define AD1848_DMA_REQUEST	0x10	/* DMA request in progress */
 
-/* defines for codec.mode */
-
-#define AD1848_MODE_NONE	0x0000
-#define AD1848_MODE_PLAY	0x0001
-#define AD1848_MODE_CAPTURE	0x0002
-#define AD1848_MODE_TIMER	0x0004
-#define AD1848_MODE_OPEN	(AD1848_MODE_PLAY|AD1848_MODE_CAPTURE|AD1848_MODE_TIMER)
-#define AD1848_MODE_RUNNING	0x0010
-
-/* defines for codec.hardware */
-
-#define AD1848_HW_DETECT	0x0000	/* let AD1848 driver detect chip */
-#define AD1848_HW_AD1847	0x0001	/* AD1847 chip */
-#define AD1848_HW_AD1848	0x0002	/* AD1848 chip */
-#define AD1848_HW_CS4248	0x0003	/* CS4248 chip */
-#define AD1848_HW_CMI8330	0x0004	/* CMI8330 chip */
-#define AD1848_HW_THINKPAD	0x0005	/* Thinkpad 360/750/755 */
-
 /* IBM Thinkpad specific stuff */
 #define AD1848_THINKPAD_CTL_PORT1		0x15e8
 #define AD1848_THINKPAD_CTL_PORT2		0x15e9
@@ -167,26 +149,12 @@ struct ad1848_mix_elem {
   .type = AD1848_MIX_SINGLE, \
   .private_value = AD1848_MIXVAL_SINGLE(reg, shift, mask, invert) }
 
-#define AD1848_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
-{ .name = xname, \
-  .index = xindex, \
-  .type = AD1848_MIX_SINGLE, \
-  .private_value = AD1848_MIXVAL_SINGLE(reg, shift, mask, invert), \
-  .tlv = xtlv }
-
 #define AD1848_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
 { .name = xname, \
   .index = xindex, \
   .type = AD1848_MIX_DOUBLE, \
   .private_value = AD1848_MIXVAL_DOUBLE(left_reg, right_reg, shift_left, shift_right, mask, invert) }
 
-#define AD1848_DOUBLE_TLV(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert, xtlv) \
-{ .name = xname, \
-  .index = xindex, \
-  .type = AD1848_MIX_DOUBLE, \
-  .private_value = AD1848_MIXVAL_DOUBLE(left_reg, right_reg, shift_left, shift_right, mask, invert), \
-  .tlv = xtlv }
-
 int snd_ad1848_add_ctl_elem(struct snd_wss *chip,
 			    const struct ad1848_mix_elem *c);
 
diff -urp linux-ref/include/sound/wss.h linux-2.6.26/include/sound/wss.h
--- linux-ref/include/sound/wss.h	2008-07-31 18:46:34.000000000 +0200
+++ linux-2.6.26/include/sound/wss.h	2008-07-31 18:46:41.000000000 +0200
@@ -55,6 +55,12 @@
 #define WSS_HW_CS4237B       0x0402	/* CS4237B - SRS 3D */
 #define WSS_HW_CS4238B	0x0403	/* CS4238B - QSOUND 3D */
 #define WSS_HW_CS4239	0x0404	/* CS4239 - Crystal Clear (tm) stereo enhancement */
+#define WSS_HW_AD1848_MASK	0x0800	/* AD1848 serie (half duplex) */
+#define WSS_HW_AD1847		0x0801	/* AD1847 chip */
+#define WSS_HW_AD1848		0x0802	/* AD1848 chip */
+#define WSS_HW_CS4248		0x0803	/* CS4248 chip */
+#define WSS_HW_CMI8330		0x0804	/* CMI8330 chip */
+#define WSS_HW_THINKPAD		0x0805	/* Thinkpad 360/750/755 */
 /* compatible, but clones */
 #define WSS_HW_INTERWAVE     0x1000	/* InterWave chip */
 #define WSS_HW_OPL3SA2       0x1101	/* OPL3-SA2 chip, similar to cs4231 */
diff -urp linux-ref/sound/isa/ad1848/ad1848.c linux-2.6.26/sound/isa/ad1848/ad1848.c
--- linux-ref/sound/isa/ad1848/ad1848.c	2008-07-31 18:46:34.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848.c	2008-07-31 18:46:41.000000000 +0200
@@ -96,7 +96,7 @@ static int __devinit snd_ad1848_probe(st
 		return -EINVAL;
 
 	error = snd_ad1848_create(card, port[n], irq[n], dma1[n],
-			thinkpad[n] ? AD1848_HW_THINKPAD : AD1848_HW_DETECT, &chip);
+			thinkpad[n] ? WSS_HW_THINKPAD : WSS_HW_DETECT, &chip);
 	if (error < 0)
 		goto out;
 
diff -urp linux-ref/sound/isa/ad1848/ad1848_lib.c linux-2.6.26/sound/isa/ad1848/ad1848_lib.c
--- linux-ref/sound/isa/ad1848/ad1848_lib.c	2008-07-31 18:46:35.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848_lib.c	2008-07-31 18:48:41.000000000 +0200
@@ -283,14 +283,12 @@ static int snd_ad1848_trigger(struct snd
 			return 0;
 		}
 		snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL] |= what);
-		chip->mode |= AD1848_MODE_RUNNING;
 	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
 		if (!(chip->image[AD1848_IFACE_CTRL] & what)) {
 			spin_unlock(&chip->reg_lock);
 			return 0;
 		}
 		snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL] &= ~what);
-		chip->mode &= ~AD1848_MODE_RUNNING;
 	} else {
 		result = -EINVAL;
 	}
@@ -378,7 +376,7 @@ static int snd_ad1848_open(struct snd_ws
 {
 	unsigned long flags;
 
-	if (chip->mode & AD1848_MODE_OPEN)
+	if (chip->mode & WSS_MODE_OPEN)
 		return -EAGAIN;
 
 	snd_ad1848_mce_down(chip);
@@ -570,11 +568,9 @@ static irqreturn_t snd_ad1848_interrupt(
 {
 	struct snd_wss *chip = dev_id;
 
-	if ((chip->mode & AD1848_MODE_PLAY) && chip->playback_substream &&
-	    (chip->mode & AD1848_MODE_RUNNING))
+	if ((chip->mode & WSS_MODE_PLAY) && chip->playback_substream)
 		snd_pcm_period_elapsed(chip->playback_substream);
-	if ((chip->mode & AD1848_MODE_CAPTURE) && chip->capture_substream &&
-	    (chip->mode & AD1848_MODE_RUNNING))
+	if ((chip->mode & WSS_MODE_RECORD) && chip->capture_substream)
 		snd_pcm_period_elapsed(chip->capture_substream);
 	outb(0, AD1848P(chip, STATUS));	/* clear global interrupt bit */
 	return IRQ_HANDLED;
@@ -690,19 +686,19 @@ static int snd_ad1848_probe(struct snd_w
 	}
 	if (id != 1)
 		return -ENODEV;	/* no valid device found */
-	if (chip->hardware == AD1848_HW_DETECT) {
+	if (chip->hardware == WSS_HW_DETECT) {
 		if (ad1847) {
-			chip->hardware = AD1848_HW_AD1847;
+			chip->hardware = WSS_HW_AD1847;
 		} else {
-			chip->hardware = AD1848_HW_AD1848;
+			chip->hardware = WSS_HW_AD1848;
 			rev = snd_ad1848_in(chip, AD1848_MISC_INFO);
 			if (rev & 0x80) {
-				chip->hardware = AD1848_HW_CS4248;
+				chip->hardware = WSS_HW_CS4248;
 			} else if ((rev & 0x0f) == 0x0a) {
 				snd_ad1848_out(chip, AD1848_MISC_INFO, 0x40);
 				for (i = 0; i < 16; ++i) {
 					if (snd_ad1848_in(chip, i) != snd_ad1848_in(chip, i + 16)) {
-						chip->hardware = AD1848_HW_CMI8330;
+						chip->hardware = WSS_HW_CMI8330;
 						break;
 					}
 				}
@@ -782,7 +778,8 @@ static int snd_ad1848_playback_open(stru
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	if ((err = snd_ad1848_open(chip, AD1848_MODE_PLAY)) < 0)
+	err = snd_ad1848_open(chip, WSS_MODE_PLAY);
+	if (err < 0)
 		return err;
 	chip->playback_substream = substream;
 	runtime->hw = snd_ad1848_playback;
@@ -798,7 +795,8 @@ static int snd_ad1848_capture_open(struc
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	if ((err = snd_ad1848_open(chip, AD1848_MODE_CAPTURE)) < 0)
+	err = snd_ad1848_open(chip, WSS_MODE_RECORD);
+	if (err < 0)
 		return err;
 	chip->capture_substream = substream;
 	runtime->hw = snd_ad1848_capture;
@@ -812,7 +810,7 @@ static int snd_ad1848_playback_close(str
 {
 	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 
-	chip->mode &= ~AD1848_MODE_PLAY;
+	chip->mode &= ~WSS_MODE_PLAY;
 	chip->playback_substream = NULL;
 	snd_ad1848_close(chip);
 	return 0;
@@ -822,7 +820,7 @@ static int snd_ad1848_capture_close(stru
 {
 	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 
-	chip->mode &= ~AD1848_MODE_CAPTURE;
+	chip->mode &= ~WSS_MODE_RECORD;
 	chip->capture_substream = NULL;
 	snd_ad1848_close(chip);
 	return 0;
@@ -903,9 +901,9 @@ int snd_ad1848_create(struct snd_card *c
 	chip->dma1 = dma;
 	chip->dma2 = dma;
 
-	if (hardware == AD1848_HW_THINKPAD) {
+	if (hardware == WSS_HW_THINKPAD) {
 		chip->thinkpad_flag = 1;
-		chip->hardware = AD1848_HW_DETECT; /* reset */
+		chip->hardware = WSS_HW_DETECT; /* reset */
 		snd_ad1848_thinkpad_twiddle(chip, 1);
 	}
 
@@ -1214,6 +1212,20 @@ static const DECLARE_TLV_DB_SCALE(db_sca
 static const DECLARE_TLV_DB_SCALE(db_scale_5bit_12db_max, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_rec_gain, 0, 150, 0);
 
+#define AD1848_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
+{ .name = xname, \
+  .index = xindex, \
+  .type = AD1848_MIX_SINGLE, \
+  .private_value = AD1848_MIXVAL_SINGLE(reg, shift, mask, invert), \
+  .tlv = xtlv }
+
+#define AD1848_DOUBLE_TLV(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert, xtlv) \
+{ .name = xname, \
+  .index = xindex, \
+  .type = AD1848_MIX_DOUBLE, \
+  .private_value = AD1848_MIXVAL_DOUBLE(left_reg, right_reg, shift_left, shift_right, mask, invert), \
+  .tlv = xtlv }
+
 static struct ad1848_mix_elem snd_ad1848_controls[] = {
 AD1848_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
 AD1848_DOUBLE_TLV("PCM Playback Volume", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1,
diff -urp linux-ref/sound/isa/cmi8330.c linux-2.6.26/sound/isa/cmi8330.c
--- linux-ref/sound/isa/cmi8330.c	2008-07-31 18:46:35.000000000 +0200
+++ linux-2.6.26/sound/isa/cmi8330.c	2008-07-31 18:46:41.000000000 +0200
@@ -465,12 +465,12 @@ static int __devinit snd_cmi8330_probe(s
 				     wssport[dev] + 4,
 				     wssirq[dev],
 				     wssdma[dev],
-				     AD1848_HW_DETECT,
+				     WSS_HW_DETECT,
 				     &acard->wss)) < 0) {
 		snd_printk(KERN_ERR PFX "(AD1848) device busy??\n");
 		return err;
 	}
-	if (acard->wss->hardware != AD1848_HW_CMI8330) {
+	if (acard->wss->hardware != WSS_HW_CMI8330) {
 		snd_printk(KERN_ERR PFX "(AD1848) not found during probe\n");
 		return -ENODEV;
 	}
diff -urp linux-ref/sound/isa/opti9xx/opti92x-ad1848.c linux-2.6.26/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-ref/sound/isa/opti9xx/opti92x-ad1848.c	2008-07-31 18:46:35.000000000 +0200
+++ linux-2.6.26/sound/isa/opti9xx/opti92x-ad1848.c	2008-07-31 18:46:41.000000000 +0200
@@ -775,7 +775,7 @@ static int __devinit snd_opti9xx_probe(s
 #else
 	if ((error = snd_ad1848_create(card, chip->wss_base + 4,
 				       chip->irq, chip->dma1,
-				       AD1848_HW_DETECT, &codec)) < 0)
+				       WSS_HW_DETECT, &codec)) < 0)
 		return error;
 	if ((error = snd_ad1848_pcm(codec, 0, &pcm)) < 0)
 		return error;
diff -urp linux-ref/sound/isa/sc6000.c linux-2.6.26/sound/isa/sc6000.c
--- linux-ref/sound/isa/sc6000.c	2008-07-31 18:46:35.000000000 +0200
+++ linux-2.6.26/sound/isa/sc6000.c	2008-07-31 18:46:41.000000000 +0200
@@ -549,7 +549,7 @@ static int __devinit snd_sc6000_probe(st
 		goto err_unmap2;
 
 	err = snd_ad1848_create(card, mss_port[dev] + 4, xirq, xdma,
-				AD1848_HW_DETECT, &chip);
+				WSS_HW_DETECT, &chip);
 	if (err < 0)
 		goto err_unmap2;
 	card->private_data = chip;
diff -urp linux-ref/sound/isa/sgalaxy.c linux-2.6.26/sound/isa/sgalaxy.c
--- linux-ref/sound/isa/sgalaxy.c	2008-07-31 18:46:35.000000000 +0200
+++ linux-2.6.26/sound/isa/sgalaxy.c	2008-07-31 18:46:41.000000000 +0200
@@ -265,7 +265,7 @@ static int __devinit snd_sgalaxy_probe(s
 
 	if ((err = snd_ad1848_create(card, wssport[dev] + 4,
 				     xirq, xdma1,
-				     AD1848_HW_DETECT, &chip)) < 0)
+				     WSS_HW_DETECT, &chip)) < 0)
 		goto _err;
 	card->private_data = chip;
 

----------------------------------------------------------------------
Najciekawsze miejsca w Polsce i na swiecie!
Zobacz >>> http://link.interia.pl/f1e60
