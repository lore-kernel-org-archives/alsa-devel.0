From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] ASoC: make ops a pointer in 'struct
	snd_soc_dai'
Date: Mon, 2 Mar 2009 11:25:46 +0800
Message-ID: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by alsa0.perex.cz (Postfix) with ESMTP id ED5201037EC
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 04:25:48 +0100 (CET)
Received: by rv-out-0506.google.com with SMTP id f9so4899202rvb.0
	for <alsa-devel@alsa-project.org>; Sun, 01 Mar 2009 19:25:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Considering the fact that most cpu_dai or codec_dai are using a same
'snd_soc_dai_ops' for several similar interfaces, 'ops' would be better
made a pointer instead, to make sharing easier and code a bit cleaner.

The patch below is rather preliminary since the asoc tree is being
actively developed, and this touches almost every piece of code,
(and possibly many others in development need to be changed as
well). Building of all codecs are OK, yet to every SoC, I didn't test
that.

Signed-off-by: Eric Miao <eric.miao@marvell.com>

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 24247f7..1367647 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -203,7 +203,7 @@ struct snd_soc_dai {
 	int (*resume)(struct snd_soc_dai *dai);

 	/* ops */
-	struct snd_soc_dai_ops ops;
+	struct snd_soc_dai_ops *ops;

 	/* DAI capabilities */
 	struct snd_soc_pcm_stream capture;
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index ff0054b..e588e63 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -697,6 +697,15 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
 			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)

+static struct snd_soc_dai_ops atmel_ssc_dai_ops = {
+	.startup	= atmel_ssc_startup,
+	.shutdown	= atmel_ssc_shutdown,
+	.prepare	= atmel_ssc_prepare,
+	.hw_params	= atmel_ssc_hw_params,
+	.set_fmt	= atmel_ssc_set_dai_fmt,
+	.set_clkdiv	= atmel_ssc_set_dai_clkdiv,
+};
+
 struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 	{	.name = "atmel-ssc0",
 		.id = 0,
@@ -712,13 +721,7 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 			.channels_max = 2,
 			.rates = ATMEL_SSC_RATES,
 			.formats = ATMEL_SSC_FORMATS,},
-		.ops = {
-			.startup = atmel_ssc_startup,
-			.shutdown = atmel_ssc_shutdown,
-			.prepare = atmel_ssc_prepare,
-			.hw_params = atmel_ssc_hw_params,
-			.set_fmt = atmel_ssc_set_dai_fmt,
-			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.ops = &atmel_ssc_dai_ops,
 		.private_data = &ssc_info[0],
 	},
 #if NUM_SSC_DEVICES == 3
@@ -736,13 +739,7 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 			.channels_max = 2,
 			.rates = ATMEL_SSC_RATES,
 			.formats = ATMEL_SSC_FORMATS,},
-		.ops = {
-			.startup = atmel_ssc_startup,
-			.shutdown = atmel_ssc_shutdown,
-			.prepare = atmel_ssc_prepare,
-			.hw_params = atmel_ssc_hw_params,
-			.set_fmt = atmel_ssc_set_dai_fmt,
-			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.ops = &atmel_ssc_dai_ops,
 		.private_data = &ssc_info[1],
 	},
 	{	.name = "atmel-ssc2",
@@ -759,13 +756,7 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 			.channels_max = 2,
 			.rates = ATMEL_SSC_RATES,
 			.formats = ATMEL_SSC_FORMATS,},
-		.ops = {
-			.startup = atmel_ssc_startup,
-			.shutdown = atmel_ssc_shutdown,
-			.prepare = atmel_ssc_prepare,
-			.hw_params = atmel_ssc_hw_params,
-			.set_fmt = atmel_ssc_set_dai_fmt,
-			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.ops = &atmel_ssc_dai_ops,
 		.private_data = &ssc_info[2],
 	},
 #endif
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index f0e30ae..479d7bd 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -342,6 +342,11 @@ static int au1xpsc_ac97_resume(struct snd_soc_dai *dai)
 	return 0;
 }

+static struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
+	.trigger	= au1xpsc_ac97_trigger,
+	.hw_params	= au1xpsc_ac97_hw_params,
+};
+
 struct snd_soc_dai au1xpsc_ac97_dai = {
 	.name			= "au1xpsc_ac97",
 	.ac97_control		= 1,
@@ -361,10 +366,7 @@ struct snd_soc_dai au1xpsc_ac97_dai = {
 		.channels_min	= 2,
 		.channels_max	= 2,
 	},
-	.ops = {
-		.trigger	= au1xpsc_ac97_trigger,
-		.hw_params	= au1xpsc_ac97_hw_params,
-	},
+	.ops = &au1xpsc_ac97_dai_ops,
 };
 EXPORT_SYMBOL_GPL(au1xpsc_ac97_dai);

diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index f916de4..bb58932 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -367,6 +367,12 @@ static int au1xpsc_i2s_resume(struct snd_soc_dai *cpu_dai)
 	return 0;
 }

+static struct snd_soc_dai_ops au1xpsc_i2s_dai_ops = {
+	.trigger	= au1xpsc_i2s_trigger,
+	.hw_params	= au1xpsc_i2s_hw_params,
+	.set_fmt	= au1xpsc_i2s_set_fmt,
+};
+
 struct snd_soc_dai au1xpsc_i2s_dai = {
 	.name			= "au1xpsc_i2s",
 	.probe			= au1xpsc_i2s_probe,
@@ -385,11 +391,7 @@ struct snd_soc_dai au1xpsc_i2s_dai = {
 		.channels_min	= 2,
 		.channels_max	= 8,	/* 2 without external help */
 	},
-	.ops = {
-		.trigger	= au1xpsc_i2s_trigger,
-		.hw_params	= au1xpsc_i2s_hw_params,
-		.set_fmt	= au1xpsc_i2s_set_fmt,
-	},
+	.ops = &au1xpsc_i2s_dai_ops,
 };
 EXPORT_SYMBOL(au1xpsc_i2s_dai);

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index d1d95d2..9648244 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -287,6 +287,13 @@ static int bf5xx_i2s_resume(struct platform_device *pdev,
 #define BF5XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |\
 	SNDRV_PCM_FMTBIT_S32_LE)

+static struct snd_soc_dai_ops bf5xx_i2s_dai_ops = {
+	.startup	= bf5xx_i2s_startup,
+	.shutdown	= bf5xx_i2s_shutdown,
+	.hw_params	= bf5xx_i2s_hw_params,
+	.set_fmt	= bf5xx_i2s_set_dai_fmt,
+};
+
 struct snd_soc_dai bf5xx_i2s_dai = {
 	.name = "bf5xx-i2s",
 	.id = 0,
@@ -304,12 +311,7 @@ struct snd_soc_dai bf5xx_i2s_dai = {
 		.channels_max = 2,
 		.rates = BF5XX_I2S_RATES,
 		.formats = BF5XX_I2S_FORMATS,},
-	.ops = {
-		.startup   = bf5xx_i2s_startup,
-		.shutdown  = bf5xx_i2s_shutdown,
-		.hw_params = bf5xx_i2s_hw_params,
-		.set_fmt = bf5xx_i2s_set_dai_fmt,
-	},
+	.ops = &bf5xx_i2s_dai_ops,
 };
 EXPORT_SYMBOL_GPL(bf5xx_i2s_dai);

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index fb53e65..7c0f412 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -41,6 +41,10 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
 		SNDRV_PCM_RATE_48000)

+static struct snd_soc_dai_ops ac97_dai_ops = {
+	.prepare	= ac97_prepare,
+};
+
 struct snd_soc_dai ac97_dai = {
 	.name = "AC97 HiFi",
 	.ac97_control = 1,
@@ -56,8 +60,7 @@ struct snd_soc_dai ac97_dai = {
 		.channels_max = 2,
 		.rates = STD_AC97_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.prepare = ac97_prepare,},
+	.ops = &ac97_dai_ops,
 };
 EXPORT_SYMBOL_GPL(ac97_dai);

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 81300d8..e81526a 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -436,6 +436,13 @@ static int ak4535_set_bias_level(struct
snd_soc_codec *codec,
 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
 		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)

+static struct snd_soc_dai_ops ak4535_dai_ops = {
+	.hw_params	= ak4535_hw_params,
+	.set_fmt	= ak4535_set_dai_fmt,
+	.digital_mute	= ak4535_mute,
+	.set_sysclk	= ak4535_set_dai_sysclk,
+};
+
 struct snd_soc_dai ak4535_dai = {
 	.name = "AK4535",
 	.playback = {
@@ -450,12 +457,7 @@ struct snd_soc_dai ak4535_dai = {
 		.channels_max = 2,
 		.rates = AK4535_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.hw_params = ak4535_hw_params,
-		.set_fmt = ak4535_set_dai_fmt,
-		.digital_mute = ak4535_mute,
-		.set_sysclk = ak4535_set_dai_sysclk,
-	},
+	.ops = &ak4535_dai_ops,
 };
 EXPORT_SYMBOL_GPL(ak4535_dai);

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index f1aa0c3..c6e155c 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -635,6 +635,17 @@ error:

 #endif /* USE_I2C*/

+#ifdef USE_I2C
+static struct snd_soc_dai_ops cs4270_dai_ops = {
+	.hw_params	= cs4270_hw_params,
+	.set_sysclk	= cs4270_set_dai_sysclk,
+	.set_fmt	= cs4270_set_dai_fmt,
+#ifdef CONFIG_SND_SOC_CS4270_HWMUTE
+	.digital_mute	= cs4270_mute,
+#endif
+};
+#endif
+
 struct snd_soc_dai cs4270_dai = {
 	.name = "CS4270",
 	.playback = {
@@ -708,15 +719,10 @@ static int cs4270_probe(struct platform_device *pdev)
 	}

 	/* Did we find a CS4270 on the I2C bus? */
-	if (codec->control_data) {
+	if (codec->control_data)
 		/* Initialize codec ops */
-		cs4270_dai.ops.hw_params = cs4270_hw_params;
-		cs4270_dai.ops.set_sysclk = cs4270_set_dai_sysclk;
-		cs4270_dai.ops.set_fmt = cs4270_set_dai_fmt;
-#ifdef CONFIG_SND_SOC_CS4270_HWMUTE
-		cs4270_dai.ops.digital_mute = cs4270_mute;
-#endif
-	} else
+		cs4270_dai.ops = &cs4270_dai_ops;
+	else
 		printk(KERN_INFO "cs4270: no I2C device found, "
 			"using stand-alone mode\n");
 #else
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index cac3736..a577ea1 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -521,6 +521,16 @@ static int ssm2602_set_bias_level(struct
snd_soc_codec *codec,
 #define SSM2602_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)

+static struct snd_soc_dai_ops ssm2602_dai_ops = {
+	.startup	= ssm2602_startup,
+	.prepare	= ssm2602_pcm_prepare,
+	.hw_params	= ssm2602_hw_params,
+	.shutdown	= ssm2602_shutdown,
+	.digital_mute	= ssm2602_mute,
+	.set_sysclk	= ssm2602_set_dai_sysclk,
+	.set_fmt	= ssm2602_set_dai_fmt,
+};
+
 struct snd_soc_dai ssm2602_dai = {
 	.name = "SSM2602",
 	.playback = {
@@ -535,15 +545,7 @@ struct snd_soc_dai ssm2602_dai = {
 		.channels_max = 2,
 		.rates = SSM2602_RATES,
 		.formats = SSM2602_FORMATS,},
-	.ops = {
-		.startup = ssm2602_startup,
-		.prepare = ssm2602_pcm_prepare,
-		.hw_params = ssm2602_hw_params,
-		.shutdown = ssm2602_shutdown,
-		.digital_mute = ssm2602_mute,
-		.set_sysclk = ssm2602_set_dai_sysclk,
-		.set_fmt = ssm2602_set_dai_fmt,
-	}
+	.ops = &ssm2602_dai_ops,
 };
 EXPORT_SYMBOL_GPL(ssm2602_dai);

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index cfdea00..daa5b88 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -598,6 +598,15 @@ static int tlv320aic23_set_bias_level(struct
snd_soc_codec *codec,
 #define AIC23_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)

+static struct snd_soc_dai_ops tlv320aic23_dai_ops = {
+	.prepare	= tlv320aic23_pcm_prepare,
+	.hw_params	= tlv320aic23_hw_params,
+	.shutdown	= tlv320aic23_shutdown,
+	.digital_mute	= tlv320aic23_mute,
+	.set_fmt	= tlv320aic23_set_dai_fmt,
+	.set_sysclk	= tlv320aic23_set_dai_sysclk,
+};
+
 struct snd_soc_dai tlv320aic23_dai = {
 	.name = "tlv320aic23",
 	.playback = {
@@ -612,14 +621,7 @@ struct snd_soc_dai tlv320aic23_dai = {
 		    .channels_max = 2,
 		    .rates = AIC23_RATES,
 		    .formats = AIC23_FORMATS,},
-	.ops = {
-		.prepare = tlv320aic23_pcm_prepare,
-		.hw_params = tlv320aic23_hw_params,
-		.shutdown = tlv320aic23_shutdown,
-		.digital_mute = tlv320aic23_mute,
-		.set_fmt = tlv320aic23_set_dai_fmt,
-		.set_sysclk = tlv320aic23_set_dai_sysclk,
-	}
+	.ops = &tlv320aic23_dai_ops,
 };
 EXPORT_SYMBOL_GPL(tlv320aic23_dai);

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 29f2f1a..8c6b15b 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -270,6 +270,13 @@ static int aic26_set_fmt(struct snd_soc_dai
*codec_dai, unsigned int fmt)
 #define AIC26_FORMATS	(SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_BE |\
 			 SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE)

+static struct snd_soc_dai_ops aic26_dai_ops = {
+	.hw_params	= aic26_hw_params,
+	.digital_mute	= aic26_mute,
+	.set_sysclk	= aic26_set_sysclk,
+	.set_fmt	= aic26_set_fmt,
+};
+
 struct snd_soc_dai aic26_dai = {
 	.name = "tlv320aic26",
 	.playback = {
@@ -286,12 +293,7 @@ struct snd_soc_dai aic26_dai = {
 		.rates = AIC26_RATES,
 		.formats = AIC26_FORMATS,
 	},
-	.ops = {
-		.hw_params = aic26_hw_params,
-		.digital_mute = aic26_mute,
-		.set_sysclk = aic26_set_sysclk,
-		.set_fmt = aic26_set_fmt,
-	},
+	.ops = &aic26_dai_ops,
 };
 EXPORT_SYMBOL_GPL(aic26_dai);

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b47a749..e24170a 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1069,6 +1069,13 @@ EXPORT_SYMBOL_GPL(aic3x_button_pressed);
 #define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)

+static struct snd_soc_dai_ops aic3x_dai_ops = {
+	.hw_params	= aic3x_hw_params,
+	.digital_mute	= aic3x_mute,
+	.set_sysclk	= aic3x_set_dai_sysclk,
+	.set_fmt	= aic3x_set_dai_fmt,
+};
+
 struct snd_soc_dai aic3x_dai = {
 	.name = "tlv320aic3x",
 	.playback = {
@@ -1083,12 +1090,7 @@ struct snd_soc_dai aic3x_dai = {
 		.channels_max = 2,
 		.rates = AIC3X_RATES,
 		.formats = AIC3X_FORMATS,},
-	.ops = {
-		.hw_params = aic3x_hw_params,
-		.digital_mute = aic3x_mute,
-		.set_sysclk = aic3x_set_dai_sysclk,
-		.set_fmt = aic3x_set_dai_fmt,
-	}
+	.ops = &aic3x_dai_ops,
 };
 EXPORT_SYMBOL_GPL(aic3x_dai);

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index a2c5064..e75a2f9 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -464,6 +464,15 @@ static int uda134x_add_controls(struct
snd_soc_codec *codec)
 	return 0;
 }

+static struct snd_soc_dai_ops uda134x_dai_ops = {
+	.startup	= uda134x_startup,
+	.shutdown	= uda134x_shutdown,
+	.hw_params	= uda134x_hw_params,
+	.digital_mute	= uda134x_mute,
+	.set_sysclk	= uda134x_set_dai_sysclk,
+	.set_fmt	= uda134x_set_dai_fmt,
+};
+
 struct snd_soc_dai uda134x_dai = {
 	.name = "UDA134X",
 	/* playback capabilities */
@@ -483,14 +492,7 @@ struct snd_soc_dai uda134x_dai = {
 		.formats = UDA134X_FORMATS,
 	},
 	/* pcm operations */
-	.ops = {
-		.startup = uda134x_startup,
-		.shutdown = uda134x_shutdown,
-		.hw_params = uda134x_hw_params,
-		.digital_mute = uda134x_mute,
-		.set_sysclk = uda134x_set_dai_sysclk,
-		.set_fmt = uda134x_set_dai_fmt,
-	}
+	.ops = &uda134x_dai_ops,
 };
 EXPORT_SYMBOL(uda134x_dai);

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index e6bf084..bdd830f 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -544,6 +544,21 @@ static int uda1380_set_bias_level(struct
snd_soc_codec *codec,
 		       SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
 		       SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)

+static struct snd_soc_dai_ops uda1380_dai_ops = {
+	.hw_params	= uda1380_pcm_hw_params,
+	.shutdown	= uda1380_pcm_shutdown,
+	.prepare	= uda1380_pcm_prepare,
+	.digital_mute	= uda1380_mute,
+	.set_fmt	= uda1380_set_dai_fmt,
+};
+
+static struct snd_soc_dai_ops uda1380_dai_ops_capture = {
+	.hw_params	= uda1380_pcm_hw_params,
+	.shutdown	= uda1380_pcm_shutdown,
+	.prepare	= uda1380_pcm_prepare,
+	.set_fmt	= uda1380_set_dai_fmt,
+};
+
 struct snd_soc_dai uda1380_dai[] = {
 {
 	.name = "UDA1380",
@@ -559,13 +574,7 @@ struct snd_soc_dai uda1380_dai[] = {
 		.channels_max = 2,
 		.rates = UDA1380_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.hw_params = uda1380_pcm_hw_params,
-		.shutdown = uda1380_pcm_shutdown,
-		.prepare = uda1380_pcm_prepare,
-		.digital_mute = uda1380_mute,
-		.set_fmt = uda1380_set_dai_fmt,
-	},
+	.ops = &uda1380_dai_ops,
 },
 { /* playback only - dual interface */
 	.name = "UDA1380",
@@ -576,13 +585,7 @@ struct snd_soc_dai uda1380_dai[] = {
 		.rates = UDA1380_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = {
-		.hw_params = uda1380_pcm_hw_params,
-		.shutdown = uda1380_pcm_shutdown,
-		.prepare = uda1380_pcm_prepare,
-		.digital_mute = uda1380_mute,
-		.set_fmt = uda1380_set_dai_fmt,
-	},
+	.ops = &uda1380_dai_ops,
 },
 { /* capture only - dual interface*/
 	.name = "UDA1380",
@@ -593,12 +596,7 @@ struct snd_soc_dai uda1380_dai[] = {
 		.rates = UDA1380_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = {
-		.hw_params = uda1380_pcm_hw_params,
-		.shutdown = uda1380_pcm_shutdown,
-		.prepare = uda1380_pcm_prepare,
-		.set_fmt = uda1380_set_dai_fmt,
-	},
+	.ops = &uda1380_dai_ops_capture,
 },
 };
 EXPORT_SYMBOL_GPL(uda1380_dai);
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 35d9975..8b9e64b 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1436,6 +1436,16 @@ static int wm8350_remove(struct platform_device *pdev)
 			SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE)

+static struct snd_soc_dai_ops wm8350_dai_ops = {
+	 .hw_params	= wm8350_pcm_hw_params,
+	 .digital_mute	= wm8350_mute,
+	 .trigger	= wm8350_pcm_trigger,
+	 .set_fmt	= wm8350_set_dai_fmt,
+	 .set_sysclk	= wm8350_set_dai_sysclk,
+	 .set_pll	= wm8350_set_fll,
+	 .set_clkdiv	= wm8350_set_clkdiv,
+};
+
 struct snd_soc_dai wm8350_dai = {
 	.name = "WM8350",
 	.playback = {
@@ -1452,15 +1462,7 @@ struct snd_soc_dai wm8350_dai = {
 		 .rates = WM8350_RATES,
 		 .formats = WM8350_FORMATS,
 	 },
-	.ops = {
-		 .hw_params = wm8350_pcm_hw_params,
-		 .digital_mute = wm8350_mute,
-		 .trigger = wm8350_pcm_trigger,
-		 .set_fmt = wm8350_set_dai_fmt,
-		 .set_sysclk = wm8350_set_dai_sysclk,
-		 .set_pll = wm8350_set_fll,
-		 .set_clkdiv = wm8350_set_clkdiv,
-	 },
+	.ops = &wm8350_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8350_dai);

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 40f8238..85e7dd7 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -570,6 +570,14 @@ static int wm8510_set_bias_level(struct
snd_soc_codec *codec,
 #define WM8510_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)

+static struct snd_soc_dai_ops wm8510_dai_ops = {
+	.hw_params	= wm8510_pcm_hw_params,
+	.digital_mute	= wm8510_mute,
+	.set_fmt	= wm8510_set_dai_fmt,
+	.set_clkdiv	= wm8510_set_dai_clkdiv,
+	.set_pll	= wm8510_set_dai_pll,
+};
+
 struct snd_soc_dai wm8510_dai = {
 	.name = "WM8510 HiFi",
 	.playback = {
@@ -584,13 +592,7 @@ struct snd_soc_dai wm8510_dai = {
 		.channels_max = 2,
 		.rates = WM8510_RATES,
 		.formats = WM8510_FORMATS,},
-	.ops = {
-		.hw_params = wm8510_pcm_hw_params,
-		.digital_mute = wm8510_mute,
-		.set_fmt = wm8510_set_dai_fmt,
-		.set_clkdiv = wm8510_set_dai_clkdiv,
-		.set_pll = wm8510_set_dai_pll,
-	},
+	.ops = &wm8510_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8510_dai);

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index d004e58..4e343db 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -785,6 +785,21 @@ static int wm8580_set_bias_level(struct
snd_soc_codec *codec,
 #define WM8580_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)

+static struct snd_soc_dai_ops wm8580_dai_ops_playback = {
+	.hw_params	= wm8580_paif_hw_params,
+	.set_fmt	= wm8580_set_paif_dai_fmt,
+	.set_clkdiv	= wm8580_set_dai_clkdiv,
+	.set_pll	= wm8580_set_dai_pll,
+	.digital_mute	= wm8580_digital_mute,
+};
+
+static struct snd_soc_dai_ops wm8580_dai_ops_capture = {
+	.hw_params	= wm8580_paif_hw_params,
+	.set_fmt	= wm8580_set_paif_dai_fmt,
+	.set_clkdiv	= wm8580_set_dai_clkdiv,
+	.set_pll	= wm8580_set_dai_pll,
+};
+
 struct snd_soc_dai wm8580_dai[] = {
 	{
 		.name = "WM8580 PAIFRX",
@@ -796,13 +811,7 @@ struct snd_soc_dai wm8580_dai[] = {
 			.rates = SNDRV_PCM_RATE_8000_192000,
 			.formats = WM8580_FORMATS,
 		},
-		.ops = {
-			 .hw_params = wm8580_paif_hw_params,
-			 .set_fmt = wm8580_set_paif_dai_fmt,
-			 .set_clkdiv = wm8580_set_dai_clkdiv,
-			 .set_pll = wm8580_set_dai_pll,
-			 .digital_mute = wm8580_digital_mute,
-		 },
+		.ops = &wm8580_dai_ops_playback,
 	},
 	{
 		.name = "WM8580 PAIFTX",
@@ -814,12 +823,7 @@ struct snd_soc_dai wm8580_dai[] = {
 			.rates = SNDRV_PCM_RATE_8000_192000,
 			.formats = WM8580_FORMATS,
 		},
-		.ops = {
-			 .hw_params = wm8580_paif_hw_params,
-			 .set_fmt = wm8580_set_paif_dai_fmt,
-			 .set_clkdiv = wm8580_set_dai_clkdiv,
-			 .set_pll = wm8580_set_dai_pll,
-		 },
+		.ops = &wm8580_dai_ops_capture,
 	},
 };
 EXPORT_SYMBOL_GPL(wm8580_dai);
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 80b1198..d22ee46 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -259,6 +259,12 @@ static int wm8728_set_bias_level(struct
snd_soc_codec *codec,
 #define WM8728_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)

+static struct snd_soc_dai_ops wm8728_dai_ops = {
+	.hw_params	= wm8728_hw_params,
+	.digital_mute	= wm8728_mute,
+	.set_fmt	= wm8728_set_dai_fmt,
+};
+
 struct snd_soc_dai wm8728_dai = {
 	.name = "WM8728",
 	.playback = {
@@ -268,11 +274,7 @@ struct snd_soc_dai wm8728_dai = {
 		.rates = WM8728_RATES,
 		.formats = WM8728_FORMATS,
 	},
-	.ops = {
-		 .hw_params = wm8728_hw_params,
-		 .digital_mute = wm8728_mute,
-		 .set_fmt = wm8728_set_dai_fmt,
-	}
+	.ops = &wm8728_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8728_dai);

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c444b9f..97f0851 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -446,6 +446,15 @@ static int wm8731_set_bias_level(struct
snd_soc_codec *codec,
 #define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)

+static struct snd_soc_dai_ops wm8731_dai_ops = {
+	.prepare	= wm8731_pcm_prepare,
+	.hw_params	= wm8731_hw_params,
+	.shutdown	= wm8731_shutdown,
+	.digital_mute	= wm8731_mute,
+	.set_sysclk	= wm8731_set_dai_sysclk,
+	.set_fmt	= wm8731_set_dai_fmt,
+};
+
 struct snd_soc_dai wm8731_dai = {
 	.name = "WM8731",
 	.playback = {
@@ -460,14 +469,7 @@ struct snd_soc_dai wm8731_dai = {
 		.channels_max = 2,
 		.rates = WM8731_RATES,
 		.formats = WM8731_FORMATS,},
-	.ops = {
-		.prepare = wm8731_pcm_prepare,
-		.hw_params = wm8731_hw_params,
-		.shutdown = wm8731_shutdown,
-		.digital_mute = wm8731_mute,
-		.set_sysclk = wm8731_set_dai_sysclk,
-		.set_fmt = wm8731_set_dai_fmt,
-	}
+	.ops = &wm8731_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8731_dai);

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 5997fa6..35de8e6 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -694,6 +694,13 @@ static int wm8750_set_bias_level(struct
snd_soc_codec *codec,
 #define WM8750_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)

+static struct snd_soc_dai_ops wm8750_dai_ops = {
+	.hw_params	= wm8750_pcm_hw_params,
+	.digital_mute	= wm8750_mute,
+	.set_fmt	= wm8750_set_dai_fmt,
+	.set_sysclk	= wm8750_set_dai_sysclk,
+};
+
 struct snd_soc_dai wm8750_dai = {
 	.name = "WM8750",
 	.playback = {
@@ -708,12 +715,7 @@ struct snd_soc_dai wm8750_dai = {
 		.channels_max = 2,
 		.rates = WM8750_RATES,
 		.formats = WM8750_FORMATS,},
-	.ops = {
-		.hw_params = wm8750_pcm_hw_params,
-		.digital_mute = wm8750_mute,
-		.set_fmt = wm8750_set_dai_fmt,
-		.set_sysclk = wm8750_set_dai_sysclk,
-	},
+	.ops = &wm8750_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8750_dai);

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 77620ab..2f291c5 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1316,6 +1316,51 @@ static int wm8753_set_bias_level(struct
snd_soc_codec *codec,
  * 3. Voice disabled - HIFI over HIFI
  * 4. Voice disabled - HIFI over HIFI, uses voice DAI LRC for capture
  */
+static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode1 = {
+	.hw_params	= wm8753_i2s_hw_params,
+	.digital_mute	= wm8753_mute,
+	.set_fmt	= wm8753_mode1h_set_dai_fmt,
+	.set_clkdiv	= wm8753_set_dai_clkdiv,
+	.set_pll	= wm8753_set_dai_pll,
+	.set_sysclk	= wm8753_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_ops wm8753_dai_ops_voice_mode1 = {
+	.hw_params	= wm8753_pcm_hw_params,
+	.digital_mute	= wm8753_mute,
+	.set_fmt	= wm8753_mode1v_set_dai_fmt,
+	.set_clkdiv	= wm8753_set_dai_clkdiv,
+	.set_pll	= wm8753_set_dai_pll,
+	.set_sysclk	= wm8753_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_ops wm8753_dai_ops_voice_mode2 = {
+	.hw_params	= wm8753_pcm_hw_params,
+	.digital_mute	= wm8753_mute,
+	.set_fmt	= wm8753_mode2_set_dai_fmt,
+	.set_clkdiv	= wm8753_set_dai_clkdiv,
+	.set_pll	= wm8753_set_dai_pll,
+	.set_sysclk	= wm8753_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode3	= {
+	.hw_params	= wm8753_i2s_hw_params,
+	.digital_mute	= wm8753_mute,
+	.set_fmt	= wm8753_mode3_4_set_dai_fmt,
+	.set_clkdiv	= wm8753_set_dai_clkdiv,
+	.set_pll	= wm8753_set_dai_pll,
+	.set_sysclk	= wm8753_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode4	= {
+	.hw_params	= wm8753_i2s_hw_params,
+	.digital_mute	= wm8753_mute,
+	.set_fmt	= wm8753_mode3_4_set_dai_fmt,
+	.set_clkdiv	= wm8753_set_dai_clkdiv,
+	.set_pll	= wm8753_set_dai_pll,
+	.set_sysclk	= wm8753_set_dai_sysclk,
+};
+
 static const struct snd_soc_dai wm8753_all_dai[] = {
 /* DAI HiFi mode 1 */
 {	.name = "WM8753 HiFi",
@@ -1332,14 +1377,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.channels_max = 2,
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS},
-	.ops = {
-		.hw_params = wm8753_i2s_hw_params,
-		.digital_mute = wm8753_mute,
-		.set_fmt = wm8753_mode1h_set_dai_fmt,
-		.set_clkdiv = wm8753_set_dai_clkdiv,
-		.set_pll = wm8753_set_dai_pll,
-		.set_sysclk = wm8753_set_dai_sysclk,
-	},
+	.ops = &wm8753_dai_ops_hifi_mode1,
 },
 /* DAI Voice mode 1 */
 {	.name = "WM8753 Voice",
@@ -1356,14 +1394,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.channels_max = 2,
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS,},
-	.ops = {
-		.hw_params = wm8753_pcm_hw_params,
-		.digital_mute = wm8753_mute,
-		.set_fmt = wm8753_mode1v_set_dai_fmt,
-		.set_clkdiv = wm8753_set_dai_clkdiv,
-		.set_pll = wm8753_set_dai_pll,
-		.set_sysclk = wm8753_set_dai_sysclk,
-	},
+	.ops = &wm8753_dai_ops_voice_mode1,
 },
 /* DAI HiFi mode 2 - dummy */
 {	.name = "WM8753 HiFi",
@@ -1384,14 +1415,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.channels_max = 2,
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS,},
-	.ops = {
-		.hw_params = wm8753_pcm_hw_params,
-		.digital_mute = wm8753_mute,
-		.set_fmt = wm8753_mode2_set_dai_fmt,
-		.set_clkdiv = wm8753_set_dai_clkdiv,
-		.set_pll = wm8753_set_dai_pll,
-		.set_sysclk = wm8753_set_dai_sysclk,
-	},
+	.ops = &wm8753_dai_ops_voice_mode2,
 },
 /* DAI HiFi mode 3 */
 {	.name = "WM8753 HiFi",
@@ -1408,14 +1432,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.channels_max = 2,
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS,},
-	.ops = {
-		.hw_params = wm8753_i2s_hw_params,
-		.digital_mute = wm8753_mute,
-		.set_fmt = wm8753_mode3_4_set_dai_fmt,
-		.set_clkdiv = wm8753_set_dai_clkdiv,
-		.set_pll = wm8753_set_dai_pll,
-		.set_sysclk = wm8753_set_dai_sysclk,
-	},
+	.ops = &wm8753_dai_ops_hifi_mode3,
 },
 /* DAI Voice mode 3 - dummy */
 {	.name = "WM8753 Voice",
@@ -1436,14 +1453,7 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 		.channels_max = 2,
 		.rates = WM8753_RATES,
 		.formats = WM8753_FORMATS,},
-	.ops = {
-		.hw_params = wm8753_i2s_hw_params,
-		.digital_mute = wm8753_mute,
-		.set_fmt = wm8753_mode3_4_set_dai_fmt,
-		.set_clkdiv = wm8753_set_dai_clkdiv,
-		.set_pll = wm8753_set_dai_pll,
-		.set_sysclk = wm8753_set_dai_sysclk,
-	},
+	.ops = &wm8753_dai_ops_hifi_mode4,
 },
 /* DAI Voice mode 4 - dummy */
 {	.name = "WM8753 Voice",
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 6767de1..589924d 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1104,6 +1104,14 @@ static int wm8900_digital_mute(struct
snd_soc_dai *codec_dai, int mute)
 	(SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S20_3LE | \
 	 SNDRV_PCM_FORMAT_S24_LE)

+static struct snd_soc_dai_ops wm8900_dai_ops = {
+	.hw_params	= wm8900_hw_params,
+	.set_clkdiv	= wm8900_set_dai_clkdiv,
+	.set_pll	= wm8900_set_dai_pll,
+	.set_fmt	= wm8900_set_dai_fmt,
+	.digital_mute	= wm8900_digital_mute,
+};
+
 struct snd_soc_dai wm8900_dai = {
 	.name = "WM8900 HiFi",
 	.playback = {
@@ -1120,13 +1128,7 @@ struct snd_soc_dai wm8900_dai = {
 		.rates = WM8900_RATES,
 		.formats = WM8900_PCM_FORMATS,
 	 },
-	.ops = {
-		.hw_params = wm8900_hw_params,
-		 .set_clkdiv = wm8900_set_dai_clkdiv,
-		 .set_pll = wm8900_set_dai_pll,
-		 .set_fmt = wm8900_set_dai_fmt,
-		 .digital_mute = wm8900_digital_mute,
-	 },
+	.ops = &wm8900_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8900_dai);

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index bde7454..f8f19d8 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1512,6 +1512,15 @@ static int wm8903_hw_params(struct
snd_pcm_substream *substream,
 			SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE)

+static struct snd_soc_dai_ops wm8903_dai_ops = {
+	.startup	= wm8903_startup,
+	.shutdown	= wm8903_shutdown,
+	.hw_params	= wm8903_hw_params,
+	.digital_mute	= wm8903_digital_mute,
+	.set_fmt	= wm8903_set_dai_fmt,
+	.set_sysclk	= wm8903_set_dai_sysclk,
+};
+
 struct snd_soc_dai wm8903_dai = {
 	.name = "WM8903",
 	.playback = {
@@ -1528,14 +1537,7 @@ struct snd_soc_dai wm8903_dai = {
 		 .rates = WM8903_CAPTURE_RATES,
 		 .formats = WM8903_FORMATS,
 	 },
-	.ops = {
-		 .startup = wm8903_startup,
-		 .shutdown = wm8903_shutdown,
-		 .hw_params = wm8903_hw_params,
-		 .digital_mute = wm8903_digital_mute,
-		 .set_fmt = wm8903_set_dai_fmt,
-		 .set_sysclk = wm8903_set_dai_sysclk
-	}
+	.ops = &wm8903_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8903_dai);

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 88ead7f..826d1c9 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -619,6 +619,13 @@ static int wm8971_set_bias_level(struct
snd_soc_codec *codec,
 #define WM8971_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)

+static struct snd_soc_dai_ops wm8971_dai_ops = {
+	.hw_params	= wm8971_pcm_hw_params,
+	.digital_mute	= wm8971_mute,
+	.set_fmt	= wm8971_set_dai_fmt,
+	.set_sysclk	= wm8971_set_dai_sysclk,
+};
+
 struct snd_soc_dai wm8971_dai = {
 	.name = "WM8971",
 	.playback = {
@@ -633,12 +640,7 @@ struct snd_soc_dai wm8971_dai = {
 		.channels_max = 2,
 		.rates = WM8971_RATES,
 		.formats = WM8971_FORMATS,},
-	.ops = {
-		.hw_params = wm8971_pcm_hw_params,
-		.digital_mute = wm8971_mute,
-		.set_fmt = wm8971_set_dai_fmt,
-		.set_sysclk = wm8971_set_dai_sysclk,
-	},
+	.ops = &wm8971_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8971_dai);

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 1cbb7b9..e0141d8 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1345,6 +1345,15 @@ static int wm8990_set_bias_level(struct
snd_soc_codec *codec,
  * 1. ADC/DAC on Primary Interface
  * 2. ADC on Primary Interface/DAC on secondary
  */
+static struct snd_soc_dai_ops wm8990_dai_ops = {
+	.hw_params	= wm8990_hw_params,
+	.digital_mute	= wm8990_mute,
+	.set_fmt	= wm8990_set_dai_fmt,
+	.set_clkdiv	= wm8990_set_dai_clkdiv,
+	.set_pll	= wm8990_set_dai_pll,
+	.set_sysclk	= wm8990_set_dai_sysclk,
+};
+
 struct snd_soc_dai wm8990_dai = {
 /* ADC/DAC on primary */
 	.name = "WM8990 ADC/DAC Primary",
@@ -1361,14 +1370,7 @@ struct snd_soc_dai wm8990_dai = {
 		.channels_max = 2,
 		.rates = WM8990_RATES,
 		.formats = WM8990_FORMATS,},
-	.ops = {
-		.hw_params = wm8990_hw_params,
-		.digital_mute = wm8990_mute,
-		.set_fmt = wm8990_set_dai_fmt,
-		.set_clkdiv = wm8990_set_dai_clkdiv,
-		.set_pll = wm8990_set_dai_pll,
-		.set_sysclk = wm8990_set_dai_sysclk,
-	},
+	.ops = &wm8990_dai_ops,
 };
 EXPORT_SYMBOL_GPL(wm8990_dai);

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index af83d62..684e94e 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -532,6 +532,14 @@ static int ac97_aux_prepare(struct
snd_pcm_substream *substream,
 		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
 		SNDRV_PCM_RATE_48000)

+static struct snd_soc_dai_ops wm9712_dai_ops_hifi = {
+	.prepare	= ac97_prepare,
+};
+
+static struct snd_soc_dai_ops wm9712_dai_ops_aux = {
+	.prepare	= ac97_aux_prepare,
+};
+
 struct snd_soc_dai wm9712_dai[] = {
 {
 	.name = "AC97 HiFi",
@@ -548,8 +556,7 @@ struct snd_soc_dai wm9712_dai[] = {
 		.channels_max = 2,
 		.rates = WM9712_AC97_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.prepare = ac97_prepare,},
+	.ops = &wm9712_dai_ops_hifi,
 },
 {
 	.name = "AC97 Aux",
@@ -559,8 +566,7 @@ struct snd_soc_dai wm9712_dai[] = {
 		.channels_max = 1,
 		.rates = WM9712_AC97_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.prepare = ac97_aux_prepare,},
+	.ops = &wm9712_dai_ops_aux,
 }
 };
 EXPORT_SYMBOL_GPL(wm9712_dai);
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index f3ca8aa..ec8f303 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1021,6 +1021,27 @@ static int ac97_aux_prepare(struct
snd_pcm_substream *substream,
 	(SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S20_3LE | \
 	 SNDRV_PCM_FORMAT_S24_LE)

+static struct snd_soc_dai_ops wm9713_dai_ops_hifi = {
+	.prepare	= ac97_hifi_prepare,
+	.set_clkdiv	= wm9713_set_dai_clkdiv,
+	.set_pll	= wm9713_set_dai_pll,
+};
+
+static struct snd_soc_dai_ops wm9713_dai_ops_aux = {
+	.prepare	= ac97_aux_prepare,
+	.set_clkdiv	= wm9713_set_dai_clkdiv,
+	.set_pll	= wm9713_set_dai_pll,
+};
+
+static struct snd_soc_dai_ops wm9713_dai_ops_voice = {
+	.hw_params	= wm9713_pcm_hw_params,
+	.shutdown	= wm9713_voiceshutdown,
+	.set_clkdiv	= wm9713_set_dai_clkdiv,
+	.set_pll	= wm9713_set_dai_pll,
+	.set_fmt	= wm9713_set_dai_fmt,
+	.set_tristate	= wm9713_set_dai_tristate,
+};
+
 struct snd_soc_dai wm9713_dai[] = {
 {
 	.name = "AC97 HiFi",
@@ -1037,10 +1058,7 @@ struct snd_soc_dai wm9713_dai[] = {
 		.channels_max = 2,
 		.rates = WM9713_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.prepare = ac97_hifi_prepare,
-		.set_clkdiv = wm9713_set_dai_clkdiv,
-		.set_pll = wm9713_set_dai_pll,},
+	.ops = &wm9713_dai_ops_hifi,
 	},
 	{
 	.name = "AC97 Aux",
@@ -1050,10 +1068,7 @@ struct snd_soc_dai wm9713_dai[] = {
 		.channels_max = 1,
 		.rates = WM9713_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.prepare = ac97_aux_prepare,
-		.set_clkdiv = wm9713_set_dai_clkdiv,
-		.set_pll = wm9713_set_dai_pll,},
+	.ops = &wm9713_dai_ops_aux,
 	},
 	{
 	.name = "WM9713 Voice",
@@ -1069,14 +1084,7 @@ struct snd_soc_dai wm9713_dai[] = {
 		.channels_max = 2,
 		.rates = WM9713_PCM_RATES,
 		.formats = WM9713_PCM_FORMATS,},
-	.ops = {
-		.hw_params = wm9713_pcm_hw_params,
-		.shutdown = wm9713_voiceshutdown,
-		.set_clkdiv = wm9713_set_dai_clkdiv,
-		.set_pll = wm9713_set_dai_pll,
-		.set_fmt = wm9713_set_dai_fmt,
-		.set_tristate = wm9713_set_dai_tristate,
-	},
+	.ops = &wm9713_dai_ops_voice,
 	},
 };
 EXPORT_SYMBOL_GPL(wm9713_dai);
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 0fee779..ffdb943 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -499,6 +499,13 @@ static void davinci_i2s_remove(struct
platform_device *pdev,

 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000

+static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
+	.startup	= davinci_i2s_startup,
+	.trigger	= davinci_i2s_trigger,
+	.hw_params	= davinci_i2s_hw_params,
+	.set_fmt	= davinci_i2s_set_dai_fmt,
+};
+
 struct snd_soc_dai davinci_i2s_dai = {
 	.name = "davinci-i2s",
 	.id = 0,
@@ -514,12 +521,7 @@ struct snd_soc_dai davinci_i2s_dai = {
 		.channels_max = 2,
 		.rates = DAVINCI_I2S_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.startup = davinci_i2s_startup,
-		.trigger = davinci_i2s_trigger,
-		.hw_params = davinci_i2s_hw_params,
-		.set_fmt = davinci_i2s_set_dai_fmt,
-	},
+	.ops = &davinci_i2s_dai_ops,
 };
 EXPORT_SYMBOL_GPL(davinci_i2s_dai);

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c6d6eb7..104d5f9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -563,6 +563,15 @@ static int fsl_ssi_set_fmt(struct snd_soc_dai
*cpu_dai, unsigned int format)
 /**
  * fsl_ssi_dai_template: template CPU DAI for the SSI
  */
+static struct snd_soc_dai_ops fsl_ssi_dai_ops = {
+	.startup	= fsl_ssi_startup,
+	.prepare	= fsl_ssi_prepare,
+	.shutdown	= fsl_ssi_shutdown,
+	.trigger	= fsl_ssi_trigger,
+	.set_sysclk	= fsl_ssi_set_sysclk,
+	.set_fmt	= fsl_ssi_set_fmt,
+};
+
 static struct snd_soc_dai fsl_ssi_dai_template = {
 	.playback = {
 		/* The SSI does not support monaural audio. */
@@ -577,14 +586,7 @@ static struct snd_soc_dai fsl_ssi_dai_template = {
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
-	.ops = {
-		.startup = fsl_ssi_startup,
-		.prepare = fsl_ssi_prepare,
-		.shutdown = fsl_ssi_shutdown,
-		.trigger = fsl_ssi_trigger,
-		.set_sysclk = fsl_ssi_set_sysclk,
-		.set_fmt = fsl_ssi_set_fmt,
-	},
+	.ops = &fsl_ssi_dai_ops,
 };

 /**
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 05dd5ab..d6882be 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -461,6 +461,16 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct
snd_soc_dai *cpu_dai,
 	return err;
 }

+static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
+	.startup	= omap_mcbsp_dai_startup,
+	.shutdown	= omap_mcbsp_dai_shutdown,
+	.trigger	= omap_mcbsp_dai_trigger,
+	.hw_params	= omap_mcbsp_dai_hw_params,
+	.set_fmt	= omap_mcbsp_dai_set_dai_fmt,
+	.set_clkdiv	= omap_mcbsp_dai_set_clkdiv,
+	.set_sysclk	= omap_mcbsp_dai_set_dai_sysclk,
+};
+
 #define OMAP_MCBSP_DAI_BUILDER(link_id)				\
 {								\
 	.name = "omap-mcbsp-dai-"#link_id,			\
@@ -477,15 +487,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct
snd_soc_dai *cpu_dai,
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
 	},							\
-	.ops = {						\
-		.startup = omap_mcbsp_dai_startup,		\
-		.shutdown = omap_mcbsp_dai_shutdown,		\
-		.trigger = omap_mcbsp_dai_trigger,		\
-		.hw_params = omap_mcbsp_dai_hw_params,		\
-		.set_fmt = omap_mcbsp_dai_set_dai_fmt,		\
-		.set_clkdiv = omap_mcbsp_dai_set_clkdiv,	\
-		.set_sysclk = omap_mcbsp_dai_set_dai_sysclk,	\
-	},							\
+	.ops = &omap_mcbsp_dai_ops,				\
 	.private_data = &mcbsp_data[(link_id)].bus_id,		\
 }

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 724e8fb..1242d68 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -766,6 +766,19 @@ static void pxa_ssp_remove(struct platform_device *pdev,
 			    SNDRV_PCM_FMTBIT_S24_LE |	\
 			    SNDRV_PCM_FMTBIT_S32_LE)

+static struct snd_soc_dai_ops pxa_ssp_dai_ops = {
+	.startup	= pxa_ssp_startup,
+	.shutdown	= pxa_ssp_shutdown,
+	.trigger	= pxa_ssp_trigger,
+	.hw_params	= pxa_ssp_hw_params,
+	.set_sysclk	= pxa_ssp_set_dai_sysclk,
+	.set_clkdiv	= pxa_ssp_set_dai_clkdiv,
+	.set_pll	= pxa_ssp_set_dai_pll,
+	.set_fmt	= pxa_ssp_set_dai_fmt,
+	.set_tdm_slot	= pxa_ssp_set_dai_tdm_slot,
+	.set_tristate	= pxa_ssp_set_dai_tristate,
+};
+
 struct snd_soc_dai pxa_ssp_dai[] = {
 	{
 		.name = "pxa2xx-ssp1",
@@ -786,18 +799,7 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		 },
-		.ops = {
-			.startup = pxa_ssp_startup,
-			.shutdown = pxa_ssp_shutdown,
-			.trigger = pxa_ssp_trigger,
-			.hw_params = pxa_ssp_hw_params,
-			.set_sysclk = pxa_ssp_set_dai_sysclk,
-			.set_clkdiv = pxa_ssp_set_dai_clkdiv,
-			.set_pll = pxa_ssp_set_dai_pll,
-			.set_fmt = pxa_ssp_set_dai_fmt,
-			.set_tdm_slot = pxa_ssp_set_dai_tdm_slot,
-			.set_tristate = pxa_ssp_set_dai_tristate,
-		},
+		.ops = &pxa_ssp_dai_ops,
 	},
 	{	.name = "pxa2xx-ssp2",
 		.id = 1,
@@ -817,18 +819,7 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		 },
-		.ops = {
-			.startup = pxa_ssp_startup,
-			.shutdown = pxa_ssp_shutdown,
-			.trigger = pxa_ssp_trigger,
-			.hw_params = pxa_ssp_hw_params,
-			.set_sysclk = pxa_ssp_set_dai_sysclk,
-			.set_clkdiv = pxa_ssp_set_dai_clkdiv,
-			.set_pll = pxa_ssp_set_dai_pll,
-			.set_fmt = pxa_ssp_set_dai_fmt,
-			.set_tdm_slot = pxa_ssp_set_dai_tdm_slot,
-			.set_tristate = pxa_ssp_set_dai_tristate,
-		},
+		.ops = &pxa_ssp_dai_ops,
 	},
 	{
 		.name = "pxa2xx-ssp3",
@@ -849,18 +840,7 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		 },
-		.ops = {
-			.startup = pxa_ssp_startup,
-			.shutdown = pxa_ssp_shutdown,
-			.trigger = pxa_ssp_trigger,
-			.hw_params = pxa_ssp_hw_params,
-			.set_sysclk = pxa_ssp_set_dai_sysclk,
-			.set_clkdiv = pxa_ssp_set_dai_clkdiv,
-			.set_pll = pxa_ssp_set_dai_pll,
-			.set_fmt = pxa_ssp_set_dai_fmt,
-			.set_tdm_slot = pxa_ssp_set_dai_tdm_slot,
-			.set_tristate = pxa_ssp_set_dai_tristate,
-		},
+		.ops = &pxa_ssp_dai_ops,
 	},
 	{
 		.name = "pxa2xx-ssp4",
@@ -881,18 +861,7 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		 },
-		.ops = {
-			.startup = pxa_ssp_startup,
-			.shutdown = pxa_ssp_shutdown,
-			.trigger = pxa_ssp_trigger,
-			.hw_params = pxa_ssp_hw_params,
-			.set_sysclk = pxa_ssp_set_dai_sysclk,
-			.set_clkdiv = pxa_ssp_set_dai_clkdiv,
-			.set_pll = pxa_ssp_set_dai_pll,
-			.set_fmt = pxa_ssp_set_dai_fmt,
-			.set_tdm_slot = pxa_ssp_set_dai_tdm_slot,
-			.set_tristate = pxa_ssp_set_dai_tristate,
-		},
+		.ops = &pxa_ssp_dai_ops,
 	},
 };
 EXPORT_SYMBOL_GPL(pxa_ssp_dai);
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index a4a655f..a7b8a3f 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -164,6 +164,10 @@ static int pxa2xx_ac97_hw_mic_params(struct
snd_pcm_substream *substream,
 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
 		SNDRV_PCM_RATE_48000)

+static struct snd_soc_dai_ops pxa_ac97_dai_ops = {
+	.hw_params	= pxa2xx_ac97_hw_params,
+};
+
 /*
  * There is only 1 physical AC97 interface for pxa2xx, but it
  * has extra fifo's that can be used for aux DACs and ADCs.
@@ -189,8 +193,7 @@ struct snd_soc_dai pxa_ac97_dai[] = {
 		.channels_max = 2,
 		.rates = PXA2XX_AC97_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.hw_params = pxa2xx_ac97_hw_params,},
+	.ops = &pxa_ac97_dai_ops,
 },
 {
 	.name = "pxa2xx-ac97-aux",
@@ -208,8 +211,7 @@ struct snd_soc_dai pxa_ac97_dai[] = {
 		.channels_max = 1,
 		.rates = PXA2XX_AC97_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.hw_params = pxa2xx_ac97_hw_aux_params,},
+	.ops = &pxa_ac97_dai_ops,
 },
 {
 	.name = "pxa2xx-ac97-mic",
@@ -221,8 +223,7 @@ struct snd_soc_dai pxa_ac97_dai[] = {
 		.channels_max = 1,
 		.rates = PXA2XX_AC97_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.hw_params = pxa2xx_ac97_hw_mic_params,},
+	.ops = &pxa_ac97_dai_ops,
 },
 };

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 223de89..bd63a86 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -335,6 +335,15 @@ static int pxa2xx_i2s_resume(struct snd_soc_dai *dai)
 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
 		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)

+static struct snd_soc_dai_ops pxa_i2s_dai_ops = {
+	.startup	= pxa2xx_i2s_startup,
+	.shutdown	= pxa2xx_i2s_shutdown,
+	.trigger	= pxa2xx_i2s_trigger,
+	.hw_params	= pxa2xx_i2s_hw_params,
+	.set_fmt	= pxa2xx_i2s_set_dai_fmt,
+	.set_sysclk	= pxa2xx_i2s_set_dai_sysclk,
+};
+
 struct snd_soc_dai pxa_i2s_dai = {
 	.name = "pxa2xx-i2s",
 	.id = 0,
@@ -350,14 +359,7 @@ struct snd_soc_dai pxa_i2s_dai = {
 		.channels_max = 2,
 		.rates = PXA2XX_I2S_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.startup = pxa2xx_i2s_startup,
-		.shutdown = pxa2xx_i2s_shutdown,
-		.trigger = pxa2xx_i2s_trigger,
-		.hw_params = pxa2xx_i2s_hw_params,
-		.set_fmt = pxa2xx_i2s_set_dai_fmt,
-		.set_sysclk = pxa2xx_i2s_set_dai_sysclk,
-	},
+	.ops = &pxa_i2s_dai_ops,
 };

 EXPORT_SYMBOL_GPL(pxa_i2s_dai);
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index f3fc0ab..382d7ee 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -708,6 +708,14 @@ static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
 	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)

+static struct snd_soc_dai_ops s3c2412_i2s_dai_ops = {
+	.trigger	= s3c2412_i2s_trigger,
+	.hw_params	= s3c2412_i2s_hw_params,
+	.set_fmt	= s3c2412_i2s_set_fmt,
+	.set_clkdiv	= s3c2412_i2s_set_clkdiv,
+	.set_sysclk	= s3c2412_i2s_set_sysclk,
+};
+
 struct snd_soc_dai s3c2412_i2s_dai = {
 	.name	= "s3c2412-i2s",
 	.id	= 0,
@@ -726,13 +734,7 @@ struct snd_soc_dai s3c2412_i2s_dai = {
 		.rates		= S3C2412_I2S_RATES,
 		.formats	= SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = {
-		.trigger	= s3c2412_i2s_trigger,
-		.hw_params	= s3c2412_i2s_hw_params,
-		.set_fmt	= s3c2412_i2s_set_fmt,
-		.set_clkdiv	= s3c2412_i2s_set_clkdiv,
-		.set_sysclk	= s3c2412_i2s_set_sysclk,
-	},
+	.ops = &s3c2412_i2s_dai_ops,
 };
 EXPORT_SYMBOL_GPL(s3c2412_i2s_dai);

diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
index 5822d2d..83ea623 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -355,6 +355,11 @@ static int s3c2443_ac97_mic_trigger(struct
snd_pcm_substream *substream,
 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
 		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)

+static struct snd_soc_dai_ops s3c2443_ac97_dai_ops = {
+	.hw_params	= s3c2443_ac97_hw_params,
+	.trigger	= s3c2443_ac97_trigger,
+};
+
 struct snd_soc_dai s3c2443_ac97_dai[] = {
 {
 	.name = "s3c2443-ac97",
@@ -374,9 +379,7 @@ struct snd_soc_dai s3c2443_ac97_dai[] = {
 		.channels_max = 2,
 		.rates = s3c2443_AC97_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.hw_params = s3c2443_ac97_hw_params,
-		.trigger = s3c2443_ac97_trigger},
+	.ops = &s3c2443_ac97_dai_ops,
 },
 {
 	.name = "pxa2xx-ac97-mic",
@@ -388,9 +391,7 @@ struct snd_soc_dai s3c2443_ac97_dai[] = {
 		.channels_max = 1,
 		.rates = s3c2443_AC97_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.hw_params = s3c2443_ac97_hw_mic_params,
-		.trigger = s3c2443_ac97_mic_trigger,},
+	.ops = &s3c2443_ac97_dai_ops,
 },
 };
 EXPORT_SYMBOL_GPL(s3c2443_ac97_dai);
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 6f4d439..82d8c6e 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -456,6 +456,14 @@ static int s3c24xx_i2s_resume(struct snd_soc_dai *cpu_dai)
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
 	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)

+static struct snd_soc_dai_ops s3c24xx_i2s_dai_ops = {
+	.trigger	= s3c24xx_i2s_trigger,
+	.hw_params	= s3c24xx_i2s_hw_params,
+	.set_fmt	= s3c24xx_i2s_set_fmt,
+	.set_clkdiv	= s3c24xx_i2s_set_clkdiv,
+	.set_sysclk	= s3c24xx_i2s_set_sysclk,
+};
+
 struct snd_soc_dai s3c24xx_i2s_dai = {
 	.name = "s3c24xx-i2s",
 	.id = 0,
@@ -472,13 +480,7 @@ struct snd_soc_dai s3c24xx_i2s_dai = {
 		.channels_max = 2,
 		.rates = S3C24XX_I2S_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = {
-		.trigger = s3c24xx_i2s_trigger,
-		.hw_params = s3c24xx_i2s_hw_params,
-		.set_fmt = s3c24xx_i2s_set_fmt,
-		.set_clkdiv = s3c24xx_i2s_set_clkdiv,
-		.set_sysclk = s3c24xx_i2s_set_sysclk,
-	},
+	.ops = &s3c24xx_i2s_dai_ops,
 };
 EXPORT_SYMBOL_GPL(s3c24xx_i2s_dai);

diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index d1e5390..56fa087 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -336,6 +336,16 @@ static int ssi_set_fmt(struct snd_soc_dai *dai,
unsigned int fmt)
 	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_U24_3LE |	\
 	 SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_U32_LE)

+static struct snd_soc_dai_ops ssi_dai_ops = {
+	.startup	= ssi_startup,
+	.shutdown	= ssi_shutdown,
+	.trigger	= ssi_trigger,
+	.hw_params	= ssi_hw_params,
+	.set_sysclk	= ssi_set_sysclk,
+	.set_clkdiv	= ssi_set_clkdiv,
+	.set_fmt	= ssi_set_fmt,
+};
+
 struct snd_soc_dai sh4_ssi_dai[] = {
 {
 	.name			= "SSI0",
@@ -352,15 +362,7 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 		.channels_min	= 2,
 		.channels_max	= 8,
 	},
-	.ops = {
-		.startup	= ssi_startup,
-		.shutdown	= ssi_shutdown,
-		.trigger	= ssi_trigger,
-		.hw_params	= ssi_hw_params,
-		.set_sysclk	= ssi_set_sysclk,
-		.set_clkdiv	= ssi_set_clkdiv,
-		.set_fmt	= ssi_set_fmt,
-	},
+	.ops = &ssi_dai_ops,
 },
 #ifdef CONFIG_CPU_SUBTYPE_SH7760
 {
@@ -378,15 +380,7 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 		.channels_min	= 2,
 		.channels_max	= 8,
 	},
-	.ops = {
-		.startup	= ssi_startup,
-		.shutdown	= ssi_shutdown,
-		.trigger	= ssi_trigger,
-		.hw_params	= ssi_hw_params,
-		.set_sysclk	= ssi_set_sysclk,
-		.set_clkdiv	= ssi_set_clkdiv,
-		.set_fmt	= ssi_set_fmt,
-	},
+	.ops = &ssi_dai_ops,
 },
 #endif
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 55fdb4a..a0113f1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -133,8 +133,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	mutex_lock(&pcm_mutex);

 	/* startup the audio subsystem */
-	if (cpu_dai->ops.startup) {
-		ret = cpu_dai->ops.startup(substream, cpu_dai);
+	if (cpu_dai->ops->startup) {
+		ret = cpu_dai->ops->startup(substream, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open interface %s\n",
 				cpu_dai->name);
@@ -150,8 +150,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}

-	if (codec_dai->ops.startup) {
-		ret = codec_dai->ops.startup(substream, codec_dai);
+	if (codec_dai->ops->startup) {
+		ret = codec_dai->ops->startup(substream, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open codec %s\n",
 				codec_dai->name);
@@ -247,8 +247,8 @@ codec_dai_err:
 		platform->pcm_ops->close(substream);

 platform_err:
-	if (cpu_dai->ops.shutdown)
-		cpu_dai->ops.shutdown(substream, cpu_dai);
+	if (cpu_dai->ops->shutdown)
+		cpu_dai->ops->shutdown(substream, cpu_dai);
 out:
 	mutex_unlock(&pcm_mutex);
 	return ret;
@@ -340,11 +340,11 @@ static int soc_codec_close(struct
snd_pcm_substream *substream)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		snd_soc_dai_digital_mute(codec_dai, 1);

-	if (cpu_dai->ops.shutdown)
-		cpu_dai->ops.shutdown(substream, cpu_dai);
+	if (cpu_dai->ops->shutdown)
+		cpu_dai->ops->shutdown(substream, cpu_dai);

-	if (codec_dai->ops.shutdown)
-		codec_dai->ops.shutdown(substream, codec_dai);
+	if (codec_dai->ops->shutdown)
+		codec_dai->ops->shutdown(substream, codec_dai);

 	if (machine->ops && machine->ops->shutdown)
 		machine->ops->shutdown(substream);
@@ -408,16 +408,16 @@ static int soc_pcm_prepare(struct
snd_pcm_substream *substream)
 		}
 	}

-	if (codec_dai->ops.prepare) {
-		ret = codec_dai->ops.prepare(substream, codec_dai);
+	if (codec_dai->ops->prepare) {
+		ret = codec_dai->ops->prepare(substream, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: codec DAI prepare error\n");
 			goto out;
 		}
 	}

-	if (cpu_dai->ops.prepare) {
-		ret = cpu_dai->ops.prepare(substream, cpu_dai);
+	if (cpu_dai->ops->prepare) {
+		ret = cpu_dai->ops->prepare(substream, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: cpu DAI prepare error\n");
 			goto out;
@@ -494,8 +494,8 @@ static int soc_pcm_hw_params(struct
snd_pcm_substream *substream,
 		}
 	}

-	if (codec_dai->ops.hw_params) {
-		ret = codec_dai->ops.hw_params(substream, params, codec_dai);
+	if (codec_dai->ops->hw_params) {
+		ret = codec_dai->ops->hw_params(substream, params, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't set codec %s hw params\n",
 				codec_dai->name);
@@ -503,8 +503,8 @@ static int soc_pcm_hw_params(struct
snd_pcm_substream *substream,
 		}
 	}

-	if (cpu_dai->ops.hw_params) {
-		ret = cpu_dai->ops.hw_params(substream, params, cpu_dai);
+	if (cpu_dai->ops->hw_params) {
+		ret = cpu_dai->ops->hw_params(substream, params, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: interface %s hw params failed\n",
 				cpu_dai->name);
@@ -526,12 +526,12 @@ out:
 	return ret;

 platform_err:
-	if (cpu_dai->ops.hw_free)
-		cpu_dai->ops.hw_free(substream, cpu_dai);
+	if (cpu_dai->ops->hw_free)
+		cpu_dai->ops->hw_free(substream, cpu_dai);

 interface_err:
-	if (codec_dai->ops.hw_free)
-		codec_dai->ops.hw_free(substream, codec_dai);
+	if (codec_dai->ops->hw_free)
+		codec_dai->ops->hw_free(substream, codec_dai);

 codec_err:
 	if (machine->ops && machine->ops->hw_free)
@@ -570,11 +570,11 @@ static int soc_pcm_hw_free(struct
snd_pcm_substream *substream)
 		platform->pcm_ops->hw_free(substream);

 	/* now free hw params for the DAI's  */
-	if (codec_dai->ops.hw_free)
-		codec_dai->ops.hw_free(substream, codec_dai);
+	if (codec_dai->ops->hw_free)
+		codec_dai->ops->hw_free(substream, codec_dai);

-	if (cpu_dai->ops.hw_free)
-		cpu_dai->ops.hw_free(substream, cpu_dai);
+	if (cpu_dai->ops->hw_free)
+		cpu_dai->ops->hw_free(substream, cpu_dai);

 	mutex_unlock(&pcm_mutex);
 	return 0;
@@ -591,8 +591,8 @@ static int soc_pcm_trigger(struct
snd_pcm_substream *substream, int cmd)
 	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	int ret;

-	if (codec_dai->ops.trigger) {
-		ret = codec_dai->ops.trigger(substream, cmd, codec_dai);
+	if (codec_dai->ops->trigger) {
+		ret = codec_dai->ops->trigger(substream, cmd, codec_dai);
 		if (ret < 0)
 			return ret;
 	}
@@ -603,8 +603,8 @@ static int soc_pcm_trigger(struct
snd_pcm_substream *substream, int cmd)
 			return ret;
 	}

-	if (cpu_dai->ops.trigger) {
-		ret = cpu_dai->ops.trigger(substream, cmd, cpu_dai);
+	if (cpu_dai->ops->trigger) {
+		ret = cpu_dai->ops->trigger(substream, cmd, cpu_dai);
 		if (ret < 0)
 			return ret;
 	}
@@ -645,8 +645,8 @@ static int soc_suspend(struct platform_device
*pdev, pm_message_t state)
 	/* mute any active DAC's */
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *dai = card->dai_link[i].codec_dai;
-		if (dai->ops.digital_mute && dai->playback.active)
-			dai->ops.digital_mute(dai, 1);
+		if (dai->ops->digital_mute && dai->playback.active)
+			dai->ops->digital_mute(dai, 1);
 	}

 	/* suspend all pcms */
@@ -741,8 +741,8 @@ static void soc_resume_deferred(struct work_struct *work)
 	/* unmute any active DACs */
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *dai = card->dai_link[i].codec_dai;
-		if (dai->ops.digital_mute && dai->playback.active)
-			dai->ops.digital_mute(dai, 0);
+		if (dai->ops->digital_mute && dai->playback.active)
+			dai->ops->digital_mute(dai, 0);
 	}

 	for (i = 0; i < card->num_links; i++) {
@@ -2020,8 +2020,8 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned int freq, int dir)
 {
-	if (dai->ops.set_sysclk)
-		return dai->ops.set_sysclk(dai, clk_id, freq, dir);
+	if (dai->ops->set_sysclk)
+		return dai->ops->set_sysclk(dai, clk_id, freq, dir);
 	else
 		return -EINVAL;
 }
@@ -2040,8 +2040,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
 int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
 	int div_id, int div)
 {
-	if (dai->ops.set_clkdiv)
-		return dai->ops.set_clkdiv(dai, div_id, div);
+	if (dai->ops->set_clkdiv)
+		return dai->ops->set_clkdiv(dai, div_id, div);
 	else
 		return -EINVAL;
 }
@@ -2059,8 +2059,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_clkdiv);
 int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
 	int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
-	if (dai->ops.set_pll)
-		return dai->ops.set_pll(dai, pll_id, freq_in, freq_out);
+	if (dai->ops->set_pll)
+		return dai->ops->set_pll(dai, pll_id, freq_in, freq_out);
 	else
 		return -EINVAL;
 }
@@ -2075,8 +2075,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
  */
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	if (dai->ops.set_fmt)
-		return dai->ops.set_fmt(dai, fmt);
+	if (dai->ops->set_fmt)
+		return dai->ops->set_fmt(dai, fmt);
 	else
 		return -EINVAL;
 }
@@ -2094,8 +2094,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int mask, int slots)
 {
-	if (dai->ops.set_sysclk)
-		return dai->ops.set_tdm_slot(dai, mask, slots);
+	if (dai->ops->set_sysclk)
+		return dai->ops->set_tdm_slot(dai, mask, slots);
 	else
 		return -EINVAL;
 }
@@ -2110,8 +2110,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
  */
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
-	if (dai->ops.set_sysclk)
-		return dai->ops.set_tristate(dai, tristate);
+	if (dai->ops->set_sysclk)
+		return dai->ops->set_tristate(dai, tristate);
 	else
 		return -EINVAL;
 }
@@ -2126,8 +2126,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tristate);
  */
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	if (dai->ops.digital_mute)
-		return dai->ops.digital_mute(dai, mute);
+	if (dai->ops->digital_mute)
+		return dai->ops->digital_mute(dai, mute);
 	else
 		return -EINVAL;
 }
@@ -2180,6 +2180,9 @@ static int snd_soc_unregister_card(struct
snd_soc_card *card)
 	return 0;
 }

+static struct snd_soc_dai_ops null_dai_ops = {
+};
+
 /**
  * snd_soc_register_dai - Register a DAI with the ASoC core
  *
@@ -2194,6 +2197,9 @@ int snd_soc_register_dai(struct snd_soc_dai *dai)
 	if (!dai->dev)
 		printk(KERN_WARNING "No device for DAI %s\n", dai->name);

+	if (!dai->ops)
+		dai->ops = &null_dai_ops;
+
 	INIT_LIST_HEAD(&dai->list);

 	mutex_lock(&client_mutex);
