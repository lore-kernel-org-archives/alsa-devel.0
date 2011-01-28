From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 3/3] ASoC: sn95031 codec - adding jack
	detection/reporting
Date: Fri, 28 Jan 2011 22:41:00 +0530
Message-ID: <1296234660-6727-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 192E62433B
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 17:56:29 +0100 (CET)
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
Cc: Harsha Priya <priya.harsha@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds the jack detection logic in sn95031 codec.
This also adds code for reading the ADC to figure out the
mic bias and therby report jack type detected

Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/sn95031.c |  197 +++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/sn95031.h |   45 ++++++++++
 2 files changed, 232 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 593632c..3fd2289 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -27,6 +27,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/input.h>
 #include <asm/intel_scu_ipc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -38,12 +39,130 @@
 #define SN95031_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100)
 #define SN95031_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
 
+/* adc helper functions */
+
+/* enables mic bias voltage */
+void sn95031_enable_mic_bias(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, SN95031_VAUD, BIT(2)|BIT(1)|BIT(0));
+	snd_soc_update_bits(codec, SN95031_MICBIAS, BIT(2), BIT(2));
+}
+
+/* Enable/Disable the ADC depending on the argument */
+static void configure_adc(struct snd_soc_codec *sn95031_codec, int val)
+{
+	int value = snd_soc_read(sn95031_codec, SN95031_ADC1CNTL1);
+
+	if (val) {
+		/* Enable and start the ADC */
+		value |= (SN95031_ADC_ENBL | SN95031_ADC_START);
+		value &= (~ADC_NO_LOOP);
+	} else
+		/* Just stop the ADC */
+		value &= (~SN95031_ADC_START);
+	snd_soc_write(sn95031_codec, SN95031_ADC1CNTL1, value);
+}
+
 /*
- * todo:
- * capture paths
- * jack detection
- * PM functions
+ * finds an empty channel for conversion
+ * If the ADC is not enabled then start using 0th channel
+ * itself. Otherwise find an empty channel by looking for a
+ * channel in which the stopbit is set to 1. returns the index
+ * of the first free channel if succeeds or an error code.
+ *
+ * Context: can sleep
+ *
  */
+static int find_free_channel(struct snd_soc_codec *sn95031_codec)
+{
+	int ret = 0, i, value;
+
+	/* check whether ADC is enabled */
+	value = snd_soc_read(sn95031_codec, SN95031_ADC1CNTL1);
+
+	if ((value & SN95031_ADC_ENBL) == 0)
+		return 0;
+
+	/* ADC is already enabled; Looking for an empty channel */
+	for (i = 0; i < ADC_CHANLS_MAX; i++) {
+		value = snd_soc_read(sn95031_codec, ADC_CHNL_START_ADDR + i);
+		if (value & SN95031_STOPBIT_MASK) {
+			ret = i;
+			break;
+		}
+	}
+	return (ret > ADC_LOOP_MAX) ? (-EINVAL) : ret;
+}
+
+/* Initialize the ADC for reading thermistor values. Can sleep. */
+static int sn95031_initialize_adc(struct snd_soc_codec *sn95031_codec)
+{
+	int base_addr, chnl_addr;
+	int value;
+	static int channel_index;
+
+	/* Index of the first channel in which the stop bit is set */
+	channel_index = find_free_channel(sn95031_codec);
+	if (channel_index < 0) {
+		pr_err("No free ADC channels");
+		return channel_index;
+	}
+
+	base_addr = ADC_CHNL_START_ADDR + channel_index;
+
+	if (!(channel_index == 0 || channel_index == ADC_LOOP_MAX)) {
+		/* Reset stop bit for channels other than 0 and 12 */
+		value = snd_soc_read(sn95031_codec, base_addr);
+		/* Set the stop bit to zero */
+		snd_soc_write(sn95031_codec, base_addr, value & 0xEF);
+		/* Index of the first free channel */
+		base_addr++;
+		channel_index++;
+	}
+
+	/* Since this is the last channel, set the stop bit
+	   to 1 by ORing the DIE_SENSOR_CODE with 0x10 */
+	snd_soc_write(sn95031_codec, base_addr, AUDIO_DETECT_CODE | 0x10);
+
+	chnl_addr = ADC_DATA_START_ADDR + 2 * channel_index;
+	pr_debug("mid_initialize : %x", chnl_addr);
+	configure_adc(sn95031_codec, 1);
+	return chnl_addr;
+}
+
+
+/* reads the ADC registers and gets the mic bias value in mV. */
+static unsigned int sn95031_get_mic_bias(struct snd_soc_codec *codec)
+{
+	u16 adc_adr = sn95031_initialize_adc(codec);
+	u16 adc_val1, adc_val2;
+	unsigned int mic_bias;
+
+	sn95031_enable_mic_bias(codec);
+
+	/* Enable the sound card for conversion before reading */
+	snd_soc_write(codec, SN95031_ADC1CNTL3, 0x05);
+	/* Re-toggle the RRDATARD bit */
+	snd_soc_write(codec, SN95031_ADC1CNTL3, 0x04);
+
+	/* Read the higher bits of data */
+	msleep(1000);
+	adc_val1 = snd_soc_read(codec, adc_adr);
+	adc_adr++;
+	adc_val2 = snd_soc_read(codec, adc_adr);
+
+	/* Adding lower two bits to the higher bits */
+	mic_bias = (adc_val1 << 2) + (adc_val2 & 3);
+	/* convesion into mV */
+	mic_bias = (ADC_ONE_LSB_MULTIPLIER * mic_bias) / 1000;
+	pr_debug("mic bias = %dmV\n", mic_bias);
+	return mic_bias;
+}
+EXPORT_SYMBOL_GPL(sn95031_get_mic_bias);
+
+/*end - adc helper functions */
+
+/* codec read/write functions */
 
 static inline unsigned int sn95031_read(struct snd_soc_codec *codec,
 			unsigned int reg)
@@ -69,6 +188,8 @@ static inline int sn95031_write(struct snd_soc_codec *codec,
 	return ret;
 }
 
+/* end - codec read/write functions */
+
 static int sn95031_set_vaud_bias(struct snd_soc_codec *codec,
 		enum snd_soc_bias_level level)
 {
@@ -373,6 +494,62 @@ struct snd_soc_dai_driver sn95031_dais[] = {
 },
 };
 
+int sn95031_get_headset_state(struct snd_soc_codec *codec)
+{
+	unsigned int mic_bias = sn95031_get_mic_bias(codec);
+	int jack_type = snd_soc_jack_get_type(mic_bias);
+
+	if (mic_bias >= SND_SOC_JACK_AM_HS_START &&
+			mic_bias < SND_SOC_JACK_AM_HS_END)
+		snd_soc_update_bits(codec, AUDIO_GPIO_CTRL, BIT(1), BIT(1));
+	else
+		snd_soc_update_bits(codec, AUDIO_GPIO_CTRL, BIT(1), BIT(0));
+
+	pr_debug("jack type detected = %d\n", jack_type);
+	if (jack_type == SND_JACK_HEADSET)
+		enable_jack_btn(codec);
+	return jack_type;
+}
+EXPORT_SYMBOL_GPL(sn95031_get_headset_state);
+
+void sn95031_jack_detection(struct snd_soc_jack *mfld_jack,
+		struct mfld_jack_msg_wq *jack_msg)
+{
+	unsigned int status, mask;
+	static int jack_state = SND_JACK_HEADSET;
+	struct snd_soc_codec *codec = jack_msg->codec;
+
+	if (!codec) {
+		pr_err("codec is null\n");
+		return;
+	}
+	pr_debug("interrupt id read in sram = 0x%x\n", jack_msg->intr_id);
+	if (jack_msg->intr_id & 0x1) {
+		pr_debug("short_push detected\n");
+		mask = status = SND_JACK_BTN_0;
+	} else if (jack_msg->intr_id & 0x2) {
+		pr_debug("long_push detected\n");
+		mask = status = SND_JACK_BTN_1;
+	} else if (jack_msg->intr_id & 0x4) {
+		mask = status = sn95031_get_headset_state(codec);
+		jack_state = mask;
+	} else if (jack_msg->intr_id & 0x8) {
+		pr_debug("headset or headphones removed\n");
+		status = 0;
+		mask = jack_state;
+		disable_jack_btn(codec);
+	} else {
+		pr_err("unidentified interrupt\n");
+		return;
+	}
+
+	snd_soc_jack_report(mfld_jack, status, mask);
+	/*button pressed and released */
+	if (status == SND_JACK_BTN_0 || status == SND_JACK_BTN_1)
+		snd_soc_jack_report(mfld_jack, 0, mask);
+}
+EXPORT_SYMBOL_GPL(sn95031_jack_detection);
+
 /* codec registration */
 static int sn95031_codec_probe(struct snd_soc_codec *codec)
 {
@@ -443,18 +620,18 @@ static int sn95031_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct snd_soc_codec_driver sn95031_codec = {
-	.probe		= sn95031_codec_probe,
-	.remove		= sn95031_codec_remove,
-	.read		= sn95031_read,
-	.write		= sn95031_write,
+struct snd_soc_codec_driver sn95031_soc_codec = {
+	.probe = sn95031_codec_probe,
+	.remove = sn95031_codec_remove,
+	.read = sn95031_read,
+	.write = sn95031_write,
 	.set_bias_level	= sn95031_set_vaud_bias,
 };
 
 static int __devinit sn95031_device_probe(struct platform_device *pdev)
 {
 	pr_debug("codec device probe called for %s\n", dev_name(&pdev->dev));
-	return snd_soc_register_codec(&pdev->dev, &sn95031_codec,
+	return snd_soc_register_codec(&pdev->dev, &sn95031_soc_codec,
 			sn95031_dais, ARRAY_SIZE(sn95031_dais));
 }
 
diff --git a/sound/soc/codecs/sn95031.h b/sound/soc/codecs/sn95031.h
index e2b17d9..d808cff 100644
--- a/sound/soc/codecs/sn95031.h
+++ b/sound/soc/codecs/sn95031.h
@@ -1,3 +1,4 @@
+
 /*
  *  sn95031.h - TI sn95031 Codec driver
  *
@@ -25,6 +26,7 @@
  */
 #ifndef _SN95031_H
 #define _SN95031_H
+#include <sound/jack.h>
 
 /*register map*/
 #define SN95031_VAUD			0xDB
@@ -96,4 +98,47 @@
 #define SN95031_SSR5			0x384
 #define SN95031_SSR6			0x385
 
+/* ADC registers */
+
+#define SN95031_ADC1CNTL1 0x1C0
+#define SN95031_ADC_ENBL 0x10
+#define SN95031_ADC_START 0x08
+#define SN95031_ADC1CNTL3 0x1C2
+#define SN95031_ADCTHERM_ENBL 0x04
+#define SN95031_ADCRRDATA_ENBL 0x05
+#define SN95031_STOPBIT_MASK 16
+#define SN95031_ADCTHERM_MASK 4
+#define ADC_CHANLS_MAX 15 /* Number of ADC channels */
+#define ADC_LOOP_MAX (ADC_CHANLS_MAX - 1)
+#define ADC_NO_LOOP 0x07
+
+/* ADC channel code values */
+#define AUDIO_DETECT_CODE 0x06
+#define AUDIO_GPIO_CTRL 0x070
+/* ADC base addresses */
+#define ADC_CHNL_START_ADDR 0x1C5 /* increments by 1 */
+#define ADC_DATA_START_ADDR 0x1D4  /* increments by 2 */
+/* multipier to convert to mV */
+#define ADC_ONE_LSB_MULTIPLIER 2346
+
+struct mfld_jack_msg_wq {
+	u8 intr_id;
+	struct snd_soc_codec *codec;
+	struct work_struct wq;
+};
+
+static inline void disable_jack_btn(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, SN95031_BTNCTRL2, 0x00);
+}
+
+static inline void enable_jack_btn(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, SN95031_BTNCTRL1, 0x77);
+	snd_soc_write(codec, SN95031_BTNCTRL2, 0x01);
+}
+
+extern void sn95031_jack_detection(struct snd_soc_jack *mfld_jack,
+		struct mfld_jack_msg_wq *jack_msg);
+
 #endif
-- 
1.7.3.4
