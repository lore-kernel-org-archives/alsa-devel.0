From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: fsl_esai: Check the return value from
	clk_prepare_enable()
Date: Mon, 10 Feb 2014 16:01:28 -0200
Message-ID: <1392055288-20148-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id E009F2625DB
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 19:01:43 +0100 (CET)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index d0c72ed..e64115c 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -431,17 +431,26 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int fsl_esai_startup(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
+	int ret;
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
 
 	/*
 	 * Some platforms might use the same bit to gate all three or two of
 	 * clocks, so keep all clocks open/close at the same time for safety
 	 */
-	clk_prepare_enable(esai_priv->coreclk);
-	if (!IS_ERR(esai_priv->extalclk))
-		clk_prepare_enable(esai_priv->extalclk);
-	if (!IS_ERR(esai_priv->fsysclk))
-		clk_prepare_enable(esai_priv->fsysclk);
+	ret = clk_prepare_enable(esai_priv->coreclk);
+	if (ret)
+		return ret;
+	if (!IS_ERR(esai_priv->extalclk)) {
+		ret = clk_prepare_enable(esai_priv->extalclk);
+		if (ret)
+			goto err_extalck;
+	}
+	if (!IS_ERR(esai_priv->fsysclk)) {
+		ret = clk_prepare_enable(esai_priv->fsysclk);
+		if (ret)
+			goto err_fsysclk;
+	}
 
 	if (!dai->active) {
 		/* Reset Port C */
@@ -463,6 +472,14 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
 	}
 
 	return 0;
+
+err_fsysclk:
+	if (!IS_ERR(esai_priv->extalclk))
+		clk_disable_unprepare(esai_priv->extalclk);
+err_extalck:
+	clk_disable_unprepare(esai_priv->coreclk);
+
+	return ret;
 }
 
 static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
-- 
1.8.1.2
