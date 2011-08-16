From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add WM8958 noise gate support
Date: Tue, 16 Aug 2011 10:10:50 +0900
Message-ID: <1313457050-5270-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 109F8103882
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 10:14:50 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/registers.h |   45 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8994-tables.c     |   12 ++++----
 sound/soc/codecs/wm8994.c            |   38 ++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index 54dbaa9..d7be463 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -138,6 +138,8 @@
 #define WM8994_AIF1_DAC1_FILTERS_2              0x421
 #define WM8994_AIF1_DAC2_FILTERS_1              0x422
 #define WM8994_AIF1_DAC2_FILTERS_2              0x423
+#define WM8958_AIF1_DAC1_NOISE_GATE             0x430
+#define WM8958_AIF1_DAC2_NOISE_GATE             0x431
 #define WM8994_AIF1_DRC1_1                      0x440
 #define WM8994_AIF1_DRC1_2                      0x441
 #define WM8994_AIF1_DRC1_3                      0x442
@@ -195,6 +197,7 @@
 #define WM8994_AIF2_ADC_FILTERS                 0x510
 #define WM8994_AIF2_DAC_FILTERS_1               0x520
 #define WM8994_AIF2_DAC_FILTERS_2               0x521
+#define WM8958_AIF2_DAC_NOISE_GATE              0x530
 #define WM8994_AIF2_DRC_1                       0x540
 #define WM8994_AIF2_DRC_2                       0x541
 #define WM8994_AIF2_DRC_3                       0x542
@@ -3040,6 +3043,34 @@
 #define WM8994_AIF1DAC2_3D_ENA_WIDTH                 1  /* AIF1DAC2_3D_ENA */
 
 /*
+ * R1072 (0x430) - AIF1 DAC1 Noise Gate
+ */
+#define WM8958_AIF1DAC1_NG_HLD_MASK             0x0060  /* AIF1DAC1_NG_HLD - [6:5] */
+#define WM8958_AIF1DAC1_NG_HLD_SHIFT                 5  /* AIF1DAC1_NG_HLD - [6:5] */
+#define WM8958_AIF1DAC1_NG_HLD_WIDTH                 2  /* AIF1DAC1_NG_HLD - [6:5] */
+#define WM8958_AIF1DAC1_NG_THR_MASK             0x000E  /* AIF1DAC1_NG_THR - [3:1] */
+#define WM8958_AIF1DAC1_NG_THR_SHIFT                 1  /* AIF1DAC1_NG_THR - [3:1] */
+#define WM8958_AIF1DAC1_NG_THR_WIDTH                 3  /* AIF1DAC1_NG_THR - [3:1] */
+#define WM8958_AIF1DAC1_NG_ENA                  0x0001  /* AIF1DAC1_NG_ENA */
+#define WM8958_AIF1DAC1_NG_ENA_MASK             0x0001  /* AIF1DAC1_NG_ENA */
+#define WM8958_AIF1DAC1_NG_ENA_SHIFT                 0  /* AIF1DAC1_NG_ENA */
+#define WM8958_AIF1DAC1_NG_ENA_WIDTH                 1  /* AIF1DAC1_NG_ENA */
+
+/*
+ * R1073 (0x431) - AIF1 DAC2 Noise Gate
+ */
+#define WM8958_AIF1DAC2_NG_HLD_MASK             0x0060  /* AIF1DAC2_NG_HLD - [6:5] */
+#define WM8958_AIF1DAC2_NG_HLD_SHIFT                 5  /* AIF1DAC2_NG_HLD - [6:5] */
+#define WM8958_AIF1DAC2_NG_HLD_WIDTH                 2  /* AIF1DAC2_NG_HLD - [6:5] */
+#define WM8958_AIF1DAC2_NG_THR_MASK             0x000E  /* AIF1DAC2_NG_THR - [3:1] */
+#define WM8958_AIF1DAC2_NG_THR_SHIFT                 1  /* AIF1DAC2_NG_THR - [3:1] */
+#define WM8958_AIF1DAC2_NG_THR_WIDTH                 3  /* AIF1DAC2_NG_THR - [3:1] */
+#define WM8958_AIF1DAC2_NG_ENA                  0x0001  /* AIF1DAC2_NG_ENA */
+#define WM8958_AIF1DAC2_NG_ENA_MASK             0x0001  /* AIF1DAC2_NG_ENA */
+#define WM8958_AIF1DAC2_NG_ENA_SHIFT                 0  /* AIF1DAC2_NG_ENA */
+#define WM8958_AIF1DAC2_NG_ENA_WIDTH                 1  /* AIF1DAC2_NG_ENA */
+
+/*
  * R1088 (0x440) - AIF1 DRC1 (1)
  */
 #define WM8994_AIF1DRC1_SIG_DET_RMS_MASK        0xF800  /* AIF1DRC1_SIG_DET_RMS - [15:11] */
@@ -3651,6 +3682,20 @@
 #define WM8994_AIF2DAC_3D_ENA_WIDTH                  1  /* AIF2DAC_3D_ENA */
 
 /*
+ * R1328 (0x530) - AIF2 DAC Noise Gate
+ */
+#define WM8958_AIF2DAC_NG_HLD_MASK              0x0060  /* AIF2DAC_NG_HLD - [6:5] */
+#define WM8958_AIF2DAC_NG_HLD_SHIFT                  5  /* AIF2DAC_NG_HLD - [6:5] */
+#define WM8958_AIF2DAC_NG_HLD_WIDTH                  2  /* AIF2DAC_NG_HLD - [6:5] */
+#define WM8958_AIF2DAC_NG_THR_MASK              0x000E  /* AIF2DAC_NG_THR - [3:1] */
+#define WM8958_AIF2DAC_NG_THR_SHIFT                  1  /* AIF2DAC_NG_THR - [3:1] */
+#define WM8958_AIF2DAC_NG_THR_WIDTH                  3  /* AIF2DAC_NG_THR - [3:1] */
+#define WM8958_AIF2DAC_NG_ENA                   0x0001  /* AIF2DAC_NG_ENA */
+#define WM8958_AIF2DAC_NG_ENA_MASK              0x0001  /* AIF2DAC_NG_ENA */
+#define WM8958_AIF2DAC_NG_ENA_SHIFT                  0  /* AIF2DAC_NG_ENA */
+#define WM8958_AIF2DAC_NG_ENA_WIDTH                  1  /* AIF2DAC_NG_ENA */
+
+/*
  * R1344 (0x540) - AIF2 DRC (1)
  */
 #define WM8994_AIF2DRC_SIG_DET_RMS_MASK         0xF800  /* AIF2DRC_SIG_DET_RMS - [15:11] */
diff --git a/sound/soc/codecs/wm8994-tables.c b/sound/soc/codecs/wm8994-tables.c
index 428d4c5..43e6603 100644
--- a/sound/soc/codecs/wm8994-tables.c
+++ b/sound/soc/codecs/wm8994-tables.c
@@ -1073,8 +1073,8 @@ const struct wm8994_access_mask wm8994_access_masks[WM8994_CACHE_SIZE] = {
 	{ 0x0000, 0x0000 }, /* R1069 */
 	{ 0x0000, 0x0000 }, /* R1070 */
 	{ 0x0000, 0x0000 }, /* R1071 */
-	{ 0x0000, 0x0000 }, /* R1072 */
-	{ 0x0000, 0x0000 }, /* R1073 */
+	{ 0x006F, 0x006F }, /* R1072  - AIF1 DAC1 Noise Gate */
+	{ 0x006F, 0x006F }, /* R1073  - AIF1 DAC2 Noise Gate */
 	{ 0x0000, 0x0000 }, /* R1074 */
 	{ 0x0000, 0x0000 }, /* R1075 */
 	{ 0x0000, 0x0000 }, /* R1076 */
@@ -1329,7 +1329,7 @@ const struct wm8994_access_mask wm8994_access_masks[WM8994_CACHE_SIZE] = {
 	{ 0x0000, 0x0000 }, /* R1325 */
 	{ 0x0000, 0x0000 }, /* R1326 */
 	{ 0x0000, 0x0000 }, /* R1327 */
-	{ 0x0000, 0x0000 }, /* R1328 */
+	{ 0x006F, 0x006F }, /* R1328  - AIF2 DAC Noise Gate */
 	{ 0x0000, 0x0000 }, /* R1329 */
 	{ 0x0000, 0x0000 }, /* R1330 */
 	{ 0x0000, 0x0000 }, /* R1331 */
@@ -2646,8 +2646,8 @@ const u16 wm8994_reg_defaults[WM8994_CACHE_SIZE] = {
 	0x0000,     /* R1069 */
 	0x0000,     /* R1070 */
 	0x0000,     /* R1071 */
-	0x0000,     /* R1072 */
-	0x0000,     /* R1073 */
+	0x0068,     /* R1072  - AIF1 DAC1 Noise Gate */
+	0x0068,     /* R1073  - AIF1 DAC2 Noise Gate */
 	0x0000,     /* R1074 */
 	0x0000,     /* R1075 */
 	0x0000,     /* R1076 */
@@ -2902,7 +2902,7 @@ const u16 wm8994_reg_defaults[WM8994_CACHE_SIZE] = {
 	0x0000,     /* R1325 */
 	0x0000,     /* R1326 */
 	0x0000,     /* R1327 */
-	0x0000,     /* R1328 */
+	0x0068,     /* R1328  - AIF2 DAC Noise Gate */
 	0x0000,     /* R1329 */
 	0x0000,     /* R1330 */
 	0x0000,     /* R1331 */
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index f328369..c45b634 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -299,6 +299,7 @@ static const DECLARE_TLV_DB_SCALE(st_tlv, -3600, 300, 0);
 static const DECLARE_TLV_DB_SCALE(wm8994_3d_tlv, -1600, 183, 0);
 static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static const DECLARE_TLV_DB_SCALE(mixin_boost_tlv, 0, 900, 0);
+static const DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
 #define WM8994_DRC_SWITCH(xname, reg, shift) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -678,8 +679,45 @@ SOC_SINGLE_TLV("AIF2 EQ5 Volume", WM8994_AIF2_EQ_GAINS_2, 6, 31, 0,
 	       eq_tlv),
 };
 
+static const char *wm8958_ng_text[] = {
+	"30ms", "125ms", "250ms", "500ms",
+};
+
+static const struct soc_enum wm8958_aif1dac1_ng_hold =
+	SOC_ENUM_SINGLE(WM8958_AIF1_DAC1_NOISE_GATE,
+			WM8958_AIF1DAC1_NG_THR_SHIFT, 4, wm8958_ng_text);
+
+static const struct soc_enum wm8958_aif1dac2_ng_hold =
+	SOC_ENUM_SINGLE(WM8958_AIF1_DAC2_NOISE_GATE,
+			WM8958_AIF1DAC2_NG_THR_SHIFT, 4, wm8958_ng_text);
+
+static const struct soc_enum wm8958_aif2dac_ng_hold =
+	SOC_ENUM_SINGLE(WM8958_AIF2_DAC_NOISE_GATE,
+			WM8958_AIF2DAC_NG_THR_SHIFT, 4, wm8958_ng_text);
+
 static const struct snd_kcontrol_new wm8958_snd_controls[] = {
 SOC_SINGLE_TLV("AIF3 Boost Volume", WM8958_AIF3_CONTROL_2, 10, 3, 0, aif_tlv),
+
+SOC_SINGLE("AIF1DAC1 Noise Gate Switch", WM8958_AIF1_DAC1_NOISE_GATE,
+	   WM8958_AIF1DAC1_NG_ENA_SHIFT, 1, 0),
+SOC_ENUM("AIF1DAC1 Noise Gate Hold Time", wm8958_aif1dac1_ng_hold),
+SOC_SINGLE_TLV("AIF1DAC1 Noise Gate Threshold Volume",
+	       WM8958_AIF1_DAC1_NOISE_GATE, WM8958_AIF1DAC1_NG_THR_SHIFT,
+	       7, 1, ng_tlv),
+
+SOC_SINGLE("AIF1DAC2 Noise Gate Switch", WM8958_AIF1_DAC2_NOISE_GATE,
+	   WM8958_AIF1DAC2_NG_ENA_SHIFT, 1, 0),
+SOC_ENUM("AIF1DAC2 Noise Gate Hold Time", wm8958_aif1dac2_ng_hold),
+SOC_SINGLE_TLV("AIF1DAC2 Noise Gate Threshold Volume",
+	       WM8958_AIF1_DAC2_NOISE_GATE, WM8958_AIF1DAC2_NG_THR_SHIFT,
+	       7, 1, ng_tlv),
+
+SOC_SINGLE("AIF2DAC Noise Gate Switch", WM8958_AIF2_DAC_NOISE_GATE,
+	   WM8958_AIF2DAC_NG_ENA_SHIFT, 1, 0),
+SOC_ENUM("AIF2DAC Noise Gate Hold Time", wm8958_aif2dac_ng_hold),
+SOC_SINGLE_TLV("AIF2DAC Noise Gate Threshold Volume",
+	       WM8958_AIF2_DAC_NOISE_GATE, WM8958_AIF2DAC_NG_THR_SHIFT,
+	       7, 1, ng_tlv),
 };
 
 static const struct snd_kcontrol_new wm1811_snd_controls[] = {
-- 
1.7.5.4
