From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Define constants for WM8962 GPIO
	functions
Date: Mon, 25 Apr 2011 20:15:04 +0100
Message-ID: <1303758905-5638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 596A1244F8
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Apr 2011 21:15:20 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm8962.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/sound/wm8962.h b/include/sound/wm8962.h
index 2b5306c..1750bed 100644
--- a/include/sound/wm8962.h
+++ b/include/sound/wm8962.h
@@ -14,6 +14,28 @@
 /* Use to set GPIO default values to zero */
 #define WM8962_GPIO_SET 0x10000
 
+#define WM8962_GPIO_FN_CLKOUT           0
+#define WM8962_GPIO_FN_LOGIC            1
+#define WM8962_GPIO_FN_SDOUT            2
+#define WM8962_GPIO_FN_IRQ              3
+#define WM8962_GPIO_FN_THERMAL          4
+#define WM8962_GPIO_FN_PLL2_LOCK        6
+#define WM8962_GPIO_FN_PLL3_LOCK        7
+#define WM8962_GPIO_FN_FLL_LOCK         9
+#define WM8962_GPIO_FN_DRC_ACT         10
+#define WM8962_GPIO_FN_WSEQ_DONE       11
+#define WM8962_GPIO_FN_ALC_NG_ACT      12
+#define WM8962_GPIO_FN_ALC_PEAK_LIMIT  13
+#define WM8962_GPIO_FN_ALC_SATURATION  14
+#define WM8962_GPIO_FN_ALC_LEVEL_THR   15
+#define WM8962_GPIO_FN_ALC_LEVEL_LOCK  16
+#define WM8962_GPIO_FN_FIFO_ERR        17
+#define WM8962_GPIO_FN_OPCLK           18
+#define WM8962_GPIO_FN_DMICCLK         19
+#define WM8962_GPIO_FN_DMICDAT         20
+#define WM8962_GPIO_FN_MICD            21
+#define WM8962_GPIO_FN_MICSCD          22
+
 struct wm8962_pdata {
 	int gpio_base;
 	u32 gpio_init[WM8962_MAX_GPIO];
-- 
1.7.4.1
