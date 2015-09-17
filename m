From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V1 3/3] ASoC: fsl_asrc: spba clock is needed by
	asrc device
Date: Thu, 17 Sep 2015 14:09:25 +0800
Message-ID: <5fbfbb7bc7598009b52023b336b6ad104ed39c42.1442469788.git.shengjiu.wang@freescale.com>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0106.outbound.protection.outlook.com [65.55.169.106])
 by alsa0.perex.cz (Postfix) with ESMTP id 1265D26513A
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 08:09:42 +0200 (CEST)
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

asrc need to enable the spba clock, when sdma is using share peripheral
script. If don't enable it, may cause the read/write wrong data from/to
register.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt |  2 ++
 sound/soc/fsl/fsl_asrc.c                             | 12 ++++++++++++
 sound/soc/fsl/fsl_asrc.h                             |  1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index b93362a..90a8cd6 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -25,6 +25,8 @@ Required properties:
 	"mem"		  Peripheral access clock to access registers.
 	"ipg"		  Peripheral clock to driver module.
 	"asrck_<0-f>"	  Clock sources for input and output clock.
+	"dma"		  The spba clock is needed when sdma share peripheral
+			  script is used.
 
    - big-endian		: If this property is absent, the little endian mode
 			  will be in use as default. Otherwise, the big endian
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 9f087d4..5ec1eae 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -859,6 +859,12 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return PTR_ERR(asrc_priv->ipg_clk);
 	}
 
+	asrc_priv->dma_clk = devm_clk_get(&pdev->dev, "dma");
+	if (IS_ERR(asrc_priv->dma_clk)) {
+		dev_err(&pdev->dev, "failed to get dma script clock\n");
+		return PTR_ERR(asrc_priv->dma_clk);
+	}
+
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
 		sprintf(tmp, "asrck_%x", i);
 		asrc_priv->asrck_clk[i] = devm_clk_get(&pdev->dev, tmp);
@@ -939,6 +945,9 @@ static int fsl_asrc_runtime_resume(struct device *dev)
 	ret = clk_prepare_enable(asrc_priv->ipg_clk);
 	if (ret)
 		goto disable_mem_clk;
+	ret = clk_prepare_enable(asrc_priv->dma_clk);
+	if (ret)
+		goto disable_ipg_clk;
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
 		ret = clk_prepare_enable(asrc_priv->asrck_clk[i]);
 		if (ret)
@@ -950,6 +959,8 @@ static int fsl_asrc_runtime_resume(struct device *dev)
 disable_asrck_clk:
 	for (i--; i >= 0; i--)
 		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
+	clk_disable_unprepare(asrc_priv->dma_clk);
+disable_ipg_clk:
 	clk_disable_unprepare(asrc_priv->ipg_clk);
 disable_mem_clk:
 	clk_disable_unprepare(asrc_priv->mem_clk);
@@ -963,6 +974,7 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
 
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
 		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
+	clk_disable_unprepare(asrc_priv->dma_clk);
 	clk_disable_unprepare(asrc_priv->ipg_clk);
 	clk_disable_unprepare(asrc_priv->mem_clk);
 
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 4aed63c..1bb13c2 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -442,6 +442,7 @@ struct fsl_asrc {
 	unsigned long paddr;
 	struct clk *mem_clk;
 	struct clk *ipg_clk;
+	struct clk *dma_clk;
 	struct clk *asrck_clk[ASRC_CLK_MAX_NUM];
 	spinlock_t lock;
 
-- 
1.9.1
