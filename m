From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 6/xx] wss_lib: replace ad1848 mixer element
 macros with wss ones
Date: Thu, 17 Jul 2008 11:34:26 +0200
Message-ID: <20080717113426.85d3cd57.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 1B519243C9
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 11:29:51 +0200 (CEST)
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

Use the wss macros instead of ad1848 ones.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-alsa/include/sound/ad1848.h linux-2.6.25/include/sound/ad1848.h
--- linux-alsa/include/sound/ad1848.h	2008-07-08 18:15:01.000000000 +0200
+++ linux-2.6.25/include/sound/ad1848.h	2008-07-08 19:05:46.000000000 +0200
@@ -126,36 +126,4 @@ int snd_ad1848_pcm(struct snd_wss *chip,
 const struct snd_pcm_ops *snd_ad1848_get_pcm_ops(int direction);
 int snd_ad1848_mixer(struct snd_wss *chip);
 
-/* exported mixer stuffs */
-enum { AD1848_MIX_SINGLE, AD1848_MIX_DOUBLE, AD1848_MIX_CAPTURE };
-
-#define AD1848_MIXVAL_SINGLE(reg, shift, mask, invert) \
-	((reg) | ((shift) << 8) | ((mask) << 16) | ((invert) << 24))
-#define AD1848_MIXVAL_DOUBLE(left_reg, right_reg, shift_left, shift_right, mask, invert) \
-	((left_reg) | ((right_reg) << 8) | ((shift_left) << 16) | ((shift_right) << 19) | ((mask) << 24) | ((invert) << 22))
-
-/* for ease of use */
-struct ad1848_mix_elem {
-	const char *name;
-	int index;
-	int type;
-	unsigned long private_value;
-	const unsigned int *tlv;
-};
-
-#define AD1848_SINGLE(xname, xindex, reg, shift, mask, invert) \
-{ .name = xname, \
-  .index = xindex, \
-  .type = AD1848_MIX_SINGLE, \
-  .private_value = AD1848_MIXVAL_SINGLE(reg, shift, mask, invert) }
-
-#define AD1848_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
-{ .name = xname, \
-  .index = xindex, \
-  .type = AD1848_MIX_DOUBLE, \
-  .private_value = AD1848_MIXVAL_DOUBLE(left_reg, right_reg, shift_left, shift_right, mask, invert) }
-
-int snd_ad1848_add_ctl_elem(struct snd_wss *chip,
-			    const struct ad1848_mix_elem *c);
-
 #endif /* __SOUND_AD1848_H */
diff -urp linux-alsa/sound/isa/ad1848/ad1848_lib.c linux-2.6.25/sound/isa/ad1848/ad1848_lib.c
--- linux-alsa/sound/isa/ad1848/ad1848_lib.c	2008-07-08 18:15:01.000000000 +0200
+++ linux-2.6.25/sound/isa/ad1848/ad1848_lib.c	2008-07-08 19:05:58.000000000 +0200
@@ -1168,86 +1168,57 @@ static int snd_ad1848_put_double(struct 
 	return change;
 }
 
-/*
- */
-int snd_ad1848_add_ctl_elem(struct snd_wss *chip,
-			    const struct ad1848_mix_elem *c)
-{
-	static struct snd_kcontrol_new newctls[] = {
-		[AD1848_MIX_SINGLE] = {
-			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-			.info = snd_ad1848_info_single,
-			.get = snd_ad1848_get_single,
-			.put = snd_ad1848_put_single,
-		},
-		[AD1848_MIX_DOUBLE] = {
-			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-			.info = snd_ad1848_info_double,
-			.get = snd_ad1848_get_double,
-			.put = snd_ad1848_put_double,
-		},
-		[AD1848_MIX_CAPTURE] = {
-			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-			.info = snd_ad1848_info_mux,
-			.get = snd_ad1848_get_mux,
-			.put = snd_ad1848_put_mux,
-		},
-	};
-	struct snd_kcontrol *ctl;
-	int err;
-
-	ctl = snd_ctl_new1(&newctls[c->type], chip);
-	if (! ctl)
-		return -ENOMEM;
-	strlcpy(ctl->id.name, c->name, sizeof(ctl->id.name));
-	ctl->id.index = c->index;
-	ctl->private_value = c->private_value;
-	if (c->tlv) {
-		ctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
-		ctl->tlv.p = c->tlv;
-	}
-	if ((err = snd_ctl_add(chip->card, ctl)) < 0)
-		return err;
-	return 0;
-}
-
-EXPORT_SYMBOL(snd_ad1848_add_ctl_elem);
-
 static const DECLARE_TLV_DB_SCALE(db_scale_6bit, -9450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_5bit_12db_max, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_rec_gain, 0, 150, 0);
 
 #define AD1848_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
-{ .name = xname, \
-  .index = xindex, \
-  .type = AD1848_MIX_SINGLE, \
-  .private_value = AD1848_MIXVAL_SINGLE(reg, shift, mask, invert), \
-  .tlv = xtlv }
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
+  .name = xname, .index = xindex, \
+  .info = snd_ad1848_info_single, \
+  .get = snd_ad1848_get_single, .put = snd_ad1848_put_single, \
+  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24), \
+  .tlv = { .p = (xtlv) } }
 
 #define AD1848_DOUBLE_TLV(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert, xtlv) \
-{ .name = xname, \
-  .index = xindex, \
-  .type = AD1848_MIX_DOUBLE, \
-  .private_value = AD1848_MIXVAL_DOUBLE(left_reg, right_reg, shift_left, shift_right, mask, invert), \
-  .tlv = xtlv }
-
-static struct ad1848_mix_elem snd_ad1848_controls[] = {
-AD1848_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
-AD1848_DOUBLE_TLV("PCM Playback Volume", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1,
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
+  .name = xname, .index = xindex, \
+  .info = snd_ad1848_info_double, \
+  .get = snd_ad1848_get_double, .put = snd_ad1848_put_double, \
+  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
+		   (shift_right << 19) | (mask << 24) | (invert << 22), \
+  .tlv = { .p = (xtlv) } }
+
+
+static struct snd_kcontrol_new snd_ad1848_controls[] = {
+WSS_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT,
+	   7, 7, 1, 1),
+AD1848_DOUBLE_TLV("PCM Playback Volume", 0,
+		  AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1,
 		  db_scale_6bit),
-AD1848_DOUBLE("Aux Playback Switch", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-AD1848_DOUBLE_TLV("Aux Playback Volume", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 0, 0, 31, 1,
+WSS_DOUBLE("Aux Playback Switch", 0,
+	   AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+AD1848_DOUBLE_TLV("Aux Playback Volume", 0,
+		  AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 0, 0, 31, 1,
 		  db_scale_5bit_12db_max),
-AD1848_DOUBLE("Aux Playback Switch", 1, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-AD1848_DOUBLE_TLV("Aux Playback Volume", 1, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
+WSS_DOUBLE("Aux Playback Switch", 1,
+	   AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+AD1848_DOUBLE_TLV("Aux Playback Volume", 1,
+		  AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
 		  db_scale_5bit_12db_max),
-AD1848_DOUBLE_TLV("Capture Volume", 0, AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 0, 0, 15, 0,
+AD1848_DOUBLE_TLV("Capture Volume", 0,
+		  AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 0, 0, 15, 0,
 		  db_scale_rec_gain),
 {
 	.name = "Capture Source",
-	.type = AD1848_MIX_CAPTURE,
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.info = snd_ad1848_info_mux,
+	.get = snd_ad1848_get_mux,
+	.put = snd_ad1848_put_mux,
 },
-AD1848_SINGLE("Loopback Capture Switch", 0, AD1848_LOOPBACK, 0, 1, 0),
+WSS_SINGLE("Loopback Capture Switch", 0, AD1848_LOOPBACK, 0, 1, 0),
 AD1848_SINGLE_TLV("Loopback Capture Volume", 0, AD1848_LOOPBACK, 1, 63, 0,
 		  db_scale_6bit),
 };
@@ -1266,9 +1237,12 @@ int snd_ad1848_mixer(struct snd_wss *chi
 
 	strcpy(card->mixername, pcm->name);
 
-	for (idx = 0; idx < ARRAY_SIZE(snd_ad1848_controls); idx++)
-		if ((err = snd_ad1848_add_ctl_elem(chip, &snd_ad1848_controls[idx])) < 0)
+	for (idx = 0; idx < ARRAY_SIZE(snd_ad1848_controls); idx++) {
+		err = snd_ctl_add(card,
+				snd_ctl_new1(&snd_ad1848_controls[idx], chip));
+		if (err < 0)
 			return err;
+	}
 
 	return 0;
 }
diff -urp linux-alsa/sound/isa/cmi8330.c linux-2.6.25/sound/isa/cmi8330.c
--- linux-alsa/sound/isa/cmi8330.c	2008-07-08 18:15:01.000000000 +0200
+++ linux-2.6.25/sound/isa/cmi8330.c	2008-07-08 19:22:23.000000000 +0200
@@ -174,32 +174,48 @@ MODULE_DEVICE_TABLE(pnp_card, snd_cmi833
 #endif
 
 
-static struct ad1848_mix_elem snd_cmi8330_controls[] __devinitdata = {
-AD1848_DOUBLE("Master Playback Volume", 0, CMI8330_MASTVOL, CMI8330_MASTVOL, 4, 0, 15, 0),
-AD1848_SINGLE("Loud Playback Switch", 0, CMI8330_MUTEMUX, 6, 1, 1),
-AD1848_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
-AD1848_DOUBLE("PCM Playback Volume", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1),
-AD1848_DOUBLE("Line Playback Switch", 0, CMI8330_MUTEMUX, CMI8330_MUTEMUX, 4, 3, 1, 0),
-AD1848_DOUBLE("Line Playback Volume", 0, CMI8330_LINVOL, CMI8330_LINVOL, 4, 0, 15, 0),
-AD1848_DOUBLE("Line Capture Switch", 0, CMI8330_RMUX3D, CMI8330_RMUX3D, 2, 1, 1, 0),
-AD1848_DOUBLE("Line Capture Volume", 0, CMI8330_LINGAIN, CMI8330_LINGAIN, 4, 0, 15, 0),
-AD1848_DOUBLE("CD Playback Switch", 0, CMI8330_MUTEMUX, CMI8330_MUTEMUX, 2, 1, 1, 0),
-AD1848_DOUBLE("CD Capture Switch", 0, CMI8330_RMUX3D, CMI8330_RMUX3D, 4, 3, 1, 0),
-AD1848_DOUBLE("CD Playback Volume", 0, CMI8330_CDINVOL, CMI8330_CDINVOL, 4, 0, 15, 0),
-AD1848_DOUBLE("CD Capture Volume", 0, CMI8330_CDINGAIN, CMI8330_CDINGAIN, 4, 0, 15, 0),
-AD1848_SINGLE("Mic Playback Switch", 0, CMI8330_MUTEMUX, 0, 1, 0),
-AD1848_SINGLE("Mic Playback Volume", 0, CMI8330_OUTPUTVOL, 0, 7, 0),
-AD1848_SINGLE("Mic Capture Switch", 0, CMI8330_RMUX3D, 0, 1, 0),
-AD1848_SINGLE("Mic Capture Volume", 0, CMI8330_OUTPUTVOL, 5, 7, 0),
-AD1848_DOUBLE("Wavetable Playback Switch", 0, CMI8330_RECMUX, CMI8330_RECMUX, 1, 0, 1, 0),
-AD1848_DOUBLE("Wavetable Playback Volume", 0, CMI8330_WAVVOL, CMI8330_WAVVOL, 4, 0, 15, 0),
-AD1848_DOUBLE("Wavetable Capture Switch", 0, CMI8330_RECMUX, CMI8330_RECMUX, 5, 4, 1, 0),
-AD1848_DOUBLE("Wavetable Capture Volume", 0, CMI8330_WAVGAIN, CMI8330_WAVGAIN, 4, 0, 15, 0),
-AD1848_SINGLE("3D Control - Switch", 0, CMI8330_RMUX3D, 5, 1, 1),
-AD1848_SINGLE("PC Speaker Playback Volume", 0, CMI8330_OUTPUTVOL, 3, 3, 0),
-AD1848_SINGLE("FM Playback Switch", 0, CMI8330_RECMUX, 3, 1, 1),
-AD1848_SINGLE(SNDRV_CTL_NAME_IEC958("Input ",CAPTURE,SWITCH), 0, CMI8330_RMUX3D, 7, 1, 1),
-AD1848_SINGLE(SNDRV_CTL_NAME_IEC958("Input ",PLAYBACK,SWITCH), 0, CMI8330_MUTEMUX, 7, 1, 1),
+static struct snd_kcontrol_new snd_cmi8330_controls[] __devinitdata = {
+WSS_DOUBLE("Master Playback Volume", 0, CMI8330_MASTVOL, CMI8330_MASTVOL,
+	   4, 0, 15, 0),
+WSS_SINGLE("Loud Playback Switch", 0, CMI8330_MUTEMUX, 6, 1, 1),
+WSS_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT,
+	   7, 7, 1, 1),
+WSS_DOUBLE("PCM Playback Volume", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT,
+	   0, 0, 63, 1),
+WSS_DOUBLE("Line Playback Switch", 0, CMI8330_MUTEMUX, CMI8330_MUTEMUX,
+	   4, 3, 1, 0),
+WSS_DOUBLE("Line Playback Volume", 0, CMI8330_LINVOL, CMI8330_LINVOL,
+	   4, 0, 15, 0),
+WSS_DOUBLE("Line Capture Switch", 0, CMI8330_RMUX3D, CMI8330_RMUX3D,
+	   2, 1, 1, 0),
+WSS_DOUBLE("Line Capture Volume", 0, CMI8330_LINGAIN, CMI8330_LINGAIN,
+	   4, 0, 15, 0),
+WSS_DOUBLE("CD Playback Switch", 0, CMI8330_MUTEMUX, CMI8330_MUTEMUX,
+	   2, 1, 1, 0),
+WSS_DOUBLE("CD Capture Switch", 0, CMI8330_RMUX3D, CMI8330_RMUX3D, 4, 3, 1, 0),
+WSS_DOUBLE("CD Playback Volume", 0, CMI8330_CDINVOL, CMI8330_CDINVOL,
+	   4, 0, 15, 0),
+WSS_DOUBLE("CD Capture Volume", 0, CMI8330_CDINGAIN, CMI8330_CDINGAIN,
+	   4, 0, 15, 0),
+WSS_SINGLE("Mic Playback Switch", 0, CMI8330_MUTEMUX, 0, 1, 0),
+WSS_SINGLE("Mic Playback Volume", 0, CMI8330_OUTPUTVOL, 0, 7, 0),
+WSS_SINGLE("Mic Capture Switch", 0, CMI8330_RMUX3D, 0, 1, 0),
+WSS_SINGLE("Mic Capture Volume", 0, CMI8330_OUTPUTVOL, 5, 7, 0),
+WSS_DOUBLE("Wavetable Playback Switch", 0, CMI8330_RECMUX, CMI8330_RECMUX,
+	   1, 0, 1, 0),
+WSS_DOUBLE("Wavetable Playback Volume", 0, CMI8330_WAVVOL, CMI8330_WAVVOL,
+	   4, 0, 15, 0),
+WSS_DOUBLE("Wavetable Capture Switch", 0, CMI8330_RECMUX, CMI8330_RECMUX,
+	   5, 4, 1, 0),
+WSS_DOUBLE("Wavetable Capture Volume", 0, CMI8330_WAVGAIN, CMI8330_WAVGAIN,
+	   4, 0, 15, 0),
+WSS_SINGLE("3D Control - Switch", 0, CMI8330_RMUX3D, 5, 1, 1),
+WSS_SINGLE("PC Speaker Playback Volume", 0, CMI8330_OUTPUTVOL, 3, 3, 0),
+WSS_SINGLE("FM Playback Switch", 0, CMI8330_RECMUX, 3, 1, 1),
+WSS_SINGLE(SNDRV_CTL_NAME_IEC958("Input ", CAPTURE, SWITCH), 0, CMI8330_RMUX3D,
+	   7, 1, 1),
+WSS_SINGLE(SNDRV_CTL_NAME_IEC958("Input ", PLAYBACK, SWITCH), 0,
+	   CMI8330_MUTEMUX, 7, 1, 1),
 };
 
 #ifdef ENABLE_SB_MIXER
@@ -268,7 +284,10 @@ static int __devinit snd_cmi8330_mixer(s
 	strcpy(card->mixername, "CMI8330/C3D");
 
 	for (idx = 0; idx < ARRAY_SIZE(snd_cmi8330_controls); idx++) {
-		if ((err = snd_ad1848_add_ctl_elem(acard->wss, &snd_cmi8330_controls[idx])) < 0)
+		err = snd_ctl_add(card,
+				snd_ctl_new1(&snd_cmi8330_controls[idx],
+					     acard->wss));
+		if (err < 0)
 			return err;
 	}
 
diff -urp linux-alsa/sound/isa/sgalaxy.c linux-2.6.25/sound/isa/sgalaxy.c
--- linux-alsa/sound/isa/sgalaxy.c	2008-07-08 18:15:01.000000000 +0200
+++ linux-2.6.25/sound/isa/sgalaxy.c	2008-07-08 19:20:27.000000000 +0200
@@ -175,9 +175,9 @@ static int __devinit snd_sgalaxy_detect(
 	return snd_sgalaxy_setup_wss(wssport[dev], irq, dma);
 }
 
-static struct ad1848_mix_elem snd_sgalaxy_controls[] = {
-AD1848_DOUBLE("Aux Playback Switch", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 7, 7, 1, 1),
-AD1848_DOUBLE("Aux Playback Volume", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 0, 0, 31, 0)
+static struct snd_kcontrol_new snd_sgalaxy_controls[] = {
+WSS_DOUBLE("Aux Playback Switch", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 7, 7, 1, 1),
+WSS_DOUBLE("Aux Playback Volume", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 0, 0, 31, 0)
 };
 
 static int __devinit snd_sgalaxy_mixer(struct snd_wss *chip)
@@ -210,7 +210,9 @@ static int __devinit snd_sgalaxy_mixer(s
 		return err;
 	/* build AUX2 input */
 	for (idx = 0; idx < ARRAY_SIZE(snd_sgalaxy_controls); idx++) {
-		if ((err = snd_ad1848_add_ctl_elem(chip, &snd_sgalaxy_controls[idx])) < 0)
+		err = snd_ctl_add(card,
+				snd_ctl_new1(&snd_sgalaxy_controls[idx], chip));
+		if (err < 0)
 			return err;
 	}
 	return 0;

----------------------------------------------------------------------
Zobacz cala prawde o Lukaszu Podolskim!
kliknij >>> http://link.interia.pl/f1e57
