From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ASoC: checking kzalloc() for IS_ERR() instead
	of NULL
Date: Sat, 9 Oct 2010 21:31:31 +0200
Message-ID: <20101009193131.GA5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C9E0710387F
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 21:32:25 +0200 (CEST)
Received: by wwb28 with SMTP id 28so1924268wwb.20
	for <alsa-devel@alsa-project.org>; Sat, 09 Oct 2010 12:32:25 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

There is a typo here that got copy and pasted to several probe
functions.  kzalloc() returns NULL on allocation failures and not an
ERR_PTR.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 642b07c..4599e8e 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -720,8 +720,8 @@ static int __devinit wm8804_spi_probe(struct spi_device *spi)
 	int ret;
 
 	wm8804 = kzalloc(sizeof *wm8804, GFP_KERNEL);
-	if (IS_ERR(wm8804))
-		return PTR_ERR(wm8804);
+	if (!wm8804)
+		return -ENOMEM;
 
 	wm8804->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8804);
@@ -758,8 +758,8 @@ static __devinit int wm8804_i2c_probe(struct i2c_client *i2c,
 	int ret;
 
 	wm8804 = kzalloc(sizeof *wm8804, GFP_KERNEL);
-	if (IS_ERR(wm8804))
-		return PTR_ERR(wm8804);
+	if (!wm8804)
+		return -ENOMEM;
 
 	wm8804->control_type = SND_SOC_I2C;
 	i2c_set_clientdata(i2c, wm8804);
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index ae9020a..fd2e7cc 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1079,8 +1079,8 @@ static int __devinit wm8985_spi_probe(struct spi_device *spi)
 	int ret;
 
 	wm8985 = kzalloc(sizeof *wm8985, GFP_KERNEL);
-	if (IS_ERR(wm8985))
-		return PTR_ERR(wm8985);
+	if (!wm8985)
+		return -ENOMEM;
 
 	wm8985->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8985);
@@ -1117,8 +1117,8 @@ static __devinit int wm8985_i2c_probe(struct i2c_client *i2c,
 	int ret;
 
 	wm8985 = kzalloc(sizeof *wm8985, GFP_KERNEL);
-	if (IS_ERR(wm8985))
-		return PTR_ERR(wm8985);
+	if (!wm8985)
+		return -ENOMEM;
 
 	wm8985->control_type = SND_SOC_I2C;
 	i2c_set_clientdata(i2c, wm8985);
