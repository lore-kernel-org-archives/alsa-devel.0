From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] mfd: wm5102: Expose DRE control registers
Date: Wed, 12 Jun 2013 17:44:07 +0100
Message-ID: <1371055448-31316-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFFFC265038
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 18:53:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Certain use cases may require specific DRE settings so expose the
necessary registers.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5102-tables.c           |    9 ++++++-
 include/linux/mfd/arizona/registers.h |   44 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/wm5102-tables.c b/drivers/mfd/wm5102-tables.c
index 155c4a1..802dd3c 100644
--- a/drivers/mfd/wm5102-tables.c
+++ b/drivers/mfd/wm5102-tables.c
@@ -65,7 +65,8 @@ static const struct reg_default wm5102_revb_patch[] = {
 	{ 0x418, 0xa080 },
 	{ 0x420, 0xa080 },
 	{ 0x428, 0xe000 },
-	{ 0x443, 0xDC1A },
+	{ 0x442, 0x3F0A },
+	{ 0x443, 0xDC1F },
 	{ 0x4B0, 0x0066 },
 	{ 0x458, 0x000b },
 	{ 0x212, 0x0000 },
@@ -424,6 +425,9 @@ static const struct reg_default wm5102_reg_default[] = {
 	{ 0x00000435, 0x0180 },   /* R1077  - DAC Digital Volume 5R */ 
 	{ 0x00000436, 0x0081 },   /* R1078  - DAC Volume Limit 5R */
 	{ 0x00000437, 0x0200 },   /* R1079  - Noise Gate Select 5R */
+	{ 0x00000440, 0x8FFF },   /* R1088  - DRE Enable */
+	{ 0x00000442, 0x3F0A },   /* R1090  - DRE Control 2 */
+	{ 0x00000443, 0xDC1F },   /* R1090  - DRE Control 3 */
 	{ 0x00000450, 0x0000 },   /* R1104  - DAC AEC Control 1 */ 
 	{ 0x00000458, 0x000B },   /* R1112  - Noise Gate Control */
 	{ 0x00000490, 0x0069 },   /* R1168  - PDM SPK1 CTRL 1 */ 
@@ -1197,6 +1201,9 @@ static bool wm5102_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_DAC_DIGITAL_VOLUME_5R:
 	case ARIZONA_DAC_VOLUME_LIMIT_5R:
 	case ARIZONA_NOISE_GATE_SELECT_5R:
+	case ARIZONA_DRE_ENABLE:
+	case ARIZONA_DRE_CONTROL_2:
+	case ARIZONA_DRE_CONTROL_3:
 	case ARIZONA_DAC_AEC_CONTROL_1:
 	case ARIZONA_NOISE_GATE_CONTROL:
 	case ARIZONA_PDM_SPK1_CTRL_1:
diff --git a/include/linux/mfd/arizona/registers.h b/include/linux/mfd/arizona/registers.h
index 4730b5c..4706d3d 100644
--- a/include/linux/mfd/arizona/registers.h
+++ b/include/linux/mfd/arizona/registers.h
@@ -215,6 +215,9 @@
 #define ARIZONA_DAC_DIGITAL_VOLUME_6R            0x43D
 #define ARIZONA_DAC_VOLUME_LIMIT_6R              0x43E
 #define ARIZONA_NOISE_GATE_SELECT_6R             0x43F
+#define ARIZONA_DRE_ENABLE                       0x440
+#define ARIZONA_DRE_CONTROL_2                    0x442
+#define ARIZONA_DRE_CONTROL_3                    0x443
 #define ARIZONA_DAC_AEC_CONTROL_1                0x450
 #define ARIZONA_NOISE_GATE_CONTROL               0x458
 #define ARIZONA_PDM_SPK1_CTRL_1                  0x490
@@ -3133,6 +3136,47 @@
 #define ARIZONA_OUT6R_NGATE_SRC_WIDTH                12  /* OUT6R_NGATE_SRC - [11:0] */
 
 /*
+ * R1088 (0x440) - DRE Enable
+ */
+#define ARIZONA_DRE3L_ENA                        0x0010  /* DRE3L_ENA */
+#define ARIZONA_DRE3L_ENA_MASK                   0x0010  /* DRE3L_ENA */
+#define ARIZONA_DRE3L_ENA_SHIFT                       4  /* DRE3L_ENA */
+#define ARIZONA_DRE3L_ENA_WIDTH                       1  /* DRE3L_ENA */
+#define ARIZONA_DRE2R_ENA                        0x0008  /* DRE2R_ENA */
+#define ARIZONA_DRE2R_ENA_MASK                   0x0008  /* DRE2R_ENA */
+#define ARIZONA_DRE2R_ENA_SHIFT                       3  /* DRE2R_ENA */
+#define ARIZONA_DRE2R_ENA_WIDTH                       1  /* DRE2R_ENA */
+#define ARIZONA_DRE2L_ENA                        0x0004  /* DRE2L_ENA */
+#define ARIZONA_DRE2L_ENA_MASK                   0x0004  /* DRE2L_ENA */
+#define ARIZONA_DRE2L_ENA_SHIFT                       2  /* DRE2L_ENA */
+#define ARIZONA_DRE2L_ENA_WIDTH                       1  /* DRE2L_ENA */
+#define ARIZONA_DRE1R_ENA                        0x0002  /* DRE1R_ENA */
+#define ARIZONA_DRE1R_ENA_MASK                   0x0002  /* DRE1R_ENA */
+#define ARIZONA_DRE1R_ENA_SHIFT                       1  /* DRE1R_ENA */
+#define ARIZONA_DRE1R_ENA_WIDTH                       1  /* DRE1R_ENA */
+#define ARIZONA_DRE1L_ENA                        0x0001  /* DRE1L_ENA */
+#define ARIZONA_DRE1L_ENA_MASK                   0x0001  /* DRE1L_ENA */
+#define ARIZONA_DRE1L_ENA_SHIFT                       0  /* DRE1L_ENA */
+#define ARIZONA_DRE1L_ENA_WIDTH                       1  /* DRE1L_ENA */
+
+/*
+ * R1090 (0x442) - DRE Control 2
+ */
+#define ARIZONA_DRE_T_LOW_MASK                   0x3F00  /* DRE_T_LOW - [13:8] */
+#define ARIZONA_DRE_T_LOW_SHIFT                       8  /* DRE_T_LOW - [13:8] */
+#define ARIZONA_DRE_T_LOW_WIDTH                       6  /* DRE_T_LOW - [13:8] */
+
+/*
+ * R1091 (0x443) - DRE Control 3
+ */
+#define ARIZONA_DRE_GAIN_SHIFT_MASK              0xC000  /* DRE_GAIN_SHIFT - [15:14] */
+#define ARIZONA_DRE_GAIN_SHIFT_SHIFT                 14  /* DRE_GAIN_SHIFT - [15:14] */
+#define ARIZONA_DRE_GAIN_SHIFT_WIDTH                  2  /* DRE_GAIN_SHIFT - [15:14] */
+#define ARIZONA_DRE_LOW_LEVEL_ABS_MASK           0x000F  /* LOW_LEVEL_ABS - [3:0] */
+#define ARIZONA_DRE_LOW_LEVEL_ABS_SHIFT               0  /* LOW_LEVEL_ABS - [3:0] */
+#define ARIZONA_DRE_LOW_LEVEL_ABS_WIDTH               4  /* LOW_LEVEL_ABS - [3:0] */
+
+/*
  * R1104 (0x450) - DAC AEC Control 1
  */
 #define ARIZONA_AEC_LOOPBACK_SRC_MASK            0x003C  /* AEC_LOOPBACK_SRC - [5:2] */
-- 
1.7.2.5
