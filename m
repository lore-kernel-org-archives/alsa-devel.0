From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] dbri: conversion to OpenFirmware framework
Date: Sun, 2 Sep 2007 09:31:09 +0200
Message-ID: <20070902093109.d415575c.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id DB8C3103892
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Sep 2007 09:25:15 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 2 Sep 2007 09:25:06 +0200
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
Cc: David Miller <davem@davemloft.net>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch converts the dbri driver to use OF framework.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires the previous dbri patch with more
code improvements posted yesterday.

Dave, please let this patch go through the ALSA tree
for merging.

--- old/sound/sparc/dbri.c	2007-09-01 22:48:24.000000000 +0200
+++ new/sound/sparc/dbri.c	2007-09-02 09:21:11.491872881 +0200
@@ -66,6 +66,7 @@
 #include <sound/control.h>
 #include <sound/initval.h>
 
+#include <asm/prom.h>
 #include <asm/sbus.h>
 #include <asm/atomic.h>
 
@@ -296,8 +297,6 @@ struct dbri_streaminfo {
 
 /* This structure holds the information for both chips (DBRI & CS4215) */
 struct snd_dbri {
-	struct snd_card *card;	/* ALSA card */
-
 	int regs_size, irq;	/* Needed for unload */
 	struct sbus_dev *sdev;	/* SBUS device info */
 	spinlock_t lock;
@@ -318,8 +317,6 @@ struct snd_dbri {
 	struct cs4215 mm;	/* mmcodec special info */
 				/* per stream (playback/record) info */
 	struct dbri_streaminfo stream_info[DBRI_NO_STREAMS];
-
-	struct snd_dbri *next;
 };
 
 #define DBRI_MAX_VOLUME		63	/* Output volume */
@@ -571,8 +568,6 @@ struct snd_dbri {
 #define DBRI_STREAM(dbri, substream)	\
 		&dbri->stream_info[DBRI_STREAMNO(substream)]
 
-static struct snd_dbri *dbri_list;	/* All DBRI devices */
-
 /*
  * Short data pipes transmit LSB first. The CS4215 receives MSB first. Grrr.
  * So we have to reverse the bits. Note: not all bit lengths are supported
@@ -2216,12 +2211,12 @@ static struct snd_pcm_ops snd_dbri_ops =
 	.pointer = snd_dbri_pointer,
 };
 
-static int __devinit snd_dbri_pcm(struct snd_dbri *dbri)
+static int __devinit snd_dbri_pcm(struct snd_card *card)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if ((err = snd_pcm_new(dbri->card,
+	if ((err = snd_pcm_new(card,
 			       /* ID */		    "sun_dbri",
 			       /* device */	    0,
 			       /* playback count */ 1,
@@ -2232,9 +2227,9 @@ static int __devinit snd_dbri_pcm(struct
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_dbri_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_dbri_ops);
 
-	pcm->private_data = dbri;
+	pcm->private_data = card->private_data;
 	pcm->info_flags = 0;
-	strcpy(pcm->name, dbri->card->shortname);
+	strcpy(pcm->name, card->shortname);
 
 	if ((err = snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_CONTINUOUS,
@@ -2420,20 +2415,22 @@ static struct snd_kcontrol_new dbri_cont
 	CS4215_SINGLE("Mic boost", 4, 4, 1, 1)
 };
 
-static int __init snd_dbri_mixer(struct snd_dbri *dbri)
+static int __devinit snd_dbri_mixer(struct snd_card *card)
 {
-	struct snd_card *card;
 	int idx, err;
+	struct snd_dbri *dbri;
 
-	snd_assert(dbri != NULL && dbri->card != NULL, return -EINVAL);
+	snd_assert(card != NULL && card->private_data != NULL, return -EINVAL);
+	dbri = card->private_data;
 
-	card = dbri->card;
 	strcpy(card->mixername, card->shortname);
 
-	for (idx = 0; idx < ARRAY_SIZE(dbri_controls); idx++)
-		if ((err = snd_ctl_add(card,
-				snd_ctl_new1(&dbri_controls[idx], dbri))) < 0)
+	for (idx = 0; idx < ARRAY_SIZE(dbri_controls); idx++) {
+		err = snd_ctl_add(card,
+				  snd_ctl_new1(&dbri_controls[idx], dbri));
+		if (err < 0)
 			return err;
+	}
 
 	for (idx = DBRI_REC; idx < DBRI_NO_STREAMS; idx++) {
 		dbri->stream_info[idx].left_gain = 0;
@@ -2480,15 +2477,16 @@ static void dbri_debug_read(struct snd_i
 }
 #endif
 
-void snd_dbri_proc(struct snd_dbri *dbri)
+void __devinit snd_dbri_proc(struct snd_card *card)
 {
+	struct snd_dbri *dbri = card->private_data;
 	struct snd_info_entry *entry;
 
-	if (!snd_card_proc_new(dbri->card, "regs", &entry))
+	if (!snd_card_proc_new(card, "regs", &entry))
 		snd_info_set_text_ops(entry, dbri, dbri_regs_read);
 
 #ifdef DBRI_DEBUG
-	if (!snd_card_proc_new(dbri->card, "debug", &entry)) {
+	if (!snd_card_proc_new(card, "debug", &entry)) {
 		snd_info_set_text_ops(entry, dbri, dbri_debug_read);
 		entry->mode = S_IFREG | S_IRUGO;	/* Readable only. */
 	}
@@ -2502,17 +2500,16 @@ void snd_dbri_proc(struct snd_dbri *dbri
 */
 static void snd_dbri_free(struct snd_dbri *dbri);
 
-static int __init snd_dbri_create(struct snd_card *card,
+static int __devinit snd_dbri_create(struct snd_card *card,
 				  struct sbus_dev *sdev,
-				  struct linux_prom_irqs *irq, int dev)
+				  int irq, int dev)
 {
 	struct snd_dbri *dbri = card->private_data;
 	int err;
 
 	spin_lock_init(&dbri->lock);
-	dbri->card = card;
 	dbri->sdev = sdev;
-	dbri->irq = irq->pri;
+	dbri->irq = irq;
 
 	dbri->dma = sbus_alloc_consistent(sdev, sizeof(struct dbri_dma),
 					  &dbri->dma_dvma);
@@ -2550,9 +2547,6 @@ static int __init snd_dbri_create(struct
 		return err;
 	}
 
-	dbri->next = dbri_list;
-	dbri_list = dbri;
-
 	return 0;
 }
 
@@ -2572,20 +2566,19 @@ static void snd_dbri_free(struct snd_dbr
 				     (void *)dbri->dma, dbri->dma_dvma);
 }
 
-static int __init dbri_attach(int prom_node, struct sbus_dev *sdev)
+static int __devinit dbri_probe(struct of_device *of_dev,
+				const struct of_device_id *match)
 {
+	struct sbus_dev *sdev = to_sbus_device(&of_dev->dev);
 	struct snd_dbri *dbri;
-	struct linux_prom_irqs irq;
+	int irq;
 	struct resource *rp;
 	struct snd_card *card;
 	static int dev = 0;
 	int err;
 
-	if (sdev->prom_name[9] < 'e') {
-		printk(KERN_ERR "DBRI: unsupported chip version %c found.\n",
-		       sdev->prom_name[9]);
-		return -EIO;
-	}
+	dprintk(D_GEN, "DBRI: Found %s in SBUS slot %d\n",
+		sdev->prom_name, sdev->slot);
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
@@ -2594,10 +2587,9 @@ static int __init dbri_attach(int prom_n
 		return -ENOENT;
 	}
 
-	err = prom_getproperty(prom_node, "intr", (char *)&irq, sizeof(irq));
-	if (err < 0) {
-		printk(KERN_ERR "DBRI-%d: Firmware node lacks IRQ property.\n",
-			dev);
+	irq = sdev->irqs[0];
+	if (irq <= 0) {
+		printk(KERN_ERR "DBRI-%d: No IRQ.\n", dev);
 		return -ENODEV;
 	}
 
@@ -2611,22 +2603,23 @@ static int __init dbri_attach(int prom_n
 	rp = &sdev->resource[0];
 	sprintf(card->longname, "%s at 0x%02lx:0x%016Lx, irq %d",
 		card->shortname,
-		rp->flags & 0xffL, (unsigned long long)rp->start, irq.pri);
+		rp->flags & 0xffL, (unsigned long long)rp->start, irq);
 
-	if ((err = snd_dbri_create(card, sdev, &irq, dev)) < 0) {
+	if ((err = snd_dbri_create(card, sdev, irq, dev)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
 	dbri = card->private_data;
-	if ((err = snd_dbri_pcm(dbri)) < 0)
+	if ((err = snd_dbri_pcm(card)) < 0)
 		goto _err;
 
-	if ((err = snd_dbri_mixer(dbri)) < 0)
+	if ((err = snd_dbri_mixer(card)) < 0)
 		goto _err;
 
 	/* /proc file handling */
-	snd_dbri_proc(dbri);
+	snd_dbri_proc(card);
+	dev_set_drvdata(&of_dev->dev, card);
 
 	err = snd_card_register(card);
 	if (err < 0)
@@ -2645,42 +2638,46 @@ _err:
 	return err;
 }
 
-/* Probe for the dbri chip and then attach the driver. */
-static int __init dbri_init(void)
+static int __devexit dbri_remove(struct of_device *dev)
 {
-	struct sbus_bus *sbus;
-	struct sbus_dev *sdev;
-	int found = 0;
-
-	/* Probe each SBUS for the DBRI chip(s). */
-	for_all_sbusdev(sdev, sbus)
-		/*
-		 * The version is coded in the last character
-		 */
-		if (!strncmp(sdev->prom_name, "SUNW,DBRI", 9)) {
-			dprintk(D_GEN, "DBRI: Found %s in SBUS slot %d\n",
-				sdev->prom_name, sdev->slot);
+	struct snd_card *card = dev_get_drvdata(&dev->dev);
 
-			if (dbri_attach(sdev->prom_node, sdev) == 0)
-				found++;
-		}
+	snd_dbri_free(card->private_data);
+	snd_card_free(card);
+
+	dev_set_drvdata(&dev->dev, NULL);
 
-	return (found > 0) ? 0 : -EIO;
+	return 0;
 }
 
-static void __exit dbri_exit(void)
-{
-	struct snd_dbri *this = dbri_list;
+static struct of_device_id dbri_match[] = {
+	{
+		.name = "SUNW,DBRIe",
+	},
+	{
+		.name = "SUNW,DBRIf",
+	},
+	{},
+};
 
-	while (this != NULL) {
-		struct snd_dbri *next = this->next;
-		struct snd_card *card = this->card;
+MODULE_DEVICE_TABLE(of, dbri_match);
 
-		snd_dbri_free(this);
-		snd_card_free(card);
-		this = next;
-	}
-	dbri_list = NULL;
+static struct of_platform_driver dbri_sbus_driver = {
+	.name		= "dbri",
+	.match_table	= dbri_match,
+	.probe		= dbri_probe,
+	.remove		= __devexit_p(dbri_remove),
+};
+
+/* Probe for the dbri chip and then attach the driver. */
+static int __init dbri_init(void)
+{
+	return of_register_driver(&dbri_sbus_driver, &sbus_bus_type);
+}
+
+static void __exit dbri_exit(void)
+{
+	of_unregister_driver(&dbri_sbus_driver);
 }
 
 module_init(dbri_init);
