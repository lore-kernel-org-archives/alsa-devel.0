From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix double free and memory leak in many
	codec drivers
Date: Mon, 25 Aug 2008 11:49:20 +0100
Message-ID: <1219661360-3555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 96BBF243F9
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Aug 2008 12:49:21 +0200 (CEST)
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

From: Jean Delvare <khali@linux-fr.org>

Many SoC audio codec drivers have improper freeing of memory in error
paths.

* codec is allocated in the platform device probe function, but is not
  freed there in case of error. Instead it is freed in the i2c device
  probe function's error path. However the success or failure of both
  functions is not linked, so this could result in a double free (if
  the platform device is successfully probed, the i2c device probing
  fails and then the platform driver is unregistered.)

* codec->private_data is allocated in many platform device probe
  functions but not freed in their error paths.

This patch hopefully solves all these problems.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4535.c      |   11 +++++++----
 sound/soc/codecs/tlv320aic3x.c |   11 +++++++----
 sound/soc/codecs/uda1380.c     |    9 +++++----
 sound/soc/codecs/wm8510.c      |    9 +++++----
 sound/soc/codecs/wm8731.c      |   11 +++++++----
 sound/soc/codecs/wm8750.c      |   10 ++++++----
 sound/soc/codecs/wm8753.c      |   11 +++++++----
 sound/soc/codecs/wm8990.c      |   11 +++++++----
 8 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index b26003c..7da9f46 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -562,10 +562,9 @@ static int ak4535_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	client_template.addr = addr;
 
 	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
+	if (i2c == NULL)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
@@ -583,7 +582,6 @@ static int ak4535_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	return ret;
 
 err:
-	kfree(codec);
 	kfree(i2c);
 	return ret;
 }
@@ -660,6 +658,11 @@ static int ak4535_probe(struct platform_device *pdev)
 #else
 	/* Add other interfaces here */
 #endif
+
+	if (ret != 0) {
+		kfree(codec->private_data);
+		kfree(codec);
+	}
 	return ret;
 }
 
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b1dce5f..5f9abb1 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1199,10 +1199,9 @@ static int aic3x_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	client_template.addr = addr;
 
 	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
+	if (i2c == NULL)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
@@ -1221,7 +1220,6 @@ static int aic3x_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	return ret;
 
 err:
-	kfree(codec);
 	kfree(i2c);
 	return ret;
 }
@@ -1302,6 +1300,11 @@ static int aic3x_probe(struct platform_device *pdev)
 #else
 	/* Add other interfaces here */
 #endif
+
+	if (ret != 0) {
+		kfree(codec->private_data);
+		kfree(codec);
+	}
 	return ret;
 }
 
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index a52d6d9..807318f 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -729,10 +729,9 @@ static int uda1380_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	client_template.addr = addr;
 
 	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
+	if (i2c == NULL)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
@@ -750,7 +749,6 @@ static int uda1380_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	return ret;
 
 err:
-	kfree(codec);
 	kfree(i2c);
 	return ret;
 }
@@ -817,6 +815,9 @@ static int uda1380_probe(struct platform_device *pdev)
 #else
 	/* Add other interfaces here */
 #endif
+
+	if (ret != 0)
+		kfree(codec);
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 67325fd..3d998e6 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -693,10 +693,9 @@ static int wm8510_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	client_template.addr = addr;
 
 	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
+	if (i2c == NULL)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
@@ -714,7 +713,6 @@ static int wm8510_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	return ret;
 
 err:
-	kfree(codec);
 	kfree(i2c);
 	return ret;
 }
@@ -782,6 +780,9 @@ static int wm8510_probe(struct platform_device *pdev)
 #else
 	/* Add other interfaces here */
 #endif
+
+	if (ret != 0)
+		kfree(codec);
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 369d39c..9402fca 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -596,10 +596,9 @@ static int wm8731_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	client_template.addr = addr;
 
 	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
+	if (i2c == NULL)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
@@ -617,7 +616,6 @@ static int wm8731_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	return ret;
 
 err:
-	kfree(codec);
 	kfree(i2c);
 	return ret;
 }
@@ -693,6 +691,11 @@ static int wm8731_probe(struct platform_device *pdev)
 #else
 	/* Add other interfaces here */
 #endif
+
+	if (ret != 0) {
+		kfree(codec->private_data);
+		kfree(codec);
+	}
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index c6a8edf..dd1f554 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -869,10 +869,9 @@ static int wm8750_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	client_template.addr = addr;
 
 	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
+	if (i2c == NULL)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
@@ -890,7 +889,6 @@ static int wm8750_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	return ret;
 
 err:
-	kfree(codec);
 	kfree(i2c);
 	return ret;
 }
@@ -966,6 +964,10 @@ static int wm8750_probe(struct platform_device *pdev)
 		/* Add other interfaces here */
 #endif
 
+	if (ret != 0) {
+		kfree(codec->private_data);
+		kfree(codec);
+	}
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index dc7b18f..5761164 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1660,10 +1660,9 @@ static int wm8753_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	client_template.addr = addr;
 
 	i2c =  kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (!i2c) {
-		kfree(codec);
+	if (!i2c)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
@@ -1682,7 +1681,6 @@ static int wm8753_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	return ret;
 
 err:
-	kfree(codec);
 	kfree(i2c);
 	return ret;
 }
@@ -1759,6 +1757,11 @@ static int wm8753_probe(struct platform_device *pdev)
 #else
 		/* Add other interfaces here */
 #endif
+
+	if (ret != 0) {
+		kfree(codec->private_data);
+		kfree(codec);
+	}
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index e44153f..dd995ef 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1500,10 +1500,9 @@ static int wm8990_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	client_template.addr = addr;
 
 	i2c =  kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
+	if (i2c == NULL)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
@@ -1521,7 +1520,6 @@ static int wm8990_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 	return ret;
 
 err:
-	kfree(codec);
 	kfree(i2c);
 	return ret;
 }
@@ -1595,6 +1593,11 @@ static int wm8990_probe(struct platform_device *pdev)
 #else
 		/* Add other interfaces here */
 #endif
+
+	if (ret != 0) {
+		kfree(codec->private_data);
+		kfree(codec);
+	}
 	return ret;
 }
 
-- 
1.5.6.3
