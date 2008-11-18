From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/17] ASoC: Build tlv320aic23 cleanly
Date: Tue, 18 Nov 2008 12:38:13 +0000
Message-ID: <1227011903-2825-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1227011903-2825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D57D103816
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:38:28 +0100 (CET)
In-Reply-To: <1227011903-2825-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Also merge down a couple of last minute style changes that got lost in the
shuffle.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic23.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index a95b538..c903e4f 100644
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
@@ -364,6 +365,7 @@ static int find_rate(int mclk, u32 need_adc, u32 need_dac)
 	return (best_j << 2) | best_i | (best_div << TLV320AIC23_CLKIN_SHIFT);
 }
 
+#ifdef DEBUG
 static void get_current_sample_rates(struct snd_soc_codec *codec, int mclk,
 		u32 *sample_rate_adc, u32 *sample_rate_dac)
 {
@@ -379,6 +381,7 @@ static void get_current_sample_rates(struct snd_soc_codec *codec, int mclk,
 	*sample_rate_adc = adc;
 	*sample_rate_dac = dac;
 }
+#endif
 
 static int set_sample_rate_control(struct snd_soc_codec *codec, int mclk,
 		u32 sample_rate_adc, u32 sample_rate_dac)
@@ -391,12 +394,14 @@ static int set_sample_rate_control(struct snd_soc_codec *codec, int mclk,
 		return -EINVAL;
 	}
 	tlv320aic23_write(codec, TLV320AIC23_SRATE, data);
-	if (1) {
-		int adc, dac;
+#ifdef DEBUG
+	{
+		u32 adc, dac;
 		get_current_sample_rates(codec, mclk, &adc, &dac);
 		printk(KERN_DEBUG "actual samplerate = %u,%u reg=%x\n",
 			adc, dac, data);
 	}
+#endif
 	return 0;
 }
 
-- 
1.5.6.5
