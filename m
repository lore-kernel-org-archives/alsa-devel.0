From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove redundant snd_soc_dapm_sync()
	calls from machine drivers
Date: Sat,  8 Oct 2011 14:09:11 +0100
Message-ID: <1318079351-27610-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0AB7524372
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Oct 2011 15:09:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The core will sync DAPM as part of the card initialization, there is no
need for machine drivers to do so during their setup.

OMAP drivers are omitted as I know Peter already has patches for them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/playpaq_wm8510.c               |    1 -
 sound/soc/atmel/sam9g20_wm8731.c               |    2 --
 sound/soc/atmel/snd-soc-afeb9260.c             |    2 --
 sound/soc/davinci/davinci-evm.c                |    2 --
 sound/soc/kirkwood/kirkwood-t5325.c            |    2 --
 sound/soc/mid-x86/mfld_machine.c               |    2 --
 sound/soc/pxa/corgi.c                          |    1 -
 sound/soc/pxa/e740_wm9705.c                    |    2 --
 sound/soc/pxa/e750_wm9705.c                    |    2 --
 sound/soc/pxa/e800_wm9712.c                    |    1 -
 sound/soc/pxa/magician.c                       |    1 -
 sound/soc/pxa/mioa701_wm9713.c                 |    1 -
 sound/soc/pxa/palm27x.c                        |    4 ----
 sound/soc/pxa/saarb.c                          |    4 ----
 sound/soc/pxa/tavorevb3.c                      |    4 ----
 sound/soc/pxa/tosa.c                           |    1 -
 sound/soc/pxa/z2.c                             |    4 ----
 sound/soc/pxa/zylonite.c                       |    1 -
 sound/soc/samsung/goni_wm8994.c                |    2 --
 sound/soc/samsung/h1940_uda1380.c              |    2 --
 sound/soc/samsung/jive_wm8750.c                |    1 -
 sound/soc/samsung/neo1973_wm8753.c             |    4 ----
 sound/soc/samsung/rx1950_uda1380.c             |    2 --
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |    1 -
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |    1 -
 sound/soc/samsung/smartq_wm8987.c              |    4 ----
 sound/soc/samsung/smdk_wm8580.c                |    6 ------
 sound/soc/samsung/smdk_wm8994.c                |    2 --
 sound/soc/sh/sh7760-ac97.c                     |    7 -------
 sound/soc/tegra/tegra_wm8903.c                 |    2 --
 sound/soc/tegra/trimslice.c                    |    2 --
 31 files changed, 0 insertions(+), 73 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index 2909bfa..73ae99a 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -338,7 +338,6 @@ static int playpaq_wm8510_init(struct snd_soc_pcm_runtime *rtd)
 	/* always connected pins */
 	snd_soc_dapm_enable_pin(dapm, "Int Mic");
 	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-	snd_soc_dapm_sync(dapm);
 
 
 
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index bad3aa1..0377c54 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -173,8 +173,6 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 	/* always connected */
 	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index 5e4d499..d427e92 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -117,8 +117,6 @@ static int afeb9260_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Line In");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index fe79842..f78c3f0 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -150,8 +150,6 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 	snd_soc_dapm_enable_pin(dapm, "Line In");
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index c8d2195..c772b3c 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -79,8 +79,6 @@ static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 277ca626..cca693a 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -234,7 +234,6 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	/* always connected */
 	snd_soc_dapm_enable_pin(dapm, "Headphones");
 	snd_soc_dapm_enable_pin(dapm, "Mic");
-	snd_soc_dapm_sync(dapm);
 
 	ret_val = snd_soc_add_controls(codec, mfld_snd_controls,
 				ARRAY_SIZE(mfld_snd_controls));
@@ -252,7 +251,6 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	/* we dont use linein in this so set to NC */
 	snd_soc_dapm_disable_pin(dapm, "LINEINL");
 	snd_soc_dapm_disable_pin(dapm, "LINEINR");
-	snd_soc_dapm_sync(dapm);
 
 	/* Headset and button jack detection */
 	ret_val = snd_soc_jack_new(codec, "Intel(R) MID Audio Jack",
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 28757fb..b0e2fb7 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -299,7 +299,6 @@ static int corgi_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 	/* Set up corgi specific audio path audio_map */
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index dc65650..35ed7eb8c 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -108,8 +108,6 @@ static int e740_ac97_init(struct snd_soc_pcm_runtime *rtd)
 
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 51897fc..ce5f056 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -90,8 +90,6 @@ static int e750_ac97_init(struct snd_soc_pcm_runtime *rtd)
 
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 053ed20..6a8f38b 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -80,7 +80,6 @@ static int e800_ac97_init(struct snd_soc_pcm_runtime *rtd)
 					ARRAY_SIZE(e800_dapm_widgets));
 
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 098e5f4..e79f516 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -423,7 +423,6 @@ static int magician_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	/* Set up magician specific audio path interconnects */
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 38ca675..0b8d1ee 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -151,7 +151,6 @@ static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Front Mic");
 	snd_soc_dapm_enable_pin(dapm, "GSM Line In");
 	snd_soc_dapm_enable_pin(dapm, "GSM Line Out");
-	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 504e400..7edc1fb 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -107,10 +107,6 @@ static int palm27x_ac97_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "PHONE");
 	snd_soc_dapm_nc_pin(dapm, "MIC2");
 
-	err = snd_soc_dapm_sync(dapm);
-	if (err)
-		return err;
-
 	/* Jack detection API stuff */
 	err = snd_soc_jack_new(codec, "Headphone Jack",
 				SND_JACK_HEADPHONE, &hs_jack);
diff --git a/sound/soc/pxa/saarb.c b/sound/soc/pxa/saarb.c
index 9595189..d9467a2 100644
--- a/sound/soc/pxa/saarb.c
+++ b/sound/soc/pxa/saarb.c
@@ -146,10 +146,6 @@ static int saarb_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_disable_pin(dapm, "Headset Mic 2");
 	snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
 
-	ret = snd_soc_dapm_sync(dapm);
-	if (ret)
-		return ret;
-
 	/* Headset jack detection */
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE
 			| SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2,
diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
index f881f65..eeec892 100644
--- a/sound/soc/pxa/tavorevb3.c
+++ b/sound/soc/pxa/tavorevb3.c
@@ -146,10 +146,6 @@ static int evb3_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_disable_pin(dapm, "Headset Mic 2");
 	snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
 
-	ret = snd_soc_dapm_sync(dapm);
-	if (ret)
-		return ret;
-
 	/* Headset jack detection */
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE
 			| SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2,
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 9a23513..620fc69 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -211,7 +211,6 @@ static int tosa_ac97_init(struct snd_soc_pcm_runtime *rtd)
 	/* set up tosa specific audio path audio_map */
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 4b81ffd..b311ffe 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -161,10 +161,6 @@ static int z2_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 	/* Set up z2 specific audio paths */
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	ret = snd_soc_dapm_sync(dapm);
-	if (ret)
-		goto err;
-
 	/* Jack detection API stuff */
 	ret = snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
 				&hs_jack);
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 2b8350b..580aae3 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -87,7 +87,6 @@ static int zylonite_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Headphone");
 	snd_soc_dapm_enable_pin(dapm, "Headset Earpiece");
 
-	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index dcaf656..7711650 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -121,8 +121,6 @@ static int goni_wm8994_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_dapm_nc_pin(dapm, "SPKOUTRP");
 	}
 
-	snd_soc_dapm_sync(dapm);
-
 	/* Headset jack detection */
 	ret = snd_soc_jack_new(codec, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_MECHANICAL | SND_JACK_AVOUT,
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 374ac2e..cdaed90 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -199,8 +199,6 @@ static int h1940_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
-	snd_soc_dapm_sync(dapm);
-
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
 		&hp_jack);
 
diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index b4e3d01..5a1e0cb 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -121,7 +121,6 @@ static int jive_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 16152ed..7207189 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -367,8 +367,6 @@ static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 			return ret;
 	}
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
@@ -409,8 +407,6 @@ static int neo1973_lm4857_init(struct snd_soc_dapm_context *dapm)
 	snd_soc_dapm_ignore_suspend(dapm, "Handset Spk");
 	snd_soc_dapm_ignore_suspend(dapm, "Headphone");
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index de1c509..d197100 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -239,8 +239,6 @@ static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
-	snd_soc_dapm_sync(dapm);
-
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
 		&hp_jack);
 
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index 2422117..5a9d495 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -77,7 +77,6 @@ static int simtec_hermes_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
 	simtec_audio_init(rtd);
-	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index 57aee5e..203bd7a 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -66,7 +66,6 @@ static int simtec_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
 	simtec_audio_init(rtd);
-	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index ebac492..16bf48f 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -179,10 +179,6 @@ static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Internal Mic");
 	snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 
-	err = snd_soc_dapm_sync(dapm);
-	if (err)
-		return err;
-
 	/* Headphone jack detection */
 	err = snd_soc_jack_new(codec, "Headphone Jack",
 			       SND_JACK_HEADPHONE, &smartq_jack);
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index dabd185..9de6b13 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -174,9 +174,6 @@ static int smdk_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 	 */
 	snd_soc_dapm_disable_pin(dapm, "MicIn");
 
-	/* signal a DAPM event */
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
@@ -192,9 +189,6 @@ static int smdk_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
 	/* Set up PAIFRX audio path */
 	snd_soc_dapm_add_routes(dapm, audio_map_rx, ARRAY_SIZE(audio_map_rx));
 
-	/* signal a DAPM event */
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 45fbe2b..f75e439 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -117,8 +117,6 @@ static int smdk_wm8994_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "IN1RP");
 	snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index 917d3ce..c62ae68 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -20,12 +20,6 @@
 extern struct snd_soc_dai_driver sh4_hac_dai[2];
 extern struct snd_soc_platform_driver sh7760_soc_platform;
 
-static int machine_init(struct snd_soc_pcm_runtime *rtd)
-{
-	snd_soc_dapm_sync(&rtd->codec->dapm);
-	return 0;
-}
-
 static struct snd_soc_dai_link sh7760_ac97_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
@@ -33,7 +27,6 @@ static struct snd_soc_dai_link sh7760_ac97_dai = {
 	.codec_dai_name = "ac97-hifi",
 	.platform_name = "sh7760-pcm-audio",
 	.codec_name = "ac97-codec",
-	.init = machine_init,
 	.ops = NULL,
 };
 
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index be27f1d..a81cf39 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -339,8 +339,6 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_dapm_nc_pin(dapm, "LINEOUTL");
 	}
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index 8fc07e9..b3a7efa 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -124,8 +124,6 @@ static int trimslice_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "RHPOUT");
 	snd_soc_dapm_nc_pin(dapm, "MICIN");
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
-- 
1.7.6.3
