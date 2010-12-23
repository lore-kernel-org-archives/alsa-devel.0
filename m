From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove incorrect WM8903 erratum
	workaround
Date: Thu, 23 Dec 2010 11:17:24 +0000
Message-ID: <1293103044-5906-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78977103893
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 12:17:25 +0100 (CET)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Due to a typographical error in the erratum workaround it was never
functional so just remove it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   20 ++++++--------------
 sound/soc/codecs/wm8903.h |   19 -------------------
 2 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index d015745..4a12ac2 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1013,7 +1013,7 @@ static int wm8903_add_widgets(struct snd_soc_codec *codec)
 static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg, reg2;
+	u16 reg;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1037,23 +1037,15 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 			wm8903_run_sequence(codec, 0);
 			wm8903_sync_reg_cache(codec, codec->reg_cache);
 
-			/* Enable low impedence charge pump output */
-			reg = snd_soc_read(codec,
-					  WM8903_CONTROL_INTERFACE_TEST_1);
-			snd_soc_write(codec, WM8903_CONTROL_INTERFACE_TEST_1,
-				     reg | WM8903_TEST_KEY);
-			reg2 = snd_soc_read(codec, WM8903_CHARGE_PUMP_TEST_1);
-			snd_soc_write(codec, WM8903_CHARGE_PUMP_TEST_1,
-				     reg2 | WM8903_CP_SW_KELVIN_MODE_MASK);
-			snd_soc_write(codec, WM8903_CONTROL_INTERFACE_TEST_1,
-				     reg);
-
 			/* By default no bypass paths are enabled so
 			 * enable Class W support.
 			 */
 			dev_dbg(codec->dev, "Enabling Class W\n");
-			snd_soc_write(codec, WM8903_CLASS_W_0, reg |
-				     WM8903_CP_DYN_FREQ | WM8903_CP_DYN_V);
+			snd_soc_update_bits(codec, WM8903_CLASS_W_0,
+					    WM8903_CP_DYN_FREQ |
+					    WM8903_CP_DYN_V,
+					    WM8903_CP_DYN_FREQ |
+					    WM8903_CP_DYN_V);
 		}
 
 		reg = snd_soc_read(codec, WM8903_VMID_CONTROL_0);
diff --git a/sound/soc/codecs/wm8903.h b/sound/soc/codecs/wm8903.h
index 996435e..7f9f6be 100644
--- a/sound/soc/codecs/wm8903.h
+++ b/sound/soc/codecs/wm8903.h
@@ -98,8 +98,6 @@ extern int wm8903_mic_detect(struct snd_soc_codec *codec,
 #define WM8903_INTERRUPT_STATUS_1_MASK          0x7A
 #define WM8903_INTERRUPT_POLARITY_1             0x7B
 #define WM8903_INTERRUPT_CONTROL                0x7E
-#define WM8903_CONTROL_INTERFACE_TEST_1         0x81
-#define WM8903_CHARGE_PUMP_TEST_1               0x95
 #define WM8903_CLOCK_RATE_TEST_4                0xA4
 #define WM8903_ANALOGUE_OUTPUT_BIAS_0           0xAC
 
@@ -1206,23 +1204,6 @@ extern int wm8903_mic_detect(struct snd_soc_codec *codec,
 #define WM8903_IRQ_POL_WIDTH                         1  /* IRQ_POL */
 
 /*
- * R129 (0x81) - Control Interface Test 1
- */
-#define WM8903_USER_KEY                         0x0002  /* USER_KEY */
-#define WM8903_USER_KEY_MASK                    0x0002  /* USER_KEY */
-#define WM8903_USER_KEY_SHIFT                        1  /* USER_KEY */
-#define WM8903_USER_KEY_WIDTH                        1  /* USER_KEY */
-#define WM8903_TEST_KEY                         0x0001  /* TEST_KEY */
-#define WM8903_TEST_KEY_MASK                    0x0001  /* TEST_KEY */
-#define WM8903_TEST_KEY_SHIFT                        0  /* TEST_KEY */
-#define WM8903_TEST_KEY_WIDTH                        1  /* TEST_KEY */
-
-/*
- * R149 (0x95) - Charge Pump Test 1
- */
-#define WM8903_CP_SW_KELVIN_MODE_MASK           0x0006  /* CP_SW_KELVIN_MODE - [2:1] */
-#define WM8903_CP_SW_KELVIN_MODE_SHIFT               1  /* CP_SW_KELVIN_MODE - [2:1] */
-#define WM8903_CP_SW_KELVIN_MODE_WIDTH               2  /* CP_SW_KELVIN_MODE - [2:1] */
 
 /*
  * R164 (0xA4) - Clock Rate Test 4
-- 
1.5.4.3
