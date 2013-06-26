From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ac97: Support multi-platform AC'97
Date: Wed, 26 Jun 2013 12:48:16 +0100
Message-ID: <1372247296-17108-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EA89E265379
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 13:48:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Currently we can only have a single platform built in with AC'97 support
due to the use of a global variable to provide the bus operations. Fix
this by making that variable a pointer and having the bus drivers set the
operations prior to registering.

This is not a particularly good or nice approach but it avoids blocking
multiplatform and a real fix involves fixing the fairly deep problems
with AC'97 support - we should be converting it to a real bus.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/sound/soc.h              |  4 +++-
 sound/soc/au1x/ac97c.c           |  7 +++++--
 sound/soc/au1x/psc-ac97.c        |  7 +++++--
 sound/soc/blackfin/bf5xx-ac97.c  | 11 +++++++++--
 sound/soc/cirrus/ep93xx-ac97.c   | 10 ++++++++--
 sound/soc/codecs/ac97.c          |  7 ++++---
 sound/soc/codecs/ad1980.c        | 12 ++++++------
 sound/soc/codecs/stac9766.c      | 22 +++++++++++-----------
 sound/soc/codecs/wm9705.c        | 14 +++++++-------
 sound/soc/codecs/wm9712.c        | 18 +++++++++---------
 sound/soc/codecs/wm9713.c        | 18 +++++++++---------
 sound/soc/fsl/imx-ssi.c          | 11 +++++++++--
 sound/soc/fsl/mpc5200_psc_ac97.c | 10 ++++++++--
 sound/soc/nuc900/nuc900-ac97.c   | 11 ++++++++---
 sound/soc/pxa/pxa2xx-ac97.c      |  8 ++++++--
 sound/soc/samsung/ac97.c         | 12 +++++++++---
 sound/soc/sh/hac.c               |  8 ++++++--
 sound/soc/soc-core.c             | 16 ++++++++++++++++
 sound/soc/tegra/tegra20_ac97.c   | 12 ++++++++++--
 sound/soc/txx9/txx9aclc-ac97.c   |  8 ++++++--
 20 files changed, 154 insertions(+), 72 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 85c1522..6eabee7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -340,7 +340,7 @@ struct snd_soc_jack_gpio;
 
 typedef int (*hw_write_t)(void *,const char* ,int);
 
-extern struct snd_ac97_bus_ops soc_ac97_ops;
+extern struct snd_ac97_bus_ops *soc_ac97_ops;
 
 enum snd_soc_control_type {
 	SND_SOC_I2C = 1,
@@ -467,6 +467,8 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	struct snd_ac97_bus_ops *ops, int num);
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
 
+int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops);
+
 /*
  *Controls
  */
diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index a51dabe..d6f7694 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -179,13 +179,12 @@ static void au1xac97c_ac97_cold_reset(struct snd_ac97 *ac97)
 }
 
 /* AC97 controller operations */
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops ac97c_bus_ops = {
 	.read		= au1xac97c_ac97_read,
 	.write		= au1xac97c_ac97_write,
 	.reset		= au1xac97c_ac97_cold_reset,
 	.warm_reset	= au1xac97c_ac97_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);	/* globals be gone! */
 
 static int alchemy_ac97c_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
@@ -272,6 +271,10 @@ static int au1xac97c_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
+	ret = snd_soc_set_ac97_ops(&ac97c_bus_ops);
+	if (ret)
+		return ret;
+
 	ret = snd_soc_register_component(&pdev->dev, &au1xac97c_component,
 					 &au1xac97c_dai_driver, 1);
 	if (ret)
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a97ba13..a822ab8 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -201,13 +201,12 @@ static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
 }
 
 /* AC97 controller operations */
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops psc_ac97_ops = {
 	.read		= au1xpsc_ac97_read,
 	.write		= au1xpsc_ac97_write,
 	.reset		= au1xpsc_ac97_cold_reset,
 	.warm_reset	= au1xpsc_ac97_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
@@ -417,6 +416,10 @@ static int au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wd);
 
+	ret = snd_soc_set_ac97_ops(&psc_ac97_ops);
+	if (ret)
+		return ret;
+
 	ret = snd_soc_register_component(&pdev->dev, &au1xpsc_ac97_component,
 					 &wd->dai_drv, 1);
 	if (ret)
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 8010f32..efb1dae 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -198,13 +198,12 @@ static void bf5xx_ac97_cold_reset(struct snd_ac97 *ac97)
 #endif
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops bf5xx_ac97_ops = {
 	.read	= bf5xx_ac97_read,
 	.write	= bf5xx_ac97_write,
 	.warm_reset	= bf5xx_ac97_warm_reset,
 	.reset	= bf5xx_ac97_cold_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 #ifdef CONFIG_PM
 static int bf5xx_ac97_suspend(struct snd_soc_dai *dai)
@@ -336,6 +335,12 @@ static int asoc_bfin_ac97_probe(struct platform_device *pdev)
 		goto sport_config_err;
 	}
 
+	ret = snd_soc_set_ac97_ops(&bf5xx_ac97_ops);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to set AC'97 ops: %d\n", ret);
+		goto sport_config_err;
+	}
+
 	ret = snd_soc_register_component(&pdev->dev, &bfin_ac97_component,
 					 &bfin_ac97_dai, 1);
 	if (ret) {
@@ -350,6 +355,7 @@ static int asoc_bfin_ac97_probe(struct platform_device *pdev)
 sport_config_err:
 	sport_done(sport_handle);
 sport_err:
+	snd_soc_set_ac97_ops(NULL);
 
 	return ret;
 }
@@ -360,6 +366,7 @@ static int asoc_bfin_ac97_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_component(&pdev->dev);
 	sport_done(sport_handle);
+	snd_soc_set_ac97_ops(NULL);
 
 	return 0;
 }
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index f193701..ac73c60 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -237,13 +237,12 @@ static irqreturn_t ep93xx_ac97_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops ep93xx_ac97_ops = {
 	.read		= ep93xx_ac97_read,
 	.write		= ep93xx_ac97_write,
 	.reset		= ep93xx_ac97_cold_reset,
 	.warm_reset	= ep93xx_ac97_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int ep93xx_ac97_trigger(struct snd_pcm_substream *substream,
 			       int cmd, struct snd_soc_dai *dai)
@@ -389,6 +388,10 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 	ep93xx_ac97_info = info;
 	platform_set_drvdata(pdev, info);
 
+	ret = snd_soc_set_ac97_ops(&ep93xx_ac97_ops);
+	if (ret)
+		goto fail;
+
 	ret = snd_soc_register_component(&pdev->dev, &ep93xx_ac97_component,
 					 &ep93xx_ac97_dai, 1);
 	if (ret)
@@ -398,6 +401,7 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 
 fail:
 	ep93xx_ac97_info = NULL;
+	snd_soc_set_ac97_ops(NULL);
 	return ret;
 }
 
@@ -412,6 +416,8 @@ static int ep93xx_ac97_remove(struct platform_device *pdev)
 
 	ep93xx_ac97_info = NULL;
 
+	snd_soc_set_ac97_ops(NULL);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index ef2ae32..ec73518 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -62,13 +62,13 @@ static struct snd_soc_dai_driver ac97_dai = {
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	return soc_ac97_ops.read(codec->ac97, reg);
+	return soc_ac97_ops->read(codec->ac97, reg);
 }
 
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
-	soc_ac97_ops.write(codec->ac97, reg, val);
+	soc_ac97_ops->write(codec->ac97, reg, val);
 	return 0;
 }
 
@@ -79,7 +79,8 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
 	int ret;
 
 	/* add codec as bus device for standard ac97 */
-	ret = snd_ac97_bus(codec->card->snd_card, 0, &soc_ac97_ops, NULL, &ac97_bus);
+	ret = snd_ac97_bus(codec->card->snd_card, 0, soc_ac97_ops, NULL,
+			   &ac97_bus);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index f385342..89fcf7d 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -108,7 +108,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	case AC97_EXTENDED_STATUS:
 	case AC97_VENDOR_ID1:
 	case AC97_VENDOR_ID2:
-		return soc_ac97_ops.read(codec->ac97, reg);
+		return soc_ac97_ops->read(codec->ac97, reg);
 	default:
 		reg = reg >> 1;
 
@@ -124,7 +124,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u16 *cache = codec->reg_cache;
 
-	soc_ac97_ops.write(codec->ac97, reg, val);
+	soc_ac97_ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < ARRAY_SIZE(ad1980_reg))
 		cache[reg] = val;
@@ -154,13 +154,13 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 	u16 retry_cnt = 0;
 
 retry:
-	if (try_warm && soc_ac97_ops.warm_reset) {
-		soc_ac97_ops.warm_reset(codec->ac97);
+	if (try_warm && soc_ac97_ops->warm_reset) {
+		soc_ac97_ops->warm_reset(codec->ac97);
 		if (ac97_read(codec, AC97_RESET) == 0x0090)
 			return 1;
 	}
 
-	soc_ac97_ops.reset(codec->ac97);
+	soc_ac97_ops->reset(codec->ac97);
 	/* Set bit 16slot in register 74h, then every slot will has only 16
 	 * bits. This command is sent out in 20bit mode, in which case the
 	 * first nibble of data is eaten by the addr. (Tag is always 16 bit)*/
@@ -186,7 +186,7 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "AD1980 SoC Audio Codec\n");
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "ad1980: failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index cbc7ae3..a5455c1 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -143,14 +143,14 @@ static int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	if (reg > AC97_STAC_PAGE0) {
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
-		soc_ac97_ops.write(codec->ac97, reg, val);
+		soc_ac97_ops->write(codec->ac97, reg, val);
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
 		return 0;
 	}
 	if (reg / 2 >= ARRAY_SIZE(stac9766_reg))
 		return -EIO;
 
-	soc_ac97_ops.write(codec->ac97, reg, val);
+	soc_ac97_ops->write(codec->ac97, reg, val);
 	cache[reg / 2] = val;
 	return 0;
 }
@@ -162,7 +162,7 @@ static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
 
 	if (reg > AC97_STAC_PAGE0) {
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
-		val = soc_ac97_ops.read(codec->ac97, reg - AC97_STAC_PAGE0);
+		val = soc_ac97_ops->read(codec->ac97, reg - AC97_STAC_PAGE0);
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
 		return val;
 	}
@@ -173,7 +173,7 @@ static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
 		reg == AC97_INT_PAGING || reg == AC97_VENDOR_ID1 ||
 		reg == AC97_VENDOR_ID2) {
 
-		val = soc_ac97_ops.read(codec->ac97, reg);
+		val = soc_ac97_ops->read(codec->ac97, reg);
 		return val;
 	}
 	return cache[reg / 2];
@@ -240,15 +240,15 @@ static int stac9766_set_bias_level(struct snd_soc_codec *codec,
 
 static int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
 {
-	if (try_warm && soc_ac97_ops.warm_reset) {
-		soc_ac97_ops.warm_reset(codec->ac97);
+	if (try_warm && soc_ac97_ops->warm_reset) {
+		soc_ac97_ops->warm_reset(codec->ac97);
 		if (stac9766_ac97_read(codec, 0) == stac9766_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops.reset(codec->ac97);
-	if (soc_ac97_ops.warm_reset)
-		soc_ac97_ops.warm_reset(codec->ac97);
+	soc_ac97_ops->reset(codec->ac97);
+	if (soc_ac97_ops->warm_reset)
+		soc_ac97_ops->warm_reset(codec->ac97);
 	if (stac9766_ac97_read(codec, 0) != stac9766_reg[0])
 		return -EIO;
 	return 0;
@@ -272,7 +272,7 @@ reset:
 		return -EIO;
 	}
 	codec->ac97->bus->ops->warm_reset(codec->ac97);
-	id = soc_ac97_ops.read(codec->ac97, AC97_VENDOR_ID2);
+	id = soc_ac97_ops->read(codec->ac97, AC97_VENDOR_ID2);
 	if (id != 0x4c13) {
 		stac9766_reset(codec, 0);
 		reset++;
@@ -336,7 +336,7 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0)
 		goto codec_err;
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index a5fc61d..70ce6793 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -209,7 +209,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
 	case AC97_RESET:
 	case AC97_VENDOR_ID1:
 	case AC97_VENDOR_ID2:
-		return soc_ac97_ops.read(codec->ac97, reg);
+		return soc_ac97_ops->read(codec->ac97, reg);
 	default:
 		reg = reg >> 1;
 
@@ -225,7 +225,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u16 *cache = codec->reg_cache;
 
-	soc_ac97_ops.write(codec->ac97, reg, val);
+	soc_ac97_ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9705_reg)))
 		cache[reg] = val;
@@ -294,8 +294,8 @@ static struct snd_soc_dai_driver wm9705_dai[] = {
 
 static int wm9705_reset(struct snd_soc_codec *codec)
 {
-	if (soc_ac97_ops.reset) {
-		soc_ac97_ops.reset(codec->ac97);
+	if (soc_ac97_ops->reset) {
+		soc_ac97_ops->reset(codec->ac97);
 		if (ac97_read(codec, 0) == wm9705_reg[0])
 			return 0; /* Success */
 	}
@@ -306,7 +306,7 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 #ifdef CONFIG_PM
 static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 {
-	soc_ac97_ops.write(codec->ac97, AC97_POWERDOWN, 0xffff);
+	soc_ac97_ops->write(codec->ac97, AC97_POWERDOWN, 0xffff);
 
 	return 0;
 }
@@ -323,7 +323,7 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 	}
 
 	for (i = 2; i < ARRAY_SIZE(wm9705_reg) << 1; i += 2) {
-		soc_ac97_ops.write(codec->ac97, i, cache[i>>1]);
+		soc_ac97_ops->write(codec->ac97, i, cache[i>>1]);
 	}
 
 	return 0;
@@ -337,7 +337,7 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9705: failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 8e9a6a3..c5eb746 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -455,7 +455,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
 		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
 		reg == AC97_REC_GAIN)
-		return soc_ac97_ops.read(codec->ac97, reg);
+		return soc_ac97_ops->read(codec->ac97, reg);
 	else {
 		reg = reg >> 1;
 
@@ -472,7 +472,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	u16 *cache = codec->reg_cache;
 
 	if (reg < 0x7c)
-		soc_ac97_ops.write(codec->ac97, reg, val);
+		soc_ac97_ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9712_reg)))
 		cache[reg] = val;
@@ -581,15 +581,15 @@ static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 
 static int wm9712_reset(struct snd_soc_codec *codec, int try_warm)
 {
-	if (try_warm && soc_ac97_ops.warm_reset) {
-		soc_ac97_ops.warm_reset(codec->ac97);
+	if (try_warm && soc_ac97_ops->warm_reset) {
+		soc_ac97_ops->warm_reset(codec->ac97);
 		if (ac97_read(codec, 0) == wm9712_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops.reset(codec->ac97);
-	if (soc_ac97_ops.warm_reset)
-		soc_ac97_ops.warm_reset(codec->ac97);
+	soc_ac97_ops->reset(codec->ac97);
+	if (soc_ac97_ops->warm_reset)
+		soc_ac97_ops->warm_reset(codec->ac97);
 	if (ac97_read(codec, 0) != wm9712_reg[0])
 		goto err;
 	return 0;
@@ -624,7 +624,7 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 			if (i == AC97_INT_PAGING || i == AC97_POWERDOWN ||
 			    (i > 0x58 && i != 0x5c))
 				continue;
-			soc_ac97_ops.write(codec->ac97, i, cache[i>>1]);
+			soc_ac97_ops->write(codec->ac97, i, cache[i>>1]);
 		}
 	}
 
@@ -635,7 +635,7 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9712: failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index f7afa68..a53e175 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -652,7 +652,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
 		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
 		reg == AC97_CD)
-		return soc_ac97_ops.read(codec->ac97, reg);
+		return soc_ac97_ops->read(codec->ac97, reg);
 	else {
 		reg = reg >> 1;
 
@@ -668,7 +668,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u16 *cache = codec->reg_cache;
 	if (reg < 0x7c)
-		soc_ac97_ops.write(codec->ac97, reg, val);
+		soc_ac97_ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9713_reg)))
 		cache[reg] = val;
@@ -1095,15 +1095,15 @@ static struct snd_soc_dai_driver wm9713_dai[] = {
 
 int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 {
-	if (try_warm && soc_ac97_ops.warm_reset) {
-		soc_ac97_ops.warm_reset(codec->ac97);
+	if (try_warm && soc_ac97_ops->warm_reset) {
+		soc_ac97_ops->warm_reset(codec->ac97);
 		if (ac97_read(codec, 0) == wm9713_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops.reset(codec->ac97);
-	if (soc_ac97_ops.warm_reset)
-		soc_ac97_ops.warm_reset(codec->ac97);
+	soc_ac97_ops->reset(codec->ac97);
+	if (soc_ac97_ops->warm_reset)
+		soc_ac97_ops->warm_reset(codec->ac97);
 	if (ac97_read(codec, 0) != wm9713_reg[0])
 		return -EIO;
 	return 0;
@@ -1180,7 +1180,7 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 			if (i == AC97_POWERDOWN || i == AC97_EXTENDED_MID ||
 				i == AC97_EXTENDED_MSTATUS || i > 0x66)
 				continue;
-			soc_ac97_ops.write(codec->ac97, i, cache[i>>1]);
+			soc_ac97_ops->write(codec->ac97, i, cache[i>>1]);
 		}
 	}
 
@@ -1197,7 +1197,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, wm9713);
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0)
 		goto codec_err;
 
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index a8362be..51be377 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -501,13 +501,12 @@ static void imx_ssi_ac97_warm_reset(struct snd_ac97 *ac97)
 	imx_ssi_ac97_read(ac97, 0);
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops imx_ssi_ac97_ops = {
 	.read		= imx_ssi_ac97_read,
 	.write		= imx_ssi_ac97_write,
 	.reset		= imx_ssi_ac97_reset,
 	.warm_reset	= imx_ssi_ac97_warm_reset
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int imx_ssi_probe(struct platform_device *pdev)
 {
@@ -583,6 +582,12 @@ static int imx_ssi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ssi);
 
+	ret = snd_soc_set_ac97_ops(&imx_ssi_ac97_ops);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to set AC'97 ops: %d\n", ret);
+		goto failed_register;
+	}
+
 	ret = snd_soc_register_component(&pdev->dev, &imx_component,
 					 dai, 1);
 	if (ret) {
@@ -608,6 +613,7 @@ failed_register:
 	release_mem_region(res->start, resource_size(res));
 	clk_disable_unprepare(ssi->clk);
 failed_clk:
+	snd_soc_set_ac97_ops(NULL);
 
 	return ret;
 }
@@ -627,6 +633,7 @@ static int imx_ssi_remove(struct platform_device *pdev)
 
 	release_mem_region(res->start, resource_size(res));
 	clk_disable_unprepare(ssi->clk);
+	snd_soc_set_ac97_ops(NULL);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 4141b35..3ef7a0c 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -131,13 +131,12 @@ static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 	psc_ac97_warm_reset(ac97);
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops psc_ac97_ops = {
 	.read		= psc_ac97_read,
 	.write		= psc_ac97_write,
 	.reset		= psc_ac97_cold_reset,
 	.warm_reset	= psc_ac97_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int psc_ac97_hw_analog_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
@@ -290,6 +289,12 @@ static int psc_ac97_of_probe(struct platform_device *op)
 	if (rc != 0)
 		return rc;
 
+	rc = snd_soc_set_ac97_ops(&psc_ac97_ops);
+	if (rc != 0) {
+		dev_err(&op->dev, "Failed to set AC'97 ops: %d\n", ret);
+		return rc;
+	}
+
 	rc = snd_soc_register_component(&op->dev, &psc_ac97_component,
 					psc_ac97_dai, ARRAY_SIZE(psc_ac97_dai));
 	if (rc != 0) {
@@ -318,6 +323,7 @@ static int psc_ac97_of_remove(struct platform_device *op)
 {
 	mpc5200_audio_dma_destroy(op);
 	snd_soc_unregister_component(&op->dev);
+	snd_soc_set_ac97_ops(NULL);
 	return 0;
 }
 
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 8dea4c1..f4c2417 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -197,13 +197,12 @@ static void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)
 }
 
 /* AC97 controller operations */
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops nuc900_ac97_ops = {
 	.read		= nuc900_ac97_read,
 	.write		= nuc900_ac97_write,
 	.reset		= nuc900_ac97_cold_reset,
 	.warm_reset	= nuc900_ac97_warm_reset,
-}
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+};
 
 static int nuc900_ac97_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
@@ -356,6 +355,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 
 	nuc900_ac97_data = nuc900_audio;
 
+	ret = snd_soc_set_ac97_ops(&nuc900_ac97_ops);
+	if (ret)
+		goto out;
+
 	ret = snd_soc_register_component(&pdev->dev, &nuc900_ac97_component,
 					 &nuc900_ac97_dai, 1);
 	if (ret)
@@ -367,6 +370,7 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 	return 0;
 
 out:
+	snd_soc_set_ac97_ops(NULL);
 	return ret;
 }
 
@@ -375,6 +379,7 @@ static int nuc900_ac97_drvremove(struct platform_device *pdev)
 	snd_soc_unregister_component(&pdev->dev);
 
 	nuc900_ac97_data = NULL;
+	snd_soc_set_ac97_ops(NULL);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 57ea8e6..a3c22ba 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -41,13 +41,12 @@ static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
 	pxa2xx_ac97_finish_reset(ac97);
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.read	= pxa2xx_ac97_read,
 	.write	= pxa2xx_ac97_write,
 	.warm_reset	= pxa2xx_ac97_warm_reset,
 	.reset	= pxa2xx_ac97_cold_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_stereo_out = {
 	.name			= "AC97 PCM Stereo out",
@@ -244,6 +243,10 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	ret = snd_soc_set_ac97_ops(&pxa2xx_ac97_ops);
+	if (ret != 0)
+		return ret;
+
 	/* Punt most of the init to the SoC probe; we may need the machine
 	 * driver to do interesting things with the clocking to get us up
 	 * and running.
@@ -255,6 +258,7 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 static int pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
+	snd_soc_set_ac97_ops(NULL);
 	return 0;
 }
 
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 04d7fd4..2dd623f 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -214,13 +214,12 @@ static irqreturn_t s3c_ac97_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops s3c_ac97_ops = {
 	.read       = s3c_ac97_read,
 	.write      = s3c_ac97_write,
 	.warm_reset = s3c_ac97_warm_reset,
 	.reset      = s3c_ac97_cold_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int s3c_ac97_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
@@ -452,6 +451,12 @@ static int s3c_ac97_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
+	ret = snd_soc_set_ac97_ops(&s3c_ac97_ops);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to set AC'97 ops: %d\n", ret);
+		goto err4;
+	}
+
 	ret = snd_soc_register_component(&pdev->dev, &s3c_ac97_component,
 					 s3c_ac97_dai, ARRAY_SIZE(s3c_ac97_dai));
 	if (ret)
@@ -472,7 +477,7 @@ err4:
 err3:
 	clk_disable_unprepare(s3c_ac97.ac97_clk);
 err2:
-
+	snd_soc_set_ac97_ops(NULL);
 	return ret;
 }
 
@@ -488,6 +493,7 @@ static int s3c_ac97_remove(struct platform_device *pdev)
 		free_irq(irq_res->start, NULL);
 
 	clk_disable_unprepare(s3c_ac97.ac97_clk);
+	snd_soc_set_ac97_ops(NULL);
 
 	return 0;
 }
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index af19f77..0af2e4d 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -227,13 +227,12 @@ static void hac_ac97_coldrst(struct snd_ac97 *ac97)
 	hac_ac97_warmrst(ac97);
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops hac_ac97_ops = {
 	.read	= hac_ac97_read,
 	.write	= hac_ac97_write,
 	.reset	= hac_ac97_coldrst,
 	.warm_reset = hac_ac97_warmrst,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int hac_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params,
@@ -316,6 +315,10 @@ static const struct snd_soc_component_driver sh4_hac_component = {
 
 static int hac_soc_platform_probe(struct platform_device *pdev)
 {
+	ret = snd_soc_set_ac97_ops(&hac_ac97_ops);
+	if (ret != 0)
+		return ret;
+
 	return snd_soc_register_component(&pdev->dev, &sh4_hac_component,
 					  sh4_hac_dai, ARRAY_SIZE(sh4_hac_dai));
 }
@@ -323,6 +326,7 @@ static int hac_soc_platform_probe(struct platform_device *pdev)
 static int hac_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
+	snd_soc_set_ac97_ops(NULL);
 	return 0;
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4489c5b..309e5c9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2080,6 +2080,22 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 
+struct snd_ac97_bus_ops *soc_ac97_ops;
+
+int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops)
+{
+	if (ops == soc_ac97_ops)
+		return 0;
+
+	if (soc_ac97_ops && ops)
+		return -EBUSY;
+
+	soc_ac97_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_set_ac97_ops);
+
 /**
  * snd_soc_free_ac97_codec - free AC97 codec device
  * @codec: audio codec
diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index 48037f7..f52eab6 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -142,13 +142,12 @@ static void tegra20_ac97_codec_write(struct snd_ac97 *ac97_snd,
 	} while (!time_after(jiffies, timeout));
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops tegra20_ac97_ops = {
 	.read		= tegra20_ac97_codec_read,
 	.write		= tegra20_ac97_codec_write,
 	.reset		= tegra20_ac97_codec_reset,
 	.warm_reset	= tegra20_ac97_codec_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static inline void tegra20_ac97_start_playback(struct tegra20_ac97 *ac97)
 {
@@ -409,6 +408,12 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 		goto err_asoc_utils_fini;
 	}
 
+	ret = snd_soc_set_ac97_ops(&tegra20_ac97_ops);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set AC'97 ops: %d\n", ret);
+		goto err_asoc_utils_fini;
+	}
+
 	ret = snd_soc_register_component(&pdev->dev, &tegra20_ac97_component,
 					 &tegra20_ac97_dai, 1);
 	if (ret) {
@@ -436,6 +441,7 @@ err_asoc_utils_fini:
 	tegra_asoc_utils_fini(&ac97->util_data);
 err_clk_put:
 err:
+	snd_soc_set_ac97_ops(NULL);
 	return ret;
 }
 
@@ -450,6 +456,8 @@ static int tegra20_ac97_platform_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(ac97->clk_ac97);
 
+	snd_soc_set_ac97_ops(NULL);
+
 	return 0;
 }
 
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 8ee8d42..4bcce8a 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -119,12 +119,11 @@ static void txx9aclc_ac97_cold_reset(struct snd_ac97 *ac97)
 }
 
 /* AC97 controller operations */
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops txx9aclc_ac97_ops = {
 	.read		= txx9aclc_ac97_read,
 	.write		= txx9aclc_ac97_write,
 	.reset		= txx9aclc_ac97_cold_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static irqreturn_t txx9aclc_ac97_irq(int irq, void *dev_id)
 {
@@ -206,6 +205,10 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	err = snd_soc_set_ac97_ops(&txx9aclc_ac97_ops);
+	if (err < 0)
+		return err;
+
 	return snd_soc_register_component(&pdev->dev, &txx9aclc_ac97_component,
 					  &txx9aclc_ac97_dai, 1);
 }
@@ -213,6 +216,7 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 static int txx9aclc_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
+	snd_soc_set_ac97_ops(NULL);
 	return 0;
 }
 
-- 
1.8.3.1
