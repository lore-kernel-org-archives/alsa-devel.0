From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: Route all bias level updates through
	the core
Date: Mon, 27 Apr 2015 22:13:24 +0200
Message-ID: <1430165606-3072-3-git-send-email-lars@metafoo.de>
References: <1430165606-3072-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-223.synserver.de (smtp-out-223.synserver.de
 [212.40.185.223])
 by alsa0.perex.cz (Postfix) with ESMTP id E7F7D26041C
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 22:13:46 +0200 (CEST)
In-Reply-To: <1430165606-3072-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Use the new snd_soc_codec_force_bias_level() helper function to invoke the
bias_level callback of a driver instead of calling the callback by hand.
Currently the effect of this is the same, but having all bias level updates
go through a central place will allow us to move more of the bias level
management into the DAPM core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98095.c | 4 ++--
 sound/soc/codecs/rt5640.c   | 4 ++--
 sound/soc/codecs/rt5645.c   | 2 +-
 sound/soc/codecs/rt5651.c   | 2 +-
 sound/soc/codecs/rt5677.c   | 2 +-
 sound/soc/codecs/sta32x.c   | 2 +-
 sound/soc/codecs/sta350.c   | 2 +-
 sound/soc/codecs/twl6040.c  | 2 +-
 sound/soc/codecs/wm8731.c   | 2 +-
 sound/soc/codecs/wm8737.c   | 2 +-
 sound/soc/codecs/wm8900.c   | 6 +++---
 sound/soc/codecs/wm8940.c   | 2 +-
 sound/soc/codecs/wm8955.c   | 2 +-
 sound/soc/codecs/wm8978.c   | 4 ++--
 sound/soc/codecs/wm8990.c   | 2 +-
 sound/soc/codecs/wm8993.c   | 4 ++--
 sound/soc/codecs/wm8994.c   | 2 +-
 sound/soc/codecs/wm9712.c   | 2 +-
 sound/soc/codecs/wm9713.c   | 2 +-
 19 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 8fba0c3..d6e80a9 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2198,7 +2198,7 @@ static int max98095_suspend(struct snd_soc_codec *codec)
 	if (max98095->headphone_jack || max98095->mic_jack)
 		max98095_jack_detect_disable(codec);
 
-	max98095_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
@@ -2208,7 +2208,7 @@ static int max98095_resume(struct snd_soc_codec *codec)
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *client = to_i2c_client(codec->dev);
 
-	max98095_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	if (max98095->headphone_jack || max98095->mic_jack) {
 		max98095_jack_detect_enable(codec);
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 178e55d..d39b25c 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1939,7 +1939,7 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 
 	rt5640->codec = codec;
 
-	rt5640_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_update_bits(codec, RT5640_DUMMY1, 0x0301, 0x0301);
 	snd_soc_update_bits(codec, RT5640_MICBIAS, 0x0030, 0x0030);
@@ -1991,7 +1991,7 @@ static int rt5640_suspend(struct snd_soc_codec *codec)
 {
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 
-	rt5640_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 	rt5640_reset(codec);
 	regcache_cache_only(rt5640->regmap, true);
 	regcache_mark_dirty(rt5640->regmap);
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 61ca49f..5147ee6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2521,7 +2521,7 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
-	rt5645_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
 
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 9f4c7be..35c9725 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1625,7 +1625,7 @@ static int rt5651_probe(struct snd_soc_codec *codec)
 		RT5651_PWR_FV1 | RT5651_PWR_FV2,
 		RT5651_PWR_FV1 | RT5651_PWR_FV2);
 
-	rt5651_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9c07a0c..b428ab6 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4621,7 +4621,7 @@ static int rt5677_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(rt5677_dmic2_clk_1));
 	}
 
-	rt5677_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	regmap_write(rt5677->regmap, RT5677_DIG_MISC, 0x0020);
 	regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x0c00);
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 007a0e3..686ec76 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -970,7 +970,7 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 	if (sta32x->pdata->needs_esd_watchdog)
 		INIT_DELAYED_WORK(&sta32x->watchdog_work, sta32x_watchdog);
 
-	sta32x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 
diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index 669e322..46fc07a 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -1037,7 +1037,7 @@ static int sta350_probe(struct snd_soc_codec *codec)
 	sta350->coef_shadow[60] = 0x400000;
 	sta350->coef_shadow[61] = 0x400000;
 
-	sta350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(sta350->supplies), sta350->supplies);
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index aeec27b..9bd887e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1130,7 +1130,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	twl6040_init_chip(codec);
 
 	return 0;
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 2245b6a..00898d9 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -599,7 +599,7 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 		goto err_regulator_enable;
 	}
 
-	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
 	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index ada9ac1..40e6acb 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -560,7 +560,7 @@ static int wm8737_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8737_RIGHT_PGA_VOLUME, WM8737_RVU,
 			    WM8737_RVU);
 
-	wm8737_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8737->supplies), wm8737->supplies);
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 2eb986c..065da37 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1138,7 +1138,7 @@ static int wm8900_suspend(struct snd_soc_codec *codec)
 	wm8900->fll_out = fll_out;
 	wm8900->fll_in = fll_in;
 
-	wm8900_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
@@ -1156,7 +1156,7 @@ static int wm8900_resume(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	wm8900_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Restart the FLL? */
 	if (wm8900->fll_out) {
@@ -1189,7 +1189,7 @@ static int wm8900_probe(struct snd_soc_codec *codec)
 	wm8900_reset(codec);
 
 	/* Turn the chip on */
-	wm8900_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the volume update bits */
 	snd_soc_update_bits(codec, WM8900_REG_LINVOL, 0x100, 0x100);
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index e4142b4..4b4b997 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -707,7 +707,7 @@ static int wm8940_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	ret = snd_soc_write(codec, WM8940_POWER1, 0x180);
 	if (ret < 0)
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 00bec91..8080eab 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -929,7 +929,7 @@ static int wm8955_probe(struct snd_soc_codec *codec)
 					    WM8955_DMEN, WM8955_DMEN);
 	}
 
-	wm8955_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index cf70329..572b1bf 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -928,7 +928,7 @@ static int wm8978_suspend(struct snd_soc_codec *codec)
 {
 	struct wm8978_priv *wm8978 = snd_soc_codec_get_drvdata(codec);
 
-	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 	/* Also switch PLL off */
 	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, 0);
 
@@ -944,7 +944,7 @@ static int wm8978_resume(struct snd_soc_codec *codec)
 	/* Sync reg_cache with the hardware */
 	regcache_sync(wm8978->regmap);
 
-	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	if (wm8978->f_pllout)
 		/* Switch PLL on */
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index c93bffc..c642b3a 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1281,7 +1281,7 @@ static int wm8990_probe(struct snd_soc_codec *codec)
 	wm8990_reset(codec);
 
 	/* charge output caps */
-	wm8990_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	snd_soc_update_bits(codec, WM8990_AUDIO_INTERFACE_4,
 			    WM8990_ALRCGPIO1, WM8990_ALRCGPIO1);
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 2e70a270..b8385ac 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1563,7 +1563,7 @@ static int wm8993_suspend(struct snd_soc_codec *codec)
 	wm8993->fll_fout = fll_fout;
 	wm8993->fll_fref = fll_fref;
 
-	wm8993_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
@@ -1573,7 +1573,7 @@ static int wm8993_resume(struct snd_soc_codec *codec)
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	wm8993_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Restart the FLL? */
 	if (wm8993->fll_fout) {
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 4fbc768..fedf48d 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3163,7 +3163,7 @@ static int wm8994_codec_suspend(struct snd_soc_codec *codec)
 				 i + 1, ret);
 	}
 
-	wm8994_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 98c9525..9119a77 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -646,7 +646,7 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	if (ret == 0) {
 		/* Sync reg_cache with the hardware after cold reset */
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 7955295..39c3e71 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1201,7 +1201,7 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	wm9713_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* do we need to re-start the PLL ? */
 	if (wm9713->pll_in)
-- 
1.8.0
