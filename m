From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: davinci-mcasp: Use defines for
	clkdiv IDs via DT binding header
Date: Mon, 15 Feb 2016 16:11:32 +0200
Message-ID: <1455545495-20292-2-git-send-email-peter.ujfalusi@ti.com>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EAF87261721
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 15:11:45 +0100 (CET)
In-Reply-To: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Instead of hardwired IDs add defines to select which divider to configure.
The defines are placed in the dt binding header so legacy and DT files can
both use them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/dt-bindings/sound/ti-mcasp.h | 9 +++++++++
 sound/soc/davinci/davinci-mcasp.c    | 8 +++++---
 2 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/sound/ti-mcasp.h

diff --git a/include/dt-bindings/sound/ti-mcasp.h b/include/dt-bindings/sound/ti-mcasp.h
new file mode 100644
index 000000000000..03519ab67b44
--- /dev/null
+++ b/include/dt-bindings/sound/ti-mcasp.h
@@ -0,0 +1,9 @@
+#ifndef _DT_BINDINGS_TI_MCASP_H
+#define _DT_BINDINGS_TI_MCASP_H
+
+/* clock divider IDs */
+#define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
+#define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
+#define MCASP_CLKDIV_BCLK_FS_RATIO	2 /* to set BCLK FS ration */
+
+#endif /* _DT_BINDINGS_TI_MCASP_H */
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 3cf46afb353f..a4e40606742a 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -37,6 +37,7 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/omap-pcm.h>
+#include <dt-bindings/sound/ti-mcasp.h>
 
 #include "edma-pcm.h"
 #include "davinci-mcasp.h"
@@ -541,14 +542,14 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 
 	pm_runtime_get_sync(mcasp->dev);
 	switch (div_id) {
-	case 0:		/* MCLK divider */
+	case MCASP_CLKDIV_AUXCLK:			/* MCLK divider */
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
 			       AHCLKXDIV(div - 1), AHCLKXDIV_MASK);
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
 			       AHCLKRDIV(div - 1), AHCLKRDIV_MASK);
 		break;
 
-	case 1:		/* BCLK divider */
+	case MCASP_CLKDIV_BCLK:			/* BCLK divider */
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG,
 			       ACLKXDIV(div - 1), ACLKXDIV_MASK);
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG,
@@ -557,7 +558,8 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 			mcasp->bclk_div = div;
 		break;
 
-	case 2:	/*
+	case MCASP_CLKDIV_BCLK_FS_RATIO:
+		/*
 		 * BCLK/LRCLK ratio descries how many bit-clock cycles
 		 * fit into one frame. The clock ratio is given for a
 		 * full period of data (for I2S format both left and
-- 
2.7.1
