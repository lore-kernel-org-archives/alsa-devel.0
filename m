From: Zidan Wang <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 2/4] ASoC: wm8960: support configure headphone jack detect pin and polarity from device tree
Date: Thu, 11 Jun 2015 19:14:34 +0800
Message-ID: <a9b871099c39cd0ef48e2b85ef93294e97ef8c70.1434020423.git.zidan.wang@freescale.com>
References: <cover.1434020423.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434020423.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

The ADCLRC/GPIO1, LINPUT3/JD2 and RINPUT3/JD3 pins can be selected as
headphone jack detect inputs to automatically disable the speaker output
and enable the headphone.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 Documentation/devicetree/bindings/sound/wm8960.txt | 11 +++++++++++
 include/sound/wm8960.h                             |  1 +
 sound/soc/codecs/wm8960.c                          | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8960.txt b/Documentation/devicetree/bindings/sound/wm8960.txt
index 2deb8a3..4f1aa8b 100644
--- a/Documentation/devicetree/bindings/sound/wm8960.txt
+++ b/Documentation/devicetree/bindings/sound/wm8960.txt
@@ -21,6 +21,16 @@ Optional properties:
 	enabled and disabled together with HP_L and HP_R pins in response to jack
 	detect events.
 
+  - wlf,hp-det: ADCLRC/GPIO1, LINPUT3/JD2 and RINPUT3/JD3 pins can be selected as
+	headphone jack detect inputs to automatically disable the speaker output
+	and enable the headphone output.
+	hp-det = <hp-det-pin hp-det-polarity>;
+	hp-det-pin = 1: ADCLRC/GPIO1 used as detect pin
+	hp-det-pin = 2: LINPUT3/JD2 used as detect pin
+	hp-det-pin = 3: RINPUT3/JD3 used as detect pin
+	hp-det-polarity = 0: hp detect high for headphone
+	hp-det-polarity = 1: hp detect high for speaker
+
 Example:
 
 codec: wm8960@1a {
@@ -28,4 +38,5 @@ codec: wm8960@1a {
 	reg = <0x1a>;
 
 	wlf,shared-lrclk;
+	wlf,hp-det = <2 0>
 };
diff --git a/include/sound/wm8960.h b/include/sound/wm8960.h
index e8ce8ee..a787376 100644
--- a/include/sound/wm8960.h
+++ b/include/sound/wm8960.h
@@ -19,6 +19,7 @@ struct wm8960_data {
 	bool capless;  /* Headphone outputs configured in capless mode */
 
 	bool shared_lrclk;  /* DAC and ADC LRCLKs are wired together */
+	u32 hp_det[2]; /* headphone detect pin and polarity */
 };
 
 #endif
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 729205f..c1be15c 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1123,6 +1123,11 @@ static void wm8960_set_pdata_from_of(struct i2c_client *i2c,
 
 	if (of_property_read_bool(np, "wlf,shared-lrclk"))
 		pdata->shared_lrclk = true;
+
+	of_property_read_u32_array(np, "wlf,hp-det", pdata->hp_det, 2);
+
+	if (pdata->hp_det[0] > 3)
+		pdata->hp_det[0] = 0;
 }
 
 static int wm8960_i2c_probe(struct i2c_client *i2c,
@@ -1168,6 +1173,23 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	/*
+	 * ADCLRC/GPIO1 pin configured as GPIO1 to select jack
+	 * detect input function
+	 */
+	if (wm8960->pdata.hp_det[0] == 1)
+	        regmap_update_bits(wm8960->regmap, WM8960_IFACE2, 1<<6, 1<<6);
+
+	/* Enable headphone jack detect */
+	if (wm8960->pdata.hp_det[0] != 0) {
+		regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2, 1<<6, 1<<6);
+		regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2, 1<<5,
+				    wm8960->pdata.hp_det[1]<<5);
+		regmap_update_bits(wm8960->regmap, WM8960_ADDCTL4, 3<<2,
+				    wm8960->pdata.hp_det[0]<<2);
+		regmap_update_bits(wm8960->regmap, WM8960_ADDCTL1, 3, 3);
+	}
+
 	/* Latch the update bits */
 	regmap_update_bits(wm8960->regmap, WM8960_LINVOL, 0x100, 0x100);
 	regmap_update_bits(wm8960->regmap, WM8960_RINVOL, 0x100, 0x100);
-- 
1.9.1
