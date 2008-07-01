From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] wss: rename cs4321_foo to wss_foo
Date: Tue, 1 Jul 2008 20:12:05 +0200
Message-ID: <20080701201205.4ad96247.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id B9ABD24436
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 20:08:27 +0200 (CEST)
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

Rename functions and structures from the former 
cs4321_lib to names more corresponding with the 
new name: wss_lib.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
Another step toward unification of all WSS compatible
chips handling.

This patch is huge because it contains formatting fixes
in all places the function names changed (and maybe
few other as well). There are few issues left in the patch
but I don't know how to fix them and do not lose common
sense.

diff -urp linux-alsa/include/sound/wss.h linux-mm/include/sound/wss.h
--- linux-alsa/include/sound/wss.h	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/include/sound/wss.h	2008-06-25 23:45:58.063543700 +0200
@@ -1,5 +1,5 @@
-#ifndef __SOUND_CS4231_H
-#define __SOUND_CS4231_H
+#ifndef __SOUND_WSS_H
+#define __SOUND_WSS_H
 
 /*
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
@@ -30,42 +30,42 @@
 
 /* defines for codec.mode */
 
-#define CS4231_MODE_NONE	0x0000
-#define CS4231_MODE_PLAY	0x0001
-#define CS4231_MODE_RECORD	0x0002
-#define CS4231_MODE_TIMER	0x0004
-#define CS4231_MODE_OPEN	(CS4231_MODE_PLAY|CS4231_MODE_RECORD|CS4231_MODE_TIMER)
+#define WSS_MODE_NONE	0x0000
+#define WSS_MODE_PLAY	0x0001
+#define WSS_MODE_RECORD	0x0002
+#define WSS_MODE_TIMER	0x0004
+#define WSS_MODE_OPEN	(WSS_MODE_PLAY|WSS_MODE_RECORD|WSS_MODE_TIMER)
 
 /* defines for codec.hardware */
 
-#define CS4231_HW_DETECT        0x0000	/* let CS4231 driver detect chip */
-#define CS4231_HW_DETECT3	0x0001	/* allow mode 3 */
-#define CS4231_HW_TYPE_MASK	0xff00	/* type mask */
-#define CS4231_HW_CS4231_MASK   0x0100	/* CS4231 serie */
-#define CS4231_HW_CS4231        0x0100	/* CS4231 chip */
-#define CS4231_HW_CS4231A       0x0101	/* CS4231A chip */
-#define CS4231_HW_AD1845	0x0102	/* AD1845 chip */
-#define CS4231_HW_CS4232_MASK   0x0200	/* CS4232 serie (has control ports) */
-#define CS4231_HW_CS4232        0x0200	/* CS4232 */
-#define CS4231_HW_CS4232A       0x0201	/* CS4232A */
-#define CS4231_HW_CS4236	0x0202	/* CS4236 */
-#define CS4231_HW_CS4236B_MASK	0x0400	/* CS4236B serie (has extended control regs) */
-#define CS4231_HW_CS4235	0x0400	/* CS4235 - Crystal Clear (tm) stereo enhancement */
-#define CS4231_HW_CS4236B       0x0401	/* CS4236B */
-#define CS4231_HW_CS4237B       0x0402	/* CS4237B - SRS 3D */
-#define CS4231_HW_CS4238B	0x0403	/* CS4238B - QSOUND 3D */
-#define CS4231_HW_CS4239	0x0404	/* CS4239 - Crystal Clear (tm) stereo enhancement */
+#define WSS_HW_DETECT        0x0000	/* let CS4231 driver detect chip */
+#define WSS_HW_DETECT3	0x0001	/* allow mode 3 */
+#define WSS_HW_TYPE_MASK	0xff00	/* type mask */
+#define WSS_HW_CS4231_MASK   0x0100	/* CS4231 serie */
+#define WSS_HW_CS4231        0x0100	/* CS4231 chip */
+#define WSS_HW_CS4231A       0x0101	/* CS4231A chip */
+#define WSS_HW_AD1845	0x0102	/* AD1845 chip */
+#define WSS_HW_CS4232_MASK   0x0200	/* CS4232 serie (has control ports) */
+#define WSS_HW_CS4232        0x0200	/* CS4232 */
+#define WSS_HW_CS4232A       0x0201	/* CS4232A */
+#define WSS_HW_CS4236	0x0202	/* CS4236 */
+#define WSS_HW_CS4236B_MASK	0x0400	/* CS4236B serie (has extended control regs) */
+#define WSS_HW_CS4235	0x0400	/* CS4235 - Crystal Clear (tm) stereo enhancement */
+#define WSS_HW_CS4236B       0x0401	/* CS4236B */
+#define WSS_HW_CS4237B       0x0402	/* CS4237B - SRS 3D */
+#define WSS_HW_CS4238B	0x0403	/* CS4238B - QSOUND 3D */
+#define WSS_HW_CS4239	0x0404	/* CS4239 - Crystal Clear (tm) stereo enhancement */
 /* compatible, but clones */
-#define CS4231_HW_INTERWAVE     0x1000	/* InterWave chip */
-#define CS4231_HW_OPL3SA2       0x1101	/* OPL3-SA2 chip, similar to cs4231 */
-#define CS4231_HW_OPTI93X 	0x1102	/* Opti 930/931/933 */
+#define WSS_HW_INTERWAVE     0x1000	/* InterWave chip */
+#define WSS_HW_OPL3SA2       0x1101	/* OPL3-SA2 chip, similar to cs4231 */
+#define WSS_HW_OPTI93X 	0x1102	/* Opti 930/931/933 */
 
 /* defines for codec.hwshare */
-#define CS4231_HWSHARE_IRQ	(1<<0)
-#define CS4231_HWSHARE_DMA1	(1<<1)
-#define CS4231_HWSHARE_DMA2	(1<<2)
+#define WSS_HWSHARE_IRQ	(1<<0)
+#define WSS_HWSHARE_DMA1	(1<<1)
+#define WSS_HWSHARE_DMA2	(1<<2)
 
-struct snd_cs4231 {
+struct snd_wss {
 	unsigned long port;		/* base i/o port */
 	struct resource *res_port;
 	unsigned long cport;		/* control base i/o port (CS4236) */
@@ -74,8 +74,8 @@ struct snd_cs4231 {
 	int dma1;			/* playback DMA */
 	int dma2;			/* record DMA */
 	unsigned short version;		/* version of CODEC chip */
-	unsigned short mode;		/* see to CS4231_MODE_XXXX */
-	unsigned short hardware;	/* see to CS4231_HW_XXXX */
+	unsigned short mode;		/* see to WSS_MODE_XXXX */
+	unsigned short hardware;	/* see to WSS_HW_XXXX */
 	unsigned short hwshare;		/* shared resources */
 	unsigned short single_dma:1,	/* forced single DMA mode (GUS 16-bit daughter board) or dma1 == dma2 */
 		       ebus_flag:1;	/* SPARC: EBUS present */
@@ -100,43 +100,50 @@ struct snd_cs4231 {
 	struct mutex open_mutex;
 
 	int (*rate_constraint) (struct snd_pcm_runtime *runtime);
-	void (*set_playback_format) (struct snd_cs4231 *chip, struct snd_pcm_hw_params *hw_params, unsigned char pdfr);
-	void (*set_capture_format) (struct snd_cs4231 *chip, struct snd_pcm_hw_params *hw_params, unsigned char cdfr);
-	void (*trigger) (struct snd_cs4231 *chip, unsigned int what, int start);
+	void (*set_playback_format) (struct snd_wss *chip,
+				     struct snd_pcm_hw_params *hw_params,
+				     unsigned char pdfr);
+	void (*set_capture_format) (struct snd_wss *chip,
+				    struct snd_pcm_hw_params *hw_params,
+				    unsigned char cdfr);
+	void (*trigger) (struct snd_wss *chip, unsigned int what, int start);
 #ifdef CONFIG_PM
-	void (*suspend) (struct snd_cs4231 *chip);
-	void (*resume) (struct snd_cs4231 *chip);
+	void (*suspend) (struct snd_wss *chip);
+	void (*resume) (struct snd_wss *chip);
 #endif
 	void *dma_private_data;
-	int (*claim_dma) (struct snd_cs4231 *chip, void *dma_private_data, int dma);
-	int (*release_dma) (struct snd_cs4231 *chip, void *dma_private_data, int dma);
+	int (*claim_dma) (struct snd_wss *chip,
+			  void *dma_private_data, int dma);
+	int (*release_dma) (struct snd_wss *chip,
+			    void *dma_private_data, int dma);
 };
 
 /* exported functions */
 
-void snd_cs4231_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char val);
-unsigned char snd_cs4231_in(struct snd_cs4231 *chip, unsigned char reg);
-void snd_cs4236_ext_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char val);
-unsigned char snd_cs4236_ext_in(struct snd_cs4231 *chip, unsigned char reg);
-void snd_cs4231_mce_up(struct snd_cs4231 *chip);
-void snd_cs4231_mce_down(struct snd_cs4231 *chip);
+void snd_wss_out(struct snd_wss *chip, unsigned char reg, unsigned char val);
+unsigned char snd_wss_in(struct snd_wss *chip, unsigned char reg);
+void snd_cs4236_ext_out(struct snd_wss *chip,
+			unsigned char reg, unsigned char val);
+unsigned char snd_cs4236_ext_in(struct snd_wss *chip, unsigned char reg);
+void snd_wss_mce_up(struct snd_wss *chip);
+void snd_wss_mce_down(struct snd_wss *chip);
 
-void snd_cs4231_overrange(struct snd_cs4231 *chip);
+void snd_wss_overrange(struct snd_wss *chip);
 
-irqreturn_t snd_cs4231_interrupt(int irq, void *dev_id);
+irqreturn_t snd_wss_interrupt(int irq, void *dev_id);
 
-const char *snd_cs4231_chip_id(struct snd_cs4231 *chip);
+const char *snd_wss_chip_id(struct snd_wss *chip);
 
-int snd_cs4231_create(struct snd_card *card,
+int snd_wss_create(struct snd_card *card,
 		      unsigned long port,
 		      unsigned long cport,
 		      int irq, int dma1, int dma2,
 		      unsigned short hardware,
 		      unsigned short hwshare,
-		      struct snd_cs4231 ** rchip);
-int snd_cs4231_pcm(struct snd_cs4231 * chip, int device, struct snd_pcm **rpcm);
-int snd_cs4231_timer(struct snd_cs4231 * chip, int device, struct snd_timer **rtimer);
-int snd_cs4231_mixer(struct snd_cs4231 * chip);
+		      struct snd_wss **rchip);
+int snd_wss_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
+int snd_wss_timer(struct snd_wss *chip, int device, struct snd_timer **rtimer);
+int snd_wss_mixer(struct snd_wss *chip);
 
 int snd_cs4236_create(struct snd_card *card,
 		      unsigned long port,
@@ -144,32 +151,38 @@ int snd_cs4236_create(struct snd_card *c
 		      int irq, int dma1, int dma2,
 		      unsigned short hardware,
 		      unsigned short hwshare,
-		      struct snd_cs4231 ** rchip);
-int snd_cs4236_pcm(struct snd_cs4231 * chip, int device, struct snd_pcm **rpcm);
-int snd_cs4236_mixer(struct snd_cs4231 * chip);
+		      struct snd_wss **rchip);
+int snd_cs4236_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
+int snd_cs4236_mixer(struct snd_wss *chip);
 
 /*
  *  mixer library
  */
 
-#define CS4231_SINGLE(xname, xindex, reg, shift, mask, invert) \
+#define WSS_SINGLE(xname, xindex, reg, shift, mask, invert) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_cs4231_info_single, \
-  .get = snd_cs4231_get_single, .put = snd_cs4231_put_single, \
+  .info = snd_wss_info_single, \
+  .get = snd_wss_get_single, .put = snd_wss_put_single, \
   .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24) }
 
-int snd_cs4231_info_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo);
-int snd_cs4231_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
-int snd_cs4231_put_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int snd_wss_info_single(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo);
+int snd_wss_get_single(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol);
+int snd_wss_put_single(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol);
 
-#define CS4231_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
+#define WSS_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_cs4231_info_double, \
-  .get = snd_cs4231_get_double, .put = snd_cs4231_put_double, \
+  .info = snd_wss_info_double, \
+  .get = snd_wss_get_double, .put = snd_wss_put_double, \
   .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22) }
 
-int snd_cs4231_info_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo);
-int snd_cs4231_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
-int snd_cs4231_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int snd_wss_info_double(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo);
+int snd_wss_get_double(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol);
+int snd_wss_put_double(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol);
 
-#endif /* __SOUND_CS4231_H */
+#endif /* __SOUND_WSS_H */
diff -urp linux-alsa/sound/isa/ad1848/ad1848.c linux-mm/sound/isa/ad1848/ad1848.c
--- linux-alsa/sound/isa/ad1848/ad1848.c	2008-06-14 00:05:02.000000000 +0200
+++ linux-mm/sound/isa/ad1848/ad1848.c	2008-06-25 18:41:45.531158672 +0200
@@ -70,15 +70,15 @@ static int __devinit snd_ad1848_match(st
 		return 0;
 
 	if (port[n] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+		snd_printk(KERN_ERR "%s: please specify port\n", dev_name(dev));
 		return 0;
 	}
 	if (irq[n] == SNDRV_AUTO_IRQ) {
-		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
+		snd_printk(KERN_ERR "%s: please specify irq\n", dev_name(dev));
 		return 0;	
 	}
 	if (dma1[n] == SNDRV_AUTO_DMA) {
-		snd_printk(KERN_ERR "%s: please specify dma1\n", dev->bus_id);
+		snd_printk(KERN_ERR "%s: please specify dma1\n", dev_name(dev));
 		return 0;
 	}
 	return 1;
diff -urp linux-alsa/sound/isa/azt2320.c linux-mm/sound/isa/azt2320.c
--- linux-alsa/sound/isa/azt2320.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/azt2320.c	2008-06-25 18:41:45.599174329 +0200
@@ -76,7 +76,7 @@ struct snd_card_azt2320 {
 	int dev_no;
 	struct pnp_dev *dev;
 	struct pnp_dev *devmpu;
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 };
 
 static struct pnp_card_device_id snd_azt2320_pnpids[] = {
@@ -181,7 +181,7 @@ static int __devinit snd_card_azt2320_pr
 	int error;
 	struct snd_card *card;
 	struct snd_card_azt2320 *acard;
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	struct snd_opl3 *opl3;
 
 	if ((card = snd_card_new(index[dev], id[dev], THIS_MODULE,
@@ -200,11 +200,12 @@ static int __devinit snd_card_azt2320_pr
 		return error;
 	}
 
-	if ((error = snd_cs4231_create(card, wss_port[dev], -1,
-				       irq[dev],
-				       dma1[dev],
-				       dma2[dev],
-				       CS4231_HW_DETECT, 0, &chip)) < 0) {
+	error = snd_wss_create(card, wss_port[dev], -1,
+			       irq[dev],
+			       dma1[dev],
+			       dma2[dev],
+			       WSS_HW_DETECT, 0, &chip);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
@@ -214,15 +215,18 @@ static int __devinit snd_card_azt2320_pr
 	sprintf(card->longname, "%s, WSS at 0x%lx, irq %i, dma %i&%i",
 		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
 
-	if ((error = snd_cs4231_pcm(chip, 0, NULL)) < 0) {
+	error = snd_wss_pcm(chip, 0, NULL);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
-	if ((error = snd_cs4231_mixer(chip)) < 0) {
+	error = snd_wss_mixer(chip);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
-	if ((error = snd_cs4231_timer(chip, 0, NULL)) < 0) {
+	error = snd_wss_timer(chip, 0, NULL);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
@@ -293,7 +297,7 @@ static int snd_azt2320_pnp_suspend(struc
 {
 	struct snd_card *card = pnp_get_card_drvdata(pcard);
 	struct snd_card_azt2320 *acard = card->private_data;
-	struct snd_cs4231 *chip = acard->chip;
+	struct snd_wss *chip = acard->chip;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	chip->suspend(chip);
@@ -304,7 +308,7 @@ static int snd_azt2320_pnp_resume(struct
 {
 	struct snd_card *card = pnp_get_card_drvdata(pcard);
 	struct snd_card_azt2320 *acard = card->private_data;
-	struct snd_cs4231 *chip = acard->chip;
+	struct snd_wss *chip = acard->chip;
 
 	chip->resume(chip);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
diff -urp linux-alsa/sound/isa/cs423x/cs4231.c linux-mm/sound/isa/cs423x/cs4231.c
--- linux-alsa/sound/isa/cs423x/cs4231.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/cs423x/cs4231.c	2008-06-25 18:41:45.647162309 +0200
@@ -91,7 +91,7 @@ static int __devinit snd_cs4231_match(st
 static int __devinit snd_cs4231_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	struct snd_pcm *pcm;
 	int error;
 
@@ -99,14 +99,14 @@ static int __devinit snd_cs4231_probe(st
 	if (!card)
 		return -EINVAL;
 
-	error = snd_cs4231_create(card, port[n], -1, irq[n], dma1[n], dma2[n],
-			CS4231_HW_DETECT, 0, &chip);
+	error = snd_wss_create(card, port[n], -1, irq[n], dma1[n], dma2[n],
+			WSS_HW_DETECT, 0, &chip);
 	if (error < 0)
 		goto out;
 
 	card->private_data = chip;
 
-	error = snd_cs4231_pcm(chip, 0, &pcm);
+	error = snd_wss_pcm(chip, 0, &pcm);
 	if (error < 0)
 		goto out;
 
@@ -118,11 +118,11 @@ static int __devinit snd_cs4231_probe(st
 	if (dma2[n] >= 0)
 		sprintf(card->longname + strlen(card->longname), "&%d", dma2[n]);
 
-	error = snd_cs4231_mixer(chip);
+	error = snd_wss_mixer(chip);
 	if (error < 0)
 		goto out;
 
-	error = snd_cs4231_timer(chip, 0, NULL);
+	error = snd_wss_timer(chip, 0, NULL);
 	if (error < 0)
 		goto out;
 
@@ -160,7 +160,7 @@ static int __devexit snd_cs4231_remove(s
 static int snd_cs4231_suspend(struct device *dev, unsigned int n, pm_message_t state)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct snd_cs4231 *chip = card->private_data;
+	struct snd_wss *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	chip->suspend(chip);
@@ -170,7 +170,7 @@ static int snd_cs4231_suspend(struct dev
 static int snd_cs4231_resume(struct device *dev, unsigned int n)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct snd_cs4231 *chip = card->private_data;
+	struct snd_wss *chip = card->private_data;
 
 	chip->resume(chip);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
diff -urp linux-alsa/sound/isa/cs423x/cs4236.c linux-mm/sound/isa/cs423x/cs4236.c
--- linux-alsa/sound/isa/cs423x/cs4236.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/cs423x/cs4236.c	2008-06-25 18:41:45.663172931 +0200
@@ -134,7 +134,7 @@ static int pnp_registered;
 #endif /* CONFIG_PNP */
 
 struct snd_card_cs4236 {
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	struct resource *res_sb_port;
 #ifdef CONFIG_PNP
 	struct pnp_dev *wss;
@@ -395,7 +395,7 @@ static int __devinit snd_cs423x_probe(st
 {
 	struct snd_card_cs4236 *acard;
 	struct snd_pcm *pcm;
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	struct snd_opl3 *opl3;
 	int err;
 
@@ -407,41 +407,37 @@ static int __devinit snd_cs423x_probe(st
 		}
 
 #ifdef CS4232
-	if ((err = snd_cs4231_create(card,
-				     port[dev],
-				     cport[dev],
-				     irq[dev],
-				     dma1[dev],
-				     dma2[dev],
-				     CS4231_HW_DETECT,
-				     0,
-				     &chip)) < 0)
+	err = snd_wss_create(card,
+			     port[dev], cport[dev], irq[dev],
+			     dma1[dev], dma2[dev],
+			     WSS_HW_DETECT, 0, &chip);
+	if (err < 0)
 		return err;
 	acard->chip = chip;
 
-	if ((err = snd_cs4231_pcm(chip, 0, &pcm)) < 0)
+	err = snd_wss_pcm(chip, 0, &pcm);
+	if (err < 0)
 		return err;
 
-	if ((err = snd_cs4231_mixer(chip)) < 0)
+	err = snd_wss_mixer(chip);
+	if (err < 0)
 		return err;
 
 #else /* CS4236 */
-	if ((err = snd_cs4236_create(card,
-				     port[dev],
-				     cport[dev],
-				     irq[dev],
-				     dma1[dev],
-				     dma2[dev],
-				     CS4231_HW_DETECT,
-				     0,
-				     &chip)) < 0)
+	err = snd_cs4236_create(card,
+				port[dev], cport[dev],
+				irq[dev], dma1[dev], dma2[dev],
+				WSS_HW_DETECT, 0, &chip);
+	if (err < 0)
 		return err;
 	acard->chip = chip;
 
-	if ((err = snd_cs4236_pcm(chip, 0, &pcm)) < 0)
+	err = snd_cs4236_pcm(chip, 0, &pcm);
+	if (err < 0)
 		return err;
 
-	if ((err = snd_cs4236_mixer(chip)) < 0)
+	err = snd_cs4236_mixer(chip);
+	if (err < 0)
 		return err;
 #endif
 	strcpy(card->driver, pcm->name);
@@ -454,7 +450,8 @@ static int __devinit snd_cs423x_probe(st
 	if (dma2[dev] >= 0)
 		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
 
-	if ((err = snd_cs4231_timer(chip, 0, NULL)) < 0)
+	err = snd_wss_timer(chip, 0, NULL);
+	if (err < 0)
 		return err;
 
 	if (fm_port[dev] > 0 && fm_port[dev] != SNDRV_AUTO_PORT) {
diff -urp linux-alsa/sound/isa/cs423x/cs4236_lib.c linux-mm/sound/isa/cs423x/cs4236_lib.c
--- linux-alsa/sound/isa/cs423x/cs4236_lib.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/cs423x/cs4236_lib.c	2008-06-25 23:32:58.556208225 +0200
@@ -121,13 +121,14 @@ static unsigned char snd_cs4236_ext_map[
  *
  */
 
-static void snd_cs4236_ctrl_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char val)
+static void snd_cs4236_ctrl_out(struct snd_wss *chip,
+				unsigned char reg, unsigned char val)
 {
 	outb(reg, chip->cport + 3);
 	outb(chip->cimage[reg] = val, chip->cport + 4);
 }
 
-static unsigned char snd_cs4236_ctrl_in(struct snd_cs4231 *chip, unsigned char reg)
+static unsigned char snd_cs4236_ctrl_in(struct snd_wss *chip, unsigned char reg)
 {
 	outb(reg, chip->cport + 3);
 	return inb(chip->cport + 4);
@@ -180,44 +181,52 @@ static unsigned char divisor_to_rate_reg
 	}
 }
 
-static void snd_cs4236_playback_format(struct snd_cs4231 *chip, struct snd_pcm_hw_params *params, unsigned char pdfr)
+static void snd_cs4236_playback_format(struct snd_wss *chip,
+				       struct snd_pcm_hw_params *params,
+				       unsigned char pdfr)
 {
 	unsigned long flags;
 	unsigned char rate = divisor_to_rate_register(params->rate_den);
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	/* set fast playback format change and clean playback FIFO */
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | 0x10);
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, pdfr & 0xf0);
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] & ~0x10);
+	snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+		    chip->image[CS4231_ALT_FEATURE_1] | 0x10);
+	snd_wss_out(chip, CS4231_PLAYBK_FORMAT, pdfr & 0xf0);
+	snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+		    chip->image[CS4231_ALT_FEATURE_1] & ~0x10);
 	snd_cs4236_ext_out(chip, CS4236_DAC_RATE, rate);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static void snd_cs4236_capture_format(struct snd_cs4231 *chip, struct snd_pcm_hw_params *params, unsigned char cdfr)
+static void snd_cs4236_capture_format(struct snd_wss *chip,
+				      struct snd_pcm_hw_params *params,
+				      unsigned char cdfr)
 {
 	unsigned long flags;
 	unsigned char rate = divisor_to_rate_register(params->rate_den);
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	/* set fast capture format change and clean capture FIFO */
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | 0x20);
-	snd_cs4231_out(chip, CS4231_REC_FORMAT, cdfr & 0xf0);
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] & ~0x20);
+	snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+		    chip->image[CS4231_ALT_FEATURE_1] | 0x20);
+	snd_wss_out(chip, CS4231_REC_FORMAT, cdfr & 0xf0);
+	snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+		    chip->image[CS4231_ALT_FEATURE_1] & ~0x20);
 	snd_cs4236_ext_out(chip, CS4236_ADC_RATE, rate);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
 #ifdef CONFIG_PM
 
-static void snd_cs4236_suspend(struct snd_cs4231 *chip)
+static void snd_cs4236_suspend(struct snd_wss *chip)
 {
 	int reg;
 	unsigned long flags;
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	for (reg = 0; reg < 32; reg++)
-		chip->image[reg] = snd_cs4231_in(chip, reg);
+		chip->image[reg] = snd_wss_in(chip, reg);
 	for (reg = 0; reg < 18; reg++)
 		chip->eimage[reg] = snd_cs4236_ext_in(chip, CS4236_I23VAL(reg));
 	for (reg = 2; reg < 9; reg++)
@@ -225,12 +234,12 @@ static void snd_cs4236_suspend(struct sn
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static void snd_cs4236_resume(struct snd_cs4231 *chip)
+static void snd_cs4236_resume(struct snd_wss *chip)
 {
 	int reg;
 	unsigned long flags;
 	
-	snd_cs4231_mce_up(chip);
+	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	for (reg = 0; reg < 32; reg++) {
 		switch (reg) {
@@ -240,7 +249,7 @@ static void snd_cs4236_resume(struct snd
 		case 29:	/* why? CS4235 - master right */
 			break;
 		default:
-			snd_cs4231_out(chip, reg, chip->image[reg]);
+			snd_wss_out(chip, reg, chip->image[reg]);
 			break;
 		}
 	}
@@ -255,7 +264,7 @@ static void snd_cs4236_resume(struct snd
 		}
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 }
 
 #endif /* CONFIG_PM */
@@ -266,24 +275,26 @@ int snd_cs4236_create(struct snd_card *c
 		      int irq, int dma1, int dma2,
 		      unsigned short hardware,
 		      unsigned short hwshare,
-		      struct snd_cs4231 ** rchip)
+		      struct snd_wss **rchip)
 {
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	unsigned char ver1, ver2;
 	unsigned int reg;
 	int err;
 
 	*rchip = NULL;
-	if (hardware == CS4231_HW_DETECT)
-		hardware = CS4231_HW_DETECT3;
+	if (hardware == WSS_HW_DETECT)
+		hardware = WSS_HW_DETECT3;
 	if (cport < 0x100) {
 		snd_printk("please, specify control port for CS4236+ chips\n");
 		return -ENODEV;
 	}
-	if ((err = snd_cs4231_create(card, port, cport, irq, dma1, dma2, hardware, hwshare, &chip)) < 0)
+	err = snd_wss_create(card, port, cport,
+			     irq, dma1, dma2, hardware, hwshare, &chip);
+	if (err < 0)
 		return err;
 
-	if (!(chip->hardware & CS4231_HW_CS4236B_MASK)) {
+	if (!(chip->hardware & WSS_HW_CS4236B_MASK)) {
 	        snd_printk("CS4236+: MODE3 and extended registers not available, hardware=0x%x\n",chip->hardware);
 		snd_device_free(card, chip);
 		return -ENODEV;
@@ -330,20 +341,20 @@ int snd_cs4236_create(struct snd_card *c
 		snd_cs4236_ext_out(chip, CS4236_I23VAL(reg), snd_cs4236_ext_map[reg]);
 
         /* initialize compatible but more featured registers */
-	snd_cs4231_out(chip, CS4231_LEFT_INPUT, 0x40);
-	snd_cs4231_out(chip, CS4231_RIGHT_INPUT, 0x40);
-	snd_cs4231_out(chip, CS4231_AUX1_LEFT_INPUT, 0xff);
-	snd_cs4231_out(chip, CS4231_AUX1_RIGHT_INPUT, 0xff);
-	snd_cs4231_out(chip, CS4231_AUX2_LEFT_INPUT, 0xdf);
-	snd_cs4231_out(chip, CS4231_AUX2_RIGHT_INPUT, 0xdf);
-	snd_cs4231_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
-	snd_cs4231_out(chip, CS4231_LEFT_LINE_IN, 0xff);
-	snd_cs4231_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
+	snd_wss_out(chip, CS4231_LEFT_INPUT, 0x40);
+	snd_wss_out(chip, CS4231_RIGHT_INPUT, 0x40);
+	snd_wss_out(chip, CS4231_AUX1_LEFT_INPUT, 0xff);
+	snd_wss_out(chip, CS4231_AUX1_RIGHT_INPUT, 0xff);
+	snd_wss_out(chip, CS4231_AUX2_LEFT_INPUT, 0xdf);
+	snd_wss_out(chip, CS4231_AUX2_RIGHT_INPUT, 0xdf);
+	snd_wss_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
+	snd_wss_out(chip, CS4231_LEFT_LINE_IN, 0xff);
+	snd_wss_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
 	switch (chip->hardware) {
-	case CS4231_HW_CS4235:
-	case CS4231_HW_CS4239:
-		snd_cs4231_out(chip, CS4235_LEFT_MASTER, 0xff);
-		snd_cs4231_out(chip, CS4235_RIGHT_MASTER, 0xff);
+	case WSS_HW_CS4235:
+	case WSS_HW_CS4239:
+		snd_wss_out(chip, CS4235_LEFT_MASTER, 0xff);
+		snd_wss_out(chip, CS4235_RIGHT_MASTER, 0xff);
 		break;
 	}
 
@@ -351,12 +362,13 @@ int snd_cs4236_create(struct snd_card *c
 	return 0;
 }
 
-int snd_cs4236_pcm(struct snd_cs4231 *chip, int device, struct snd_pcm **rpcm)
+int snd_cs4236_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
 	
-	if ((err = snd_cs4231_pcm(chip, device, &pcm)) < 0)
+	err = snd_wss_pcm(chip, device, &pcm);
+	if (err < 0)
 		return err;
 	pcm->info_flags &= ~SNDRV_PCM_INFO_JOINT_DUPLEX;
 	if (rpcm)
@@ -387,7 +399,7 @@ static int snd_cs4236_info_single(struct
 
 static int snd_cs4236_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
@@ -404,7 +416,7 @@ static int snd_cs4236_get_single(struct 
 
 static int snd_cs4236_put_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
@@ -433,7 +445,7 @@ static int snd_cs4236_put_single(struct 
 
 static int snd_cs4236_get_singlec(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
@@ -450,7 +462,7 @@ static int snd_cs4236_get_singlec(struct
 
 static int snd_cs4236_put_singlec(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
@@ -490,7 +502,7 @@ static int snd_cs4236_info_double(struct
 
 static int snd_cs4236_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int left_reg = kcontrol->private_value & 0xff;
 	int right_reg = (kcontrol->private_value >> 8) & 0xff;
@@ -512,7 +524,7 @@ static int snd_cs4236_get_double(struct 
 
 static int snd_cs4236_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int left_reg = kcontrol->private_value & 0xff;
 	int right_reg = (kcontrol->private_value >> 8) & 0xff;
@@ -555,7 +567,7 @@ static int snd_cs4236_put_double(struct 
 
 static int snd_cs4236_get_double1(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int left_reg = kcontrol->private_value & 0xff;
 	int right_reg = (kcontrol->private_value >> 8) & 0xff;
@@ -577,7 +589,7 @@ static int snd_cs4236_get_double1(struct
 
 static int snd_cs4236_put_double1(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int left_reg = kcontrol->private_value & 0xff;
 	int right_reg = (kcontrol->private_value >> 8) & 0xff;
@@ -600,7 +612,7 @@ static int snd_cs4236_put_double1(struct
 	val1 = (chip->image[left_reg] & ~(mask << shift_left)) | val1;
 	val2 = (chip->eimage[CS4236_REG(right_reg)] & ~(mask << shift_right)) | val2;
 	change = val1 != chip->image[left_reg] || val2 != chip->eimage[CS4236_REG(right_reg)];
-	snd_cs4231_out(chip, left_reg, val1);
+	snd_wss_out(chip, left_reg, val1);
 	snd_cs4236_ext_out(chip, right_reg, val2);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return change;
@@ -619,7 +631,7 @@ static inline int snd_cs4236_mixer_maste
 
 static int snd_cs4236_get_master_digital(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
@@ -631,7 +643,7 @@ static int snd_cs4236_get_master_digital
 
 static int snd_cs4236_put_master_digital(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int change;
 	unsigned short val1, val2;
@@ -678,7 +690,7 @@ static inline int snd_cs4235_mixer_outpu
 
 static int snd_cs4235_get_output_accu(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
@@ -690,7 +702,7 @@ static int snd_cs4235_get_output_accu(st
 
 static int snd_cs4235_put_output_accu(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int change;
 	unsigned short val1, val2;
@@ -701,108 +713,160 @@ static int snd_cs4235_put_output_accu(st
 	val1 = (chip->image[CS4235_LEFT_MASTER] & ~(3 << 5)) | val1;
 	val2 = (chip->image[CS4235_RIGHT_MASTER] & ~(3 << 5)) | val2;
 	change = val1 != chip->image[CS4235_LEFT_MASTER] || val2 != chip->image[CS4235_RIGHT_MASTER];
-	snd_cs4231_out(chip, CS4235_LEFT_MASTER, val1);
-	snd_cs4231_out(chip, CS4235_RIGHT_MASTER, val2);
+	snd_wss_out(chip, CS4235_LEFT_MASTER, val1);
+	snd_wss_out(chip, CS4235_RIGHT_MASTER, val2);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return change;
 }
 
 static struct snd_kcontrol_new snd_cs4236_controls[] = {
 
-CS4236_DOUBLE("Master Digital Playback Switch", 0, CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
-CS4236_DOUBLE("Master Digital Capture Switch", 0, CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
+CS4236_DOUBLE("Master Digital Playback Switch", 0,
+		CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
+CS4236_DOUBLE("Master Digital Capture Switch", 0,
+		CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
 CS4236_MASTER_DIGITAL("Master Digital Volume", 0),
 
-CS4236_DOUBLE("Capture Boost Volume", 0, CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1),
+CS4236_DOUBLE("Capture Boost Volume", 0,
+		CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1),
 
-CS4231_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Playback Volume", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
-
-CS4236_DOUBLE("DSP Playback Switch", 0, CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 7, 7, 1, 1),
-CS4236_DOUBLE("DSP Playback Volume", 0, CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 0, 0, 63, 1),
-
-CS4236_DOUBLE("FM Playback Switch", 0, CS4236_LEFT_FM, CS4236_RIGHT_FM, 7, 7, 1, 1),
-CS4236_DOUBLE("FM Playback Volume", 0, CS4236_LEFT_FM, CS4236_RIGHT_FM, 0, 0, 63, 1),
-
-CS4236_DOUBLE("Wavetable Playback Switch", 0, CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 7, 7, 1, 1),
-CS4236_DOUBLE("Wavetable Playback Volume", 0, CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 0, 0, 63, 1),
-
-CS4231_DOUBLE("Synth Playback Switch", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-CS4231_DOUBLE("Synth Volume", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
-CS4231_DOUBLE("Synth Capture Switch", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 6, 6, 1, 1),
-CS4231_DOUBLE("Synth Capture Bypass", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 5, 5, 1, 1),
-
-CS4236_DOUBLE("Mic Playback Switch", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 6, 6, 1, 1),
-CS4236_DOUBLE("Mic Capture Switch", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 7, 7, 1, 1),
+WSS_DOUBLE("PCM Playback Switch", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
+WSS_DOUBLE("PCM Playback Volume", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+
+CS4236_DOUBLE("DSP Playback Switch", 0,
+		CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 7, 7, 1, 1),
+CS4236_DOUBLE("DSP Playback Volume", 0,
+		CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 0, 0, 63, 1),
+
+CS4236_DOUBLE("FM Playback Switch", 0,
+		CS4236_LEFT_FM, CS4236_RIGHT_FM, 7, 7, 1, 1),
+CS4236_DOUBLE("FM Playback Volume", 0,
+		CS4236_LEFT_FM, CS4236_RIGHT_FM, 0, 0, 63, 1),
+
+CS4236_DOUBLE("Wavetable Playback Switch", 0,
+		CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 7, 7, 1, 1),
+CS4236_DOUBLE("Wavetable Playback Volume", 0,
+		CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 0, 0, 63, 1),
+
+WSS_DOUBLE("Synth Playback Switch", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
+WSS_DOUBLE("Synth Volume", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
+WSS_DOUBLE("Synth Capture Switch", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 6, 6, 1, 1),
+WSS_DOUBLE("Synth Capture Bypass", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 5, 5, 1, 1),
+
+CS4236_DOUBLE("Mic Playback Switch", 0,
+		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 6, 6, 1, 1),
+CS4236_DOUBLE("Mic Capture Switch", 0,
+		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 7, 7, 1, 1),
 CS4236_DOUBLE("Mic Volume", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 0, 0, 31, 1),
-CS4236_DOUBLE("Mic Playback Boost", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 5, 5, 1, 0),
-
-CS4231_DOUBLE("Line Playback Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Line Volume", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("Line Capture Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
-CS4231_DOUBLE("Line Capture Bypass", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 5, 5, 1, 1),
-
-CS4231_DOUBLE("CD Playback Switch", 0, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("CD Volume", 0, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("CD Capture Switch", 0, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
-
-CS4236_DOUBLE1("Mono Output Playback Switch", 0, CS4231_MONO_CTRL, CS4236_RIGHT_MIX_CTRL, 6, 7, 1, 1),
-CS4236_DOUBLE1("Mono Playback Switch", 0, CS4231_MONO_CTRL, CS4236_LEFT_MIX_CTRL, 7, 7, 1, 1),
-CS4231_SINGLE("Mono Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
-CS4231_SINGLE("Mono Playback Bypass", 0, CS4231_MONO_CTRL, 5, 1, 0),
+CS4236_DOUBLE("Mic Playback Boost", 0,
+		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 5, 5, 1, 0),
 
-CS4231_DOUBLE("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
-CS4231_DOUBLE("Analog Loopback Capture Switch", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 7, 7, 1, 0),
-
-CS4231_SINGLE("Digital Loopback Playback Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
-CS4236_DOUBLE1("Digital Loopback Playback Volume", 0, CS4231_LOOPBACK, CS4236_RIGHT_LOOPBACK, 2, 0, 63, 1)
+WSS_DOUBLE("Line Playback Switch", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Line Volume", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE("Line Capture Switch", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
+WSS_DOUBLE("Line Capture Bypass", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 5, 5, 1, 1),
+
+WSS_DOUBLE("CD Playback Switch", 0,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("CD Volume", 0,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE("CD Capture Switch", 0,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
+
+CS4236_DOUBLE1("Mono Output Playback Switch", 0,
+		CS4231_MONO_CTRL, CS4236_RIGHT_MIX_CTRL, 6, 7, 1, 1),
+CS4236_DOUBLE1("Mono Playback Switch", 0,
+		CS4231_MONO_CTRL, CS4236_LEFT_MIX_CTRL, 7, 7, 1, 1),
+WSS_SINGLE("Mono Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
+WSS_SINGLE("Mono Playback Bypass", 0, CS4231_MONO_CTRL, 5, 1, 0),
+
+WSS_DOUBLE("Capture Volume", 0,
+		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
+WSS_DOUBLE("Analog Loopback Capture Switch", 0,
+		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 7, 7, 1, 0),
+
+WSS_SINGLE("Digital Loopback Playback Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
+CS4236_DOUBLE1("Digital Loopback Playback Volume", 0,
+		CS4231_LOOPBACK, CS4236_RIGHT_LOOPBACK, 2, 0, 63, 1)
 };
 
 static struct snd_kcontrol_new snd_cs4235_controls[] = {
 
-CS4231_DOUBLE("Master Switch", 0, CS4235_LEFT_MASTER, CS4235_RIGHT_MASTER, 7, 7, 1, 1),
-CS4231_DOUBLE("Master Volume", 0, CS4235_LEFT_MASTER, CS4235_RIGHT_MASTER, 0, 0, 31, 1),
+WSS_DOUBLE("Master Switch", 0,
+		CS4235_LEFT_MASTER, CS4235_RIGHT_MASTER, 7, 7, 1, 1),
+WSS_DOUBLE("Master Volume", 0,
+		CS4235_LEFT_MASTER, CS4235_RIGHT_MASTER, 0, 0, 31, 1),
 
 CS4235_OUTPUT_ACCU("Playback Volume", 0),
 
-CS4236_DOUBLE("Master Digital Playback Switch", 0, CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
-CS4236_DOUBLE("Master Digital Capture Switch", 0, CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
+CS4236_DOUBLE("Master Digital Playback Switch", 0,
+		CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
+CS4236_DOUBLE("Master Digital Capture Switch", 0,
+		CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
 CS4236_MASTER_DIGITAL("Master Digital Volume", 0),
 
-CS4231_DOUBLE("Master Digital Playback Switch", 1, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-CS4231_DOUBLE("Master Digital Capture Switch", 1, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 6, 6, 1, 1),
-CS4231_DOUBLE("Master Digital Volume", 1, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
-
-CS4236_DOUBLE("Capture Volume", 0, CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1),
-
-CS4231_DOUBLE("PCM Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Volume", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+WSS_DOUBLE("Master Digital Playback Switch", 1,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
+WSS_DOUBLE("Master Digital Capture Switch", 1,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 6, 6, 1, 1),
+WSS_DOUBLE("Master Digital Volume", 1,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
+
+CS4236_DOUBLE("Capture Volume", 0,
+		CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1),
+
+WSS_DOUBLE("PCM Switch", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
+WSS_DOUBLE("PCM Volume", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
 
 CS4236_DOUBLE("DSP Switch", 0, CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 7, 7, 1, 1),
 
 CS4236_DOUBLE("FM Switch", 0, CS4236_LEFT_FM, CS4236_RIGHT_FM, 7, 7, 1, 1),
 
-CS4236_DOUBLE("Wavetable Switch", 0, CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 7, 7, 1, 1),
+CS4236_DOUBLE("Wavetable Switch", 0,
+		CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 7, 7, 1, 1),
 
-CS4236_DOUBLE("Mic Capture Switch", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 7, 7, 1, 1),
-CS4236_DOUBLE("Mic Playback Switch", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 6, 6, 1, 1),
+CS4236_DOUBLE("Mic Capture Switch", 0,
+		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 7, 7, 1, 1),
+CS4236_DOUBLE("Mic Playback Switch", 0,
+		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 6, 6, 1, 1),
 CS4236_SINGLE("Mic Volume", 0, CS4236_LEFT_MIC, 0, 31, 1),
 CS4236_SINGLE("Mic Playback Boost", 0, CS4236_LEFT_MIC, 5, 1, 0),
 
-CS4231_DOUBLE("Aux Playback Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Capture Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
-CS4231_DOUBLE("Aux Volume", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
-
-CS4231_DOUBLE("Aux Playback Switch", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Capture Switch", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
-CS4231_DOUBLE("Aux Volume", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
-
-CS4236_DOUBLE1("Master Mono Switch", 0, CS4231_MONO_CTRL, CS4236_RIGHT_MIX_CTRL, 6, 7, 1, 1),
-
-CS4236_DOUBLE1("Mono Switch", 0, CS4231_MONO_CTRL, CS4236_LEFT_MIX_CTRL, 7, 7, 1, 1),
-CS4231_SINGLE("Mono Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
+WSS_DOUBLE("Aux Playback Switch", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Aux Capture Switch", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
+WSS_DOUBLE("Aux Volume", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+
+WSS_DOUBLE("Aux Playback Switch", 1,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Aux Capture Switch", 1,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
+WSS_DOUBLE("Aux Volume", 1,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+
+CS4236_DOUBLE1("Master Mono Switch", 0,
+		CS4231_MONO_CTRL, CS4236_RIGHT_MIX_CTRL, 6, 7, 1, 1),
+
+CS4236_DOUBLE1("Mono Switch", 0,
+		CS4231_MONO_CTRL, CS4236_LEFT_MIX_CTRL, 7, 7, 1, 1),
+WSS_SINGLE("Mono Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
 
-CS4231_DOUBLE("Analog Loopback Switch", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 7, 7, 1, 0),
+WSS_DOUBLE("Analog Loopback Switch", 0,
+		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 7, 7, 1, 0),
 };
 
 #define CS4236_IEC958_ENABLE(xname, xindex) \
@@ -813,14 +877,14 @@ CS4231_DOUBLE("Analog Loopback Switch", 
 
 static int snd_cs4236_get_iec958_switch(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	ucontrol->value.integer.value[0] = chip->image[CS4231_ALT_FEATURE_1] & 0x02 ? 1 : 0;
 #if 0
 	printk("get valid: ALT = 0x%x, C3 = 0x%x, C4 = 0x%x, C5 = 0x%x, C6 = 0x%x, C8 = 0x%x\n",
-			snd_cs4231_in(chip, CS4231_ALT_FEATURE_1),
+			snd_wss_in(chip, CS4231_ALT_FEATURE_1),
 			snd_cs4236_ctrl_in(chip, 3),
 			snd_cs4236_ctrl_in(chip, 4),
 			snd_cs4236_ctrl_in(chip, 5),
@@ -833,7 +897,7 @@ static int snd_cs4236_get_iec958_switch(
 
 static int snd_cs4236_put_iec958_switch(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int change;
 	unsigned short enable, val;
@@ -841,23 +905,23 @@ static int snd_cs4236_put_iec958_switch(
 	enable = ucontrol->value.integer.value[0] & 1;
 
 	mutex_lock(&chip->mce_mutex);
-	snd_cs4231_mce_up(chip);
+	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	val = (chip->image[CS4231_ALT_FEATURE_1] & ~0x0e) | (0<<2) | (enable << 1);
 	change = val != chip->image[CS4231_ALT_FEATURE_1];
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, val);
+	snd_wss_out(chip, CS4231_ALT_FEATURE_1, val);
 	val = snd_cs4236_ctrl_in(chip, 4) | 0xc0;
 	snd_cs4236_ctrl_out(chip, 4, val);
 	udelay(100);
 	val &= ~0x40;
 	snd_cs4236_ctrl_out(chip, 4, val);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 	mutex_unlock(&chip->mce_mutex);
 
 #if 0
 	printk("set valid: ALT = 0x%x, C3 = 0x%x, C4 = 0x%x, C5 = 0x%x, C6 = 0x%x, C8 = 0x%x\n",
-			snd_cs4231_in(chip, CS4231_ALT_FEATURE_1),
+			snd_wss_in(chip, CS4231_ALT_FEATURE_1),
 			snd_cs4236_ctrl_in(chip, 3),
 			snd_cs4236_ctrl_in(chip, 4),
 			snd_cs4236_ctrl_in(chip, 5),
@@ -896,7 +960,7 @@ CS4236_SINGLEC("3D Control - Volume", 0,
 CS4236_SINGLEC("3D Control - IEC958", 0, 3, 5, 1, 0)
 };
 
-int snd_cs4236_mixer(struct snd_cs4231 *chip)
+int snd_cs4236_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card;
 	unsigned int idx, count;
@@ -905,10 +969,10 @@ int snd_cs4236_mixer(struct snd_cs4231 *
 
 	snd_assert(chip != NULL && chip->card != NULL, return -EINVAL);
 	card = chip->card;
-	strcpy(card->mixername, snd_cs4231_chip_id(chip));
+	strcpy(card->mixername, snd_wss_chip_id(chip));
 
-	if (chip->hardware == CS4231_HW_CS4235 ||
-	    chip->hardware == CS4231_HW_CS4239) {
+	if (chip->hardware == WSS_HW_CS4235 ||
+	    chip->hardware == WSS_HW_CS4239) {
 		for (idx = 0; idx < ARRAY_SIZE(snd_cs4235_controls); idx++) {
 			if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4235_controls[idx], chip))) < 0)
 				return err;
@@ -920,16 +984,16 @@ int snd_cs4236_mixer(struct snd_cs4231 *
 		}
 	}
 	switch (chip->hardware) {
-	case CS4231_HW_CS4235:
-	case CS4231_HW_CS4239:
+	case WSS_HW_CS4235:
+	case WSS_HW_CS4239:
 		count = ARRAY_SIZE(snd_cs4236_3d_controls_cs4235);
 		kcontrol = snd_cs4236_3d_controls_cs4235;
 		break;
-	case CS4231_HW_CS4237B:
+	case WSS_HW_CS4237B:
 		count = ARRAY_SIZE(snd_cs4236_3d_controls_cs4237);
 		kcontrol = snd_cs4236_3d_controls_cs4237;
 		break;
-	case CS4231_HW_CS4238B:
+	case WSS_HW_CS4238B:
 		count = ARRAY_SIZE(snd_cs4236_3d_controls_cs4238);
 		kcontrol = snd_cs4236_3d_controls_cs4238;
 		break;
@@ -941,8 +1005,8 @@ int snd_cs4236_mixer(struct snd_cs4231 *
 		if ((err = snd_ctl_add(card, snd_ctl_new1(kcontrol, chip))) < 0)
 			return err;
 	}
-	if (chip->hardware == CS4231_HW_CS4237B ||
-	    chip->hardware == CS4231_HW_CS4238B) {
+	if (chip->hardware == WSS_HW_CS4237B ||
+	    chip->hardware == WSS_HW_CS4238B) {
 		for (idx = 0; idx < ARRAY_SIZE(snd_cs4236_iec958_controls); idx++) {
 			if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4236_iec958_controls[idx], chip))) < 0)
 				return err;
diff -urp linux-alsa/sound/isa/gus/gusmax.c linux-mm/sound/isa/gus/gusmax.c
--- linux-alsa/sound/isa/gus/gusmax.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/gus/gusmax.c	2008-06-25 18:41:45.819179911 +0200
@@ -75,7 +75,7 @@ struct snd_gusmax {
 	int irq;
 	struct snd_card *card;
 	struct snd_gus_card *gus;
-	struct snd_cs4231 *cs4231;
+	struct snd_wss *wss;
 	unsigned short gus_status_reg;
 	unsigned short pcm_status_reg;
 };
@@ -117,7 +117,7 @@ static irqreturn_t snd_gusmax_interrupt(
 		}
 		if (inb(maxcard->pcm_status_reg) & 0x01) { /* IRQ bit is set? */
 			handled = 1;
-			snd_cs4231_interrupt(irq, maxcard->cs4231);
+			snd_wss_interrupt(irq, maxcard->wss);
 			loop++;
 		}
 	} while (loop && --max > 0);
@@ -140,10 +140,7 @@ static void __devinit snd_gusmax_init(in
 	outb(gus->max_cntrl_val, GUSP(gus, MAXCNTRLPORT));
 }
 
-#define CS4231_PRIVATE( left, right, shift, mute ) \
-			((left << 24)|(right << 16)|(shift<<8)|mute)
-
-static int __devinit snd_gusmax_mixer(struct snd_cs4231 *chip)
+static int __devinit snd_gusmax_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
@@ -214,7 +211,7 @@ static int __devinit snd_gusmax_probe(st
 	int xirq, xdma1, xdma2, err;
 	struct snd_card *card;
 	struct snd_gus_card *gus = NULL;
-	struct snd_cs4231 *cs4231;
+	struct snd_wss *wss;
 	struct snd_gusmax *maxcard;
 
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
@@ -301,33 +298,39 @@ static int __devinit snd_gusmax_probe(st
 	}
 	maxcard->irq = xirq;
 	
-	if ((err = snd_cs4231_create(card,
-				     gus->gf1.port + 0x10c, -1, xirq,
-				     xdma2 < 0 ? xdma1 : xdma2, xdma1,
-				     CS4231_HW_DETECT,
-				     CS4231_HWSHARE_IRQ |
-				     CS4231_HWSHARE_DMA1 |
-				     CS4231_HWSHARE_DMA2,
-				     &cs4231)) < 0)
+	err = snd_wss_create(card,
+			     gus->gf1.port + 0x10c, -1, xirq,
+			     xdma2 < 0 ? xdma1 : xdma2, xdma1,
+			     WSS_HW_DETECT,
+			     WSS_HWSHARE_IRQ |
+			     WSS_HWSHARE_DMA1 |
+			     WSS_HWSHARE_DMA2,
+			     &wss);
+	if (err < 0)
 		goto _err;
 
-	if ((err = snd_cs4231_pcm(cs4231, 0, NULL)) < 0)
+	err = snd_wss_pcm(wss, 0, NULL);
+	if (err < 0)
 		goto _err;
 
-	if ((err = snd_cs4231_mixer(cs4231)) < 0)
+	err = snd_wss_mixer(wss);
+	if (err < 0)
 		goto _err;
 
-	if ((err = snd_cs4231_timer(cs4231, 2, NULL)) < 0)
+	err = snd_wss_timer(wss, 2, NULL);
+	if (err < 0)
 		goto _err;
 
 	if (pcm_channels[dev] > 0) {
 		if ((err = snd_gf1_pcm_new(gus, 1, 1, NULL)) < 0)
 			goto _err;
 	}
-	if ((err = snd_gusmax_mixer(cs4231)) < 0)
+	err = snd_gusmax_mixer(wss);
+	if (err < 0)
 		goto _err;
 
-	if ((err = snd_gf1_rawmidi_new(gus, 0, NULL)) < 0)
+	err = snd_gf1_rawmidi_new(gus, 0, NULL);
+	if (err < 0)
 		goto _err;
 
 	sprintf(card->longname + strlen(card->longname), " at 0x%lx, irq %i, dma %i", gus->gf1.port, xirq, xdma1);
@@ -336,11 +339,12 @@ static int __devinit snd_gusmax_probe(st
 
 	snd_card_set_dev(card, pdev);
 
-	if ((err = snd_card_register(card)) < 0)
+	err = snd_card_register(card);
+	if (err < 0)
 		goto _err;
 		
 	maxcard->gus = gus;
-	maxcard->cs4231 = cs4231;
+	maxcard->wss = wss;
 
 	dev_set_drvdata(pdev, card);
 	return 0;
diff -urp linux-alsa/sound/isa/gus/interwave.c linux-mm/sound/isa/gus/interwave.c
--- linux-alsa/sound/isa/gus/interwave.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/gus/interwave.c	2008-06-25 23:23:41.623536555 +0200
@@ -118,7 +118,7 @@ struct snd_interwave {
 	int irq;
 	struct snd_card *card;
 	struct snd_gus_card *gus;
-	struct snd_cs4231 *cs4231;
+	struct snd_wss *wss;
 #ifdef SNDRV_STB
 	struct resource *i2c_res;
 #endif
@@ -312,7 +312,7 @@ static irqreturn_t snd_interwave_interru
 		}
 		if (inb(iwcard->pcm_status_reg) & 0x01) {	/* IRQ bit is set? */
 			handled = 1;
-			snd_cs4231_interrupt(irq, iwcard->cs4231);
+			snd_wss_interrupt(irq, iwcard->wss);
 			loop++;
 		}
 	} while (loop && --max > 0);
@@ -498,13 +498,17 @@ static void __devinit snd_interwave_init
 }
 
 static struct snd_kcontrol_new snd_interwave_controls[] = {
-CS4231_DOUBLE("Master Playback Switch", 0, CS4231_LINE_LEFT_OUTPUT, CS4231_LINE_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Master Playback Volume", 0, CS4231_LINE_LEFT_OUTPUT, CS4231_LINE_RIGHT_OUTPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("Mic Playback Switch", 0, CS4231_LEFT_MIC_INPUT, CS4231_RIGHT_MIC_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Mic Playback Volume", 0, CS4231_LEFT_MIC_INPUT, CS4231_RIGHT_MIC_INPUT, 0, 0, 31, 1)
+WSS_DOUBLE("Master Playback Switch", 0,
+		CS4231_LINE_LEFT_OUTPUT, CS4231_LINE_RIGHT_OUTPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Master Playback Volume", 0,
+		CS4231_LINE_LEFT_OUTPUT, CS4231_LINE_RIGHT_OUTPUT, 0, 0, 31, 1),
+WSS_DOUBLE("Mic Playback Switch", 0,
+		CS4231_LEFT_MIC_INPUT, CS4231_RIGHT_MIC_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Mic Playback Volume", 0,
+		CS4231_LEFT_MIC_INPUT, CS4231_RIGHT_MIC_INPUT, 0, 0, 31, 1)
 };
 
-static int __devinit snd_interwave_mixer(struct snd_cs4231 *chip)
+static int __devinit snd_interwave_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
@@ -527,10 +531,10 @@ static int __devinit snd_interwave_mixer
 	for (idx = 0; idx < ARRAY_SIZE(snd_interwave_controls); idx++)
 		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_interwave_controls[idx], chip))) < 0)
 			return err;
-	snd_cs4231_out(chip, CS4231_LINE_LEFT_OUTPUT, 0x9f);
-	snd_cs4231_out(chip, CS4231_LINE_RIGHT_OUTPUT, 0x9f);
-	snd_cs4231_out(chip, CS4231_LEFT_MIC_INPUT, 0x9f);
-	snd_cs4231_out(chip, CS4231_RIGHT_MIC_INPUT, 0x9f);
+	snd_wss_out(chip, CS4231_LINE_LEFT_OUTPUT, 0x9f);
+	snd_wss_out(chip, CS4231_LINE_RIGHT_OUTPUT, 0x9f);
+	snd_wss_out(chip, CS4231_LEFT_MIC_INPUT, 0x9f);
+	snd_wss_out(chip, CS4231_RIGHT_MIC_INPUT, 0x9f);
 	/* reassign AUXA to SYNTHESIZER */
 	strcpy(id1.name, "Aux Playback Switch");
 	strcpy(id2.name, "Synth Playback Switch");
@@ -642,7 +646,7 @@ static int __devinit snd_interwave_probe
 {
 	int xirq, xdma1, xdma2;
 	struct snd_interwave *iwcard = card->private_data;
-	struct snd_cs4231 *cs4231;
+	struct snd_wss *wss;
 	struct snd_gus_card *gus;
 #ifdef SNDRV_STB
 	struct snd_i2c_bus *i2c_bus;
@@ -684,33 +688,39 @@ static int __devinit snd_interwave_probe
 	}
 	iwcard->irq = xirq;
 
-	if ((err = snd_cs4231_create(card,
-				     gus->gf1.port + 0x10c, -1, xirq,
-				     xdma2 < 0 ? xdma1 : xdma2, xdma1,
-				     CS4231_HW_INTERWAVE,
-				     CS4231_HWSHARE_IRQ |
-				     CS4231_HWSHARE_DMA1 |
-				     CS4231_HWSHARE_DMA2,
-				     &cs4231)) < 0)
+	err = snd_wss_create(card,
+			     gus->gf1.port + 0x10c, -1, xirq,
+			     xdma2 < 0 ? xdma1 : xdma2, xdma1,
+			     WSS_HW_INTERWAVE,
+			     WSS_HWSHARE_IRQ |
+			     WSS_HWSHARE_DMA1 |
+			     WSS_HWSHARE_DMA2,
+			     &wss);
+	if (err < 0)
 		return err;
 
-	if ((err = snd_cs4231_pcm(cs4231, 0, &pcm)) < 0)
+	err = snd_wss_pcm(wss, 0, &pcm);
+	if (err < 0)
 		return err;
 
 	sprintf(pcm->name + strlen(pcm->name), " rev %c", gus->revision + 'A');
 	strcat(pcm->name, " (codec)");
 
-	if ((err = snd_cs4231_timer(cs4231, 2, NULL)) < 0)
+	err = snd_wss_timer(wss, 2, NULL);
+	if (err < 0)
 		return err;
 
-	if ((err = snd_cs4231_mixer(cs4231)) < 0)
+	err = snd_wss_mixer(wss);
+	if (err < 0)
 		return err;
 
 	if (pcm_channels[dev] > 0) {
-		if ((err = snd_gf1_pcm_new(gus, 1, 1, NULL)) < 0)
+		err = snd_gf1_pcm_new(gus, 1, 1, NULL);
+		if (err < 0)
 			return err;
 	}
-	if ((err = snd_interwave_mixer(cs4231)) < 0)
+	err = snd_interwave_mixer(wss);
+	if (err < 0)
 		return err;
 
 #ifdef SNDRV_STB
@@ -754,10 +764,11 @@ static int __devinit snd_interwave_probe
 	if (xdma2 >= 0)
 		sprintf(card->longname + strlen(card->longname), "&%d", xdma2);
 
-	if ((err = snd_card_register(card)) < 0)
+	err = snd_card_register(card);
+	if (err < 0)
 		return err;
 	
-	iwcard->cs4231 = cs4231;
+	iwcard->wss = wss;
 	iwcard->gus = gus;
 	return 0;
 }
diff -urp linux-alsa/sound/isa/opl3sa2.c linux-mm/sound/isa/opl3sa2.c
--- linux-alsa/sound/isa/opl3sa2.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/opl3sa2.c	2008-06-25 23:20:43.230193930 +0200
@@ -133,7 +133,7 @@ struct snd_opl3sa2 {
 	spinlock_t reg_lock;
 	struct snd_hwdep *synth;
 	struct snd_rawmidi *rmidi;
-	struct snd_cs4231 *cs4231;
+	struct snd_wss *wss;
 	unsigned char ctlregs[0x20];
 	int ymode;		/* SL added */
 	struct snd_kcontrol *master_switch;
@@ -318,7 +318,7 @@ static irqreturn_t snd_opl3sa2_interrupt
 
 	if (status & 0x07) {	/* TI,CI,PI */
 		handled = 1;
-		snd_cs4231_interrupt(irq, chip->cs4231);
+		snd_wss_interrupt(irq, chip->wss);
 	}
 
 	if (status & 0x40) { /* hardware volume change */
@@ -573,7 +573,7 @@ static int snd_opl3sa2_suspend(struct sn
 	struct snd_opl3sa2 *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	chip->cs4231->suspend(chip->cs4231);
+	chip->wss->suspend(chip->wss);
 	/* power down */
 	snd_opl3sa2_write(chip, OPL3SA2_PM_CTRL, OPL3SA2_PM_D3);
 
@@ -597,8 +597,8 @@ static int snd_opl3sa2_resume(struct snd
 		for (i = 0x12; i <= 0x16; i++)
 			snd_opl3sa2_write(chip, i, chip->ctlregs[i]);
 	}
-	/* restore cs4231 */
-	chip->cs4231->resume(chip->cs4231);
+	/* restore wss */
+	chip->wss->resume(chip->wss);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
@@ -659,7 +659,7 @@ static int __devinit snd_opl3sa2_probe(s
 {
 	int xirq, xdma1, xdma2;
 	struct snd_opl3sa2 *chip;
-	struct snd_cs4231 *cs4231;
+	struct snd_wss *wss;
 	struct snd_opl3 *opl3;
 	int err;
 
@@ -679,23 +679,25 @@ static int __devinit snd_opl3sa2_probe(s
 		return -ENODEV;
 	}
 	chip->irq = xirq;
-	if ((err = snd_cs4231_create(card,
-				     wss_port[dev] + 4, -1,
-				     xirq, xdma1, xdma2,
-				     CS4231_HW_OPL3SA2,
-				     CS4231_HWSHARE_IRQ,
-				     &cs4231)) < 0) {
+	err = snd_wss_create(card,
+			     wss_port[dev] + 4, -1,
+			     xirq, xdma1, xdma2,
+			     WSS_HW_OPL3SA2, WSS_HWSHARE_IRQ, &wss);
+	if (err < 0) {
 		snd_printd("Oops, WSS not detected at 0x%lx\n", wss_port[dev] + 4);
 		return err;
 	}
-	chip->cs4231 = cs4231;
-	if ((err = snd_cs4231_pcm(cs4231, 0, NULL)) < 0)
+	chip->wss = wss;
+	err = snd_wss_pcm(wss, 0, NULL);
+	if (err < 0)
 		return err;
-	if ((err = snd_cs4231_mixer(cs4231)) < 0)
+	err = snd_wss_mixer(wss);
+	if (err < 0)
 		return err;
 	if ((err = snd_opl3sa2_mixer(chip)) < 0)
 		return err;
-	if ((err = snd_cs4231_timer(cs4231, 0, NULL)) < 0)
+	err = snd_wss_timer(wss, 0, NULL);
+	if (err < 0)
 		return err;
 	if (fm_port[dev] >= 0x340 && fm_port[dev] < 0x400) {
 		if ((err = snd_opl3_create(card, fm_port[dev],
diff -urp linux-alsa/sound/isa/opti9xx/miro.c linux-mm/sound/isa/opti9xx/miro.c
--- linux-alsa/sound/isa/opti9xx/miro.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/opti9xx/miro.c	2008-06-25 23:17:51.009039938 +0200
@@ -1221,7 +1221,7 @@ static int __devinit snd_miro_probe(stru
 
 	int error;
 	struct snd_miro *miro;
-	struct snd_cs4231 *codec;
+	struct snd_wss *codec;
 	struct snd_timer *timer;
 	struct snd_card *card;
 	struct snd_pcm *pcm;
@@ -1310,29 +1310,32 @@ static int __devinit snd_miro_probe(stru
 		}
 	}
 
-	if ((error = snd_miro_configure(miro))) {
+	error = snd_miro_configure(miro);
+	if (error) {
 		snd_card_free(card);
 		return error;
 	}
 
-	if ((error = snd_cs4231_create(card, miro->wss_base + 4, -1,
-				       miro->irq, miro->dma1, miro->dma2,
-				       CS4231_HW_AD1845,
-				       0,
-				       &codec)) < 0) {
+	error = snd_wss_create(card, miro->wss_base + 4, -1,
+				miro->irq, miro->dma1, miro->dma2,
+				WSS_HW_AD1845, 0, &codec);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
 
-	if ((error = snd_cs4231_pcm(codec, 0, &pcm)) < 0) {
+	error = snd_wss_pcm(codec, 0, &pcm);
+	if (error < 0)  {
 		snd_card_free(card);
 		return error;
 	}
-	if ((error = snd_cs4231_mixer(codec)) < 0) {
+	error = snd_wss_mixer(codec);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
-	if ((error = snd_cs4231_timer(codec, 0, &timer)) < 0) {
+	error = snd_wss_timer(codec, 0, &timer);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
diff -urp linux-alsa/sound/isa/opti9xx/opti92x-ad1848.c linux-mm/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-alsa/sound/isa/opti9xx/opti92x-ad1848.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/opti9xx/opti92x-ad1848.c	2008-06-25 23:13:58.190075936 +0200
@@ -135,7 +135,7 @@ struct snd_opti9xx {
 	unsigned long mc_base_size;
 #ifdef OPTi93X
 	unsigned long mc_indir_index;
-	struct snd_cs4231 *codec;
+	struct snd_wss *codec;
 #endif	/* OPTi93X */
 	unsigned long pwd_reg;
 
@@ -558,7 +558,7 @@ __skip_mpu:
 
 static irqreturn_t snd_opti93x_interrupt(int irq, void *dev_id)
 {
-	struct snd_cs4231 *codec = dev_id;
+	struct snd_wss *codec = dev_id;
 	struct snd_opti9xx *chip = codec->card->private_data;
 	unsigned char status;
 
@@ -566,7 +566,7 @@ static irqreturn_t snd_opti93x_interrupt
 	if ((status & OPTi93X_IRQ_PLAYBACK) && codec->playback_substream)
 		snd_pcm_period_elapsed(codec->playback_substream);
 	if ((status & OPTi93X_IRQ_CAPTURE) && codec->capture_substream) {
-		snd_cs4231_overrange(codec);
+		snd_wss_overrange(codec);
 		snd_pcm_period_elapsed(codec->capture_substream);
 	}
 	outb(0x00, OPTi93X_PORT(codec, STATUS));
@@ -687,7 +687,7 @@ static void snd_card_opti9xx_free(struct
         
 	if (chip) {
 #ifdef OPTi93X
-		struct snd_cs4231 *codec = chip->codec;
+		struct snd_wss *codec = chip->codec;
 		if (codec->irq > 0) {
 			disable_irq(codec->irq);
 			free_irq(codec->irq, codec);
@@ -703,7 +703,7 @@ static int __devinit snd_opti9xx_probe(s
 	int error;
 	struct snd_opti9xx *chip = card->private_data;
 #if defined(CS4231) || defined(OPTi93X)
-	struct snd_cs4231 *codec;
+	struct snd_wss *codec;
 #ifdef CS4231
 	struct snd_timer *timer;
 #endif
@@ -730,33 +730,39 @@ static int __devinit snd_opti9xx_probe(s
 #endif
 
 	if (chip->wss_base == SNDRV_AUTO_PORT) {
-		if ((chip->wss_base = snd_legacy_find_free_ioport(possible_ports, 4)) < 0) {
+		chip->wss_base = snd_legacy_find_free_ioport(possible_ports, 4);
+		if (chip->wss_base < 0) {
 			snd_printk("unable to find a free WSS port\n");
 			return -EBUSY;
 		}
 	}
-	if ((error = snd_opti9xx_configure(chip)))
+	error = snd_opti9xx_configure(chip);
+	if (error)
 		return error;
 
 #if defined(CS4231) || defined(OPTi93X)
-	if ((error = snd_cs4231_create(card, chip->wss_base + 4, -1,
-				       chip->irq, chip->dma1, chip->dma2,
+	error = snd_wss_create(card, chip->wss_base + 4, -1,
+			       chip->irq, chip->dma1, chip->dma2,
 #ifdef CS4231
-				       CS4231_HW_DETECT, 0,
+			       WSS_HW_DETECT, 0,
 #else /* OPTi93x */
-				       CS4231_HW_OPTI93X, CS4231_HWSHARE_IRQ,
+			       WSS_HW_OPTI93X, WSS_HWSHARE_IRQ,
 #endif
-				       &codec)) < 0)
+			       &codec);
+	if (error < 0)
 		return error;
 #ifdef OPTi93X
 	chip->codec = codec;
 #endif
-	if ((error = snd_cs4231_pcm(codec, 0, &pcm)) < 0)
+	error = snd_wss_pcm(codec, 0, &pcm);
+	if (error < 0)
 		return error;
-	if ((error = snd_cs4231_mixer(codec)) < 0)
+	error = snd_wss_mixer(codec);
+	if (error < 0)
 		return error;
 #ifdef CS4231
-	if ((error = snd_cs4231_timer(codec, 0, &timer)) < 0)
+	error = snd_wss_timer(codec, 0, &timer);
+	if (error < 0)
 		return error;
 #else /* OPTI93X */
 	error = request_irq(chip->irq, snd_opti93x_interrupt,
diff -urp linux-alsa/sound/isa/sscape.c linux-mm/sound/isa/sscape.c
--- linux-alsa/sound/isa/sscape.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/sscape.c	2008-06-25 19:28:01.434867234 +0200
@@ -147,7 +147,7 @@ struct soundscape {
 	enum card_type type;
 	struct resource *io_res;
 	struct resource *wss_res;
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	struct snd_mpu401 *mpu;
 	struct snd_hwdep *hw;
 
@@ -726,7 +726,7 @@ static int sscape_midi_info(struct snd_k
 static int sscape_midi_get(struct snd_kcontrol *kctl,
                            struct snd_ctl_elem_value *uctl)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kctl);
+	struct snd_wss *chip = snd_kcontrol_chip(kctl);
 	struct snd_card *card = chip->card;
 	register struct soundscape *s = get_card_soundscape(card);
 	unsigned long flags;
@@ -746,7 +746,7 @@ static int sscape_midi_get(struct snd_kc
 static int sscape_midi_put(struct snd_kcontrol *kctl,
                            struct snd_ctl_elem_value *uctl)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kctl);
+	struct snd_wss *chip = snd_kcontrol_chip(kctl);
 	struct snd_card *card = chip->card;
 	register struct soundscape *s = get_card_soundscape(card);
 	unsigned long flags;
@@ -958,7 +958,9 @@ static int __devinit create_mpu401(struc
  * Override for the CS4231 playback format function.
  * The AD1845 has much simpler format and rate selection.
  */
-static void ad1845_playback_format(struct snd_cs4231 * chip, struct snd_pcm_hw_params *params, unsigned char format)
+static void ad1845_playback_format(struct snd_wss *chip,
+				   struct snd_pcm_hw_params *params,
+				   unsigned char format)
 {
 	unsigned long flags;
 	unsigned rate = params_rate(params);
@@ -983,9 +985,9 @@ static void ad1845_playback_format(struc
 	 * NOTE: We seem to need to write to the MSB before the LSB
 	 *       to get the correct sample frequency.
 	 */
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, (format & 0xf0));
-	snd_cs4231_out(chip, AD1845_FREQ_SEL_MSB, (unsigned char) (rate >> 8));
-	snd_cs4231_out(chip, AD1845_FREQ_SEL_LSB, (unsigned char) rate);
+	snd_wss_out(chip, CS4231_PLAYBK_FORMAT, (format & 0xf0));
+	snd_wss_out(chip, AD1845_FREQ_SEL_MSB, (unsigned char) (rate >> 8));
+	snd_wss_out(chip, AD1845_FREQ_SEL_LSB, (unsigned char) rate);
 
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
@@ -994,7 +996,9 @@ static void ad1845_playback_format(struc
  * Override for the CS4231 capture format function. 
  * The AD1845 has much simpler format and rate selection.
  */
-static void ad1845_capture_format(struct snd_cs4231 * chip, struct snd_pcm_hw_params *params, unsigned char format)
+static void ad1845_capture_format(struct snd_wss *chip,
+				  struct snd_pcm_hw_params *params,
+				  unsigned char format)
 {
 	unsigned long flags;
 	unsigned rate = params_rate(params);
@@ -1019,9 +1023,9 @@ static void ad1845_capture_format(struct
 	 * NOTE: We seem to need to write to the MSB before the LSB
 	 *       to get the correct sample frequency.
 	 */
-	snd_cs4231_out(chip, CS4231_REC_FORMAT, (format & 0xf0));
-	snd_cs4231_out(chip, AD1845_FREQ_SEL_MSB, (unsigned char) (rate >> 8));
-	snd_cs4231_out(chip, AD1845_FREQ_SEL_LSB, (unsigned char) rate);
+	snd_wss_out(chip, CS4231_REC_FORMAT, (format & 0xf0));
+	snd_wss_out(chip, AD1845_FREQ_SEL_MSB, (unsigned char) (rate >> 8));
+	snd_wss_out(chip, AD1845_FREQ_SEL_LSB, (unsigned char) rate);
 
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
@@ -1036,7 +1040,7 @@ static int __devinit create_ad1845(struc
 				   int irq, int dma1, int dma2)
 {
 	register struct soundscape *sscape = get_card_soundscape(card);
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	int err;
 
 	if (sscape->type == SSCAPE_VIVO)
@@ -1045,9 +1049,9 @@ static int __devinit create_ad1845(struc
 	if (dma1 == dma2)
 		dma2 = -1;
 
-	err = snd_cs4231_create(card,
+	err = snd_wss_create(card,
 				port, -1, irq, dma1, dma2,
-				CS4231_HW_DETECT, CS4231_HWSHARE_DMA1, &chip);
+				WSS_HW_DETECT, WSS_HWSHARE_DMA1, &chip);
 	if (!err) {
 		unsigned long flags;
 		struct snd_pcm *pcm;
@@ -1063,11 +1067,11 @@ static int __devinit create_ad1845(struc
  *
 #define AD1845_IFACE_CONFIG  \
            (CS4231_AUTOCALIB | CS4231_RECORD_ENABLE | CS4231_PLAYBACK_ENABLE)
-    snd_cs4231_mce_up(chip);
+    snd_wss_mce_up(chip);
     spin_lock_irqsave(&chip->reg_lock, flags);
-    snd_cs4231_out(chip, CS4231_IFACE_CTRL, AD1845_IFACE_CONFIG);
+    snd_wss_out(chip, CS4231_IFACE_CTRL, AD1845_IFACE_CONFIG);
     spin_unlock_irqrestore(&chip->reg_lock, flags);
-    snd_cs4231_mce_down(chip);
+    snd_wss_mce_down(chip);
  */
 
 		if (sscape->type != SSCAPE_VIVO) {
@@ -1077,11 +1081,11 @@ static int __devinit create_ad1845(struc
 			 * be 14.31818 MHz, because we must set this register
 			 * to get the playback to sound correct ...
 			 */
-			snd_cs4231_mce_up(chip);
+			snd_wss_mce_up(chip);
 			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_cs4231_out(chip, AD1845_CRYS_CLOCK_SEL, 0x20);
+			snd_wss_out(chip, AD1845_CRYS_CLOCK_SEL, 0x20);
 			spin_unlock_irqrestore(&chip->reg_lock, flags);
-			snd_cs4231_mce_down(chip);
+			snd_wss_mce_down(chip);
 
 			/*
 			 * More custom configuration:
@@ -1089,28 +1093,28 @@ static int __devinit create_ad1845(struc
 			 * b) enable frequency selection (for capture/playback)
 			 */
 			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_cs4231_out(chip, CS4231_MISC_INFO,
+			snd_wss_out(chip, CS4231_MISC_INFO,
 					CS4231_MODE2 | 0x10);
-			val = snd_cs4231_in(chip, AD1845_PWR_DOWN_CTRL);
-			snd_cs4231_out(chip, AD1845_PWR_DOWN_CTRL,
+			val = snd_wss_in(chip, AD1845_PWR_DOWN_CTRL);
+			snd_wss_out(chip, AD1845_PWR_DOWN_CTRL,
 					val | AD1845_FREQ_SEL_ENABLE);
 			spin_unlock_irqrestore(&chip->reg_lock, flags);
 		}
 
-		err = snd_cs4231_pcm(chip, 0, &pcm);
+		err = snd_wss_pcm(chip, 0, &pcm);
 		if (err < 0) {
 			snd_printk(KERN_ERR "sscape: No PCM device "
 					    "for AD1845 chip\n");
 			goto _error;
 		}
 
-		err = snd_cs4231_mixer(chip);
+		err = snd_wss_mixer(chip);
 		if (err < 0) {
 			snd_printk(KERN_ERR "sscape: No mixer device "
 					    "for AD1845 chip\n");
 			goto _error;
 		}
-		err = snd_cs4231_timer(chip, 0, NULL);
+		err = snd_wss_timer(chip, 0, NULL);
 		if (err < 0) {
 			snd_printk(KERN_ERR "sscape: No timer device "
 					    "for AD1845 chip\n");
diff -urp linux-alsa/sound/isa/wavefront/wavefront.c linux-mm/sound/isa/wavefront/wavefront.c
--- linux-alsa/sound/isa/wavefront/wavefront.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/wavefront/wavefront.c	2008-06-25 23:46:59.269375541 +0200
@@ -1,6 +1,6 @@
 /*
  *  ALSA card-level driver for Turtle Beach Wavefront cards 
- *                                              (Maui,Tropez,Tropez+)
+ *						(Maui,Tropez,Tropez+)
  *
  *  Copyright (c) 1997-1999 by Paul Barton-Davis <pbd@op.net>
  *
@@ -320,8 +320,8 @@ snd_wavefront_new_midi (struct snd_card 
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_wavefront_midi_input);
 
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT |
-	                     SNDRV_RAWMIDI_INFO_INPUT |
-	                     SNDRV_RAWMIDI_INFO_DUPLEX;
+			     SNDRV_RAWMIDI_INFO_INPUT |
+			     SNDRV_RAWMIDI_INFO_DUPLEX;
 
 	return rmidi;
 }
@@ -364,7 +364,7 @@ static int __devinit
 snd_wavefront_probe (struct snd_card *card, int dev)
 {
 	snd_wavefront_card_t *acard = card->private_data;
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	struct snd_hwdep *wavefront_synth;
 	struct snd_rawmidi *ics2115_internal_rmidi = NULL;
 	struct snd_rawmidi *ics2115_external_rmidi = NULL;
@@ -373,21 +373,20 @@ snd_wavefront_probe (struct snd_card *ca
 
 	/* --------- PCM --------------- */
 
-	if ((err = snd_cs4231_create (card,
-				      cs4232_pcm_port[dev],
-				      -1,
-				      cs4232_pcm_irq[dev],
-				      dma1[dev],
-				      dma2[dev],
-				      CS4231_HW_DETECT, 0, &chip)) < 0) {
-		snd_printk (KERN_ERR "can't allocate CS4231 device\n");
+	err = snd_wss_create(card, cs4232_pcm_port[dev], -1,
+			     cs4232_pcm_irq[dev], dma1[dev], dma2[dev],
+			     WSS_HW_DETECT, 0, &chip);
+	if (err < 0) {
+		snd_printk(KERN_ERR "can't allocate WSS device\n");
 		return err;
 	}
 
-	if ((err = snd_cs4231_pcm (chip, 0, NULL)) < 0)
+	err = snd_wss_pcm(chip, 0, NULL);
+	if (err < 0)
 		return err;
 
-	if ((err = snd_cs4231_timer (chip, 0, NULL)) < 0)
+	err = snd_wss_timer(chip, 0, NULL);
+	if (err < 0)
 		return err;
 
 	/* ---------- OPL3 synth --------- */
@@ -395,24 +394,24 @@ snd_wavefront_probe (struct snd_card *ca
 	if (fm_port[dev] > 0 && fm_port[dev] != SNDRV_AUTO_PORT) {
 		struct snd_opl3 *opl3;
 
-	        if ((err = snd_opl3_create(card,
-					   fm_port[dev],
-					   fm_port[dev] + 2,
-					   OPL3_HW_OPL3_CS,
-					   0, &opl3)) < 0) {
+		err = snd_opl3_create(card, fm_port[dev], fm_port[dev] + 2,
+				      OPL3_HW_OPL3_CS, 0, &opl3);
+		if (err < 0) {
 			snd_printk (KERN_ERR "can't allocate or detect OPL3 synth\n");
 			return err;
 		}
 
-		if ((err = snd_opl3_hwdep_new(opl3, hw_dev, 1, NULL)) < 0)
+		err = snd_opl3_hwdep_new(opl3, hw_dev, 1, NULL);
+		if (err < 0)
 			return err;
 		hw_dev++;
 	}
 
 	/* ------- ICS2115 Wavetable synth ------- */
 
-	if ((acard->wavefront.res_base = request_region(ics2115_port[dev], 16,
-							"ICS2115")) == NULL) {
+	acard->wavefront.res_base = request_region(ics2115_port[dev], 16,
+						   "ICS2115");
+	if (acard->wavefront.res_base == NULL) {
 		snd_printk(KERN_ERR "unable to grab ICS2115 i/o region 0x%lx-0x%lx\n",
 			   ics2115_port[dev], ics2115_port[dev] + 16 - 1);
 		return -EBUSY;
@@ -426,7 +425,8 @@ snd_wavefront_probe (struct snd_card *ca
 	acard->wavefront.irq = ics2115_irq[dev];
 	acard->wavefront.base = ics2115_port[dev];
 
-	if ((wavefront_synth = snd_wavefront_new_synth (card, hw_dev, acard)) == NULL) {
+	wavefront_synth = snd_wavefront_new_synth(card, hw_dev, acard);
+	if (wavefront_synth == NULL) {
 		snd_printk (KERN_ERR "can't create WaveFront synth device\n");
 		return -ENOMEM;
 	}
@@ -437,7 +437,8 @@ snd_wavefront_probe (struct snd_card *ca
 
 	/* --------- Mixer ------------ */
 
-	if ((err = snd_cs4231_mixer(chip)) < 0) {
+	err = snd_wss_mixer(chip);
+	if (err < 0) {
 		snd_printk (KERN_ERR "can't allocate mixer device\n");
 		return err;
 	}
@@ -445,11 +446,11 @@ snd_wavefront_probe (struct snd_card *ca
 	/* -------- CS4232 MPU-401 interface -------- */
 
 	if (cs4232_mpu_port[dev] > 0 && cs4232_mpu_port[dev] != SNDRV_AUTO_PORT) {
-		if ((err = snd_mpu401_uart_new(card, midi_dev, MPU401_HW_CS4232,
-					       cs4232_mpu_port[dev], 0,
-					       cs4232_mpu_irq[dev],
-					       IRQF_DISABLED,
-					       NULL)) < 0) {
+		err = snd_mpu401_uart_new(card, midi_dev, MPU401_HW_CS4232,
+					  cs4232_mpu_port[dev], 0,
+					  cs4232_mpu_irq[dev], IRQF_DISABLED,
+					  NULL);
+		if (err < 0) {
 			snd_printk (KERN_ERR "can't allocate CS4232 MPU-401 device\n");
 			return err;
 		}
@@ -602,7 +603,7 @@ static struct isa_driver snd_wavefront_d
 
 #ifdef CONFIG_PNP
 static int __devinit snd_wavefront_pnp_detect(struct pnp_card_link *pcard,
-                                              const struct pnp_card_device_id *pid)
+				      const struct pnp_card_device_id *pid)
 {
 	static int dev;
 	struct snd_card *card;
diff -urp linux-alsa/sound/isa/wss/wss_lib.c linux-mm/sound/isa/wss/wss_lib.c
--- linux-alsa/sound/isa/wss/wss_lib.c	2008-06-24 19:45:16.000000000 +0200
+++ linux-mm/sound/isa/wss/wss_lib.c	2008-06-25 19:11:56.104196128 +0200
@@ -6,7 +6,7 @@
  *     - sometimes record brokes playback with WSS portion of 
  *       Yamaha OPL3-SA3 chip
  *     - CS4231 (GUS MAX) - still trouble with occasional noises
- *                        - broken initialization?
+ *			  - broken initialization?
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -78,12 +78,13 @@ static struct snd_pcm_hw_constraint_list
 	.mask = 0,
 };
 
-static int snd_cs4231_xrate(struct snd_pcm_runtime *runtime)
+static int snd_wss_xrate(struct snd_pcm_runtime *runtime)
 {
-	return snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
+	return snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+					  &hw_constraints_rates);
 }
 
-static unsigned char snd_cs4231_original_image[32] =
+static unsigned char snd_wss_original_image[32] =
 {
 	0x00,			/* 00/00 - lic */
 	0x00,			/* 01/01 - ric */
@@ -159,150 +160,192 @@ static unsigned char snd_opti93x_origina
  *  Basic I/O functions
  */
 
-static inline void cs4231_outb(struct snd_cs4231 *chip, u8 offset, u8 val)
+static inline void wss_outb(struct snd_wss *chip, u8 offset, u8 val)
 {
 	outb(val, chip->port + offset);
 }
+EXPORT_SYMBOL(snd_wss_out);
 
-static inline u8 cs4231_inb(struct snd_cs4231 *chip, u8 offset)
+static inline u8 wss_inb(struct snd_wss *chip, u8 offset)
 {
 	return inb(chip->port + offset);
 }
 
-static void snd_cs4231_wait(struct snd_cs4231 *chip)
+static void snd_wss_wait(struct snd_wss *chip)
 {
 	int timeout;
 
 	for (timeout = 250;
-	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
+	     timeout > 0 && (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
 	     timeout--)
 	     	udelay(100);
 }
 
-static void snd_cs4231_outm(struct snd_cs4231 *chip, unsigned char reg,
+static void snd_wss_outm(struct snd_wss *chip, unsigned char reg,
 			    unsigned char mask, unsigned char value)
 {
 	unsigned char tmp = (chip->image[reg] & mask) | value;
 
-	snd_cs4231_wait(chip);
+	snd_wss_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
 	chip->image[reg] = tmp;
 	if (!chip->calibrate_mute) {
-		cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
+		wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
 		wmb();
-		cs4231_outb(chip, CS4231P(REG), tmp);
+		wss_outb(chip, CS4231P(REG), tmp);
 		mb();
 	}
 }
 
-static void snd_cs4231_dout(struct snd_cs4231 *chip, unsigned char reg, unsigned char value)
+static void snd_wss_dout(struct snd_wss *chip, unsigned char reg,
+			 unsigned char value)
 {
 	int timeout;
 
 	for (timeout = 250;
-	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
+	     timeout > 0 && (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
 	     timeout--)
 	     	udelay(10);
-	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
-	cs4231_outb(chip, CS4231P(REG), value);
+	wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
+	wss_outb(chip, CS4231P(REG), value);
 	mb();
 }
 
-void snd_cs4231_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char value)
+void snd_wss_out(struct snd_wss *chip, unsigned char reg, unsigned char value)
 {
-	snd_cs4231_wait(chip);
+	snd_wss_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
-	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
-	cs4231_outb(chip, CS4231P(REG), value);
+	wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
+	wss_outb(chip, CS4231P(REG), value);
 	chip->image[reg] = value;
 	mb();
 	snd_printdd("codec out - reg 0x%x = 0x%x\n",
 			chip->mce_bit | reg, value);
 }
 
-unsigned char snd_cs4231_in(struct snd_cs4231 *chip, unsigned char reg)
+unsigned char snd_wss_in(struct snd_wss *chip, unsigned char reg)
 {
-	snd_cs4231_wait(chip);
+	snd_wss_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("in: auto calibration time out - reg = 0x%x\n", reg);
 #endif
-	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
+	wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
 	mb();
-	return cs4231_inb(chip, CS4231P(REG));
+	return wss_inb(chip, CS4231P(REG));
 }
+EXPORT_SYMBOL(snd_wss_in);
 
-void snd_cs4236_ext_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char val)
+void snd_cs4236_ext_out(struct snd_wss *chip, unsigned char reg,
+			unsigned char val)
 {
-	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | 0x17);
-	cs4231_outb(chip, CS4231P(REG), reg | (chip->image[CS4236_EXT_REG] & 0x01));
-	cs4231_outb(chip, CS4231P(REG), val);
+	wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | 0x17);
+	wss_outb(chip, CS4231P(REG),
+		 reg | (chip->image[CS4236_EXT_REG] & 0x01));
+	wss_outb(chip, CS4231P(REG), val);
 	chip->eimage[CS4236_REG(reg)] = val;
 #if 0
 	printk("ext out : reg = 0x%x, val = 0x%x\n", reg, val);
 #endif
 }
+EXPORT_SYMBOL(snd_cs4236_ext_out);
 
-unsigned char snd_cs4236_ext_in(struct snd_cs4231 *chip, unsigned char reg)
+unsigned char snd_cs4236_ext_in(struct snd_wss *chip, unsigned char reg)
 {
-	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | 0x17);
-	cs4231_outb(chip, CS4231P(REG), reg | (chip->image[CS4236_EXT_REG] & 0x01));
+	wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | 0x17);
+	wss_outb(chip, CS4231P(REG),
+		 reg | (chip->image[CS4236_EXT_REG] & 0x01));
 #if 1
-	return cs4231_inb(chip, CS4231P(REG));
+	return wss_inb(chip, CS4231P(REG));
 #else
 	{
 		unsigned char res;
-		res = cs4231_inb(chip, CS4231P(REG));
+		res = wss_inb(chip, CS4231P(REG));
 		printk("ext in : reg = 0x%x, val = 0x%x\n", reg, res);
 		return res;
 	}
 #endif
 }
+EXPORT_SYMBOL(snd_cs4236_ext_in);
 
 #if 0
 
-static void snd_cs4231_debug(struct snd_cs4231 *chip)
+static void snd_wss_debug(struct snd_wss *chip)
 {
-	printk("CS4231 REGS:      INDEX = 0x%02x  ", cs4231_inb(chip, CS4231P(REGSEL)));
-	printk("                 STATUS = 0x%02x\n", cs4231_inb(chip, CS4231P(STATUS)));
-	printk("  0x00: left input      = 0x%02x  ", snd_cs4231_in(chip, 0x00));
-	printk("  0x10: alt 1 (CFIG 2)  = 0x%02x\n", snd_cs4231_in(chip, 0x10));
-	printk("  0x01: right input     = 0x%02x  ", snd_cs4231_in(chip, 0x01));
-	printk("  0x11: alt 2 (CFIG 3)  = 0x%02x\n", snd_cs4231_in(chip, 0x11));
-	printk("  0x02: GF1 left input  = 0x%02x  ", snd_cs4231_in(chip, 0x02));
-	printk("  0x12: left line in    = 0x%02x\n", snd_cs4231_in(chip, 0x12));
-	printk("  0x03: GF1 right input = 0x%02x  ", snd_cs4231_in(chip, 0x03));
-	printk("  0x13: right line in   = 0x%02x\n", snd_cs4231_in(chip, 0x13));
-	printk("  0x04: CD left input   = 0x%02x  ", snd_cs4231_in(chip, 0x04));
-	printk("  0x14: timer low       = 0x%02x\n", snd_cs4231_in(chip, 0x14));
-	printk("  0x05: CD right input  = 0x%02x  ", snd_cs4231_in(chip, 0x05));
-	printk("  0x15: timer high      = 0x%02x\n", snd_cs4231_in(chip, 0x15));
-	printk("  0x06: left output     = 0x%02x  ", snd_cs4231_in(chip, 0x06));
-	printk("  0x16: left MIC (PnP)  = 0x%02x\n", snd_cs4231_in(chip, 0x16));
-	printk("  0x07: right output    = 0x%02x  ", snd_cs4231_in(chip, 0x07));
-	printk("  0x17: right MIC (PnP) = 0x%02x\n", snd_cs4231_in(chip, 0x17));
-	printk("  0x08: playback format = 0x%02x  ", snd_cs4231_in(chip, 0x08));
-	printk("  0x18: IRQ status      = 0x%02x\n", snd_cs4231_in(chip, 0x18));
-	printk("  0x09: iface (CFIG 1)  = 0x%02x  ", snd_cs4231_in(chip, 0x09));
-	printk("  0x19: left line out   = 0x%02x\n", snd_cs4231_in(chip, 0x19));
-	printk("  0x0a: pin control     = 0x%02x  ", snd_cs4231_in(chip, 0x0a));
-	printk("  0x1a: mono control    = 0x%02x\n", snd_cs4231_in(chip, 0x1a));
-	printk("  0x0b: init & status   = 0x%02x  ", snd_cs4231_in(chip, 0x0b));
-	printk("  0x1b: right line out  = 0x%02x\n", snd_cs4231_in(chip, 0x1b));
-	printk("  0x0c: revision & mode = 0x%02x  ", snd_cs4231_in(chip, 0x0c));
-	printk("  0x1c: record format   = 0x%02x\n", snd_cs4231_in(chip, 0x1c));
-	printk("  0x0d: loopback        = 0x%02x  ", snd_cs4231_in(chip, 0x0d));
-	printk("  0x1d: var freq (PnP)  = 0x%02x\n", snd_cs4231_in(chip, 0x1d));
-	printk("  0x0e: ply upr count   = 0x%02x  ", snd_cs4231_in(chip, 0x0e));
-	printk("  0x1e: ply lwr count   = 0x%02x\n", snd_cs4231_in(chip, 0x1e));
-	printk("  0x0f: rec upr count   = 0x%02x  ", snd_cs4231_in(chip, 0x0f));
-	printk("  0x1f: rec lwr count   = 0x%02x\n", snd_cs4231_in(chip, 0x1f));
+	printk(KERN_DEBUG "CS4231 REGS:      INDEX = 0x%02x  ",
+		wss_inb(chip, CS4231P(REGSEL)));
+	printk(KERN_DEBUG "                 STATUS = 0x%02x\n",
+		wss_inb(chip, CS4231P(STATUS)));
+	printk(KERN_DEBUG "  0x00: left input      = 0x%02x  ",
+		snd_wss_in(chip, 0x00));
+	printk(KERN_DEBUG "  0x10: alt 1 (CFIG 2)  = 0x%02x\n",
+		snd_wss_in(chip, 0x10));
+	printk(KERN_DEBUG "  0x01: right input     = 0x%02x  ",
+		snd_wss_in(chip, 0x01));
+	printk(KERN_DEBUG "  0x11: alt 2 (CFIG 3)  = 0x%02x\n",
+		snd_wss_in(chip, 0x11));
+	printk(KERN_DEBUG "  0x02: GF1 left input  = 0x%02x  ",
+		snd_wss_in(chip, 0x02));
+	printk(KERN_DEBUG "  0x12: left line in    = 0x%02x\n",
+		snd_wss_in(chip, 0x12));
+	printk(KERN_DEBUG "  0x03: GF1 right input = 0x%02x  ",
+		snd_wss_in(chip, 0x03));
+	printk(KERN_DEBUG "  0x13: right line in   = 0x%02x\n",
+		snd_wss_in(chip, 0x13));
+	printk(KERN_DEBUG "  0x04: CD left input   = 0x%02x  ",
+		snd_wss_in(chip, 0x04));
+	printk(KERN_DEBUG "  0x14: timer low       = 0x%02x\n",
+		snd_wss_in(chip, 0x14));
+	printk(KERN_DEBUG "  0x05: CD right input  = 0x%02x  ",
+		snd_wss_in(chip, 0x05));
+	printk(KERN_DEBUG "  0x15: timer high      = 0x%02x\n",
+		snd_wss_in(chip, 0x15));
+	printk(KERN_DEBUG "  0x06: left output     = 0x%02x  ",
+		snd_wss_in(chip, 0x06));
+	printk(KERN_DEBUG "  0x16: left MIC (PnP)  = 0x%02x\n",
+		snd_wss_in(chip, 0x16));
+	printk(KERN_DEBUG "  0x07: right output    = 0x%02x  ",
+		snd_wss_in(chip, 0x07));
+	printk(KERN_DEBUG "  0x17: right MIC (PnP) = 0x%02x\n",
+		snd_wss_in(chip, 0x17));
+	printk(KERN_DEBUG "  0x08: playback format = 0x%02x  ",
+		snd_wss_in(chip, 0x08));
+	printk(KERN_DEBUG "  0x18: IRQ status      = 0x%02x\n",
+		snd_wss_in(chip, 0x18));
+	printk(KERN_DEBUG "  0x09: iface (CFIG 1)  = 0x%02x  ",
+		snd_wss_in(chip, 0x09));
+	printk(KERN_DEBUG "  0x19: left line out   = 0x%02x\n",
+		snd_wss_in(chip, 0x19));
+	printk(KERN_DEBUG "  0x0a: pin control     = 0x%02x  ",
+		snd_wss_in(chip, 0x0a));
+	printk(KERN_DEBUG "  0x1a: mono control    = 0x%02x\n",
+		snd_wss_in(chip, 0x1a));
+	printk(KERN_DEBUG "  0x0b: init & status   = 0x%02x  ",
+		snd_wss_in(chip, 0x0b));
+	printk(KERN_DEBUG "  0x1b: right line out  = 0x%02x\n",
+		snd_wss_in(chip, 0x1b));
+	printk(KERN_DEBUG "  0x0c: revision & mode = 0x%02x  ",
+		snd_wss_in(chip, 0x0c));
+	printk(KERN_DEBUG "  0x1c: record format   = 0x%02x\n",
+		snd_wss_in(chip, 0x1c));
+	printk(KERN_DEBUG "  0x0d: loopback        = 0x%02x  ",
+		snd_wss_in(chip, 0x0d));
+	printk(KERN_DEBUG "  0x1d: var freq (PnP)  = 0x%02x\n",
+		snd_wss_in(chip, 0x1d));
+	printk(KERN_DEBUG "  0x0e: ply upr count   = 0x%02x  ",
+		snd_wss_in(chip, 0x0e));
+	printk(KERN_DEBUG "  0x1e: ply lwr count   = 0x%02x\n",
+		snd_wss_in(chip, 0x1e));
+	printk(KERN_DEBUG "  0x0f: rec upr count   = 0x%02x  ",
+		snd_wss_in(chip, 0x0f));
+	printk(KERN_DEBUG "  0x1f: rec lwr count   = 0x%02x\n",
+		snd_wss_in(chip, 0x1f));
 }
 
 #endif
@@ -311,61 +354,63 @@ static void snd_cs4231_debug(struct snd_
  *  CS4231 detection / MCE routines
  */
 
-static void snd_cs4231_busy_wait(struct snd_cs4231 *chip)
+static void snd_wss_busy_wait(struct snd_wss *chip)
 {
 	int timeout;
 
 	/* huh.. looks like this sequence is proper for CS4231A chip (GUS MAX) */
 	for (timeout = 5; timeout > 0; timeout--)
-		cs4231_inb(chip, CS4231P(REGSEL));
+		wss_inb(chip, CS4231P(REGSEL));
 	/* end of cleanup sequence */
 	for (timeout = 250;
-	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
+	     timeout > 0 && (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
 	     timeout--)
 	     	udelay(10);
 }
 
-void snd_cs4231_mce_up(struct snd_cs4231 *chip)
+void snd_wss_mce_up(struct snd_wss *chip)
 {
 	unsigned long flags;
 	int timeout;
 
-	snd_cs4231_wait(chip);
+	snd_wss_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("mce_up - auto calibration time out (0)\n");
 #endif
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	chip->mce_bit |= CS4231_MCE;
-	timeout = cs4231_inb(chip, CS4231P(REGSEL));
+	timeout = wss_inb(chip, CS4231P(REGSEL));
 	if (timeout == 0x80)
 		snd_printk("mce_up [0x%lx]: serious init problem - codec still busy\n", chip->port);
 	if (!(timeout & CS4231_MCE))
-		cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | (timeout & 0x1f));
+		wss_outb(chip, CS4231P(REGSEL),
+			 chip->mce_bit | (timeout & 0x1f));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
+EXPORT_SYMBOL(snd_wss_mce_up);
 
-void snd_cs4231_mce_down(struct snd_cs4231 *chip)
+void snd_wss_mce_down(struct snd_wss *chip)
 {
 	unsigned long flags;
 	unsigned long end_time;
 	int timeout;
 
-	snd_cs4231_busy_wait(chip);
+	snd_wss_busy_wait(chip);
 
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("mce_down [0x%lx] - auto calibration time out (0)\n", (long)CS4231P(REGSEL));
 #endif
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	chip->mce_bit &= ~CS4231_MCE;
-	timeout = cs4231_inb(chip, CS4231P(REGSEL));
-	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | (timeout & 0x1f));
+	timeout = wss_inb(chip, CS4231P(REGSEL));
+	wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | (timeout & 0x1f));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	if (timeout == 0x80)
 		snd_printk("mce_down [0x%lx]: serious init problem - codec still busy\n", chip->port);
 	if ((timeout & CS4231_MCE) == 0 ||
-	    !(chip->hardware & (CS4231_HW_CS4231_MASK | CS4231_HW_CS4232_MASK))) {
+	    !(chip->hardware & (WSS_HW_CS4231_MASK | WSS_HW_CS4232_MASK))) {
 		return;
 	}
 
@@ -380,7 +425,7 @@ void snd_cs4231_mce_down(struct snd_cs42
 
 	/* check condition up to 250 ms */
 	end_time = jiffies + msecs_to_jiffies(250);
-	while (snd_cs4231_in(chip, CS4231_TEST_INIT) &
+	while (snd_wss_in(chip, CS4231_TEST_INIT) &
 		CS4231_CALIB_IN_PROGRESS) {
 
 		if (time_after(jiffies, end_time)) {
@@ -395,7 +440,7 @@ void snd_cs4231_mce_down(struct snd_cs42
 
 	/* check condition up to 100 ms */
 	end_time = jiffies + msecs_to_jiffies(100);
-	while (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {
+	while (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {
 		if (time_after(jiffies, end_time)) {
 			snd_printk(KERN_ERR "mce_down - auto calibration time out (3)\n");
 			return;
@@ -404,10 +449,11 @@ void snd_cs4231_mce_down(struct snd_cs42
 	}
 
 	snd_printdd("(3) jiffies = %lu\n", jiffies);
-	snd_printd("mce_down - exit = 0x%x\n", cs4231_inb(chip, CS4231P(REGSEL)));
+	snd_printd("mce_down - exit = 0x%x\n", wss_inb(chip, CS4231P(REGSEL)));
 }
+EXPORT_SYMBOL(snd_wss_mce_down);
 
-static unsigned int snd_cs4231_get_count(unsigned char format, unsigned int size)
+static unsigned int snd_wss_get_count(unsigned char format, unsigned int size)
 {
 	switch (format & 0xe0) {
 	case CS4231_LINEAR_16:
@@ -422,19 +468,15 @@ static unsigned int snd_cs4231_get_count
 	return size;
 }
 
-static int snd_cs4231_trigger(struct snd_pcm_substream *substream,
+static int snd_wss_trigger(struct snd_pcm_substream *substream,
 			      int cmd)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	int result = 0;
 	unsigned int what;
 	struct snd_pcm_substream *s;
 	int do_start;
 
-#if 0
-	printk("codec trigger!!! - what = %i, enable = %i, status = 0x%x\n", what, enable, cs4231_inb(chip, CS4231P(STATUS)));
-#endif
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -466,10 +508,10 @@ static int snd_cs4231_trigger(struct snd
 		if (chip->trigger)
 			chip->trigger(chip, what, 0);
 	}
-	snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
+	snd_wss_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
 	spin_unlock(&chip->reg_lock);
 #if 0
-	snd_cs4231_debug(chip);
+	snd_wss_debug(chip);
 #endif
 	return result;
 }
@@ -478,7 +520,7 @@ static int snd_cs4231_trigger(struct snd
  *  CODEC I/O
  */
 
-static unsigned char snd_cs4231_get_rate(unsigned int rate)
+static unsigned char snd_wss_get_rate(unsigned int rate)
 {
 	int i;
 
@@ -489,9 +531,9 @@ static unsigned char snd_cs4231_get_rate
 	return freq_bits[ARRAY_SIZE(rates) - 1];
 }
 
-static unsigned char snd_cs4231_get_format(struct snd_cs4231 *chip,
-				           int format,
-                                           int channels)
+static unsigned char snd_wss_get_format(struct snd_wss *chip,
+					int format,
+					int channels)
 {
 	unsigned char rformat;
 
@@ -511,7 +553,7 @@ static unsigned char snd_cs4231_get_form
 	return rformat;
 }
 
-static void snd_cs4231_calibrate_mute(struct snd_cs4231 *chip, int mute)
+static void snd_wss_calibrate_mute(struct snd_wss *chip, int mute)
 {
 	unsigned long flags;
 
@@ -522,30 +564,46 @@ static void snd_cs4231_calibrate_mute(st
 		return;
 	}
 	if (!mute) {
-		snd_cs4231_dout(chip, CS4231_LEFT_INPUT, chip->image[CS4231_LEFT_INPUT]);
-		snd_cs4231_dout(chip, CS4231_RIGHT_INPUT, chip->image[CS4231_RIGHT_INPUT]);
-		snd_cs4231_dout(chip, CS4231_LOOPBACK, chip->image[CS4231_LOOPBACK]);
-	}
-	snd_cs4231_dout(chip, CS4231_AUX1_LEFT_INPUT, mute ? 0x80 : chip->image[CS4231_AUX1_LEFT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX1_RIGHT_INPUT, mute ? 0x80 : chip->image[CS4231_AUX1_RIGHT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX2_LEFT_INPUT, mute ? 0x80 : chip->image[CS4231_AUX2_LEFT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX2_RIGHT_INPUT, mute ? 0x80 : chip->image[CS4231_AUX2_RIGHT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_LEFT_OUTPUT, mute ? 0x80 : chip->image[CS4231_LEFT_OUTPUT]);
-	snd_cs4231_dout(chip, CS4231_RIGHT_OUTPUT, mute ? 0x80 : chip->image[CS4231_RIGHT_OUTPUT]);
-	snd_cs4231_dout(chip, CS4231_LEFT_LINE_IN, mute ? 0x80 : chip->image[CS4231_LEFT_LINE_IN]);
-	snd_cs4231_dout(chip, CS4231_RIGHT_LINE_IN, mute ? 0x80 : chip->image[CS4231_RIGHT_LINE_IN]);
-	snd_cs4231_dout(chip, CS4231_MONO_CTRL, mute ? 0xc0 : chip->image[CS4231_MONO_CTRL]);
-	if (chip->hardware == CS4231_HW_INTERWAVE) {
-		snd_cs4231_dout(chip, CS4231_LEFT_MIC_INPUT, mute ? 0x80 : chip->image[CS4231_LEFT_MIC_INPUT]);
-		snd_cs4231_dout(chip, CS4231_RIGHT_MIC_INPUT, mute ? 0x80 : chip->image[CS4231_RIGHT_MIC_INPUT]);		
-		snd_cs4231_dout(chip, CS4231_LINE_LEFT_OUTPUT, mute ? 0x80 : chip->image[CS4231_LINE_LEFT_OUTPUT]);
-		snd_cs4231_dout(chip, CS4231_LINE_RIGHT_OUTPUT, mute ? 0x80 : chip->image[CS4231_LINE_RIGHT_OUTPUT]);
+		snd_wss_dout(chip, CS4231_LEFT_INPUT,
+			     chip->image[CS4231_LEFT_INPUT]);
+		snd_wss_dout(chip, CS4231_RIGHT_INPUT,
+			     chip->image[CS4231_RIGHT_INPUT]);
+		snd_wss_dout(chip, CS4231_LOOPBACK,
+			     chip->image[CS4231_LOOPBACK]);
+	}
+	snd_wss_dout(chip, CS4231_AUX1_LEFT_INPUT,
+		     mute ? 0x80 : chip->image[CS4231_AUX1_LEFT_INPUT]);
+	snd_wss_dout(chip, CS4231_AUX1_RIGHT_INPUT,
+		     mute ? 0x80 : chip->image[CS4231_AUX1_RIGHT_INPUT]);
+	snd_wss_dout(chip, CS4231_AUX2_LEFT_INPUT,
+		     mute ? 0x80 : chip->image[CS4231_AUX2_LEFT_INPUT]);
+	snd_wss_dout(chip, CS4231_AUX2_RIGHT_INPUT,
+		     mute ? 0x80 : chip->image[CS4231_AUX2_RIGHT_INPUT]);
+	snd_wss_dout(chip, CS4231_LEFT_OUTPUT,
+		     mute ? 0x80 : chip->image[CS4231_LEFT_OUTPUT]);
+	snd_wss_dout(chip, CS4231_RIGHT_OUTPUT,
+		     mute ? 0x80 : chip->image[CS4231_RIGHT_OUTPUT]);
+	snd_wss_dout(chip, CS4231_LEFT_LINE_IN,
+		     mute ? 0x80 : chip->image[CS4231_LEFT_LINE_IN]);
+	snd_wss_dout(chip, CS4231_RIGHT_LINE_IN,
+		     mute ? 0x80 : chip->image[CS4231_RIGHT_LINE_IN]);
+	snd_wss_dout(chip, CS4231_MONO_CTRL,
+		     mute ? 0xc0 : chip->image[CS4231_MONO_CTRL]);
+	if (chip->hardware == WSS_HW_INTERWAVE) {
+		snd_wss_dout(chip, CS4231_LEFT_MIC_INPUT,
+			     mute ? 0x80 : chip->image[CS4231_LEFT_MIC_INPUT]);
+		snd_wss_dout(chip, CS4231_RIGHT_MIC_INPUT,
+			     mute ? 0x80 : chip->image[CS4231_RIGHT_MIC_INPUT]);
+		snd_wss_dout(chip, CS4231_LINE_LEFT_OUTPUT,
+			mute ? 0x80 : chip->image[CS4231_LINE_LEFT_OUTPUT]);
+		snd_wss_dout(chip, CS4231_LINE_RIGHT_OUTPUT,
+			mute ? 0x80 : chip->image[CS4231_LINE_RIGHT_OUTPUT]);
 	}
 	chip->calibrate_mute = mute;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static void snd_cs4231_playback_format(struct snd_cs4231 *chip,
+static void snd_wss_playback_format(struct snd_wss *chip,
 				       struct snd_pcm_hw_params *params,
 				       unsigned char pdfr)
 {
@@ -553,79 +611,87 @@ static void snd_cs4231_playback_format(s
 	int full_calib = 1;
 
 	mutex_lock(&chip->mce_mutex);
-	snd_cs4231_calibrate_mute(chip, 1);
-	if (chip->hardware == CS4231_HW_CS4231A ||
-	    (chip->hardware & CS4231_HW_CS4232_MASK)) {
+	snd_wss_calibrate_mute(chip, 1);
+	if (chip->hardware == WSS_HW_CS4231A ||
+	    (chip->hardware & WSS_HW_CS4232_MASK)) {
 		spin_lock_irqsave(&chip->reg_lock, flags);
 		if ((chip->image[CS4231_PLAYBK_FORMAT] & 0x0f) == (pdfr & 0x0f)) {	/* rate is same? */
-			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | 0x10);
-			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
-			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] &= ~0x10);
+			snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+				    chip->image[CS4231_ALT_FEATURE_1] | 0x10);
+			chip->image[CS4231_PLAYBK_FORMAT] = pdfr;
+			snd_wss_out(chip, CS4231_PLAYBK_FORMAT,
+				    chip->image[CS4231_PLAYBK_FORMAT]);
+			snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+				    chip->image[CS4231_ALT_FEATURE_1] &= ~0x10);
 			udelay(100); /* Fixes audible clicks at least on GUS MAX */
 			full_calib = 0;
 		}
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	}
 	if (full_calib) {
-		snd_cs4231_mce_up(chip);
+		snd_wss_mce_up(chip);
 		spin_lock_irqsave(&chip->reg_lock, flags);
-		if (chip->hardware != CS4231_HW_INTERWAVE && !chip->single_dma) {
-			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
+		if (chip->hardware != WSS_HW_INTERWAVE && !chip->single_dma) {
+			snd_wss_out(chip, CS4231_PLAYBK_FORMAT,
 					(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) ?
 					(pdfr & 0xf0) | (chip->image[CS4231_REC_FORMAT] & 0x0f) :
-				        pdfr);
+					pdfr);
 		} else {
-			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
+			snd_wss_out(chip, CS4231_PLAYBK_FORMAT,
+				    chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
 		}
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		if (chip->hardware == CS4231_HW_OPL3SA2)
+		if (chip->hardware == WSS_HW_OPL3SA2)
 			udelay(100);	/* this seems to help */
-		snd_cs4231_mce_down(chip);
+		snd_wss_mce_down(chip);
 	}
-	snd_cs4231_calibrate_mute(chip, 0);
+	snd_wss_calibrate_mute(chip, 0);
 	mutex_unlock(&chip->mce_mutex);
 }
 
-static void snd_cs4231_capture_format(struct snd_cs4231 *chip,
-				      struct snd_pcm_hw_params *params,
-                                      unsigned char cdfr)
+static void snd_wss_capture_format(struct snd_wss *chip,
+				   struct snd_pcm_hw_params *params,
+				   unsigned char cdfr)
 {
 	unsigned long flags;
 	int full_calib = 1;
 
 	mutex_lock(&chip->mce_mutex);
-	snd_cs4231_calibrate_mute(chip, 1);
-	if (chip->hardware == CS4231_HW_CS4231A ||
-	    (chip->hardware & CS4231_HW_CS4232_MASK)) {
+	snd_wss_calibrate_mute(chip, 1);
+	if (chip->hardware == WSS_HW_CS4231A ||
+	    (chip->hardware & WSS_HW_CS4232_MASK)) {
 		spin_lock_irqsave(&chip->reg_lock, flags);
 		if ((chip->image[CS4231_PLAYBK_FORMAT] & 0x0f) == (cdfr & 0x0f) ||	/* rate is same? */
 		    (chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE)) {
-			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | 0x20);
-			snd_cs4231_out(chip, CS4231_REC_FORMAT, chip->image[CS4231_REC_FORMAT] = cdfr);
-			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] &= ~0x20);
+			snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+				chip->image[CS4231_ALT_FEATURE_1] | 0x20);
+			snd_wss_out(chip, CS4231_REC_FORMAT,
+				chip->image[CS4231_REC_FORMAT] = cdfr);
+			snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+				chip->image[CS4231_ALT_FEATURE_1] &= ~0x20);
 			full_calib = 0;
 		}
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	}
 	if (full_calib) {
-		snd_cs4231_mce_up(chip);
+		snd_wss_mce_up(chip);
 		spin_lock_irqsave(&chip->reg_lock, flags);
-		if (chip->hardware != CS4231_HW_INTERWAVE) {
+		if (chip->hardware != WSS_HW_INTERWAVE) {
 			if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE)) {
-				snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
+				snd_wss_out(chip, CS4231_PLAYBK_FORMAT,
 					       ((chip->single_dma ? cdfr : chip->image[CS4231_PLAYBK_FORMAT]) & 0xf0) |
 					       (cdfr & 0x0f));
 				spin_unlock_irqrestore(&chip->reg_lock, flags);
-				snd_cs4231_mce_down(chip);
-				snd_cs4231_mce_up(chip);
+				snd_wss_mce_down(chip);
+				snd_wss_mce_up(chip);
 				spin_lock_irqsave(&chip->reg_lock, flags);
 			}
 		}
-		snd_cs4231_out(chip, CS4231_REC_FORMAT, cdfr);
+		snd_wss_out(chip, CS4231_REC_FORMAT, cdfr);
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		snd_cs4231_mce_down(chip);
+		snd_wss_mce_down(chip);
 	}
-	snd_cs4231_calibrate_mute(chip, 0);
+	snd_wss_calibrate_mute(chip, 0);
 	mutex_unlock(&chip->mce_mutex);
 }
 
@@ -633,130 +699,143 @@ static void snd_cs4231_capture_format(st
  *  Timer interface
  */
 
-static unsigned long snd_cs4231_timer_resolution(struct snd_timer * timer)
+static unsigned long snd_wss_timer_resolution(struct snd_timer *timer)
 {
-	struct snd_cs4231 *chip = snd_timer_chip(timer);
-	if (chip->hardware & CS4231_HW_CS4236B_MASK)
+	struct snd_wss *chip = snd_timer_chip(timer);
+	if (chip->hardware & WSS_HW_CS4236B_MASK)
 		return 14467;
 	else
 		return chip->image[CS4231_PLAYBK_FORMAT] & 1 ? 9969 : 9920;
 }
 
-static int snd_cs4231_timer_start(struct snd_timer * timer)
+static int snd_wss_timer_start(struct snd_timer *timer)
 {
 	unsigned long flags;
 	unsigned int ticks;
-	struct snd_cs4231 *chip = snd_timer_chip(timer);
+	struct snd_wss *chip = snd_timer_chip(timer);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	ticks = timer->sticks;
 	if ((chip->image[CS4231_ALT_FEATURE_1] & CS4231_TIMER_ENABLE) == 0 ||
 	    (unsigned char)(ticks >> 8) != chip->image[CS4231_TIMER_HIGH] ||
 	    (unsigned char)ticks != chip->image[CS4231_TIMER_LOW]) {
-		snd_cs4231_out(chip, CS4231_TIMER_HIGH, chip->image[CS4231_TIMER_HIGH] = (unsigned char) (ticks >> 8));
-		snd_cs4231_out(chip, CS4231_TIMER_LOW, chip->image[CS4231_TIMER_LOW] = (unsigned char) ticks);
-		snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | CS4231_TIMER_ENABLE);
+		chip->image[CS4231_TIMER_HIGH] = (unsigned char) (ticks >> 8);
+		snd_wss_out(chip, CS4231_TIMER_HIGH,
+			    chip->image[CS4231_TIMER_HIGH]);
+		chip->image[CS4231_TIMER_LOW] = (unsigned char) ticks;
+		snd_wss_out(chip, CS4231_TIMER_LOW,
+			    chip->image[CS4231_TIMER_LOW]);
+		snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+			    chip->image[CS4231_ALT_FEATURE_1] |
+			    CS4231_TIMER_ENABLE);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return 0;
 }
 
-static int snd_cs4231_timer_stop(struct snd_timer * timer)
+static int snd_wss_timer_stop(struct snd_timer *timer)
 {
 	unsigned long flags;
-	struct snd_cs4231 *chip = snd_timer_chip(timer);
+	struct snd_wss *chip = snd_timer_chip(timer);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] &= ~CS4231_TIMER_ENABLE);
+	snd_wss_out(chip, CS4231_ALT_FEATURE_1,
+		    chip->image[CS4231_ALT_FEATURE_1] &= ~CS4231_TIMER_ENABLE);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return 0;
 }
 
-static void snd_cs4231_init(struct snd_cs4231 *chip)
+static void snd_wss_init(struct snd_wss *chip)
 {
 	unsigned long flags;
 
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
 	snd_printk("init: (1)\n");
 #endif
-	snd_cs4231_mce_up(chip);
+	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
-			     CS4231_RECORD_ENABLE | CS4231_RECORD_PIO |
-			     CS4231_CALIB_MODE);
+	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
+				CS4231_PLAYBACK_PIO |
+				CS4231_RECORD_ENABLE |
+				CS4231_RECORD_PIO |
+				CS4231_CALIB_MODE);
 	chip->image[CS4231_IFACE_CTRL] |= CS4231_AUTOCALIB;
-	snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
+	snd_wss_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
 	snd_printk("init: (2)\n");
 #endif
 
-	snd_cs4231_mce_up(chip);
+	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1]);
+	snd_wss_out(chip,
+		    CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (3) - afei = 0x%x\n", chip->image[CS4231_ALT_FEATURE_1]);
+	snd_printk("init: (3) - afei = 0x%x\n",
+		   chip->image[CS4231_ALT_FEATURE_1]);
 #endif
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs4231_out(chip, CS4231_ALT_FEATURE_2, chip->image[CS4231_ALT_FEATURE_2]);
+	snd_wss_out(chip, CS4231_ALT_FEATURE_2,
+		    chip->image[CS4231_ALT_FEATURE_2]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
-	snd_cs4231_mce_up(chip);
+	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT]);
+	snd_wss_out(chip, CS4231_PLAYBK_FORMAT,
+		    chip->image[CS4231_PLAYBK_FORMAT]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
 	snd_printk("init: (4)\n");
 #endif
 
-	snd_cs4231_mce_up(chip);
+	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs4231_out(chip, CS4231_REC_FORMAT, chip->image[CS4231_REC_FORMAT]);
+	snd_wss_out(chip, CS4231_REC_FORMAT, chip->image[CS4231_REC_FORMAT]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
 	snd_printk("init: (5)\n");
 #endif
 }
 
-static int snd_cs4231_open(struct snd_cs4231 *chip, unsigned int mode)
+static int snd_wss_open(struct snd_wss *chip, unsigned int mode)
 {
 	unsigned long flags;
 
 	mutex_lock(&chip->open_mutex);
 	if ((chip->mode & mode) ||
-	    ((chip->mode & CS4231_MODE_OPEN) && chip->single_dma)) {
+	    ((chip->mode & WSS_MODE_OPEN) && chip->single_dma)) {
 		mutex_unlock(&chip->open_mutex);
 		return -EAGAIN;
 	}
-	if (chip->mode & CS4231_MODE_OPEN) {
+	if (chip->mode & WSS_MODE_OPEN) {
 		chip->mode |= mode;
 		mutex_unlock(&chip->open_mutex);
 		return 0;
 	}
 	/* ok. now enable and ack CODEC IRQ */
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs4231_out(chip, CS4231_IRQ_STATUS, CS4231_PLAYBACK_IRQ |
+	snd_wss_out(chip, CS4231_IRQ_STATUS, CS4231_PLAYBACK_IRQ |
 		       CS4231_RECORD_IRQ |
 		       CS4231_TIMER_IRQ);
-	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
-	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
-	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
+	snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
+	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	chip->image[CS4231_PIN_CTRL] |= CS4231_IRQ_ENABLE;
-	snd_cs4231_out(chip, CS4231_PIN_CTRL, chip->image[CS4231_PIN_CTRL]);
-	snd_cs4231_out(chip, CS4231_IRQ_STATUS, CS4231_PLAYBACK_IRQ |
+	snd_wss_out(chip, CS4231_PIN_CTRL, chip->image[CS4231_PIN_CTRL]);
+	snd_wss_out(chip, CS4231_IRQ_STATUS, CS4231_PLAYBACK_IRQ |
 		       CS4231_RECORD_IRQ |
 		       CS4231_TIMER_IRQ);
-	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
+	snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	chip->mode = mode;
@@ -764,48 +843,49 @@ static int snd_cs4231_open(struct snd_cs
 	return 0;
 }
 
-static void snd_cs4231_close(struct snd_cs4231 *chip, unsigned int mode)
+static void snd_wss_close(struct snd_wss *chip, unsigned int mode)
 {
 	unsigned long flags;
 
 	mutex_lock(&chip->open_mutex);
 	chip->mode &= ~mode;
-	if (chip->mode & CS4231_MODE_OPEN) {
+	if (chip->mode & WSS_MODE_OPEN) {
 		mutex_unlock(&chip->open_mutex);
 		return;
 	}
-	snd_cs4231_calibrate_mute(chip, 1);
+	snd_wss_calibrate_mute(chip, 1);
 
 	/* disable IRQ */
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
-	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
-	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
+	snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
+	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	chip->image[CS4231_PIN_CTRL] &= ~CS4231_IRQ_ENABLE;
-	snd_cs4231_out(chip, CS4231_PIN_CTRL, chip->image[CS4231_PIN_CTRL]);
+	snd_wss_out(chip, CS4231_PIN_CTRL, chip->image[CS4231_PIN_CTRL]);
 
 	/* now disable record & playback */
 
 	if (chip->image[CS4231_IFACE_CTRL] & (CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
 					       CS4231_RECORD_ENABLE | CS4231_RECORD_PIO)) {
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		snd_cs4231_mce_up(chip);
+		snd_wss_mce_up(chip);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 		chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
 						     CS4231_RECORD_ENABLE | CS4231_RECORD_PIO);
-		snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
+		snd_wss_out(chip, CS4231_IFACE_CTRL,
+			    chip->image[CS4231_IFACE_CTRL]);
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		snd_cs4231_mce_down(chip);
+		snd_wss_mce_down(chip);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 	}
 
 	/* clear IRQ again */
-	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
-	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
-	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
+	snd_wss_out(chip, CS4231_IRQ_STATUS, 0);
+	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
+	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
-	snd_cs4231_calibrate_mute(chip, 0);
+	snd_wss_calibrate_mute(chip, 0);
 
 	chip->mode = 0;
 	mutex_unlock(&chip->open_mutex);
@@ -815,59 +895,60 @@ static void snd_cs4231_close(struct snd_
  *  timer open/close
  */
 
-static int snd_cs4231_timer_open(struct snd_timer * timer)
+static int snd_wss_timer_open(struct snd_timer *timer)
 {
-	struct snd_cs4231 *chip = snd_timer_chip(timer);
-	snd_cs4231_open(chip, CS4231_MODE_TIMER);
+	struct snd_wss *chip = snd_timer_chip(timer);
+	snd_wss_open(chip, WSS_MODE_TIMER);
 	return 0;
 }
 
-static int snd_cs4231_timer_close(struct snd_timer * timer)
+static int snd_wss_timer_close(struct snd_timer *timer)
 {
-	struct snd_cs4231 *chip = snd_timer_chip(timer);
-	snd_cs4231_close(chip, CS4231_MODE_TIMER);
+	struct snd_wss *chip = snd_timer_chip(timer);
+	snd_wss_close(chip, WSS_MODE_TIMER);
 	return 0;
 }
 
-static struct snd_timer_hardware snd_cs4231_timer_table =
+static struct snd_timer_hardware snd_wss_timer_table =
 {
 	.flags =	SNDRV_TIMER_HW_AUTO,
 	.resolution =	9945,
 	.ticks =	65535,
-	.open =		snd_cs4231_timer_open,
-	.close =	snd_cs4231_timer_close,
-	.c_resolution = snd_cs4231_timer_resolution,
-	.start =	snd_cs4231_timer_start,
-	.stop =		snd_cs4231_timer_stop,
+	.open =		snd_wss_timer_open,
+	.close =	snd_wss_timer_close,
+	.c_resolution = snd_wss_timer_resolution,
+	.start =	snd_wss_timer_start,
+	.stop =		snd_wss_timer_stop,
 };
 
 /*
  *  ok.. exported functions..
  */
 
-static int snd_cs4231_playback_hw_params(struct snd_pcm_substream *substream,
+static int snd_wss_playback_hw_params(struct snd_pcm_substream *substream,
 					 struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	unsigned char new_pdfr;
 	int err;
 
 	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
 		return err;
-	new_pdfr = snd_cs4231_get_format(chip, params_format(hw_params), params_channels(hw_params)) |
-		   snd_cs4231_get_rate(params_rate(hw_params));
+	new_pdfr = snd_wss_get_format(chip, params_format(hw_params),
+				params_channels(hw_params)) |
+				snd_wss_get_rate(params_rate(hw_params));
 	chip->set_playback_format(chip, hw_params, new_pdfr);
 	return 0;
 }
 
-static int snd_cs4231_playback_hw_free(struct snd_pcm_substream *substream)
+static int snd_wss_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static int snd_cs4231_playback_prepare(struct snd_pcm_substream *substream)
+static int snd_wss_playback_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned long flags;
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
@@ -877,39 +958,40 @@ static int snd_cs4231_playback_prepare(s
 	chip->p_dma_size = size;
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO);
 	snd_dma_program(chip->dma1, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
-	count = snd_cs4231_get_count(chip->image[CS4231_PLAYBK_FORMAT], count) - 1;
-	snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, (unsigned char) count);
-	snd_cs4231_out(chip, CS4231_PLY_UPR_CNT, (unsigned char) (count >> 8));
+	count = snd_wss_get_count(chip->image[CS4231_PLAYBK_FORMAT], count) - 1;
+	snd_wss_out(chip, CS4231_PLY_LWR_CNT, (unsigned char) count);
+	snd_wss_out(chip, CS4231_PLY_UPR_CNT, (unsigned char) (count >> 8));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 #if 0
-	snd_cs4231_debug(chip);
+	snd_wss_debug(chip);
 #endif
 	return 0;
 }
 
-static int snd_cs4231_capture_hw_params(struct snd_pcm_substream *substream,
+static int snd_wss_capture_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	unsigned char new_cdfr;
 	int err;
 
 	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
 		return err;
-	new_cdfr = snd_cs4231_get_format(chip, params_format(hw_params), params_channels(hw_params)) |
-		   snd_cs4231_get_rate(params_rate(hw_params));
+	new_cdfr = snd_wss_get_format(chip, params_format(hw_params),
+			   params_channels(hw_params)) |
+			   snd_wss_get_rate(params_rate(hw_params));
 	chip->set_capture_format(chip, hw_params, new_cdfr);
 	return 0;
 }
 
-static int snd_cs4231_capture_hw_free(struct snd_pcm_substream *substream)
+static int snd_wss_capture_hw_free(struct snd_pcm_substream *substream)
 {
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static int snd_cs4231_capture_prepare(struct snd_pcm_substream *substream)
+static int snd_wss_capture_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned long flags;
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
@@ -919,49 +1001,52 @@ static int snd_cs4231_capture_prepare(st
 	chip->c_dma_size = size;
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_RECORD_ENABLE | CS4231_RECORD_PIO);
 	snd_dma_program(chip->dma2, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
-	count = snd_cs4231_get_count(chip->image[CS4231_REC_FORMAT], count) - 1;
-	if (chip->single_dma && chip->hardware != CS4231_HW_INTERWAVE) {
-		snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, (unsigned char) count);
-		snd_cs4231_out(chip, CS4231_PLY_UPR_CNT, (unsigned char) (count >> 8));
+	count = snd_wss_get_count(chip->image[CS4231_REC_FORMAT], count) - 1;
+	if (chip->single_dma && chip->hardware != WSS_HW_INTERWAVE) {
+		snd_wss_out(chip, CS4231_PLY_LWR_CNT, (unsigned char) count);
+		snd_wss_out(chip, CS4231_PLY_UPR_CNT,
+			    (unsigned char) (count >> 8));
 	} else {
-		snd_cs4231_out(chip, CS4231_REC_LWR_CNT, (unsigned char) count);
-		snd_cs4231_out(chip, CS4231_REC_UPR_CNT, (unsigned char) (count >> 8));
+		snd_wss_out(chip, CS4231_REC_LWR_CNT, (unsigned char) count);
+		snd_wss_out(chip, CS4231_REC_UPR_CNT,
+			    (unsigned char) (count >> 8));
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return 0;
 }
 
-void snd_cs4231_overrange(struct snd_cs4231 *chip)
+void snd_wss_overrange(struct snd_wss *chip)
 {
 	unsigned long flags;
 	unsigned char res;
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	res = snd_cs4231_in(chip, CS4231_TEST_INIT);
+	res = snd_wss_in(chip, CS4231_TEST_INIT);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	if (res & (0x08 | 0x02))	/* detect overrange only above 0dB; may be user selectable? */
 		chip->capture_substream->runtime->overrange++;
 }
+EXPORT_SYMBOL(snd_wss_overrange);
 
-irqreturn_t snd_cs4231_interrupt(int irq, void *dev_id)
+irqreturn_t snd_wss_interrupt(int irq, void *dev_id)
 {
-	struct snd_cs4231 *chip = dev_id;
+	struct snd_wss *chip = dev_id;
 	unsigned char status;
 
-	status = snd_cs4231_in(chip, CS4231_IRQ_STATUS);
+	status = snd_wss_in(chip, CS4231_IRQ_STATUS);
 	if (status & CS4231_TIMER_IRQ) {
 		if (chip->timer)
 			snd_timer_interrupt(chip->timer, chip->timer->sticks);
 	}		
-	if (chip->single_dma && chip->hardware != CS4231_HW_INTERWAVE) {
+	if (chip->single_dma && chip->hardware != WSS_HW_INTERWAVE) {
 		if (status & CS4231_PLAYBACK_IRQ) {
-			if (chip->mode & CS4231_MODE_PLAY) {
+			if (chip->mode & WSS_MODE_PLAY) {
 				if (chip->playback_substream)
 					snd_pcm_period_elapsed(chip->playback_substream);
 			}
-			if (chip->mode & CS4231_MODE_RECORD) {
+			if (chip->mode & WSS_MODE_RECORD) {
 				if (chip->capture_substream) {
-					snd_cs4231_overrange(chip);
+					snd_wss_overrange(chip);
 					snd_pcm_period_elapsed(chip->capture_substream);
 				}
 			}
@@ -973,21 +1058,23 @@ irqreturn_t snd_cs4231_interrupt(int irq
 		}
 		if (status & CS4231_RECORD_IRQ) {
 			if (chip->capture_substream) {
-				snd_cs4231_overrange(chip);
+				snd_wss_overrange(chip);
 				snd_pcm_period_elapsed(chip->capture_substream);
 			}
 		}
 	}
 
 	spin_lock(&chip->reg_lock);
-	snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
+	snd_wss_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
 	spin_unlock(&chip->reg_lock);
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(snd_wss_interrupt);
 
-static snd_pcm_uframes_t snd_cs4231_playback_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t snd_wss_playback_pointer
+		(struct snd_pcm_substream *substream)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
 
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE))
@@ -996,9 +1083,10 @@ static snd_pcm_uframes_t snd_cs4231_play
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-static snd_pcm_uframes_t snd_cs4231_capture_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t snd_wss_capture_pointer
+		(struct snd_pcm_substream *substream)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
 	
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE))
@@ -1011,7 +1099,7 @@ static snd_pcm_uframes_t snd_cs4231_capt
 
  */
 
-static int snd_cs4231_probe(struct snd_cs4231 *chip)
+static int snd_wss_probe(struct snd_wss *chip)
 {
 	unsigned long flags;
 	int i, id, rev;
@@ -1019,103 +1107,104 @@ static int snd_cs4231_probe(struct snd_c
 	unsigned int hw;
 
 #if 0
-	snd_cs4231_debug(chip);
+	snd_wss_debug(chip);
 #endif
 	id = 0;
 	for (i = 0; i < 50; i++) {
 		mb();
-		if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+		if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 			udelay(2000);
 		else {
 			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_cs4231_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
-			id = snd_cs4231_in(chip, CS4231_MISC_INFO) & 0x0f;
+			snd_wss_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
+			id = snd_wss_in(chip, CS4231_MISC_INFO) & 0x0f;
 			spin_unlock_irqrestore(&chip->reg_lock, flags);
 			if (id == 0x0a)
 				break;	/* this is valid value */
 		}
 	}
-	snd_printdd("cs4231: port = 0x%lx, id = 0x%x\n", chip->port, id);
+	snd_printdd("wss: port = 0x%lx, id = 0x%x\n", chip->port, id);
 	if (id != 0x0a)
 		return -ENODEV;	/* no valid device found */
 
-	if (((hw = chip->hardware) & CS4231_HW_TYPE_MASK) == CS4231_HW_DETECT) {
-		rev = snd_cs4231_in(chip, CS4231_VERSION) & 0xe7;
+	hw = chip->hardware;
+	if ((hw & WSS_HW_TYPE_MASK) == WSS_HW_DETECT) {
+		rev = snd_wss_in(chip, CS4231_VERSION) & 0xe7;
 		snd_printdd("CS4231: VERSION (I25) = 0x%x\n", rev);
 		if (rev == 0x80) {
-			unsigned char tmp = snd_cs4231_in(chip, 23);
-			snd_cs4231_out(chip, 23, ~tmp);
-			if (snd_cs4231_in(chip, 23) != tmp)
-				chip->hardware = CS4231_HW_AD1845;
+			unsigned char tmp = snd_wss_in(chip, 23);
+			snd_wss_out(chip, 23, ~tmp);
+			if (snd_wss_in(chip, 23) != tmp)
+				chip->hardware = WSS_HW_AD1845;
 			else
-				chip->hardware = CS4231_HW_CS4231;
+				chip->hardware = WSS_HW_CS4231;
 		} else if (rev == 0xa0) {
-			chip->hardware = CS4231_HW_CS4231A;
+			chip->hardware = WSS_HW_CS4231A;
 		} else if (rev == 0xa2) {
-			chip->hardware = CS4231_HW_CS4232;
+			chip->hardware = WSS_HW_CS4232;
 		} else if (rev == 0xb2) {
-			chip->hardware = CS4231_HW_CS4232A;
+			chip->hardware = WSS_HW_CS4232A;
 		} else if (rev == 0x83) {
-			chip->hardware = CS4231_HW_CS4236;
+			chip->hardware = WSS_HW_CS4236;
 		} else if (rev == 0x03) {
-			chip->hardware = CS4231_HW_CS4236B;
+			chip->hardware = WSS_HW_CS4236B;
 		} else {
 			snd_printk("unknown CS chip with version 0x%x\n", rev);
 			return -ENODEV;		/* unknown CS4231 chip? */
 		}
 	}
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	cs4231_inb(chip, CS4231P(STATUS));	/* clear any pendings IRQ */
-	cs4231_outb(chip, CS4231P(STATUS), 0);
+	wss_inb(chip, CS4231P(STATUS));	/* clear any pendings IRQ */
+	wss_outb(chip, CS4231P(STATUS), 0);
 	mb();
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	chip->image[CS4231_MISC_INFO] = CS4231_MODE2;
 	switch (chip->hardware) {
-	case CS4231_HW_INTERWAVE:
+	case WSS_HW_INTERWAVE:
 		chip->image[CS4231_MISC_INFO] = CS4231_IW_MODE3;
 		break;
-	case CS4231_HW_CS4235:
-	case CS4231_HW_CS4236B:
-	case CS4231_HW_CS4237B:
-	case CS4231_HW_CS4238B:
-	case CS4231_HW_CS4239:
-		if (hw == CS4231_HW_DETECT3)
+	case WSS_HW_CS4235:
+	case WSS_HW_CS4236B:
+	case WSS_HW_CS4237B:
+	case WSS_HW_CS4238B:
+	case WSS_HW_CS4239:
+		if (hw == WSS_HW_DETECT3)
 			chip->image[CS4231_MISC_INFO] = CS4231_4236_MODE3;
 		else
-			chip->hardware = CS4231_HW_CS4236;
+			chip->hardware = WSS_HW_CS4236;
 		break;
 	}
 
 	chip->image[CS4231_IFACE_CTRL] =
 	    (chip->image[CS4231_IFACE_CTRL] & ~CS4231_SINGLE_DMA) |
 	    (chip->single_dma ? CS4231_SINGLE_DMA : 0);
-	if (chip->hardware != CS4231_HW_OPTI93X) {
+	if (chip->hardware != WSS_HW_OPTI93X) {
 		chip->image[CS4231_ALT_FEATURE_1] = 0x80;
 		chip->image[CS4231_ALT_FEATURE_2] =
-			chip->hardware == CS4231_HW_INTERWAVE ? 0xc2 : 0x01;
+			chip->hardware == WSS_HW_INTERWAVE ? 0xc2 : 0x01;
 	}
 	ptr = (unsigned char *) &chip->image;
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	for (i = 0; i < 32; i++)	/* ok.. fill all CS4231 registers */
-		snd_cs4231_out(chip, i, *ptr++);
+		snd_wss_out(chip, i, *ptr++);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_up(chip);
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_up(chip);
+	snd_wss_mce_down(chip);
 
 	mdelay(2);
 
 	/* ok.. try check hardware version for CS4236+ chips */
-	if ((hw & CS4231_HW_TYPE_MASK) == CS4231_HW_DETECT) {
-		if (chip->hardware == CS4231_HW_CS4236B) {
+	if ((hw & WSS_HW_TYPE_MASK) == WSS_HW_DETECT) {
+		if (chip->hardware == WSS_HW_CS4236B) {
 			rev = snd_cs4236_ext_in(chip, CS4236_VERSION);
 			snd_cs4236_ext_out(chip, CS4236_VERSION, 0xff);
 			id = snd_cs4236_ext_in(chip, CS4236_VERSION);
 			snd_cs4236_ext_out(chip, CS4236_VERSION, rev);
 			snd_printdd("CS4231: ext version; rev = 0x%x, id = 0x%x\n", rev, id);
 			if ((id & 0x1f) == 0x1d) {	/* CS4235 */
-				chip->hardware = CS4231_HW_CS4235;
+				chip->hardware = WSS_HW_CS4235;
 				switch (id >> 5) {
 				case 4:
 				case 5:
@@ -1130,13 +1219,13 @@ static int snd_cs4231_probe(struct snd_c
 				case 5:
 				case 6:
 				case 7:
-					chip->hardware = CS4231_HW_CS4236B;
+					chip->hardware = WSS_HW_CS4236B;
 					break;
 				default:
 					snd_printk("unknown CS4236 chip (enhanced version = 0x%x)\n", id);
 				}
 			} else if ((id & 0x1f) == 0x08) {	/* CS4237B */
-				chip->hardware = CS4231_HW_CS4237B;
+				chip->hardware = WSS_HW_CS4237B;
 				switch (id >> 5) {
 				case 4:
 				case 5:
@@ -1147,7 +1236,7 @@ static int snd_cs4231_probe(struct snd_c
 					snd_printk("unknown CS4237B chip (enhanced version = 0x%x)\n", id);
 				}
 			} else if ((id & 0x1f) == 0x09) {	/* CS4238B */
-				chip->hardware = CS4231_HW_CS4238B;
+				chip->hardware = WSS_HW_CS4238B;
 				switch (id >> 5) {
 				case 5:
 				case 6:
@@ -1157,7 +1246,7 @@ static int snd_cs4231_probe(struct snd_c
 					snd_printk("unknown CS4238B chip (enhanced version = 0x%x)\n", id);
 				}
 			} else if ((id & 0x1f) == 0x1e) {	/* CS4239 */
-				chip->hardware = CS4231_HW_CS4239;
+				chip->hardware = WSS_HW_CS4239;
 				switch (id >> 5) {
 				case 4:
 				case 5:
@@ -1178,7 +1267,7 @@ static int snd_cs4231_probe(struct snd_c
 
  */
 
-static struct snd_pcm_hardware snd_cs4231_playback =
+static struct snd_pcm_hardware snd_wss_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -1199,7 +1288,7 @@ static struct snd_pcm_hardware snd_cs423
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_cs4231_capture =
+static struct snd_pcm_hardware snd_wss_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -1224,21 +1313,21 @@ static struct snd_pcm_hardware snd_cs423
 
  */
 
-static int snd_cs4231_playback_open(struct snd_pcm_substream *substream)
+static int snd_wss_playback_open(struct snd_pcm_substream *substream)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	runtime->hw = snd_cs4231_playback;
+	runtime->hw = snd_wss_playback;
 
 	/* hardware bug in InterWave chipset */
-	if (chip->hardware == CS4231_HW_INTERWAVE && chip->dma1 > 3)
+	if (chip->hardware == WSS_HW_INTERWAVE && chip->dma1 > 3)
 	    	runtime->hw.formats &= ~SNDRV_PCM_FMTBIT_MU_LAW;
 	
 	/* hardware limitation of cheap chips */
-	if (chip->hardware == CS4231_HW_CS4235 ||
-	    chip->hardware == CS4231_HW_CS4239)
+	if (chip->hardware == WSS_HW_CS4235 ||
+	    chip->hardware == WSS_HW_CS4239)
 		runtime->hw.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE;
 
 	snd_pcm_limit_isa_dma_size(chip->dma1, &runtime->hw.buffer_bytes_max);
@@ -1249,7 +1338,8 @@ static int snd_cs4231_playback_open(stru
 			return err;
 	}
 
-	if ((err = snd_cs4231_open(chip, CS4231_MODE_PLAY)) < 0) {
+	err = snd_wss_open(chip, WSS_MODE_PLAY);
+	if (err < 0) {
 		if (chip->release_dma)
 			chip->release_dma(chip, chip->dma_private_data, chip->dma1);
 		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
@@ -1261,17 +1351,17 @@ static int snd_cs4231_playback_open(stru
 	return 0;
 }
 
-static int snd_cs4231_capture_open(struct snd_pcm_substream *substream)
+static int snd_wss_capture_open(struct snd_pcm_substream *substream)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	runtime->hw = snd_cs4231_capture;
+	runtime->hw = snd_wss_capture;
 
 	/* hardware limitation of cheap chips */
-	if (chip->hardware == CS4231_HW_CS4235 ||
-	    chip->hardware == CS4231_HW_CS4239)
+	if (chip->hardware == WSS_HW_CS4235 ||
+	    chip->hardware == WSS_HW_CS4239)
 		runtime->hw.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE;
 
 	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.buffer_bytes_max);
@@ -1282,7 +1372,8 @@ static int snd_cs4231_capture_open(struc
 			return err;
 	}
 
-	if ((err = snd_cs4231_open(chip, CS4231_MODE_RECORD)) < 0) {
+	err = snd_wss_open(chip, WSS_MODE_RECORD);
+	if (err < 0) {
 		if (chip->release_dma)
 			chip->release_dma(chip, chip->dma_private_data, chip->dma2);
 		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
@@ -1294,28 +1385,28 @@ static int snd_cs4231_capture_open(struc
 	return 0;
 }
 
-static int snd_cs4231_playback_close(struct snd_pcm_substream *substream)
+static int snd_wss_playback_close(struct snd_pcm_substream *substream)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 
 	chip->playback_substream = NULL;
-	snd_cs4231_close(chip, CS4231_MODE_PLAY);
+	snd_wss_close(chip, WSS_MODE_PLAY);
 	return 0;
 }
 
-static int snd_cs4231_capture_close(struct snd_pcm_substream *substream)
+static int snd_wss_capture_close(struct snd_pcm_substream *substream)
 {
-	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
+	struct snd_wss *chip = snd_pcm_substream_chip(substream);
 
 	chip->capture_substream = NULL;
-	snd_cs4231_close(chip, CS4231_MODE_RECORD);
+	snd_wss_close(chip, WSS_MODE_RECORD);
 	return 0;
 }
 
 #ifdef CONFIG_PM
 
 /* lowlevel suspend callback for CS4231 */
-static void snd_cs4231_suspend(struct snd_cs4231 *chip)
+static void snd_wss_suspend(struct snd_wss *chip)
 {
 	int reg;
 	unsigned long flags;
@@ -1323,67 +1414,68 @@ static void snd_cs4231_suspend(struct sn
 	snd_pcm_suspend_all(chip->pcm);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	for (reg = 0; reg < 32; reg++)
-		chip->image[reg] = snd_cs4231_in(chip, reg);
+		chip->image[reg] = snd_wss_in(chip, reg);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
 /* lowlevel resume callback for CS4231 */
-static void snd_cs4231_resume(struct snd_cs4231 *chip)
+static void snd_wss_resume(struct snd_wss *chip)
 {
 	int reg;
 	unsigned long flags;
 	/* int timeout; */
 	
-	snd_cs4231_mce_up(chip);
+	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	for (reg = 0; reg < 32; reg++) {
 		switch (reg) {
 		case CS4231_VERSION:
 			break;
 		default:
-			snd_cs4231_out(chip, reg, chip->image[reg]);
+			snd_wss_out(chip, reg, chip->image[reg]);
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 #if 1
-	snd_cs4231_mce_down(chip);
+	snd_wss_mce_down(chip);
 #else
 	/* The following is a workaround to avoid freeze after resume on TP600E.
-	   This is the first half of copy of snd_cs4231_mce_down(), but doesn't
+	   This is the first half of copy of snd_wss_mce_down(), but doesn't
 	   include rescheduling.  -- iwai
 	   */
-	snd_cs4231_busy_wait(chip);
+	snd_wss_busy_wait(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	chip->mce_bit &= ~CS4231_MCE;
-	timeout = cs4231_inb(chip, CS4231P(REGSEL));
-	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | (timeout & 0x1f));
+	timeout = wss_inb(chip, CS4231P(REGSEL));
+	wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | (timeout & 0x1f));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	if (timeout == 0x80)
 		snd_printk("down [0x%lx]: serious init problem - codec still busy\n", chip->port);
 	if ((timeout & CS4231_MCE) == 0 ||
-	    !(chip->hardware & (CS4231_HW_CS4231_MASK | CS4231_HW_CS4232_MASK))) {
+	    !(chip->hardware & (WSS_HW_CS4231_MASK | WSS_HW_CS4232_MASK))) {
 		return;
 	}
-	snd_cs4231_busy_wait(chip);
+	snd_wss_busy_wait(chip);
 #endif
 }
 #endif /* CONFIG_PM */
 
-static int snd_cs4231_free(struct snd_cs4231 *chip)
+static int snd_wss_free(struct snd_wss *chip)
 {
 	release_and_free_resource(chip->res_port);
 	release_and_free_resource(chip->res_cport);
 	if (chip->irq >= 0) {
 		disable_irq(chip->irq);
-		if (!(chip->hwshare & CS4231_HWSHARE_IRQ))
+		if (!(chip->hwshare & WSS_HWSHARE_IRQ))
 			free_irq(chip->irq, (void *) chip);
 	}
-	if (!(chip->hwshare & CS4231_HWSHARE_DMA1) && chip->dma1 >= 0) {
+	if (!(chip->hwshare & WSS_HWSHARE_DMA1) && chip->dma1 >= 0) {
 		snd_dma_disable(chip->dma1);
 		free_dma(chip->dma1);
 	}
-	if (!(chip->hwshare & CS4231_HWSHARE_DMA2) && chip->dma2 >= 0 && chip->dma2 != chip->dma1) {
+	if (!(chip->hwshare & WSS_HWSHARE_DMA2) &&
+	    chip->dma2 >= 0 && chip->dma2 != chip->dma1) {
 		snd_dma_disable(chip->dma2);
 		free_dma(chip->dma2);
 	}
@@ -1393,39 +1485,40 @@ static int snd_cs4231_free(struct snd_cs
 	return 0;
 }
 
-static int snd_cs4231_dev_free(struct snd_device *device)
+static int snd_wss_dev_free(struct snd_device *device)
 {
-	struct snd_cs4231 *chip = device->device_data;
-	return snd_cs4231_free(chip);	
+	struct snd_wss *chip = device->device_data;
+	return snd_wss_free(chip);
 }
 
-const char *snd_cs4231_chip_id(struct snd_cs4231 *chip)
+const char *snd_wss_chip_id(struct snd_wss *chip)
 {
 	switch (chip->hardware) {
-	case CS4231_HW_CS4231:	return "CS4231";
-	case CS4231_HW_CS4231A: return "CS4231A";
-	case CS4231_HW_CS4232:	return "CS4232";
-	case CS4231_HW_CS4232A:	return "CS4232A";
-	case CS4231_HW_CS4235:	return "CS4235";
-	case CS4231_HW_CS4236:  return "CS4236";
-	case CS4231_HW_CS4236B: return "CS4236B";
-	case CS4231_HW_CS4237B: return "CS4237B";
-	case CS4231_HW_CS4238B: return "CS4238B";
-	case CS4231_HW_CS4239:	return "CS4239";
-	case CS4231_HW_INTERWAVE: return "AMD InterWave";
-	case CS4231_HW_OPL3SA2: return chip->card->shortname;
-	case CS4231_HW_AD1845: return "AD1845";
-	case CS4231_HW_OPTI93X: return "OPTi 93x";
+	case WSS_HW_CS4231:	return "CS4231";
+	case WSS_HW_CS4231A: return "CS4231A";
+	case WSS_HW_CS4232:	return "CS4232";
+	case WSS_HW_CS4232A:	return "CS4232A";
+	case WSS_HW_CS4235:	return "CS4235";
+	case WSS_HW_CS4236:  return "CS4236";
+	case WSS_HW_CS4236B: return "CS4236B";
+	case WSS_HW_CS4237B: return "CS4237B";
+	case WSS_HW_CS4238B: return "CS4238B";
+	case WSS_HW_CS4239:	return "CS4239";
+	case WSS_HW_INTERWAVE: return "AMD InterWave";
+	case WSS_HW_OPL3SA2: return chip->card->shortname;
+	case WSS_HW_AD1845: return "AD1845";
+	case WSS_HW_OPTI93X: return "OPTi 93x";
 	default: return "???";
 	}
 }
+EXPORT_SYMBOL(snd_wss_chip_id);
 
-static int snd_cs4231_new(struct snd_card *card,
+static int snd_wss_new(struct snd_card *card,
 			  unsigned short hardware,
 			  unsigned short hwshare,
-			  struct snd_cs4231 ** rchip)
+			  struct snd_wss **rchip)
 {
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 
 	*rchip = NULL;
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -1438,35 +1531,35 @@ static int snd_cs4231_new(struct snd_car
 	mutex_init(&chip->mce_mutex);
 	mutex_init(&chip->open_mutex);
 	chip->card = card;
-	chip->rate_constraint = snd_cs4231_xrate;
-	chip->set_playback_format = snd_cs4231_playback_format;
-	chip->set_capture_format = snd_cs4231_capture_format;
-	if (chip->hardware == CS4231_HW_OPTI93X)
+	chip->rate_constraint = snd_wss_xrate;
+	chip->set_playback_format = snd_wss_playback_format;
+	chip->set_capture_format = snd_wss_capture_format;
+	if (chip->hardware == WSS_HW_OPTI93X)
 		memcpy(&chip->image, &snd_opti93x_original_image,
 		       sizeof(snd_opti93x_original_image));
 	else
-		memcpy(&chip->image, &snd_cs4231_original_image,
-		       sizeof(snd_cs4231_original_image));
+		memcpy(&chip->image, &snd_wss_original_image,
+		       sizeof(snd_wss_original_image));
 
-        *rchip = chip;
-        return 0;
+	*rchip = chip;
+	return 0;
 }
 
-int snd_cs4231_create(struct snd_card *card,
-	              unsigned long port,
-	              unsigned long cport,
+int snd_wss_create(struct snd_card *card,
+		      unsigned long port,
+		      unsigned long cport,
 		      int irq, int dma1, int dma2,
 		      unsigned short hardware,
 		      unsigned short hwshare,
-		      struct snd_cs4231 ** rchip)
+		      struct snd_wss **rchip)
 {
 	static struct snd_device_ops ops = {
-		.dev_free =	snd_cs4231_dev_free,
+		.dev_free =	snd_wss_dev_free,
 	};
-	struct snd_cs4231 *chip;
+	struct snd_wss *chip;
 	int err;
 
-	err = snd_cs4231_new(card, hardware, hwshare, &chip);
+	err = snd_wss_new(card, hardware, hwshare, &chip);
 	if (err < 0)
 		return err;
 	
@@ -1475,32 +1568,36 @@ int snd_cs4231_create(struct snd_card *c
 	chip->dma2 = -1;
 
 	if ((chip->res_port = request_region(port, 4, "CS4231")) == NULL) {
-		snd_printk(KERN_ERR "cs4231: can't grab port 0x%lx\n", port);
-		snd_cs4231_free(chip);
+		snd_printk(KERN_ERR "wss: can't grab port 0x%lx\n", port);
+		snd_wss_free(chip);
 		return -EBUSY;
 	}
 	chip->port = port;
 	if ((long)cport >= 0 && (chip->res_cport = request_region(cport, 8, "CS4232 Control")) == NULL) {
-		snd_printk(KERN_ERR "cs4231: can't grab control port 0x%lx\n", cport);
-		snd_cs4231_free(chip);
+		snd_printk(KERN_ERR
+			   "wss: can't grab control port 0x%lx\n", cport);
+		snd_wss_free(chip);
 		return -ENODEV;
 	}
 	chip->cport = cport;
-	if (!(hwshare & CS4231_HWSHARE_IRQ) && request_irq(irq, snd_cs4231_interrupt, IRQF_DISABLED, "CS4231", (void *) chip)) {
-		snd_printk(KERN_ERR "cs4231: can't grab IRQ %d\n", irq);
-		snd_cs4231_free(chip);
-		return -EBUSY;
-	}
+	if (!(hwshare & WSS_HWSHARE_IRQ))
+		if (request_irq(irq, snd_wss_interrupt, IRQF_DISABLED,
+				"CS4231", (void *) chip)) {
+			snd_printk(KERN_ERR "wss: can't grab IRQ %d\n", irq);
+			snd_wss_free(chip);
+			return -EBUSY;
+		}
 	chip->irq = irq;
-	if (!(hwshare & CS4231_HWSHARE_DMA1) && request_dma(dma1, "CS4231 - 1")) {
-		snd_printk(KERN_ERR "cs4231: can't grab DMA1 %d\n", dma1);
-		snd_cs4231_free(chip);
+	if (!(hwshare & WSS_HWSHARE_DMA1) && request_dma(dma1, "CS4231 - 1")) {
+		snd_printk(KERN_ERR "wss: can't grab DMA1 %d\n", dma1);
+		snd_wss_free(chip);
 		return -EBUSY;
 	}
 	chip->dma1 = dma1;
-	if (!(hwshare & CS4231_HWSHARE_DMA2) && dma1 != dma2 && dma2 >= 0 && request_dma(dma2, "CS4231 - 2")) {
-		snd_printk(KERN_ERR "cs4231: can't grab DMA2 %d\n", dma2);
-		snd_cs4231_free(chip);
+	if (!(hwshare & WSS_HWSHARE_DMA2) && dma1 != dma2 &&
+	      dma2 >= 0 && request_dma(dma2, "CS4231 - 2")) {
+		snd_printk(KERN_ERR "wss: can't grab DMA2 %d\n", dma2);
+		snd_wss_free(chip);
 		return -EBUSY;
 	}
 	if (dma1 == dma2 || dma2 < 0) {
@@ -1510,14 +1607,14 @@ int snd_cs4231_create(struct snd_card *c
 		chip->dma2 = dma2;
 
 	/* global setup */
-	if (snd_cs4231_probe(chip) < 0) {
-		snd_cs4231_free(chip);
+	if (snd_wss_probe(chip) < 0) {
+		snd_wss_free(chip);
 		return -ENODEV;
 	}
-	snd_cs4231_init(chip);
+	snd_wss_init(chip);
 
 #if 0
-	if (chip->hardware & CS4231_HW_CS4232_MASK) {
+	if (chip->hardware & WSS_HW_CS4232_MASK) {
 		if (chip->res_cport == NULL)
 			snd_printk("CS4232 control port features are not accessible\n");
 	}
@@ -1525,43 +1622,44 @@ int snd_cs4231_create(struct snd_card *c
 
 	/* Register device */
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_cs4231_free(chip);
+		snd_wss_free(chip);
 		return err;
 	}
 
 #ifdef CONFIG_PM
 	/* Power Management */
-	chip->suspend = snd_cs4231_suspend;
-	chip->resume = snd_cs4231_resume;
+	chip->suspend = snd_wss_suspend;
+	chip->resume = snd_wss_resume;
 #endif
 
 	*rchip = chip;
 	return 0;
 }
+EXPORT_SYMBOL(snd_wss_create);
 
-static struct snd_pcm_ops snd_cs4231_playback_ops = {
-	.open =		snd_cs4231_playback_open,
-	.close =	snd_cs4231_playback_close,
+static struct snd_pcm_ops snd_wss_playback_ops = {
+	.open =		snd_wss_playback_open,
+	.close =	snd_wss_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_cs4231_playback_hw_params,
-	.hw_free =	snd_cs4231_playback_hw_free,
-	.prepare =	snd_cs4231_playback_prepare,
-	.trigger =	snd_cs4231_trigger,
-	.pointer =	snd_cs4231_playback_pointer,
+	.hw_params =	snd_wss_playback_hw_params,
+	.hw_free =	snd_wss_playback_hw_free,
+	.prepare =	snd_wss_playback_prepare,
+	.trigger =	snd_wss_trigger,
+	.pointer =	snd_wss_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_cs4231_capture_ops = {
-	.open =		snd_cs4231_capture_open,
-	.close =	snd_cs4231_capture_close,
+static struct snd_pcm_ops snd_wss_capture_ops = {
+	.open =		snd_wss_capture_open,
+	.close =	snd_wss_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_cs4231_capture_hw_params,
-	.hw_free =	snd_cs4231_capture_hw_free,
-	.prepare =	snd_cs4231_capture_prepare,
-	.trigger =	snd_cs4231_trigger,
-	.pointer =	snd_cs4231_capture_pointer,
+	.hw_params =	snd_wss_capture_hw_params,
+	.hw_free =	snd_wss_capture_hw_free,
+	.prepare =	snd_wss_capture_prepare,
+	.trigger =	snd_wss_trigger,
+	.pointer =	snd_wss_capture_pointer,
 };
 
-int snd_cs4231_pcm(struct snd_cs4231 *chip, int device, struct snd_pcm **rpcm)
+int snd_wss_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1573,17 +1671,17 @@ int snd_cs4231_pcm(struct snd_cs4231 *ch
 	mutex_init(&chip->mce_mutex);
 	mutex_init(&chip->open_mutex);
 
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_cs4231_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_cs4231_capture_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_wss_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_wss_capture_ops);
 	
 	/* global setup */
 	pcm->private_data = chip;
 	pcm->info_flags = 0;
 	if (chip->single_dma)
 		pcm->info_flags |= SNDRV_PCM_INFO_HALF_DUPLEX;
-	if (chip->hardware != CS4231_HW_INTERWAVE)
+	if (chip->hardware != WSS_HW_INTERWAVE)
 		pcm->info_flags |= SNDRV_PCM_INFO_JOINT_DUPLEX;
-	strcpy(pcm->name, snd_cs4231_chip_id(chip));
+	strcpy(pcm->name, snd_wss_chip_id(chip));
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_isa_data(),
@@ -1594,14 +1692,15 @@ int snd_cs4231_pcm(struct snd_cs4231 *ch
 		*rpcm = pcm;
 	return 0;
 }
+EXPORT_SYMBOL(snd_wss_pcm);
 
-static void snd_cs4231_timer_free(struct snd_timer *timer)
+static void snd_wss_timer_free(struct snd_timer *timer)
 {
-	struct snd_cs4231 *chip = timer->private_data;
+	struct snd_wss *chip = timer->private_data;
 	chip->timer = NULL;
 }
 
-int snd_cs4231_timer(struct snd_cs4231 *chip, int device, struct snd_timer **rtimer)
+int snd_wss_timer(struct snd_wss *chip, int device, struct snd_timer **rtimer)
 {
 	struct snd_timer *timer;
 	struct snd_timer_id tid;
@@ -1615,21 +1714,23 @@ int snd_cs4231_timer(struct snd_cs4231 *
 	tid.subdevice = 0;
 	if ((err = snd_timer_new(chip->card, "CS4231", &tid, &timer)) < 0)
 		return err;
-	strcpy(timer->name, snd_cs4231_chip_id(chip));
+	strcpy(timer->name, snd_wss_chip_id(chip));
 	timer->private_data = chip;
-	timer->private_free = snd_cs4231_timer_free;
-	timer->hw = snd_cs4231_timer_table;
+	timer->private_free = snd_wss_timer_free;
+	timer->hw = snd_wss_timer_table;
 	chip->timer = timer;
 	if (rtimer)
 		*rtimer = timer;
 	return 0;
 }
+EXPORT_SYMBOL(snd_wss_timer);
 	
 /*
  *  MIXER part
  */
 
-static int snd_cs4231_info_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+static int snd_wss_info_mux(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[4] = {
 		"Line", "Aux", "Mic", "Mix"
@@ -1641,7 +1742,7 @@ static int snd_cs4231_info_mux(struct sn
 		"Line", "Synth", "Mic", "Mix"
 	};
 	char **ptexts = texts;
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 
 	snd_assert(chip->card != NULL, return -EINVAL);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -1652,16 +1753,17 @@ static int snd_cs4231_info_mux(struct sn
 	if (!strcmp(chip->card->driver, "GUS MAX"))
 		ptexts = gusmax_texts;
 	switch (chip->hardware) {
-	case CS4231_HW_INTERWAVE: ptexts = gusmax_texts; break;
-	case CS4231_HW_OPL3SA2: ptexts = opl3sa_texts; break;
+	case WSS_HW_INTERWAVE: ptexts = gusmax_texts; break;
+	case WSS_HW_OPL3SA2: ptexts = opl3sa_texts; break;
 	}
 	strcpy(uinfo->value.enumerated.name, ptexts[uinfo->value.enumerated.item]);
 	return 0;
 }
 
-static int snd_cs4231_get_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int snd_wss_get_mux(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
@@ -1671,9 +1773,10 @@ static int snd_cs4231_get_mux(struct snd
 	return 0;
 }
 
-static int snd_cs4231_put_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int snd_wss_put_mux(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	unsigned short left, right;
 	int change;
@@ -1687,14 +1790,15 @@ static int snd_cs4231_put_mux(struct snd
 	left = (chip->image[CS4231_LEFT_INPUT] & ~CS4231_MIXS_ALL) | left;
 	right = (chip->image[CS4231_RIGHT_INPUT] & ~CS4231_MIXS_ALL) | right;
 	change = left != chip->image[CS4231_LEFT_INPUT] ||
-	         right != chip->image[CS4231_RIGHT_INPUT];
-	snd_cs4231_out(chip, CS4231_LEFT_INPUT, left);
-	snd_cs4231_out(chip, CS4231_RIGHT_INPUT, right);
+		 right != chip->image[CS4231_RIGHT_INPUT];
+	snd_wss_out(chip, CS4231_LEFT_INPUT, left);
+	snd_wss_out(chip, CS4231_RIGHT_INPUT, right);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return change;
 }
 
-int snd_cs4231_info_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+int snd_wss_info_single(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
 {
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 
@@ -1704,10 +1808,12 @@ int snd_cs4231_info_single(struct snd_kc
 	uinfo->value.integer.max = mask;
 	return 0;
 }
+EXPORT_SYMBOL(snd_wss_info_single);
 
-int snd_cs4231_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+int snd_wss_get_single(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
@@ -1721,10 +1827,12 @@ int snd_cs4231_get_single(struct snd_kco
 		ucontrol->value.integer.value[0] = mask - ucontrol->value.integer.value[0];
 	return 0;
 }
+EXPORT_SYMBOL(snd_wss_get_single);
 
-int snd_cs4231_put_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+int snd_wss_put_single(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
@@ -1740,12 +1848,14 @@ int snd_cs4231_put_single(struct snd_kco
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	val = (chip->image[reg] & ~(mask << shift)) | val;
 	change = val != chip->image[reg];
-	snd_cs4231_out(chip, reg, val);
+	snd_wss_out(chip, reg, val);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return change;
 }
+EXPORT_SYMBOL(snd_wss_put_single);
 
-int snd_cs4231_info_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+int snd_wss_info_double(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
 {
 	int mask = (kcontrol->private_value >> 24) & 0xff;
 
@@ -1755,10 +1865,12 @@ int snd_cs4231_info_double(struct snd_kc
 	uinfo->value.integer.max = mask;
 	return 0;
 }
+EXPORT_SYMBOL(snd_wss_info_double);
 
-int snd_cs4231_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+int snd_wss_get_double(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int left_reg = kcontrol->private_value & 0xff;
 	int right_reg = (kcontrol->private_value >> 8) & 0xff;
@@ -1777,10 +1889,12 @@ int snd_cs4231_get_double(struct snd_kco
 	}
 	return 0;
 }
+EXPORT_SYMBOL(snd_wss_get_double);
 
-int snd_cs4231_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+int snd_wss_put_double(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int left_reg = kcontrol->private_value & 0xff;
 	int right_reg = (kcontrol->private_value >> 8) & 0xff;
@@ -1803,81 +1917,91 @@ int snd_cs4231_put_double(struct snd_kco
 	val1 = (chip->image[left_reg] & ~(mask << shift_left)) | val1;
 	val2 = (chip->image[right_reg] & ~(mask << shift_right)) | val2;
 	change = val1 != chip->image[left_reg] || val2 != chip->image[right_reg];
-	snd_cs4231_out(chip, left_reg, val1);
-	snd_cs4231_out(chip, right_reg, val2);
+	snd_wss_out(chip, left_reg, val1);
+	snd_wss_out(chip, right_reg, val2);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return change;
 }
+EXPORT_SYMBOL(snd_wss_put_double);
 
-static struct snd_kcontrol_new snd_cs4231_controls[] = {
-CS4231_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Playback Volume", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
-CS4231_DOUBLE("Line Playback Switch", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-CS4231_DOUBLE("Line Playback Volume", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
-CS4231_DOUBLE("Aux Playback Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("Aux Playback Switch", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_SINGLE("Mono Playback Switch", 0, CS4231_MONO_CTRL, 7, 1, 1),
-CS4231_SINGLE("Mono Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
-CS4231_SINGLE("Mono Output Playback Switch", 0, CS4231_MONO_CTRL, 6, 1, 1),
-CS4231_SINGLE("Mono Output Playback Bypass", 0, CS4231_MONO_CTRL, 5, 1, 0),
-CS4231_DOUBLE("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
+static struct snd_kcontrol_new snd_wss_controls[] = {
+WSS_DOUBLE("PCM Playback Switch", 0,
+	   CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
+WSS_DOUBLE("PCM Playback Volume", 0,
+	   CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+WSS_DOUBLE("Line Playback Switch", 0,
+	   CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
+WSS_DOUBLE("Line Playback Volume", 0,
+	   CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
+WSS_DOUBLE("Aux Playback Switch", 0,
+	   CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Aux Playback Volume", 0,
+	   CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE("Aux Playback Switch", 1,
+	   CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Aux Playback Volume", 1,
+	   CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_SINGLE("Mono Playback Switch", 0, CS4231_MONO_CTRL, 7, 1, 1),
+WSS_SINGLE("Mono Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
+WSS_SINGLE("Mono Output Playback Switch", 0, CS4231_MONO_CTRL, 6, 1, 1),
+WSS_SINGLE("Mono Output Playback Bypass", 0, CS4231_MONO_CTRL, 5, 1, 0),
+WSS_DOUBLE("Capture Volume", 0,
+	   CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Source",
-	.info = snd_cs4231_info_mux,
-	.get = snd_cs4231_get_mux,
-	.put = snd_cs4231_put_mux,
+	.info = snd_wss_info_mux,
+	.get = snd_wss_get_mux,
+	.put = snd_wss_put_mux,
 },
-CS4231_DOUBLE("Mic Boost", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
-CS4231_SINGLE("Loopback Capture Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
-CS4231_SINGLE("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1)
+WSS_DOUBLE("Mic Boost", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
+WSS_SINGLE("Loopback Capture Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
+WSS_SINGLE("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1)
 };
-                                        
+
 static struct snd_kcontrol_new snd_opti93x_controls[] = {
-CS4231_DOUBLE("Master Playback Switch", 0,
+WSS_DOUBLE("Master Playback Switch", 0,
 	      OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 7, 7, 1, 1),
-CS4231_DOUBLE("Master Playback Volume", 0,
+WSS_DOUBLE("Master Playback Volume", 0,
 	      OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1),
-CS4231_DOUBLE("PCM Playback Switch", 0,
+WSS_DOUBLE("PCM Playback Switch", 0,
 	      CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Playback Volume", 0,
+WSS_DOUBLE("PCM Playback Volume", 0,
 	      CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("FM Playback Switch", 0,
+WSS_DOUBLE("FM Playback Switch", 0,
 	      CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("FM Playback Volume", 0,
+WSS_DOUBLE("FM Playback Volume", 0,
 	      CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 1, 1, 15, 1),
-CS4231_DOUBLE("Line Playback Switch", 0,
+WSS_DOUBLE("Line Playback Switch", 0,
 	      CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-CS4231_DOUBLE("Line Playback Volume", 0,
+WSS_DOUBLE("Line Playback Volume", 0,
 	      CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 15, 1),
-CS4231_DOUBLE("Mic Playback Switch", 0,
+WSS_DOUBLE("Mic Playback Switch", 0,
 	      OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Mic Playback Volume", 0,
+WSS_DOUBLE("Mic Playback Volume", 0,
 	      OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 1, 1, 15, 1),
-CS4231_DOUBLE("Mic Boost", 0,
+WSS_DOUBLE("Mic Boost", 0,
 	      CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
-CS4231_DOUBLE("CD Playback Switch", 0,
+WSS_DOUBLE("CD Playback Switch", 0,
 	      CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("CD Playback Volume", 0,
+WSS_DOUBLE("CD Playback Volume", 0,
 	      CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 1, 1, 15, 1),
-CS4231_DOUBLE("Aux Playback Switch", 0,
+WSS_DOUBLE("Aux Playback Switch", 0,
 	      OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 0,
+WSS_DOUBLE("Aux Playback Volume", 0,
 	      OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 1, 1, 15, 1),
-CS4231_DOUBLE("Capture Volume", 0,
+WSS_DOUBLE("Capture Volume", 0,
 	      CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Source",
-	.info = snd_cs4231_info_mux,
-	.get = snd_cs4231_get_mux,
-	.put = snd_cs4231_put_mux,
+	.info = snd_wss_info_mux,
+	.get = snd_wss_get_mux,
+	.put = snd_wss_put_mux,
 }
 };
 
-int snd_cs4231_mixer(struct snd_cs4231 *chip)
+int snd_wss_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card;
 	unsigned int idx;
@@ -1889,7 +2013,7 @@ int snd_cs4231_mixer(struct snd_cs4231 *
 
 	strcpy(card->mixername, chip->pcm->name);
 
-	if (chip->hardware == CS4231_HW_OPTI93X)
+	if (chip->hardware == WSS_HW_OPTI93X)
 		for (idx = 0; idx < ARRAY_SIZE(snd_opti93x_controls); idx++) {
 			err = snd_ctl_add(card,
 					snd_ctl_new1(&snd_opti93x_controls[idx],
@@ -1898,48 +2022,29 @@ int snd_cs4231_mixer(struct snd_cs4231 *
 				return err;
 		}
 	else
-		for (idx = 0; idx < ARRAY_SIZE(snd_cs4231_controls); idx++) {
+		for (idx = 0; idx < ARRAY_SIZE(snd_wss_controls); idx++) {
 			err = snd_ctl_add(card,
-					snd_ctl_new1(&snd_cs4231_controls[idx],
+					snd_ctl_new1(&snd_wss_controls[idx],
 						     chip));
 			if (err < 0)
 				return err;
 		}
 	return 0;
 }
-
-EXPORT_SYMBOL(snd_cs4231_out);
-EXPORT_SYMBOL(snd_cs4231_in);
-EXPORT_SYMBOL(snd_cs4236_ext_out);
-EXPORT_SYMBOL(snd_cs4236_ext_in);
-EXPORT_SYMBOL(snd_cs4231_mce_up);
-EXPORT_SYMBOL(snd_cs4231_mce_down);
-EXPORT_SYMBOL(snd_cs4231_overrange);
-EXPORT_SYMBOL(snd_cs4231_interrupt);
-EXPORT_SYMBOL(snd_cs4231_chip_id);
-EXPORT_SYMBOL(snd_cs4231_create);
-EXPORT_SYMBOL(snd_cs4231_pcm);
-EXPORT_SYMBOL(snd_cs4231_mixer);
-EXPORT_SYMBOL(snd_cs4231_timer);
-EXPORT_SYMBOL(snd_cs4231_info_single);
-EXPORT_SYMBOL(snd_cs4231_get_single);
-EXPORT_SYMBOL(snd_cs4231_put_single);
-EXPORT_SYMBOL(snd_cs4231_info_double);
-EXPORT_SYMBOL(snd_cs4231_get_double);
-EXPORT_SYMBOL(snd_cs4231_put_double);
+EXPORT_SYMBOL(snd_wss_mixer);
 
 /*
  *  INIT part
  */
 
-static int __init alsa_cs4231_init(void)
+static int __init alsa_wss_init(void)
 {
 	return 0;
 }
 
-static void __exit alsa_cs4231_exit(void)
+static void __exit alsa_wss_exit(void)
 {
 }
 
-module_init(alsa_cs4231_init)
-module_exit(alsa_cs4231_exit)
+module_init(alsa_wss_init)
+module_exit(alsa_wss_exit)

----------------------------------------------------------------------
Masz czas tylko do 10 lipca.
Przystap on-line do ING OFE!
Sprawdz >> http://link.interia.pl/f1e54
