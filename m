From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm_hubs: Special case headphones for
	digital paths in more use cases
Date: Fri, 27 Apr 2012 18:34:59 +0100
Message-ID: <1335548101-22693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CCAAC24557
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 19:35:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The optimisations which we can do with caching the headphone DCS result in
wm_hubs have only been enabled in cases where class W is enabled. However,
there are more use cases which can benefit from the cache, especially with
WM8994 series devices with their more advanced digital routing.

Rather than keying off the class W information from the CODECs have a
check in wm_hubs for a suitable path and use that to determine if we can
deploy our headphone optimisations.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c  |    2 --
 sound/soc/codecs/wm8994.c  |    4 +---
 sound/soc/codecs/wm_hubs.c |   48 ++++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/wm_hubs.h |    5 ++---
 4 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index d256a93..8bb0059 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -852,7 +852,6 @@ static int class_w_put(struct snd_kcontrol *kcontrol,
 					    0);
 		}
 		wm8993->class_w_users++;
-		wm8993->hubs_data.class_w = true;
 	}
 
 	/* Implement the change */
@@ -869,7 +868,6 @@ static int class_w_put(struct snd_kcontrol *kcontrol,
 					    WM8993_CP_DYN_V);
 		}
 		wm8993->class_w_users--;
-		wm8993->hubs_data.class_w = false;
 	}
 
 	dev_dbg(codec->dev, "Indirect DAC use count now %d\n",
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 587062b..5b7bb10 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -998,13 +998,11 @@ static void wm8994_update_class_w(struct snd_soc_codec *codec)
 				    WM8994_CP_DYN_PWR |
 				    WM8994_CP_DYN_SRC_SEL_MASK,
 				    source | WM8994_CP_DYN_PWR);
-		wm8994->hubs.class_w = true;
 
 	} else {
 		dev_dbg(codec->dev, "Class W disabled\n");
 		snd_soc_update_bits(codec, WM8994_CLASS_W_1,
 				    WM8994_CP_DYN_PWR, 0);
-		wm8994->hubs.class_w = false;
 	}
 }
 
@@ -3777,7 +3775,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		wm8994->hubs.dcs_readback_mode = 2;
 		wm8994->hubs.no_series_update = 1;
 		wm8994->hubs.hp_startup_mode = 1;
-		wm8994->hubs.no_cache_class_w = true;
+		wm8994->hubs.no_cache_dac_hp_direct = true;
 		wm8994->fll_byp = true;
 
 		switch (wm8994->revision) {
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 6c028c4..df44083 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -109,6 +109,42 @@ irqreturn_t wm_hubs_dcs_done(int irq, void *data)
 }
 EXPORT_SYMBOL_GPL(wm_hubs_dcs_done);
 
+static bool wm_hubs_dac_hp_direct(struct snd_soc_codec *codec)
+{
+	int reg;
+
+	/* If we're going via the mixer we'll need to do additional checks */
+	reg = snd_soc_read(codec, WM8993_OUTPUT_MIXER1);
+	if (!(reg & WM8993_DACL_TO_HPOUT1L)) {
+		if (reg & ~WM8993_DACL_TO_MIXOUTL) {
+			dev_vdbg(codec->dev, "Analogue paths connected: %x\n",
+				 reg & ~WM8993_DACL_TO_HPOUT1L);
+			return false;
+		} else {
+			dev_vdbg(codec->dev, "HPL connected to mixer\n");
+			return false;
+		}
+	} else {
+		dev_vdbg(codec->dev, "HPL connected to DAC\n");
+	}
+
+	reg = snd_soc_read(codec, WM8993_OUTPUT_MIXER2);
+	if (!(reg & WM8993_DACR_TO_HPOUT1R)) {
+		if (reg & ~WM8993_DACR_TO_MIXOUTR) {
+			dev_vdbg(codec->dev, "Analogue paths connected: %x\n",
+				 reg & ~WM8993_DACR_TO_HPOUT1R);
+			return false;
+		} else {
+			dev_vdbg(codec->dev, "HPR connected to mixer\n");
+			return false;
+		}
+	} else {
+		dev_vdbg(codec->dev, "HPR connected to DAC\n");
+	}
+
+	return true;
+}
+
 /*
  * Startup calibration of the DC servo
  */
@@ -129,10 +165,10 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 
 	/* If we're using a digital only path and have a previously
 	 * callibrated DC servo offset stored then use that. */
-	if (hubs->class_w && hubs->class_w_dcs) {
+	if (wm_hubs_dac_hp_direct(codec) && hubs->dac_hp_direct_dcs) {
 		dev_dbg(codec->dev, "Using cached DC servo offset %x\n",
-			hubs->class_w_dcs);
-		snd_soc_write(codec, dcs_reg, hubs->class_w_dcs);
+			hubs->dac_hp_direct_dcs);
+		snd_soc_write(codec, dcs_reg, hubs->dac_hp_direct_dcs);
 		wait_for_dc_servo(codec,
 				  WM8993_DCS_TRIG_DAC_WR_0 |
 				  WM8993_DCS_TRIG_DAC_WR_1);
@@ -207,8 +243,8 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 
 	/* Save the callibrated offset if we're in class W mode and
 	 * therefore don't have any analogue signal mixed in. */
-	if (hubs->class_w && !hubs->no_cache_class_w)
-		hubs->class_w_dcs = dcs_cfg;
+	if (wm_hubs_dac_hp_direct(codec) && !hubs->no_cache_dac_hp_direct)
+		hubs->dac_hp_direct_dcs = dcs_cfg;
 }
 
 /*
@@ -224,7 +260,7 @@ static int wm8993_put_dc_servo(struct snd_kcontrol *kcontrol,
 	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 
 	/* Updating the analogue gains invalidates the DC servo cache */
-	hubs->class_w_dcs = 0;
+	hubs->dac_hp_direct_dcs = 0;
 
 	/* If we're applying an offset correction then updating the
 	 * callibration would be likely to introduce further offsets. */
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index 5705276..8bb9f1b 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -30,9 +30,8 @@ struct wm_hubs_data {
 	int series_startup;
 	int no_series_update;
 
-	bool no_cache_class_w;
-	bool class_w;
-	u16 class_w_dcs;
+	bool no_cache_dac_hp_direct;
+	u16 dac_hp_direct_dcs;
 
 	bool lineout1_se;
 	bool lineout1n_ena;
-- 
1.7.10
