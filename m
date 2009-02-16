From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cs4236: cs4232 and cs4236 driver merge to
 solve PnP BIOS detection
Date: Mon, 16 Feb 2009 07:43:51 +0100
Message-ID: <20090216074351.0316c9ab.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 31271243D0
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 07:39:18 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Stanley Pinchak <stanley.pinchak@gmail.com>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Also, the patch adds recognition if the chip is cs4236b+
or earlier part. This unifies drivers for both cs4232
and cs4236+ chips. It allows to use the PnP BIOS
detection for the cs4236+ chips. Previously, only
the snd-cs4232 could be detected by the PnP BIOS.

The cs4232+ cards reports two separate PnP BIOS ids.

The patch adds search for the second id to find out
resources assigned to a control port.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The cs4232 and cs4236 are the same now and one can be removed.

Stanley tested this patch and it worked for him (cs4232 chip in
Tecra 500). 

I have tested it on Dell Latitude CP (cs4237b chip)
which is now correctly recognized. Previously, it was
recognized as a basic cs4236 chip. Also, I have tested it
with Maxi Sound 32 PnP card (ISA PnP cs4236b) with
success.

A side effect of this approach is that on ISA PnP cards
the driver reports an error of PnP BIOS detection 
everytime it is loaded. This is due to driver rejecting
the PnP BIOS initialization for ISA PnP cards. Probably,
the earlier cs4232 driver worked the same way.

diff --git a/include/sound/wss.h b/include/sound/wss.h
index fd01f22..6d65f32 100644
--- a/include/sound/wss.h
+++ b/include/sound/wss.h
@@ -154,6 +154,7 @@ int snd_wss_create(struct snd_card *card,
 		      unsigned short hardware,
 		      unsigned short hwshare,
 		      struct snd_wss **rchip);
+int snd_wss_free(struct snd_wss *chip);
 int snd_wss_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
 int snd_wss_timer(struct snd_wss *chip, int device, struct snd_timer **rtimer);
 int snd_wss_mixer(struct snd_wss *chip);
diff --git a/sound/isa/cs423x/Makefile b/sound/isa/cs423x/Makefile
index 5870ca2..dfdd96d 100644
--- a/sound/isa/cs423x/Makefile
+++ b/sound/isa/cs423x/Makefile
@@ -10,6 +10,6 @@ snd-cs4236-objs := cs4236.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_CS4231) += snd-cs4231.o
-obj-$(CONFIG_SND_CS4232) += snd-cs4232.o
+obj-$(CONFIG_SND_CS4232) += snd-cs4232.o snd-cs4236-lib.o
 obj-$(CONFIG_SND_CS4236) += snd-cs4236.o snd-cs4236-lib.o
 
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index f784598..089b7e8 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -33,17 +33,14 @@
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
-#ifdef CS4232
-MODULE_DESCRIPTION("Cirrus Logic CS4232");
+MODULE_DESCRIPTION("Cirrus Logic CS4232-9");
 MODULE_SUPPORTED_DEVICE("{{Turtle Beach,TBS-2000},"
 		"{Turtle Beach,Tropez Plus},"
 		"{SIC CrystalWave 32},"
 		"{Hewlett Packard,Omnibook 5500},"
 		"{TerraTec,Maestro 32/96},"
-		"{Philips,PCA70PS}}");
-#else
-MODULE_DESCRIPTION("Cirrus Logic CS4235-9");
-MODULE_SUPPORTED_DEVICE("{{Crystal Semiconductors,CS4235},"
+		"{Philips,PCA70PS}},"
+		"{{Crystal Semiconductors,CS4235},"
 		"{Crystal Semiconductors,CS4236},"
 		"{Crystal Semiconductors,CS4237},"
 		"{Crystal Semiconductors,CS4238},"
@@ -70,15 +67,9 @@ MODULE_SUPPORTED_DEVICE("{{Crystal Semiconductors,CS4235},"
 		"{Typhoon Soundsystem,CS4236B},"
 		"{Turtle Beach,Malibu},"
 		"{Unknown,Digital PC 5000 Onboard}}");
-#endif
 
-#ifdef CS4232
-#define IDENT "CS4232"
-#define DEV_NAME "cs4232"
-#else
-#define IDENT "CS4236+"
-#define DEV_NAME "cs4236"
-#endif
+#define IDENT "CS4232+"
+#define DEV_NAME "cs4232+"
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
@@ -128,9 +119,7 @@ MODULE_PARM_DESC(dma2, "DMA2 # for " IDENT " driver.");
 #ifdef CONFIG_PNP
 static int isa_registered;
 static int pnpc_registered;
-#ifdef CS4232
 static int pnp_registered;
-#endif
 #endif /* CONFIG_PNP */
 
 struct snd_card_cs4236 {
@@ -145,11 +134,10 @@ struct snd_card_cs4236 {
 
 #ifdef CONFIG_PNP
 
-#ifdef CS4232
 /*
  * PNP BIOS
  */
-static const struct pnp_device_id snd_cs4232_pnpbiosids[] = {
+static const struct pnp_device_id snd_cs423x_pnpbiosids[] = {
 	{ .id = "CSC0100" },
 	{ .id = "CSC0000" },
 	/* Guillemot Turtlebeach something appears to be cs4232 compatible
@@ -157,10 +145,8 @@ static const struct pnp_device_id snd_cs4232_pnpbiosids[] = {
 	{ .id = "GIM0100" },
 	{ .id = "" }
 };
-MODULE_DEVICE_TABLE(pnp, snd_cs4232_pnpbiosids);
-#endif /* CS4232 */
+MODULE_DEVICE_TABLE(pnp, snd_cs423x_pnpbiosids);
 
-#ifdef CS4232
 #define CS423X_ISAPNP_DRIVER	"cs4232_isapnp"
 static struct pnp_card_device_id snd_cs423x_pnpids[] = {
 	/* Philips PCA70PS */
@@ -179,12 +165,6 @@ static struct pnp_card_device_id snd_cs423x_pnpids[] = {
 	{ .id = "CSCf032", .devs = { { "CSC0000" }, { "CSC0010" }, { "CSC0003" } } },
 	/* Netfinity 3000 on-board soundcard */
 	{ .id = "CSCe825", .devs = { { "CSC0100" }, { "CSC0110" }, { "CSC010f" } } },
-	/* --- */
-	{ .id = "" }	/* end */
-};
-#else /* CS4236 */
-#define CS423X_ISAPNP_DRIVER	"cs4236_isapnp"
-static struct pnp_card_device_id snd_cs423x_pnpids[] = {
 	/* Intel Marlin Spike Motherboard - CS4235 */
 	{ .id = "CSC0225", .devs = { { "CSC0000" }, { "CSC0010" }, { "CSC0003" } } },
 	/* Intel Marlin Spike Motherboard (#2) - CS4235 */
@@ -266,7 +246,6 @@ static struct pnp_card_device_id snd_cs423x_pnpids[] = {
 	/* --- */
 	{ .id = "" }	/* end */
 };
-#endif
 
 MODULE_DEVICE_TABLE(pnp_card, snd_cs423x_pnpids);
 
@@ -323,17 +302,19 @@ static int __devinit snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
 	return 0;
 }
 
-#ifdef CS4232
-static int __devinit snd_card_cs4232_pnp(int dev, struct snd_card_cs4236 *acard,
-					 struct pnp_dev *pdev)
+static int __devinit snd_card_cs423x_pnp(int dev, struct snd_card_cs4236 *acard,
+					 struct pnp_dev *pdev,
+					 struct pnp_dev *cdev)
 {
 	acard->wss = pdev;
 	if (snd_cs423x_pnp_init_wss(dev, acard->wss) < 0)
 		return -EBUSY;
-	cport[dev] = -1;
+	if (cdev)
+		cport[dev] = pnp_port_start(cdev, 0);
+	else
+		cport[dev] = -1;
 	return 0;
 }
-#endif
 
 static int __devinit snd_card_cs423x_pnpc(int dev, struct snd_card_cs4236 *acard,
 					  struct pnp_card_link *card,
@@ -411,40 +392,39 @@ static int __devinit snd_cs423x_probe(struct snd_card *card, int dev)
 			return -EBUSY;
 		}
 
-#ifdef CS4232
 	err = snd_wss_create(card, port[dev], cport[dev],
 			     irq[dev],
 			     dma1[dev], dma2[dev],
-			     WSS_HW_DETECT, 0, &chip);
-	if (err < 0)
-		return err;
-	acard->chip = chip;
-
-	err = snd_wss_pcm(chip, 0, &pcm);
-	if (err < 0)
-		return err;
-
-	err = snd_wss_mixer(chip);
+			     WSS_HW_DETECT3, 0, &chip);
 	if (err < 0)
 		return err;
-
-#else /* CS4236 */
-	err = snd_cs4236_create(card,
-				port[dev], cport[dev],
-				irq[dev], dma1[dev], dma2[dev],
-				WSS_HW_DETECT, 0, &chip);
-	if (err < 0)
-		return err;
-	acard->chip = chip;
-
-	err = snd_cs4236_pcm(chip, 0, &pcm);
-	if (err < 0)
-		return err;
-
-	err = snd_cs4236_mixer(chip);
-	if (err < 0)
-		return err;
-#endif
+	if (chip->hardware & WSS_HW_CS4236B_MASK) {
+		snd_wss_free(chip);
+		err = snd_cs4236_create(card,
+					port[dev], cport[dev],
+					irq[dev], dma1[dev], dma2[dev],
+					WSS_HW_DETECT, 0, &chip);
+		if (err < 0)
+			return err;
+		acard->chip = chip;
+
+		err = snd_cs4236_pcm(chip, 0, &pcm);
+		if (err < 0)
+			return err;
+
+		err = snd_cs4236_mixer(chip);
+		if (err < 0)
+			return err;
+	} else {
+		acard->chip = chip;
+		err = snd_wss_pcm(chip, 0, &pcm);
+		if (err < 0)
+			return err;
+
+		err = snd_wss_mixer(chip);
+		if (err < 0)
+			return err;
+	}
 	strcpy(card->driver, pcm->name);
 	strcpy(card->shortname, pcm->name);
 	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i",
@@ -579,13 +559,15 @@ static struct isa_driver cs423x_isa_driver = {
 
 
 #ifdef CONFIG_PNP
-#ifdef CS4232
-static int __devinit snd_cs4232_pnpbios_detect(struct pnp_dev *pdev,
+static int __devinit snd_cs423x_pnpbios_detect(struct pnp_dev *pdev,
 					       const struct pnp_device_id *id)
 {
 	static int dev;
 	int err;
 	struct snd_card *card;
+	struct pnp_dev *cdev;
+	struct list_head *pos;
+	char cid[PNP_ID_LEN];
 
 	if (pnp_device_is_isapnp(pdev))
 		return -ENOENT;	/* we have another procedure - card */
@@ -596,10 +578,20 @@ static int __devinit snd_cs4232_pnpbios_detect(struct pnp_dev *pdev,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 
+	/* prepare second id */
+	strcpy(cid, pdev->id[0].id);
+	cid[5] = '1';
+	cdev = NULL;
+	list_for_each(pos, &(pdev->protocol->devices)) {
+		cdev = list_entry(pos, struct pnp_dev, protocol_list);
+		if (!strcmp(cdev->id[0].id, cid))
+			break;
+	}
 	err = snd_cs423x_card_new(dev, &card);
 	if (err < 0)
 		return err;
-	if ((err = snd_card_cs4232_pnp(dev, card->private_data, pdev)) < 0) {
+	err = snd_card_cs423x_pnp(dev, card->private_data, pdev, cdev);
+	if (err < 0) {
 		printk(KERN_ERR "PnP BIOS detection failed for " IDENT "\n");
 		snd_card_free(card);
 		return err;
@@ -614,35 +606,34 @@ static int __devinit snd_cs4232_pnpbios_detect(struct pnp_dev *pdev,
 	return 0;
 }
 
-static void __devexit snd_cs4232_pnp_remove(struct pnp_dev * pdev)
+static void __devexit snd_cs423x_pnp_remove(struct pnp_dev *pdev)
 {
 	snd_card_free(pnp_get_drvdata(pdev));
 	pnp_set_drvdata(pdev, NULL);
 }
 
 #ifdef CONFIG_PM
-static int snd_cs4232_pnp_suspend(struct pnp_dev *pdev, pm_message_t state)
+static int snd_cs423x_pnp_suspend(struct pnp_dev *pdev, pm_message_t state)
 {
 	return snd_cs423x_suspend(pnp_get_drvdata(pdev));
 }
 
-static int snd_cs4232_pnp_resume(struct pnp_dev *pdev)
+static int snd_cs423x_pnp_resume(struct pnp_dev *pdev)
 {
 	return snd_cs423x_resume(pnp_get_drvdata(pdev));
 }
 #endif
 
-static struct pnp_driver cs4232_pnp_driver = {
-	.name = "cs4232-pnpbios",
-	.id_table = snd_cs4232_pnpbiosids,
-	.probe = snd_cs4232_pnpbios_detect,
-	.remove = __devexit_p(snd_cs4232_pnp_remove),
+static struct pnp_driver cs423x_pnp_driver = {
+	.name = "cs423x-pnpbios",
+	.id_table = snd_cs423x_pnpbiosids,
+	.probe = snd_cs423x_pnpbios_detect,
+	.remove = __devexit_p(snd_cs423x_pnp_remove),
 #ifdef CONFIG_PM
-	.suspend	= snd_cs4232_pnp_suspend,
-	.resume		= snd_cs4232_pnp_resume,
+	.suspend	= snd_cs423x_pnp_suspend,
+	.resume		= snd_cs423x_pnp_resume,
 #endif
 };
-#endif /* CS4232 */
 
 static int __devinit snd_cs423x_pnpc_detect(struct pnp_card_link *pcard,
 					    const struct pnp_card_device_id *pid)
@@ -716,18 +707,14 @@ static int __init alsa_card_cs423x_init(void)
 #ifdef CONFIG_PNP
 	if (!err)
 		isa_registered = 1;
-#ifdef CS4232
-	err = pnp_register_driver(&cs4232_pnp_driver);
+	err = pnp_register_driver(&cs423x_pnp_driver);
 	if (!err)
 		pnp_registered = 1;
-#endif
 	err = pnp_register_card_driver(&cs423x_pnpc_driver);
 	if (!err)
 		pnpc_registered = 1;
-#ifdef CS4232
 	if (pnp_registered)
 		err = 0;
-#endif
 	if (isa_registered)
 		err = 0;
 #endif
@@ -739,10 +726,8 @@ static void __exit alsa_card_cs423x_exit(void)
 #ifdef CONFIG_PNP
 	if (pnpc_registered)
 		pnp_unregister_card_driver(&cs423x_pnpc_driver);
-#ifdef CS4232
 	if (pnp_registered)
-		pnp_unregister_driver(&cs4232_pnp_driver);
-#endif
+		pnp_unregister_driver(&cs423x_pnp_driver);
 	if (isa_registered)
 #endif
 		isa_unregister_driver(&cs423x_isa_driver);
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index aab44e7..5d2ba1b 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1682,7 +1682,7 @@ static void snd_wss_resume(struct snd_wss *chip)
 }
 #endif /* CONFIG_PM */
 
-static int snd_wss_free(struct snd_wss *chip)
+int snd_wss_free(struct snd_wss *chip)
 {
 	release_and_free_resource(chip->res_port);
 	release_and_free_resource(chip->res_cport);
@@ -1705,6 +1705,7 @@ static int snd_wss_free(struct snd_wss *chip)
 	kfree(chip);
 	return 0;
 }
+EXPORT_SYMBOL(snd_wss_free);
 
 static int snd_wss_dev_free(struct snd_device *device)
 {


----------------------------------------------------------------------
Zostan mistrzem parkowania w Bombaju!
Zagraj >> http://link.interia.pl/f204e 
