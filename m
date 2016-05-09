From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: davinci-mcasp: Use defines for
	clkdiv IDs
Date: Mon, 9 May 2016 13:42:29 +0300
Message-ID: <1462790552-6438-2-git-send-email-peter.ujfalusi@ti.com>
References: <1462790552-6438-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 69725265770
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 12:42:38 +0200 (CEST)
In-Reply-To: <1462790552-6438-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Instead of hardwired IDs add defines for the available dividers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 7 ++++---
 sound/soc/davinci/davinci-mcasp.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index a4e7af7efb00..836f694e4b9d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -547,14 +547,14 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 
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
@@ -563,7 +563,8 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 			mcasp->bclk_div = div;
 		break;
 
-	case 2:	/*
+	case MCASP_CLKDIV_BCLK_FS_RATIO:
+		/*
 		 * BCLK/LRCLK ratio descries how many bit-clock cycles
 		 * fit into one frame. The clock ratio is given for a
 		 * full period of data (for I2S format both left and
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index a3be108a8c17..1e8787fb3fb7 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -306,4 +306,9 @@
 #define NUMEVT(x)	(((x) & 0xFF) << 8)
 #define NUMDMA_MASK	(0xFF)
 
+/* clock divider IDs */
+#define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
+#define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
+#define MCASP_CLKDIV_BCLK_FS_RATIO	2 /* to set BCLK FS ration */
+
 #endif	/* DAVINCI_MCASP_H */
-- 
2.8.2
