From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/10] ASoC: Merge snd_soc_ops into
	snd_soc_dai_ops
Date: Fri, 21 Nov 2008 14:48:29 +0000
Message-ID: <1227278913-25313-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
	<1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82260244E7
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:48:36 +0100 (CET)
In-Reply-To: <1227278913-25313-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Liam Girdwood's ASoC v2 work avoids having two different ops structures
for DAIs by merging the members of struct snd_soc_ops into struct
snd_soc_dai_ops, allowing per DAI configuration for everything.
Backport this change.

This paves the way for future work allowing any combination of DAIs to
be connected rather than having fixed purpose CODEC and CPU DAIs and
only allowing CODEC<->CPU interconnections.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h            |   20 +++++++++-
 sound/soc/atmel/atmel_ssc_dai.c    |   21 +++++-----
 sound/soc/au1x/psc-ac97.c          |    5 +-
 sound/soc/au1x/psc-i2s.c           |    8 ++--
 sound/soc/blackfin/bf5xx-i2s.c     |   12 +++--
 sound/soc/codecs/ac97.c            |    3 +-
 sound/soc/codecs/ak4535.c          |    5 +-
 sound/soc/codecs/cs4270.c          |   11 +++--
 sound/soc/codecs/ssm2602.c         |   14 ++++---
 sound/soc/codecs/tlv320aic23.c     |   19 +++++----
 sound/soc/codecs/tlv320aic26.c     |    5 +-
 sound/soc/codecs/tlv320aic3x.c     |    5 +-
 sound/soc/codecs/twl4030.c         |    5 +-
 sound/soc/codecs/uda134x.c         |   12 +++---
 sound/soc/codecs/uda1380.c         |   15 +++----
 sound/soc/codecs/wm8510.c          |    5 +-
 sound/soc/codecs/wm8580.c          |   12 ++----
 sound/soc/codecs/wm8728.c          |    5 +-
 sound/soc/codecs/wm8731.c          |   11 +++--
 sound/soc/codecs/wm8750.c          |    5 +-
 sound/soc/codecs/wm8753.c          |   25 +++++-------
 sound/soc/codecs/wm8900.c          |    5 +-
 sound/soc/codecs/wm8903.c          |   11 +++--
 sound/soc/codecs/wm8971.c          |    5 +-
 sound/soc/codecs/wm8990.c          |    6 +-
 sound/soc/codecs/wm9712.c          |    6 ++-
 sound/soc/codecs/wm9713.c          |   21 +++++-----
 sound/soc/davinci/davinci-i2s.c    |   12 +++--
 sound/soc/davinci/davinci-sffsdr.c |    3 +-
 sound/soc/fsl/fsl_ssi.c            |   14 ++++---
 sound/soc/fsl/mpc5200_psc_i2s.c    |   17 +++++---
 sound/soc/omap/omap-mcbsp.c        |   14 ++++---
 sound/soc/omap/omap2evm.c          |    3 +-
 sound/soc/pxa/pxa-ssp.c            |   20 ++++------
 sound/soc/pxa/pxa2xx-ac97.c        |    9 +++-
 sound/soc/pxa/pxa2xx-i2s.c         |   15 ++++---
 sound/soc/s3c24xx/s3c2412-i2s.c    |    8 ++--
 sound/soc/s3c24xx/s3c2443-ac97.c   |    8 ++-
 sound/soc/s3c24xx/s3c24xx-i2s.c    |    9 ++--
 sound/soc/sh/hac.c                 |    3 +-
 sound/soc/sh/ssi.c                 |   16 ++++----
 sound/soc/soc-core.c               |   74 ++++++++++++++++++------------------
 42 files changed, 265 insertions(+), 237 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 08b8f70..f51cb55 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -156,6 +156,23 @@ struct snd_soc_dai_ops {
 	 * Called by soc-core to minimise any pops.
 	 */
 	int (*digital_mute)(struct snd_soc_dai *dai, int mute);
+
+	/*
+	 * ALSA PCM audio operations - all optional.
+	 * Called by soc-core during audio PCM operations.
+	 */
+	int (*startup)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
+	void (*shutdown)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
+	int (*hw_params)(struct snd_pcm_substream *,
+		struct snd_pcm_hw_params *, struct snd_soc_dai *);
+	int (*hw_free)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
+	int (*prepare)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
+	int (*trigger)(struct snd_pcm_substream *, int,
+		struct snd_soc_dai *);
 };
 
 /*
@@ -180,8 +197,7 @@ struct snd_soc_dai {
 		struct snd_soc_dai *dai);
 
 	/* ops */
-	struct snd_soc_ops ops;
-	struct snd_soc_dai_ops dai_ops;
+	struct snd_soc_dai_ops ops;
 
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream capture;
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index d290b78..916f73b 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -202,7 +202,8 @@ static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
 /*
  * Startup.  Only that one substream allowed in each direction.
  */
-static int atmel_ssc_startup(struct snd_pcm_substream *substream)
+static int atmel_ssc_startup(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
@@ -231,7 +232,8 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream)
  * Shutdown.  Clear DMA parameters and shutdown the SSC if there
  * are no other substreams open.
  */
-static void atmel_ssc_shutdown(struct snd_pcm_substream *substream)
+static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
@@ -332,7 +334,8 @@ static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
  * Configure the SSC.
  */
 static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	int id = rtd->dai->cpu_dai->id;
@@ -600,7 +603,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 }
 
 
-static int atmel_ssc_prepare(struct snd_pcm_substream *substream)
+static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
@@ -715,8 +719,7 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 			.startup = atmel_ssc_startup,
 			.shutdown = atmel_ssc_shutdown,
 			.prepare = atmel_ssc_prepare,
-			.hw_params = atmel_ssc_hw_params,},
-		.dai_ops = {
+			.hw_params = atmel_ssc_hw_params,
 			.set_fmt = atmel_ssc_set_dai_fmt,
 			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
 		.private_data = &ssc_info[0],
@@ -741,8 +744,7 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 			.startup = atmel_ssc_startup,
 			.shutdown = atmel_ssc_shutdown,
 			.prepare = atmel_ssc_prepare,
-			.hw_params = atmel_ssc_hw_params,},
-		.dai_ops = {
+			.hw_params = atmel_ssc_hw_params,
 			.set_fmt = atmel_ssc_set_dai_fmt,
 			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
 		.private_data = &ssc_info[1],
@@ -766,8 +768,7 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 			.startup = atmel_ssc_startup,
 			.shutdown = atmel_ssc_shutdown,
 			.prepare = atmel_ssc_prepare,
-			.hw_params = atmel_ssc_hw_params,},
-		.dai_ops = {
+			.hw_params = atmel_ssc_hw_params,
 			.set_fmt = atmel_ssc_set_dai_fmt,
 			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
 		.private_data = &ssc_info[2],
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 57facba..ad60a60 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -160,7 +160,8 @@ struct snd_ac97_bus_ops soc_ac97_ops = {
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *params)
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
 {
 	/* FIXME */
 	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
@@ -210,7 +211,7 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 }
 
 static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
-				int cmd)
+				int cmd, struct snd_soc_dai *dai)
 {
 	/* FIXME */
 	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 9384702..05a5acb 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -116,7 +116,8 @@ out:
 }
 
 static int au1xpsc_i2s_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct au1xpsc_audio_data *pscdata = au1xpsc_i2s_workdata;
 
@@ -240,7 +241,8 @@ static int au1xpsc_i2s_stop(struct au1xpsc_audio_data *pscdata, int stype)
 	return 0;
 }
 
-static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
+static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
 {
 	struct au1xpsc_audio_data *pscdata = au1xpsc_i2s_workdata;
 	int ret, stype = SUBSTREAM_TYPE(substream);
@@ -389,8 +391,6 @@ struct snd_soc_dai au1xpsc_i2s_dai = {
 	.ops = {
 		.trigger	= au1xpsc_i2s_trigger,
 		.hw_params	= au1xpsc_i2s_hw_params,
-	},
-	.dai_ops = {
 		.set_fmt	= au1xpsc_i2s_set_fmt,
 	},
 };
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index e020c16..4e675b5 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -132,7 +132,8 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	return ret;
 }
 
-static int bf5xx_i2s_startup(struct snd_pcm_substream *substream)
+static int bf5xx_i2s_startup(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
 
@@ -142,7 +143,8 @@ static int bf5xx_i2s_startup(struct snd_pcm_substream *substream)
 }
 
 static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	int ret = 0;
 
@@ -193,7 +195,8 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream)
+static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
 	bf5xx_i2s.counter--;
@@ -307,8 +310,7 @@ struct snd_soc_dai bf5xx_i2s_dai = {
 	.ops = {
 		.startup   = bf5xx_i2s_startup,
 		.shutdown  = bf5xx_i2s_shutdown,
-		.hw_params = bf5xx_i2s_hw_params,},
-	.dai_ops = {
+		.hw_params = bf5xx_i2s_hw_params,
 		.set_fmt = bf5xx_i2s_set_dai_fmt,
 	},
 };
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index bd1ebdc..8a93aff 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -24,7 +24,8 @@
 
 #define AC97_VERSION "0.6"
 
-static int ac97_prepare(struct snd_pcm_substream *substream)
+static int ac97_prepare(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 2a89b58..c742290 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -339,7 +339,8 @@ static int ak4535_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 }
 
 static int ak4535_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -451,8 +452,6 @@ struct snd_soc_dai ak4535_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.hw_params = ak4535_hw_params,
-	},
-	.dai_ops = {
 		.set_fmt = ak4535_set_dai_fmt,
 		.digital_mute = ak4535_mute,
 		.set_sysclk = ak4535_set_dai_sysclk,
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 0ff476d..7507d46 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -360,13 +360,14 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 /*
  * Program the CS4270 with the given hardware parameters.
  *
- * The .dai_ops functions are used to provide board-specific data, like
+ * The .ops functions are used to provide board-specific data, like
  * input frequencies, to this driver.  This function takes that information,
  * combines it with the hardware parameters provided, and programs the
  * hardware accordingly.
  */
 static int cs4270_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params)
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -710,10 +711,10 @@ static int cs4270_probe(struct platform_device *pdev)
 	if (codec->control_data) {
 		/* Initialize codec ops */
 		cs4270_dai.ops.hw_params = cs4270_hw_params;
-		cs4270_dai.dai_ops.set_sysclk = cs4270_set_dai_sysclk;
-		cs4270_dai.dai_ops.set_fmt = cs4270_set_dai_fmt;
+		cs4270_dai.ops.set_sysclk = cs4270_set_dai_sysclk;
+		cs4270_dai.ops.set_fmt = cs4270_set_dai_fmt;
 #ifdef CONFIG_SND_SOC_CS4270_HWMUTE
-		cs4270_dai.dai_ops.digital_mute = cs4270_mute;
+		cs4270_dai.ops.digital_mute = cs4270_mute;
 #endif
 	} else
 		printk(KERN_INFO "cs4270: no I2C device found, "
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 56dc1c9..0c5884e 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -285,7 +285,8 @@ static inline int get_coeff(int mclk, int rate)
 }
 
 static int ssm2602_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
 {
 	u16 srate;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -330,7 +331,8 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int ssm2602_startup(struct snd_pcm_substream *substream)
+static int ssm2602_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -366,7 +368,8 @@ static int ssm2602_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int ssm2602_pcm_prepare(struct snd_pcm_substream *substream)
+static int ssm2602_pcm_prepare(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -377,7 +380,8 @@ static int ssm2602_pcm_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void ssm2602_shutdown(struct snd_pcm_substream *substream)
+static void ssm2602_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -536,8 +540,6 @@ struct snd_soc_dai ssm2602_dai = {
 		.prepare = ssm2602_pcm_prepare,
 		.hw_params = ssm2602_hw_params,
 		.shutdown = ssm2602_shutdown,
-	},
-	.dai_ops = {
 		.digital_mute = ssm2602_mute,
 		.set_sysclk = ssm2602_set_dai_sysclk,
 		.set_fmt = ssm2602_set_dai_fmt,
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index c903e4f..a4e13d0 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -418,7 +418,8 @@ static int tlv320aic23_add_widgets(struct snd_soc_codec *codec)
 }
 
 static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -465,7 +466,8 @@ static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int tlv320aic23_pcm_prepare(struct snd_pcm_substream *substream)
+static int tlv320aic23_pcm_prepare(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -477,7 +479,8 @@ static int tlv320aic23_pcm_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void tlv320aic23_shutdown(struct snd_pcm_substream *substream)
+static void tlv320aic23_shutdown(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -613,12 +616,10 @@ struct snd_soc_dai tlv320aic23_dai = {
 		.prepare = tlv320aic23_pcm_prepare,
 		.hw_params = tlv320aic23_hw_params,
 		.shutdown = tlv320aic23_shutdown,
-		},
-	.dai_ops = {
-		    .digital_mute = tlv320aic23_mute,
-		    .set_fmt = tlv320aic23_set_dai_fmt,
-		    .set_sysclk = tlv320aic23_set_dai_sysclk,
-		    }
+		.digital_mute = tlv320aic23_mute,
+		.set_fmt = tlv320aic23_set_dai_fmt,
+		.set_sysclk = tlv320aic23_set_dai_sysclk,
+	}
 };
 EXPORT_SYMBOL_GPL(tlv320aic23_dai);
 
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index bed8a9e..6b7ddfc 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -125,7 +125,8 @@ static int aic26_reg_write(struct snd_soc_codec *codec, unsigned int reg,
  * Digital Audio Interface Operations
  */
 static int aic26_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *params)
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -287,8 +288,6 @@ struct snd_soc_dai aic26_dai = {
 	},
 	.ops = {
 		.hw_params = aic26_hw_params,
-	},
-	.dai_ops = {
 		.digital_mute = aic26_mute,
 		.set_sysclk = aic26_set_sysclk,
 		.set_fmt = aic26_set_fmt,
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index cff276e..b76bcc3 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -694,7 +694,8 @@ static int aic3x_add_widgets(struct snd_soc_codec *codec)
 }
 
 static int aic3x_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *params)
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -1009,8 +1010,6 @@ struct snd_soc_dai aic3x_dai = {
 		.formats = AIC3X_FORMATS,},
 	.ops = {
 		.hw_params = aic3x_hw_params,
-	},
-	.dai_ops = {
 		.digital_mute = aic3x_mute,
 		.set_sysclk = aic3x_set_dai_sysclk,
 		.set_fmt = aic3x_set_dai_fmt,
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c778eb4..3348951 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -343,7 +343,8 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 }
 
 static int twl4030_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *params)
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -523,8 +524,6 @@ struct snd_soc_dai twl4030_dai = {
 		.formats = TWL4030_FORMATS,},
 	.ops = {
 		.hw_params = twl4030_hw_params,
-	},
-	.dai_ops = {
 		.set_sysclk = twl4030_set_dai_sysclk,
 		.set_fmt = twl4030_set_dai_fmt,
 	}
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 69ef521..91f333c 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -168,7 +168,8 @@ static int uda134x_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
-static int uda134x_startup(struct snd_pcm_substream *substream)
+static int uda134x_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -200,7 +201,8 @@ static int uda134x_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void uda134x_shutdown(struct snd_pcm_substream *substream)
+static void uda134x_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -214,7 +216,8 @@ static void uda134x_shutdown(struct snd_pcm_substream *substream)
 }
 
 static int uda134x_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -484,9 +487,6 @@ struct snd_soc_dai uda134x_dai = {
 		.startup = uda134x_startup,
 		.shutdown = uda134x_shutdown,
 		.hw_params = uda134x_hw_params,
-	},
-	/* DAI operations */
-	.dai_ops = {
 		.digital_mute = uda134x_mute,
 		.set_sysclk = uda134x_set_dai_sysclk,
 		.set_fmt = uda134x_set_dai_fmt,
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index a69ee72..330877c 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -407,7 +407,8 @@ static int uda1380_set_dai_fmt(struct snd_soc_dai *codec_dai,
  * when the DAI is being clocked by the CPU DAI. It's up to the
  * machine and cpu DAI driver to do this before we are called.
  */
-static int uda1380_pcm_prepare(struct snd_pcm_substream *substream)
+static int uda1380_pcm_prepare(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -439,7 +440,8 @@ static int uda1380_pcm_prepare(struct snd_pcm_substream *substream)
 }
 
 static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -477,7 +479,8 @@ static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream)
+static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -560,8 +563,6 @@ struct snd_soc_dai uda1380_dai[] = {
 		.hw_params = uda1380_pcm_hw_params,
 		.shutdown = uda1380_pcm_shutdown,
 		.prepare = uda1380_pcm_prepare,
-	},
-	.dai_ops = {
 		.digital_mute = uda1380_mute,
 		.set_fmt = uda1380_set_dai_fmt,
 	},
@@ -579,8 +580,6 @@ struct snd_soc_dai uda1380_dai[] = {
 		.hw_params = uda1380_pcm_hw_params,
 		.shutdown = uda1380_pcm_shutdown,
 		.prepare = uda1380_pcm_prepare,
-	},
-	.dai_ops = {
 		.digital_mute = uda1380_mute,
 		.set_fmt = uda1380_set_dai_fmt,
 	},
@@ -598,8 +597,6 @@ struct snd_soc_dai uda1380_dai[] = {
 		.hw_params = uda1380_pcm_hw_params,
 		.shutdown = uda1380_pcm_shutdown,
 		.prepare = uda1380_pcm_prepare,
-	},
-	.dai_ops = {
 		.set_fmt = uda1380_set_dai_fmt,
 	},
 },
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index d8ca2da..173b66c 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -463,7 +463,8 @@ static int wm8510_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 static int wm8510_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -585,8 +586,6 @@ struct snd_soc_dai wm8510_dai = {
 		.formats = WM8510_FORMATS,},
 	.ops = {
 		.hw_params = wm8510_pcm_hw_params,
-	},
-	.dai_ops = {
 		.digital_mute = wm8510_mute,
 		.set_fmt = wm8510_set_dai_fmt,
 		.set_clkdiv = wm8510_set_dai_clkdiv,
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index cbcd7c3..220d4b6 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -548,13 +548,13 @@ static int wm8580_set_dai_pll(struct snd_soc_dai *codec_dai,
  * Set PCM DAI bit size and sample rate.
  */
 static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai_link *dai = rtd->dai;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
-	u16 paifb = wm8580_read(codec, WM8580_PAIF3 + dai->codec_dai->id);
+	u16 paifb = wm8580_read(codec, WM8580_PAIF3 + dai->id);
 
 	paifb &= ~WM8580_AIF_LENGTH_MASK;
 	/* bit size */
@@ -574,7 +574,7 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	wm8580_write(codec, WM8580_PAIF3 + dai->codec_dai->id, paifb);
+	wm8580_write(codec, WM8580_PAIF3 + dai->id, paifb);
 	return 0;
 }
 
@@ -798,8 +798,6 @@ struct snd_soc_dai wm8580_dai[] = {
 		},
 		.ops = {
 			 .hw_params = wm8580_paif_hw_params,
-		 },
-		.dai_ops = {
 			 .set_fmt = wm8580_set_paif_dai_fmt,
 			 .set_clkdiv = wm8580_set_dai_clkdiv,
 			 .set_pll = wm8580_set_dai_pll,
@@ -818,8 +816,6 @@ struct snd_soc_dai wm8580_dai[] = {
 		},
 		.ops = {
 			 .hw_params = wm8580_paif_hw_params,
-		 },
-		.dai_ops = {
 			 .set_fmt = wm8580_set_paif_dai_fmt,
 			 .set_clkdiv = wm8580_set_dai_clkdiv,
 			 .set_pll = wm8580_set_dai_pll,
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 3e39dea..71949bd 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -147,7 +147,8 @@ static int wm8728_mute(struct snd_soc_dai *dai, int mute)
 }
 
 static int wm8728_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -269,8 +270,6 @@ struct snd_soc_dai wm8728_dai = {
 	},
 	.ops = {
 		 .hw_params = wm8728_hw_params,
-	},
-	.dai_ops = {
 		 .digital_mute = wm8728_mute,
 		 .set_fmt = wm8728_set_dai_fmt,
 	}
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 7f8a7e3..c0f2770 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -264,7 +264,8 @@ static inline int get_coeff(int mclk, int rate)
 }
 
 static int wm8731_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -293,7 +294,8 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int wm8731_pcm_prepare(struct snd_pcm_substream *substream)
+static int wm8731_pcm_prepare(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -305,7 +307,8 @@ static int wm8731_pcm_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void wm8731_shutdown(struct snd_pcm_substream *substream)
+static void wm8731_shutdown(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -461,8 +464,6 @@ struct snd_soc_dai wm8731_dai = {
 		.prepare = wm8731_pcm_prepare,
 		.hw_params = wm8731_hw_params,
 		.shutdown = wm8731_shutdown,
-	},
-	.dai_ops = {
 		.digital_mute = wm8731_mute,
 		.set_sysclk = wm8731_set_dai_sysclk,
 		.set_fmt = wm8731_set_dai_fmt,
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 9b7296e..860a1d5 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -614,7 +614,8 @@ static int wm8750_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 static int wm8750_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -709,8 +710,6 @@ struct snd_soc_dai wm8750_dai = {
 		.formats = WM8750_FORMATS,},
 	.ops = {
 		.hw_params = wm8750_pcm_hw_params,
-	},
-	.dai_ops = {
 		.digital_mute = wm8750_mute,
 		.set_fmt = wm8750_set_dai_fmt,
 		.set_sysclk = wm8750_set_dai_sysclk,
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index d426eaa..5e4cd3b 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -922,7 +922,8 @@ static int wm8753_vdac_adc_set_dai_fmt(struct snd_soc_dai *codec_dai,
  * Set PCM DAI bit size and sample rate.
  */
 static int wm8753_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -1155,7 +1156,8 @@ static int wm8753_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
  * Set PCM DAI bit size and sample rate.
  */
 static int wm8753_i2s_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -1323,16 +1325,15 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM8753_RATES,
-		.formats = WM8753_FORMATS,},
+		.formats = WM8753_FORMATS},
 	.capture = { /* dummy for fast DAI switching */
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM8753_RATES,
-		.formats = WM8753_FORMATS,},
+		.formats = WM8753_FORMATS},
 	.ops = {
-		.hw_params = wm8753_i2s_hw_params,},
-	.dai_ops = {
+		.hw_params = wm8753_i2s_hw_params,
 		.digital_mute = wm8753_mute,
 		.set_fmt = wm8753_mode1h_set_dai_fmt,
 		.set_clkdiv = wm8753_set_dai_clkdiv,
@@ -1356,8 +1357,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS,},
 	.ops = {
-		.hw_params = wm8753_pcm_hw_params,},
-	.dai_ops = {
+		.hw_params = wm8753_pcm_hw_params,
 		.digital_mute = wm8753_mute,
 		.set_fmt = wm8753_mode1v_set_dai_fmt,
 		.set_clkdiv = wm8753_set_dai_clkdiv,
@@ -1385,8 +1385,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS,},
 	.ops = {
-		.hw_params = wm8753_pcm_hw_params,},
-	.dai_ops = {
+		.hw_params = wm8753_pcm_hw_params,
 		.digital_mute = wm8753_mute,
 		.set_fmt = wm8753_mode2_set_dai_fmt,
 		.set_clkdiv = wm8753_set_dai_clkdiv,
@@ -1410,8 +1409,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS,},
 	.ops = {
-		.hw_params = wm8753_i2s_hw_params,},
-	.dai_ops = {
+		.hw_params = wm8753_i2s_hw_params,
 		.digital_mute = wm8753_mute,
 		.set_fmt = wm8753_mode3_4_set_dai_fmt,
 		.set_clkdiv = wm8753_set_dai_clkdiv,
@@ -1439,8 +1437,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS,},
 	.ops = {
-		.hw_params = wm8753_i2s_hw_params,},
-	.dai_ops = {
+		.hw_params = wm8753_i2s_hw_params,
 		.digital_mute = wm8753_mute,
 		.set_fmt = wm8753_mode3_4_set_dai_fmt,
 		.set_clkdiv = wm8753_set_dai_clkdiv,
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index de016f4..d1326be 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -727,7 +727,8 @@ static int wm8900_add_widgets(struct snd_soc_codec *codec)
 }
 
 static int wm8900_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -1117,8 +1118,6 @@ struct snd_soc_dai wm8900_dai = {
 	 },
 	.ops = {
 		.hw_params = wm8900_hw_params,
-	 },
-	.dai_ops = {
 		 .set_clkdiv = wm8900_set_dai_clkdiv,
 		 .set_pll = wm8900_set_dai_pll,
 		 .set_fmt = wm8900_set_dai_fmt,
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ce40d78..efbe892 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1257,7 +1257,8 @@ static struct {
 	{ 0,      0 },
 };
 
-static int wm8903_startup(struct snd_pcm_substream *substream)
+static int wm8903_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -1298,7 +1299,8 @@ static int wm8903_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void wm8903_shutdown(struct snd_pcm_substream *substream)
+static void wm8903_shutdown(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -1317,7 +1319,8 @@ static void wm8903_shutdown(struct snd_pcm_substream *substream)
 }
 
 static int wm8903_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params)
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -1515,8 +1518,6 @@ struct snd_soc_dai wm8903_dai = {
 		 .startup = wm8903_startup,
 		 .shutdown = wm8903_shutdown,
 		 .hw_params = wm8903_hw_params,
-	},
-	.dai_ops = {
 		 .digital_mute = wm8903_digital_mute,
 		 .set_fmt = wm8903_set_dai_fmt,
 		 .set_sysclk = wm8903_set_dai_sysclk
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index f41a578..26edcc9 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -541,7 +541,8 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -634,8 +635,6 @@ struct snd_soc_dai wm8971_dai = {
 		.formats = WM8971_FORMATS,},
 	.ops = {
 		.hw_params = wm8971_pcm_hw_params,
-	},
-	.dai_ops = {
 		.digital_mute = wm8971_mute,
 		.set_fmt = wm8971_set_dai_fmt,
 		.set_sysclk = wm8971_set_dai_sysclk,
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 2d7b009..1392651 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1172,7 +1172,8 @@ static int wm8990_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
  * Set PCM DAI bit size and sample rate.
  */
 static int wm8990_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -1362,8 +1363,7 @@ struct snd_soc_dai wm8990_dai = {
 		.rates = WM8990_RATES,
 		.formats = WM8990_FORMATS,},
 	.ops = {
-		.hw_params = wm8990_hw_params,},
-	.dai_ops = {
+		.hw_params = wm8990_hw_params,
 		.digital_mute = wm8990_mute,
 		.set_fmt = wm8990_set_dai_fmt,
 		.set_clkdiv = wm8990_set_dai_clkdiv,
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index ffb471e..81c38e7 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -487,7 +487,8 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	return 0;
 }
 
-static int ac97_prepare(struct snd_pcm_substream *substream)
+static int ac97_prepare(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -507,7 +508,8 @@ static int ac97_prepare(struct snd_pcm_substream *substream)
 	return ac97_write(codec, reg, runtime->rate);
 }
 
-static int ac97_aux_prepare(struct snd_pcm_substream *substream)
+static int ac97_aux_prepare(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 740bf3c..a0cc5ac 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -928,7 +928,8 @@ static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -954,7 +955,8 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void wm9713_voiceshutdown(struct snd_pcm_substream *substream)
+static void wm9713_voiceshutdown(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
@@ -969,7 +971,8 @@ static void wm9713_voiceshutdown(struct snd_pcm_substream *substream)
 	ac97_write(codec, AC97_EXTENDED_MID, status);
 }
 
-static int ac97_hifi_prepare(struct snd_pcm_substream *substream)
+static int ac97_hifi_prepare(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -989,7 +992,8 @@ static int ac97_hifi_prepare(struct snd_pcm_substream *substream)
 	return ac97_write(codec, reg, runtime->rate);
 }
 
-static int ac97_aux_prepare(struct snd_pcm_substream *substream)
+static int ac97_aux_prepare(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -1042,8 +1046,7 @@ struct snd_soc_dai wm9713_dai[] = {
 		.rates = WM9713_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
-		.prepare = ac97_hifi_prepare,},
-	.dai_ops = {
+		.prepare = ac97_hifi_prepare,
 		.set_clkdiv = wm9713_set_dai_clkdiv,
 		.set_pll = wm9713_set_dai_pll,},
 	},
@@ -1056,8 +1059,7 @@ struct snd_soc_dai wm9713_dai[] = {
 		.rates = WM9713_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
-		.prepare = ac97_aux_prepare,},
-	.dai_ops = {
+		.prepare = ac97_aux_prepare,
 		.set_clkdiv = wm9713_set_dai_clkdiv,
 		.set_pll = wm9713_set_dai_pll,},
 	},
@@ -1077,8 +1079,7 @@ struct snd_soc_dai wm9713_dai[] = {
 		.formats = WM9713_PCM_FORMATS,},
 	.ops = {
 		.hw_params = wm9713_pcm_hw_params,
-		.shutdown = wm9713_voiceshutdown,},
-	.dai_ops = {
+		.shutdown = wm9713_voiceshutdown,
 		.set_clkdiv = wm9713_set_dai_clkdiv,
 		.set_pll = wm9713_set_dai_pll,
 		.set_fmt = wm9713_set_dai_fmt,
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 95df51e..7a17cd0 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -188,7 +188,8 @@ static void davinci_mcbsp_stop(struct snd_pcm_substream *substream)
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
 }
 
-static int davinci_i2s_startup(struct snd_pcm_substream *substream)
+static int davinci_i2s_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -285,7 +286,8 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 }
 
 static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_pcm_dma_params *dma_params = rtd->dai->cpu_dai->dma_data;
@@ -349,7 +351,8 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
+static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
 {
 	int ret = 0;
 
@@ -473,8 +476,7 @@ struct snd_soc_dai davinci_i2s_dai = {
 	.ops = {
 		.startup = davinci_i2s_startup,
 		.trigger = davinci_i2s_trigger,
-		.hw_params = davinci_i2s_hw_params,},
-	.dai_ops = {
+		.hw_params = davinci_i2s_hw_params,
 		.set_fmt = davinci_i2s_set_dai_fmt,
 	},
 };
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index fa38f9c..e95fde1 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -34,7 +34,8 @@
 #include "davinci-i2s.h"
 
 static int sffsdr_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params)
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 157a789..52c290b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -266,7 +266,8 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
  * If this is the first stream open, then grab the IRQ and program most of
  * the SSI registers.
  */
-static int fsl_ssi_startup(struct snd_pcm_substream *substream)
+static int fsl_ssi_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
@@ -411,7 +412,8 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream)
  * Note: The SxCCR.DC and SxCCR.PM bits are only used if the SSI is the
  * clock master.
  */
-static int fsl_ssi_prepare(struct snd_pcm_substream *substream)
+static int fsl_ssi_prepare(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -441,7 +443,8 @@ static int fsl_ssi_prepare(struct snd_pcm_substream *substream)
  * The DMA channel is in external master start and pause mode, which
  * means the SSI completely controls the flow of data.
  */
-static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd)
+static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
@@ -490,7 +493,8 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd)
  *
  * Shutdown the SSI if there are no other substreams open.
  */
-static void fsl_ssi_shutdown(struct snd_pcm_substream *substream)
+static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
@@ -578,8 +582,6 @@ static struct snd_soc_dai fsl_ssi_dai_template = {
 		.prepare = fsl_ssi_prepare,
 		.shutdown = fsl_ssi_shutdown,
 		.trigger = fsl_ssi_trigger,
-	},
-	.dai_ops = {
 		.set_sysclk = fsl_ssi_set_sysclk,
 		.set_fmt = fsl_ssi_set_fmt,
 	},
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 94a02ea..e2c172f 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -187,7 +187,8 @@ static irqreturn_t psc_i2s_bcom_irq(int irq, void *_psc_i2s_stream)
  * If this is the first stream open, then grab the IRQ and program most of
  * the PSC registers.
  */
-static int psc_i2s_startup(struct snd_pcm_substream *substream)
+static int psc_i2s_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct psc_i2s *psc_i2s = rtd->dai->cpu_dai->private_data;
@@ -220,7 +221,8 @@ static int psc_i2s_startup(struct snd_pcm_substream *substream)
 }
 
 static int psc_i2s_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct psc_i2s *psc_i2s = rtd->dai->cpu_dai->private_data;
@@ -256,7 +258,8 @@ static int psc_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int psc_i2s_hw_free(struct snd_pcm_substream *substream)
+static int psc_i2s_hw_free(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
 {
 	snd_pcm_set_runtime_buffer(substream, NULL);
 	return 0;
@@ -268,7 +271,8 @@ static int psc_i2s_hw_free(struct snd_pcm_substream *substream)
  * This function is called by ALSA to start, stop, pause, and resume the DMA
  * transfer of data.
  */
-static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
+static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct psc_i2s *psc_i2s = rtd->dai->cpu_dai->private_data;
@@ -383,7 +387,8 @@ static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
  *
  * Shutdown the PSC if there are no other substreams open.
  */
-static void psc_i2s_shutdown(struct snd_pcm_substream *substream)
+static void psc_i2s_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct psc_i2s *psc_i2s = rtd->dai->cpu_dai->private_data;
@@ -483,8 +488,6 @@ static struct snd_soc_dai psc_i2s_dai_template = {
 		.hw_free = psc_i2s_hw_free,
 		.shutdown = psc_i2s_shutdown,
 		.trigger = psc_i2s_trigger,
-	},
-	.dai_ops = {
 		.set_sysclk = psc_i2s_set_sysclk,
 		.set_fmt = psc_i2s_set_fmt,
 	},
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3d4060b..6013898 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -138,7 +138,8 @@ static const unsigned long omap34xx_mcbsp_port[][2] = {
 static const unsigned long omap34xx_mcbsp_port[][2] = {};
 #endif
 
-static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream)
+static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -151,7 +152,8 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream)
 	return err;
 }
 
-static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream)
+static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -163,7 +165,8 @@ static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream)
 	}
 }
 
-static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd)
+static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -192,7 +195,8 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd)
 }
 
 static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
-				    struct snd_pcm_hw_params *params)
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -470,8 +474,6 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		.shutdown = omap_mcbsp_dai_shutdown,		\
 		.trigger = omap_mcbsp_dai_trigger,		\
 		.hw_params = omap_mcbsp_dai_hw_params,		\
-	},							\
-	.dai_ops = {						\
 		.set_fmt = omap_mcbsp_dai_set_dai_fmt,		\
 		.set_clkdiv = omap_mcbsp_dai_set_clkdiv,	\
 		.set_sysclk = omap_mcbsp_dai_set_dai_sysclk,	\
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
index 5bea311..7b160f9 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -38,7 +38,8 @@
 #include "../codecs/twl4030.h"
 
 static int omap2evm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index e2b54b8..d0dd624 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -212,7 +212,8 @@ static struct pxa2xx_pcm_dma_params *ssp_dma_params[4][4] = {
 	},
 };
 
-static int pxa_ssp_startup(struct snd_pcm_substream *substream)
+static int pxa_ssp_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -228,7 +229,8 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-static void pxa_ssp_shutdown(struct snd_pcm_substream *substream)
+static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -604,7 +606,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
  * Can be called multiple times by oss emulation.
  */
 static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -678,7 +681,8 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd)
+static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -806,8 +810,6 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 			.shutdown = pxa_ssp_shutdown,
 			.trigger = pxa_ssp_trigger,
 			.hw_params = pxa_ssp_hw_params,
-		 },
-		.dai_ops = {
 			.set_sysclk = pxa_ssp_set_dai_sysclk,
 			.set_clkdiv = pxa_ssp_set_dai_clkdiv,
 			.set_pll = pxa_ssp_set_dai_pll,
@@ -840,8 +842,6 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 			.shutdown = pxa_ssp_shutdown,
 			.trigger = pxa_ssp_trigger,
 			.hw_params = pxa_ssp_hw_params,
-		 },
-		.dai_ops = {
 			.set_sysclk = pxa_ssp_set_dai_sysclk,
 			.set_clkdiv = pxa_ssp_set_dai_clkdiv,
 			.set_pll = pxa_ssp_set_dai_pll,
@@ -875,8 +875,6 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 			.shutdown = pxa_ssp_shutdown,
 			.trigger = pxa_ssp_trigger,
 			.hw_params = pxa_ssp_hw_params,
-		 },
-		.dai_ops = {
 			.set_sysclk = pxa_ssp_set_dai_sysclk,
 			.set_clkdiv = pxa_ssp_set_dai_clkdiv,
 			.set_pll = pxa_ssp_set_dai_pll,
@@ -910,8 +908,6 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 			.shutdown = pxa_ssp_shutdown,
 			.trigger = pxa_ssp_trigger,
 			.hw_params = pxa_ssp_hw_params,
-		 },
-		.dai_ops = {
 			.set_sysclk = pxa_ssp_set_dai_sysclk,
 			.set_clkdiv = pxa_ssp_set_dai_clkdiv,
 			.set_pll = pxa_ssp_set_dai_pll,
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index a7a3a9c..86667d2 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -117,7 +117,8 @@ static void pxa2xx_ac97_remove(struct platform_device *pdev,
 }
 
 static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -131,7 +132,8 @@ static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
 }
 
 static int pxa2xx_ac97_hw_aux_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -145,7 +147,8 @@ static int pxa2xx_ac97_hw_aux_params(struct snd_pcm_substream *substream,
 }
 
 static int pxa2xx_ac97_hw_mic_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index e758034..9a3e55b 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -121,7 +121,8 @@ static struct pxa2xx_gpio gpio_bus[] = {
 	},
 };
 
-static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream)
+static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -187,7 +188,8 @@ static int pxa2xx_i2s_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 }
 
 static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -248,7 +250,8 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int pxa2xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
+static int pxa2xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			      struct snd_soc_dai *dai)
 {
 	int ret = 0;
 
@@ -269,7 +272,8 @@ static int pxa2xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
 	return ret;
 }
 
-static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream)
+static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
 {
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		SACR1 |= SACR1_DRPL;
@@ -353,8 +357,7 @@ struct snd_soc_dai pxa_i2s_dai = {
 		.startup = pxa2xx_i2s_startup,
 		.shutdown = pxa2xx_i2s_shutdown,
 		.trigger = pxa2xx_i2s_trigger,
-		.hw_params = pxa2xx_i2s_hw_params,},
-	.dai_ops = {
+		.hw_params = pxa2xx_i2s_hw_params,
 		.set_fmt = pxa2xx_i2s_set_dai_fmt,
 		.set_sysclk = pxa2xx_i2s_set_dai_sysclk,
 	},
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index ded7d99..360cc2a 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -343,7 +343,8 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 }
 
 static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	u32 iismod;
@@ -373,7 +374,8 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
+static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
 {
 	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 	unsigned long irqs;
@@ -730,8 +732,6 @@ struct snd_soc_dai s3c2412_i2s_dai = {
 	.ops = {
 		.trigger	= s3c2412_i2s_trigger,
 		.hw_params	= s3c2412_i2s_hw_params,
-	},
-	.dai_ops = {
 		.set_fmt	= s3c2412_i2s_set_fmt,
 		.set_clkdiv	= s3c2412_i2s_set_clkdiv,
 		.set_sysclk	= s3c2412_i2s_set_sysclk,
diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
index 19c5c3c..3137782 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -271,7 +271,8 @@ static void s3c2443_ac97_remove(struct platform_device *pdev,
 }
 
 static int s3c2443_ac97_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -313,7 +314,8 @@ static int s3c2443_ac97_trigger(struct snd_pcm_substream *substream, int cmd)
 }
 
 static int s3c2443_ac97_hw_mic_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -327,7 +329,7 @@ static int s3c2443_ac97_hw_mic_params(struct snd_pcm_substream *substream,
 }
 
 static int s3c2443_ac97_mic_trigger(struct snd_pcm_substream *substream,
-	int cmd)
+				    int cmd, struct snd_soc_dai *dai)
 {
 	u32 ac_glbctrl;
 
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index c18977b..1bac9dd 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -243,7 +243,8 @@ static int s3c24xx_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 }
 
 static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	u32 iismod;
@@ -279,7 +280,8 @@ static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
+static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
 {
 	int ret = 0;
 
@@ -475,8 +477,7 @@ struct snd_soc_dai s3c24xx_i2s_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.trigger = s3c24xx_i2s_trigger,
-		.hw_params = s3c24xx_i2s_hw_params,},
-	.dai_ops = {
+		.hw_params = s3c24xx_i2s_hw_params,
 		.set_fmt = s3c24xx_i2s_set_fmt,
 		.set_clkdiv = s3c24xx_i2s_set_clkdiv,
 		.set_sysclk = s3c24xx_i2s_set_sysclk,
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index df7bc34..3318071 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -236,7 +236,8 @@ struct snd_ac97_bus_ops soc_ac97_ops = {
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int hac_hw_params(struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *params)
+			 struct snd_pcm_hw_params *params,
+			 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct hac_priv *hac = &hac_cpu_data[rtd->dai->cpu_dai->id];
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 55c3464..52a2338 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -89,7 +89,8 @@ struct ssi_priv {
  * track usage of the SSI; it is simplex-only so prevent attempts of
  * concurrent playback + capture. FIXME: any locking required?
  */
-static int ssi_startup(struct snd_pcm_substream *substream)
+static int ssi_startup(struct snd_pcm_substream *substream,
+		       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct ssi_priv *ssi = &ssi_cpu_data[rtd->dai->cpu_dai->id];
@@ -101,7 +102,8 @@ static int ssi_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void ssi_shutdown(struct snd_pcm_substream *substream)
+static void ssi_shutdown(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct ssi_priv *ssi = &ssi_cpu_data[rtd->dai->cpu_dai->id];
@@ -109,7 +111,8 @@ static void ssi_shutdown(struct snd_pcm_substream *substream)
 	ssi->inuse = 0;
 }
 
-static int ssi_trigger(struct snd_pcm_substream *substream, int cmd)
+static int ssi_trigger(struct snd_pcm_substream *substream, int cmd,
+		       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct ssi_priv *ssi = &ssi_cpu_data[rtd->dai->cpu_dai->id];
@@ -129,7 +132,8 @@ static int ssi_trigger(struct snd_pcm_substream *substream, int cmd)
 }
 
 static int ssi_hw_params(struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *params)
+			 struct snd_pcm_hw_params *params,
+			 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct ssi_priv *ssi = &ssi_cpu_data[rtd->dai->cpu_dai->id];
@@ -354,8 +358,6 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 		.shutdown	= ssi_shutdown,
 		.trigger	= ssi_trigger,
 		.hw_params	= ssi_hw_params,
-	},
-	.dai_ops = {
 		.set_sysclk	= ssi_set_sysclk,
 		.set_clkdiv	= ssi_set_clkdiv,
 		.set_fmt	= ssi_set_fmt,
@@ -383,8 +385,6 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 		.shutdown	= ssi_shutdown,
 		.trigger	= ssi_trigger,
 		.hw_params	= ssi_hw_params,
-	},
-	.dai_ops = {
 		.set_sysclk	= ssi_set_sysclk,
 		.set_clkdiv	= ssi_set_clkdiv,
 		.set_fmt	= ssi_set_fmt,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c5cb951..43f4060 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -134,7 +134,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 
 	/* startup the audio subsystem */
 	if (cpu_dai->ops.startup) {
-		ret = cpu_dai->ops.startup(substream);
+		ret = cpu_dai->ops.startup(substream, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open interface %s\n",
 				cpu_dai->name);
@@ -151,7 +151,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	}
 
 	if (codec_dai->ops.startup) {
-		ret = codec_dai->ops.startup(substream);
+		ret = codec_dai->ops.startup(substream, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open codec %s\n",
 				codec_dai->name);
@@ -248,7 +248,7 @@ codec_dai_err:
 
 platform_err:
 	if (cpu_dai->ops.shutdown)
-		cpu_dai->ops.shutdown(substream);
+		cpu_dai->ops.shutdown(substream, cpu_dai);
 out:
 	mutex_unlock(&pcm_mutex);
 	return ret;
@@ -339,10 +339,10 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 		snd_soc_dai_digital_mute(codec_dai, 1);
 
 	if (cpu_dai->ops.shutdown)
-		cpu_dai->ops.shutdown(substream);
+		cpu_dai->ops.shutdown(substream, cpu_dai);
 
 	if (codec_dai->ops.shutdown)
-		codec_dai->ops.shutdown(substream);
+		codec_dai->ops.shutdown(substream, codec_dai);
 
 	if (machine->ops && machine->ops->shutdown)
 		machine->ops->shutdown(substream);
@@ -406,7 +406,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	if (codec_dai->ops.prepare) {
-		ret = codec_dai->ops.prepare(substream);
+		ret = codec_dai->ops.prepare(substream, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: codec DAI prepare error\n");
 			goto out;
@@ -414,7 +414,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	if (cpu_dai->ops.prepare) {
-		ret = cpu_dai->ops.prepare(substream);
+		ret = cpu_dai->ops.prepare(substream, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: cpu DAI prepare error\n");
 			goto out;
@@ -491,7 +491,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (codec_dai->ops.hw_params) {
-		ret = codec_dai->ops.hw_params(substream, params);
+		ret = codec_dai->ops.hw_params(substream, params, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't set codec %s hw params\n",
 				codec_dai->name);
@@ -500,7 +500,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (cpu_dai->ops.hw_params) {
-		ret = cpu_dai->ops.hw_params(substream, params);
+		ret = cpu_dai->ops.hw_params(substream, params, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: interface %s hw params failed\n",
 				cpu_dai->name);
@@ -523,11 +523,11 @@ out:
 
 platform_err:
 	if (cpu_dai->ops.hw_free)
-		cpu_dai->ops.hw_free(substream);
+		cpu_dai->ops.hw_free(substream, cpu_dai);
 
 interface_err:
 	if (codec_dai->ops.hw_free)
-		codec_dai->ops.hw_free(substream);
+		codec_dai->ops.hw_free(substream, codec_dai);
 
 codec_err:
 	if (machine->ops && machine->ops->hw_free)
@@ -566,10 +566,10 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	/* now free hw params for the DAI's  */
 	if (codec_dai->ops.hw_free)
-		codec_dai->ops.hw_free(substream);
+		codec_dai->ops.hw_free(substream, codec_dai);
 
 	if (cpu_dai->ops.hw_free)
-		cpu_dai->ops.hw_free(substream);
+		cpu_dai->ops.hw_free(substream, cpu_dai);
 
 	mutex_unlock(&pcm_mutex);
 	return 0;
@@ -586,7 +586,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	int ret;
 
 	if (codec_dai->ops.trigger) {
-		ret = codec_dai->ops.trigger(substream, cmd);
+		ret = codec_dai->ops.trigger(substream, cmd, codec_dai);
 		if (ret < 0)
 			return ret;
 	}
@@ -598,7 +598,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 
 	if (cpu_dai->ops.trigger) {
-		ret = cpu_dai->ops.trigger(substream, cmd);
+		ret = cpu_dai->ops.trigger(substream, cmd, cpu_dai);
 		if (ret < 0)
 			return ret;
 	}
@@ -637,10 +637,10 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D3hot);
 
 	/* mute any active DAC's */
-	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_dai *dai = machine->dai_link[i].codec_dai;
-		if (dai->dai_ops.digital_mute && dai->playback.active)
-			dai->dai_ops.digital_mute(dai, 1);
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai *dai = card->dai_link[i].codec_dai;
+		if (dai->ops.digital_mute && dai->playback.active)
+			dai->ops.digital_mute(dai, 1);
 	}
 
 	/* suspend all pcms */
@@ -733,10 +733,10 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	/* unmute any active DACs */
-	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_dai *dai = machine->dai_link[i].codec_dai;
-		if (dai->dai_ops.digital_mute && dai->playback.active)
-			dai->dai_ops.digital_mute(dai, 0);
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai *dai = card->dai_link[i].codec_dai;
+		if (dai->ops.digital_mute && dai->playback.active)
+			dai->ops.digital_mute(dai, 0);
 	}
 
 	for (i = 0; i < card->num_links; i++) {
@@ -1849,8 +1849,8 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned int freq, int dir)
 {
-	if (dai->dai_ops.set_sysclk)
-		return dai->dai_ops.set_sysclk(dai, clk_id, freq, dir);
+	if (dai->ops.set_sysclk)
+		return dai->ops.set_sysclk(dai, clk_id, freq, dir);
 	else
 		return -EINVAL;
 }
@@ -1869,8 +1869,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
 int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
 	int div_id, int div)
 {
-	if (dai->dai_ops.set_clkdiv)
-		return dai->dai_ops.set_clkdiv(dai, div_id, div);
+	if (dai->ops.set_clkdiv)
+		return dai->ops.set_clkdiv(dai, div_id, div);
 	else
 		return -EINVAL;
 }
@@ -1888,8 +1888,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_clkdiv);
 int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
 	int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
-	if (dai->dai_ops.set_pll)
-		return dai->dai_ops.set_pll(dai, pll_id, freq_in, freq_out);
+	if (dai->ops.set_pll)
+		return dai->ops.set_pll(dai, pll_id, freq_in, freq_out);
 	else
 		return -EINVAL;
 }
@@ -1905,8 +1905,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
  */
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	if (dai->dai_ops.set_fmt)
-		return dai->dai_ops.set_fmt(dai, fmt);
+	if (dai->ops.set_fmt)
+		return dai->ops.set_fmt(dai, fmt);
 	else
 		return -EINVAL;
 }
@@ -1924,8 +1924,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int mask, int slots)
 {
-	if (dai->dai_ops.set_sysclk)
-		return dai->dai_ops.set_tdm_slot(dai, mask, slots);
+	if (dai->ops.set_sysclk)
+		return dai->ops.set_tdm_slot(dai, mask, slots);
 	else
 		return -EINVAL;
 }
@@ -1940,8 +1940,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
  */
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
-	if (dai->dai_ops.set_sysclk)
-		return dai->dai_ops.set_tristate(dai, tristate);
+	if (dai->ops.set_sysclk)
+		return dai->ops.set_tristate(dai, tristate);
 	else
 		return -EINVAL;
 }
@@ -1956,8 +1956,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tristate);
  */
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	if (dai->dai_ops.digital_mute)
-		return dai->dai_ops.digital_mute(dai, mute);
+	if (dai->ops.digital_mute)
+		return dai->ops.digital_mute(dai, mute);
 	else
 		return -EINVAL;
 }
-- 
1.5.6.5
