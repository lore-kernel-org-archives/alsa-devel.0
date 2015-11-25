From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_asrc: spba clock is needed by asrc
	device" to the asoc tree
Date: Wed, 25 Nov 2015 13:00:03 +0000
Message-ID: <E1a1Zg3-0002pY-2I@debutante>
References: <9ef23a7376b28ae9144f036dbc5d74e3c3240109.1448356624.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F6502606CD
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:13 +0100 (CET)
In-Reply-To: <9ef23a7376b28ae9144f036dbc5d74e3c3240109.1448356624.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_asrc: spba clock is needed by asrc device

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

>From 13b8a97a760eee021558dc48fd65e77e8a362909 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@freescale.com>
Date: Tue, 24 Nov 2015 17:19:34 +0800
Subject: [PATCH] ASoC: fsl_asrc: spba clock is needed by asrc device

ASRC need to enable the spba clock, when sdma is using share peripheral
script. In this case, there is two spba master port is used, if don't
enable the clock, the spba bus will have arbitration issue, which may
cause read/write wrong data from/to ASRC registers

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt |  5 +++++
 sound/soc/fsl/fsl_asrc.c                             | 14 ++++++++++++++
 sound/soc/fsl/fsl_asrc.h                             |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index b93362a570be..3e26a9478e57 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -25,6 +25,11 @@ Required properties:
 	"mem"		  Peripheral access clock to access registers.
 	"ipg"		  Peripheral clock to driver module.
 	"asrck_<0-f>"	  Clock sources for input and output clock.
+	"spba"		  The spba clock is required when ASRC is placed as a
+			  bus slave of the Shared Peripheral Bus and when two
+			  or more bus masters (CPU, DMA or DSP) try to access
+			  it. This property is optional depending on the SoC
+			  design.
 
    - big-endian		: If this property is absent, the little endian mode
 			  will be in use as default. Otherwise, the big endian
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 9f087d4f73ed..cf382475670b 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -859,6 +859,10 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return PTR_ERR(asrc_priv->ipg_clk);
 	}
 
+	asrc_priv->spba_clk = devm_clk_get(&pdev->dev, "spba");
+	if (IS_ERR(asrc_priv->spba_clk))
+		dev_warn(&pdev->dev, "failed to get spba clock\n");
+
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
 		sprintf(tmp, "asrck_%x", i);
 		asrc_priv->asrck_clk[i] = devm_clk_get(&pdev->dev, tmp);
@@ -939,6 +943,11 @@ static int fsl_asrc_runtime_resume(struct device *dev)
 	ret = clk_prepare_enable(asrc_priv->ipg_clk);
 	if (ret)
 		goto disable_mem_clk;
+	if (!IS_ERR(asrc_priv->spba_clk)) {
+		ret = clk_prepare_enable(asrc_priv->spba_clk);
+		if (ret)
+			goto disable_ipg_clk;
+	}
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
 		ret = clk_prepare_enable(asrc_priv->asrck_clk[i]);
 		if (ret)
@@ -950,6 +959,9 @@ static int fsl_asrc_runtime_resume(struct device *dev)
 disable_asrck_clk:
 	for (i--; i >= 0; i--)
 		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
+	if (!IS_ERR(asrc_priv->spba_clk))
+		clk_disable_unprepare(asrc_priv->spba_clk);
+disable_ipg_clk:
 	clk_disable_unprepare(asrc_priv->ipg_clk);
 disable_mem_clk:
 	clk_disable_unprepare(asrc_priv->mem_clk);
@@ -963,6 +975,8 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
 
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
 		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
+	if (!IS_ERR(asrc_priv->spba_clk))
+		clk_disable_unprepare(asrc_priv->spba_clk);
 	clk_disable_unprepare(asrc_priv->ipg_clk);
 	clk_disable_unprepare(asrc_priv->mem_clk);
 
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 4aed63c4b431..68802cdc3f28 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -426,6 +426,7 @@ struct fsl_asrc_pair {
  * @paddr: physical address to the base address of registers
  * @mem_clk: clock source to access register
  * @ipg_clk: clock source to drive peripheral
+ * @spba_clk: SPBA clock (optional, depending on SoC design)
  * @asrck_clk: clock sources to driver ASRC internal logic
  * @lock: spin lock for resource protection
  * @pair: pair pointers
@@ -442,6 +443,7 @@ struct fsl_asrc {
 	unsigned long paddr;
 	struct clk *mem_clk;
 	struct clk *ipg_clk;
+	struct clk *spba_clk;
 	struct clk *asrck_clk[ASRC_CLK_MAX_NUM];
 	spinlock_t lock;
 
-- 
2.6.2
