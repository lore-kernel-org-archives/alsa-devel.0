From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 1/5] [v3] ASoC: fsl: use snd_soc_register_card
	to register the card
Date: Fri, 14 Sep 2012 16:14:34 -0500
Message-ID: <1347657278-25295-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AE79E264F05
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 23:14:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use snd_soc_register_card() instead of platform_device_alloc("soc-audio")
to register the sound card from the machine drivers.  The use of
platform_device_alloc is deprecated.

Although several other drivers still use platform_device_alloc(), the
Freescale drivers were not using it to pass driver data.  Instead of fixing
the driver data usage, it's better to replace the deprecated code.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/mpc8610_hpcd.c |   32 +++++++-------------------------
 sound/soc/fsl/p1022_ds.c     |   31 ++++++-------------------------
 2 files changed, 13 insertions(+), 50 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 60bcba1..9ff9318 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -192,7 +192,6 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 		container_of(dev, struct platform_device, dev);
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
-	struct platform_device *sound_device = NULL;
 	struct mpc8610_hpcd_data *machine_data;
 	int ret = -ENODEV;
 	const char *sprop;
@@ -341,34 +340,22 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	machine_data->card.probe = mpc8610_hpcd_machine_probe;
 	machine_data->card.remove = mpc8610_hpcd_machine_remove;
 	machine_data->card.name = pdev->name; /* The platform driver name */
+	machine_data->card.owner = THIS_MODULE;
+	machine_data->card.dev = &pdev->dev;
 	machine_data->card.num_links = 2;
 	machine_data->card.dai_link = machine_data->dai;
 
-	/* Allocate a new audio platform device structure */
-	sound_device = platform_device_alloc("soc-audio", -1);
-	if (!sound_device) {
-		dev_err(&pdev->dev, "platform device alloc failed\n");
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	/* Associate the card data with the sound device */
-	platform_set_drvdata(sound_device, &machine_data->card);
-
 	/* Register with ASoC */
-	ret = platform_device_add(sound_device);
+	ret = snd_soc_register_card(&machine_data->card);
 	if (ret) {
-		dev_err(&pdev->dev, "platform device add failed\n");
-		goto error_sound;
+		dev_err(&pdev->dev, "could not register card\n");
+		goto error;
 	}
-	dev_set_drvdata(&pdev->dev, sound_device);
 
 	of_node_put(codec_np);
 
 	return 0;
 
-error_sound:
-	platform_device_put(sound_device);
 error:
 	kfree(machine_data);
 error_alloc:
@@ -383,17 +370,12 @@ error_alloc:
  */
 static int __devexit mpc8610_hpcd_remove(struct platform_device *pdev)
 {
-	struct platform_device *sound_device = dev_get_drvdata(&pdev->dev);
-	struct snd_soc_card *card = platform_get_drvdata(sound_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct mpc8610_hpcd_data *machine_data =
 		container_of(card, struct mpc8610_hpcd_data, card);
 
-	platform_device_unregister(sound_device);
-
+	snd_soc_unregister_card(card);
 	kfree(machine_data);
-	sound_device->dev.platform_data = NULL;
-
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 50adf40..144d496 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -202,7 +202,6 @@ static int p1022_ds_probe(struct platform_device *pdev)
 		container_of(dev, struct platform_device, dev);
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
-	struct platform_device *sound_device = NULL;
 	struct machine_data *mdata;
 	int ret = -ENODEV;
 	const char *sprop;
@@ -349,36 +348,23 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	mdata->card.probe = p1022_ds_machine_probe;
 	mdata->card.remove = p1022_ds_machine_remove;
 	mdata->card.name = pdev->name; /* The platform driver name */
+	mdata->card.owner = THIS_MODULE;
+	mdata->card.dev = &pdev->dev;
 	mdata->card.num_links = 2;
 	mdata->card.dai_link = mdata->dai;
 
-	/* Allocate a new audio platform device structure */
-	sound_device = platform_device_alloc("soc-audio", -1);
-	if (!sound_device) {
-		dev_err(&pdev->dev, "platform device alloc failed\n");
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	/* Associate the card data with the sound device */
-	platform_set_drvdata(sound_device, &mdata->card);
-
 	/* Register with ASoC */
-	ret = platform_device_add(sound_device);
+	ret = snd_soc_register_card(&mdata->card);
 	if (ret) {
-		dev_err(&pdev->dev, "platform device add failed\n");
+		dev_err(&pdev->dev, "could not register card\n");
 		goto error;
 	}
-	dev_set_drvdata(&pdev->dev, sound_device);
 
 	of_node_put(codec_np);
 
 	return 0;
 
 error:
-	if (sound_device)
-		platform_device_put(sound_device);
-
 	kfree(mdata);
 error_put:
 	of_node_put(codec_np);
@@ -392,17 +378,12 @@ error_put:
  */
 static int __devexit p1022_ds_remove(struct platform_device *pdev)
 {
-	struct platform_device *sound_device = dev_get_drvdata(&pdev->dev);
-	struct snd_soc_card *card = platform_get_drvdata(sound_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct machine_data *mdata =
 		container_of(card, struct machine_data, card);
 
-	platform_device_unregister(sound_device);
-
+	snd_soc_unregister_card(card);
 	kfree(mdata);
-	sound_device->dev.platform_data = NULL;
-
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
 }
-- 
1.7.3.4
