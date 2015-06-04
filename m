From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 09/22] DT/sound: bindings header file for
	tas2552 codec
Date: Thu, 4 Jun 2015 15:22:33 +0300
Message-ID: <1433420571-5421-10-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2910B2664B2
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:18 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Binding header file for clock input selection and configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/dt-bindings/sound/tas2552.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/sound/tas2552.h

diff --git a/include/dt-bindings/sound/tas2552.h b/include/dt-bindings/sound/tas2552.h
new file mode 100644
index 000000000000..a4e1a079980b
--- /dev/null
+++ b/include/dt-bindings/sound/tas2552.h
@@ -0,0 +1,18 @@
+#ifndef __DT_TAS2552_H
+#define __DT_TAS2552_H
+
+#define TAS2552_PLL_CLKIN		(0)
+#define TAS2552_PDM_CLK			(1)
+#define TAS2552_CLK_TARGET_MASK		(1)
+
+#define TAS2552_PLL_CLKIN_MCLK		((0 << 1) | TAS2552_PLL_CLKIN)
+#define TAS2552_PLL_CLKIN_BCLK		((1 << 1) | TAS2552_PLL_CLKIN)
+#define TAS2552_PLL_CLKIN_IVCLKIN	((2 << 1) | TAS2552_PLL_CLKIN)
+#define TAS2552_PLL_CLKIN_1_8_FIXED	((3 << 1) | TAS2552_PLL_CLKIN)
+
+#define TAS2552_PDM_CLK_PLL		((0 << 1) | TAS2552_PDM_CLK)
+#define TAS2552_PDM_CLK_IVCLKIN		((1 << 1) | TAS2552_PDM_CLK)
+#define TAS2552_PDM_CLK_BCLK		((2 << 1) | TAS2552_PDM_CLK)
+#define TAS2552_PDM_CLK_MCLK		((3 << 1) | TAS2552_PDM_CLK)
+
+#endif /* __DT_TAS2552_H */
-- 
2.4.2
