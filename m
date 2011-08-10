From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add bitfield definitions for WM8958
	MICBIAS registers
Date: Wed, 10 Aug 2011 19:40:32 +0900
Message-ID: <1312972832-1568-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7FE9624628
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 12:40:47 +0200 (CEST)
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
 include/linux/mfd/wm8994/registers.h |   38 ++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index 6152914..64bf91e 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -1922,6 +1922,44 @@
 #define WM8994_LDO2_DISCH_WIDTH                      1  /* LDO2_DISCH */
 
 /*
+ * R61 (0x3D) - MICBIAS1
+ */
+#define WM8958_MICB1_RATE                       0x0020  /* MICB1_RATE */
+#define WM8958_MICB1_RATE_MASK                  0x0020  /* MICB1_RATE */
+#define WM8958_MICB1_RATE_SHIFT                      5  /* MICB1_RATE */
+#define WM8958_MICB1_RATE_WIDTH                      1  /* MICB1_RATE */
+#define WM8958_MICB1_MODE                       0x0010  /* MICB1_MODE */
+#define WM8958_MICB1_MODE_MASK                  0x0010  /* MICB1_MODE */
+#define WM8958_MICB1_MODE_SHIFT                      4  /* MICB1_MODE */
+#define WM8958_MICB1_MODE_WIDTH                      1  /* MICB1_MODE */
+#define WM8958_MICB1_LVL_MASK                   0x000E  /* MICB1_LVL - [3:1] */
+#define WM8958_MICB1_LVL_SHIFT                       1  /* MICB1_LVL - [3:1] */
+#define WM8958_MICB1_LVL_WIDTH                       3  /* MICB1_LVL - [3:1] */
+#define WM8958_MICB1_DISCH                      0x0001  /* MICB1_DISCH */
+#define WM8958_MICB1_DISCH_MASK                 0x0001  /* MICB1_DISCH */
+#define WM8958_MICB1_DISCH_SHIFT                     0  /* MICB1_DISCH */
+#define WM8958_MICB1_DISCH_WIDTH                     1  /* MICB1_DISCH */
+
+/*
+ * R62 (0x3E) - MICBIAS2
+ */
+#define WM8958_MICB2_RATE                       0x0020  /* MICB2_RATE */
+#define WM8958_MICB2_RATE_MASK                  0x0020  /* MICB2_RATE */
+#define WM8958_MICB2_RATE_SHIFT                      5  /* MICB2_RATE */
+#define WM8958_MICB2_RATE_WIDTH                      1  /* MICB2_RATE */
+#define WM8958_MICB2_MODE                       0x0010  /* MICB2_MODE */
+#define WM8958_MICB2_MODE_MASK                  0x0010  /* MICB2_MODE */
+#define WM8958_MICB2_MODE_SHIFT                      4  /* MICB2_MODE */
+#define WM8958_MICB2_MODE_WIDTH                      1  /* MICB2_MODE */
+#define WM8958_MICB2_LVL_MASK                   0x000E  /* MICB2_LVL - [3:1] */
+#define WM8958_MICB2_LVL_SHIFT                       1  /* MICB2_LVL - [3:1] */
+#define WM8958_MICB2_LVL_WIDTH                       3  /* MICB2_LVL - [3:1] */
+#define WM8958_MICB2_DISCH                      0x0001  /* MICB2_DISCH */
+#define WM8958_MICB2_DISCH_MASK                 0x0001  /* MICB2_DISCH */
+#define WM8958_MICB2_DISCH_SHIFT                     0  /* MICB2_DISCH */
+#define WM8958_MICB2_DISCH_WIDTH                     1  /* MICB2_DISCH */
+
+/*
  * R76 (0x4C) - Charge Pump (1)
  */
 #define WM8994_CP_ENA                           0x8000  /* CP_ENA */
-- 
1.7.5.4
