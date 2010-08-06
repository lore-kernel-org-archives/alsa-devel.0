From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: multi-comp: twl4030: TI CODECs
Date: Fri,  6 Aug 2010 08:49:54 +0300
Message-ID: <1281073795-4364-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1281073795-4364-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BE6724389
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 07:49:56 +0200 (CEST)
In-Reply-To: <1281073795-4364-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Corrections for the twl4030 codec driver on top of the
current multi-comp branch.
Short log:
- twl4030.h header removed, since it is not needed anymore
- all codec parameters are coming from platform_data
- put back the idle_bias_off=1

This can be squashed to 'ASoC: multi-component - TI CODECs'
commit for now.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   73 +++++++++++++++++++++----------------------
 sound/soc/codecs/twl4030.h |   52 -------------------------------
 2 files changed, 36 insertions(+), 89 deletions(-)
 delete mode 100644 sound/soc/codecs/twl4030.h

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index cab013e..7bde165 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -36,7 +36,16 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include "twl4030.h"
+/* Register descriptions are here */
+#include <linux/mfd/twl4030-codec.h>
+
+/* Shadow register used by the audio driver */
+#define TWL4030_REG_SW_SHADOW		0x4A
+#define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)
+
+/* TWL4030_REG_SW_SHADOW (0x4A) Fields */
+#define TWL4030_HFL_EN			0x01
+#define TWL4030_HFR_EN			0x02
 
 /*
  * twl4030 register cache & default register settings
@@ -279,17 +288,17 @@ static inline void twl4030_reset_registers(struct snd_soc_codec *codec)
 
 static void twl4030_init_chip(struct snd_soc_codec *codec)
 {
-	struct twl4030_setup_data *setup = dev_get_platdata(codec->dev);
+	struct twl4030_codec_audio_data *pdata = dev_get_platdata(codec->dev);
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 reg, byte;
 	int i = 0;
 
 	/* Check defaults, if instructed before anything else */
-	if (setup && setup->check_defaults)
+	if (pdata && pdata->check_defaults)
 		twl4030_check_defaults(codec);
 
 	/* Reset registers, if no setup data or if instructed to do so */
-	if (!setup || (setup && setup->reset_registers))
+	if (!pdata || (pdata && pdata->reset_registers))
 		twl4030_reset_registers(codec);
 
 	/* Refresh APLL_CTL register from HW */
@@ -310,20 +319,14 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 	twl4030_write(codec, TWL4030_REG_ARXR2_APGA_CTL, 0x32);
 
 	/* Machine dependent setup */
-	if (!setup)
+	if (!pdata)
 		return;
 
-	twl4030->digimic_delay = setup->digimic_delay;
-
-	/* Configuration for headset ramp delay from setup data */
-	if (setup->sysclk != twl4030->sysclk)
-		dev_warn(codec->dev,
-				"Mismatch in APLL mclk: %u (configured: %u)\n",
-				setup->sysclk, twl4030->sysclk);
+	twl4030->digimic_delay = pdata->digimic_delay;
 
 	reg = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
 	reg &= ~TWL4030_RAMP_DELAY;
-	reg |= (setup->ramp_delay_value << 2);
+	reg |= (pdata->ramp_delay_value << 2);
 	twl4030_write_reg_cache(codec, TWL4030_REG_HS_POPN_SET, reg);
 
 	/* initiate offset cancellation */
@@ -331,7 +334,7 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 	reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
 	reg &= ~TWL4030_OFFSET_CNCL_SEL;
-	reg |= setup->offset_cncl_path;
+	reg |= pdata->offset_cncl_path;
 	twl4030_write(codec, TWL4030_REG_ANAMICL,
 		reg | TWL4030_CNCL_OFFSET_START);
 
@@ -617,7 +620,7 @@ static int micpath_event(struct snd_soc_dapm_widget *w,
 static int pin_name##pga_event(struct snd_soc_dapm_widget *w,		\
 		struct snd_kcontrol *kcontrol, int event)		\
 {									\
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec);	\
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec); \
 									\
 	switch (event) {						\
 	case SND_SOC_DAPM_POST_PMU:					\
@@ -746,7 +749,7 @@ static int aif_event(struct snd_soc_dapm_widget *w,
 
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
-	struct twl4030_codec_audio_data *setup = codec->dev->platform_data;
+	struct twl4030_codec_audio_data *pdata = codec->dev->platform_data;
 	unsigned char hs_gain, hs_pop;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	/* Base values for ramp delay calculation: 2^19 - 2^26 */
@@ -758,9 +761,9 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 
 	/* Enable external mute control, this dramatically reduces
 	 * the pop-noise */
-	if (setup && setup->hs_extmute) {
-		if (setup->set_hs_extmute) {
-			setup->set_hs_extmute(1);
+	if (pdata && pdata->hs_extmute) {
+		if (pdata->set_hs_extmute) {
+			pdata->set_hs_extmute(1);
 		} else {
 			hs_pop |= TWL4030_EXTMUTE;
 			twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
@@ -798,9 +801,9 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 	}
 
 	/* Disable external mute */
-	if (setup && setup->hs_extmute) {
-		if (setup->set_hs_extmute) {
-			setup->set_hs_extmute(0);
+	if (pdata && pdata->hs_extmute) {
+		if (pdata->set_hs_extmute) {
+			pdata->set_hs_extmute(0);
 		} else {
 			hs_pop &= ~TWL4030_EXTMUTE;
 			twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
@@ -2189,7 +2192,7 @@ static int twl4030_voice_set_tristate(struct snd_soc_dai *dai, int tristate)
 #define TWL4030_RATES	 (SNDRV_PCM_RATE_8000_48000)
 #define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE)
 
-struct snd_soc_dai_ops twl4030_dai_ops = {
+static struct snd_soc_dai_ops twl4030_dai_hifi_ops = {
 	.startup	= twl4030_startup,
 	.shutdown	= twl4030_shutdown,
 	.hw_params	= twl4030_hw_params,
@@ -2222,7 +2225,7 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 		.channels_max = 4,
 		.rates = TWL4030_RATES,
 		.formats = TWL4030_FORMATS,},
-	.ops = &twl4030_dai_ops,
+	.ops = &twl4030_dai_hifi_ops,
 },
 {
 	.name = "twl4030-voice",
@@ -2242,9 +2245,7 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 },
 };
 
-
-static int twl4030_soc_suspend(struct snd_soc_codec *codec,
-		pm_message_t state)
+static int twl4030_soc_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
@@ -2258,11 +2259,18 @@ static int twl4030_soc_resume(struct snd_soc_codec *codec)
 
 static int twl4030_soc_probe(struct snd_soc_codec *codec)
 {
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
+	struct twl4030_priv *twl4030;
 
+	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
+	if (twl4030 == NULL) {
+		printk("Can not allocate memroy\n");
+		return -ENOMEM;
+	}
+	snd_soc_codec_set_drvdata(codec, twl4030);
 	/* Set the defaults, and power up the codec */
 	twl4030->sysclk = twl4030_codec_get_mclk() / 1000;
 	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->idle_bias_off = 1;
 
 	twl4030_init_chip(codec);
 
@@ -2294,21 +2302,12 @@ static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 {
 	struct twl4030_codec_audio_data *pdata = pdev->dev.platform_data;
-	struct twl4030_priv *twl4030;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "platform_data is missing\n");
 		return -EINVAL;
 	}
 
-	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
-	if (twl4030 == NULL) {
-		dev_err(&pdev->dev, "Can not allocate memroy\n");
-		return -ENOMEM;
-	}
-
-	dev_set_drvdata(&pdev->dev, twl4030);
-
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_twl4030,
 			twl4030_dai, ARRAY_SIZE(twl4030_dai));
 }
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
deleted file mode 100644
index 12b5e4e..0000000
--- a/sound/soc/codecs/twl4030.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * ALSA SoC TWL4030 codec driver
- *
- * Author: Steve Sakoman <steve@sakoman.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __TWL4030_AUDIO_H__
-#define __TWL4030_AUDIO_H__
-
-/* Register descriptions are here */
-#include <linux/mfd/twl4030-codec.h>
-
-/* Shadow register used by the audio driver */
-#define TWL4030_REG_SW_SHADOW		0x4A
-#define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)
-
-/* TWL4030_REG_SW_SHADOW (0x4A) Fields */
-#define TWL4030_HFL_EN			0x01
-#define TWL4030_HFR_EN			0x02
-
-#define TWL4030_DAI_HIFI		0
-#define TWL4030_DAI_VOICE		1
-
-struct twl4030_setup_data {
-	unsigned int ramp_delay_value;
-	unsigned int digimic_delay; /* in ms */
-	unsigned int sysclk;
-	unsigned int offset_cncl_path;
-	unsigned int check_defaults:1;
-	unsigned int reset_registers:1;
-	unsigned int hs_extmute:1;
-	void (*set_hs_extmute)(int mute);
-};
-
-#endif	/* End of __TWL4030_AUDIO_H__ */
-
-
-- 
1.7.2
