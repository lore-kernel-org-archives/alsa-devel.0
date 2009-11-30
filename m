From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] opti-miro: add PnP detection
Date: Mon, 30 Nov 2009 07:46:56 +0100
Message-ID: <20091130074656.f8334bc2.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 32B55103824
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 07:44:47 +0100 (CET)
Received: from poczta.interia.pl (mi04.poczta.interia.pl [10.217.12.4])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 8EA331EF19F
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 07:44:44 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 2A15836B0FC
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 07:44:44 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The PCM12 and PCM20 can be set into the ISA PnP mode. The PCM12 PnP
was sold as the PnP device.
Add code to handle detection of these cards using ISA PnP framework.

Tested on the PCM20 in PnP mode. The PCM12 PnP has the same MS Windows
INF file except for a card name displayed for user.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/miro.c |  203 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 192 insertions(+), 11 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index c67bc3c..6123c75 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/isa.h>
+#include <linux/pnp.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
@@ -60,6 +61,9 @@ static int dma1 = SNDRV_DEFAULT_DMA1;		/* 0,1,3 */
 static int dma2 = SNDRV_DEFAULT_DMA1;		/* 0,1,3 */
 static int wss;
 static int ide;
+#ifdef CONFIG_PNP
+static int isapnp = 1;				/* Enable ISA PnP detection */
+#endif
 
 module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for miro soundcard.");
@@ -83,6 +87,10 @@ module_param(wss, int, 0444);
 MODULE_PARM_DESC(wss, "wss mode");
 module_param(ide, int, 0444);
 MODULE_PARM_DESC(ide, "enable ide port");
+#ifdef CONFIG_PNP
+module_param(isapnp, bool, 0444);
+MODULE_PARM_DESC(isapnp, "Enable ISA PnP detection for specified soundcard.");
+#endif
 
 #define OPTi9XX_HW_DETECT	0
 #define OPTi9XX_HW_82C928	1
@@ -131,6 +139,21 @@ static char * snd_opti9xx_names[] = {
 	"82C930", "82C931", "82C933"
 };
 
+static int snd_miro_pnp_is_probed;
+
+#ifdef CONFIG_PNP
+
+static struct pnp_card_device_id snd_miro_pnpids[] = {
+	/* PCM20 and PCM12 in PnP mode */
+	{ .id = "MIR0924",
+	  .devs = { { "MIR0000" }, { "MIR0002" }, { "MIR0005" } }, },
+	{ .id = "" }
+};
+
+MODULE_DEVICE_TABLE(pnp_card, snd_miro_pnpids);
+
+#endif	/* CONFIG_PNP */
+
 /* 
  *  ACI control
  */
@@ -781,17 +804,23 @@ static int __devinit snd_miro_init(struct snd_miro *chip,
 	chip->mpu_port = -1;
 	chip->mpu_irq = -1;
 
+	chip->pwd_reg = 3;
+
+#ifdef CONFIG_PNP
+	if (isapnp && chip->mc_base)
+		/* PnP resource gives the least 10 bits */
+		chip->mc_base |= 0xc00;
+	else
+#endif
+		chip->mc_base = 0xf8c;
+
 	switch (hardware) {
 	case OPTi9XX_HW_82C929:
-		chip->mc_base = 0xf8c;
 		chip->password = 0xe3;
-		chip->pwd_reg = 3;
 		break;
 
 	case OPTi9XX_HW_82C924:
-		chip->mc_base = 0xf8c;
 		chip->password = 0xe5;
-		chip->pwd_reg = 3;
 		break;
 
 	default:
@@ -1014,17 +1043,22 @@ static int __devinit snd_miro_configure(struct snd_miro *chip)
 		return -EINVAL;
 	}
 
-	switch (chip->wss_base) {
-	case 0x530:
+	/* PnP resource says it decodes only 10 bits of address */
+	switch (chip->wss_base & 0x3ff) {
+	case 0x130:
+		chip->wss_base = 0x530;
 		wss_base_bits = 0x00;
 		break;
-	case 0x604:
+	case 0x204:
+		chip->wss_base = 0x604;
 		wss_base_bits = 0x03;
 		break;
-	case 0xe80:
+	case 0x280:
+		chip->wss_base = 0xe80;
 		wss_base_bits = 0x01;
 		break;
-	case 0xf40:
+	case 0x340:
+		chip->wss_base = 0xf40;
 		wss_base_bits = 0x02;
 		break;
 	default:
@@ -1238,7 +1272,7 @@ static int __devinit snd_card_miro_aci_detect(struct snd_card *card,
 static void snd_card_miro_free(struct snd_card *card)
 {
 	struct snd_miro *miro = card->private_data;
-        
+
 	release_and_free_resource(miro->res_aci_port);
 	if (miro->aci)
 		miro->aci->aci_port = 0;
@@ -1370,6 +1404,12 @@ static int __devinit snd_miro_probe(struct snd_card *card)
 
 static int __devinit snd_miro_isa_match(struct device *devptr, unsigned int n)
 {
+#ifdef CONFIG_PNP
+	if (snd_miro_pnp_is_probed)
+		return 0;
+	if (isapnp)
+		return 0;
+#endif
 	return 1;
 }
 
@@ -1487,14 +1527,155 @@ static struct isa_driver snd_miro_driver = {
 	},
 };
 
+#ifdef CONFIG_PNP
+
+static int __devinit snd_card_miro_pnp(struct snd_miro *chip,
+					struct pnp_card_link *card,
+					const struct pnp_card_device_id *pid)
+{
+	struct pnp_dev *pdev;
+	int err;
+	struct pnp_dev *devmpu;
+	struct pnp_dev *devmc;
+
+	pdev = pnp_request_card_device(card, pid->devs[0].id, NULL);
+	if (pdev == NULL)
+		return -EBUSY;
+
+	devmpu = pnp_request_card_device(card, pid->devs[1].id, NULL);
+	if (devmpu == NULL)
+		return -EBUSY;
+
+	devmc = pnp_request_card_device(card, pid->devs[2].id, NULL);
+	if (devmc == NULL)
+		return -EBUSY;
+
+	err = pnp_activate_dev(pdev);
+	if (err < 0) {
+		snd_printk(KERN_ERR "AUDIO pnp configure failure: %d\n", err);
+		return err;
+	}
+
+	err = pnp_activate_dev(devmc);
+	if (err < 0) {
+		snd_printk(KERN_ERR "OPL syntg pnp configure failure: %d\n",
+				    err);
+		return err;
+	}
+
+	port = pnp_port_start(pdev, 1);
+	fm_port = pnp_port_start(pdev, 2) + 8;
+
+	/*
+	 * The MC(0) is never accessed and the miroSOUND PCM20 card does not
+	 * include it in the PnP resource range. OPTI93x include it.
+	 */
+	chip->mc_base = pnp_port_start(devmc, 0) - 1;
+	chip->mc_base_size = pnp_port_len(devmc, 0) + 1;
+
+	irq = pnp_irq(pdev, 0);
+	dma1 = pnp_dma(pdev, 0);
+	dma2 = pnp_dma(pdev, 1);
+
+	if (mpu_port > 0) {
+		err = pnp_activate_dev(devmpu);
+		if (err < 0) {
+			snd_printk(KERN_ERR "MPU401 pnp configure failure\n");
+			mpu_port = -1;
+			return err;
+		}
+		mpu_port = pnp_port_start(devmpu, 0);
+		mpu_irq = pnp_irq(devmpu, 0);
+	}
+	return 0;
+}
+
+static int __devinit snd_miro_pnp_probe(struct pnp_card_link *pcard,
+					const struct pnp_card_device_id *pid)
+{
+	struct snd_card *card;
+	int err;
+	struct snd_miro *miro;
+
+	if (snd_miro_pnp_is_probed)
+		return -EBUSY;
+	if (!isapnp)
+		return -ENODEV;
+	err = snd_card_create(index, id, THIS_MODULE,
+				sizeof(struct snd_miro), &card);
+	if (err < 0)
+		return err;
+
+	card->private_free = snd_card_miro_free;
+	miro = card->private_data;
+
+	err = snd_card_miro_pnp(miro, pcard, pid);
+	if (err) {
+		snd_card_free(card);
+		return err;
+	}
+
+	/* only miroSOUND PCM20 and PCM12 == OPTi924 */
+	err = snd_miro_init(miro, OPTi9XX_HW_82C924);
+	if (err) {
+		snd_card_free(card);
+		return err;
+	}
+
+	err = snd_miro_opti_check(miro);
+	if (err) {
+		snd_printk(KERN_ERR "OPTI chip not found\n");
+		snd_card_free(card);
+		return err;
+	}
+
+	snd_card_set_dev(card, &pcard->card->dev);
+	err = snd_miro_probe(card);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	pnp_set_card_drvdata(pcard, card);
+	snd_miro_pnp_is_probed = 1;
+	return 0;
+}
+
+static void __devexit snd_miro_pnp_remove(struct pnp_card_link * pcard)
+{
+	snd_card_free(pnp_get_card_drvdata(pcard));
+	pnp_set_card_drvdata(pcard, NULL);
+	snd_miro_pnp_is_probed = 0;
+}
+
+static struct pnp_card_driver miro_pnpc_driver = {
+	.flags		= PNP_DRIVER_RES_DISABLE,
+	.name		= "miro",
+	.id_table	= snd_miro_pnpids,
+	.probe		= snd_miro_pnp_probe,
+	.remove		= __devexit_p(snd_miro_pnp_remove),
+};
+#endif
+
 static int __init alsa_card_miro_init(void)
 {
+#ifdef CONFIG_PNP
+	pnp_register_card_driver(&miro_pnpc_driver);
+	if (snd_miro_pnp_is_probed)
+		return 0;
+	pnp_unregister_card_driver(&miro_pnpc_driver);
+#endif
 	return isa_register_driver(&snd_miro_driver, 1);
 }
 
 static void __exit alsa_card_miro_exit(void)
 {
-	isa_unregister_driver(&snd_miro_driver);
+	if (!snd_miro_pnp_is_probed) {
+		isa_unregister_driver(&snd_miro_driver);
+		return;
+	}
+#ifdef CONFIG_PNP
+	pnp_unregister_card_driver(&miro_pnpc_driver);
+#endif
 }
 
 module_init(alsa_card_miro_init)
-- 
1.6.4


----------------------------------------------------------------------
Konkurs dla fanow Hannah Montana!
Sprawdz >> http://link.interia.pl/f2469
