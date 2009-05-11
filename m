From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Mon, 11 May 2009 14:14:25 +0300
Message-ID: <1242040465-10835-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BE93924797
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 13:14:32 +0200 (CEST)
In-Reply-To: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, getarunks@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch fixes the - agressive - 'tuck' sound heard when
the codec goes to standby mode.

We need to wait for the ramp down completion in case of
headsetl_event:POST_PMD.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index fd392c6..c22f8d6 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -130,6 +130,8 @@ struct twl4030_priv {
 	unsigned int rate;
 	unsigned int sample_bits;
 	unsigned int channels;
+
+	unsigned int sysclk;
 };
 
 /*
@@ -586,6 +588,11 @@ static int headsetl_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
 	unsigned char hs_gain, hs_pop;
+	struct twl4030_priv *twl4030 = w->codec->private_data;
+	/* Base values for ramp delay calculation: 2^19 - 2^26 */
+	unsigned int ramp_base[] = {524288, 1048576, 2097152, 4194304,
+				    8388608, 16777216, 33554432, 67108864};
+	unsigned int ramp_delay;
 
 	/* Save the current volume */
 	hs_gain = twl4030_read_reg_cache(w->codec, TWL4030_REG_HS_GAIN_SET);
@@ -609,6 +616,12 @@ static int headsetl_event(struct snd_soc_dapm_widget *w,
 		/* Do the anti-pop/bias ramp disable according to the TRM */
 		hs_pop &= ~TWL4030_RAMP_EN;
 		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+
+		/* We need to wait RAMP_DELAY time, otherwise 'tuck' sound can
+		 * be heard on the output */
+		ramp_delay = (hs_pop & TWL4030_RAMP_DELAY) >> 2;
+		mdelay(ramp_base[ramp_delay] / twl4030->sysclk);
+
 		/* Bypass the reg_cache to mute the headset */
 		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 					hs_gain & (~0x0f),
@@ -1567,17 +1580,21 @@ static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
 	u8 infreq;
 
 	switch (freq) {
 	case 19200000:
 		infreq = TWL4030_APLL_INFREQ_19200KHZ;
+		twl4030->sysclk = 19200;
 		break;
 	case 26000000:
 		infreq = TWL4030_APLL_INFREQ_26000KHZ;
+		twl4030->sysclk = 26000;
 		break;
 	case 38400000:
 		infreq = TWL4030_APLL_INFREQ_38400KHZ;
+		twl4030->sysclk = 38400;
 		break;
 	default:
 		printk(KERN_ERR "TWL4030 set sysclk: unknown rate %d\n",
@@ -1929,6 +1946,9 @@ static int twl4030_probe(struct platform_device *pdev)
 		kfree(codec);
 		return -ENOMEM;
 	}
+	/* Set default sysclk (used by the headsetl_event callback for
+	 * pop-attenuation) */
+	twl4030->sysclk = 26000;
 
 	codec->private_data = twl4030;
 	socdev->card->codec = codec;
-- 
1.6.2.3
