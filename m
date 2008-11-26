From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] tlv320aic3x: headset/button press support
Date: Wed, 26 Nov 2008 23:07:42 +0100
Message-ID: <20081126220742.GA24648@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 803CF243A6
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 23:07:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 2F8ED7F402D
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 23:07:45 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9+dGqkgBrzrr for <alsa-devel@alsa-project.org>;
	Wed, 26 Nov 2008 23:07:42 +0100 (CET)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch adds a function to setup headset and button press detection
modes.

Also, aic3x_headset_detected() returns the value from the current state's
register rather than the interrupt cause flag so it works without an 
interrupt as well.

Best regards,
Daniel


--opJtzjQTFsWo+cga
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="tlv320aic3x-headset.diff"

Added a function to setup headset and button press detection modes. Also,
aic3x_headset_detected() returns the value from the current state's register
rather than the interrupt cause flag so it works without an interrupt as well.

Signed-off-by: Daniel Mack <daniel@caiaq.de>

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 2047c66..a41aa72 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1017,14 +1017,32 @@ int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio)
 }
 EXPORT_SYMBOL_GPL(aic3x_get_gpio);
 
+void aic3x_set_headset_detection(struct snd_soc_codec *codec, int val)
+{
+	u8 reg_a = val & 0xff;
+	if (reg_a & (3 << 5))
+		reg_a |= 0x80;
+
+	aic3x_write(codec, AIC3X_HEADSET_DETECT_CTRL_A, reg_a);
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
index 7e982ac..2f36c03 100644
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
@@ -233,7 +235,28 @@ enum {
 
 void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state);
 int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio);
+
+/* headset detection / button API, logically OR the values
+ * on calls to aic3x_set_headset_detection(). */
+#define AIC3X_HEADSET_DETECT_OFF	(0 << 5)
+#define AIC3X_HEADSET_DETECT_STEREO	(1 << 5)
+#define AIC3X_HEADSET_DETECT_CELLULAR	(2 << 5)
+#define AIC3X_HEADSET_DETECT_BOTH	(3 << 5)
+
+#define AIC3X_HEADSET_DEBOUNCE_16MS	(0 << 2)
+#define AIC3X_HEADSET_DEBOUNCE_32MS	(1 << 2)
+#define AIC3X_HEADSET_DEBOUNCE_64MS	(2 << 2)
+#define AIC3X_HEADSET_DEBOUNCE_128MS	(3 << 2)
+#define AIC3X_HEADSET_DEBOUNCE_256MS	(4 << 2)
+
+#define AIC3X_BUTTON_DEBOUNCE_0MS	(0 << 0)
+#define AIC3X_BUTTON_DEBOUNCE_8MS	(1 << 0)
+#define AIC3X_BUTTON_DEBOUNCE_16MS	(2 << 0)
+#define AIC3X_BUTTON_DEBOUNCE_32MS	(3 << 0)
+
+void aic3x_set_headset_detection(struct snd_soc_codec *codec, int val);
 int aic3x_headset_detected(struct snd_soc_codec *codec);
+int aic3x_button_pressed(struct snd_soc_codec *codec);
 
 struct aic3x_setup_data {
 	int i2c_bus;

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--opJtzjQTFsWo+cga--
