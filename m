From: Ben Dooks <ben@simtec.co.uk>
Subject: tlv320aic3x: Allow driver to use already registered
	i2c device
Date: Fri, 07 Aug 2009 00:02:05 +0100
Message-ID: <20090806230204.992074844@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EB6310380E
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 01:02:05 +0200 (CEST)
Content-Disposition: inline; filename=dbg-tlv320aic33.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add the ability for the driver to use an already registered i2c device
instead of creating one of them itself. Add the field i2c_already field
to the setup data and not set the i2c bus address the driver will then
use the device already setup.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 sound/soc/codecs/tlv320aic3x.c |    9 ++++++++-
 sound/soc/codecs/tlv320aic3x.h |    1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

Index: b/sound/soc/codecs/tlv320aic3x.c
===================================================================
--- a/sound/soc/codecs/tlv320aic3x.c	2009-08-06 11:53:30.000000000 +0100
+++ b/sound/soc/codecs/tlv320aic3x.c	2009-08-06 15:29:45.000000000 +0100
@@ -1310,6 +1310,7 @@ static int aic3x_i2c_remove(struct i2c_c
 
 static const struct i2c_device_id aic3x_i2c_id[] = {
 	{ "tlv320aic3x", 0 },
+	{ "tlv320aic33", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
@@ -1405,6 +1406,10 @@ static int aic3x_probe(struct platform_d
 		codec->hw_write = (hw_write_t) i2c_master_send;
 		codec->hw_read = (hw_read_t) aic3x_i2c_read;
 		ret = aic3x_add_i2c_device(pdev, setup);
+	} else if (setup->i2c_already) {
+		codec->hw_write = (hw_write_t) i2c_master_send;
+		codec->hw_read = (hw_read_t) aic3x_i2c_read;
+		i2c_add_driver(&aic3x_i2c_driver);
 	}
 #else
 	/* Add other interfaces here */
@@ -1421,6 +1426,7 @@ static int aic3x_remove(struct platform_
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct aic3x_setup_data *setup = socdev->codec_data;
 
 	/* power down chip */
 	if (codec->control_data)
@@ -1429,7 +1435,8 @@ static int aic3x_remove(struct platform_
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
+	if (setup && !setup->i2c_already)
+		i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&aic3x_i2c_driver);
 #endif
 	kfree(codec->private_data);
Index: b/sound/soc/codecs/tlv320aic3x.h
===================================================================
--- a/sound/soc/codecs/tlv320aic3x.h	2009-08-06 11:53:30.000000000 +0100
+++ b/sound/soc/codecs/tlv320aic3x.h	2009-08-06 12:11:03.000000000 +0100
@@ -283,6 +283,7 @@ int aic3x_button_pressed(struct snd_soc_
 
 struct aic3x_setup_data {
 	int i2c_bus;
+	unsigned char i2c_already;	/* i2c device already registered */
 	unsigned short i2c_address;
 	unsigned int gpio_func[2];
 };

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
