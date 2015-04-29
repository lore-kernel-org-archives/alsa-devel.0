From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 1/8] mfd: arizona: Split INx_MODE into two fields
Date: Wed, 29 Apr 2015 15:37:02 +0100
Message-ID: <1430318229-28518-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1430318229-28518-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430318229-28518-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com
Cc: myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Later arizona silicon has the single/differential selector
in a different register, and IN1_MODE only selects between
analogue or digital. Prepare for this by splitting the
INx_MODE definition into two fields.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/mfd/arizona-core.c            |    8 ++++++--
 include/linux/mfd/arizona/pdata.h     |    5 ++++-
 include/linux/mfd/arizona/registers.h |   27 ++++++++++++++++++---------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 6ca6dfa..33fa5b5 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -977,12 +977,16 @@ int arizona_dev_init(struct arizona *arizona)
 		/* Default for both is 0 so noop with defaults */
 		val = arizona->pdata.dmic_ref[i]
 			<< ARIZONA_IN1_DMIC_SUP_SHIFT;
-		val |= arizona->pdata.inmode[i] << ARIZONA_IN1_MODE_SHIFT;
+		if (arizona->pdata.inmode[i] & ARIZONA_INMODE_DMIC)
+			val |= 1 << ARIZONA_IN1_MODE_SHIFT;
+		if (arizona->pdata.inmode[i] & ARIZONA_INMODE_SE)
+			val |= 1 << ARIZONA_IN1_SINGLE_ENDED_SHIFT;
 
 		regmap_update_bits(arizona->regmap,
 				   ARIZONA_IN1L_CONTROL + (i * 8),
 				   ARIZONA_IN1_DMIC_SUP_MASK |
-				   ARIZONA_IN1_MODE_MASK, val);
+				   ARIZONA_IN1_MODE_MASK |
+				   ARIZONA_IN1_SINGLE_ENDED_MASK, val);
 	}
 
 	for (i = 0; i < ARIZONA_MAX_OUTPUT; i++) {
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 1789cb0..f672267 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -156,7 +156,10 @@ struct arizona_pdata {
 	/** MICBIAS configurations */
 	struct arizona_micbias micbias[ARIZONA_MAX_MICBIAS];
 
-	/** Mode of input structures */
+	/**
+	 * Mode of input structures
+	 * One of the ARIZONA_INMODE_xxx values
+	 */
 	int inmode[ARIZONA_MAX_INPUT];
 
 	/** Mode for outputs */
diff --git a/include/linux/mfd/arizona/registers.h b/include/linux/mfd/arizona/registers.h
index aacc10d..3499d36 100644
--- a/include/linux/mfd/arizona/registers.h
+++ b/include/linux/mfd/arizona/registers.h
@@ -2515,9 +2515,12 @@
 #define ARIZONA_IN1_DMIC_SUP_MASK                0x1800  /* IN1_DMIC_SUP - [12:11] */
 #define ARIZONA_IN1_DMIC_SUP_SHIFT                   11  /* IN1_DMIC_SUP - [12:11] */
 #define ARIZONA_IN1_DMIC_SUP_WIDTH                    2  /* IN1_DMIC_SUP - [12:11] */
-#define ARIZONA_IN1_MODE_MASK                    0x0600  /* IN1_MODE - [10:9] */
-#define ARIZONA_IN1_MODE_SHIFT                        9  /* IN1_MODE - [10:9] */
-#define ARIZONA_IN1_MODE_WIDTH                        2  /* IN1_MODE - [10:9] */
+#define ARIZONA_IN1_MODE_MASK                    0x0400  /* IN1_MODE - [10] */
+#define ARIZONA_IN1_MODE_SHIFT                       10  /* IN1_MODE - [10] */
+#define ARIZONA_IN1_MODE_WIDTH                        1  /* IN1_MODE - [10] */
+#define ARIZONA_IN1_SINGLE_ENDED_MASK            0x0200  /* IN1_MODE - [9] */
+#define ARIZONA_IN1_SINGLE_ENDED_SHIFT                9  /* IN1_MODE - [9] */
+#define ARIZONA_IN1_SINGLE_ENDED_WIDTH                1  /* IN1_MODE - [9] */
 #define ARIZONA_IN1L_PGA_VOL_MASK                0x00FE  /* IN1L_PGA_VOL - [7:1] */
 #define ARIZONA_IN1L_PGA_VOL_SHIFT                    1  /* IN1L_PGA_VOL - [7:1] */
 #define ARIZONA_IN1L_PGA_VOL_WIDTH                    7  /* IN1L_PGA_VOL - [7:1] */
@@ -2588,9 +2591,12 @@
 #define ARIZONA_IN2_DMIC_SUP_MASK                0x1800  /* IN2_DMIC_SUP - [12:11] */
 #define ARIZONA_IN2_DMIC_SUP_SHIFT                   11  /* IN2_DMIC_SUP - [12:11] */
 #define ARIZONA_IN2_DMIC_SUP_WIDTH                    2  /* IN2_DMIC_SUP - [12:11] */
-#define ARIZONA_IN2_MODE_MASK                    0x0600  /* IN2_MODE - [10:9] */
-#define ARIZONA_IN2_MODE_SHIFT                        9  /* IN2_MODE - [10:9] */
-#define ARIZONA_IN2_MODE_WIDTH                        2  /* IN2_MODE - [10:9] */
+#define ARIZONA_IN2_MODE_MASK                    0x0400  /* IN2_MODE - [10] */
+#define ARIZONA_IN2_MODE_SHIFT                       10  /* IN2_MODE - [10] */
+#define ARIZONA_IN2_MODE_WIDTH                        1  /* IN2_MODE - [10] */
+#define ARIZONA_IN2_SINGLE_ENDED_MASK            0x0200  /* IN2_MODE - [9] */
+#define ARIZONA_IN2_SINGLE_ENDED_SHIFT                9  /* IN2_MODE - [9] */
+#define ARIZONA_IN2_SINGLE_ENDED_WIDTH                1  /* IN2_MODE - [9] */
 #define ARIZONA_IN2L_PGA_VOL_MASK                0x00FE  /* IN2L_PGA_VOL - [7:1] */
 #define ARIZONA_IN2L_PGA_VOL_SHIFT                    1  /* IN2L_PGA_VOL - [7:1] */
 #define ARIZONA_IN2L_PGA_VOL_WIDTH                    7  /* IN2L_PGA_VOL - [7:1] */
@@ -2661,9 +2667,12 @@
 #define ARIZONA_IN3_DMIC_SUP_MASK                0x1800  /* IN3_DMIC_SUP - [12:11] */
 #define ARIZONA_IN3_DMIC_SUP_SHIFT                   11  /* IN3_DMIC_SUP - [12:11] */
 #define ARIZONA_IN3_DMIC_SUP_WIDTH                    2  /* IN3_DMIC_SUP - [12:11] */
-#define ARIZONA_IN3_MODE_MASK                    0x0600  /* IN3_MODE - [10:9] */
-#define ARIZONA_IN3_MODE_SHIFT                        9  /* IN3_MODE - [10:9] */
-#define ARIZONA_IN3_MODE_WIDTH                        2  /* IN3_MODE - [10:9] */
+#define ARIZONA_IN3_MODE_MASK                    0x0400  /* IN3_MODE - [10] */
+#define ARIZONA_IN3_MODE_SHIFT                       10  /* IN3_MODE - [10] */
+#define ARIZONA_IN3_MODE_WIDTH                        1  /* IN3_MODE - [10] */
+#define ARIZONA_IN3_SINGLE_ENDED_MASK            0x0200  /* IN3_MODE - [9] */
+#define ARIZONA_IN3_SINGLE_ENDED_SHIFT                9  /* IN3_MODE - [9] */
+#define ARIZONA_IN3_SINGLE_ENDED_WIDTH                1  /* IN3_MODE - [9] */
 #define ARIZONA_IN3L_PGA_VOL_MASK                0x00FE  /* IN3L_PGA_VOL - [7:1] */
 #define ARIZONA_IN3L_PGA_VOL_SHIFT                    1  /* IN3L_PGA_VOL - [7:1] */
 #define ARIZONA_IN3L_PGA_VOL_WIDTH                    7  /* IN3L_PGA_VOL - [7:1] */
-- 
1.7.2.5

