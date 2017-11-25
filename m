From: Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH] ALSA: ice1724: Fix resume issues with Prodigy 7.1 HiFi
Date: Sat, 25 Nov 2017 23:31:08 +0100
Message-ID: <20171125223108.16814-1-dev@pp3345.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Yussuf Khalil <dev@pp3345.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There are two issues after resuming from suspend on the
Audiotrak Prodigy 7.1 HiFi:
 - the output volume is set to 100%
 - microphone input isn't working anymore

This patch fixes these issues by reinitializing both codecs of the device
and restoring the previous volumes during resume.

Signed-off-by: Yussuf Khalil <dev@pp3345.net>
---
 sound/pci/ice1712/prodigy_hifi.c | 131 ++++++++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 29 deletions(-)

diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index 2697402b5195..8dabd4d0211d 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -965,13 +965,32 @@ static int prodigy_hd2_add_controls(struct snd_ice1712 *ice)
 	return 0;
 }
 
+static void wm8766_init(struct snd_ice1712 *ice)
+{
+	static unsigned short wm8766_inits[] = {
+		WM8766_RESET,	   0x0000,
+		WM8766_DAC_CTRL,	0x0120,
+		WM8766_INT_CTRL,	0x0022, /* I2S Normal Mode, 24 bit */
+		WM8766_DAC_CTRL2,       0x0001,
+		WM8766_DAC_CTRL3,       0x0080,
+		WM8766_LDA1,	    0x0100,
+		WM8766_LDA2,	    0x0100,
+		WM8766_LDA3,	    0x0100,
+		WM8766_RDA1,	    0x0100,
+		WM8766_RDA2,	    0x0100,
+		WM8766_RDA3,	    0x0100,
+		WM8766_MUTE1,	   0x0000,
+		WM8766_MUTE2,	   0x0000,
+	};
+	unsigned int i;
 
-/*
- * initialize the chip
- */
-static int prodigy_hifi_init(struct snd_ice1712 *ice)
+	for (i = 0; i < ARRAY_SIZE(wm8766_inits); i += 2)
+		wm8766_spi_write(ice, wm8766_inits[i], wm8766_inits[i + 1]);
+}
+
+static void wm8776_init(struct snd_ice1712 *ice)
 {
-	static unsigned short wm_inits[] = {
+	static unsigned short wm8776_inits[] = {
 		/* These come first to reduce init pop noise */
 		WM_ADC_MUX,	0x0003,	/* ADC mute */
 		/* 0x00c0 replaced by 0x0003 */
@@ -982,7 +1001,76 @@ static int prodigy_hifi_init(struct snd_ice1712 *ice)
 		WM_POWERDOWN,	0x0008,	/* All power-up except HP */
 		WM_RESET,	0x0000,	/* reset */
 	};
-	static unsigned short wm_inits2[] = {
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(wm8776_inits); i += 2)
+		wm_put(ice, wm8776_inits[i], wm8776_inits[i + 1]);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int prodigy_hifi_resume(struct snd_ice1712 *ice)
+{
+	static unsigned short wm8776_reinit_registers[] = {
+		WM_MASTER_CTRL,
+		WM_DAC_INT,
+		WM_ADC_INT,
+		WM_OUT_MUX,
+		WM_HP_ATTEN_L,
+		WM_HP_ATTEN_R,
+		WM_PHASE_SWAP,
+		WM_DAC_CTRL2,
+		WM_ADC_ATTEN_L,
+		WM_ADC_ATTEN_R,
+		WM_ALC_CTRL1,
+		WM_ALC_CTRL2,
+		WM_ALC_CTRL3,
+		WM_NOISE_GATE,
+		WM_ADC_MUX,
+		/* no DAC attenuation here */
+	};
+	struct prodigy_hifi_spec *spec = ice->spec;
+	int i, ch;
+
+	mutex_lock(&ice->gpio_mutex);
+
+	/* reinitialize WM8776 and re-apply old register values */
+	wm8776_init(ice);
+	schedule_timeout_uninterruptible(1);
+	for (i = 0; i < ARRAY_SIZE(wm8776_reinit_registers); i++)
+		wm_put(ice, wm8776_reinit_registers[i],
+		       wm_get(ice, wm8776_reinit_registers[i]));
+
+	/* reinitialize WM8766 and re-apply volumes for all DACs */
+	wm8766_init(ice);
+	for (ch = 0; ch < 2; ch++) {
+		wm_set_vol(ice, WM_DAC_ATTEN_L + ch,
+			   spec->vol[2 + ch], spec->master[ch]);
+
+		wm8766_set_vol(ice, WM8766_LDA1 + ch,
+			       spec->vol[0 + ch], spec->master[ch]);
+
+		wm8766_set_vol(ice, WM8766_LDA2 + ch,
+			       spec->vol[4 + ch], spec->master[ch]);
+
+		wm8766_set_vol(ice, WM8766_LDA3 + ch,
+			       spec->vol[6 + ch], spec->master[ch]);
+	}
+
+	/* unmute WM8776 DAC */
+	wm_put(ice, WM_DAC_MUTE, 0x00);
+	wm_put(ice, WM_DAC_CTRL1, 0x90);
+
+	mutex_unlock(&ice->gpio_mutex);
+	return 0;
+}
+#endif
+
+/*
+ * initialize the chip
+ */
+static int prodigy_hifi_init(struct snd_ice1712 *ice)
+{
+	static unsigned short wm8776_defaults[] = {
 		WM_MASTER_CTRL,  0x0022, /* 256fs, slave mode */
 		WM_DAC_INT,	0x0022,	/* I2S, normal polarity, 24bit */
 		WM_ADC_INT,	0x0022,	/* I2S, normal polarity, 24bit */
@@ -1010,22 +1098,6 @@ static int prodigy_hifi_init(struct snd_ice1712 *ice)
 		WM_DAC_MUTE,	0x0000,	/* DAC unmute */
 		WM_ADC_MUX,	0x0003,	/* ADC unmute, both CD/Line On */
 	};
-	static unsigned short wm8766_inits[] = {
-		WM8766_RESET,	   0x0000,
-		WM8766_DAC_CTRL,	0x0120,
-		WM8766_INT_CTRL,	0x0022, /* I2S Normal Mode, 24 bit */
-		WM8766_DAC_CTRL2,       0x0001,
-		WM8766_DAC_CTRL3,       0x0080,
-		WM8766_LDA1,	    0x0100,
-		WM8766_LDA2,	    0x0100,
-		WM8766_LDA3,	    0x0100,
-		WM8766_RDA1,	    0x0100,
-		WM8766_RDA2,	    0x0100,
-		WM8766_RDA3,	    0x0100,
-		WM8766_MUTE1,	   0x0000,
-		WM8766_MUTE2,	   0x0000,
-	};
-
 	struct prodigy_hifi_spec *spec;
 	unsigned int i;
 
@@ -1052,16 +1124,17 @@ static int prodigy_hifi_init(struct snd_ice1712 *ice)
 	ice->spec = spec;
 
 	/* initialize WM8776 codec */
-	for (i = 0; i < ARRAY_SIZE(wm_inits); i += 2)
-		wm_put(ice, wm_inits[i], wm_inits[i+1]);
+	wm8776_init(ice);
 	schedule_timeout_uninterruptible(1);
-	for (i = 0; i < ARRAY_SIZE(wm_inits2); i += 2)
-		wm_put(ice, wm_inits2[i], wm_inits2[i+1]);
+	for (i = 0; i < ARRAY_SIZE(wm8776_defaults); i += 2)
+		wm_put(ice, wm8776_defaults[i], wm8776_defaults[i + 1]);
 
-	/* initialize WM8766 codec */
-	for (i = 0; i < ARRAY_SIZE(wm8766_inits); i += 2)
-		wm8766_spi_write(ice, wm8766_inits[i], wm8766_inits[i+1]);
+	wm8766_init(ice);
 
+#ifdef CONFIG_PM_SLEEP
+	ice->pm_resume = &prodigy_hifi_resume;
+	ice->pm_suspend_enabled = 1;
+#endif
 
 	return 0;
 }
-- 
2.14.3
