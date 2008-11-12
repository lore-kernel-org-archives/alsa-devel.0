From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: TLV320AIC23B Support more sample
	rates
Date: Wed, 12 Nov 2008 11:55:46 +0000
Message-ID: <1226490949-22360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081112115507.GA22288@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B8C93243D8
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 12:55:50 +0100 (CET)
In-Reply-To: <20081112115507.GA22288@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

From: Troy Kisky <troy.kisky@boundarydevices.com>

Add support for more sample rates, different crystals
and split playback/capture rates.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
Acked-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic23.c |  222 ++++++++++++++++++++++++++++++++--------
 1 files changed, 177 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 44308da..a95b538 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -37,12 +37,6 @@
 
 #define AIC23_VERSION "0.1"
 
-struct tlv320aic23_srate_reg_info {
-	u32 sample_rate;
-	u8 control;		/* SR3, SR2, SR1, SR0 and BOSR */
-	u8 divider;		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
-};
-
 /*
  * AIC23 register cache
  */
@@ -261,20 +255,151 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 };
 
-/* tlv320aic23 related */
-static const struct tlv320aic23_srate_reg_info srate_reg_info[] = {
-	{4000, 0x06, 1},	/*  4000 */
-	{8000, 0x06, 0},	/*  8000 */
-	{16000, 0x0C, 1},	/* 16000 */
-	{22050, 0x11, 1},	/* 22050 */
-	{24000, 0x00, 1},	/* 24000 */
-	{32000, 0x0C, 0},	/* 32000 */
-	{44100, 0x11, 0},	/* 44100 */
-	{48000, 0x00, 0},	/* 48000 */
-	{88200, 0x1F, 0},	/* 88200 */
-	{96000, 0x0E, 0},	/* 96000 */
+/* AIC23 driver data */
+struct aic23 {
+	struct snd_soc_codec codec;
+	int mclk;
+	int requested_adc;
+	int requested_dac;
+};
+
+/*
+ * Common Crystals used
+ * 11.2896 Mhz /128 = *88.2k  /192 = 58.8k
+ * 12.0000 Mhz /125 = *96k    /136 = 88.235K
+ * 12.2880 Mhz /128 = *96k    /192 = 64k
+ * 16.9344 Mhz /128 = 132.3k /192 = *88.2k
+ * 18.4320 Mhz /128 = 144k   /192 = *96k
+ */
+
+/*
+ * Normal BOSR 0-256/2 = 128, 1-384/2 = 192
+ * USB BOSR 0-250/2 = 125, 1-272/2 = 136
+ */
+static const int bosr_usb_divisor_table[] = {
+	128, 125, 192, 136
+};
+#define LOWER_GROUP ((1<<0) | (1<<1) | (1<<2) | (1<<3) | (1<<6) | (1<<7))
+#define UPPER_GROUP ((1<<8) | (1<<9) | (1<<10) | (1<<11)        | (1<<15))
+static const unsigned short sr_valid_mask[] = {
+	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 0*/
+	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 1*/
+	LOWER_GROUP,			/* Usb, bosr - 0*/
+	UPPER_GROUP,			/* Usb, bosr - 1*/
+};
+/*
+ * Every divisor is a factor of 11*12
+ */
+#define SR_MULT (11*12)
+#define A(x) (x) ? (SR_MULT/x) : 0
+static const unsigned char sr_adc_mult_table[] = {
+	A(2), A(2), A(12), A(12),  A(0), A(0), A(3), A(1),
+	A(2), A(2), A(11), A(11),  A(0), A(0), A(0), A(1)
+};
+static const unsigned char sr_dac_mult_table[] = {
+	A(2), A(12), A(2), A(12),  A(0), A(0), A(3), A(1),
+	A(2), A(11), A(2), A(11),  A(0), A(0), A(0), A(1)
 };
 
+static unsigned get_score(int adc, int adc_l, int adc_h, int need_adc,
+		int dac, int dac_l, int dac_h, int need_dac)
+{
+	if ((adc >= adc_l) && (adc <= adc_h) &&
+			(dac >= dac_l) && (dac <= dac_h)) {
+		int diff_adc = need_adc - adc;
+		int diff_dac = need_dac - dac;
+		return abs(diff_adc) + abs(diff_dac);
+	}
+	return UINT_MAX;
+}
+
+static int find_rate(int mclk, u32 need_adc, u32 need_dac)
+{
+	int i, j;
+	int best_i = -1;
+	int best_j = -1;
+	int best_div = 0;
+	unsigned best_score = UINT_MAX;
+	int adc_l, adc_h, dac_l, dac_h;
+
+	need_adc *= SR_MULT;
+	need_dac *= SR_MULT;
+	/*
+	 * rates given are +/- 1/32
+	 */
+	adc_l = need_adc - (need_adc >> 5);
+	adc_h = need_adc + (need_adc >> 5);
+	dac_l = need_dac - (need_dac >> 5);
+	dac_h = need_dac + (need_dac >> 5);
+	for (i = 0; i < 4; i++) {
+		int base = mclk / bosr_usb_divisor_table[i];
+		int mask = sr_valid_mask[i];
+		for (j = 0; j < 16; j++, mask >>= 1) {
+			int adc;
+			int dac;
+			int score;
+			if ((mask & 1) == 0)
+				continue;
+			adc = base * sr_adc_mult_table[j];
+			dac = base * sr_dac_mult_table[j];
+			score = get_score(adc, adc_l, adc_h, need_adc,
+					dac, dac_l, dac_h, need_dac);
+			if (best_score > score) {
+				best_score = score;
+				best_i = i;
+				best_j = j;
+				best_div = 0;
+			}
+			score = get_score((adc >> 1), adc_l, adc_h, need_adc,
+					(dac >> 1), dac_l, dac_h, need_dac);
+			/* prefer to have a /2 */
+			if ((score != UINT_MAX) && (best_score >= score)) {
+				best_score = score;
+				best_i = i;
+				best_j = j;
+				best_div = 1;
+			}
+		}
+	}
+	return (best_j << 2) | best_i | (best_div << TLV320AIC23_CLKIN_SHIFT);
+}
+
+static void get_current_sample_rates(struct snd_soc_codec *codec, int mclk,
+		u32 *sample_rate_adc, u32 *sample_rate_dac)
+{
+	int src = tlv320aic23_read_reg_cache(codec, TLV320AIC23_SRATE);
+	int sr = (src >> 2) & 0x0f;
+	int val = (mclk / bosr_usb_divisor_table[src & 3]);
+	int adc = (val * sr_adc_mult_table[sr]) / SR_MULT;
+	int dac = (val * sr_dac_mult_table[sr]) / SR_MULT;
+	if (src & TLV320AIC23_CLKIN_HALF) {
+		adc >>= 1;
+		dac >>= 1;
+	}
+	*sample_rate_adc = adc;
+	*sample_rate_dac = dac;
+}
+
+static int set_sample_rate_control(struct snd_soc_codec *codec, int mclk,
+		u32 sample_rate_adc, u32 sample_rate_dac)
+{
+	/* Search for the right sample rate */
+	int data = find_rate(mclk, sample_rate_adc, sample_rate_dac);
+	if (data < 0) {
+		printk(KERN_ERR "%s:Invalid rate %u,%u requested\n",
+				__func__, sample_rate_adc, sample_rate_dac);
+		return -EINVAL;
+	}
+	tlv320aic23_write(codec, TLV320AIC23_SRATE, data);
+	if (1) {
+		int adc, dac;
+		get_current_sample_rates(codec, mclk, &adc, &dac);
+		printk(KERN_DEBUG "actual samplerate = %u,%u reg=%x\n",
+			adc, dac, data);
+	}
+	return 0;
+}
+
 static int tlv320aic23_add_widgets(struct snd_soc_codec *codec)
 {
 	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
@@ -293,27 +418,30 @@ static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
-	u16 iface_reg, data;
-	u8 count = 0;
+	u16 iface_reg;
+	int ret;
+	struct aic23 *aic23 = container_of(codec, struct aic23, codec);
+	u32 sample_rate_adc = aic23->requested_adc;
+	u32 sample_rate_dac = aic23->requested_dac;
+	u32 sample_rate = params_rate(params);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		aic23->requested_dac = sample_rate_dac = sample_rate;
+		if (!sample_rate_adc)
+			sample_rate_adc = sample_rate;
+	} else {
+		aic23->requested_adc = sample_rate_adc = sample_rate;
+		if (!sample_rate_dac)
+			sample_rate_dac = sample_rate;
+	}
+	ret = set_sample_rate_control(codec, aic23->mclk, sample_rate_adc,
+			sample_rate_dac);
+	if (ret < 0)
+		return ret;
 
 	iface_reg =
 	    tlv320aic23_read_reg_cache(codec,
 				       TLV320AIC23_DIGT_FMT) & ~(0x03 << 2);
-
-	/* Search for the right sample rate */
-	/* Verify what happens if the rate is not supported
-	 * now it goes to 96Khz */
-	while ((srate_reg_info[count].sample_rate != params_rate(params)) &&
-	       (count < ARRAY_SIZE(srate_reg_info))) {
-		count++;
-	}
-
-	data =  (srate_reg_info[count].divider << TLV320AIC23_CLKIN_SHIFT) |
-		(srate_reg_info[count]. control << TLV320AIC23_BOSR_SHIFT) |
-		TLV320AIC23_USB_CLK_ON;
-
-	tlv320aic23_write(codec, TLV320AIC23_SRATE, data);
-
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		break;
@@ -349,12 +477,17 @@ static void tlv320aic23_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
+	struct aic23 *aic23 = container_of(codec, struct aic23, codec);
 
 	/* deactivate */
 	if (!codec->active) {
 		udelay(50);
 		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
 	}
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		aic23->requested_dac = 0;
+	else
+		aic23->requested_adc = 0;
 }
 
 static int tlv320aic23_mute(struct snd_soc_dai *dai, int mute)
@@ -422,12 +555,9 @@ static int tlv320aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				      int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-
-	switch (freq) {
-	case 12000000:
-		return 0;
-	}
-	return -EINVAL;
+	struct aic23 *aic23 = container_of(codec, struct aic23, codec);
+	aic23->mclk = freq;
+	return 0;
 }
 
 static int tlv320aic23_set_bias_level(struct snd_soc_codec *codec,
@@ -659,14 +789,15 @@ static int tlv320aic23_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec;
+	struct aic23 *aic23;
 	int ret = 0;
 
 	printk(KERN_INFO "AIC23 Audio Codec %s\n", AIC23_VERSION);
 
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
+	aic23 = kzalloc(sizeof(struct aic23), GFP_KERNEL);
+	if (aic23 == NULL)
 		return -ENOMEM;
-
+	codec = &aic23->codec;
 	socdev->codec = codec;
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -687,6 +818,7 @@ static int tlv320aic23_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
+	struct aic23 *aic23 = container_of(codec, struct aic23, codec);
 
 	if (codec->control_data)
 		tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
@@ -697,7 +829,7 @@ static int tlv320aic23_remove(struct platform_device *pdev)
 	i2c_del_driver(&tlv320aic23_i2c_driver);
 #endif
 	kfree(codec->reg_cache);
-	kfree(codec);
+	kfree(aic23);
 
 	return 0;
 }
-- 
1.5.6.5
