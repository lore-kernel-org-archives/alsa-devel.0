From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_hubs: Cache multiple DCS offsets
Date: Tue,  1 May 2012 19:19:55 +0100
Message-ID: <1335896395-7630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41B7B1042DB
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 20:20:03 +0200 (CEST)
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

Rather than invalidating the cached DCS value every time the headphone
gain changes store multiple values, indexed by gain. This allows the
optimisation we get from the cache to take effect more often.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   74 ++++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/wm_hubs.h |    3 +-
 2 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 8a29843..dfe957a 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -143,12 +143,69 @@ static bool wm_hubs_dac_hp_direct(struct snd_soc_codec *codec)
 	return true;
 }
 
+struct wm_hubs_dcs_cache {
+	struct list_head list;
+	unsigned int left;
+	unsigned int right;
+	u16 dcs_cfg;
+};
+
+static bool wm_hubs_dcs_cache_get(struct snd_soc_codec *codec,
+				  struct wm_hubs_dcs_cache **entry)
+{
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_dcs_cache *cache;
+	unsigned int left, right;
+
+	left = snd_soc_read(codec, WM8993_LEFT_OUTPUT_VOLUME);
+	left &= WM8993_HPOUT1L_VOL_MASK;
+
+	right = snd_soc_read(codec, WM8993_RIGHT_OUTPUT_VOLUME);
+	right &= WM8993_HPOUT1R_VOL_MASK;
+
+	list_for_each_entry(cache, &hubs->dcs_cache, list) {
+		if (cache->left != left || cache->right != right)
+			continue;
+
+		*entry = cache;
+		return true;
+	}
+
+	return false;
+}
+
+static void wm_hubs_dcs_cache_set(struct snd_soc_codec *codec, u16 dcs_cfg)
+{
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_dcs_cache *cache;
+
+	if (hubs->no_cache_dac_hp_direct)
+		return;
+
+	cache = devm_kzalloc(codec->dev, sizeof(*cache), GFP_KERNEL);
+	if (!cache) {
+		dev_err(codec->dev, "Failed to allocate DCS cache entry\n");
+		return;
+	}
+
+	cache->left = snd_soc_read(codec, WM8993_LEFT_OUTPUT_VOLUME);
+	cache->left &= WM8993_HPOUT1L_VOL_MASK;
+
+	cache->right = snd_soc_read(codec, WM8993_RIGHT_OUTPUT_VOLUME);
+	cache->right &= WM8993_HPOUT1R_VOL_MASK;
+
+	cache->dcs_cfg = dcs_cfg;
+
+	list_add_tail(&cache->list, &hubs->dcs_cache);
+}
+
 /*
  * Startup calibration of the DC servo
  */
 static void calibrate_dc_servo(struct snd_soc_codec *codec)
 {
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_dcs_cache *cache;
 	s8 offset;
 	u16 reg, reg_l, reg_r, dcs_cfg, dcs_reg;
 
@@ -163,10 +220,11 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 
 	/* If we're using a digital only path and have a previously
 	 * callibrated DC servo offset stored then use that. */
-	if (wm_hubs_dac_hp_direct(codec) && hubs->dac_hp_direct_dcs) {
-		dev_dbg(codec->dev, "Using cached DC servo offset %x\n",
-			hubs->dac_hp_direct_dcs);
-		snd_soc_write(codec, dcs_reg, hubs->dac_hp_direct_dcs);
+	if (wm_hubs_dac_hp_direct(codec) &&
+	    wm_hubs_dcs_cache_get(codec, &cache)) {
+		dev_dbg(codec->dev, "Using cached DCS offset %x for %d,%d\n",
+			cache->dcs_cfg, cache->left, cache->right);
+		snd_soc_write(codec, dcs_reg, cache->dcs_cfg);
 		wait_for_dc_servo(codec,
 				  WM8993_DCS_TRIG_DAC_WR_0 |
 				  WM8993_DCS_TRIG_DAC_WR_1);
@@ -241,8 +299,8 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 
 	/* Save the callibrated offset if we're in class W mode and
 	 * therefore don't have any analogue signal mixed in. */
-	if (wm_hubs_dac_hp_direct(codec) && !hubs->no_cache_dac_hp_direct)
-		hubs->dac_hp_direct_dcs = dcs_cfg;
+	if (wm_hubs_dac_hp_direct(codec))
+		wm_hubs_dcs_cache_set(codec, dcs_cfg);
 }
 
 /*
@@ -257,9 +315,6 @@ static int wm8993_put_dc_servo(struct snd_kcontrol *kcontrol,
 
 	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 
-	/* Updating the analogue gains invalidates the DC servo cache */
-	hubs->dac_hp_direct_dcs = 0;
-
 	/* If we're applying an offset correction then updating the
 	 * callibration would be likely to introduce further offsets. */
 	if (hubs->dcs_codes_l || hubs->dcs_codes_r || hubs->no_series_update)
@@ -1057,6 +1112,7 @@ int wm_hubs_add_analogue_routes(struct snd_soc_codec *codec,
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
+	INIT_LIST_HEAD(&hubs->dcs_cache);
 	init_completion(&hubs->dcs_done);
 
 	snd_soc_dapm_add_routes(dapm, analogue_routes,
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index 71861fc..da2dc89 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -16,6 +16,7 @@
 
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <linux/list.h>
 #include <sound/control.h>
 
 struct snd_soc_codec;
@@ -32,7 +33,7 @@ struct wm_hubs_data {
 	int no_series_update;
 
 	bool no_cache_dac_hp_direct;
-	u16 dac_hp_direct_dcs;
+	struct list_head dcs_cache;
 	bool (*check_class_w_digital)(struct snd_soc_codec *);
 
 	bool lineout1_se;
-- 
1.7.10
