From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 10/20] ASoC: davinci-mcasp: Move private struct
	definition to source file
Date: Thu, 14 Nov 2013 11:35:26 +0200
Message-ID: <1384421737-4467-11-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D44E261A27
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:36:04 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since it is a private struct strictly used by the davinci-mcasp driver it
can be moved from header file to the source file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 30 ++++++++++++++++++++++++++++++
 sound/soc/davinci/davinci-mcasp.h | 35 -----------------------------------
 2 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 1c1585e..7010795 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -37,6 +37,36 @@
 
 #define DAVINCI_MCASP_NUM_SERIALIZER	16
 
+struct davinci_audio_dev {
+	struct davinci_pcm_dma_params dma_params[2];
+	void __iomem *base;
+	struct device *dev;
+
+	/* McASP specific data */
+	int	tdm_slots;
+	u8	op_mode;
+	u8	num_serializer;
+	u8	*serial_dir;
+	u8	version;
+	u16	bclk_lrclk_ratio;
+
+	/* McASP FIFO related */
+	u8	txnumevt;
+	u8	rxnumevt;
+
+#ifdef CONFIG_PM_SLEEP
+	struct {
+		u32	txfmtctl;
+		u32	rxfmtctl;
+		u32	txfmt;
+		u32	rxfmt;
+		u32	aclkxctl;
+		u32	aclkrctl;
+		u32	pdir;
+	} context;
+#endif
+};
+
 static inline void mcasp_set_bits(void __iomem *reg, u32 val)
 {
 	__raw_writel(__raw_readl(reg) | val, reg);
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 619b98b..80e5a18 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -18,11 +18,6 @@
 #ifndef DAVINCI_MCASP_H
 #define DAVINCI_MCASP_H
 
-#include <linux/io.h>
-#include <linux/platform_data/davinci_asp.h>
-
-#include "davinci-pcm.h"
-
 /*
  * McASP register definitions
  */
@@ -290,34 +285,4 @@
 #define NUMEVT_MASK	(0xFF << 8)
 #define NUMDMA_MASK	(0xFF)
 
-struct davinci_audio_dev {
-	struct davinci_pcm_dma_params dma_params[2];
-	void __iomem *base;
-	struct device *dev;
-
-	/* McASP specific data */
-	int	tdm_slots;
-	u8	op_mode;
-	u8	num_serializer;
-	u8	*serial_dir;
-	u8	version;
-	u16	bclk_lrclk_ratio;
-
-	/* McASP FIFO related */
-	u8	txnumevt;
-	u8	rxnumevt;
-
-#ifdef CONFIG_PM_SLEEP
-	struct {
-		u32	txfmtctl;
-		u32	rxfmtctl;
-		u32	txfmt;
-		u32	rxfmt;
-		u32	aclkxctl;
-		u32	aclkrctl;
-		u32	pdir;
-	} context;
-#endif
-};
-
 #endif	/* DAVINCI_MCASP_H */
-- 
1.8.4.2
