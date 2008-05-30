From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC V2] Make Freescale MPC8610 drivers more
	dynamic
Date: Fri, 30 May 2008 17:41:51 -0500
Message-ID: <1212187311-22901-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id BA1A62433C
	for <alsa-devel@alsa-project.org>;
	Sat, 31 May 2008 00:42:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lg@opensource.wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

More miscellaneous changes to the Freescale MPC8610 driver set, with the goal
of supporting multiple SSIs.

Minor documentation improvements.  Allow teh CS4270 registers to be read
via sysfs.  Create the device names from the device tree, to allow multiple
devices.  Remove separate Kconfig option for the MPC8610 SOC.  Various
minor code optimizations.  Improve programming of the global utilties
registers.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

My patch, "Add CS4270 i2c data to fsl_soc.c" must be applied for these drivers
to work.

 sound/soc/codecs/cs4270.c    |   85 ++++++----
 sound/soc/fsl/Kconfig        |   28 +---
 sound/soc/fsl/Makefile       |    7 +-
 sound/soc/fsl/fsl_dma.c      |    7 +-
 sound/soc/fsl/fsl_dma.h      |    5 -
 sound/soc/fsl/fsl_ssi.c      |   57 +++----
 sound/soc/fsl/fsl_ssi.h      |   19 ++-
 sound/soc/fsl/mpc8610_hpcd.c |  350 ++++++++++++++++++++++++++++++------------
 8 files changed, 354 insertions(+), 204 deletions(-)
 rewrite sound/soc/fsl/Kconfig (77%)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 6bb4bc7..410fed5 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -104,18 +104,28 @@
 #define CS4270_MUTE_DAC_A	0x01
 #define CS4270_MUTE_DAC_B	0x02
 
-/* Private data for the CS4270 */
+/**
+ * struct cs4270_private: per-codec private data for the CS4270
+ * @codec: codec structure
+ * @name: name of this codec
+ * @mclk: input frequency of the MCLK pin
+ * @mode: mode (I2S or left-justified)
+ * @reg_cache: register cache
+ *
+ * The register cache is NUMREGS+1 because the hardware registers are
+ * indexed from 1, not 0.  The ASoC function that reads the registers
+ * assumes it's indexed from 0, so to maintain compatibility we pretend
+ * there is a register 0.
+ */
 struct cs4270_private {
 	struct snd_soc_codec codec;
 	char name[16];
-	unsigned int mclk; /* Input frequency of the MCLK pin */
-	unsigned int mode; /* The mode (I2S or left-justified) */
-	struct snd_soc_dai_ops dai_ops;
+	unsigned int mclk;
+	unsigned int mode;
 	struct snd_soc_dai *dai;
-	struct snd_soc_dai_new dai_new;
 	struct snd_soc_dai_caps playback;
 	struct snd_soc_dai_caps capture;
-	u8 reg_cache[CS4270_NUMREGS];
+	u8 reg_cache[CS4270_NUMREGS + 1];
 };
 
 /*
@@ -169,8 +179,8 @@ static struct {
 /* The number of MCLK/LRCK ratios supported by the CS4270 */
 #define NUM_MCLK_RATIOS		ARRAY_SIZE(cs4270_mode_ratios)
 
-/*
- * Determine the CS4270 samples rates.
+/**
+ * cs4270_set_dai_sysclk: determine the CS4270 samples rates.
  *
  * 'freq' is the input frequency to MCLK.  The other parameters are ignored.
  *
@@ -284,10 +294,10 @@ static unsigned int cs4270_read_reg_cache(struct snd_soc_codec *codec,
 		container_of(codec, struct cs4270_private, codec);
 	u8 *cache = cs4270->reg_cache;
 
-	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
+	if (reg > CS4270_LASTREG)
 		return -EIO;
 
-	return cache[reg - CS4270_FIRSTREG];
+	return cache[reg];
 }
 
 /*
@@ -311,7 +321,7 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 
 	/* Only perform an I2C operation if the new value is different */
-	if (cache[reg - CS4270_FIRSTREG] != value) {
+	if (cache[reg] != value) {
 		struct i2c_client *client = codec->control_data;
 
 		if (i2c_smbus_write_byte_data(client, reg, value)) {
@@ -320,7 +330,7 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 		}
 
 		/* We've written to the hardware, so update the cache */
-		cache[reg - CS4270_FIRSTREG] = value;
+		cache[reg] = value;
 	}
 
 	return 0;
@@ -481,6 +491,13 @@ static int cs4270_codec_init(struct snd_soc_codec *codec,
 	return ret;
 }
 
+static struct snd_soc_dai_ops dai_ops = {
+	.hw_params = cs4270_hw_params,
+	.set_sysclk = cs4270_set_dai_sysclk,
+	.set_fmt = cs4270_set_dai_fmt,
+	.digital_mute = cs4270_mute,
+};
+
 /*
  * Initialize the I2C interface of the CS4270
  *
@@ -495,8 +512,8 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 {
 	struct cs4270_private *cs4270;
 	struct snd_soc_codec *codec = NULL;
+	struct snd_soc_dai_new dai_new;
 	int ret = 0;
-	int registered = 0;	/* 1 == the codec has been registered */
 
 	/* Verify that we have a CS4270 */
 
@@ -515,8 +532,9 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	dev_info(&client->dev, "found device at address %X\n", client->addr);
-	dev_info(&client->dev, "hardware revision %X\n", ret & 0xF);
+	dev_info(&client->dev,
+		"found device at address %X, hardware revision %u\n",
+		client->addr, ret & 0xF);
 
 	/*
 	 * Normally, we'd call snd_soc_new_codec, but that function
@@ -532,15 +550,20 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 
 	/* The I2C interface is set up, so pre-fill our register cache */
 	ret = i2c_smbus_read_i2c_block_data(client, CS4270_FIRSTREG | 0x80,
-		CS4270_NUMREGS, cs4270->reg_cache);
+		CS4270_NUMREGS, cs4270->reg_cache + 1);
 	if (ret != CS4270_NUMREGS) {
 		dev_err(&client->dev, "failed to fill register cache\n");
 		ret = -EIO;
 		goto error;
 	}
 
-	strcpy(cs4270->name, "cirrus,cs4270");
+	sprintf(cs4270->name, "%s@%s", dev_driver_string(&client->dev),
+		dev_name(&client->dev));
 
+	/* Initialize the playback and capture stream data.  The sample rate
+	 * fields are initialized later when the fabric driver calls
+	 * cs4270_set_dai_sysclk().  Hopefully, this won't cause any problems.
+	 */
 	cs4270->playback.stream_name = "Playback";
 	cs4270->playback.channels_min = 1;
 	cs4270->playback.channels_max = 2;
@@ -551,11 +574,6 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 	cs4270->capture.channels_max = 2;
 	cs4270->capture.formats = CS4270_FORMATS;
 
-	cs4270->dai_ops.hw_params = cs4270_hw_params;
-	cs4270->dai_ops.set_sysclk = cs4270_set_dai_sysclk;
-	cs4270->dai_ops.set_fmt = cs4270_set_dai_fmt;
-	cs4270->dai_ops.digital_mute = cs4270_mute;
-
 	codec = &cs4270->codec;
 
 	mutex_init(&codec->mutex);
@@ -563,29 +581,29 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 	INIT_LIST_HEAD(&codec->dai_list);
 	codec->name = cs4270->name;
 
-	codec->control_data = client;
+	snd_soc_card_config_codec(codec, NULL, NULL, client);
 	codec->init = cs4270_codec_init;
 	codec->reg_cache = cs4270->reg_cache;
 	codec->codec_read = cs4270_read_reg_cache;
 	codec->codec_write = cs4270_i2c_write;
+	codec->reg_cache_size = sizeof(cs4270->reg_cache);
 
 	ret = snd_soc_register_codec(codec, &client->dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to register card\n");
 		goto error;
 	}
-	registered = 1;
+	memset(&dai_new, 0, sizeof(dai_new));
+	dai_new.name = cs4270->name;
+	dai_new.playback = &cs4270->playback;
+	dai_new.capture = &cs4270->capture;
+	dai_new.ops = &dai_ops;
 
-	cs4270->dai_new.name = cs4270->name;
-	cs4270->dai_new.playback = &cs4270->playback;
-	cs4270->dai_new.capture = &cs4270->capture;
-	cs4270->dai_new.ops = &cs4270->dai_ops;
-
-	cs4270->dai =
-		snd_soc_register_codec_dai(&cs4270->dai_new, &client->dev);
+	cs4270->dai = snd_soc_register_codec_dai(&dai_new, &client->dev);
 	if (!cs4270->dai) {
 		dev_err(&client->dev, "failed to register DAI\n");
 		ret = -EINVAL;
+		snd_soc_unregister_codec(codec);
 		goto error;
 	}
 
@@ -597,9 +615,6 @@ error:
 	if (cs4270->dai)
 		snd_soc_unregister_codec_dai(cs4270->dai);
 
-	if (registered)
-		snd_soc_unregister_codec(codec);
-
 	kfree(cs4270);
 
 	return ret;
@@ -646,7 +661,7 @@ static int __init cs4270_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "Cirrus Logic CS4270 ASoC codec driver\n");
+	pr_info("Cirrus Logic CS4270 ASoC codec driver\n");
 
 	/* i2c_add_driver() will call cs4270_i2c_probe() */
 	ret = i2c_add_driver(&cs4270_i2c_driver);
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
dissimilarity index 77%
index 257101f..5e80774 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,20 +1,8 @@
-menu "ALSA SoC audio for Freescale SOCs"
-
-config SND_SOC_MPC8610
-	bool "ALSA SoC support for the MPC8610 SOC"
-	depends on SND_SOC && MPC8610_HPCD
-	default y if MPC8610
-	help
-	  Say Y if you want to add support for codecs attached to the SSI
-          device on an MPC8610.
-
-config SND_SOC_MPC8610_HPCD
-	bool "ALSA SoC support for the Freescale MPC8610 HPCD board"
-	depends on SND_SOC_MPC8610
-	select SND_SOC_CS4270
-	select SND_SOC_CS4270_VD33_ERRATA
-	default y if MPC8610_HPCD
-	help
-	  Say Y if you want to enable audio on the Freescale MPC8610 HPCD.
-
-endmenu
+config SND_SOC_MPC8610_HPCD
+	tristate "Freescale MPC8610 HPCD support"
+	depends on SND_SOC && MPC8610_HPCD
+	select SND_SOC_CS4270
+	select SND_SOC_CS4270_VD33_ERRATA
+	default y if SND_SOC && MPC8610_HPCD
+	help
+	  Say Y or M if you want to enable audio on the Freescale MPC8610 HPCD.
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 62f680a..0392962 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -1,6 +1,3 @@
-# MPC8610 HPCD Machine Support
-obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += mpc8610_hpcd.o
-
-# MPC8610 Platform Support
-obj-$(CONFIG_SND_SOC_MPC8610) += fsl_ssi.o fsl_dma.o
+# MPC8610 HPCD Support
+obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += mpc8610_hpcd.o fsl_ssi.o fsl_dma.o
 
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 2925ec0..fed18ac 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -794,8 +794,7 @@ static struct snd_pcm_ops fsl_dma_ops = {
 	.pointer	= fsl_dma_pointer,
 };
 
-const char fsl_platform_id[] = "fsl_pcm";
-EXPORT_SYMBOL_GPL(fsl_platform_id);
+static const char fsl_platform_id[] = "fsl-elo";
 
 static struct snd_soc_platform_new fsl_dma_platform = {
 	.name		= fsl_platform_id,
@@ -852,7 +851,7 @@ static __init int fsl_dma_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "Freescale Elo DMA ASoC PCM driver\n");
+	pr_info("Freescale Elo DMA ASoC platform driver\n");
 
 	ret = platform_driver_register(&fsl_dma_driver);
 	if (ret < 0) {
@@ -880,6 +879,6 @@ module_init(fsl_dma_init);
 module_exit(fsl_dma_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM driver");
+MODULE_DESCRIPTION("Freescale Elo DMA ASoC platform driver");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index ed4592f..8bba2bf 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -140,9 +140,4 @@ struct fsl_dma_info {
 	unsigned int channel_id;
 };
 
-extern const char fsl_platform_id[];
-extern struct snd_soc_dai fsl_ssi; /* TODO: probably not needed */
-
-int fsl_dma_configure(struct fsl_dma_info *dma_info);
-
 #endif
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5fd0312..1d4c3f4 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -424,7 +424,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai)
 {
-
 	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -652,8 +651,6 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 		return -ENOMEM;
 	}
 
-	ssi_info->dev = &ofdev->dev;
-
 	/*
 	 * We are only interested in SSIs with a codec phandle in them, so let's
 	 * make sure this SSI has one.
@@ -689,7 +686,7 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 	}
 	ssi_info->id = *iprop;
 
-	strcpy(ssi_info->name, "fsl,mpc8610-ssi");
+	sprintf(ssi_info->name, "ssi%u", ssi_info->id);
 
 	/* Get the serial format and clock direction. */
 	sprop = of_get_property(np, "fsl,mode", NULL);
@@ -703,20 +700,6 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 		ssi_info->dai_format = SND_SOC_DAIFMT_I2S;
 		ssi_info->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_IN;
-
-		/*
-		 * In i2s-slave mode, the codec has its own clock source, so we
-		 * need to get the frequency from the device tree and pass it to
-		 * the codec driver.
-		 */
-		iprop = of_get_property(codec_np, "clock-frequency", NULL);
-		if (!iprop || !*iprop) {
-			dev_err(&ofdev->dev, "codec bus-frequency property "
-				"is missing or invalid\n");
-			ret = -EINVAL;
-			goto error;
-		}
-		ssi_info->clk_frequency = *iprop;
 	} else if (strcasecmp(sprop, "i2s-master") == 0) {
 		ssi_info->dai_format = SND_SOC_DAIFMT_I2S;
 		ssi_info->codec_clk_direction = SND_SOC_CLOCK_IN;
@@ -752,6 +735,19 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 		goto error;
 	}
 
+	/* If the codec is the clock source, then the codec node should
+	   contain the clock frequency. */
+	if (ssi_info->codec_clk_direction == SND_SOC_CLOCK_OUT) {
+		iprop = of_get_property(codec_np, "clock-frequency", NULL);
+		if (!iprop || !*iprop) {
+			dev_err(&ofdev->dev, "codec clock-frequency property "
+				"is missing or invalid\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		ssi_info->clk_frequency = *iprop;
+	}
+
 	if (!ssi_info->clk_frequency) {
 		dev_err(&ofdev->dev, "unknown clock frequency\n");
 		ret = -EINVAL;
@@ -825,6 +821,8 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 	dai_template.capture = &capture;
 	dai_template.ops = &ops;
 
+	/* If the other three drivers have loaded, then the call to
+	   snd_soc_register_platform_dai() will initialize the system. */
 	ssi_info->dai =
 		snd_soc_register_platform_dai(&dai_template, &ofdev->dev);
 	if (!ssi_info->dai) {
@@ -835,7 +833,7 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 
 	ssi_info->dai->private_data = ssi_info;
 
-	ssi_info->dev_attr.attr.name = ssi_info->name;
+	ssi_info->dev_attr.attr.name = "stats";
 	ssi_info->dev_attr.attr.mode = S_IRUGO;
 	ssi_info->dev_attr.show = fsl_sysfs_ssi_show;
 
@@ -848,12 +846,9 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 
 	dev_set_drvdata(&ofdev->dev, ssi_info);
 
-
-
 	return 0;
 
 error:
-
 	if (ssi_info->dai)
 		snd_soc_unregister_platform_dai(ssi_info->dai);
 
@@ -877,18 +872,14 @@ static int fsl_ssi_remove(struct of_device *ofdev)
 {
 	struct fsl_ssi_info *ssi_info = dev_get_drvdata(&ofdev->dev);
 
-	if (ssi_info->dai)
+	if (ssi_info) {
+		device_remove_file(&ofdev->dev, &ssi_info->dev_attr);
 		snd_soc_unregister_platform_dai(ssi_info->dai);
-
-	if (ssi_info->irq)
 		irq_dispose_mapping(ssi_info->irq);
-
-	if (ssi_info->ssi)
 		iounmap(ssi_info->ssi);
-
-	kfree(ssi_info);
-
-	dev_set_drvdata(&ofdev->dev, NULL);
+		kfree(ssi_info);
+		dev_set_drvdata(&ofdev->dev, NULL);
+	}
 
 	return 0;
 }
@@ -918,7 +909,7 @@ static int __init fsl_ssi_init(void)
 {
 	int ret;
 	
-	printk(KERN_INFO "Freescale SSI ASoC driver\n");
+	pr_info("Freescale SSI ASoC CPU driver\n");
 	
 	ret = of_register_platform_driver(&fsl_ssi_of_driver);
 
@@ -943,5 +934,5 @@ module_init(fsl_ssi_init);
 module_exit(fsl_ssi_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale SSI ASoC driver");
+MODULE_DESCRIPTION("Freescale SSI ASoC CPU driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 9a22b04..91af81c 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -200,14 +200,22 @@ struct ccsr_ssi {
  * fsl_ssi_info: per-SSI private data
  *
  * @name: short name for this device ("SSI0", "SSI1", etc)
+ * @id: 0=SS1, 1=SSI2, etc
  * @ssi: pointer to the SSI's registers
  * @ssi_phys: physical address of the SSI registers
  * @irq: IRQ of this SSI
- * @dev: struct device pointer
- * @playback: the number of playback streams opened
- * @capture: the number of capture streams opened
- * @cpu_dai: the CPU DAI for this device
+ * @playback: 1=playback stream open, 0 otherwise
+ * @capture: 1=capture stream open, 0 otherwise
+ * @lock: spinlock for enabling/disabling the SSI
+ * @dai: the CPU DAI for this device
  * @dev_attr: the sysfs device attribute structure
+ * @pmuxcr: saved value of the PMUXCR register
+ * @dmcr: saved value of the DMACR register
+ * @dai_format: the serial protocol format (I2S, left-justified, etc)
+ * @codec_clk_direction: whether the codec is the clock master or slave
+ * @cpu_clk_direction: whether the SSI is the clock master or slave
+ * @clk_frequency: the base frequency of the clock
+ * @dma_info: information on the two DMA channels used by this SSI
  * @stats: SSI statistics
  */
 struct fsl_ssi_info {
@@ -216,12 +224,13 @@ struct fsl_ssi_info {
 	struct ccsr_ssi __iomem *ssi;
 	dma_addr_t ssi_phys;
 	unsigned int irq;
-	struct device *dev;
 	unsigned int playback;
 	unsigned int capture;
 	spinlock_t lock;
 	struct snd_soc_dai *dai;
 	struct device_attribute dev_attr;
+	u32 pmuxcr;
+	u32 dmacr;
 
 	unsigned int dai_format;
 	unsigned int codec_clk_direction;
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 10c7fd7..4beb61e 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -1,5 +1,5 @@
 /**
- * Freescale MPC8610HPCD ALSA SoC Fabric driver
+ * Freescale MPC8610 HPCD ASoC fabric driver
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
@@ -9,6 +9,8 @@
  * express or implied.
  */
 
+#define DEBUG
+
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
@@ -24,6 +26,11 @@
 #include "fsl_dma.h"
 #include "fsl_ssi.h"
 
+/* To keep memory allocations simple, we define a limit to the number of
+ * SSIs we support.
+ */
+#define MAX_SSI		2
+
 /**
  * mpc8610_hpcd_data: fabric-specific ASoC device data
  *
@@ -31,75 +38,82 @@
  * MPC8610 HPCD.  Some of the data is taken from the device tree.
  */
 struct mpc8610_hpcd_data {
+	char codec_name[32];
 	struct snd_soc_card soc_card;
-	unsigned int dai_format;
-	unsigned int codec_clk_direction;
-	unsigned int cpu_clk_direction;
-	unsigned int clk_frequency;
 	struct ccsr_guts __iomem *guts;
+	unsigned int num_configs;
+	struct snd_soc_pcm_config pcm_configs[MAX_SSI];
+	struct mpc8610_hpcd_names {
+		char pcm_name[32];
+		char ssi_name[32];
+		char codec_name[32];
+		char platform_name[32];
+		char cpu_dai_name[32];
+	} names[MAX_SSI];
 };
 
 /**
+ * guts_dmacr_mask: return the DMACR bitmask for a given DMA channel
+ * @co: The DMA controller (0 or 1)
+ * @ch: The channel on the DMA controller (0, 1, 2, or 3)
+ */
+static inline u32 guts_dmacr_mask(unsigned int co, unsigned int ch)
+{
+	unsigned int shift = 16 + (8 * (1 - co) + 2 * (3 - ch));
+
+	return 3 << shift;
+}
+
+/**
+ * guts_pmuxcr_dma_mask: return the mask for the DMA bits in the PMXUCR
+ * @co: The DMA controller (0 or 1)
+ * @ch: The channel on the DMA controller (0, 1, 2, or 3)
+ *
+ * If ch is not 0 or 3, then a value of 0 is returned.
+ */
+static inline u32 guts_pmuxcr_dma_mask(unsigned int co, unsigned int ch)
+{
+	if ((ch == 0) || (ch == 3)) {
+		unsigned int shift = 2 * (co + 1) - (ch & 1) - 1;
+
+		return 1 << shift;
+	} else
+		return 0;
+}
+
+/**
  * mpc8610_hpcd_audio_init: initalize the board
  *
  * This function is called when platform_device_add() is called.  It is used
  * to initialize the board-specific hardware.
  *
- * Here we program the DMACR and PMUXCR registers.
+ * If the platform (SSI) driver is loaded last, then cpu_dai->private_data
+ * is not yet initialized, so therefore we cannot get ssi_info.
  */
 static int mpc8610_hpcd_audio_init(struct snd_soc_card *soc_card)
 {
+	struct snd_soc_codec *codec;
 	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
-	struct snd_soc_dai *cpu_dai =
-		snd_soc_card_get_dai(soc_card, "fsl,mpc8610-ssi");
-	struct snd_soc_codec *codec =
-		snd_soc_card_get_codec(soc_card, "cirrus,cs4270");
-	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
-	int ret;
-
-	/* This is stupid. snd_soc_card_config_codec() initializes the
-	 * codec->control_data structure, which is supposed to be a pointer to
-	 * the i2c_client structure.  But I already assigned that variable in
-	 * the codec driver.  After all, the codec driver is the one that
-	 * supposed to get probed by the I2C bus.  So in order to avoid
-	 * overwriting codec->control_data, I pass it as the 4th parameter.
-	 */
-	snd_soc_card_config_codec(codec, NULL, NULL, codec->control_data);
-	ret = snd_soc_card_init_codec(codec, soc_card);
-	if (ret < 0) {
-		dev_err(soc_card->dev, "could not initialize codec\n");
-		return ret;
-	}
-
-	/* Program the signal routing between the SSI and the DMA */
-	guts_set_dmacr(soc_card_data->guts,
-		ssi_info->dma_info[0].controller_id,
-		ssi_info->dma_info[0].channel_id, CCSR_GUTS_DMACR_DEV_SSI);
-	guts_set_dmacr(soc_card_data->guts,
-		ssi_info->dma_info[1].controller_id,
-		ssi_info->dma_info[1].channel_id, CCSR_GUTS_DMACR_DEV_SSI);
-
-	guts_set_pmuxcr_dma(soc_card_data->guts,
-		ssi_info->dma_info[0].controller_id,
-		ssi_info->dma_info[0].channel_id, 0);
-	guts_set_pmuxcr_dma(soc_card_data->guts,
-		ssi_info->dma_info[1].controller_id,
-		ssi_info->dma_info[1].channel_id, 0);
-
-	/* FIXME: Magic numbers? */
-	guts_set_pmuxcr_dma(soc_card_data->guts, 1, 0, 0);
-	guts_set_pmuxcr_dma(soc_card_data->guts, 1, 3, 0);
-	guts_set_pmuxcr_dma(soc_card_data->guts, 0, 3, 0);
+	unsigned int i;
+	int ret = 0;
 
-	switch (ssi_info->id) {
-	case 0:
-		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
-		break;
-	case 1:
-		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_SSI);
-		break;
+	for (i = 0; i < soc_card_data->num_configs; i++) {
+		codec = snd_soc_card_get_codec(soc_card,
+			soc_card_data->names[i].codec_name);
+
+		if (!codec) {
+			dev_err(soc_card->dev, "could not find codec\n");
+			return -ENODEV;
+		}
+
+		/* The codec driver should have called
+		 * snd_soc_card_config_codec() by now.
+		 */
+		ret = snd_soc_card_init_codec(codec, soc_card);
+		if (ret < 0) {
+			dev_err(soc_card->dev, "could not initialize codec\n");
+			continue;
+		}
 	}
 
 	return 0;
@@ -138,8 +152,42 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
+	struct snd_soc_card *soc_card = rtd->soc_card;
+	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
 	int ret = 0;
 
+	/* Save the PMUXCR and DMACR registers so that we can restore them
+	 * properly later.
+	 */
+	ssi_info->dmacr = in_be32(&soc_card_data->guts->dmacr);
+	ssi_info->pmuxcr = in_be32(&soc_card_data->guts->pmuxcr);
+
+	/* Program the signal routing between the SSI and the DMA */
+	guts_set_dmacr(soc_card_data->guts,
+		ssi_info->dma_info[0].controller_id,
+		ssi_info->dma_info[0].channel_id, CCSR_GUTS_DMACR_DEV_SSI);
+	guts_set_dmacr(soc_card_data->guts,
+		ssi_info->dma_info[1].controller_id,
+		ssi_info->dma_info[1].channel_id, CCSR_GUTS_DMACR_DEV_SSI);
+
+	guts_set_pmuxcr_dma(soc_card_data->guts,
+		ssi_info->dma_info[0].controller_id,
+		ssi_info->dma_info[0].channel_id, 0);
+	guts_set_pmuxcr_dma(soc_card_data->guts,
+		ssi_info->dma_info[1].controller_id,
+		ssi_info->dma_info[1].channel_id, 0);
+
+	switch (ssi_info->id) {
+	case 0:
+		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
+		break;
+	case 1:
+		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_SSI);
+		break;
+	}
+
 	/* Tell the CPU driver what the serial protocol is. */
 	ret = snd_soc_dai_set_fmt(cpu_dai, ssi_info->dai_format);
 	if (ret < 0) {
@@ -183,38 +231,106 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static void mpc8610_hpcd_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
+	struct snd_soc_card *soc_card = rtd->soc_card;
+	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
+	u32 mask;
+
+	soc_card_data = soc_card->private_data;
+	ssi_info = cpu_dai->private_data;
+
+	/* Restore the DMACR register */
+	mask = guts_dmacr_mask(ssi_info->dma_info[0].controller_id,
+		ssi_info->dma_info[0].channel_id) |
+		guts_dmacr_mask(ssi_info->dma_info[1].controller_id,
+		ssi_info->dma_info[1].channel_id);
+
+	clrsetbits_be32(&soc_card_data->guts->dmacr, mask,
+		ssi_info->dmacr & mask);
+
+	/* Restore the PMUXCR register */
+	mask = guts_pmuxcr_dma_mask(ssi_info->dma_info[0].controller_id,
+		ssi_info->dma_info[0].channel_id) |
+		guts_pmuxcr_dma_mask(ssi_info->dma_info[1].controller_id,
+		ssi_info->dma_info[1].channel_id) |
+		(ssi_info->id ? CCSR_GUTS_PMUXCR_SSI2_MASK :
+		CCSR_GUTS_PMUXCR_SSI1_MASK);
+
+	clrsetbits_be32(&soc_card_data->guts->pmuxcr, mask,
+			ssi_info->pmuxcr & mask);
+}
+
 /**
- * mpc8610_hpcd_audio_exit: Remove the sound device
+ * get_codec_name: get the name of the codec that a given SSI is using
+ * @ssi_np: pointer to the SSI node
+ * @name: returned name of the codec driver
+ *
+ * This function returns the name of the codec device that matches a given
+ * SSI.
+ *
+ * The purpose behind this function is to make the device tree the sole
+ * source of information concerning the linkage between devices in the ASoC
+ * device chain.  Unfortunately, it's not really as elegant as it should be.
  *
- * This function is called to remove the sound device for one SSI.  We
- * de-program the DMACR and PMUXCR register.
+ * With this function, we should be able to mix-and-match codecs just by
+ * loading the right codec driver.
  */
-void mpc8610_hpcd_audio_exit(struct snd_soc_card *soc_card)
+static int get_codec_name(struct device_node *ssi_np, char *name)
 {
-	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
-	struct snd_soc_dai *cpu_dai =
-		snd_soc_card_get_dai(soc_card, "fsl,mpc8610-ssi");
-	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
+	const phandle *codec_ph;
+	struct device_node *codec_np;
+	struct device_node *i2c_np;
+	unsigned int bus;
+	unsigned int addr;
+	const unsigned int *iprop;
+	const char *compat;
+
+	codec_ph = of_get_property(ssi_np, "codec-handle", NULL);
+	if (!codec_ph) {
+		pr_debug("%s: no codec handle\n", ssi_np->full_name);
+		return 0;
+	}
 
-	/* Restore the signal routing */
+	codec_np = of_find_node_by_phandle(*codec_ph);
+	if (!codec_np) {
+		pr_debug("%s: codec node does not exist\n", ssi_np->full_name);
+		return -1;
+	}
 
-	guts_set_dmacr(soc_card_data->guts,
-		ssi_info->dma_info[0].controller_id,
-		ssi_info->dma_info[0].channel_id, 0);
-	guts_set_dmacr(soc_card_data->guts,
-		ssi_info->dma_info[1].controller_id,
-		ssi_info->dma_info[1].channel_id, 0);
+	/* We assume that the first (or only) string in the compatible field is
+	 * the one that counts.
+	 */
+	compat = of_get_property(codec_np, "compatible", NULL);
+
+	/* We only care about the part after the comma */
+	compat = strchr(compat, ',') + 1;
+
+	/* Now determine the I2C bus and address it's on */
+	i2c_np = of_get_parent(codec_np);
+	iprop = of_get_property(i2c_np, "cell-index", NULL);
+	if (!iprop) {
+		pr_debug("%s: cannot determine I2C bus number\n",
+			codec_np->full_name);
+		return -1;
+	}
+	bus = *iprop;
 
-	switch (ssi_info->id) {
-	case 0:
-		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
-		break;
-	case 1:
-		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
-		break;
+	iprop = of_get_property(codec_np, "reg", NULL);
+	if (!iprop) {
+		pr_debug("%s: cannot determine I2C address\n",
+			codec_np->full_name);
+		return -1;
 	}
+	addr = *iprop;
+
+	/* Now build the string */
+	sprintf(name, "%s@%d-%04x", compat, bus, addr);
+
+	return 1;
 }
 
 /**
@@ -222,17 +338,7 @@ void mpc8610_hpcd_audio_exit(struct snd_soc_card *soc_card)
  */
 static struct snd_soc_ops mpc8610_hpcd_ops = {
 	.startup = mpc8610_hpcd_startup,
-};
-
-static struct snd_soc_pcm_config mpc8610_pcm_config = {
-	.name		= "MPC8610 HPCD",
-	.codec		= "cirrus,cs4270",
-	.codec_dai	= "cirrus,cs4270",
-	.platform	= "fsl_pcm",
-	.cpu_dai	= "fsl,mpc8610-ssi",
-	.ops		= &mpc8610_hpcd_ops,
-	.playback	= 1,
-	.capture	= 1,
+	.shutdown = mpc8610_hpcd_shutdown,
 };
 
 /**
@@ -249,6 +355,8 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	struct snd_soc_card *soc_card = NULL;
 	struct mpc8610_hpcd_data *soc_card_data;
 	struct device_node *guts_np = NULL;
+	struct device_node *ssi_np;
+	unsigned int i = 0;
 	int ret = -ENODEV;
 
 	soc_card_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
@@ -281,16 +389,63 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 
 	soc_card->longname = "MPC8610HPCD";
 	soc_card->init = mpc8610_hpcd_audio_init;
-	soc_card->exit = mpc8610_hpcd_audio_exit;
 	soc_card->private_data = soc_card_data;
 	soc_card->dev = &pdev->dev;
 
-	ret = snd_soc_card_create_pcms(soc_card, &mpc8610_pcm_config, 1);
+	/* Scan the device tree for SSI nodes.  Each one we find that has a
+	 * codec is registered.  Remember, we only support MAX_SSI of these.
+	 */
+	for_each_compatible_node(ssi_np, NULL, "fsl,mpc8610-ssi") {
+		const unsigned int *iprop;
+		struct snd_soc_pcm_config *pcm_config;
+		struct mpc8610_hpcd_names *name;
+
+		name = &soc_card_data->names[i];
+		pcm_config = &soc_card_data->pcm_configs[i];
+
+		pcm_config->name = name->pcm_name;
+		pcm_config->codec = name->codec_name;
+		pcm_config->codec_dai = name->codec_name;
+		pcm_config->platform = "fsl-elo";
+		pcm_config->cpu_dai = name->ssi_name;
+		pcm_config->ops = &mpc8610_hpcd_ops;
+		pcm_config->playback = 1;
+		pcm_config->capture = 1;
+
+		sprintf(name->pcm_name, "MPC8610HPCD.%u", i);
+
+		/* Get the SSI name */
+		iprop = of_get_property(ssi_np, "cell-index", NULL);
+		if (!iprop) {
+			dev_err(soc_card->dev, "no cell-index for %s\n",
+				ssi_np->full_name);
+			continue;
+		}
+		sprintf(name->ssi_name, "ssi%u", *iprop);
+
+		/* Get the codec name  */
+		ret = get_codec_name(ssi_np, name->codec_name);
+		if (ret < 0)
+			dev_err(soc_card->dev, "could not get codec for %s\n",
+				ssi_np->full_name);
+		if (ret < 1)
+			continue;
+
+		dev_dbg(soc_card->dev, "registering cpu %s with codec %s\n",
+			pcm_config->cpu_dai, pcm_config->codec);
+
+		if (++i == MAX_SSI)
+			break;
+	}
+
+	ret = snd_soc_card_create_pcms(soc_card, soc_card_data->pcm_configs, i);
 	if (ret) {
-		dev_err(&pdev->dev, "could not create PCMs\n");
-		goto error;
+		dev_err(soc_card->dev, "could not create PCMs\n");
+		return ret;
 	}
 
+	soc_card_data->num_configs = i;
+
 	platform_set_drvdata(pdev, soc_card);
 
 	ret = snd_soc_card_register(soc_card);
@@ -330,7 +485,7 @@ static int mpc8610_hpcd_remove(struct platform_device *pdev)
 
 static struct platform_driver mpc8610_hpcd_driver = {
 	.driver = {
-		.name   	= "mpc8610_hpcd",
+		.name   	= "MPC8610HPCD",
 		.owner		= THIS_MODULE,
 	},
 	.probe  	= mpc8610_hpcd_probe,
@@ -348,7 +503,7 @@ static int __init mpc8610_hpcd_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "Freescale MPC8610 HPCD ASoC fabric driver\n");
+	pr_info("Freescale MPC8610 HPCD ASoC fabric driver\n");
 
 	ret = platform_driver_register(&mpc8610_hpcd_driver);
 	if (ret < 0) {
@@ -356,7 +511,8 @@ static int __init mpc8610_hpcd_init(void)
 		return ret;
 	}
 
-	pdev = platform_device_register_simple("mpc8610_hpcd", 0, NULL, 0);
+	pdev = platform_device_register_simple(mpc8610_hpcd_driver.driver.name,
+		0, NULL, 0);
 	if (!pdev) {
 		pr_err("mpc8610-hpcd: could not register device\n");
 		platform_driver_unregister(&mpc8610_hpcd_driver);
-- 
1.5.5
