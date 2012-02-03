From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Add support for DAI and machine
	kcontrols.
Date: Fri,  3 Feb 2012 17:43:09 +0000
Message-ID: <1328290989-14399-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id BDCA111CDFF
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 18:43:22 +0100 (CET)
Received: by mail-ww0-f53.google.com with SMTP id dr12so3990618wgb.10
	for <alsa-devel@alsa-project.org>; Fri, 03 Feb 2012 09:43:20 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently ASoC can only add kcontrols using codec and platform component device
handles. It's also desirable to add kcontrols for DAIs (i.e. McBSP) and for
SoC card machine drivers too. This allows the kcontrol to have a direct handle to
the parent ASoC component DAI/SoC Card/Platform/Codec device and hence easily
get it's private data.

This change makes snd_soc_add_controls() static and wraps it in the folowing
calls (card and dai are new) :-

snd_soc_add_card_controls()
snd_soc_add_codec_controls()
snd_soc_add_dai_controls()
snd_soc_add_platform_controls()

This patch also does a lot of small mechanical changes in individual codec drivers
to replace snd_soc_add_controls() with snd_soc_add_codec_controls().

It also updates the McBSP DAI driver to use snd_soc_add_dai_controls().

Finally, it updates the existing machine drivers that register controls to either :-

1) Use snd_soc_add_card_controls() where no direct codec control is required.
2) Use snd_soc_add_codec_controls() where there is direct codec control.

In the case of 1) above we also update the machine drivers to get the correct
component data pointers from the kcontrol (rather than getting the machine pointer
via the codec pointer).

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h                |    6 ++-
 sound/soc/codecs/ad1836.c          |    6 +-
 sound/soc/codecs/ad1980.c          |    2 +-
 sound/soc/codecs/adau1373.c        |    4 +-
 sound/soc/codecs/ak4535.c          |    2 +-
 sound/soc/codecs/ak4642.c          |    2 +-
 sound/soc/codecs/ak4671.c          |    2 +-
 sound/soc/codecs/alc5623.c         |    8 +-
 sound/soc/codecs/alc5632.c         |    2 +-
 sound/soc/codecs/cq93vc.c          |    2 +-
 sound/soc/codecs/cs4270.c          |    2 +-
 sound/soc/codecs/cs4271.c          |    2 +-
 sound/soc/codecs/lm4857.c          |    2 +-
 sound/soc/codecs/max98088.c        |    4 +-
 sound/soc/codecs/max98095.c        |    6 +-
 sound/soc/codecs/max9877.c         |    2 +-
 sound/soc/codecs/sn95031.c         |    2 +-
 sound/soc/codecs/ssm2602.c         |    2 +-
 sound/soc/codecs/stac9766.c        |    2 +-
 sound/soc/codecs/tlv320aic23.c     |    2 +-
 sound/soc/codecs/tlv320aic26.c     |    2 +-
 sound/soc/codecs/tlv320aic32x4.c   |    2 +-
 sound/soc/codecs/tlv320aic3x.c     |    4 +-
 sound/soc/codecs/tlv320dac33.c     |    2 +-
 sound/soc/codecs/tpa6130a2.c       |    4 +-
 sound/soc/codecs/uda134x.c         |    6 +-
 sound/soc/codecs/wl1273.c          |    2 +-
 sound/soc/codecs/wm8737.c          |    2 +-
 sound/soc/codecs/wm8770.c          |    2 +-
 sound/soc/codecs/wm8904.c          |   16 +++---
 sound/soc/codecs/wm8940.c          |    2 +-
 sound/soc/codecs/wm8958-dsp2.c     |   14 ++--
 sound/soc/codecs/wm8960.c          |    2 +-
 sound/soc/codecs/wm8961.c          |    2 +-
 sound/soc/codecs/wm8962.c          |    6 +-
 sound/soc/codecs/wm8990.c          |    2 +-
 sound/soc/codecs/wm8991.c          |    2 +-
 sound/soc/codecs/wm8993.c          |    4 +-
 sound/soc/codecs/wm8994.c          |   12 ++--
 sound/soc/codecs/wm8995.c          |    2 +-
 sound/soc/codecs/wm8996.c          |    4 +-
 sound/soc/codecs/wm9081.c          |    2 +-
 sound/soc/codecs/wm9090.c          |    6 +-
 sound/soc/codecs/wm9705.c          |    2 +-
 sound/soc/codecs/wm9712.c          |    2 +-
 sound/soc/codecs/wm9713.c          |    2 +-
 sound/soc/codecs/wm_hubs.c         |    2 +-
 sound/soc/mid-x86/mfld_machine.c   |    2 +-
 sound/soc/omap/ams-delta.c         |    2 +-
 sound/soc/omap/n810.c              |   15 ++---
 sound/soc/omap/omap-mcbsp.c        |    8 +-
 sound/soc/omap/omap-mcbsp.h        |    2 +-
 sound/soc/omap/rx51.c              |   25 ++++----
 sound/soc/pxa/corgi.c              |   14 ++---
 sound/soc/pxa/magician.c           |    2 +-
 sound/soc/pxa/poodle.c             |   14 ++---
 sound/soc/pxa/tosa.c               |    2 +-
 sound/soc/samsung/neo1973_wm8753.c |    4 +-
 sound/soc/samsung/s3c24xx_simtec.c |    6 +-
 sound/soc/soc-core.c               |  108 +++++++++++++++++++++++-------------
 60 files changed, 203 insertions(+), 173 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0992dff..9e96b4b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -368,10 +368,14 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
 struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 				  void *data, char *long_name,
 				  const char *prefix);
-int snd_soc_add_controls(struct snd_soc_codec *codec,
+int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
 	const struct snd_kcontrol_new *controls, int num_controls);
+int snd_soc_add_card_controls(struct snd_soc_card *soc_card,
+	const struct snd_kcontrol_new *controls, int num_controls);
+int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
+	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 982d201..12e3b41 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -277,7 +277,7 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 	if (ad1836->type == AD1836) {
 		/* left/right diff:PGA/MUX */
 		snd_soc_write(codec, AD1836_ADC_CTRL3, 0x3A);
-		ret = snd_soc_add_controls(codec, ad1836_controls,
+		ret = snd_soc_add_codec_controls(codec, ad1836_controls,
 				ARRAY_SIZE(ad1836_controls));
 		if (ret)
 			return ret;
@@ -285,11 +285,11 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 		snd_soc_write(codec, AD1836_ADC_CTRL3, 0x00);
 	}
 
-	ret = snd_soc_add_controls(codec, ad183x_dac_controls, num_dacs * 2);
+	ret = snd_soc_add_codec_controls(codec, ad183x_dac_controls, num_dacs * 2);
 	if (ret)
 		return ret;
 
-	ret = snd_soc_add_controls(codec, ad183x_adc_controls, num_adcs);
+	ret = snd_soc_add_codec_controls(codec, ad183x_adc_controls, num_adcs);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 9bba7f8..8c39ddd 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -228,7 +228,7 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	ext_status = ac97_read(codec, AC97_EXTENDED_STATUS);
 	ac97_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);
 
-	snd_soc_add_controls(codec, ad1980_snd_ac97_controls,
+	snd_soc_add_codec_controls(codec, ad1980_snd_ac97_controls,
 				ARRAY_SIZE(ad1980_snd_ac97_controls));
 
 	return 0;
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 971ba45..51e0d05 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1259,7 +1259,7 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 				pdata->drc_setting[i]);
 		}
 
-		snd_soc_add_controls(codec, adau1373_drc_controls,
+		snd_soc_add_codec_controls(codec, adau1373_drc_controls,
 			pdata->num_drc);
 
 		val = 0;
@@ -1284,7 +1284,7 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 	}
 
 	if (!lineout_differential) {
-		snd_soc_add_controls(codec, adau1373_lineout2_controls,
+		snd_soc_add_codec_controls(codec, adau1373_lineout2_controls,
 			ARRAY_SIZE(adau1373_lineout2_controls));
 	}
 
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 9e809e05..dd15516 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -382,7 +382,7 @@ static int ak4535_probe(struct snd_soc_codec *codec)
 	/* power on device */
 	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_controls(codec, ak4535_snd_controls,
+	snd_soc_add_codec_controls(codec, ak4535_snd_controls,
 				ARRAY_SIZE(ak4535_snd_controls));
 	return 0;
 }
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 5ef70b5..16bd1e7 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -476,7 +476,7 @@ static int ak4642_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	snd_soc_add_controls(codec, ak4642_snd_controls,
+	snd_soc_add_codec_controls(codec, ak4642_snd_controls,
 			     ARRAY_SIZE(ak4642_snd_controls));
 
 	ak4642_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index a53b152..5fb7c2a 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -628,7 +628,7 @@ static int ak4671_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	snd_soc_add_controls(codec, ak4671_snd_controls,
+	snd_soc_add_codec_controls(codec, ak4671_snd_controls,
 			     ARRAY_SIZE(ak4671_snd_controls));
 
 	ak4671_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 3feee56..94089b4 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -925,22 +925,22 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 
 	switch (alc5623->id) {
 	case 0x21:
-		snd_soc_add_controls(codec, alc5621_vol_snd_controls,
+		snd_soc_add_codec_controls(codec, alc5621_vol_snd_controls,
 			ARRAY_SIZE(alc5621_vol_snd_controls));
 		break;
 	case 0x22:
-		snd_soc_add_controls(codec, alc5622_vol_snd_controls,
+		snd_soc_add_codec_controls(codec, alc5622_vol_snd_controls,
 			ARRAY_SIZE(alc5622_vol_snd_controls));
 		break;
 	case 0x23:
-		snd_soc_add_controls(codec, alc5623_vol_snd_controls,
+		snd_soc_add_codec_controls(codec, alc5623_vol_snd_controls,
 			ARRAY_SIZE(alc5623_vol_snd_controls));
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	snd_soc_add_controls(codec, alc5623_snd_controls,
+	snd_soc_add_codec_controls(codec, alc5623_snd_controls,
 			ARRAY_SIZE(alc5623_snd_controls));
 
 	snd_soc_dapm_new_controls(dapm, alc5623_dapm_widgets,
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 390e437..9b0ab2f 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -994,7 +994,7 @@ static int alc5632_probe(struct snd_soc_codec *codec)
 
 	switch (alc5632->id) {
 	case 0x5c:
-		snd_soc_add_controls(codec, alc5632_vol_snd_controls,
+		snd_soc_add_codec_controls(codec, alc5632_vol_snd_controls,
 			ARRAY_SIZE(alc5632_vol_snd_controls));
 		break;
 	default:
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 06d2ea1..064cd6a 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -157,7 +157,7 @@ static int cq93vc_probe(struct snd_soc_codec *codec)
 	codec->control_data = davinci_vc;
 
 	/* Set controls */
-	snd_soc_add_controls(codec, cq93vc_snd_controls,
+	snd_soc_add_codec_controls(codec, cq93vc_snd_controls,
 			     ARRAY_SIZE(cq93vc_snd_controls));
 
 	/* Off, with power on */
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 0555366..6baccd2 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -521,7 +521,7 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Add the non-DAPM controls */
-	ret = snd_soc_add_controls(codec, cs4270_snd_controls,
+	ret = snd_soc_add_codec_controls(codec, cs4270_snd_controls,
 				ARRAY_SIZE(cs4270_snd_controls));
 	if (ret < 0) {
 		dev_err(codec->dev, "failed to add controls\n");
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index f6fe846..bf71412 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -513,7 +513,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
-	return snd_soc_add_controls(codec, cs4271_snd_controls,
+	return snd_soc_add_codec_controls(codec, cs4271_snd_controls,
 		ARRAY_SIZE(cs4271_snd_controls));
 }
 
diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 3190392..ba4fafb 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -179,7 +179,7 @@ static int lm4857_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = lm4857->i2c;
 
-	ret = snd_soc_add_controls(codec, lm4857_controls,
+	ret = snd_soc_add_codec_controls(codec, lm4857_controls,
 			ARRAY_SIZE(lm4857_controls));
 	if (ret)
 		return ret;
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 006efcf..af7324b 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1908,7 +1908,7 @@ static void max98088_handle_eq_pdata(struct snd_soc_codec *codec)
        max98088->eq_enum.texts = max98088->eq_texts;
        max98088->eq_enum.max = max98088->eq_textcnt;
 
-       ret = snd_soc_add_controls(codec, controls, ARRAY_SIZE(controls));
+       ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
        if (ret != 0)
                dev_err(codec->dev, "Failed to add EQ control: %d\n", ret);
 }
@@ -2030,7 +2030,7 @@ static int max98088_probe(struct snd_soc_codec *codec)
 
        max98088_handle_pdata(codec);
 
-       snd_soc_add_controls(codec, max98088_snd_controls,
+       snd_soc_add_codec_controls(codec, max98088_snd_controls,
                             ARRAY_SIZE(max98088_snd_controls));
 
 err_access:
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index fcfa749..0bb511a 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1284,7 +1284,7 @@ static const struct snd_soc_dapm_route max98095_audio_map[] = {
 
 static int max98095_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_add_controls(codec, max98095_snd_controls,
+	snd_soc_add_codec_controls(codec, max98095_snd_controls,
 			     ARRAY_SIZE(max98095_snd_controls));
 
 	return 0;
@@ -1984,7 +1984,7 @@ static void max98095_handle_eq_pdata(struct snd_soc_codec *codec)
 	max98095->eq_enum.texts = max98095->eq_texts;
 	max98095->eq_enum.max = max98095->eq_textcnt;
 
-	ret = snd_soc_add_controls(codec, controls, ARRAY_SIZE(controls));
+	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
 	if (ret != 0)
 		dev_err(codec->dev, "Failed to add EQ control: %d\n", ret);
 }
@@ -2139,7 +2139,7 @@ static void max98095_handle_bq_pdata(struct snd_soc_codec *codec)
 	max98095->bq_enum.texts = max98095->bq_texts;
 	max98095->bq_enum.max = max98095->bq_textcnt;
 
-	ret = snd_soc_add_controls(codec, controls, ARRAY_SIZE(controls));
+	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
 	if (ret != 0)
 		dev_err(codec->dev, "Failed to add Biquad control: %d\n", ret);
 }
diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index dcf6f2a..3a2ba3d 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -253,7 +253,7 @@ static const struct snd_kcontrol_new max9877_controls[] = {
 /* This function is called from ASoC machine driver */
 int max9877_add_controls(struct snd_soc_codec *codec)
 {
-	return snd_soc_add_controls(codec, max9877_controls,
+	return snd_soc_add_codec_controls(codec, max9877_controls,
 			ARRAY_SIZE(max9877_controls));
 }
 EXPORT_SYMBOL_GPL(max9877_add_controls);
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index f99baa0..3a09faa 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -871,7 +871,7 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, SN95031_SSR2, 0x10);
 	snd_soc_write(codec, SN95031_SSR3, 0x40);
 
-	snd_soc_add_controls(codec, sn95031_snd_controls,
+	snd_soc_add_codec_controls(codec, sn95031_snd_controls,
 			     ARRAY_SIZE(sn95031_snd_controls));
 
 	return 0;
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 333dd98..de2b205 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -548,7 +548,7 @@ static int ssm2602_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, SSM2602_ROUT1V,
 			    ROUT1V_RLHP_BOTH, ROUT1V_RLHP_BOTH);
 
-	ret = snd_soc_add_controls(codec, ssm2602_snd_controls,
+	ret = snd_soc_add_codec_controls(codec, ssm2602_snd_controls,
 			ARRAY_SIZE(ssm2602_snd_controls));
 	if (ret)
 		return ret;
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index cc0566c..982e437 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -355,7 +355,7 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 
 	stac9766_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_controls(codec, stac9766_snd_ac97_controls,
+	snd_soc_add_codec_controls(codec, stac9766_snd_ac97_controls,
 			     ARRAY_SIZE(stac9766_snd_ac97_controls));
 
 	return 0;
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index dfa41a9..16d55f9 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -593,7 +593,7 @@ static int tlv320aic23_probe(struct snd_soc_codec *codec)
 
 	snd_soc_write(codec, TLV320AIC23_ACTIVE, 0x1);
 
-	snd_soc_add_controls(codec, tlv320aic23_snd_controls,
+	snd_soc_add_codec_controls(codec, tlv320aic23_snd_controls,
 				ARRAY_SIZE(tlv320aic23_snd_controls));
 
 	return 0;
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index a038dae..802064b 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -389,7 +389,7 @@ static int aic26_probe(struct snd_soc_codec *codec)
 
 	/* register controls */
 	dev_dbg(codec->dev, "Registering controls\n");
-	err = snd_soc_add_controls(codec, aic26_snd_controls,
+	err = snd_soc_add_codec_controls(codec, aic26_snd_controls,
 			ARRAY_SIZE(aic26_snd_controls));
 	WARN_ON(err < 0);
 
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index eb401ef..37bb248 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -679,7 +679,7 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	}
 
 	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	snd_soc_add_controls(codec, aic32x4_snd_controls,
+	snd_soc_add_codec_controls(codec, aic32x4_snd_controls,
 			     ARRAY_SIZE(aic32x4_snd_controls));
 	aic32x4_add_widgets(codec);
 
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 492f22f..400d1ec 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1426,10 +1426,10 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 			      (aic3x->setup->gpio_func[1] & 0xf) << 4);
 	}
 
-	snd_soc_add_controls(codec, aic3x_snd_controls,
+	snd_soc_add_codec_controls(codec, aic3x_snd_controls,
 			     ARRAY_SIZE(aic3x_snd_controls));
 	if (aic3x->model == AIC3X_MODEL_3007)
-		snd_soc_add_controls(codec, &aic3x_classd_amp_gain_ctrl, 1);
+		snd_soc_add_codec_controls(codec, &aic3x_classd_amp_gain_ctrl, 1);
 
 	aic3x_add_widgets(codec);
 	list_add(&aic3x->list, &reset_list);
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index f0aad26..4e679e8 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1440,7 +1440,7 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 
 	/* Only add the FIFO controls, if we have valid IRQ number */
 	if (dac33->irq >= 0)
-		snd_soc_add_controls(codec, dac33_mode_snd_controls,
+		snd_soc_add_codec_controls(codec, dac33_mode_snd_controls,
 				     ARRAY_SIZE(dac33_mode_snd_controls));
 
 err_power:
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 363b99d..6fe4aa3 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -351,10 +351,10 @@ int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	if (data->id == TPA6140A2)
-		return snd_soc_add_controls(codec, tpa6140a2_controls,
+		return snd_soc_add_codec_controls(codec, tpa6140a2_controls,
 						ARRAY_SIZE(tpa6140a2_controls));
 	else
-		return snd_soc_add_controls(codec, tpa6130a2_controls,
+		return snd_soc_add_codec_controls(codec, tpa6130a2_controls,
 						ARRAY_SIZE(tpa6130a2_controls));
 }
 EXPORT_SYMBOL_GPL(tpa6130a2_add_controls);
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 8f4f469..797b0dd 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -531,15 +531,15 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 	switch (pd->model) {
 	case UDA134X_UDA1340:
 	case UDA134X_UDA1344:
-		ret = snd_soc_add_controls(codec, uda1340_snd_controls,
+		ret = snd_soc_add_codec_controls(codec, uda1340_snd_controls,
 					ARRAY_SIZE(uda1340_snd_controls));
 	break;
 	case UDA134X_UDA1341:
-		ret = snd_soc_add_controls(codec, uda1341_snd_controls,
+		ret = snd_soc_add_codec_controls(codec, uda1341_snd_controls,
 					ARRAY_SIZE(uda1341_snd_controls));
 	break;
 	case UDA134X_UDA1345:
-		ret = snd_soc_add_controls(codec, uda1345_snd_controls,
+		ret = snd_soc_add_codec_controls(codec, uda1345_snd_controls,
 					ARRAY_SIZE(uda1345_snd_controls));
 	break;
 	default:
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 44aacf9..3d868dc 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -464,7 +464,7 @@ static int wl1273_probe(struct snd_soc_codec *codec)
 
 	snd_soc_codec_set_drvdata(codec, wl1273);
 
-	r = snd_soc_add_controls(codec, wl1273_controls,
+	r = snd_soc_add_codec_controls(codec, wl1273_controls,
 				 ARRAY_SIZE(wl1273_controls));
 	if (r)
 		kfree(wl1273);
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index ff95e62c..4fe9d19 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -599,7 +599,7 @@ static int wm8737_probe(struct snd_soc_codec *codec)
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8737->supplies), wm8737->supplies);
 
-	snd_soc_add_controls(codec, wm8737_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8737_snd_controls,
 			     ARRAY_SIZE(wm8737_snd_controls));
 	wm8737_add_widgets(codec);
 
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 19374a9..fb09d1c 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -643,7 +643,7 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 	/* mute all DACs */
 	snd_soc_update_bits(codec, WM8770_DACMUTE, 0x10, 0x10);
 
-	snd_soc_add_controls(codec, wm8770_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8770_snd_controls,
 			     ARRAY_SIZE(wm8770_snd_controls));
 	snd_soc_dapm_new_controls(&codec->dapm, wm8770_dapm_widgets,
 				  ARRAY_SIZE(wm8770_dapm_widgets));
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 14afc11..9f5f186 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1176,11 +1176,11 @@ static int wm8904_add_widgets(struct snd_soc_codec *codec)
 
 	switch (wm8904->devtype) {
 	case WM8904:
-		snd_soc_add_controls(codec, wm8904_adc_snd_controls,
+		snd_soc_add_codec_controls(codec, wm8904_adc_snd_controls,
 				     ARRAY_SIZE(wm8904_adc_snd_controls));
-		snd_soc_add_controls(codec, wm8904_dac_snd_controls,
+		snd_soc_add_codec_controls(codec, wm8904_dac_snd_controls,
 				     ARRAY_SIZE(wm8904_dac_snd_controls));
-		snd_soc_add_controls(codec, wm8904_snd_controls,
+		snd_soc_add_codec_controls(codec, wm8904_snd_controls,
 				     ARRAY_SIZE(wm8904_snd_controls));
 
 		snd_soc_dapm_new_controls(dapm, wm8904_adc_dapm_widgets,
@@ -1201,7 +1201,7 @@ static int wm8904_add_widgets(struct snd_soc_codec *codec)
 		break;
 
 	case WM8912:
-		snd_soc_add_controls(codec, wm8904_dac_snd_controls,
+		snd_soc_add_codec_controls(codec, wm8904_dac_snd_controls,
 				     ARRAY_SIZE(wm8904_dac_snd_controls));
 
 		snd_soc_dapm_new_controls(dapm, wm8904_dac_dapm_widgets,
@@ -2020,7 +2020,7 @@ static void wm8904_handle_retune_mobile_pdata(struct snd_soc_codec *codec)
 	wm8904->retune_mobile_enum.max = wm8904->num_retune_mobile_texts;
 	wm8904->retune_mobile_enum.texts = wm8904->retune_mobile_texts;
 
-	ret = snd_soc_add_controls(codec, &control, 1);
+	ret = snd_soc_add_codec_controls(codec, &control, 1);
 	if (ret != 0)
 		dev_err(codec->dev,
 			"Failed to add ReTune Mobile control: %d\n", ret);
@@ -2033,7 +2033,7 @@ static void wm8904_handle_pdata(struct snd_soc_codec *codec)
 	int ret, i;
 
 	if (!pdata) {
-		snd_soc_add_controls(codec, wm8904_eq_controls,
+		snd_soc_add_codec_controls(codec, wm8904_eq_controls,
 				     ARRAY_SIZE(wm8904_eq_controls));
 		return;
 	}
@@ -2061,7 +2061,7 @@ static void wm8904_handle_pdata(struct snd_soc_codec *codec)
 		wm8904->drc_enum.max = pdata->num_drc_cfgs;
 		wm8904->drc_enum.texts = wm8904->drc_texts;
 
-		ret = snd_soc_add_controls(codec, &control, 1);
+		ret = snd_soc_add_codec_controls(codec, &control, 1);
 		if (ret != 0)
 			dev_err(codec->dev,
 				"Failed to add DRC mode control: %d\n", ret);
@@ -2075,7 +2075,7 @@ static void wm8904_handle_pdata(struct snd_soc_codec *codec)
 	if (pdata->num_retune_mobile_cfgs)
 		wm8904_handle_retune_mobile_pdata(codec);
 	else
-		snd_soc_add_controls(codec, wm8904_eq_controls,
+		snd_soc_add_codec_controls(codec, wm8904_eq_controls,
 				     ARRAY_SIZE(wm8904_eq_controls));
 }
 
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index ae1933e..d2883af 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -717,7 +717,7 @@ static int wm8940_probe(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	ret = snd_soc_add_controls(codec, wm8940_snd_controls,
+	ret = snd_soc_add_codec_controls(codec, wm8940_snd_controls,
 			     ARRAY_SIZE(wm8940_snd_controls));
 	if (ret)
 		return ret;
diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 8d4ea43..0502c9d 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -920,11 +920,11 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 
 	wm8994->dsp_active = -1;
 
-	snd_soc_add_controls(codec, wm8958_mbc_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8958_mbc_snd_controls,
 			     ARRAY_SIZE(wm8958_mbc_snd_controls));
-	snd_soc_add_controls(codec, wm8958_vss_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8958_vss_snd_controls,
 			     ARRAY_SIZE(wm8958_vss_snd_controls));
-	snd_soc_add_controls(codec, wm8958_enh_eq_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8958_enh_eq_snd_controls,
 			     ARRAY_SIZE(wm8958_enh_eq_snd_controls));
 
 
@@ -958,7 +958,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->mbc_enum.max = pdata->num_mbc_cfgs;
 		wm8994->mbc_enum.texts = wm8994->mbc_texts;
 
-		ret = snd_soc_add_controls(wm8994->codec, control, 1);
+		ret = snd_soc_add_codec_controls(wm8994->codec, control, 1);
 		if (ret != 0)
 			dev_err(wm8994->codec->dev,
 				"Failed to add MBC mode controls: %d\n", ret);
@@ -986,7 +986,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->vss_enum.max = pdata->num_vss_cfgs;
 		wm8994->vss_enum.texts = wm8994->vss_texts;
 
-		ret = snd_soc_add_controls(wm8994->codec, control, 1);
+		ret = snd_soc_add_codec_controls(wm8994->codec, control, 1);
 		if (ret != 0)
 			dev_err(wm8994->codec->dev,
 				"Failed to add VSS mode controls: %d\n", ret);
@@ -1015,7 +1015,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->vss_hpf_enum.max = pdata->num_vss_hpf_cfgs;
 		wm8994->vss_hpf_enum.texts = wm8994->vss_hpf_texts;
 
-		ret = snd_soc_add_controls(wm8994->codec, control, 1);
+		ret = snd_soc_add_codec_controls(wm8994->codec, control, 1);
 		if (ret != 0)
 			dev_err(wm8994->codec->dev,
 				"Failed to add VSS HPFmode controls: %d\n",
@@ -1045,7 +1045,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->enh_eq_enum.max = pdata->num_enh_eq_cfgs;
 		wm8994->enh_eq_enum.texts = wm8994->enh_eq_texts;
 
-		ret = snd_soc_add_controls(wm8994->codec, control, 1);
+		ret = snd_soc_add_codec_controls(wm8994->codec, control, 1);
 		if (ret != 0)
 			dev_err(wm8994->codec->dev,
 				"Failed to add enhanced EQ controls: %d\n",
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index e5caae3..840d720 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -940,7 +940,7 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8960_LOUT2, 0x100, 0x100);
 	snd_soc_update_bits(codec, WM8960_ROUT2, 0x100, 0x100);
 
-	snd_soc_add_controls(codec, wm8960_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8960_snd_controls,
 				     ARRAY_SIZE(wm8960_snd_controls));
 	wm8960_add_widgets(codec);
 
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 4f20c72..05ea7c2 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1022,7 +1022,7 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 
 	wm8961_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_controls(codec, wm8961_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8961_snd_controls,
 				ARRAY_SIZE(wm8961_snd_controls));
 	snd_soc_dapm_new_controls(dapm, wm8961_dapm_widgets,
 				  ARRAY_SIZE(wm8961_dapm_widgets));
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index a20e2b7..3831764 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2403,13 +2403,13 @@ static int wm8962_add_widgets(struct snd_soc_codec *codec)
 	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_add_controls(codec, wm8962_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8962_snd_controls,
 			     ARRAY_SIZE(wm8962_snd_controls));
 	if (pdata && pdata->spk_mono)
-		snd_soc_add_controls(codec, wm8962_spk_mono_controls,
+		snd_soc_add_codec_controls(codec, wm8962_spk_mono_controls,
 				     ARRAY_SIZE(wm8962_spk_mono_controls));
 	else
-		snd_soc_add_controls(codec, wm8962_spk_stereo_controls,
+		snd_soc_add_codec_controls(codec, wm8962_spk_stereo_controls,
 				     ARRAY_SIZE(wm8962_spk_stereo_controls));
 
 
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index e538eda..9d24235 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1356,7 +1356,7 @@ static int wm8990_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8990_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
 	snd_soc_write(codec, WM8990_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
-	snd_soc_add_controls(codec, wm8990_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8990_snd_controls,
 				ARRAY_SIZE(wm8990_snd_controls));
 	wm8990_add_widgets(codec);
 
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 7ee40da..9ac31ba 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1297,7 +1297,7 @@ static int wm8991_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8991_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
 	snd_soc_write(codec, WM8991_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
-	snd_soc_add_controls(codec, wm8991_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8991_snd_controls,
 			     ARRAY_SIZE(wm8991_snd_controls));
 
 	snd_soc_dapm_new_controls(&codec->dapm, wm8991_dapm_widgets,
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 592f18e..045fe38 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1549,13 +1549,13 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 	if (ret != 0)
 		return ret;
 
-	snd_soc_add_controls(codec, wm8993_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8993_snd_controls,
 			     ARRAY_SIZE(wm8993_snd_controls));
 	if (wm8993->pdata.num_retune_configs != 0) {
 		dev_dbg(codec->dev, "Using ReTune Mobile\n");
 	} else {
 		dev_dbg(codec->dev, "No ReTune Mobile, using normal EQ\n");
-		snd_soc_add_controls(codec, wm8993_eq_controls,
+		snd_soc_add_codec_controls(codec, wm8993_eq_controls,
 				     ARRAY_SIZE(wm8993_eq_controls));
 	}
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 93d27b6..b0f3c8f 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2861,7 +2861,7 @@ static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 	wm8994->retune_mobile_enum.max = wm8994->num_retune_mobile_texts;
 	wm8994->retune_mobile_enum.texts = wm8994->retune_mobile_texts;
 
-	ret = snd_soc_add_controls(wm8994->codec, controls,
+	ret = snd_soc_add_codec_controls(wm8994->codec, controls,
 				   ARRAY_SIZE(controls));
 	if (ret != 0)
 		dev_err(wm8994->codec->dev,
@@ -2914,7 +2914,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		wm8994->drc_enum.max = pdata->num_drc_cfgs;
 		wm8994->drc_enum.texts = wm8994->drc_texts;
 
-		ret = snd_soc_add_controls(wm8994->codec, controls,
+		ret = snd_soc_add_codec_controls(wm8994->codec, controls,
 					   ARRAY_SIZE(controls));
 		if (ret != 0)
 			dev_err(wm8994->codec->dev,
@@ -2930,7 +2930,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 	if (pdata->num_retune_mobile_cfgs)
 		wm8994_handle_retune_mobile_pdata(wm8994);
 	else
-		snd_soc_add_controls(wm8994->codec, wm8994_eq_controls,
+		snd_soc_add_codec_controls(wm8994->codec, wm8994_eq_controls,
 				     ARRAY_SIZE(wm8994_eq_controls));
 
 	for (i = 0; i < ARRAY_SIZE(pdata->micbias); i++) {
@@ -3638,7 +3638,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm8994_handle_pdata(wm8994);
 
 	wm_hubs_add_analogue_controls(codec);
-	snd_soc_add_controls(codec, wm8994_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8994_snd_controls,
 			     ARRAY_SIZE(wm8994_snd_controls));
 	snd_soc_dapm_new_controls(dapm, wm8994_dapm_widgets,
 				  ARRAY_SIZE(wm8994_dapm_widgets));
@@ -3664,7 +3664,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		}
 		break;
 	case WM8958:
-		snd_soc_add_controls(codec, wm8958_snd_controls,
+		snd_soc_add_codec_controls(codec, wm8958_snd_controls,
 				     ARRAY_SIZE(wm8958_snd_controls));
 		snd_soc_dapm_new_controls(dapm, wm8958_dapm_widgets,
 					  ARRAY_SIZE(wm8958_dapm_widgets));
@@ -3686,7 +3686,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 
 	case WM1811:
-		snd_soc_add_controls(codec, wm8958_snd_controls,
+		snd_soc_add_codec_controls(codec, wm8958_snd_controls,
 				     ARRAY_SIZE(wm8958_snd_controls));
 		snd_soc_dapm_new_controls(dapm, wm8958_dapm_widgets,
 					  ARRAY_SIZE(wm8958_dapm_widgets));
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index c8aada5..8e397cc 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2137,7 +2137,7 @@ static int wm8995_probe(struct snd_soc_codec *codec)
 
 	wm8995_update_class_w(codec);
 
-	snd_soc_add_controls(codec, wm8995_snd_controls,
+	snd_soc_add_codec_controls(codec, wm8995_snd_controls,
 			     ARRAY_SIZE(wm8995_snd_controls));
 	snd_soc_dapm_new_controls(&codec->dapm, wm8995_dapm_widgets,
 				  ARRAY_SIZE(wm8995_dapm_widgets));
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index d8da10f..2814e26 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2763,7 +2763,7 @@ static void wm8996_retune_mobile_pdata(struct snd_soc_codec *codec)
 	wm8996->retune_mobile_enum.max = wm8996->num_retune_mobile_texts;
 	wm8996->retune_mobile_enum.texts = wm8996->retune_mobile_texts;
 
-	ret = snd_soc_add_controls(codec, controls, ARRAY_SIZE(controls));
+	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
 	if (ret != 0)
 		dev_err(codec->dev,
 			"Failed to add ReTune Mobile controls: %d\n", ret);
@@ -2961,7 +2961,7 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 	if (wm8996->pdata.num_retune_mobile_cfgs)
 		wm8996_retune_mobile_pdata(codec);
 	else
-		snd_soc_add_controls(codec, wm8996_eq_controls,
+		snd_soc_add_codec_controls(codec, wm8996_eq_controls,
 				     ARRAY_SIZE(wm8996_eq_controls));
 
 	/* If the TX LRCLK pins are not in LRCLK mode configure the
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index a6bab39..7b09b1f 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1287,7 +1287,7 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 	if (!wm9081->pdata.num_retune_configs) {
 		dev_dbg(codec->dev,
 			"No ReTune Mobile data, using normal EQ\n");
-		snd_soc_add_controls(codec, wm9081_eq_controls,
+		snd_soc_add_codec_controls(codec, wm9081_eq_controls,
 				     ARRAY_SIZE(wm9081_eq_controls));
 	}
 
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index a2b9208..e8280ee 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -433,7 +433,7 @@ static int wm9090_add_controls(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_add_controls(codec, wm9090_controls,
+	snd_soc_add_codec_controls(codec, wm9090_controls,
 			     ARRAY_SIZE(wm9090_controls));
 
 	if (wm9090->pdata.lin1_diff) {
@@ -442,7 +442,7 @@ static int wm9090_add_controls(struct snd_soc_codec *codec)
 	} else {
 		snd_soc_dapm_add_routes(dapm, audio_map_in1_se,
 					ARRAY_SIZE(audio_map_in1_se));
-		snd_soc_add_controls(codec, wm9090_in1_se_controls,
+		snd_soc_add_codec_controls(codec, wm9090_in1_se_controls,
 				     ARRAY_SIZE(wm9090_in1_se_controls));
 	}
 
@@ -452,7 +452,7 @@ static int wm9090_add_controls(struct snd_soc_codec *codec)
 	} else {
 		snd_soc_dapm_add_routes(dapm, audio_map_in2_se,
 					ARRAY_SIZE(audio_map_in2_se));
-		snd_soc_add_controls(codec, wm9090_in2_se_controls,
+		snd_soc_add_codec_controls(codec, wm9090_in2_se_controls,
 				     ARRAY_SIZE(wm9090_in2_se_controls));
 	}
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 40c92ea..cacc6a8 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -351,7 +351,7 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 	if (ret)
 		goto reset_err;
 
-	snd_soc_add_controls(codec, wm9705_snd_ac97_controls,
+	snd_soc_add_codec_controls(codec, wm9705_snd_ac97_controls,
 				ARRAY_SIZE(wm9705_snd_ac97_controls));
 
 	return 0;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index b7b31f8..7faa2d4 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -637,7 +637,7 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
 
 	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	snd_soc_add_controls(codec, wm9712_snd_ac97_controls,
+	snd_soc_add_codec_controls(codec, wm9712_snd_ac97_controls,
 				ARRAY_SIZE(wm9712_snd_ac97_controls));
 
 	return 0;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 2b8479b..2d22cc7 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1216,7 +1216,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	reg = ac97_read(codec, AC97_CD) & 0x7fff;
 	ac97_write(codec, AC97_CD, reg);
 
-	snd_soc_add_controls(codec, wm9713_snd_ac97_controls,
+	snd_soc_add_codec_controls(codec, wm9713_snd_ac97_controls,
 				ARRAY_SIZE(wm9713_snd_ac97_controls));
 
 	return 0;
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 2a61094..32a5f82 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -895,7 +895,7 @@ int wm_hubs_add_analogue_controls(struct snd_soc_codec *codec)
 			    WM8993_MIXOUTR_ZC | WM8993_MIXOUT_VU,
 			    WM8993_MIXOUTR_ZC | WM8993_MIXOUT_VU);
 
-	snd_soc_add_controls(codec, analogue_snd_controls,
+	snd_soc_add_codec_controls(codec, analogue_snd_controls,
 			     ARRAY_SIZE(analogue_snd_controls));
 
 	snd_soc_dapm_new_controls(dapm, analogue_dapm_widgets,
diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 6f77eef..2937e54 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -235,7 +235,7 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_enable_pin(dapm, "Headphones");
 	snd_soc_dapm_enable_pin(dapm, "Mic");
 
-	ret_val = snd_soc_add_controls(codec, mfld_snd_controls,
+	ret_val = snd_soc_add_codec_controls(codec, mfld_snd_controls,
 				ARRAY_SIZE(mfld_snd_controls));
 	if (ret_val) {
 		pr_err("soc_add_controls failed %d", ret_val);
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index a04a433..f406285 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -572,7 +572,7 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_disable_pin(dapm, "AGCOUT");
 
 	/* Add virtual switch */
-	ret = snd_soc_add_controls(codec, ams_delta_audio_controls,
+	ret = snd_soc_add_codec_controls(codec, ams_delta_audio_controls,
 					ARRAY_SIZE(ams_delta_audio_controls));
 	if (ret)
 		dev_warn(card->dev,
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index fc6209b..630b419 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -55,9 +55,8 @@ static int n810_spk_func;
 static int n810_jack_func;
 static int n810_dmic_func;
 
-static void n810_ext_control(struct snd_soc_codec *codec)
+static void n810_ext_control(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int hp = 0, line1l = 0;
 
 	switch (n810_jack_func) {
@@ -102,7 +101,7 @@ static int n810_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_minmax(runtime,
 				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
 
-	n810_ext_control(codec);
+	n810_ext_control(&codec->dapm);
 	return clk_enable(sys_clkout2);
 }
 
@@ -142,13 +141,13 @@ static int n810_get_spk(struct snd_kcontrol *kcontrol,
 static int n810_set_spk(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
 	if (n810_spk_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	n810_spk_func = ucontrol->value.integer.value[0];
-	n810_ext_control(codec);
+	n810_ext_control(&card->dapm);
 
 	return 1;
 }
@@ -164,13 +163,13 @@ static int n810_get_jack(struct snd_kcontrol *kcontrol,
 static int n810_set_jack(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
 	if (n810_jack_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	n810_jack_func = ucontrol->value.integer.value[0];
-	n810_ext_control(codec);
+	n810_ext_control(&card->dapm);
 
 	return 1;
 }
@@ -186,7 +185,7 @@ static int n810_get_input(struct snd_kcontrol *kcontrol,
 static int n810_set_input(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
 	if (n810_dmic_func == ucontrol->value.integer.value[0])
 		return 0;
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 0173719..1287b87 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -744,17 +744,17 @@ static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] = {
 				      omap_mcbsp3_set_st_ch1_volume),
 };
 
-int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id)
+int omap_mcbsp_st_add_controls(struct snd_soc_dai *dai)
 {
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
-	switch (mcbsp_id) {
+	switch (dai->id) {
 	case 1: /* McBSP 2 */
-		return snd_soc_add_controls(codec, omap_mcbsp2_st_controls,
+		return snd_soc_add_dai_controls(dai, omap_mcbsp2_st_controls,
 					ARRAY_SIZE(omap_mcbsp2_st_controls));
 	case 2: /* McBSP 3 */
-		return snd_soc_add_controls(codec, omap_mcbsp3_st_controls,
+		return snd_soc_add_dai_controls(dai, omap_mcbsp3_st_controls,
 					ARRAY_SIZE(omap_mcbsp3_st_controls));
 	default:
 		break;
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index 65cde9d3..476fe2a 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -59,6 +59,6 @@ enum omap_mcbsp_div {
 #define NUM_LINKS	5
 #endif
 
-int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id);
+int omap_mcbsp_st_add_controls(struct snd_soc_dai *dai);
 
 #endif
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index ad16db5..04e4d25 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -59,9 +59,8 @@ static int rx51_spk_func;
 static int rx51_dmic_func;
 static int rx51_jack_func;
 
-static void rx51_ext_control(struct snd_soc_codec *codec)
+static void rx51_ext_control(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int hp = 0, hs = 0, tvout = 0;
 
 	switch (rx51_jack_func) {
@@ -102,11 +101,11 @@ static int rx51_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = rtd->card;
 
 	snd_pcm_hw_constraint_minmax(runtime,
 				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
-	rx51_ext_control(codec);
+	rx51_ext_control(&card->dapm);
 
 	return 0;
 }
@@ -138,13 +137,13 @@ static int rx51_get_spk(struct snd_kcontrol *kcontrol,
 static int rx51_set_spk(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (rx51_spk_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	rx51_spk_func = ucontrol->value.integer.value[0];
-	rx51_ext_control(codec);
+	rx51_ext_control(&card->dapm);
 
 	return 1;
 }
@@ -184,13 +183,13 @@ static int rx51_get_input(struct snd_kcontrol *kcontrol,
 static int rx51_set_input(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (rx51_dmic_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	rx51_dmic_func = ucontrol->value.integer.value[0];
-	rx51_ext_control(codec);
+	rx51_ext_control(&card->dapm);
 
 	return 1;
 }
@@ -206,13 +205,13 @@ static int rx51_get_jack(struct snd_kcontrol *kcontrol,
 static int rx51_set_jack(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (rx51_jack_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	rx51_jack_func = ucontrol->value.integer.value[0];
-	rx51_ext_control(codec);
+	rx51_ext_control(&card->dapm);
 
 	return 1;
 }
@@ -297,7 +296,7 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "LINE1R");
 
 	/* Add RX-51 specific controls */
-	err = snd_soc_add_controls(codec, aic34_rx51_controls,
+	err = snd_soc_add_card_controls(rtd->card, aic34_rx51_controls,
 				   ARRAY_SIZE(aic34_rx51_controls));
 	if (err < 0)
 		return err;
@@ -314,7 +313,7 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 	snd_soc_limit_volume(codec, "TPA6130A2 Headphone Playback Volume", 42);
 
-	err = omap_mcbsp_st_add_controls(codec, 1);
+	err = omap_mcbsp_st_add_controls(rtd->cpu_dai);
 	if (err < 0)
 		return err;
 
@@ -335,7 +334,7 @@ static int rx51_aic34b_init(struct snd_soc_dapm_context *dapm)
 {
 	int err;
 
-	err = snd_soc_add_controls(dapm->codec, aic34_rx51_controlsb,
+	err = snd_soc_add_card_controls(dapm->card, aic34_rx51_controlsb,
 				   ARRAY_SIZE(aic34_rx51_controlsb));
 	if (err < 0)
 		return err;
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index bc21944..863367a 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -45,10 +45,8 @@
 static int corgi_jack_func;
 static int corgi_spk_func;
 
-static void corgi_ext_control(struct snd_soc_codec *codec)
+static void corgi_ext_control(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
 	/* set up jack connection */
 	switch (corgi_jack_func) {
 	case CORGI_HP:
@@ -104,7 +102,7 @@ static int corgi_startup(struct snd_pcm_substream *substream)
 	mutex_lock(&codec->mutex);
 
 	/* check the jack status at stream startup */
-	corgi_ext_control(codec);
+	corgi_ext_control(&codec->dapm);
 
 	mutex_unlock(&codec->mutex);
 
@@ -173,13 +171,13 @@ static int corgi_get_jack(struct snd_kcontrol *kcontrol,
 static int corgi_set_jack(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (corgi_jack_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	corgi_jack_func = ucontrol->value.integer.value[0];
-	corgi_ext_control(codec);
+	corgi_ext_control(&card->dapm);
 	return 1;
 }
 
@@ -193,13 +191,13 @@ static int corgi_get_spk(struct snd_kcontrol *kcontrol,
 static int corgi_set_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
 	if (corgi_spk_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	corgi_spk_func = ucontrol->value.integer.value[0];
-	corgi_ext_control(codec);
+	corgi_ext_control(&card->dapm);
 	return 1;
 }
 
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 3f7a8ec..aace19e 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -411,7 +411,7 @@ static int magician_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "VINR");
 
 	/* Add magician specific controls */
-	err = snd_soc_add_controls(codec, uda1380_magician_controls,
+	err = snd_soc_add_codec_controls(codec, uda1380_magician_controls,
 				ARRAY_SIZE(uda1380_magician_controls));
 	if (err < 0)
 		return err;
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index fd0ed10..d2cc8173 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -43,10 +43,8 @@
 static int poodle_jack_func;
 static int poodle_spk_func;
 
-static void poodle_ext_control(struct snd_soc_codec *codec)
+static void poodle_ext_control(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
 	/* set up jack connection */
 	if (poodle_jack_func == POODLE_HP) {
 		/* set = unmute headphone */
@@ -81,7 +79,7 @@ static int poodle_startup(struct snd_pcm_substream *substream)
 	mutex_lock(&codec->mutex);
 
 	/* check the jack status at stream startup */
-	poodle_ext_control(codec);
+	poodle_ext_control(&codec->dapm);
 
 	mutex_unlock(&codec->mutex);
 
@@ -152,13 +150,13 @@ static int poodle_get_jack(struct snd_kcontrol *kcontrol,
 static int poodle_set_jack(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
 	if (poodle_jack_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	poodle_jack_func = ucontrol->value.integer.value[0];
-	poodle_ext_control(codec);
+	poodle_ext_control(&card->dapm);
 	return 1;
 }
 
@@ -172,13 +170,13 @@ static int poodle_get_spk(struct snd_kcontrol *kcontrol,
 static int poodle_set_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
 	if (poodle_spk_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	poodle_spk_func = ucontrol->value.integer.value[0];
-	poodle_ext_control(codec);
+	poodle_ext_control(&card->dapm);
 	return 1;
 }
 
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 564ef08..2aec63f 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -197,7 +197,7 @@ static int tosa_ac97_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "MONOOUT");
 
 	/* add tosa specific controls */
-	err = snd_soc_add_controls(codec, tosa_controls,
+	err = snd_soc_add_codec_controls(codec, tosa_controls,
 				ARRAY_SIZE(tosa_controls));
 	if (err < 0)
 		return err;
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 7ac0ba2..e34f4e8 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -298,7 +298,7 @@ static int neo1973_gta02_wm8753_init(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_add_controls(codec, neo1973_gta02_wm8753_controls,
+	ret = snd_soc_add_card_controls(codec->card, neo1973_gta02_wm8753_controls,
 			ARRAY_SIZE(neo1973_gta02_wm8753_controls));
 	if (ret)
 		return ret;
@@ -338,7 +338,7 @@ static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 
 	/* add neo1973 specific controls */
-	ret = snd_soc_add_controls(codec, neo1973_wm8753_controls,
+	ret = snd_soc_add_card_controls(rtd->card, neo1973_wm8753_controls,
 			ARRAY_SIZE(neo1973_wm8753_controls));
 	if (ret)
 		return ret;
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index a253bcc..656d5af 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -134,18 +134,18 @@ static const struct snd_kcontrol_new amp_unmute_controls[] = {
 
 void simtec_audio_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = rtd->card;
 
 	if (pdata->amp_gpio > 0) {
 		pr_debug("%s: adding amp routes\n", __func__);
 
-		snd_soc_add_controls(codec, amp_unmute_controls,
+		snd_soc_add_card_controls(card, amp_unmute_controls,
 				     ARRAY_SIZE(amp_unmute_controls));
 	}
 
 	if (pdata->amp_gain[0] > 0) {
 		pr_debug("%s: adding amp controls\n", __func__);
-		snd_soc_add_controls(codec, amp_gain_controls,
+		snd_soc_add_card_controls(card, amp_gain_controls,
 				     ARRAY_SIZE(amp_gain_controls));
 	}
 }
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b48cf4f..cbaf595 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -992,7 +992,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	}
 
 	if (driver->controls)
-		snd_soc_add_controls(codec, driver->controls,
+		snd_soc_add_codec_controls(codec, driver->controls,
 				     driver->num_controls);
 	if (driver->dapm_routes)
 		snd_soc_dapm_add_routes(&codec->dapm, driver->dapm_routes,
@@ -1453,13 +1453,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
-	/* We should have a non-codec control add function but we don't */
 	if (card->controls)
-		snd_soc_add_controls(list_first_entry(&card->codec_dev_list,
-						      struct snd_soc_codec,
-						      card_list),
-				     card->controls,
-				     card->num_controls);
+		snd_soc_add_card_controls(card, card->controls, card->num_controls);
 
 	if (card->dapm_routes)
 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
@@ -2007,9 +2002,28 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 }
 EXPORT_SYMBOL_GPL(snd_soc_cnew);
 
+static int snd_soc_add_controls(struct snd_card *card, struct device *dev,
+	const struct snd_kcontrol_new *controls, int num_controls,
+	const char *prefix, void *data)
+{
+	int err, i;
+
+	for (i = 0; i < num_controls; i++) {
+		const struct snd_kcontrol_new *control = &controls[i];
+		err = snd_ctl_add(card, snd_soc_cnew(control, data,
+						     control->name, prefix));
+		if (err < 0) {
+			dev_err(dev, "Failed to add %s: %d\n", control->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
- * snd_soc_add_controls - add an array of controls to a codec.
- * Convienience function to add a list of controls. Many codecs were
+ * snd_soc_add_codec_controls - add an array of controls to a codec.
+ * Convenience function to add a list of controls. Many codecs were
  * duplicating this code.
  *
  * @codec: codec to add controls to
@@ -2018,31 +2032,19 @@ EXPORT_SYMBOL_GPL(snd_soc_cnew);
  *
  * Return 0 for success, else error.
  */
-int snd_soc_add_controls(struct snd_soc_codec *codec,
+int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
 	struct snd_card *card = codec->card->snd_card;
-	int err, i;
 
-	for (i = 0; i < num_controls; i++) {
-		const struct snd_kcontrol_new *control = &controls[i];
-		err = snd_ctl_add(card, snd_soc_cnew(control, codec,
-						     control->name,
-						     codec->name_prefix));
-		if (err < 0) {
-			dev_err(codec->dev, "%s: Failed to add %s: %d\n",
-				codec->name, control->name, err);
-			return err;
-		}
-	}
-
-	return 0;
+	return snd_soc_add_controls(card, codec->dev, controls, num_controls,
+			codec->name_prefix, codec);
 }
-EXPORT_SYMBOL_GPL(snd_soc_add_controls);
+EXPORT_SYMBOL_GPL(snd_soc_add_codec_controls);
 
 /**
  * snd_soc_add_platform_controls - add an array of controls to a platform.
- * Convienience function to add a list of controls.
+ * Convenience function to add a list of controls.
  *
  * @platform: platform to add controls to
  * @controls: array of controls to add
@@ -2054,23 +2056,53 @@ int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
 	struct snd_card *card = platform->card->snd_card;
-	int err, i;
 
-	for (i = 0; i < num_controls; i++) {
-		const struct snd_kcontrol_new *control = &controls[i];
-		err = snd_ctl_add(card, snd_soc_cnew(control, platform,
-				control->name, NULL));
-		if (err < 0) {
-			dev_err(platform->dev, "Failed to add %s %d\n",control->name, err);
-			return err;
-		}
-	}
-
-	return 0;
+	return snd_soc_add_controls(card, platform->dev, controls, num_controls,
+			NULL, platform);
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_platform_controls);
 
 /**
+ * snd_soc_add_card_controls - add an array of controls to a SoC card.
+ * Convenience function to add a list of controls.
+ *
+ * @soc_card: SoC card to add controls to
+ * @controls: array of controls to add
+ * @num_controls: number of elements in the array
+ *
+ * Return 0 for success, else error.
+ */
+int snd_soc_add_card_controls(struct snd_soc_card *soc_card,
+	const struct snd_kcontrol_new *controls, int num_controls)
+{
+	struct snd_card *card = soc_card->snd_card;
+
+	return snd_soc_add_controls(card, soc_card->dev, controls, num_controls,
+			NULL, soc_card);
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_card_controls);
+
+/**
+ * snd_soc_add_dai_controls - add an array of controls to a DAI.
+ * Convienience function to add a list of controls.
+ *
+ * @dai: DAI to add controls to
+ * @controls: array of controls to add
+ * @num_controls: number of elements in the array
+ *
+ * Return 0 for success, else error.
+ */
+int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
+	const struct snd_kcontrol_new *controls, int num_controls)
+{
+	struct snd_card *card = dai->card->snd_card;
+
+	return snd_soc_add_controls(card, dai->dev, controls, num_controls,
+			NULL, dai);
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_dai_controls);
+
+/**
  * snd_soc_info_enum_double - enumerated double mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
-- 
1.7.5.4
