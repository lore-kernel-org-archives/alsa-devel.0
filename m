From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: AC'97 ops need regmap,
	clock and cleaning up on failure" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:47 +0000
Message-ID: <E1eJOWN-00073R-Gi@debutante>
References: <ecfcedaa-f0e9-ec1f-82c5-f0d319068a5d@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CA0EE267589
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:54 +0100 (CET)
In-Reply-To: <ecfcedaa-f0e9-ec1f-82c5-f0d319068a5d@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, stable@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: AC'97 ops need regmap, clock and cleaning up on failure

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

>From 695b78b548d8a26288f041e907ff17758df9e1d5 Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Mon, 20 Nov 2017 23:14:55 +0100
Subject: [PATCH] ASoC: fsl_ssi: AC'97 ops need regmap, clock and cleaning up
 on failure

AC'97 ops (register read / write) need SSI regmap and clock, so they have
to be set after them.

We also need to set these ops back to NULL if we fail the probe.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/fsl/fsl_ssi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f2f51e06e22c..c3a83ed0297e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1458,12 +1458,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 				sizeof(fsl_ssi_ac97_dai));
 
 		fsl_ac97_data = ssi_private;
-
-		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
-		if (ret) {
-			dev_err(&pdev->dev, "could not set AC'97 ops\n");
-			return ret;
-		}
 	} else {
 		/* Initialize this copy of the CPU DAI driver structure */
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
@@ -1574,6 +1568,14 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (fsl_ssi_is_ac97(ssi_private)) {
+		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "could not set AC'97 ops\n");
+			goto error_ac97_ops;
+		}
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
 					      &ssi_private->cpu_dai_drv, 1);
 	if (ret) {
@@ -1657,6 +1659,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
 
 error_asoc_register:
+	if (fsl_ssi_is_ac97(ssi_private))
+		snd_soc_set_ac97_ops(NULL);
+
+error_ac97_ops:
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
-- 
2.15.0
