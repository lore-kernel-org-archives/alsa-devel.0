From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: CS4232 Playback bug on Tecra 500
Date: Mon, 26 Jan 2009 18:33:15 +0100
Message-ID: <20090126183315.68772c4d.krzysztof.h1@poczta.fm>
References: <405205790901212040s79ce94a4if4ff742a9c18bc67@mail.gmail.com>
	<20090122134150.f6d0e192.krzysztof.h1@poczta.fm>
	<405205790901220743k32d76edeh733b2dacfbf0497e@mail.gmail.com>
	<20090122172856.e39ae951.krzysztof.h1@poczta.fm>
	<s5h7i4n5mar.wl%tiwai@suse.de>
	<20090124092606.11f3660e.krzysztof.h1@poczta.fm>
	<s5hab9e5rky.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C1451037F4
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2009 18:29:53 +0100 (CET)
In-Reply-To: <s5hab9e5rky.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Stanley Pinchak <stanley.pinchak@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Jan 2009 10:45:01 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 24 Jan 2009 09:26:06 +0100,
> Krzysztof Helt wrote:
> > 
> > I have opened my laptop and it has the CS4237B chipset (the one
> > the Dell states for this model). 
> > A problem is with ALSA drivers. The snd-cs4232 is the only driver
> > which supports pnpbios. The snd-cs4236 does not so it does not
> > recognize the card. 
> > 
> > An ultimate solution would be to merge the snd-cs4236-lib into
> > the wss-lib (as Rene Herman proposed some time ago) then
> > prepare a single driver for all cs423x cards.
> 
> Agreed.  I don't think that would be too much job, just checking
> cs4236_lib.c.  Only the testing isn't easy nowadays just lack of
> available hardware.
> 

The proposed solution does not help.

The problem is more complicated. The cs4236+ cards have two
separate PNP bios ids! The problem here is that Linux kernel
allows only one id per device. The ids are CS0010* for the CS0000*
device and CS0110* for the CS0100* devices. The second device
has only control port range (one io range).

I have prepared the patch which I tested on my Dell Latitude CPi
laptop and now it properly discovers the CS4237B codec. Stanley,
please test it as well.

The patch checks all PNP devices for the second id and if it is found
(so the control port io is known) it assumes the CS4236+ chip. If not,
it assumes the CS4232 chip.

This patch makes both drivers snd-cs4232 and snd-cs4236 identical
so the next step is to remove one. My proposition is to remove the
snd-cs4236 and change the description of the snd-cs4232 driver
to handle all cs4232+ codecs.

Kind regards,
Krzysztof
PS. Stanley, please build only one the snd-cs4232 or snd-cs4236 driver.

diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 019c940..d490bb8 100644
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
@@ -409,40 +390,38 @@ static int __devinit snd_cs423x_probe(struct snd_card *card, int dev)
 			return -EBUSY;
 		}
 
-#ifdef CS4232
-	err = snd_wss_create(card, port[dev], cport[dev],
-			     irq[dev],
-			     dma1[dev], dma2[dev],
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
-	if (err < 0)
-		return err;
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
+	if (cport[dev] > 0) {
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
+		err = snd_wss_create(card, port[dev], cport[dev],
+				     irq[dev],
+				     dma1[dev], dma2[dev],
+				     WSS_HW_DETECT, 0, &chip);
+		if (err < 0)
+			return err;
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
@@ -577,13 +556,15 @@ static struct isa_driver cs423x_isa_driver = {
 
 
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
@@ -594,10 +575,20 @@ static int __devinit snd_cs4232_pnpbios_detect(struct pnp_dev *pdev,
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
 	card = snd_cs423x_card_new(dev);
 	if (! card)
 		return -ENOMEM;
-	if ((err = snd_card_cs4232_pnp(dev, card->private_data, pdev)) < 0) {
+	err = snd_card_cs423x_pnp(dev, card->private_data, pdev, cdev);
+	if (err < 0) {
 		printk(KERN_ERR "PnP BIOS detection failed for " IDENT "\n");
 		snd_card_free(card);
 		return err;
@@ -612,35 +603,34 @@ static int __devinit snd_cs4232_pnpbios_detect(struct pnp_dev *pdev,
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
@@ -714,18 +704,14 @@ static int __init alsa_card_cs423x_init(void)
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
@@ -737,10 +723,8 @@ static void __exit alsa_card_cs423x_exit(void)
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


----------------------------------------------------------------------
Konkurs Walentynkowy! Wybierz nagrode i wygraj!
Sprawdz >>  http://link.interia.pl/f2039 
