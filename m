From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 1/2] ASoC: fsl_ssi: AC'97 ops need regmap,
 clock and cleaning up on failure
Date: Mon, 20 Nov 2017 23:14:55 +0100
Message-ID: <ecfcedaa-f0e9-ec1f-82c5-f0d319068a5d@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 984B0267065
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 23:15:01 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

AC'97 ops (register read / write) need SSI regmap and clock, so they have
to be set after them.

We also need to set these ops back to NULL if we fail the probe.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index dad80b4b0cfc..a71bb8391f61 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1460,12 +1460,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
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
@@ -1576,6 +1570,14 @@ static int fsl_ssi_probe(struct platform_device *pdev)
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
@@ -1659,6 +1661,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
 
 error_asoc_register:
+	if (fsl_ssi_is_ac97(ssi_private))
+		snd_soc_set_ac97_ops(NULL);
+
+error_ac97_ops:
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
