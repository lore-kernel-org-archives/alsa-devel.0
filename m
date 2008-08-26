From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8903 I2C cleanups
Date: Tue, 26 Aug 2008 15:29:11 +0100
Message-ID: <1219760951-21283-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9439924718
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 16:29:12 +0200 (CEST)
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
Cc: Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Fix a few issues identified by Jean Delvare:

 - Add missing newline to error display.
 - Return an error when we fail to locate the I2C adaptor.
 - Remove the static wm8903_i2c_device Jean suggested, it's redundant.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 73dfd5b..a3f54ec 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1706,8 +1706,6 @@ static struct i2c_driver wm8903_i2c_driver = {
 	.id_table = wm8903_i2c_id,
 };
 
-static struct i2c_client *wm8903_i2c_device;
-
 static int wm8903_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -1716,6 +1714,7 @@ static int wm8903_probe(struct platform_device *pdev)
 	struct wm8903_priv *wm8903;
 	struct i2c_board_info board_info;
 	struct i2c_adapter *adapter;
+	struct i2c_client *i2c_client;
 	int ret = 0;
 
 	setup = socdev->codec_data;
@@ -1746,7 +1745,7 @@ static int wm8903_probe(struct platform_device *pdev)
 	codec->hw_write = (hw_write_t)i2c_master_send;
 	ret = i2c_add_driver(&wm8903_i2c_driver);
 	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver");
+		dev_err(&pdev->dev, "can't add i2c driver\n");
 		goto err_priv;
 	} else {
 		memset(&board_info, 0, sizeof(board_info));
@@ -1757,12 +1756,13 @@ static int wm8903_probe(struct platform_device *pdev)
 		if (!adapter) {
 			dev_err(&pdev->dev, "Can't get I2C bus %d\n",
 				setup->i2c_bus);
+			ret = -ENODEV;
 			goto err_adapter;
 		}
 
-		wm8903_i2c_device = i2c_new_device(adapter, &board_info);
+		i2c_client = i2c_new_device(adapter, &board_info);
 		i2c_put_adapter(adapter);
-		if (wm8903_i2c_device == NULL) {
+		if (i2c_client == NULL) {
 			dev_err(&pdev->dev,
 				"I2C driver registration failed\n");
 			ret = -ENODEV;
@@ -1792,7 +1792,7 @@ static int wm8903_remove(struct platform_device *pdev)
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-	i2c_unregister_device(wm8903_i2c_device);
+	i2c_unregister_device(socdev->codec->control_data);
 	i2c_del_driver(&wm8903_i2c_driver);
 	kfree(codec->private_data);
 	kfree(codec);
-- 
1.5.6.5
