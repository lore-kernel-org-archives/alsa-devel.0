From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-spdif: add snd_soc_pm_ops for spdif
	machine driver" to the asoc tree
Date: Mon, 05 Oct 2015 17:44:50 +0100
Message-ID: <E1Zj8sc-0003Iy-B7@finisterre>
References: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A81D1261522
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 18:45:06 +0200 (CEST)
In-Reply-To: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-spdif: add snd_soc_pm_ops for spdif machine driver

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

>From 43ac946922b337507c4131c45bf339ddcd7e7402 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 18 Sep 2015 17:18:48 +0800
Subject: [PATCH] ASoC: imx-spdif: add snd_soc_pm_ops for spdif machine driver

Add snd_soc_pm_ops in machine driver to make the trigger suspend/resume
be called in suspend/resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-spdif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 33da26a..a407e83 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -89,6 +89,7 @@ MODULE_DEVICE_TABLE(of, imx_spdif_dt_ids);
 static struct platform_driver imx_spdif_driver = {
 	.driver = {
 		.name = "imx-spdif",
+		.pm = &snd_soc_pm_ops,
 		.of_match_table = imx_spdif_dt_ids,
 	},
 	.probe = imx_spdif_audio_probe,
-- 
2.5.0
