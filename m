From: Rodolfo Giometti <giometti@linux.it>
Subject: [PATCH] Au1xxx sound registration and power management
Date: Thu, 20 Jul 2006 09:37:00 +0200
Message-ID: <20060720073659.GE6887@enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UTZ8bGhNySVQ9LYl"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.enneenne.com (81-174-11-161.f5.ngi.it [81.174.11.161])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F72D14E
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 09:36:56 +0200 (MEST)
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50) id 1G3S6r-0002qn-TO
	for alsa-devel@alsa-project.org; Thu, 20 Jul 2006 08:34:10 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>) id 1G3T5g-0002MJ-0Y
	for alsa-devel@alsa-project.org; Thu, 20 Jul 2006 09:37:00 +0200
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

here a patch to support device registration and power management for
the au1xxx ALSA driver.

Ciao,

Rodolfo

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1000_snd-pm-and-registration
Content-Transfer-Encoding: quoted-printable

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/p=
latform.c
index 0088889..34de6d3 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -88,6 +88,31 @@ static struct platform_device au1xxx_eth
 #endif
 #endif
=20
+#if defined(CONFIG_SND_AU1X00)
+/* AC97 controller */
+static struct resource au1xxx_snd_resources[] =3D {
+	[0] =3D {
+		.name   =3D "snd-base",
+		.start  =3D AC97C_BASE,
+		.end    =3D AC97C_BASE + AC97_IOSIZE - 1,
+		.flags  =3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.name	=3D "snd-irq",
+		.start	=3D AU1000_AC97C_INT,
+		.end	=3D AU1000_AC97C_INT,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device au1xxx_snd_device =3D {
+		.name   =3D "au1xxx-snd",
+		.id             =3D -1,
+		.num_resources  =3D ARRAY_SIZE(au1xxx_snd_resources),
+		.resource       =3D au1xxx_snd_resources,
+};
+#endif
+
 /* OHCI (USB full speed host controller) */
 static struct resource au1xxx_usb_ohci_resources[] =3D {
 	[0] =3D {
@@ -376,6 +401,9 @@ #if defined(CONFIG_SOC_AU1000) || \
 	&au1xxx_eth1_device,
 #endif
 #endif
+#if defined(CONFIG_SND_AU1X00)
+	&au1xxx_snd_device,
+#endif
 	&au1xxx_usb_ohci_device,
 	&au1x00_pcmcia_device,
 #ifdef CONFIG_FB_AU1100
diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-=
au1x00/au1000.h
index 0988af9..cb8939a 100644
--- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
@@ -1600,6 +1600,9 @@ #define SYS_CPUPLL                0xB190
 #define SYS_AUXPLL                0xB1900064
=20
 /* AC97 Controller */
+#define AC97C_BASE              AC97_PHYS_ADDR
+#define AC97_IOSIZE		0x14
+
 #define AC97C_CONFIG              0xB0000000
   #define AC97C_RECV_SLOTS_BIT  13
   #define AC97C_RECV_SLOTS_MASK (0x3ff << AC97C_RECV_SLOTS_BIT)
diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index cf476fe..2dd6862 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -5,6 +5,8 @@
  * Copyright 2004 Cooper Street Innovations Inc.
  * Author: Charles Eidsness	<charles@cooper-street.com>
  *
+ * PM support added by Rodolfo Giometti <giometti@linux.it>
+ *
  *  This program is free software; you can redistribute  it and/or modify =
it
  *  under  the terms of  the GNU General  Public License as published by t=
he
  *  Free Software Foundation;  either version 2 of the  License, or (at yo=
ur
@@ -40,6 +42,7 @@ #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/version.h>
+#include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -53,6 +56,8 @@ MODULE_DESCRIPTION("Au1000 AC'97 ALSA Dr
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{AMD,Au1000 AC'97}}");
=20
+#define DRV_NAME        "au1xxx-snd"
+
 #define PLAYBACK 0
 #define CAPTURE 1
 #define AC97_SLOT_3 0x01
@@ -526,7 +531,6 @@ get the interupt driven case to work eff
=20
 }
=20
-
 static void
 snd_au1000_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned =
short val)
 {
@@ -550,24 +554,17 @@ get the interupt driven case to work eff
 	spin_unlock(&au1000->ac97_lock);
 }
=20
+static struct snd_ac97_bus_ops au1000_ac97_ops =3D {
+	.write =3D snd_au1000_ac97_write,
+	.read =3D snd_au1000_ac97_read,
+};
+
 static int __devinit
 snd_au1000_ac97_new(struct snd_au1000 *au1000)
 {
 	int err;
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
- 	static struct snd_ac97_bus_ops ops =3D {
-		.write =3D snd_au1000_ac97_write,
-		.read =3D snd_au1000_ac97_read,
-	};
-
-	if ((au1000->ac97_res_port =3D request_mem_region(CPHYSADDR(AC97C_CONFIG),
-	       		0x100000, "Au1x00 AC97")) =3D=3D NULL) {
-		snd_printk(KERN_ERR "ALSA AC97: can't grap AC97 port\n");
-		return -EBUSY;
-	}
-	au1000->ac97_ioport =3D (struct au1000_ac97_reg *)
-		KSEG1ADDR(au1000->ac97_res_port->start);
=20
 	spin_lock_init(&au1000->ac97_lock);
=20
@@ -588,7 +585,7 @@ snd_au1000_ac97_new(struct snd_au1000 *a
 	mdelay(5);
=20
 	/* Initialise AC97 middle-layer */
-	if ((err =3D snd_ac97_bus(au1000->card, 0, &ops, au1000, &pbus)) < 0)
+	if ((err =3D snd_ac97_bus(au1000->card, 0, &au1000_ac97_ops, au1000, &pbu=
s)) < 0)
  		return err;
=20
 	memset(&ac97, 0, sizeof(ac97));
@@ -626,68 +623,154 @@ snd_au1000_free(struct snd_card *card)
 	}
 }
=20
+#ifdef CONFIG_PM
+static u32 au1000_ac97_config;
+
+static int au1000_drv_suspend(struct platform_device *pdev, pm_message_t s=
tate)
+{
+	struct snd_card *card =3D platform_get_drvdata(pdev);
+	struct snd_au1000 *au1000 =3D card->private_data;
+
+	if (!card)
+		return 0;
=20
-static struct snd_card *au1000_card;
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
+	snd_pcm_suspend_all(au1000->pcm);
+	snd_ac97_suspend(au1000->ac97);
+
+	/* Save Au1000's AC'97 Control Block and disable the controller */
+	au1000_ac97_config =3D au1000->ac97_ioport->config;
+	au1000->ac97_ioport->cntrl =3D AC97C_RS;
+
+	return 0;
+}
=20
-static int __init
-au1000_init(void)
+static int au1000_drv_resume(struct platform_device *pdev)
 {
-	int err;
-	struct snd_card *card;
-	struct snd_au1000 *au1000;
+	struct snd_card *card =3D platform_get_drvdata(pdev);
+	struct snd_au1000 *au1000 =3D card->private_data;
+
+	if (!card)
+		return 0;
=20
+	/* Initialise Au1000's AC'97 Control Block and restore previous
+	 * configuration */
+	au1000->ac97_ioport->cntrl =3D AC97C_RS | AC97C_CE;
+	udelay(10);
+	au1000->ac97_ioport->cntrl =3D AC97C_CE;
+	udelay(10);
+	au1000->ac97_ioport->config =3D au1000_ac97_config;
+
+	snd_ac97_resume(au1000->ac97);
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+
+	return 0;
+}
+#endif
+
+static int __init au1000_drv_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct snd_card *card =3D NULL;
+	struct snd_au1000 *au1000 =3D NULL;
+	int ret;
+
+	/* Get the resource info */
+	ret =3D -ENODEV;
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "snd-base");
+	if (!res)
+		goto exit;
+
+	ret =3D -ENOMEM;
 	card =3D snd_card_new(-1, "AC97", THIS_MODULE, sizeof(struct snd_au1000));
 	if (card =3D=3D NULL)
-		return -ENOMEM;
+		goto exit;
=20
+	card->dev =3D &pdev->dev;
 	card->private_free =3D snd_au1000_free;
 	au1000 =3D card->private_data;
 	au1000->card =3D card;
=20
+	au1000->ac97_res_port =3D res;
+	au1000->ac97_ioport =3D ioremap(res->start, res->end - res->start + 1);
+	ret =3D -ENOMEM;
+	if (!au1000->ac97_ioport) {
+		printk (KERN_ERR "%s: unable to remap address %lx\n",
+			DRV_NAME, res->start);
+		goto exit;
+	}
+
 	au1000->stream[PLAYBACK] =3D kmalloc(sizeof(struct audio_stream), GFP_KER=
NEL);
 	au1000->stream[CAPTURE ] =3D kmalloc(sizeof(struct audio_stream), GFP_KER=
NEL);
 	/* so that snd_au1000_free will work as intended */
- 	au1000->ac97_res_port =3D NULL;
 	if (au1000->stream[PLAYBACK])
 		au1000->stream[PLAYBACK]->dma =3D -1;
 	if (au1000->stream[CAPTURE ])
 		au1000->stream[CAPTURE ]->dma =3D -1;
=20
 	if (au1000->stream[PLAYBACK] =3D=3D NULL ||
-	    au1000->stream[CAPTURE ] =3D=3D NULL) {
-		snd_card_free(card);
-		return -ENOMEM;
-	}
+	    au1000->stream[CAPTURE ] =3D=3D NULL)
+		goto exit;
=20
-	if ((err =3D snd_au1000_ac97_new(au1000)) < 0 ) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((ret =3D snd_au1000_ac97_new(au1000)) < 0)
+		goto exit;
=20
-	if ((err =3D snd_au1000_pcm_new(au1000)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((ret =3D snd_au1000_pcm_new(au1000)) < 0)
+		goto exit;
=20
 	strcpy(card->driver, "Au1000-AC97");
 	strcpy(card->shortname, "AMD Au1000-AC97");
 	sprintf(card->longname, "AMD Au1000--AC97 ALSA Driver");
=20
-	if ((err =3D snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((ret =3D snd_card_register(card)) < 0)
+		goto exit;
+	platform_set_drvdata(pdev, card);
=20
 	printk( KERN_INFO "ALSA AC97: Driver Initialized\n" );
-	au1000_card =3D card;
+
 	return 0;
+
+exit :
+	if (au1000 && au1000->ac97_ioport)
+		iounmap(au1000->ac97_ioport);
+	if (card)
+		snd_card_free(card);
+
+	return ret;
 }
=20
-static void __exit au1000_exit(void)
+static int __exit au1000_drv_remove(struct platform_device *pdev)
 {
-	snd_card_free(au1000_card);
+	struct snd_card *card =3D platform_get_drvdata(pdev);
+
+	if (card)
+		snd_card_free(card);
+
+	return 0;
 }
=20
-module_init(au1000_init);
-module_exit(au1000_exit);
+static struct platform_driver au1000_driver =3D {
+	.probe		=3D au1000_drv_probe,
+	.remove		=3D au1000_drv_remove,
+#ifdef CONFIG_PM
+	.suspend	=3D au1000_drv_suspend,
+	.resume		=3D au1000_drv_resume,
+#endif
+	.driver		=3D {
+		.name	=3D DRV_NAME,
+	},
+};
+
+
+static int __init au1000_snd_init(void)
+{
+	return platform_driver_register(&au1000_driver);
+}
+
+static void __exit au1000_snd_exit(void)
+{
+	platform_driver_unregister(&au1000_driver);
+}
=20
+module_init(au1000_snd_init);
+module_exit(au1000_snd_exit);

--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--UTZ8bGhNySVQ9LYl--
