From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: fsl_asrc: Check for
	clk_prepare_enable() error" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:59 +0100
Message-ID: <E1ZCTNn-0005ZQ-8z@finisterre>
References: <1434834013-23088-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F622265733
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:12 +0200 (CEST)
In-Reply-To: <1434834013-23088-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: fsl_asrc: Check for clk_prepare_enable() error

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b1ade0f2afe283d59eb313e5717870fdb831fc4e Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Sat, 20 Jun 2015 18:00:13 -0300
Subject: [PATCH] ASoC: fsl: fsl_asrc: Check for clk_prepare_enable() error

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c068494..9f087d4 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -931,14 +931,29 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 static int fsl_asrc_runtime_resume(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
-	int i;
+	int i, ret;
 
-	clk_prepare_enable(asrc_priv->mem_clk);
-	clk_prepare_enable(asrc_priv->ipg_clk);
-	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
-		clk_prepare_enable(asrc_priv->asrck_clk[i]);
+	ret = clk_prepare_enable(asrc_priv->mem_clk);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(asrc_priv->ipg_clk);
+	if (ret)
+		goto disable_mem_clk;
+	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
+		ret = clk_prepare_enable(asrc_priv->asrck_clk[i]);
+		if (ret)
+			goto disable_asrck_clk;
+	}
 
 	return 0;
+
+disable_asrck_clk:
+	for (i--; i >= 0; i--)
+		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
+	clk_disable_unprepare(asrc_priv->ipg_clk);
+disable_mem_clk:
+	clk_disable_unprepare(asrc_priv->mem_clk);
+	return ret;
 }
 
 static int fsl_asrc_runtime_suspend(struct device *dev)
-- 
2.1.4
