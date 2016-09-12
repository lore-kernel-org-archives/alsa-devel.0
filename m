From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7219: Support HP detect procedure when MCLK not
 present
Date: Mon, 12 Sep 2016 16:46:50 +0100
Message-ID: <20160912154650.F1EAF3FA9D@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

Currently the driver code assumes that MCLK will be present during
the procedure, or if it has control of MCLK then it can make sure
it's enabled. Some platforms however do not provide MCLK to the
driver in this way, and will not leave MCLK enabled when Codec is
in STANDBY state.

This patch adds support for the HP detect procedure when running
from the device's internal oscillator, to ensure all platforms
can make use of this feature correctly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219-aad.c | 34 ++++++++++++++++++++++++++++++++--
 sound/soc/codecs/da7219-aad.h |  6 ++++--
 sound/soc/codecs/da7219.h     |  2 ++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 4e369a1..fc27dab 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -115,7 +115,7 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 
 	u16 tonegen_freq_hptest;
-	u8 accdet_cfg8;
+	u8 pll_srm_sts, gain_ramp_ctrl, accdet_cfg8;
 	int report = 0, ret = 0;
 
 	/* Lock DAPM and any Kcontrols that are affected by this test */
@@ -133,6 +133,20 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 		}
 	}
 
+	/*
+	 * If MCLK not present, then we're using the internal oscillator and
+	 * require different frequency settings to achieve the same result.
+	 */
+	pll_srm_sts = snd_soc_read(codec, DA7219_PLL_SRM_STS);
+	if (pll_srm_sts & DA7219_PLL_SRM_STS_MCLK)
+		tonegen_freq_hptest = cpu_to_le16(DA7219_AAD_HPTEST_RAMP_FREQ);
+	else
+		tonegen_freq_hptest = cpu_to_le16(DA7219_AAD_HPTEST_RAMP_FREQ_INT_OSC);
+
+	/* Ensure gain ramping at fastest rate */
+	gain_ramp_ctrl = snd_soc_read(codec, DA7219_GAIN_RAMP_CTRL);
+	snd_soc_write(codec, DA7219_GAIN_RAMP_CTRL, DA7219_GAIN_RAMP_RATE_X8);
+
 	/* Bypass cache so it saves current settings */
 	regcache_cache_bypass(da7219->regmap, true);
 
@@ -195,9 +209,15 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	snd_soc_write(codec, DA7219_HP_R_CTRL,
 		      DA7219_HP_R_AMP_OE_MASK | DA7219_HP_R_AMP_EN_MASK);
 
+	/*
+	 * If we're running from the internal oscillator then give audio paths
+	 * time to settle before running test.
+	 */
+	if (!(pll_srm_sts & DA7219_PLL_SRM_STS_MCLK))
+		msleep(DA7219_AAD_HPTEST_INT_OSC_PATH_DELAY);
+
 	/* Configure & start Tone Generator */
 	snd_soc_write(codec, DA7219_TONE_GEN_ON_PER, DA7219_BEEP_ON_PER_MASK);
-	tonegen_freq_hptest = cpu_to_le16(DA7219_AAD_HPTEST_RAMP_FREQ);
 	regmap_raw_write(da7219->regmap, DA7219_TONE_GEN_FREQ1_L,
 			 &tonegen_freq_hptest, sizeof(tonegen_freq_hptest));
 	snd_soc_update_bits(codec, DA7219_TONE_GEN_CFG2,
@@ -256,6 +276,16 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	snd_soc_update_bits(codec, DA7219_ACCDET_CONFIG_8,
 			    DA7219_HPTEST_EN_MASK, 0);
 
+	/*
+	 * If we're running from the internal oscillator then give audio paths
+	 * time to settle before allowing headphones to be driven as required.
+	 */
+	if (!(pll_srm_sts & DA7219_PLL_SRM_STS_MCLK))
+		msleep(DA7219_AAD_HPTEST_INT_OSC_PATH_DELAY);
+
+	/* Restore gain ramping rate */
+	snd_soc_write(codec, DA7219_GAIN_RAMP_CTRL, gain_ramp_ctrl);
+
 	/* Drive Headphones/lineout */
 	snd_soc_update_bits(codec, DA7219_HP_L_CTRL, DA7219_HP_L_AMP_OE_MASK,
 			    DA7219_HP_L_AMP_OE_MASK);
diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
index 4fccf67..a34be48 100644
--- a/sound/soc/codecs/da7219-aad.h
+++ b/sound/soc/codecs/da7219-aad.h
@@ -176,8 +176,10 @@
 #define DA7219_AAD_MICBIAS_CHK_DELAY	10
 #define DA7219_AAD_MICBIAS_CHK_RETRIES	5
 
-#define DA7219_AAD_HPTEST_RAMP_FREQ	0x28
-#define DA7219_AAD_HPTEST_PERIOD	65
+#define DA7219_AAD_HPTEST_RAMP_FREQ		0x28
+#define DA7219_AAD_HPTEST_RAMP_FREQ_INT_OSC	0x4D
+#define DA7219_AAD_HPTEST_PERIOD		65
+#define DA7219_AAD_HPTEST_INT_OSC_PATH_DELAY	20
 
 enum da7219_aad_event_regs {
 	DA7219_AAD_IRQ_REG_A = 0,
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index ff2a2f0..545576d 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -224,6 +224,7 @@
 #define DA7219_PLL_SRM_STATE_MASK	(0xF << 0)
 #define DA7219_PLL_SRM_STATUS_SHIFT	4
 #define DA7219_PLL_SRM_STATUS_MASK	(0xF << 4)
+#define DA7219_PLL_SRM_STS_MCLK		(0x1 << 4)
 #define DA7219_PLL_SRM_STS_SRM_LOCK	(0x1 << 7)
 
 /* DA7219_DIG_ROUTING_DAI = 0x2A */
@@ -576,6 +577,7 @@
 /* DA7219_GAIN_RAMP_CTRL = 0x92 */
 #define DA7219_GAIN_RAMP_RATE_SHIFT	0
 #define DA7219_GAIN_RAMP_RATE_MASK	(0x3 << 0)
+#define DA7219_GAIN_RAMP_RATE_X8	(0x0 << 0)
 #define DA7219_GAIN_RAMP_RATE_MAX	4
 
 /* DA7219_PC_COUNT = 0x94 */
-- 
1.9.3
