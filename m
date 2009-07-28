From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ASoC: CX20442: fix issues pointed out by
	subsystem maintainer
Date: Tue, 28 Jul 2009 20:24:12 +0200
Message-ID: <200907282024.13630.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 529A3246FA
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 20:24:46 +0200 (CEST)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch fixes some checkpatch identified issues and adds a comment about
line discipline interaction to my driver code, as requested by Mark on my
inital submission (thank you Mark for applying my imperfect patch anyway).
It also fixes MODULE_ALIAS mismatch as used in my machine driver.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
In my next attempt, I'll try to satisfy Mark's request for pushing down the
line discipline code, now existing in my machine driver, to the codec driver.

--- linux-2.6.31-rc3/sound/soc/codecs/cx20442.c.orig	2009-07-22 04:56:45.000000000 +0200
+++ linux-2.6.31-rc3/sound/soc/codecs/cx20442.c	2009-07-22 21:46:41.000000000 +0200
@@ -132,7 +132,7 @@ enum v253_vls {
 
 static int cx20442_pm_to_v253_vls(u8 value)
 {
-	switch(value & ~(1 << CX20442_AGC)) {
+	switch (value & ~(1 << CX20442_AGC)) {
 	case 0:
 		return V253_VLS_T;
 	case (1 << CX20442_SPKOUT):
@@ -152,7 +152,7 @@ static int cx20442_pm_to_v253_vls(u8 val
 }
 static int cx20442_pm_to_v253_vsp(u8 value)
 {
-	switch(value & ~(1 << CX20442_AGC)) {
+	switch (value & ~(1 << CX20442_AGC)) {
 	case (1 << CX20442_SPKOUT):
 	case (1 << CX20442_MIC):
 	case (1 << CX20442_SPKOUT) | (1 << CX20442_MIC):
@@ -171,6 +171,9 @@ static int cx20442_write(struct snd_soc_
 	if (reg >= codec->reg_cache_size)
 		return -EINVAL;
 
+	/* hw_write and control_data pointers required for talking to the modem
+	 * are expected to be set by the machine driver's line discipline
+	 * initialization code */
 	if (!codec->hw_write || !codec->control_data)
 		return -EIO;
 
@@ -182,7 +185,7 @@ static int cx20442_write(struct snd_soc_
 		return vls;
 
 	vsp = cx20442_pm_to_v253_vsp(value);
-	if (vsp < 0 )
+	if (vsp < 0)
 		return vsp;
 
 	if ((vls == V253_VLS_T) ||
@@ -232,7 +235,7 @@ static int cx20442_codec_probe(struct pl
 	struct snd_soc_codec *codec;
 	int ret;
 
-	if(!cx20442_codec) {
+	if (!cx20442_codec) {
 		dev_err(&pdev->dev, "cx20442 not yet discovered\n");
 		return -ENODEV;
 	}
@@ -310,13 +313,13 @@ static int cx20442_register(struct cx204
 
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
-		//dev_err(&dev->dev, "Failed to register codec: %d\n", ret);
+		dev_err(&codec->dev, "Failed to register codec: %d\n", ret);
 		goto err;
 	}
 
 	ret = snd_soc_register_dai(&cx20442_dai);
 	if (ret != 0) {
-		//dev_err(&dev->dev, "Failed to register DAI: %d\n", ret);
+		dev_err(&codec->dev, "Failed to register DAI: %d\n", ret);
 		goto err_codec;
 	}
 
@@ -392,4 +395,4 @@ module_exit(cx20442_exit);
 MODULE_DESCRIPTION("ASoC CX20442-11 voice modem codec driver");
 MODULE_AUTHOR("Janusz Krzysztofik");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:cx20442-codec");
+MODULE_ALIAS("platform:cx20442");
