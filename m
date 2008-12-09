From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 15/18] ASoC: Register non-AC97 codec DAIs
Date: Tue,  9 Dec 2008 14:01:39 +0000
Message-ID: <1228831302-17605-15-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-14-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F35CD10384C
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:46 +0100 (CET)
In-Reply-To: <1228831302-17605-14-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Currently this is done at module probe time since ASoC ties in codec
device probe to the instantiation of the entire ASoC device. Subsequent
patches will refactor the codec drivers to handle probing separately.
Note that the core does not yet use this information.

AC97 is special since the codec is controlled over the AC97 link but
we want to give the machine driver a chance to set up the system before
trying to instantiate since it may need to do configuration before the
AC97 link will operate

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ad73311.c     |   12 ++++++++++++
 sound/soc/codecs/ak4535.c      |   12 ++++++++++++
 sound/soc/codecs/cs4270.c      |   12 ++++++++++++
 sound/soc/codecs/pcm3008.c     |   12 ++++++++++++
 sound/soc/codecs/ssm2602.c     |   12 ++++++++++++
 sound/soc/codecs/tlv320aic23.c |   12 ++++++++++++
 sound/soc/codecs/tlv320aic26.c |   15 ++++++++++++---
 sound/soc/codecs/tlv320aic3x.c |   12 ++++++++++++
 sound/soc/codecs/twl4030.c     |   14 +++++++++++++-
 sound/soc/codecs/uda134x.c     |   12 ++++++++++++
 sound/soc/codecs/uda1380.c     |   12 ++++++++++++
 sound/soc/codecs/wm8510.c      |   12 ++++++++++++
 sound/soc/codecs/wm8580.c      |   12 ++++++++++++
 sound/soc/codecs/wm8728.c      |   12 ++++++++++++
 sound/soc/codecs/wm8731.c      |   12 ++++++++++++
 sound/soc/codecs/wm8750.c      |   12 ++++++++++++
 sound/soc/codecs/wm8753.c      |   12 ++++++++++++
 sound/soc/codecs/wm8900.c      |   12 ++++++++++++
 sound/soc/codecs/wm8903.c      |   12 ++++++++++++
 sound/soc/codecs/wm8971.c      |   12 ++++++++++++
 sound/soc/codecs/wm8990.c      |   12 ++++++++++++
 21 files changed, 253 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index 500f9f3..e32f550 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -98,6 +98,18 @@ struct snd_soc_codec_device soc_codec_dev_ad73311 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_ad73311);
 
+static int __devinit ad73311_init(void)
+{
+	return snd_soc_register_dai(&ad73311_dai);
+}
+module_init(ad73311_init);
+
+static void __exit ad73311_exit(void)
+{
+	snd_soc_unregister_dai(&ad73311_dai);
+}
+module_exit(ad73311_exit);
+
 MODULE_DESCRIPTION("ASoC ad73311 driver");
 MODULE_AUTHOR("Cliff Cai ");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 23062c9..94148fb 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -688,6 +688,18 @@ struct snd_soc_codec_device soc_codec_dev_ak4535 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_ak4535);
 
+static int __devinit ak4535_modinit(void)
+{
+	return snd_soc_register_dai(&ak4535_dai);
+}
+module_init(ak4535_modinit);
+
+static void __exit ak4535_exit(void)
+{
+	snd_soc_unregister_dai(&ak4535_dai);
+}
+module_exit(ak4535_exit);
+
 MODULE_DESCRIPTION("Soc AK4535 driver");
 MODULE_AUTHOR("Richard Purdie");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 4667a07..73aaf24 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -774,6 +774,18 @@ struct snd_soc_codec_device soc_codec_device_cs4270 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_device_cs4270);
 
+static int __devinit cs4270_init(void)
+{
+	return snd_soc_register_dai(&cs4270_dai);
+}
+module_init(cs4270_init);
+
+static void __exit cs4270_exit(void)
+{
+	snd_soc_unregister_dai(&cs4270_dai);
+}
+module_exit(cs4270_exit);
+
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Cirrus Logic CS4270 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index a586255..f333e88 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -195,6 +195,18 @@ struct snd_soc_codec_device soc_codec_dev_pcm3008 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_pcm3008);
 
+static int __devinit pcm3008_init(void)
+{
+	return snd_soc_register_dai(&pcm3008_dai);
+}
+module_init(pcm3008_init);
+
+static void __exit pcm3008_exit(void)
+{
+	snd_soc_unregister_dai(&pcm3008_dai);
+}
+module_exit(pcm3008_exit);
+
 MODULE_DESCRIPTION("Soc PCM3008 driver");
 MODULE_AUTHOR("Hugo Villeneuve");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 9738449..77fdcb4 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -793,6 +793,18 @@ struct snd_soc_codec_device soc_codec_dev_ssm2602 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_ssm2602);
 
+static int __devinit ssm2602_modinit(void)
+{
+	return snd_soc_register_dai(&ssm2602_dai);
+}
+module_init(ssm2602_modinit);
+
+static void __exit ssm2602_exit(void)
+{
+	snd_soc_unregister_dai(&ssm2602_dai);
+}
+module_exit(ssm2602_exit);
+
 MODULE_DESCRIPTION("ASoC ssm2602 driver");
 MODULE_AUTHOR("Cliff Cai");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index d209bec..eac449b 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -847,6 +847,18 @@ struct snd_soc_codec_device soc_codec_dev_tlv320aic23 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320aic23);
 
+static int __devinit tlv320aic23_modinit(void)
+{
+	return snd_soc_register_dai(&tlv320aic23_dai);
+}
+module_init(tlv320aic23_modinit);
+
+static void __exit tlv320aic23_exit(void)
+{
+	snd_soc_unregister_dai(&tlv320aic23_dai);
+}
+module_exit(tlv320aic23_exit);
+
 MODULE_DESCRIPTION("ASoC TLV320AIC23 codec driver");
 MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index e33fb7e..29f2f1a 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -426,7 +426,7 @@ static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
 static int aic26_spi_probe(struct spi_device *spi)
 {
 	struct aic26 *aic26;
-	int rc, i, reg;
+	int ret, i, reg;
 
 	dev_dbg(&spi->dev, "probing tlv320aic26 spi device\n");
 
@@ -456,6 +456,14 @@ static int aic26_spi_probe(struct spi_device *spi)
 	aic26->codec.reg_cache_size = AIC26_NUM_REGS;
 	aic26->codec.reg_cache = aic26->reg_cache;
 
+	aic26_dai.dev = &spi->dev;
+	ret = snd_soc_register_dai(&aic26_dai);
+	if (ret != 0) {
+		dev_err(&spi->dev, "Failed to register DAI: %d\n", ret);
+		kfree(aic26);
+		return ret;
+	}
+
 	/* Reset the codec to power on defaults */
 	aic26_reg_write(&aic26->codec, AIC26_REG_RESET, 0xBB00);
 
@@ -474,8 +482,8 @@ static int aic26_spi_probe(struct spi_device *spi)
 
 	/* Register the sysfs files for debugging */
 	/* Create SysFS files */
-	rc = device_create_file(&spi->dev, &dev_attr_keyclick);
-	if (rc)
+	ret = device_create_file(&spi->dev, &dev_attr_keyclick);
+	if (ret)
 		dev_info(&spi->dev, "error creating sysfs files\n");
 
 #if defined(CONFIG_SND_SOC_OF_SIMPLE)
@@ -492,6 +500,7 @@ static int aic26_spi_remove(struct spi_device *spi)
 {
 	struct aic26 *aic26 = dev_get_drvdata(&spi->dev);
 
+	snd_soc_unregister_dai(&aic26_dai);
 	kfree(aic26);
 
 	return 0;
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6a05829..ccd5759 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1411,6 +1411,18 @@ struct snd_soc_codec_device soc_codec_dev_aic3x = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_aic3x);
 
+static int __devinit aic3x_modinit(void)
+{
+	return snd_soc_register_dai(&aic3x_dai);
+}
+module_init(aic3x_modinit);
+
+static void __exit aic3x_exit(void)
+{
+	snd_soc_unregister_dai(&aic3x_dai);
+}
+module_exit(aic3x_exit);
+
 MODULE_DESCRIPTION("ASoC TLV320AIC3X codec driver");
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 358aa2b..373daa4 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -358,7 +358,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 	.put = snd_soc_put_volsw_r2_twl4030, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		.max = xmax, .invert = xinvert} }
+		 .rshift = xshift, .max = xmax, .invert = xinvert} }
 #define SOC_SINGLE_TLV_TWL4030(xname, xreg, xshift, xmax, xinvert, tlv_array) \
 	SOC_DOUBLE_TLV_TWL4030(xname, xreg, xshift, xshift, xmax, \
 			       xinvert, tlv_array)
@@ -1275,6 +1275,18 @@ struct snd_soc_codec_device soc_codec_dev_twl4030 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_twl4030);
 
+static int __devinit twl4030_init(void)
+{
+	return snd_soc_register_dai(&twl4030_dai);
+}
+module_init(twl4030_init);
+
+static void __exit twl4030_exit(void)
+{
+	snd_soc_unregister_dai(&twl4030_dai);
+}
+module_exit(twl4030_exit);
+
 MODULE_DESCRIPTION("ASoC TWL4030 codec driver");
 MODULE_AUTHOR("Steve Sakoman");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 58de749..8e035b5 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -651,6 +651,18 @@ struct snd_soc_codec_device soc_codec_dev_uda134x = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_uda134x);
 
+static int __devinit uda134x_init(void)
+{
+	return snd_soc_register_dai(&uda134x_dai);
+}
+module_init(uda134x_init);
+
+static void __exit uda134x_exit(void)
+{
+	snd_soc_unregister_dai(&uda134x_dai);
+}
+module_exit(uda134x_exit);
+
 MODULE_DESCRIPTION("UDA134X ALSA soc codec driver");
 MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 4249165..55a99b6 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -841,6 +841,18 @@ struct snd_soc_codec_device soc_codec_dev_uda1380 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_uda1380);
 
+static int __devinit uda1380_modinit(void)
+{
+	return snd_soc_register_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
+}
+module_init(uda1380_modinit);
+
+static void __exit uda1380_exit(void)
+{
+	snd_soc_unregister_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
+}
+module_exit(uda1380_exit);
+
 MODULE_AUTHOR("Giorgio Padrin");
 MODULE_DESCRIPTION("Audio support for codec Philips UDA1380");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 126c70f..a2af04b 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -889,6 +889,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8510 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8510);
 
+static int __devinit wm8510_modinit(void)
+{
+	return snd_soc_register_dai(&wm8510_dai);
+}
+module_init(wm8510_modinit);
+
+static void __exit wm8510_exit(void)
+{
+	snd_soc_unregister_dai(&wm8510_dai);
+}
+module_exit(wm8510_exit);
+
 MODULE_DESCRIPTION("ASoC WM8510 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 572a31d..391ec29 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -1042,6 +1042,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8580 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8580);
 
+static int __devinit wm8580_modinit(void)
+{
+	return snd_soc_register_dais(wm8580_dai, ARRAY_SIZE(wm8580_dai));
+}
+module_init(wm8580_modinit);
+
+static void __exit wm8580_exit(void)
+{
+	snd_soc_unregister_dais(wm8580_dai, ARRAY_SIZE(wm8580_dai));
+}
+module_exit(wm8580_exit);
+
 MODULE_DESCRIPTION("ASoC WM8580 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 28f12c6..d905e25 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -568,6 +568,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8728 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8728);
 
+static int __devinit wm8728_modinit(void)
+{
+	return snd_soc_register_dai(&wm8728_dai);
+}
+module_init(wm8728_modinit);
+
+static void __exit wm8728_exit(void)
+{
+	snd_soc_unregister_dai(&wm8728_dai);
+}
+module_exit(wm8728_exit);
+
 MODULE_DESCRIPTION("ASoC WM8728 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 403dea1..7b455a6 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -793,6 +793,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8731 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8731);
 
+static int __devinit wm8731_modinit(void)
+{
+	return snd_soc_register_dai(&wm8731_dai);
+}
+module_init(wm8731_modinit);
+
+static void __exit wm8731_exit(void)
+{
+	snd_soc_unregister_dai(&wm8731_dai);
+}
+module_exit(wm8731_exit);
+
 MODULE_DESCRIPTION("ASoC WM8731 driver");
 MODULE_AUTHOR("Richard Purdie");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 979446f..84a6307 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -1085,6 +1085,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8750 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
 
+static int __devinit wm8750_modinit(void)
+{
+	return snd_soc_register_dai(&wm8750_dai);
+}
+module_init(wm8750_modinit);
+
+static void __exit wm8750_exit(void)
+{
+	snd_soc_unregister_dai(&wm8750_dai);
+}
+module_exit(wm8750_exit);
+
 MODULE_DESCRIPTION("ASoC WM8750 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 96c0453..1caca30 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1874,6 +1874,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8753 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8753);
 
+static int __devinit wm8753_modinit(void)
+{
+	return snd_soc_register_dais(wm8753_dai, ARRAY_SIZE(wm8753_dai));
+}
+module_init(wm8753_modinit);
+
+static void __exit wm8753_exit(void)
+{
+	snd_soc_unregister_dais(wm8753_dai, ARRAY_SIZE(wm8753_dai));
+}
+module_exit(wm8753_exit);
+
 MODULE_DESCRIPTION("ASoC WM8753 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 29cd839..02bb1c9 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1530,6 +1530,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8900 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8900);
 
+static int __devinit wm8900_modinit(void)
+{
+	return snd_soc_register_dai(&wm8900_dai);
+}
+module_init(wm8900_modinit);
+
+static void __exit wm8900_exit(void)
+{
+	snd_soc_unregister_dai(&wm8900_dai);
+}
+module_exit(wm8900_exit);
+
 MODULE_DESCRIPTION("ASoC WM8900 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 3c83b79..5d8fe7e 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1809,6 +1809,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8903 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8903);
 
+static int __devinit wm8903_modinit(void)
+{
+	return snd_soc_register_dai(&wm8903_dai);
+}
+module_init(wm8903_modinit);
+
+static void __exit wm8903_exit(void)
+{
+	snd_soc_unregister_dai(&wm8903_dai);
+}
+module_exit(wm8903_exit);
+
 MODULE_DESCRIPTION("ASoC WM8903 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.cm>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 53e6937..2979fc4 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -935,6 +935,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8971 = {
 
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8971);
 
+static int __devinit wm8971_modinit(void)
+{
+	return snd_soc_register_dai(&wm8971_dai);
+}
+module_init(wm8971_modinit);
+
+static void __exit wm8971_exit(void)
+{
+	snd_soc_unregister_dai(&wm8971_dai);
+}
+module_exit(wm8971_exit);
+
 MODULE_DESCRIPTION("ASoC WM8971 driver");
 MODULE_AUTHOR("Lab126");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 5c5128b..53e71aa 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1643,6 +1643,18 @@ struct snd_soc_codec_device soc_codec_dev_wm8990 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8990);
 
+static int __devinit wm8990_modinit(void)
+{
+	return snd_soc_register_dai(&wm8990_dai);
+}
+module_init(wm8990_modinit);
+
+static void __exit wm8990_exit(void)
+{
+	snd_soc_unregister_dai(&wm8990_dai);
+}
+module_exit(wm8990_exit);
+
 MODULE_DESCRIPTION("ASoC WM8990 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
-- 
1.5.6.5
