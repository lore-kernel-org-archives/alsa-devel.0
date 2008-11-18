From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/1] [ALSA] ASoc: TLV320AIC23B Cleanup
Date: Mon, 17 Nov 2008 17:30:44 -0700
Message-ID: <1226968244-13796-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-05.inet.qwest.net (mpls-qmqp-05.inet.qwest.net
	[63.231.195.116])
	by alsa0.perex.cz (Postfix) with ESMTP id C3DCF243BD
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 01:31:01 +0100 (CET)
In-Reply-To: <>
References: <>
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
Cc: broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Use #ifdef DEBUG to print actual sample rates.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index a95b538..8a9ef21 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -331,10 +331,11 @@ static int find_rate(int mclk, u32 need_adc, u32 need_dac)
 	adc_h = need_adc + (need_adc >> 5);
 	dac_l = need_dac - (need_dac >> 5);
 	dac_h = need_dac + (need_dac >> 5);
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < ARRAY_SIZE(bosr_usb_divisor_table); i++) {
 		int base = mclk / bosr_usb_divisor_table[i];
 		int mask = sr_valid_mask[i];
-		for (j = 0; j < 16; j++, mask >>= 1) {
+		for (j = 0; j < ARRAY_SIZE(sr_adc_mult_table);
+				j++, mask >>= 1) {
 			int adc;
 			int dac;
 			int score;
@@ -364,21 +365,22 @@ static int find_rate(int mclk, u32 need_adc, u32 need_dac)
 	return (best_j << 2) | best_i | (best_div << TLV320AIC23_CLKIN_SHIFT);
 }
 
-static void get_current_sample_rates(struct snd_soc_codec *codec, int mclk,
+#ifdef DEBUG
+static void get_current_sample_rates(int sample_rate_control, int mclk,
 		u32 *sample_rate_adc, u32 *sample_rate_dac)
 {
-	int src = tlv320aic23_read_reg_cache(codec, TLV320AIC23_SRATE);
-	int sr = (src >> 2) & 0x0f;
-	int val = (mclk / bosr_usb_divisor_table[src & 3]);
+	int sr = (sample_rate_control >> 2) & 0x0f;
+	int val = (mclk / bosr_usb_divisor_table[sample_rate_control & 3]);
 	int adc = (val * sr_adc_mult_table[sr]) / SR_MULT;
 	int dac = (val * sr_dac_mult_table[sr]) / SR_MULT;
-	if (src & TLV320AIC23_CLKIN_HALF) {
+	if (sample_rate_control & TLV320AIC23_CLKIN_HALF) {
 		adc >>= 1;
 		dac >>= 1;
 	}
 	*sample_rate_adc = adc;
 	*sample_rate_dac = dac;
 }
+#endif
 
 static int set_sample_rate_control(struct snd_soc_codec *codec, int mclk,
 		u32 sample_rate_adc, u32 sample_rate_dac)
@@ -391,12 +393,14 @@ static int set_sample_rate_control(struct snd_soc_codec *codec, int mclk,
 		return -EINVAL;
 	}
 	tlv320aic23_write(codec, TLV320AIC23_SRATE, data);
-	if (1) {
+#ifdef DEBUG
+	{
 		int adc, dac;
-		get_current_sample_rates(codec, mclk, &adc, &dac);
+		get_current_sample_rates(data, mclk, &adc, &dac);
 		printk(KERN_DEBUG "actual samplerate = %u,%u reg=%x\n",
 			adc, dac, data);
 	}
+#endif
 	return 0;
 }
 
-- 
1.5.4.3
