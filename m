From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Remove expensive print in irq
	handler" to the asoc tree
Date: Fri, 18 Jan 2019 18:38:27 +0000 (GMT)
Message-ID: <20190118183827.3D8ED11276E7@debutante.sirena.org.uk>
References: <20190118142623.17720-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B3EAB266AA9
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 19:38:28 +0100 (CET)
In-Reply-To: <20190118142623.17720-1-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Remove expensive print in irq handler

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e412fcb0db5c44a3450ca678b281ea9332e6bf82 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 18 Jan 2019 14:26:46 +0000
Subject: [PATCH] ASoC: fsl_sai: Remove expensive print in irq handler

When stopping audio, ASoC will first stop DMA then CPU DAI.
Sometimes there is a delay between DMA stop and CPU DAI stop, which
triggers an underrun error. Now, because of the delay introduced
by dev_err another underrun error will occur causing a vicious circle
making impossible to stop CPU DAI.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4163f2cfc06f..db9e0872f73d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -62,10 +62,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 		dev_dbg(dev, "isr: Start of Tx word detected\n");
 
 	if (flags & FSL_SAI_CSR_SEF)
-		dev_warn(dev, "isr: Tx Frame sync error detected\n");
+		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
 
 	if (flags & FSL_SAI_CSR_FEF) {
-		dev_warn(dev, "isr: Transmit underrun detected\n");
+		dev_dbg(dev, "isr: Transmit underrun detected\n");
 		/* FIFO reset for safety */
 		xcsr |= FSL_SAI_CSR_FR;
 	}
@@ -96,10 +96,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 		dev_dbg(dev, "isr: Start of Rx word detected\n");
 
 	if (flags & FSL_SAI_CSR_SEF)
-		dev_warn(dev, "isr: Rx Frame sync error detected\n");
+		dev_dbg(dev, "isr: Rx Frame sync error detected\n");
 
 	if (flags & FSL_SAI_CSR_FEF) {
-		dev_warn(dev, "isr: Receive overflow detected\n");
+		dev_dbg(dev, "isr: Receive overflow detected\n");
 		/* FIFO reset for safety */
 		xcsr |= FSL_SAI_CSR_FR;
 	}
-- 
2.20.1
