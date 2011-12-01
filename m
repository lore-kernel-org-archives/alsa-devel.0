From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ASoC: Add platform data for WM8958/WM1811
	microphone detection rates
Date: Thu,  1 Dec 2011 14:16:45 +0000
Message-ID: <1322749006-371-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EA68103C07
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 15:17:10 +0100 (CET)
In-Reply-To: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Allow systems to override the default microphone detection rates using
platform data in case the settings are not suitable (eg, due to an
unusually noisy jack).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h |   20 ++++++++++++++++++++
 sound/soc/codecs/wm8994.c        |   12 ++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index d46c55a..3fb1f40 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -113,6 +113,23 @@ struct wm8958_enh_eq_cfg {
 	u16 regs[WM8958_ENH_EQ_REGS];
 };
 
+/**
+ * Microphone detection rates, used to tune response rates and power
+ * consumption for WM8958/WM1811 microphone detection.
+ *
+ * @sysclk: System clock rate to use this configuration for.
+ * @idle: True if this configuration should use when no accessory is detected,
+ *        false otherwise.
+ * @start: Value for MICD_BIAS_START_TIME register field (not shifted).
+ * @rate: Value for MICD_RATE register field (not shifted).
+ */
+struct wm8958_micd_rate {
+	int sysclk;
+	bool idle;
+	int start;
+	int rate;
+};
+
 struct wm8994_pdata {
 	int gpio_base;
 
@@ -144,6 +161,9 @@ struct wm8994_pdata {
 	int num_enh_eq_cfgs;
 	struct wm8958_enh_eq_cfg *enh_eq_cfgs;
 
+	int num_micd_rates;
+	struct wm8958_micd_rate *micd_rates;
+
         /* LINEOUT can be differential or single ended */
         unsigned int lineout1_diff:1;
         unsigned int lineout2_diff:1;
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 72282da..aea5100 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -60,13 +60,6 @@ static int wm8994_retune_mobile_base[] = {
 
 static void wm8958_default_micdet(u16 status, void *data);
 
-struct wm8958_micd_rate {
-	int sysclk;
-	bool idle;
-	int start;
-	int rate;
-};
-
 static const struct wm8958_micd_rate micdet_rates[] = {
 	{ 32768,       true,  1, 4 },
 	{ 32768,       false, 1, 1 },
@@ -100,7 +93,10 @@ static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 	else
 		sysclk = wm8994->aifclk[0];
 
-	if (wm8994->jackdet) {
+	if (wm8994->pdata && wm8994->pdata->micd_rates) {
+		rates = wm8994->pdata->micd_rates;
+		num_rates = wm8994->pdata->num_micd_rates;
+	} else if (wm8994->jackdet) {
 		rates = jackdet_rates;
 		num_rates = ARRAY_SIZE(jackdet_rates);
 	} else {
-- 
1.7.7.3
