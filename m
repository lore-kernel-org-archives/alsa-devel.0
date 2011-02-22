From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support configuration of WM8958
	microphone bias analogue parameters
Date: Tue, 22 Feb 2011 01:16:00 +0000
Message-ID: <1298337360-12614-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 951451037F2
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 02:16:02 +0100 (CET)
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

The WM8958 has a different microphone bias architecture to WM8994 so needs
different configuration to WM8994. Support this in platform data.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h     |    7 +++++--
 include/linux/mfd/wm8994/registers.h |    2 ++
 sound/soc/codecs/wm8994.c            |    7 +++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index 0686946..466b1c7 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -108,13 +108,16 @@ struct wm8994_pdata {
 	 */
 	int micdet_irq;
 
-        /* Microphone biases: 0=0.9*AVDD1 1=0.65*AVVD1 */
+        /* WM8994 microphone biases: 0=0.9*AVDD1 1=0.65*AVVD1 */
         unsigned int micbias1_lvl:1;
         unsigned int micbias2_lvl:1;
 
-        /* Jack detect threashold levels, see datasheet for values */
+        /* WM8994 jack detect threashold levels, see datasheet for values */
         unsigned int jd_scthr:2;
         unsigned int jd_thr:2;
+
+	/* WM8958 microphone bias configuration */
+	int micbias[2];
 };
 
 #endif
diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index be072fa..f3ee842 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -63,6 +63,8 @@
 #define WM8994_MICBIAS                          0x3A
 #define WM8994_LDO_1                            0x3B
 #define WM8994_LDO_2                            0x3C
+#define WM8958_MICBIAS1				0x3D
+#define WM8958_MICBIAS2				0x3E
 #define WM8994_CHARGE_PUMP_1                    0x4C
 #define WM8958_CHARGE_PUMP_2                    0x4D
 #define WM8994_CLASS_W_1                        0x51
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index ce192cc..4df047e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2859,6 +2859,13 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 	else
 		snd_soc_add_controls(wm8994->codec, wm8994_eq_controls,
 				     ARRAY_SIZE(wm8994_eq_controls));
+
+	for (i = 0; i < ARRAY_SIZE(pdata->micbias); i++) {
+		if (pdata->micbias[i]) {
+			snd_soc_write(codec, WM8958_MICBIAS1 + i,
+				pdata->micbias[i] & 0xffff);
+		}
+	}
 }
 
 /**
-- 
1.7.2.3
