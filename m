From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Module parameters for SoundScape driver
Date: Mon, 14 Oct 2002 00:31:30 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210132331.g9DNVUnh001637@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have been hacking on the SoundScape driver again, and have now added support for the following
module parameters (assuming no "snd_" prefix):

index
id
port
irq
mpu_irq
dma

I haven't added the second DMA channel in yet because the driver couldn't do anything with it
even if I did. Anyway, people with purely ISA SoundScape cards can now (theoretically) load
this driver into any index between 0 and 7 with whatever parameters and ID name they choose.
If you don't specify any parameters and you have compiled in the ISA PnP support then the
driver will try and read configuration values off the bus.

I have tested this driver and it seems to load/unload/work OK without any trouble. The only
feature missing for a non-modular build is the ability to turn inactive hardware on; I'll add
that next.

Note: the main objective here was to be able to "modprobe snd-sscape index=???" and for the
driver to Just Work under ISA-PnP. A secondary concern was for the driver to not shoot itself
in the foot if I specified "modprobe snd-sscape port=xxx irq=yyy mpu_irq=zzz dma=qqq" instead.

If anyone out there has multiple SoundScape cards (rofl) then the driver should work for you too.

Cheers,
Chris


Index: sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/sscape.c,v
retrieving revision 1.8
diff -u -u -r1.8 sscape.c
--- sscape.c	8 Oct 2002 10:11:08 -0000	1.8
+++ sscape.c	13 Oct 2002 23:09:54 -0000
@@ -29,9 +29,9 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #ifndef LINUX_ISAPNP_H
-#include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
+#  include <linux/isapnp.h>
+#  define isapnp_card pci_bus
+#  define isapnp_dev pci_dev
 #endif
 #include <linux/spinlock.h>
 #include <asm/dma.h>
@@ -52,11 +52,36 @@
 MODULE_DESCRIPTION("ENSONIQ SoundScape PnP driver");
 MODULE_LICENSE("GPL");
 
-static int snd_index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
-
-MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_index, "Index number for this soundcard");
-MODULE_PARM_SYNTAX(snd_index, SNDRV_INDEX_DESC);
+static int __initdata index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char* __initdata id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static long __initdata port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = SNDRV_AUTO_PORT };
+static int __initdata irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int __initdata mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int __initdata dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+
+MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(index, "Index number for SoundScape soundcard");
+MODULE_PARM_SYNTAX(index, SNDRV_INDEX_DESC);
+
+MODULE_PARM(id, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
+MODULE_PARM_DESC(id, "Description for SoundScape card");
+MODULE_PARM_SYNTAX(id, SNDRV_ID_DESC);
+
+MODULE_PARM(port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
+MODULE_PARM_DESC(port, "Port # for SoundScape driver.");
+MODULE_PARM_SYNTAX(port, SNDRV_ENABLED);
+
+MODULE_PARM(irq, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(irq, "IRQ # for SoundScape driver.");
+MODULE_PARM_SYNTAX(irq, SNDRV_IRQ_DESC);
+
+MODULE_PARM(mpu_irq, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(mpu_irq, "MPU401 IRQ # for SoundScape driver.");
+MODULE_PARM_SYNTAX(mpu_irq, SNDRV_IRQ_DESC);
+
+MODULE_PARM(dma, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(dma, "DMA # for SoundScape driver.");
+MODULE_PARM_SYNTAX(dma, SNDRV_DMA8_DESC);
 
 static const struct isapnp_card_id sscape_pnpids[] __devinitdata = {
 	{ISAPNP_CARD_ID('E', 'N', 'S', 0x3081), .devs = {ISAPNP_DEVICE_ID('E', 'N', 'S', 0x0000)}},
@@ -66,7 +91,6 @@
 ISAPNP_CARD_TABLE(sscape_pnpids);
 
 static snd_card_t *sscape_card[SNDRV_CARDS];
-static unsigned __initdata sscape_count;
 
 
 #define MPU401_IO(i)     ((i) + 0)
@@ -130,8 +154,15 @@
 	int hw_in_use;
 	unsigned long midi_usage;
 	unsigned char midi_vol;
+
+#ifdef __ISAPNP__
+	struct isapnp_dev *isapnp;
+#endif
 };
 
+#define INVALID_IRQ  ((unsigned)-1)
+
+
 static inline struct soundscape *get_card_soundscape(snd_card_t * c)
 {
 	return (struct soundscape *) (c->private_data);
@@ -432,8 +463,8 @@
  * Upload a byte-stream into the SoundScape using DMA channel A.
  */
 static int upload_dma_data(struct soundscape *s,
-			   const unsigned char *data, unsigned long size,
-			   unsigned long dmasize)
+                           const unsigned char *data, unsigned long size,
+                           unsigned long dmasize)
 {
 	unsigned long flags;
 	struct dmabuf dma;
@@ -512,7 +543,7 @@
 		ret = -EAGAIN;
 	}
 
-      _release_dma:
+	_release_dma:
 	/*
 	 * NOTE!!! We are NOT holding any spinlocks at this point !!!
 	 */
@@ -569,7 +600,7 @@
  * userspace memory addresses.
  */
 static int sscape_upload_microcode(struct soundscape *sscape,
-				   const struct sscape_microcode *mc)
+                                   const struct sscape_microcode *mc)
 {
 	unsigned long flags;
 	int ret;
@@ -626,7 +657,7 @@
 }
 
 static int sscape_hw_ioctl(snd_hwdep_t * hw, struct file *file,
-			   unsigned int cmd, unsigned long arg)
+                           unsigned int cmd, unsigned long arg)
 {
 	struct soundscape *sscape = get_hwdep_soundscape(hw);
 	int err = -EBUSY;
@@ -686,7 +717,7 @@
  * Mixer control for the SoundScape's MIDI device.
  */
 static int sscape_midi_info(snd_kcontrol_t * ctl,
-			    snd_ctl_elem_info_t * uinfo)
+                            snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
@@ -696,7 +727,7 @@
 }
 
 static int sscape_midi_get(snd_kcontrol_t * kctl,
-			   snd_ctl_elem_value_t * uctl)
+                           snd_ctl_elem_value_t * uctl)
 {
 	cs4231_t *chip = snd_kcontrol_chip(kctl);
 	snd_card_t *card = chip->card;
@@ -716,7 +747,7 @@
 }
 
 static int sscape_midi_put(snd_kcontrol_t * kctl,
-			   snd_ctl_elem_value_t * uctl)
+                           snd_ctl_elem_value_t * uctl)
 {
 	cs4231_t *chip = snd_kcontrol_chip(kctl);
 	snd_card_t *card = chip->card;
@@ -777,9 +808,9 @@
 	for (cfg = 0; cfg < ARRAY_SIZE(valid_irq); ++cfg) {
 		if (irq == valid_irq[cfg])
 			return cfg;
-	}			/* for */
+	} /* for */
 
-	return 0xff;
+	return INVALID_IRQ;
 }
 
 
@@ -831,7 +862,7 @@
 	 */
 	retval = 1;
 
-      _done:
+	_done:
 	spin_unlock_irqrestore(&s->lock, flags);
 	return retval;
 }
@@ -889,10 +920,10 @@
 
 #define MPU401_SHARE_HARDWARE  1
 	if ((err = snd_mpu401_uart_new(card, devnum,
-				       MPU401_HW_MPU401,
-				       port, MPU401_SHARE_HARDWARE,
-				       irq, SA_INTERRUPT,
-				       &rawmidi)) == 0) {
+	                               MPU401_HW_MPU401,
+	                               port, MPU401_SHARE_HARDWARE,
+	                               irq, SA_INTERRUPT,
+	                               &rawmidi)) == 0) {
 		mpu401_t *mpu = (mpu401_t *) rawmidi->private_data;
 		mpu->open_input = mpu401_open;
 		mpu->open_output = mpu401_open;
@@ -1061,54 +1092,100 @@
 		strcpy(card->driver, "SoundScape");
 		strcpy(card->shortname, pcm->name);
 		snprintf(card->longname, sizeof(card->longname),
-			 "%s at 0x%lx, IRQ %d, DMA %d\n",
-			 pcm->name, chip->port, chip->irq, chip->dma1);
+		         "%s at 0x%lx, IRQ %d, DMA %d\n",
+		         pcm->name, chip->port, chip->irq, chip->dma1);
 		chip->set_playback_format = ad1845_playback_format;
 		chip->set_capture_format = ad1845_capture_format;
 		sscape->chip = chip;
 	}
 
-      _error:
+	_error:
 	return err;
 }
 
+
+struct params
+{
+	int index;
+	const char *id;
+	unsigned port;
+	int irq;
+	int mpu_irq;
+	int dma1;
+
+#ifdef __ISAPNP__
+	struct isapnp_dev *isapnp;
+#endif
+};
+
+
+static inline struct params*
+init_params(struct params *params,
+            int index,
+            const char *id,
+            unsigned port,
+            int irq,
+            int mpu_irq,
+            int dma1,
+            struct isapnp_dev *isapnp)
+{
+	params->index = index;
+	params->id = id;
+	params->port = port;
+	params->irq = irq;
+	params->mpu_irq = mpu_irq;  
+	params->dma1 = (dma1 & 0x03);
+
+#ifdef __ISAPNP__
+	params->isapnp = isapnp;
+#endif
+
+ return params;
+}
+
+
 /*
  * Create an ALSA soundcard entry for the SoundScape, using
  * the given list of port, IRQ and DMA resources.
  */
-static int __init create_sscape(unsigned port, int irq, int mpu_irq, int dma1, int dma2)
+static int __init create_sscape(const struct params *params)
 {
 	snd_card_t *card;
 	register struct soundscape *sscape;
-	register unsigned mpu_irq_cfg;
 	register unsigned dma_cfg;
+	unsigned irq_cfg;
+	unsigned mpu_irq_cfg;
 	struct resource *io_res;
 	unsigned long flags;
 	int err;
 
 	/*
-	 * Check that the driver can handle one more card ...
+	 * Check that the user didn't pass us garbage data ...
 	 */
-	if (sscape_count >= ARRAY_SIZE(sscape_card)) {
-		printk(KERN_ERR "sscape: Maximum number of cards reached (%d)\n", sscape_count);
-		return -EBUSY;
+	irq_cfg = get_irq_config(params->irq);
+	if (irq_cfg == INVALID_IRQ) {
+		printk(KERN_ERR "sscape: Invalid IRQ %d\n", params->irq);
+		return -ENXIO;
+	}
+
+	mpu_irq_cfg = get_irq_config(params->mpu_irq);
+	if (mpu_irq_cfg == INVALID_IRQ) {
+		printk(KERN_ERR "sscape: Invalid IRQ %d\n", params->mpu_irq);
+		return -ENXIO;
 	}
 
 	/*
 	 * Grab IO ports that we will need to probe so that we
 	 * can detect and control this hardware ...
 	 */
-	if ((io_res = request_region(port, 8, "SoundScape")) == NULL) {
+	if ((io_res = request_region(params->port, 8, "SoundScape")) == NULL) {
 		return -EBUSY;
 	}
 
-	dma1 &= 0x03;
-	dma2 &= 0x03;
-
 	/*
-	 * Grab both DMA channels ...
+	 * Grab both DMA channels (OK, only one for now) ...
 	 */
-	if ((err = request_dma(dma1, "SoundScape")) < 0) {
+	if ((err = request_dma(params->dma1, "SoundScape")) < 0) {
 		goto _release_region;
 	}
 
@@ -1116,7 +1193,7 @@
 	 * Create a new ALSA sound card entry, in anticipation
 	 * of detecting our hardware ...
 	 */
-	if ((card = snd_card_new(snd_index[sscape_count], "SoundScape", THIS_MODULE, sizeof(struct soundscape))) == NULL) {
+	if ((card = snd_card_new(params->index, params->id, THIS_MODULE, sizeof(struct soundscape))) == NULL) {
 		err = -ENOMEM;
 		goto _release_dma;
 	}
@@ -1125,21 +1202,21 @@
 	spin_lock_init(&sscape->lock);
 	spin_lock_init(&sscape->fwlock);
 	sscape->io_res = io_res;
-	sscape->io_base = port;
+	sscape->io_base = params->port;
 
 	if (!detect_sscape(sscape)) {
-		printk(KERN_ERR "sscape: hardware not detected\n");
+		printk(KERN_ERR "sscape: hardware not detected at 0x%x\n", sscape->io_base);
 		err = -ENODEV;
 		goto _release_card;
 	}
 
-	printk(KERN_INFO "sscape: hardware detected at 0x%x, using IRQ %d, DMA %d,%d\n",
-	       sscape->io_base, irq, dma1, dma2);
+	printk(KERN_INFO "sscape: hardware detected at 0x%x, using IRQ %d, DMA %d\n",
+	                 sscape->io_base, params->irq, params->dma1);
 
 	/*
 	 * Now create the hardware-specific device so that we can
 	 * load the microcode into the on-board processor.
-	 * We cannot detect the AD1845 system until this firmware
+	 * We cannot use the MPU-401 MIDI system until this firmware
 	 * has been loaded into the card.
 	 */
 	if ((err = snd_hwdep_new(card, "MC68EC000", 0, &(sscape->hw))) < 0) {
@@ -1162,7 +1239,7 @@
 
 	activate_ad1845_unsafe(sscape->io_base);
 
-	sscape_write_unsafe(sscape->io_base, GA_INTENA_REG, 0x00);	/* disable */
+	sscape_write_unsafe(sscape->io_base, GA_INTENA_REG, 0x00); /* disable */
 	sscape_write_unsafe(sscape->io_base, GA_SMCFGA_REG, 0x2e);
 	sscape_write_unsafe(sscape->io_base, GA_SMCFGB_REG, 0x00);
 
@@ -1174,9 +1251,10 @@
 	sscape_write_unsafe(sscape->io_base, GA_DMAA_REG, dma_cfg);
 	sscape_write_unsafe(sscape->io_base, GA_DMAB_REG, 0x20);
 
-	mpu_irq_cfg = get_irq_config(mpu_irq);
-	sscape_write_unsafe(sscape->io_base, GA_INTCFG_REG, 0xf0 | (mpu_irq_cfg << 2) | mpu_irq_cfg);
-	sscape_write_unsafe(sscape->io_base, GA_CDCFG_REG, 0x09 | DMA_8BIT | (dma1 << 4) | (get_irq_config(irq) << 1));
+	sscape_write_unsafe(sscape->io_base,
+	                    GA_INTCFG_REG, 0xf0 | (mpu_irq_cfg << 2) | mpu_irq_cfg);
+	sscape_write_unsafe(sscape->io_base,
+	                    GA_CDCFG_REG, 0x09 | DMA_8BIT | (params->dma1 << 4) | (irq_cfg << 1));
 
 	spin_unlock_irqrestore(&sscape->lock, flags);
 
@@ -1184,13 +1262,15 @@
 	 * We have now enabled the codec chip, and so we should
 	 * detect the AD1845 device ...
 	 */
-	if ((err = create_ad1845(card, CODEC_IO(port), irq, dma1)) < 0) {
-		printk(KERN_ERR "sscape: No AD1845 device at 0x%x, IRQ %d\n", CODEC_IO(port), irq);
+	if ((err = create_ad1845(card, CODEC_IO(params->port), params->irq, params->dma1)) < 0) {
+		printk(KERN_ERR "sscape: No AD1845 device at 0x%x, IRQ %d\n",
+		                CODEC_IO(params->port), params->irq);
 		goto _release_card;
 	}
 #define MIDI_DEVNUM  0
-	if ((err = create_mpu401(card, MIDI_DEVNUM, MPU401_IO(port), mpu_irq)) < 0) {
-		printk(KERN_ERR "sscape: Failed to create MPU-401 device at 0x%x\n", port);
+	if ((err = create_mpu401(card, MIDI_DEVNUM, MPU401_IO(params->port), params->mpu_irq)) < 0) {
+		printk(KERN_ERR "sscape: Failed to create MPU-401 device at 0x%x\n",
+		                MPU401_IO(params->port));
 		goto _release_card;
 	}
 
@@ -1212,6 +1292,9 @@
 	host_write_ctrl_unsafe(sscape->io_base, 0, 100);
 	host_write_ctrl_unsafe(sscape->io_base, CMD_XXX_MIDI_VOL, 100);
 
+#ifdef __ISAPNP__
+	sscape->isapnp = params->isapnp;
+#endif
 
 	/*
 	 * Now that we have successfully created this sound card,
@@ -1220,18 +1303,17 @@
 	 *       function now that our "constructor" has completed.
 	 */
 	card->private_free = soundscape_free;
-	sscape_card[sscape_count] = card;
-	++sscape_count;
+	sscape_card[card->number] = card;
 
 	return 0;
 
-      _release_card:
+	_release_card:
 	snd_card_free(card);
 
-      _release_dma:
-	free_dma(dma1);
+	_release_dma:
+	free_dma(params->dma1);
 
-      _release_region:
+	_release_region:
 	release_resource(io_res);
 	kfree_nocheck(io_res);
 
@@ -1239,11 +1321,51 @@
 }
 
 
-#ifdef MODULE
-static int __init sscape_module_probe(struct isapnp_card *card, const struct isapnp_card_id *id)
+#ifdef __ISAPNP__
+struct isapnp_data
+{
+	struct params *params;
+	unsigned cards;
+	unsigned idx;
+};
+
+static void* __initdata hackptr;
+
+
+static inline int __init get_next_autoindex(int i)
+{
+	while ((i < SNDRV_CARDS) && (port[i] != SNDRV_AUTO_PORT)) {
+		++i;
+	} /* while */
+
+	return i;
+}
+
+
+static inline int __init is_port_known(unsigned io, struct params *params, int cards)
 {
+	while (--cards >= 0) {
+		if (params[cards].port == io)
+			return 1;
+	} /* while */
+
+	return 0;
+}
+
+
+static int __init sscape_isapnp_card(struct isapnp_card *card, const struct isapnp_card_id *pnpid)
+{
+	struct isapnp_data *data = hackptr;
 	struct isapnp_dev *dev;
-	int ret = -ENODEV;
+	int ret;
+
+	/*
+	 * Allow this function to fail *quietly* if all the ISA PnP
+	 * devices were configured using module parameters instead.
+	 */
+	if ((data->idx = get_next_autoindex(data->idx)) >= SNDRV_CARDS) {
+		return -ENOSPC;
+	}
 
 	/*
 	 * We have found a candidate ISA PnP card. Now we
@@ -1262,19 +1384,43 @@
 	 */
 	printk(KERN_INFO "sscape: %s\n", card->name);
 
-	dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
+	/*
+	 * Check that we still have room for another sound card ...
+	 */
+	if (data->cards >= SNDRV_CARDS) {
+		printk(KERN_ERR "sscape: No room for another ALSA device\n");
+		return -ENOSPC;
+	}
+
+	ret = -ENODEV;
+
+	dev = isapnp_find_dev(card, pnpid->devs[0].vendor, pnpid->devs[0].function, NULL);
 	if (dev) {
 		if (!dev->active) {
 			printk(KERN_INFO "sscape: device is inactive\n");
 		} else {
+			struct params *this;
+
 			/*
-			 * Use these resources to create a new instance of the sound driver
+			 * Read the correct parameters off the ISA PnP bus ...
 			 */
-			ret = create_sscape(dev->resource[0].start,
-					    dev->irq_resource[0].start,
-					    dev->irq_resource[1].start,
-					    dev->dma_resource[0].start,
-					    dev->dma_resource[1].start);
+			this = init_params(&data->params[data->cards],
+			                   index[data->idx],
+			                   id[data->idx],
+			                   dev->resource[0].start,
+			                   dev->irq_resource[0].start,
+			                   dev->irq_resource[1].start,
+			                   dev->dma_resource[0].start,
+			                   dev);
+
+			/*
+			 * Do we know about this sound card already?
+			 */
+			if ( !is_port_known(this->port, data->params, data->cards) ) {
+				++(data->cards);
+			  ++(data->idx);
+				ret = 0;
+			}
 		}
 	}
 
@@ -1282,28 +1428,145 @@
 }
 
 
-static int __init sscape_init(void)
+static int __init sscape_isapnp_probe(struct params *sscape_params, int cards)
 {
-	int cards = isapnp_probe_cards(sscape_pnpids, sscape_module_probe);
-	if (cards > 0)
-		return 0;
-	if (!cards)
-		return -ENODEV;
+	struct isapnp_data  probe_data;
+
+	probe_data.params = sscape_params;
+	probe_data.cards = cards;
+	probe_data.idx = 0;
+
+	/*
+	 * This is the best way to pass data into the ISA-PnP
+	 * callback function. We have NO CHOICE but to use a
+	 * global variable (Ewwwwwww!) ...
+	 */
+	hackptr = &probe_data;
+	return isapnp_probe_cards(sscape_pnpids, sscape_isapnp_card);
+}
+#endif
+
+
+static int __init sscape_manual_probe(struct params *params)
+{
+	int cards = 0;
+	unsigned i;
+
+	for (i = 0; i < SNDRV_CARDS; ++i) {
+		/*
+		 * We do NOT probe for ports.
+		 * If we're not given a port number for this
+		 * card then we completely ignore this line
+		 * of parameters.
+		 */
+		if (port[i] == SNDRV_AUTO_PORT)
+			continue;
+
+		/*
+		 * Make sure we were given ALL of the other parameters.
+		 */
+		if ( (irq[i] == SNDRV_AUTO_IRQ) ||
+		     (mpu_irq[i] == SNDRV_AUTO_IRQ) ||
+		     (dma[i] == SNDRV_AUTO_DMA) ) {
+			printk(KERN_INFO
+			       "sscape: insufficient parameters, need IO, IRQ, MPU-IRQ and DMA\n");
+			return -ENXIO;
+		}
+
+		/*
+		 * This cards looks OK ...
+		 */
+		init_params(params, index[i], id[i], port[i], irq[i], mpu_irq[i], dma[i], NULL);
+		++params;
+		++cards;
+	} /* for */
+
 	return cards;
 }
 
+
 static void __exit sscape_exit(void)
 {
-	unsigned i = 0;
+	unsigned i;
 
-	while ((i < ARRAY_SIZE(sscape_card)) && sscape_card[i]) {
+	for (i = 0; i < ARRAY_SIZE(sscape_card); ++i) {
 		snd_card_free(sscape_card[i]);
-		++i;
-	} /* while */
+	} /* for */
+}
+
+
+static int __init sscape_init(void)
+{
+	struct params sscape_params[ARRAY_SIZE(sscape_card)];
+	int cards;
+	int ret;
+	int i;
+
+	/*
+	 * First check whether we were passed any parameters.
+	 * These MUST take precedence over ANY automatic way
+	 * of allocating cards, because the operator is
+	 * S-P-E-L-L-I-N-G it out for us...
+	 */
+	cards = sscape_manual_probe(sscape_params);
+	if (cards < 0)
+		return cards;
+
+#ifdef __ISAPNP__
+	if (cards < SNDRV_CARDS)
+		cards += sscape_isapnp_probe(sscape_params, cards);
+#endif
+
+	/*
+	 * Now try to attach drivers for any cards we've found ...
+	 */ 
+	ret = -ENODEV;
+
+	for (i = 0; i < cards; ++i) {
+		ret = create_sscape(&sscape_params[i]);
+
+		/*
+		 * Did we create this SoundScape driver successfully?
+		 */
+		if (ret != 0) {
+			/*
+			 * Linux will NOT clean up automatically if the
+			 * module_init function fails ...
+			 */
+			sscape_exit();
+			break;
+		}
+	} /* for */
+
+	return ret;
 }
 
 module_init(sscape_init);
 module_exit(sscape_exit);
-#else
-#  error This driver can currently only be compiled as a module
+
+#ifndef MODULE
+
+/* format is: snd-sscape=index,id,port,irq,mpu_irq,dma */
+
+static int __init builtin_sscape_setup(char *str)
+{
+	static unsigned __initdata nr_dev;
+
+	if (nr_dev >= SNDRV_CARDS)
+		return 0;
+
+	(void)((get_option(&str, &index[nr_dev]) == 2) &&
+	       (get_option(&str, (int*)&id[nr_dev]) == 2) &&
+	       (get_option(&str, (int*)&port[nr_dev]) == 2) &&
+	       (get_option(&str, &irq[nr_dev]) == 2) &&
+	       (get_option(&str, &mpu_irq[nr_dev]) == 2) &&
+	       (get_option(&str, &dma[nr_dev]) == 2)); 
+ 
+	++nr_dev;
+	return 1;
+}
+
+__setup("snd-sscape=", builtin_sscape_setup);
+
 #endif
+


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
