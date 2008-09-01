From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: Don't suggest compile time selection
	of codec access
Date: Mon,  1 Sep 2008 18:47:04 +0100
Message-ID: <1220291224-11269-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6A211037F8
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 19:47:06 +0200 (CEST)
In-Reply-To: <1220291224-11269-7-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently the boiler plate code used by most ASoC codecs to provide a
placeholder for SPI access suggests making the selection of SPI a
compile time option which is suboptimal when trying to build kernels
supporting multiple systems.  Change this template to suggest allowing
runtime selection instead.

Leave the drivers not yet converted to new style I2C access for now to
avoid collisions.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4535.c  |    6 +++---
 sound/soc/codecs/uda1380.c |    6 +++---
 sound/soc/codecs/wm8750.c  |    6 +++---
 sound/soc/codecs/wm8990.c  |    6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index e512cd7..088cf99 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -622,7 +622,7 @@ static int ak4535_probe(struct platform_device *pdev)
 	struct ak4535_setup_data *setup;
 	struct snd_soc_codec *codec;
 	struct ak4535_priv *ak4535;
-	int ret = 0;
+	int ret;
 
 	printk(KERN_INFO "AK4535 Audio Codec %s", AK4535_VERSION);
 
@@ -644,14 +644,14 @@ static int ak4535_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	ak4535_socdev = socdev;
+	ret = -ENODEV;
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		codec->hw_write = (hw_write_t)i2c_master_send;
 		codec->hw_read = (hw_read_t)i2c_master_recv;
 		ret = ak4535_add_i2c_device(pdev, setup);
 	}
-#else
-	/* Add other interfaces here */
 #endif
 
 	if (ret != 0) {
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index f0c8043..d206d7f 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -788,7 +788,7 @@ static int uda1380_probe(struct platform_device *pdev)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct uda1380_setup_data *setup;
 	struct snd_soc_codec *codec;
-	int ret = 0;
+	int ret;
 
 	pr_info("UDA1380 Audio Codec %s", UDA1380_VERSION);
 
@@ -803,13 +803,13 @@ static int uda1380_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	uda1380_socdev = socdev;
+	ret = -ENODEV;
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = uda1380_add_i2c_device(pdev, setup);
 	}
-#else
-	/* Add other interfaces here */
 #endif
 
 	if (ret != 0)
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 34d8465..9847aa0 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -934,7 +934,7 @@ static int wm8750_probe(struct platform_device *pdev)
 	struct wm8750_setup_data *setup = socdev->codec_data;
 	struct snd_soc_codec *codec;
 	struct wm8750_priv *wm8750;
-	int ret = 0;
+	int ret;
 
 	pr_info("WM8750 Audio Codec %s", WM8750_VERSION);
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
@@ -955,13 +955,13 @@ static int wm8750_probe(struct platform_device *pdev)
 	wm8750_socdev = socdev;
 	INIT_DELAYED_WORK(&codec->delayed_work, wm8750_work);
 
+	ret = -ENODEV;
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = wm8750_add_i2c_device(pdev, setup);
 	}
-#else
-		/* Add other interfaces here */
 #endif
 
 	if (ret != 0) {
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index e1bb505..63410d7 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1565,7 +1565,7 @@ static int wm8990_probe(struct platform_device *pdev)
 	struct wm8990_setup_data *setup;
 	struct snd_soc_codec *codec;
 	struct wm8990_priv *wm8990;
-	int ret = 0;
+	int ret;
 
 	pr_info("WM8990 Audio Codec %s\n", WM8990_VERSION);
 
@@ -1587,13 +1587,13 @@ static int wm8990_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&codec->dapm_paths);
 	wm8990_socdev = socdev;
 
+	ret = -ENODEV;
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = wm8990_add_i2c_device(pdev, setup);
 	}
-#else
-		/* Add other interfaces here */
 #endif
 
 	if (ret != 0) {
-- 
1.5.6.5
