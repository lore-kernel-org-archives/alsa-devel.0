From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 08/11] wss_lib: use wss mixer code instead of
	ad1848 one
Date: Thu, 31 Jul 2008 21:08:32 +0200
Message-ID: <20080731210832.0cc7fe26.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 205282447B
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 21:03:16 +0200 (CEST)
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

Use the wss mixer code and kill the ad1848 mixer code.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

Changes since previous version:

1. Nicer formatting of WSS_SINGLE/WSS_DOUBLE and TLV
   macros.
2. TLV macro definitions moved to the wss.h directly.

diff -urp linux-ref/include/sound/ad1848.h linux-2.6.26/include/sound/ad1848.h
--- linux-ref/include/sound/ad1848.h	2008-07-31 19:03:47.000000000 +0200
+++ linux-2.6.26/include/sound/ad1848.h	2008-07-31 19:03:53.000000000 +0200
@@ -115,6 +115,5 @@ int snd_ad1848_create(struct snd_card *c
 
 int snd_ad1848_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
 const struct snd_pcm_ops *snd_ad1848_get_pcm_ops(int direction);
-int snd_ad1848_mixer(struct snd_wss *chip);
 
 #endif /* __SOUND_AD1848_H */
diff -urp linux-ref/include/sound/wss.h linux-2.6.26/include/sound/wss.h
--- linux-ref/include/sound/wss.h	2008-07-31 18:51:25.000000000 +0200
+++ linux-2.6.26/include/sound/wss.h	2008-07-31 19:03:53.000000000 +0200
@@ -193,6 +193,31 @@ int snd_wss_put_single(struct snd_kcontr
   .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
 		   (shift_right << 19) | (mask << 24) | (invert << 22) }
 
+#define WSS_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
+  .name = xname, \
+  .index = xindex, \
+  .info = snd_wss_info_single, \
+  .get = snd_wss_get_single, \
+  .put = snd_wss_put_single, \
+  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24), \
+  .tlv = { .p = (xtlv) } }
+
+#define WSS_DOUBLE_TLV(xname, xindex, left_reg, right_reg, \
+			shift_left, shift_right, mask, invert, xtlv) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
+  .name = xname, \
+  .index = xindex, \
+  .info = snd_wss_info_double, \
+  .get = snd_wss_get_double, \
+  .put = snd_wss_put_double, \
+  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
+		   (shift_right << 19) | (mask << 24) | (invert << 22), \
+  .tlv = { .p = (xtlv) } }
+
+
 int snd_wss_info_double(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_info *uinfo);
 int snd_wss_get_double(struct snd_kcontrol *kcontrol,
diff -urp linux-ref/sound/isa/ad1848/ad1848.c linux-2.6.26/sound/isa/ad1848/ad1848.c
--- linux-ref/sound/isa/ad1848/ad1848.c	2008-07-31 18:51:25.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848.c	2008-07-31 19:03:53.000000000 +0200
@@ -106,7 +106,7 @@ static int __devinit snd_ad1848_probe(st
 	if (error < 0)
 		goto out;
 
-	error = snd_ad1848_mixer(chip);
+	error = snd_wss_mixer(chip);
 	if (error < 0)
 		goto out;
 
diff -urp linux-ref/sound/isa/ad1848/ad1848_lib.c linux-2.6.26/sound/isa/ad1848/ad1848_lib.c
--- linux-ref/sound/isa/ad1848/ad1848_lib.c	2008-07-31 19:03:47.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848_lib.c	2008-07-31 19:05:04.000000000 +0200
@@ -995,267 +995,6 @@ const struct snd_pcm_ops *snd_ad1848_get
 EXPORT_SYMBOL(snd_ad1848_get_pcm_ops);
 
 /*
- *  MIXER part
- */
-
-static int snd_ad1848_info_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	static char *texts[4] = {
-		"Line", "Aux", "Mic", "Mix"
-	};
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 2;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3)
-		uinfo->value.enumerated.item = 3;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
-}
-
-static int snd_ad1848_get_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
-	
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	ucontrol->value.enumerated.item[0] = (chip->image[AD1848_LEFT_INPUT] & AD1848_MIXS_ALL) >> 6;
-	ucontrol->value.enumerated.item[1] = (chip->image[AD1848_RIGHT_INPUT] & AD1848_MIXS_ALL) >> 6;
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	return 0;
-}
-
-static int snd_ad1848_put_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
-	unsigned short left, right;
-	int change;
-	
-	if (ucontrol->value.enumerated.item[0] > 3 ||
-	    ucontrol->value.enumerated.item[1] > 3)
-		return -EINVAL;
-	left = ucontrol->value.enumerated.item[0] << 6;
-	right = ucontrol->value.enumerated.item[1] << 6;
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	left = (chip->image[AD1848_LEFT_INPUT] & ~AD1848_MIXS_ALL) | left;
-	right = (chip->image[AD1848_RIGHT_INPUT] & ~AD1848_MIXS_ALL) | right;
-	change = left != chip->image[AD1848_LEFT_INPUT] ||
-	         right != chip->image[AD1848_RIGHT_INPUT];
-	snd_ad1848_out(chip, AD1848_LEFT_INPUT, left);
-	snd_ad1848_out(chip, AD1848_RIGHT_INPUT, right);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	return change;
-}
-
-static int snd_ad1848_info_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	int mask = (kcontrol->private_value >> 16) & 0xff;
-
-	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
-	return 0;
-}
-
-static int snd_ad1848_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0xff;
-	int mask = (kcontrol->private_value >> 16) & 0xff;
-	int invert = (kcontrol->private_value >> 24) & 0xff;
-	
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	ucontrol->value.integer.value[0] = (chip->image[reg] >> shift) & mask;
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	if (invert)
-		ucontrol->value.integer.value[0] = mask - ucontrol->value.integer.value[0];
-	return 0;
-}
-
-static int snd_ad1848_put_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0xff;
-	int mask = (kcontrol->private_value >> 16) & 0xff;
-	int invert = (kcontrol->private_value >> 24) & 0xff;
-	int change;
-	unsigned short val;
-	
-	val = (ucontrol->value.integer.value[0] & mask);
-	if (invert)
-		val = mask - val;
-	val <<= shift;
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	val = (chip->image[reg] & ~(mask << shift)) | val;
-	change = val != chip->image[reg];
-	snd_ad1848_out(chip, reg, val);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	return change;
-}
-
-static int snd_ad1848_info_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	int mask = (kcontrol->private_value >> 24) & 0xff;
-
-	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 2;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
-	return 0;
-}
-
-static int snd_ad1848_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
-	int left_reg = kcontrol->private_value & 0xff;
-	int right_reg = (kcontrol->private_value >> 8) & 0xff;
-	int shift_left = (kcontrol->private_value >> 16) & 0x07;
-	int shift_right = (kcontrol->private_value >> 19) & 0x07;
-	int mask = (kcontrol->private_value >> 24) & 0xff;
-	int invert = (kcontrol->private_value >> 22) & 1;
-	
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	ucontrol->value.integer.value[0] = (chip->image[left_reg] >> shift_left) & mask;
-	ucontrol->value.integer.value[1] = (chip->image[right_reg] >> shift_right) & mask;
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	if (invert) {
-		ucontrol->value.integer.value[0] = mask - ucontrol->value.integer.value[0];
-		ucontrol->value.integer.value[1] = mask - ucontrol->value.integer.value[1];
-	}
-	return 0;
-}
-
-static int snd_ad1848_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
-	int left_reg = kcontrol->private_value & 0xff;
-	int right_reg = (kcontrol->private_value >> 8) & 0xff;
-	int shift_left = (kcontrol->private_value >> 16) & 0x07;
-	int shift_right = (kcontrol->private_value >> 19) & 0x07;
-	int mask = (kcontrol->private_value >> 24) & 0xff;
-	int invert = (kcontrol->private_value >> 22) & 1;
-	int change;
-	unsigned short val1, val2;
-	
-	val1 = ucontrol->value.integer.value[0] & mask;
-	val2 = ucontrol->value.integer.value[1] & mask;
-	if (invert) {
-		val1 = mask - val1;
-		val2 = mask - val2;
-	}
-	val1 <<= shift_left;
-	val2 <<= shift_right;
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	if (left_reg != right_reg) {
-		val1 = (chip->image[left_reg] & ~(mask << shift_left)) | val1;
-		val2 = (chip->image[right_reg] & ~(mask << shift_right)) | val2;
-		change = val1 != chip->image[left_reg] || val2 != chip->image[right_reg];
-		snd_ad1848_out(chip, left_reg, val1);
-		snd_ad1848_out(chip, right_reg, val2);
-	} else {
-		val1 = (chip->image[left_reg] & ~((mask << shift_left) | (mask << shift_right))) | val1 | val2;
-		change = val1 != chip->image[left_reg];
-		snd_ad1848_out(chip, left_reg, val1);		
-	}
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	return change;
-}
-
-static const DECLARE_TLV_DB_SCALE(db_scale_6bit, -9450, 150, 0);
-static const DECLARE_TLV_DB_SCALE(db_scale_5bit_12db_max, -3450, 150, 0);
-static const DECLARE_TLV_DB_SCALE(db_scale_rec_gain, 0, 150, 0);
-
-#define AD1848_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_ad1848_info_single, \
-  .get = snd_ad1848_get_single, \
-  .put = snd_ad1848_put_single, \
-  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24), \
-  .tlv = { .p = (xtlv) } }
-
-#define AD1848_DOUBLE_TLV(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert, xtlv) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_ad1848_info_double, \
-  .get = snd_ad1848_get_double, \
-  .put = snd_ad1848_put_double, \
-  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
-		   (shift_right << 19) | (mask << 24) | (invert << 22), \
-  .tlv = { .p = (xtlv) } }
-
-static struct snd_kcontrol_new snd_ad1848_controls[] = {
-WSS_DOUBLE("PCM Playback Switch", 0,
-		AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
-AD1848_DOUBLE_TLV("PCM Playback Volume", 0,
-		AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1,
-		db_scale_6bit),
-WSS_DOUBLE("Aux Playback Switch", 0,
-		AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-AD1848_DOUBLE_TLV("Aux Playback Volume", 0,
-		AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 0, 0, 31, 1,
-		db_scale_5bit_12db_max),
-WSS_DOUBLE("Aux Playback Switch", 1,
-		AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-AD1848_DOUBLE_TLV("Aux Playback Volume", 1,
-		AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
-		db_scale_5bit_12db_max),
-AD1848_DOUBLE_TLV("Capture Volume", 0,
-		AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 0, 0, 15, 0,
-		db_scale_rec_gain),
-{
-	.name = "Capture Source",
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.info = snd_ad1848_info_mux,
-	.get = snd_ad1848_get_mux,
-	.put = snd_ad1848_put_mux,
-},
-WSS_SINGLE("Loopback Capture Switch", 0,
-		AD1848_LOOPBACK, 0, 1, 0),
-AD1848_SINGLE_TLV("Loopback Capture Volume", 0,
-		AD1848_LOOPBACK, 1, 63, 0,
-		db_scale_6bit),
-};
-                                        
-int snd_ad1848_mixer(struct snd_wss *chip)
-{
-	struct snd_card *card;
-	struct snd_pcm *pcm;
-	unsigned int idx;
-	int err;
-
-	snd_assert(chip != NULL && chip->pcm != NULL, return -EINVAL);
-
-	pcm = chip->pcm;
-	card = chip->card;
-
-	strcpy(card->mixername, pcm->name);
-
-	for (idx = 0; idx < ARRAY_SIZE(snd_ad1848_controls); idx++) {
-		err = snd_ctl_add(card,
-				snd_ctl_new1(&snd_ad1848_controls[idx], chip));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
-EXPORT_SYMBOL(snd_ad1848_mixer);
-
-/*
  *  INIT part
  */
 
diff -urp linux-ref/sound/isa/opti9xx/opti92x-ad1848.c linux-2.6.26/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-ref/sound/isa/opti9xx/opti92x-ad1848.c	2008-07-31 18:51:25.000000000 +0200
+++ linux-2.6.26/sound/isa/opti9xx/opti92x-ad1848.c	2008-07-31 19:03:59.000000000 +0200
@@ -757,6 +757,15 @@ static int __devinit snd_opti9xx_probe(s
 	error = snd_wss_pcm(codec, 0, &pcm);
 	if (error < 0)
 		return error;
+#else
+	error = snd_ad1848_create(card, chip->wss_base + 4, chip->irq,
+				  chip->dma1, WSS_HW_DETECT, &codec);
+	if (error < 0)
+		return error;
+	error = snd_ad1848_pcm(codec, 0, &pcm);
+	if (error < 0)
+		return error;
+#endif
 	error = snd_wss_mixer(codec);
 	if (error < 0)
 		return error;
@@ -764,7 +773,8 @@ static int __devinit snd_opti9xx_probe(s
 	error = snd_wss_timer(codec, 0, &timer);
 	if (error < 0)
 		return error;
-#else /* OPTI93X */
+#endif
+#ifdef OPTi93X
 	error = request_irq(chip->irq, snd_opti93x_interrupt,
 			    IRQF_DISABLED, DEV_NAME" - WSS", codec);
 	if (error < 0) {
@@ -772,16 +782,6 @@ static int __devinit snd_opti9xx_probe(s
 		return error;
 	}
 #endif
-#else
-	if ((error = snd_ad1848_create(card, chip->wss_base + 4,
-				       chip->irq, chip->dma1,
-				       WSS_HW_DETECT, &codec)) < 0)
-		return error;
-	if ((error = snd_ad1848_pcm(codec, 0, &pcm)) < 0)
-		return error;
-	if ((error = snd_ad1848_mixer(codec)) < 0)
-		return error;
-#endif
 	strcpy(card->driver, chip->name);
 	sprintf(card->shortname, "OPTi %s", card->driver);
 #if defined(CS4231) || defined(OPTi93X)
diff -urp linux-ref/sound/isa/sc6000.c linux-2.6.26/sound/isa/sc6000.c
--- linux-ref/sound/isa/sc6000.c	2008-07-31 18:51:25.000000000 +0200
+++ linux-2.6.26/sound/isa/sc6000.c	2008-07-31 19:03:59.000000000 +0200
@@ -560,9 +560,9 @@ static int __devinit snd_sc6000_probe(st
 			   "error creating new ad1848 PCM device\n");
 		goto err_unmap2;
 	}
-	err = snd_ad1848_mixer(chip);
+	err = snd_wss_mixer(chip);
 	if (err < 0) {
-		snd_printk(KERN_ERR PFX "error creating new ad1848 mixer\n");
+		snd_printk(KERN_ERR PFX "error creating new WSS mixer\n");
 		goto err_unmap2;
 	}
 	err = snd_sc6000_mixer(chip);
diff -urp linux-ref/sound/isa/sgalaxy.c linux-2.6.26/sound/isa/sgalaxy.c
--- linux-ref/sound/isa/sgalaxy.c	2008-07-31 18:59:20.000000000 +0200
+++ linux-2.6.26/sound/isa/sgalaxy.c	2008-07-31 19:03:59.000000000 +0200
@@ -277,8 +277,9 @@ static int __devinit snd_sgalaxy_probe(s
 		snd_printdd(PFX "error creating new ad1848 PCM device\n");
 		goto _err;
 	}
-	if ((err = snd_ad1848_mixer(chip)) < 0) {
-		snd_printdd(PFX "error creating new ad1848 mixer\n");
+	err = snd_wss_mixer(chip);
+	if (err < 0) {
+		snd_printdd(PFX "error creating new WSS mixer\n");
 		goto _err;
 	}
 	if ((err = snd_sgalaxy_mixer(chip)) < 0) {
diff -urp linux-ref/sound/isa/wss/wss_lib.c linux-2.6.26/sound/isa/wss/wss_lib.c
--- linux-ref/sound/isa/wss/wss_lib.c	2008-07-31 18:40:55.000000000 +0200
+++ linux-2.6.26/sound/isa/wss/wss_lib.c	2008-07-31 19:03:59.000000000 +0200
@@ -33,6 +33,7 @@
 #include <sound/core.h>
 #include <sound/wss.h>
 #include <sound/pcm_params.h>
+#include <sound/tlv.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -1957,16 +1958,58 @@ int snd_wss_put_double(struct snd_kcontr
 	val1 <<= shift_left;
 	val2 <<= shift_right;
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	val1 = (chip->image[left_reg] & ~(mask << shift_left)) | val1;
-	val2 = (chip->image[right_reg] & ~(mask << shift_right)) | val2;
-	change = val1 != chip->image[left_reg] || val2 != chip->image[right_reg];
-	snd_wss_out(chip, left_reg, val1);
-	snd_wss_out(chip, right_reg, val2);
+	if (left_reg != right_reg) {
+		val1 = (chip->image[left_reg] & ~(mask << shift_left)) | val1;
+		val2 = (chip->image[right_reg] & ~(mask << shift_right)) | val2;
+		change = val1 != chip->image[left_reg] ||
+			 val2 != chip->image[right_reg];
+		snd_wss_out(chip, left_reg, val1);
+		snd_wss_out(chip, right_reg, val2);
+	} else {
+		mask = (mask << shift_left) | (mask << shift_right);
+		val1 = (chip->image[left_reg] & ~mask) | val1 | val2;
+		change = val1 != chip->image[left_reg];
+		snd_wss_out(chip, left_reg, val1);
+	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return change;
 }
 EXPORT_SYMBOL(snd_wss_put_double);
 
+static const DECLARE_TLV_DB_SCALE(db_scale_6bit, -9450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_5bit_12db_max, -3450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_rec_gain, 0, 150, 0);
+
+static struct snd_kcontrol_new snd_ad1848_controls[] = {
+WSS_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT,
+	   7, 7, 1, 1),
+WSS_DOUBLE_TLV("PCM Playback Volume", 0,
+	       CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1,
+	       db_scale_6bit),
+WSS_DOUBLE("Aux Playback Switch", 0,
+	   CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE_TLV("Aux Playback Volume", 0,
+	       CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1,
+	       db_scale_5bit_12db_max),
+WSS_DOUBLE("Aux Playback Switch", 1,
+	   CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE_TLV("Aux Playback Volume", 1,
+	       CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
+	       db_scale_5bit_12db_max),
+WSS_DOUBLE_TLV("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT,
+		0, 0, 15, 0, db_scale_rec_gain),
+{
+	.name = "Capture Source",
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.info = snd_wss_info_mux,
+	.get = snd_wss_get_mux,
+	.put = snd_wss_put_mux,
+},
+WSS_SINGLE("Loopback Capture Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
+WSS_SINGLE_TLV("Loopback Capture Volume", 0, CS4231_LOOPBACK, 1, 63, 0,
+	       db_scale_6bit),
+};
+
 static struct snd_kcontrol_new snd_wss_controls[] = {
 WSS_DOUBLE("PCM Playback Switch", 0,
 		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
@@ -2071,6 +2114,14 @@ int snd_wss_mixer(struct snd_wss *chip)
 			if (err < 0)
 				return err;
 		}
+	else if (chip->hardware & WSS_HW_AD1848_MASK)
+		for (idx = 0; idx < ARRAY_SIZE(snd_ad1848_controls); idx++) {
+			err = snd_ctl_add(card,
+					snd_ctl_new1(&snd_ad1848_controls[idx],
+						     chip));
+			if (err < 0)
+				return err;
+		}
 	else
 		for (idx = 0; idx < ARRAY_SIZE(snd_wss_controls); idx++) {
 			err = snd_ctl_add(card,

----------------------------------------------------------------------
Galeria absurdow.
zobacz >>> http://link.interia.pl/f1e5e
