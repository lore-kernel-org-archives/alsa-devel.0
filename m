From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: tlv320aic3x: headset/button press
	support
Date: Wed,  3 Dec 2008 13:24:54 +0000
Message-ID: <1228310694-6082-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081203132005.GA5943@rakim.wolfsonmicro.main>
	<1228310694-6082-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB6C21037F7
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 14:24:56 +0100 (CET)
In-Reply-To: <1228310694-6082-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

From: Daniel Mack <daniel@caiaq.org>

- Add aic3x_set_headset_detection() function to define the headset
  detection mode for tlv32aic3x chips
- added aic3x_button_pressed()
- Read from the real-time registers in aic3x_headset_detected() to query
  headset presence without an occured interrupt

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c |   31 +++++++++++++++++++++++++-
 sound/soc/codecs/tlv320aic3x.h |   46 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 0f4067b..341e1ad 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1018,14 +1018,41 @@ int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio)
 }
 EXPORT_SYMBOL_GPL(aic3x_get_gpio);
 
+void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
+				 int headset_debounce, int button_debounce)
+{
+	u8 val;
+
+	val = ((detect & AIC3X_HEADSET_DETECT_MASK)
+		<< AIC3X_HEADSET_DETECT_SHIFT) |
+	      ((headset_debounce & AIC3X_HEADSET_DEBOUNCE_MASK)
+		<< AIC3X_HEADSET_DEBOUNCE_SHIFT) |
+	      ((button_debounce & AIC3X_BUTTON_DEBOUNCE_MASK)
+		<< AIC3X_BUTTON_DEBOUNCE_SHIFT);
+
+	if (detect & AIC3X_HEADSET_DETECT_MASK)
+		val |= AIC3X_HEADSET_DETECT_ENABLED;
+
+	aic3x_write(codec, AIC3X_HEADSET_DETECT_CTRL_A, val);
+}
+EXPORT_SYMBOL_GPL(aic3x_set_headset_detection);
+
 int aic3x_headset_detected(struct snd_soc_codec *codec)
 {
 	u8 val;
-	aic3x_read(codec, AIC3X_RT_IRQ_FLAGS_REG, &val);
-	return (val >> 2) & 1;
+	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
+	return (val >> 4) & 1;
 }
 EXPORT_SYMBOL_GPL(aic3x_headset_detected);
 
+int aic3x_button_pressed(struct snd_soc_codec *codec)
+{
+	u8 val;
+	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
+	return (val >> 5) & 1;
+}
+EXPORT_SYMBOL_GPL(aic3x_button_pressed);
+
 #define AIC3X_RATES	SNDRV_PCM_RATE_8000_96000
 #define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 7e982ac..73e35b6 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -39,7 +39,9 @@
 #define AIC3X_OVRF_STATUS_AND_PLLR_REG	11
 /* Audio codec digital filter control register */
 #define AIC3X_CODEC_DFILT_CTRL		12
-
+/* Headset/button press detection register */
+#define AIC3X_HEADSET_DETECT_CTRL_A	13
+#define AIC3X_HEADSET_DETECT_CTRL_B	14
 /* ADC PGA Gain control registers */
 #define LADC_VOL			15
 #define RADC_VOL			16
@@ -233,7 +235,49 @@ enum {
 
 void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state);
 int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio);
+
+/* headset detection / button API */
+
+/* The AIC3x supports detection of stereo headsets (GND + left + right signal)
+ * and cellular headsets (GND + speaker output + microphone input).
+ * It is recommended to enable MIC bias for this function to work properly.
+ * For more information, please refer to the datasheet. */
+enum {
+	AIC3X_HEADSET_DETECT_OFF	= 0,
+	AIC3X_HEADSET_DETECT_STEREO	= 1,
+	AIC3X_HEADSET_DETECT_CELLULAR   = 2,
+	AIC3X_HEADSET_DETECT_BOTH	= 3
+};
+
+enum {
+	AIC3X_HEADSET_DEBOUNCE_16MS	= 0,
+	AIC3X_HEADSET_DEBOUNCE_32MS	= 1,
+	AIC3X_HEADSET_DEBOUNCE_64MS	= 2,
+	AIC3X_HEADSET_DEBOUNCE_128MS	= 3,
+	AIC3X_HEADSET_DEBOUNCE_256MS	= 4,
+	AIC3X_HEADSET_DEBOUNCE_512MS	= 5
+};
+
+enum {
+	AIC3X_BUTTON_DEBOUNCE_0MS	= 0,
+	AIC3X_BUTTON_DEBOUNCE_8MS	= 1,
+	AIC3X_BUTTON_DEBOUNCE_16MS	= 2,
+	AIC3X_BUTTON_DEBOUNCE_32MS	= 3
+};
+
+#define AIC3X_HEADSET_DETECT_ENABLED	0x80
+#define AIC3X_HEADSET_DETECT_SHIFT	5
+#define AIC3X_HEADSET_DETECT_MASK	3
+#define AIC3X_HEADSET_DEBOUNCE_SHIFT	2
+#define AIC3X_HEADSET_DEBOUNCE_MASK	7
+#define AIC3X_BUTTON_DEBOUNCE_SHIFT 	0
+#define AIC3X_BUTTON_DEBOUNCE_MASK	3
+
+/* see the enums above for valid parameters to this function */
+void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
+				 int headset_debounce, int button_debounce);
 int aic3x_headset_detected(struct snd_soc_codec *codec);
+int aic3x_button_pressed(struct snd_soc_codec *codec);
 
 struct aic3x_setup_data {
 	int i2c_bus;
-- 
1.5.6.5
