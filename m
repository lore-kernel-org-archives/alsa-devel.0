From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] aoa: remove driver_data direct access of
	struct device
Date: Mon, 11 May 2009 21:54:51 +0200
Message-ID: <4A08828B.7090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id F389C2440C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 21:54:51 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4061638ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 12:54:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: johannes@sipsolutions.net
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

To avoid direct access to the driver_data pointer in struct device, the
functions dev_get_drvdata() and dev_set_drvdata() should be used.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index fbf5c93..586965f 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1037,7 +1037,7 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 	}
 	ldev->selfptr_headphone.ptr = ldev;
 	ldev->selfptr_lineout.ptr = ldev;
-	sdev->ofdev.dev.driver_data = ldev;
+	dev_set_drvdata(&sdev->ofdev.dev, ldev);
 	list_add(&ldev->list, &layouts_list);
 	layouts_list_items++;
 
@@ -1081,7 +1081,7 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 
 static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
 {
-	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
 	int i;
 
 	for (i=0; i<MAX_CODECS_PER_BUS; i++) {
@@ -1114,7 +1114,7 @@ static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
 #ifdef CONFIG_PM
 static int aoa_fabric_layout_suspend(struct soundbus_dev *sdev, pm_message_t state)
 {
-	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
 
 	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
 		ldev->gpio.methods->all_amps_off(&ldev->gpio);
@@ -1124,7 +1124,7 @@ static int aoa_fabric_layout_suspend(struct soundbus_dev *sdev, pm_message_t sta
 
 static int aoa_fabric_layout_resume(struct soundbus_dev *sdev)
 {
-	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
 
 	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
 		ldev->gpio.methods->all_amps_restore(&ldev->gpio);
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 418c84c..4e3b819 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -358,14 +358,14 @@ static int i2sbus_probe(struct macio_dev* dev, const struct of_device_id *match)
 		return -ENODEV;
 	}
 
-	dev->ofdev.dev.driver_data = control;
+	dev_set_drvdata(&dev->ofdev.dev, control);
 
 	return 0;
 }
 
 static int i2sbus_remove(struct macio_dev* dev)
 {
-	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct i2sbus_control *control = dev_get_drvdata(&dev->ofdev.dev);
 	struct i2sbus_dev *i2sdev, *tmp;
 
 	list_for_each_entry_safe(i2sdev, tmp, &control->list, item)
@@ -377,7 +377,7 @@ static int i2sbus_remove(struct macio_dev* dev)
 #ifdef CONFIG_PM
 static int i2sbus_suspend(struct macio_dev* dev, pm_message_t state)
 {
-	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct i2sbus_control *control = dev_get_drvdata(&dev->ofdev.dev);
 	struct codec_info_item *cii;
 	struct i2sbus_dev* i2sdev;
 	int err, ret = 0;
@@ -407,7 +407,7 @@ static int i2sbus_suspend(struct macio_dev* dev, pm_message_t state)
 
 static int i2sbus_resume(struct macio_dev* dev)
 {
-	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct i2sbus_control *control = dev_get_drvdata(&dev->ofdev.dev);
 	struct codec_info_item *cii;
 	struct i2sbus_dev* i2sdev;
 	int err, ret = 0;
