From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: ac97: Support multi-platform AC'97
Date: Wed, 26 Jun 2013 14:40:16 +0200
Message-ID: <3333302.d3tySHZuq0@wuerfel>
References: <1372247296-17108-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EFB0265485
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 14:38:54 +0200 (CEST)
In-Reply-To: <1372247296-17108-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 26 June 2013 12:48:16 Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Currently we can only have a single platform built in with AC'97 support
> due to the use of a global variable to provide the bus operations. Fix
> this by making that variable a pointer and having the bus drivers set the
> operations prior to registering.
> 
> This is not a particularly good or nice approach but it avoids blocking
> multiplatform and a real fix involves fixing the fairly deep problems
> with AC'97 support - we should be converting it to a real bus.

It is nicer than the Kconfig hack I posted though. I had started yet
another approach at some point but that grew to a rather large patch
and I got bored before it was complete:

The idea is to turn the ac97 ops into a pointer that is passed around
the structures that actually use it. See below for how far I got with
this.

> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>


-----
commit 093119e386b2093b9f76a0fd908dcc080080e1a0
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Apr 23 16:59:42 2013 +0200

    [incomplete] ASoC: move soc_ac97_ops into card structure
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 85c1522..c37d8ea 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -463,8 +463,7 @@ int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
 int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
 				unsigned int mask, unsigned int value);
 
-int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
-	struct snd_ac97_bus_ops *ops, int num);
+int snd_soc_new_ac97_codec(struct snd_soc_codec *codec);
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
 
 /*
@@ -932,6 +931,7 @@ struct snd_soc_dai_link {
 	/* machine stream operations */
 	const struct snd_soc_ops *ops;
 	const struct snd_soc_compr_ops *compr_ops;
+	const struct snd_ac97_bus_ops *ac97_ops;
 };
 
 struct snd_soc_codec_conf {
@@ -992,6 +992,8 @@ struct snd_soc_card {
 				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level);
 
+	struct snd_ac97_bus_ops *ac97_ops;
+
 	long pmdown_time;
 
 	/* CPU <--> Codec DAI links  */
@@ -1004,6 +1006,7 @@ struct snd_soc_card {
 	struct snd_soc_codec_conf *codec_conf;
 	int num_configs;
 
+
 	/*
 	 * optional auxiliary devices such as amplifiers or codecs with DAI
 	 * link unused
diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index 44b8dce..b4c4d7f 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -179,13 +179,13 @@ static void au1xac97c_ac97_cold_reset(struct snd_ac97 *ac97)
 }
 
 /* AC97 controller operations */
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops au1x_ac97_ops = {
 	.read		= au1xac97c_ac97_read,
 	.write		= au1xac97c_ac97_write,
 	.reset		= au1xac97c_ac97_cold_reset,
 	.warm_reset	= au1xac97c_ac97_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);	/* globals be gone! */
+EXPORT_SYMBOL_GPL(au1x_ac97_ops);	/* globals be gone! */
 
 static int alchemy_ac97c_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
index 376d976..b0e115a 100644
--- a/sound/soc/au1x/db1000.c
+++ b/sound/soc/au1x/db1000.c
@@ -32,6 +32,7 @@ static struct snd_soc_card db1000_ac97 = {
 	.owner		= THIS_MODULE,
 	.dai_link	= &db1000_ac97_dai,
 	.num_links	= 1,
+	.ac97_ops	= &au1x_ac97_ops,
 };
 
 static int db1000_audio_probe(struct platform_device *pdev)
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index a497a0c..a5a6afb 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -60,6 +60,7 @@ static struct snd_soc_card db1200_ac97_machine = {
 	.owner		= THIS_MODULE,
 	.dai_link	= &db1200_ac97_dai,
 	.num_links	= 1,
+	.ac97_ops	= &au1xpsc_ac97_ops,
 };
 
 static struct snd_soc_dai_link db1300_ac97_dai = {
@@ -75,12 +76,14 @@ static struct snd_soc_card db1300_ac97_machine = {
 	.name		= "DB1300_AC97",
 	.dai_link	= &db1300_ac97_dai,
 	.num_links	= 1,
+	.ac97_ops	= &au1xpsc_ac97_ops,
 };
 
 static struct snd_soc_card db1550_ac97_machine = {
 	.name		= "DB1550_AC97",
 	.dai_link	= &db1200_ac97_dai,
 	.num_links	= 1,
+	.ac97_ops	= &au1xpsc_ac97_ops,
 };
 
 /*-------------------------  I2S PART  ---------------------------*/
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 8f1862a..dd88c2d 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -201,13 +201,13 @@ static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
 }
 
 /* AC97 controller operations */
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops au1xpsc_ac97_ops = {
 	.read		= au1xpsc_ac97_read,
 	.write		= au1xpsc_ac97_write,
 	.reset		= au1xpsc_ac97_cold_reset,
 	.warm_reset	= au1xpsc_ac97_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+EXPORT_SYMBOL_GPL(au1xpsc_ac97_ops);
 
 static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index b16b2e0..3093159 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -26,6 +26,9 @@ struct au1xpsc_audio_data {
 	int dmaids[2];
 };
 
+extern struct snd_ac97_bus_ops au1xpsc_ac97_ops;
+extern struct snd_ac97_bus_ops au1x_ac97_ops;
+
 /* easy access macros */
 #define PSC_CTRL(x)	((unsigned long)((x)->mmio) + PSC_CTRL_OFFSET)
 #define PSC_SEL(x)	((unsigned long)((x)->mmio) + PSC_SEL_OFFSET)
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index 7798fbd..07e306a 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -237,13 +237,13 @@ static irqreturn_t ep93xx_ac97_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops ep93xx_ac97_ops = {
 	.read		= ep93xx_ac97_read,
 	.write		= ep93xx_ac97_write,
 	.reset		= ep93xx_ac97_cold_reset,
 	.warm_reset	= ep93xx_ac97_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+EXPORT_SYMBOL_GPL(ep93xx_ac97_ops);
 
 static int ep93xx_ac97_trigger(struct snd_pcm_substream *substream,
 			       int cmd, struct snd_soc_dai *dai)
diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
index 4d094d0..66e88ea 100644
--- a/sound/soc/cirrus/simone.c
+++ b/sound/soc/cirrus/simone.c
@@ -35,6 +35,7 @@ static struct snd_soc_card snd_soc_simone = {
 	.owner		= THIS_MODULE,
 	.dai_link	= &simone_dai,
 	.num_links	= 1,
+	.ac97_ops	= &ep93xx_ac97_ops,
 };
 
 static struct platform_device *simone_snd_ac97_device;
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 76553c3..0fd2734 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -62,13 +62,13 @@ static struct snd_soc_dai_driver ac97_dai = {
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	return codec->bus->ops->read(codec->ac97, reg);
+	return codec->ac97->bus->ops->read(codec->ac97, reg);
 }
 
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
-	codec->bus->ops->write(codec->ac97, reg, val);
+	codec->ac97->bus->ops->write(codec->ac97, reg, val);
 	return 0;
 }
 
@@ -79,7 +79,7 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
 	int ret;
 
 	/* add codec as bus device for standard ac97 */
-	ret = snd_ac97_bus(codec->card->snd_card, 0, &soc_ac97_ops, NULL, &ac97_bus);
+	ret = snd_ac97_bus(codec->card->snd_card, 0, codec->card->ac97_ops, NULL, &ac97_bus);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 34d1036..ee215a0 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -186,7 +186,7 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "AD1980 SoC Audio Codec\n");
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0) {
 		printk(KERN_ERR "ad1980: failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index caea922..9f15e89 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -340,7 +340,7 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "STAC9766 SoC Audio Codec %s\n", STAC9766_VERSION);
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0)
 		goto codec_err;
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 3e8d510..9388ef2 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -339,7 +339,7 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "WM9705 SoC Audio Codec\n");
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9705: failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index e02951e..4ec869d 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -635,7 +635,7 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9712: failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index f740487..e55fb86 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1197,7 +1197,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, wm9713);
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0)
 		goto codec_err;
 
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 902fab0..37e94fe 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -501,13 +501,13 @@ static void imx_ssi_ac97_warm_reset(struct snd_ac97 *ac97)
 	imx_ssi_ac97_read(ac97, 0);
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops imx_ssi_ac97_ops = {
 	.read		= imx_ssi_ac97_read,
 	.write		= imx_ssi_ac97_write,
 	.reset		= imx_ssi_ac97_reset,
 	.warm_reset	= imx_ssi_ac97_warm_reset
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+EXPORT_SYMBOL_GPL(imx_ssi_ac97_ops);
 
 static int imx_ssi_probe(struct platform_device *pdev)
 {
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index bb6b3db..1ef6ee2 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -216,4 +216,6 @@ struct imx_ssi {
 	struct platform_device *soc_platform_pdev_fiq;
 };
 
+extern struct snd_ac97_bus_ops imx_ssi_ac97_ops;
+
 #endif /* _IMX_SSI_H */
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 4141b35..00bce4a 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -131,13 +131,13 @@ static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 	psc_ac97_warm_reset(ac97);
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops psc_ac97_ops = {
 	.read		= psc_ac97_read,
 	.write		= psc_ac97_write,
 	.reset		= psc_ac97_cold_reset,
 	.warm_reset	= psc_ac97_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+EXPORT_SYMBOL_GPL(psc_ac97_ops);
 
 static int psc_ac97_hw_analog_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.h b/sound/soc/fsl/mpc5200_psc_ac97.h
index e881e78..4e28b03 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.h
+++ b/sound/soc/fsl/mpc5200_psc_ac97.h
@@ -10,4 +10,6 @@
 #define MPC5200_AC97_NORMAL 0
 #define MPC5200_AC97_SPDIF 1
 
+extern struct snd_ac97_bus_ops *psc_ac97_ops;
+
 #endif /* __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__ */
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index fe3285c..869581f 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -197,13 +197,13 @@ static void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)
 }
 
 /* AC97 controller operations */
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops nuc900_ac97_ops = {
 	.read		= nuc900_ac97_read,
 	.write		= nuc900_ac97_write,
 	.reset		= nuc900_ac97_cold_reset,
 	.warm_reset	= nuc900_ac97_warm_reset,
 }
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+EXPORT_SYMBOL_GPL(nuc900_ac97_ops);
 
 static int nuc900_ac97_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
diff --git a/sound/soc/nuc900/nuc900-audio.c b/sound/soc/nuc900/nuc900-audio.c
index 2f6e6fd..938bf55 100644
--- a/sound/soc/nuc900/nuc900-audio.c
+++ b/sound/soc/nuc900/nuc900-audio.c
@@ -35,6 +35,7 @@ static struct snd_soc_card nuc900evb_audio_machine = {
 	.owner		= THIS_MODULE,
 	.dai_link	= &nuc900evb_ac97_dai,
 	.num_links	= 1,
+	.ac97_ops	= &nuc900_ac97_ops,
 };
 
 static struct platform_device *nuc900evb_asoc_dev;
diff --git a/sound/soc/nuc900/nuc900-audio.h b/sound/soc/nuc900/nuc900-audio.h
index 59f7e8e..72c8a6c 100644
--- a/sound/soc/nuc900/nuc900-audio.h
+++ b/sound/soc/nuc900/nuc900-audio.h
@@ -111,5 +111,6 @@ struct nuc900_audio {
 };
 
 extern struct nuc900_audio *nuc900_ac97_data;
+extern struct snd_ac97_bus_ops *nuc900_ac97_ops;
 
 #endif /*end _NUC900_AUDIO_H */
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 57ea8e6..eee66aa 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -41,13 +41,13 @@ static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
 	pxa2xx_ac97_finish_reset(ac97);
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.read	= pxa2xx_ac97_read,
 	.write	= pxa2xx_ac97_write,
 	.warm_reset	= pxa2xx_ac97_warm_reset,
 	.reset	= pxa2xx_ac97_cold_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_ops);
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_stereo_out = {
 	.name			= "AC97 PCM Stereo out",
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index cb88ead..f9f036a 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -214,13 +214,13 @@ static irqreturn_t s3c_ac97_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops s3c_ac97_ops = {
 	.read       = s3c_ac97_read,
 	.write      = s3c_ac97_write,
 	.warm_reset = s3c_ac97_warm_reset,
 	.reset      = s3c_ac97_cold_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+EXPORT_SYMBOL_GPL(s3c_ac97_ops);
 
 static int s3c_ac97_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
diff --git a/sound/soc/samsung/ln2440sbc_alc650.c b/sound/soc/samsung/ln2440sbc_alc650.c
index 9342fc2..cc38567 100644
--- a/sound/soc/samsung/ln2440sbc_alc650.c
+++ b/sound/soc/samsung/ln2440sbc_alc650.c
@@ -37,6 +37,7 @@ static struct snd_soc_card ln2440sbc = {
 	.owner = THIS_MODULE,
 	.dai_link = ln2440sbc_dai,
 	.num_links = ARRAY_SIZE(ln2440sbc_dai),
+	.ac97_ops = &samsung_ac97_ops,
 };
 
 static struct platform_device *ln2440sbc_snd_ac97_device;
diff --git a/sound/soc/samsung/regs-ac97.h b/sound/soc/samsung/regs-ac97.h
index c3878f7..42459ac 100644
--- a/sound/soc/samsung/regs-ac97.h
+++ b/sound/soc/samsung/regs-ac97.h
@@ -64,4 +64,6 @@
 #define S3C_AC97_PCM_DATA				(0x18)
 #define S3C_AC97_MIC_DATA				(0x1C)
 
+extern struct snd_ac97_bus_ops *s3c_ac97_ops;
+
 #endif /* __ASM_ARCH_REGS_AC97_H */
diff --git a/sound/soc/samsung/smdk2443_wm9710.c b/sound/soc/samsung/smdk2443_wm9710.c
index c390aad6..9c224c9c 100644
--- a/sound/soc/samsung/smdk2443_wm9710.c
+++ b/sound/soc/samsung/smdk2443_wm9710.c
@@ -33,6 +33,7 @@ static struct snd_soc_card smdk2443 = {
 	.owner = THIS_MODULE,
 	.dai_link = smdk2443_dai,
 	.num_links = ARRAY_SIZE(smdk2443_dai),
+	.ac97_ops = &samsung_ac97_ops,
 };
 
 static struct platform_device *smdk2443_snd_ac97_device;
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index 4a3568a..bd9cc6c 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -31,6 +31,7 @@ static struct snd_soc_card sh7760_ac97_soc_machine  = {
 	.owner = THIS_MODULE,
 	.dai_link = &sh7760_ac97_dai,
 	.num_links = 1,
+	.ac97_ops = &sh_ac97_ops,
 };
 
 static struct platform_device *sh7760_ac97_snd_device;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d56bbea..068d3a4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2046,8 +2046,7 @@ EXPORT_SYMBOL_GPL(snd_soc_platform_write);
  *
  * Initialises AC97 codec resources for use by ad-hoc devices only.
  */
-int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
-	struct snd_ac97_bus_ops *ops, int num)
+int snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
 {
 	mutex_lock(&codec->mutex);
 
@@ -2065,8 +2064,8 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 		return -ENOMEM;
 	}
 
-	codec->ac97->bus->ops = ops;
-	codec->ac97->num = num;
+	codec->ac97->bus->ops = codec->card->ac97_ops;
+	codec->ac97->num = 0;
 
 	/*
 	 * Mark the AC97 device to be created by us. This way we ensure that the
diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index 2f70ea7..4643ad5 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -142,13 +142,13 @@ static void tegra20_ac97_codec_write(struct snd_ac97 *ac97_snd,
 	} while (!time_after(jiffies, timeout));
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+struct snd_ac97_bus_ops tegra20_ac97_ops = {
 	.read		= tegra20_ac97_codec_read,
 	.write		= tegra20_ac97_codec_write,
 	.reset		= tegra20_ac97_codec_reset,
 	.warm_reset	= tegra20_ac97_codec_warm_reset,
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+EXPORT_SYMBOL_GPL(tegra20_ac97_ops);
 
 static inline void tegra20_ac97_start_playback(struct tegra20_ac97 *ac97)
 {
diff --git a/sound/soc/tegra/tegra20_ac97.h b/sound/soc/tegra/tegra20_ac97.h
index 4acb3aa..f94d2d7 100644
--- a/sound/soc/tegra/tegra20_ac97.h
+++ b/sound/soc/tegra/tegra20_ac97.h
@@ -92,4 +92,7 @@ struct tegra20_ac97 {
 	int sync_gpio;
 	struct tegra_asoc_utils_data util_data;
 };
+
+extern struct snd_ac97_bus_ops tegra_ac97_ops;
+
 #endif /* __TEGRA20_AC97_H__ */
diff --git a/sound/soc/txx9/txx9aclc-generic.c b/sound/soc/txx9/txx9aclc-generic.c
index b056a14..4a12a18 100644
--- a/sound/soc/txx9/txx9aclc-generic.c
+++ b/sound/soc/txx9/txx9aclc-generic.c
@@ -35,6 +35,7 @@ static struct snd_soc_card txx9aclc_generic_card = {
 	.owner		= THIS_MODULE,
 	.dai_link	= &txx9aclc_generic_dai,
 	.num_links	= 1,
+	.ac97_ops	= &txx9_ac97_ops,
 };
 
 static struct platform_device *soc_pdev;
commit 3319b5d42f24524aad47312105355bc7b6ce6ba6
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Apr 22 22:09:38 2013 +0200

    ASoC: remove most references to soc_ac97_ops

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index ef2ae32..76553c3 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -62,13 +62,13 @@ static struct snd_soc_dai_driver ac97_dai = {
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	return soc_ac97_ops.read(codec->ac97, reg);
+	return codec->bus->ops->read(codec->ac97, reg);
 }
 
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
-	soc_ac97_ops.write(codec->ac97, reg, val);
+	codec->bus->ops->write(codec->ac97, reg, val);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index f385342..34d1036 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -108,7 +108,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	case AC97_EXTENDED_STATUS:
 	case AC97_VENDOR_ID1:
 	case AC97_VENDOR_ID2:
-		return soc_ac97_ops.read(codec->ac97, reg);
+		return codec->ac97->bus->ops->read(codec->ac97, reg);
 	default:
 		reg = reg >> 1;
 
@@ -124,7 +124,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u16 *cache = codec->reg_cache;
 
-	soc_ac97_ops.write(codec->ac97, reg, val);
+	codec->ac97->bus->ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < ARRAY_SIZE(ad1980_reg))
 		cache[reg] = val;
@@ -154,13 +154,13 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 	u16 retry_cnt = 0;
 
 retry:
-	if (try_warm && soc_ac97_ops.warm_reset) {
-		soc_ac97_ops.warm_reset(codec->ac97);
+	if (try_warm && codec->ac97->bus->ops->warm_reset) {
+		codec->ac97->bus->ops->warm_reset(codec->ac97);
 		if (ac97_read(codec, AC97_RESET) == 0x0090)
 			return 1;
 	}
 
-	soc_ac97_ops.reset(codec->ac97);
+	codec->ac97->bus->ops->reset(codec->ac97);
 	/* Set bit 16slot in register 74h, then every slot will has only 16
 	 * bits. This command is sent out in 20bit mode, in which case the
 	 * first nibble of data is eaten by the addr. (Tag is always 16 bit)*/
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 2eda85ba..caea922 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -145,14 +145,14 @@ static int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	if (reg > AC97_STAC_PAGE0) {
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
-		soc_ac97_ops.write(codec->ac97, reg, val);
+		codec->ac97->bus->ops->write(codec->ac97, reg, val);
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
 		return 0;
 	}
 	if (reg / 2 >= ARRAY_SIZE(stac9766_reg))
 		return -EIO;
 
-	soc_ac97_ops.write(codec->ac97, reg, val);
+	codec->ac97->bus->ops->write(codec->ac97, reg, val);
 	cache[reg / 2] = val;
 	return 0;
 }
@@ -164,7 +164,7 @@ static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
 
 	if (reg > AC97_STAC_PAGE0) {
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
-		val = soc_ac97_ops.read(codec->ac97, reg - AC97_STAC_PAGE0);
+		val = codec->ac97->bus->ops->read(codec->ac97, reg - AC97_STAC_PAGE0);
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
 		return val;
 	}
@@ -175,7 +175,7 @@ static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
 		reg == AC97_INT_PAGING || reg == AC97_VENDOR_ID1 ||
 		reg == AC97_VENDOR_ID2) {
 
-		val = soc_ac97_ops.read(codec->ac97, reg);
+		val = codec->ac97->bus->ops->read(codec->ac97, reg);
 		return val;
 	}
 	return cache[reg / 2];
@@ -242,15 +242,15 @@ static int stac9766_set_bias_level(struct snd_soc_codec *codec,
 
 static int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
 {
-	if (try_warm && soc_ac97_ops.warm_reset) {
-		soc_ac97_ops.warm_reset(codec->ac97);
+	if (try_warm && codec->ac97->bus->ops->warm_reset) {
+		codec->ac97->bus->ops->warm_reset(codec->ac97);
 		if (stac9766_ac97_read(codec, 0) == stac9766_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops.reset(codec->ac97);
-	if (soc_ac97_ops.warm_reset)
-		soc_ac97_ops.warm_reset(codec->ac97);
+	codec->ac97->bus->ops->reset(codec->ac97);
+	if (codec->ac97->bus->ops->warm_reset)
+		codec->ac97->bus->ops->warm_reset(codec->ac97);
 	if (stac9766_ac97_read(codec, 0) != stac9766_reg[0])
 		return -EIO;
 	return 0;
@@ -274,7 +274,7 @@ reset:
 		return -EIO;
 	}
 	codec->ac97->bus->ops->warm_reset(codec->ac97);
-	id = soc_ac97_ops.read(codec->ac97, AC97_VENDOR_ID2);
+	id = codec->ac97->bus->ops->read(codec->ac97, AC97_VENDOR_ID2);
 	if (id != 0x4c13) {
 		stac9766_reset(codec, 0);
 		reset++;
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 05b1f34..3e8d510 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -209,7 +209,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
 	case AC97_RESET:
 	case AC97_VENDOR_ID1:
 	case AC97_VENDOR_ID2:
-		return soc_ac97_ops.read(codec->ac97, reg);
+		return codec->ac97->bus->ops->read(codec->ac97, reg);
 	default:
 		reg = reg >> 1;
 
@@ -225,7 +225,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u16 *cache = codec->reg_cache;
 
-	soc_ac97_ops.write(codec->ac97, reg, val);
+	codec->ac97->bus->ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9705_reg)))
 		cache[reg] = val;
@@ -294,8 +294,8 @@ static struct snd_soc_dai_driver wm9705_dai[] = {
 
 static int wm9705_reset(struct snd_soc_codec *codec)
 {
-	if (soc_ac97_ops.reset) {
-		soc_ac97_ops.reset(codec->ac97);
+	if (codec->ac97->bus->ops->reset) {
+		codec->ac97->bus->ops->reset(codec->ac97);
 		if (ac97_read(codec, 0) == wm9705_reg[0])
 			return 0; /* Success */
 	}
@@ -306,7 +306,7 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 #ifdef CONFIG_PM
 static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 {
-	soc_ac97_ops.write(codec->ac97, AC97_POWERDOWN, 0xffff);
+	codec->ac97->bus->ops->write(codec->ac97, AC97_POWERDOWN, 0xffff);
 
 	return 0;
 }
@@ -323,7 +323,7 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 	}
 
 	for (i = 2; i < ARRAY_SIZE(wm9705_reg) << 1; i += 2) {
-		soc_ac97_ops.write(codec->ac97, i, cache[i>>1]);
+		codec->ac97->bus->ops->write(codec->ac97, i, cache[i>>1]);
 	}
 
 	return 0;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 8e9a6a3..e02951e 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -455,7 +455,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
 		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
 		reg == AC97_REC_GAIN)
-		return soc_ac97_ops.read(codec->ac97, reg);
+		return codec->ac97->bus->ops->read(codec->ac97, reg);
 	else {
 		reg = reg >> 1;
 
@@ -472,7 +472,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	u16 *cache = codec->reg_cache;
 
 	if (reg < 0x7c)
-		soc_ac97_ops.write(codec->ac97, reg, val);
+		codec->ac97->bus->ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9712_reg)))
 		cache[reg] = val;
@@ -581,15 +581,15 @@ static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 
 static int wm9712_reset(struct snd_soc_codec *codec, int try_warm)
 {
-	if (try_warm && soc_ac97_ops.warm_reset) {
-		soc_ac97_ops.warm_reset(codec->ac97);
+	if (try_warm && codec->ac97->bus->ops->warm_reset) {
+		codec->ac97->bus->ops->warm_reset(codec->ac97);
 		if (ac97_read(codec, 0) == wm9712_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops.reset(codec->ac97);
-	if (soc_ac97_ops.warm_reset)
-		soc_ac97_ops.warm_reset(codec->ac97);
+	codec->ac97->bus->ops->reset(codec->ac97);
+	if (codec->ac97->bus->ops->warm_reset)
+		codec->ac97->bus->ops->warm_reset(codec->ac97);
 	if (ac97_read(codec, 0) != wm9712_reg[0])
 		goto err;
 	return 0;
@@ -624,7 +624,7 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 			if (i == AC97_INT_PAGING || i == AC97_POWERDOWN ||
 			    (i > 0x58 && i != 0x5c))
 				continue;
-			soc_ac97_ops.write(codec->ac97, i, cache[i>>1]);
+			codec->ac97->bus->ops->write(codec->ac97, i, cache[i>>1]);
 		}
 	}
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index f7afa68..f740487 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -652,7 +652,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
 		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
 		reg == AC97_CD)
-		return soc_ac97_ops.read(codec->ac97, reg);
+		return codec->ac97->bus->ops->read(codec->ac97, reg);
 	else {
 		reg = reg >> 1;
 
@@ -668,7 +668,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u16 *cache = codec->reg_cache;
 	if (reg < 0x7c)
-		soc_ac97_ops.write(codec->ac97, reg, val);
+		codec->ac97->bus->ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9713_reg)))
 		cache[reg] = val;
@@ -1095,15 +1095,15 @@ static struct snd_soc_dai_driver wm9713_dai[] = {
 
 int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 {
-	if (try_warm && soc_ac97_ops.warm_reset) {
-		soc_ac97_ops.warm_reset(codec->ac97);
+	if (try_warm && codec->ac97->bus->ops->warm_reset) {
+		codec->ac97->bus->ops->warm_reset(codec->ac97);
 		if (ac97_read(codec, 0) == wm9713_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops.reset(codec->ac97);
-	if (soc_ac97_ops.warm_reset)
-		soc_ac97_ops.warm_reset(codec->ac97);
+	codec->ac97->bus->ops->reset(codec->ac97);
+	if (codec->ac97->bus->ops->warm_reset)
+		codec->ac97->bus->ops->warm_reset(codec->ac97);
 	if (ac97_read(codec, 0) != wm9713_reg[0])
 		return -EIO;
 	return 0;
@@ -1180,7 +1180,7 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 			if (i == AC97_POWERDOWN || i == AC97_EXTENDED_MID ||
 				i == AC97_EXTENDED_MSTATUS || i > 0x66)
 				continue;
-			soc_ac97_ops.write(codec->ac97, i, cache[i>>1]);
+			codec->ac97->bus->ops->write(codec->ac97, i, cache[i>>1]);
 		}
 	}
 
