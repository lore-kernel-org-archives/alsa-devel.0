From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_esai: spba clock is needed by esai
	device" to the asoc tree
Date: Wed, 25 Nov 2015 13:00:04 +0000
Message-ID: <E1a1Zg4-0002qV-VZ@debutante>
References: <1201ff5b1edf387138e3cb8c98f91804d9866c4d.1448356624.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AF05261B20
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:14 +0100 (CET)
In-Reply-To: <1201ff5b1edf387138e3cb8c98f91804d9866c4d.1448356624.git.shengjiu.wang@freescale.com>
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

   ASoC: fsl_esai: spba clock is needed by esai device

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

>From a2a4d6049aa18c0e105d9b53e3236cb50ea5bfa1 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@freescale.com>
Date: Tue, 24 Nov 2015 17:19:32 +0800
Subject: [PATCH] ASoC: fsl_esai: spba clock is needed by esai device

ESAI need to enable the spba clock, when sdma is using share peripheral
script. In this case, there is two spba master port is used, if don't
enable the clock, the spba bus will have arbitration issue, which may
cause read/write wrong data from/to ESAI registers.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl,esai.txt |  5 +++++
 sound/soc/fsl/fsl_esai.c                             | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
index d3b6b5f48010..cd3ee5d84f03 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
@@ -27,6 +27,11 @@ Required properties:
 			  derive HCK, SCK and FS.
 	"fsys"		  The system clock derived from ahb clock used to
 			  derive HCK, SCK and FS.
+	"spba"		  The spba clock is required when ESAI is placed as a
+			  bus slave of the Shared Peripheral Bus and when two
+			  or more bus masters (CPU, DMA or DSP) try to access
+			  it. This property is optional depending on the SoC
+			  design.
 
   - fsl,fifo-depth	: The number of elements in the transmit and receive
 			  FIFOs. This number is the maximum allowed value for
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 59f234e51971..6746f76a8c7f 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -35,6 +35,7 @@
  * @coreclk: clock source to access register
  * @extalclk: esai clock source to derive HCK, SCK and FS
  * @fsysclk: system clock source to derive HCK, SCK and FS
+ * @spbaclk: SPBA clock (optional, depending on SoC design)
  * @fifo_depth: depth of tx/rx FIFO
  * @slot_width: width of each DAI slot
  * @slots: number of slots
@@ -54,6 +55,7 @@ struct fsl_esai {
 	struct clk *coreclk;
 	struct clk *extalclk;
 	struct clk *fsysclk;
+	struct clk *spbaclk;
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
@@ -469,6 +471,11 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
 	ret = clk_prepare_enable(esai_priv->coreclk);
 	if (ret)
 		return ret;
+	if (!IS_ERR(esai_priv->spbaclk)) {
+		ret = clk_prepare_enable(esai_priv->spbaclk);
+		if (ret)
+			goto err_spbaclk;
+	}
 	if (!IS_ERR(esai_priv->extalclk)) {
 		ret = clk_prepare_enable(esai_priv->extalclk);
 		if (ret)
@@ -499,6 +506,9 @@ err_fsysclk:
 	if (!IS_ERR(esai_priv->extalclk))
 		clk_disable_unprepare(esai_priv->extalclk);
 err_extalck:
+	if (!IS_ERR(esai_priv->spbaclk))
+		clk_disable_unprepare(esai_priv->spbaclk);
+err_spbaclk:
 	clk_disable_unprepare(esai_priv->coreclk);
 
 	return ret;
@@ -564,6 +574,8 @@ static void fsl_esai_shutdown(struct snd_pcm_substream *substream,
 		clk_disable_unprepare(esai_priv->fsysclk);
 	if (!IS_ERR(esai_priv->extalclk))
 		clk_disable_unprepare(esai_priv->extalclk);
+	if (!IS_ERR(esai_priv->spbaclk))
+		clk_disable_unprepare(esai_priv->spbaclk);
 	clk_disable_unprepare(esai_priv->coreclk);
 }
 
@@ -819,6 +831,11 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "failed to get fsys clock: %ld\n",
 				PTR_ERR(esai_priv->fsysclk));
 
+	esai_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
+	if (IS_ERR(esai_priv->spbaclk))
+		dev_warn(&pdev->dev, "failed to get spba clock: %ld\n",
+				PTR_ERR(esai_priv->spbaclk));
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
-- 
2.6.2
