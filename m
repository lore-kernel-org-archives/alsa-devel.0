From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 41/47] ASoC: wm8994: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:11:00 +0200
Message-ID: <1433146266-1599-41-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F9E0261A95
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:31 +0200 (CEST)
In-Reply-To: <1433146266-1599-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
other manual access to codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8994.c | 58 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2d32b54..99a758a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -212,6 +212,7 @@ static int configure_aif_clock(struct snd_soc_codec *codec, int aif)
 
 static int configure_clock(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int change, new;
 
@@ -239,7 +240,7 @@ static int configure_clock(struct snd_soc_codec *codec)
 	change = snd_soc_update_bits(codec, WM8994_CLOCKING_1,
 				     WM8994_SYSCLK_SRC, new);
 	if (change)
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_sync(dapm);
 
 	wm8958_micd_set_rate(codec);
 
@@ -2492,12 +2493,12 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 			break;
 		}
 
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY)
 			active_reference(codec);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			switch (control->type) {
 			case WM8958:
 				if (control->revision == 0) {
@@ -2521,7 +2522,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 					    WM8994_LINEOUT2_DISCH);
 		}
 
-		if (codec->dapm.bias_level == SND_SOC_BIAS_PREPARE)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE)
 			active_dereference(codec);
 
 		/* MICBIAS into bypass mode on newer devices */
@@ -2541,7 +2542,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY)
 			wm8994->cur_fw = NULL;
 		break;
 	}
@@ -2552,7 +2553,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 int wm8994_vmid_mode(struct snd_soc_codec *codec, enum wm8994_vmid_mode mode)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	switch (mode) {
 	case WM8994_VMID_NORMAL:
@@ -3354,6 +3355,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		      int micbias)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994_micdet *micdet;
 	struct wm8994 *control = wm8994->wm8994;
@@ -3368,20 +3370,16 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 	case 1:
 		micdet = &wm8994->micdet[0];
 		if (jack)
-			ret = snd_soc_dapm_force_enable_pin(&codec->dapm,
-							    "MICBIAS1");
+			ret = snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
 		else
-			ret = snd_soc_dapm_disable_pin(&codec->dapm,
-						       "MICBIAS1");
+			ret = snd_soc_dapm_disable_pin(dapm, "MICBIAS1");
 		break;
 	case 2:
 		micdet = &wm8994->micdet[1];
 		if (jack)
-			ret = snd_soc_dapm_force_enable_pin(&codec->dapm,
-							    "MICBIAS1");
+			ret = snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
 		else
-			ret = snd_soc_dapm_disable_pin(&codec->dapm,
-						       "MICBIAS1");
+			ret = snd_soc_dapm_disable_pin(dapm, "MICBIAS1");
 		break;
 	default:
 		dev_warn(codec->dev, "Invalid MICBIAS %d\n", micbias);
@@ -3413,7 +3411,7 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 			    WM8994_MIC2_DET_DB_MASK | WM8994_MIC2_SHRT_DB_MASK,
 			    WM8994_MIC1_DET_DB | WM8994_MIC1_SHRT_DB);
 
-	snd_soc_dapm_sync(&codec->dapm);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
@@ -3503,6 +3501,7 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 /* Should be called with accdet_lock held */
 static void wm1811_micd_stop(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (!wm8994->jackdet)
@@ -3513,8 +3512,7 @@ static void wm1811_micd_stop(struct snd_soc_codec *codec)
 	wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_JACK);
 
 	if (wm8994->wm8994->pdata.jd_ext_cap)
-		snd_soc_dapm_disable_pin(&codec->dapm,
-					 "MICBIAS2");
+		snd_soc_dapm_disable_pin(dapm, "MICBIAS2");
 }
 
 static void wm8958_button_det(struct snd_soc_codec *codec, u16 status)
@@ -3623,14 +3621,14 @@ static void wm1811_mic_work(struct work_struct *work)
 						  mic_work.work);
 	struct wm8994 *control = wm8994->wm8994;
 	struct snd_soc_codec *codec = wm8994->hubs.codec;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	pm_runtime_get_sync(codec->dev);
 
 	/* If required for an external cap force MICBIAS on */
 	if (control->pdata.jd_ext_cap) {
-		snd_soc_dapm_force_enable_pin(&codec->dapm,
-					      "MICBIAS2");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS2");
+		snd_soc_dapm_sync(dapm);
 	}
 
 	mutex_lock(&wm8994->accdet_lock);
@@ -3662,6 +3660,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	struct wm8994_priv *wm8994 = data;
 	struct wm8994 *control = wm8994->wm8994;
 	struct snd_soc_codec *codec = wm8994->hubs.codec;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	int reg, delay;
 	bool present;
 
@@ -3722,7 +3721,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 
 	/* Turn off MICBIAS if it was on for an external cap */
 	if (control->pdata.jd_ext_cap && !present)
-		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS2");
+		snd_soc_dapm_disable_pin(dapm, "MICBIAS2");
 
 	if (present)
 		snd_soc_jack_report(wm8994->micdet[0].jack,
@@ -3768,6 +3767,7 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		      wm1811_micdet_cb det_cb, void *det_cb_data,
 		      wm1811_mic_id_cb id_cb, void *id_cb_data)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 	u16 micd_lvl_sel;
@@ -3781,8 +3781,8 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 	}
 
 	if (jack) {
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "CLK_SYS");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_force_enable_pin(dapm, "CLK_SYS");
+		snd_soc_dapm_sync(dapm);
 
 		wm8994->micdet[0].jack = jack;
 
@@ -3817,7 +3817,7 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_2,
 				    WM8958_MICD_LVL_SEL_MASK, micd_lvl_sel);
 
-		WARN_ON(codec->dapm.bias_level > SND_SOC_BIAS_STANDBY);
+		WARN_ON(snd_soc_codec_get_bias_level(codec) > SND_SOC_BIAS_STANDBY);
 
 		/*
 		 * If we can use jack detection start off with that,
@@ -3844,8 +3844,8 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, 0);
 		wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_NONE);
-		snd_soc_dapm_disable_pin(&codec->dapm, "CLK_SYS");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_disable_pin(dapm, "CLK_SYS");
+		snd_soc_dapm_sync(dapm);
 	}
 
 	return 0;
@@ -3983,9 +3983,9 @@ static irqreturn_t wm8994_temp_shut(int irq, void *data)
 
 static int wm8994_codec_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm8994 *control = dev_get_drvdata(codec->dev->parent);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	unsigned int reg;
 	int ret, i;
 
@@ -4016,7 +4016,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm8994->micdet_irq = control->pdata.micdet_irq;
 
 	/* By default use idle_bias_off, will override for WM8994 */
-	codec->dapm.idle_bias_off = 1;
+	dapm->idle_bias_off = 1;
 
 	/* Set revision-specific configuration */
 	switch (control->type) {
@@ -4024,7 +4024,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		/* Single ended line outputs should have VMID on. */
 		if (!control->pdata.lineout1_diff ||
 		    !control->pdata.lineout2_diff)
-			codec->dapm.idle_bias_off = 0;
+			dapm->idle_bias_off = 0;
 
 		switch (control->revision) {
 		case 2:
-- 
2.1.4
