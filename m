From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-sgtl5000: lower log level for
	potential probe deferral cases" to the asoc tree
Date: Fri, 18 Jan 2019 18:38:36 +0000 (GMT)
Message-ID: <20190118183836.55BD911276E7@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B5A6266FA5
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 19:38:37 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Agner <stefan@agner.ch>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-sgtl5000: lower log level for potential probe deferral cases

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

>From 691beb02d9ff364000a8de4e74898600b9caee89 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Fri, 18 Jan 2019 10:06:53 +0100
Subject: [PATCH] ASoC: imx-sgtl5000: lower log level for potential probe
 deferral cases

Not finding the codec/SSI instance can be due to probe deferral.
Do not print error messages in those cases.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 594bde3b0ded..9790a2a8ec2d 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -104,13 +104,13 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 
 	ssi_pdev = of_find_device_by_node(ssi_np);
 	if (!ssi_pdev) {
-		dev_err(&pdev->dev, "failed to find SSI platform device\n");
+		dev_dbg(&pdev->dev, "failed to find SSI platform device\n");
 		ret = -EPROBE_DEFER;
 		goto fail;
 	}
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
-		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		dev_dbg(&pdev->dev, "failed to find codec platform device\n");
 		ret = -EPROBE_DEFER;
 		goto fail;
 	}
-- 
2.20.1
