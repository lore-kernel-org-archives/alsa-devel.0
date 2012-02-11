From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: wm_hubs: Clamp inputs to VMID while
	we ramp
Date: Sat, 11 Feb 2012 23:13:28 +0000
Message-ID: <1329002010-5688-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329002010-5688-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 88058103AEA
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 00:13:34 +0100 (CET)
In-Reply-To: <1329002010-5688-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Reduces the amount of time taken to stabilise them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.h  |    9 +++++++++
 sound/soc/codecs/wm_hubs.c |   10 ++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8993.h b/sound/soc/codecs/wm8993.h
index 2184617..4478b40 100644
--- a/sound/soc/codecs/wm8993.h
+++ b/sound/soc/codecs/wm8993.h
@@ -31,6 +31,7 @@
 #define WM8993_GPIO_CTRL_1                      0x12
 #define WM8993_GPIO1                            0x13
 #define WM8993_IRQ_DEBOUNCE                     0x14
+#define WM8993_INPUTS_CLAMP_REG			0x15
 #define WM8993_GPIOCTRL_2                       0x16
 #define WM8993_GPIO_POL                         0x17
 #define WM8993_LEFT_LINE_INPUT_1_2_VOLUME       0x18
@@ -656,6 +657,14 @@
 #define WM8993_GPIO1_DB_WIDTH                        1  /* GPIO1_DB */
 
 /*
+ * R21 (0x15) - Inputs Clamp
+ */
+#define WM8993_INPUTS_CLAMP                     0x0040  /* INPUTS_CLAMP */
+#define WM8993_INPUTS_CLAMP_MASK                0x0040  /* INPUTS_CLAMP */
+#define WM8993_INPUTS_CLAMP_SHIFT                    7  /* INPUTS_CLAMP */
+#define WM8993_INPUTS_CLAMP_WIDTH                    1  /* INPUTS_CLAMP */
+
+/*
  * R22 (0x16) - GPIOCTRL 2
  */
 #define WM8993_IM_JD2_EINT                      0x2000  /* IM_JD2_EINT */
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index f7650c5..9742c66 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -1040,6 +1040,12 @@ void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
 	int val;
 
 	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		/* Clamp the inputs to VMID while we ramp to charge caps */
+		snd_soc_update_bits(codec, WM8993_INPUTS_CLAMP_REG,
+				    WM8993_INPUTS_CLAMP, WM8993_INPUTS_CLAMP);
+		break;
+
 	case SND_SOC_BIAS_ON:
 		/* Turn off any unneded single ended outputs */
 		val = 0;
@@ -1067,6 +1073,10 @@ void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
 		    !hubs->lineout2n_ena && !hubs->lineout2p_ena)
 			snd_soc_update_bits(codec, WM8993_ANTIPOP1,
 					    WM8993_LINEOUT_VMID_BUF_ENA, 0);
+
+		/* Remove the input clamps */
+		snd_soc_update_bits(codec, WM8993_INPUTS_CLAMP_REG,
+				    WM8993_INPUTS_CLAMP, 0);
 		break;
 
 	default:
-- 
1.7.9.rc1
