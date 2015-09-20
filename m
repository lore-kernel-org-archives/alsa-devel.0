From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Fix devm_kasprintf
	format string" to the asoc tree
Date: Sat, 19 Sep 2015 17:13:05 -0700
Message-ID: <E1ZdSFd-00043a-Vw@finisterre>
References: <1442577770-30650-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BFD0F26065F
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:39 +0200 (CEST)
In-Reply-To: <1442577770-30650-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Fix devm_kasprintf format string

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

>From ab1fffe3a73c694d698645451ba61255ec4ba5e6 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 18 Sep 2015 15:02:50 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Fix devm_kasprintf format string

The '\n' at the end of the format string is not needed. It adds an extra
line break when doing
cat /proc/interrupts

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 2c5a2c5..7d45d98 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1685,7 +1685,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "common");
 	if (irq >= 0) {
-		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common\n",
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common",
 					  dev_name(&pdev->dev));
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_common_irq_handler,
@@ -1702,7 +1702,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "rx");
 	if (irq >= 0) {
-		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx\n",
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx",
 					  dev_name(&pdev->dev));
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_rx_irq_handler,
@@ -1717,7 +1717,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "tx");
 	if (irq >= 0) {
-		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_tx\n",
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_tx",
 					  dev_name(&pdev->dev));
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_tx_irq_handler,
-- 
2.5.0
