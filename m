From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-spdif: don't print EPROBE_DEFER as
	error" to the asoc tree
Date: Fri, 18 Jan 2019 18:38:30 +0000 (GMT)
Message-ID: <20190118183830.E386B11276E7@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CCF49266BE8
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 19:38:31 +0100 (CET)
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

   ASoC: imx-spdif: don't print EPROBE_DEFER as error

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

>From 2363d85f4e04f7218efc66b6167a405cccbc8ff7 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Fri, 18 Jan 2019 10:06:56 +0100
Subject: [PATCH] ASoC: imx-spdif: don't print EPROBE_DEFER as error

Probe deferral is to be expected during normal operation, so avoid
printing an error when it is encountered.

Removing the goto would not be strictly necessary. However, if
code gets added later, the cleanup in the EPROBE_DEFER case likely
would get missed.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-spdif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index fb896b2c9ba3..797d66e43d49 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -67,10 +67,8 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 		goto end;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
-	if (ret) {
+	if (ret && ret != -EPROBE_DEFER)
 		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
-		goto end;
-	}
 
 end:
 	of_node_put(spdif_np);
-- 
2.20.1
