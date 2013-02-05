From: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2200: Provide platform data for
	MICBIAS configuration
Date: Tue,  5 Feb 2013 16:26:43 +0000
Message-ID: <1360081603-2795-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEE8E261629
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 17:26:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Chris Rattray <crattray@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
---
 include/sound/wm2200.h    |   22 +++++++++++++++++++++-
 sound/soc/codecs/wm2200.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/include/sound/wm2200.h b/include/sound/wm2200.h
index 79bf55b..bc7ab1a 100644
--- a/include/sound/wm2200.h
+++ b/include/sound/wm2200.h
@@ -12,6 +12,7 @@
 #define __LINUX_SND_WM2200_H
 
 #define WM2200_GPIO_SET 0x10000
+#define WM2200_MAX_MICBIAS 2
 
 enum wm2200_in_mode {
 	WM2200_IN_SE = 0,
@@ -25,6 +26,24 @@ enum wm2200_dmic_sup {
 	WM2200_DMIC_SUP_MICBIAS2 = 2,
 };
 
+enum wm2200_mbias_lvl {
+	WM2200_MBIAS_LVL_1V5 = 1,
+	WM2200_MBIAS_LVL_1V8 = 2,
+	WM2200_MBIAS_LVL_1V9 = 3,
+	WM2200_MBIAS_LVL_2V0 = 4,
+	WM2200_MBIAS_LVL_2V2 = 5,
+	WM2200_MBIAS_LVL_2V4 = 6,
+	WM2200_MBIAS_LVL_2V5 = 7,
+	WM2200_MBIAS_LVL_2V6 = 8,
+};
+
+struct wm2200_micbias {
+	enum wm2200_mbias_lvl mb_lvl;      /** Regulated voltage */
+	unsigned int discharge:1;          /** Actively discharge */
+	unsigned int fast_start:1;         /** Enable aggressive startup ramp rate */
+	unsigned int bypass:1;             /** Use bypass mode */
+};
+
 struct wm2200_pdata {
 	int reset;      /** GPIO controlling /RESET, if any */
 	int ldo_ena;    /** GPIO controlling LODENA, if any */
@@ -35,7 +54,8 @@ struct wm2200_pdata {
 	enum wm2200_in_mode in_mode[3];
 	enum wm2200_dmic_sup dmic_sup[3];
 
-	int micbias_cfg[2];  /** Register value to configure MICBIAS */
+	/** MICBIAS configurations */
+	struct wm2200_micbias micbias[WM2200_MAX_MICBIAS];
 };
 
 #endif
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index bdd3d80..bbd8383 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2192,6 +2192,7 @@ static int wm2200_i2c_probe(struct i2c_client *i2c,
 	struct wm2200_priv *wm2200;
 	unsigned int reg;
 	int ret, i;
+	int val;
 
 	wm2200 = devm_kzalloc(&i2c->dev, sizeof(struct wm2200_priv),
 			      GFP_KERNEL);
@@ -2342,6 +2343,36 @@ static int wm2200_i2c_probe(struct i2c_client *i2c,
 		regmap_write(wm2200->regmap, WM2200_AUDIO_IF_1_16 + i, i);
 	}
 
+	for (i = 0; i < WM2200_MAX_MICBIAS; i++) {
+		if (!wm2200->pdata.micbias[i].mb_lvl &&
+		    !wm2200->pdata.micbias[i].bypass)
+			continue;
+
+		/* Apply default for bypass mode */
+		if (!wm2200->pdata.micbias[i].mb_lvl)
+			wm2200->pdata.micbias[i].mb_lvl
+					= WM2200_MBIAS_LVL_1V5;
+
+		val = (wm2200->pdata.micbias[i].mb_lvl -1)
+					<< WM2200_MICB1_LVL_SHIFT;
+
+		if (wm2200->pdata.micbias[i].discharge)
+			val |= WM2200_MICB1_DISCH;
+
+		if (wm2200->pdata.micbias[i].fast_start)
+			val |= WM2200_MICB1_RATE;
+
+		if (wm2200->pdata.micbias[i].bypass)
+			val |= WM2200_MICB1_MODE;
+
+		regmap_update_bits(wm2200->regmap,
+				   WM2200_MIC_BIAS_CTRL_1 + i,
+				   WM2200_MICB1_LVL_MASK |
+				   WM2200_MICB1_DISCH |
+				   WM2200_MICB1_MODE |
+				   WM2200_MICB1_RATE, val);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(wm2200->pdata.in_mode); i++) {
 		regmap_update_bits(wm2200->regmap, wm2200_mic_ctrl_reg[i],
 				   WM2200_IN1_MODE_MASK |
-- 
1.7.2.5
