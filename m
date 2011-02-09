From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: sn95031: Add support for reading mic
	bias
Date: Wed,  9 Feb 2011 14:42:27 +0530
Message-ID: <1297242747-18632-4-git-send-email-vinod.koul@intel.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F14E103954
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 10:05:13 +0100 (CET)
In-Reply-To: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds support to read the mic bias voltage
when a jack is inserted. It uses ADC to measure.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/sn95031.c |  127 ++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/sn95031.h |   25 +++++++++
 2 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 3cd812d..a0808dd 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -40,12 +40,129 @@
 #define SN95031_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100)
 #define SN95031_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
 
+/* adc helper functions */
+
+/* enables mic bias voltage */
+static void sn95031_enable_mic_bias(struct snd_soc_codec *codec)
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
+		value &= (~SN95031_ADC_NO_LOOP);
+	} else {
+		/* Just stop the ADC */
+		value &= (~SN95031_ADC_START);
+	}
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
+	for (i = 0; i <	SN95031_ADC_CHANLS_MAX; i++) {
+		value = snd_soc_read(sn95031_codec,
+				SN95031_ADC_CHNL_START_ADDR + i);
+		if (value & SN95031_STOPBIT_MASK) {
+			ret = i;
+			break;
+		}
+	}
+	return (ret > SN95031_ADC_LOOP_MAX) ? (-EINVAL) : ret;
+}
+
+/* Initialize the ADC for reading micbias values. Can sleep. */
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
+	base_addr = SN95031_ADC_CHNL_START_ADDR + channel_index;
+
+	if (!(channel_index == 0 || channel_index ==  SN95031_ADC_LOOP_MAX)) {
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
+	snd_soc_write(sn95031_codec, base_addr,
+				SN95031_AUDIO_DETECT_CODE | 0x10);
+
+	chnl_addr = SN95031_ADC_DATA_START_ADDR + 2 * channel_index;
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
+	mic_bias = (mic_bias * SN95031_ADC_ONE_LSB_MULTIPLIER) / 1000;
+	pr_debug("mic bias = %dmV\n", mic_bias);
+	return mic_bias;
+}
+EXPORT_SYMBOL_GPL(sn95031_get_mic_bias);
+/*end - adc helper functions */
 
 static inline unsigned int sn95031_read(struct snd_soc_codec *codec,
 			unsigned int reg)
@@ -664,6 +781,8 @@ static inline void enable_jack_btn(struct snd_soc_codec *codec)
 
 static int sn95031_get_headset_state(struct snd_soc_jack *mfld_jack)
 {
+	int micbias = sn95031_get_mic_bias(mfld_jack->codec);
+
 	/* Defaulting to HEADSET for now.
 	 * will change after adding soc-jack detection apis */
 	int jack_type = SND_JACK_HEADSET;
diff --git a/sound/soc/codecs/sn95031.h b/sound/soc/codecs/sn95031.h
index 3d6f9bb..47bd6af 100644
--- a/sound/soc/codecs/sn95031.h
+++ b/sound/soc/codecs/sn95031.h
@@ -96,7 +96,31 @@
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
+#define SN95031_ADC_CHANLS_MAX 15 /* Number of ADC channels */
+#define SN95031_ADC_LOOP_MAX (SN95031_ADC_CHANLS_MAX - 1)
+#define SN95031_ADC_NO_LOOP 0x07
 #define SN95031_AUDIO_GPIO_CTRL 0x070
+
+/* ADC channel code values */
+#define SN95031_AUDIO_DETECT_CODE 0x06
+
+/* ADC base addresses */
+#define SN95031_ADC_CHNL_START_ADDR 0x1C5 /* increments by 1 */
+#define SN95031_ADC_DATA_START_ADDR 0x1D4  /* increments by 2 */
+/* multipier to convert to mV */
+#define SN95031_ADC_ONE_LSB_MULTIPLIER 2346
+
+
 struct mfld_jack_data {
 	int intr_id;
 	int micbias_vol;
@@ -106,4 +130,5 @@ struct mfld_jack_data {
 extern void sn95031_jack_detection(struct mfld_jack_data *jack_data);
 
 extern void disable_jack_btn(struct snd_soc_codec *codec);
+
 #endif
-- 
1.7.2.3
