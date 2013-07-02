From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] mfd: arizona: Add GPIO control register
	bit definitions
Date: Tue,  2 Jul 2013 15:53:36 +0100
Message-ID: <1372776817-29811-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 825A4265484
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 17:00:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, sameo@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/linux/mfd/arizona/registers.h |   35 +++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/arizona/registers.h b/include/linux/mfd/arizona/registers.h
index 715b6ba..522798d 100644
--- a/include/linux/mfd/arizona/registers.h
+++ b/include/linux/mfd/arizona/registers.h
@@ -4131,6 +4131,41 @@
 #define ARIZONA_SLIMTX1_PORT_STS_WIDTH                1  /* SLIMTX1_PORT_STS */
 
 /*
+ * R3072 - R3076 (0xC00 - 0xC04) ARIZONA_GPIO1_CTRL - ARIZONA_GPIO5_CTRL
+ */
+#define ARIZONA_GPN_DIR                          0x8000  /* GPN_DIR */
+#define ARIZONA_GPN_DIR_MASK                     0x8000  /* GPN_DIR */
+#define ARIZONA_GPN_DIR_SHIFT                        15  /* GPN_DIR */
+#define ARIZONA_GPN_DIR_WIDTH                         1  /* GPN_DIR */
+#define ARIZONA_GPN_PU                           0x4000  /* GPN_PU */
+#define ARIZONA_GPN_PU_MASK                      0x4000  /* GPN_PU */
+#define ARIZONA_GPN_PU_SHIFT                         14  /* GPN_PU */
+#define ARIZONA_GPN_PU_WIDTH                          1  /* GPN_PU */
+#define ARIZONA_GPN_PD                           0x2000  /* GPN_PD */
+#define ARIZONA_GPN_PD_MASK                      0x2000  /* GPN_PD */
+#define ARIZONA_GPN_PD_SHIFT                         13  /* GPN_PD */
+#define ARIZONA_GPN_PD_WIDTH                          1  /* GPN_PD */
+#define ARIZONA_GPN_LVL                          0x0800  /* GPN_LVL */
+#define ARIZONA_GPN_LVL_MASK                     0x0800  /* GPN_LVL */
+#define ARIZONA_GPN_LVL_SHIFT                        11  /* GPN_LVL */
+#define ARIZONA_GPN_LVL_WIDTH                         1  /* GPN_LVL */
+#define ARIZONA_GPN_POL                          0x0400  /* GPN_POL */
+#define ARIZONA_GPN_POL_MASK                     0x0400  /* GPN_POL */
+#define ARIZONA_GPN_POL_SHIFT                        10  /* GPN_POL */
+#define ARIZONA_GPN_POL_WIDTH                         1  /* GPN_POL */
+#define ARIZONA_GPN_OP_CFG                       0x0200  /* GPN_OP_CFG */
+#define ARIZONA_GPN_OP_CFG_MASK                  0x0200  /* GPN_OP_CFG */
+#define ARIZONA_GPN_OP_CFG_SHIFT                      9  /* GPN_OP_CFG */
+#define ARIZONA_GPN_OP_CFG_WIDTH                      1  /* GPN_OP_CFG */
+#define ARIZONA_GPN_DB                           0x0100  /* GPN_DB */
+#define ARIZONA_GPN_DB_MASK                      0x0100  /* GPN_DB */
+#define ARIZONA_GPN_DB_SHIFT                          8  /* GPN_DB */
+#define ARIZONA_GPN_DB_WIDTH                          1  /* GPN_DB */
+#define ARIZONA_GPN_FN_MASK                      0x007F  /* GPN_DB */
+#define ARIZONA_GPN_FN_SHIFT                          0  /* GPN_DB */
+#define ARIZONA_GPN_FN_WIDTH                          7  /* GPN_DB */
+
+/*
  * R3087 (0xC0F) - IRQ CTRL 1
  */
 #define ARIZONA_IRQ_POL                          0x0400  /* IRQ_POL */
-- 
1.7.2.5
