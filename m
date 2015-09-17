From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V1 1/3] ASoC: fsl_esai: spba clock is needed by
	esai device
Date: Thu, 17 Sep 2015 14:09:23 +0800
Message-ID: <dcd22cb04ad5b12478ed9a24ff1462fbc4d5be51.1442469788.git.shengjiu.wang@freescale.com>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DE9C261ABB
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 08:09:36 +0200 (CEST)
In-Reply-To: <cover.1442469788.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

esai need to enable the spba clock, when sdma is using share peripheral
script. If don't enable it, may cause the read/write wrong data from/to
register.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl,esai.txt |  2 ++
 sound/soc/fsl/fsl_esai.c                             | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
index d3b6b5f..d677203 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
@@ -27,6 +27,8 @@ Required properties:
 			  derive HCK, SCK and FS.
 	"fsys"		  The system clock derived from ahb clock used to
 			  derive HCK, SCK and FS.
+	"dma"		  The spba clock is needed when sdma share peripheral
+			  script is used.
 
   - fsl,fifo-depth	: The number of elements in the transmit and receive
 			  FIFOs. This number is the maximum allowed value for
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 837979e..4e99818 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -54,6 +54,7 @@ struct fsl_esai {
 	struct clk *coreclk;
 	struct clk *extalclk;
 	struct clk *fsysclk;
+	struct clk *dmaclk;
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
@@ -469,6 +470,9 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
 	ret = clk_prepare_enable(esai_priv->coreclk);
 	if (ret)
 		return ret;
+	ret = clk_prepare_enable(esai_priv->dmaclk);
+	if (ret)
+		return ret;
 	if (!IS_ERR(esai_priv->extalclk)) {
 		ret = clk_prepare_enable(esai_priv->extalclk);
 		if (ret)
@@ -499,6 +503,7 @@ err_fsysclk:
 	if (!IS_ERR(esai_priv->extalclk))
 		clk_disable_unprepare(esai_priv->extalclk);
 err_extalck:
+	clk_disable_unprepare(esai_priv->dmaclk);
 	clk_disable_unprepare(esai_priv->coreclk);
 
 	return ret;
@@ -564,6 +569,7 @@ static void fsl_esai_shutdown(struct snd_pcm_substream *substream,
 		clk_disable_unprepare(esai_priv->fsysclk);
 	if (!IS_ERR(esai_priv->extalclk))
 		clk_disable_unprepare(esai_priv->extalclk);
+	clk_disable_unprepare(esai_priv->dmaclk);
 	clk_disable_unprepare(esai_priv->coreclk);
 }
 
@@ -772,6 +778,13 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "failed to get fsys clock: %ld\n",
 				PTR_ERR(esai_priv->fsysclk));
 
+	esai_priv->dmaclk = devm_clk_get(&pdev->dev, "dma");
+	if (IS_ERR(esai_priv->dmaclk)) {
+		dev_err(&pdev->dev, "Cannot get dma clock: %ld\n",
+				PTR_ERR(esai_priv->dmaclk));
+		return PTR_ERR(esai_priv->dmaclk);
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
-- 
1.9.1
