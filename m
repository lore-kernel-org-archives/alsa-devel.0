From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 4/6] ASoC: fsl_ssi: add AC'97 ops setting check and cleanup
Date: Thu, 30 Jul 2015 16:34:56 +0200
Message-ID: <55BA3610.8030404@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Check whether setting AC'97 ops succeeded and clean them
on removal so the fsl_ssi driver can be reloaded.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7f4f0b9..154bcf6 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1340,7 +1340,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 		fsl_ac97_data = ssi_private;
 
-		snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "could not set AC'97 ops\n");
+			return ret;
+		}
 	} else {
 		/* Initialize this copy of the CPU DAI driver structure */
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
@@ -1480,6 +1484,9 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
+	if (fsl_ssi_is_ac97(ssi_private))
+		snd_soc_set_ac97_ops(NULL);
+
 	return 0;
 }
 
